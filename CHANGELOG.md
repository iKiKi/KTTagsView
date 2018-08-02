# Change Log
All notable changes to this project will be documented in this file.
`KTTagsView ` adheres to [Semantic Versioning](http://semver.org/).

#### 1.x Releases
- `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101)

---

## [2.0.0](https://github.com/iKiKi/KTTagsView/releases/tag/2.0.0)
Released on 2018-08-XX.

#### Updated
- In `TagsViewDataSource`, `tagsView(tagsView:,sizeForTagAt:)` have been renamed to `tagsView(tagsView:,preferredSizeForTagAt:)`. TagsView may now override the returned size to make sure its width doesn't exceed the current TagsView's width. The previous behaviour was to make a `fatalError` in this case while it's wasn't documented.

## [1.0.1](https://github.com/iKiKi/KTTagsView/releases/tag/1.0.1)
Released on 2018-04-22.

#### Added
- `CHANGELOG.md`.
  - Added by [KiKi](https://github.com/iKiKi).

#### Updated
- Pod summary description.
  - Updated by [KiKi](https://github.com/iKiKi).

#### Fixed
- `tvOS` **Carthage** framework deployment target. 
  - Fixed by [KiKi](https://github.com/iKiKi).

## [1.0.0](https://github.com/iKiKi/KTTagsView/releases/tag/1.0.0)
Released on 2018-03-20.

#### Added
- Initial release of `KTTagsView`.
  - Added by [KiKi](https://github.com/iKiKi).
