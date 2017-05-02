---
title: "Connecting View Controllers"
date: 2017-05-02 00:00
---
<br>

**Inspiration**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The inspiration behind this blog post comes from an [objc.io](https://www.objc.io/) Swift Talk, with the same title as this one. In their talk, Chris Eidhof and Florian Kugler start with a small app and move the view controller connections, which start as segues in storyboard, to a centralized `App` class.

The end result looks like this:
<br><br>

```swift
final class App {
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  let navigationController: UINavigationController
  
  init(window: UIWindow) {
    navigationController = window.rootViewController as! UINavigationController
    let episodesVC = navigationController.viewControllers[0] as! EpisodesViewController
    episodesVC.didSelect = showEpisode
    episodesVC.didTapProfile = showProfile
  }
  
  func showEpisode(_ episode: Episode) {
    let detailVC = storyboard.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
    detailVC.episode = episode
    navigationController.pushViewController(detailVC, animated: true)
  }
  
  func showProfile() {
    let profileNC = self.storyboard.instantiateViewController(withIdentifier: "Profile") as! UINavigationController
    let profileVC = profileNC.viewControllers[0] as! ProfileViewController
    profileVC.didTapClose = {
      self.navigationController.dismiss(animated: true, completion: nil)
    }
    navigationController.present(profileNC, animated: true, completion: nil)
  }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The `didSelect`, `didTapProfile`, and `didTapClose` methods are attributes on the actual view controllers, which are called based on certain events.  For example, in the Episodes Table View:
<br><br>

```swift
class EpisodesViewController: UITableViewController {

    ...

    var didSelect: (Episode) -> () = { _ in }

    ...

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        didSelect(episode)
    }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When the `EpisodesViewController` is instantiated, it's `didSelect` attribute is set to `App`'s `showProfile` method, which takes an `episode` and pushes a `DetailViewController`.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chris and Florian's refactor is beneficial, because it centralizes transition logic in one place, rather than bloating the view controllers with boilerplate.

**<center>* * * * *</center>**

**Another Path**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;While watching this Swift Talk, I had an idea for a different path Swift programmers could take to simplify and consolidate transition logic, which involves an enum and a protocol extension. I took the same code from Chris and Florian, removed the `App` class and a few other lines, and implemented my idea.  

The end result looks like this:
<br><br>

```swift
enum Controller {
  
  case Detail(episode: Episode)
  case Episode
  case Profile
  
  var sb: UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
  
  var instance: UIViewController {
    switch self {
    case .Detail(let episode):
      let vc = sb.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
      vc.episode = episode
      return vc
    case .Episode():
      return sb.instantiateViewController(withIdentifier: "Episode") as! EpisodesViewController
    case .Profile():
      return sb.instantiateViewController(withIdentifier: "Profile") as! UINavigationController
    }
  }
}

protocol Transitionable: class {
  
  var navigationController: UINavigationController? { get }
  
  func present(vc: Controller)
  func push(vc: Controller)
}

extension Transitionable {
  
  func present(vc: Controller) {
    let vc = vc.instance
    navigationController?.present(vc, animated: true, completion: nil)
  }
  
  func push(vc: Controller) {
    let vc = vc.instance
    navigationController?.pushViewController(vc, animated: true)
  }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The general idea is to use the `Controller` enum as a data struct to represent all the possible view controllers, and to present or push these a view controller using the `Transitionable` protocol.  This makes it possible to present or push a view controller with a single line of code, for example, in the Episodes Table View, the code now reads:
<br><br>

```swift
class EpisodesViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        push(vc: Controller.Detail(episode: episode))
    }
}
```
<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Compared to the `objc.io` implementation, this line is more verbose, but it is also a little clearer what is happening (i.e. a detail view controller is being pushed onto the stack).

**<center>* * * * *</center>**

**Conclusion**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In the context of this simple application, both approaches work, and are an improvement upon using segues in storyboard or writing the code in the view controllers. The next question is which approach is preferable in the context of a larger application?

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chris and Florian's approach seems to be more malleable, because their transitions are being uniquely set from the `App` class.  So, in the future they can easily create methods in this class to instantiate view controllers with different parameters. My approach might benefit from being a little more declarative at the points where transitions are called. Also, representing view controllers in an enum enables autocomplete and lets the programmer know which variables a view controller expects to be given. For example, we wouldn't want to push a `DetailViewController` without an `episode`.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Feel free to look at the [source code](https://github.com/OLI9292/Connecting-view-controllers) and email me any thoughts.