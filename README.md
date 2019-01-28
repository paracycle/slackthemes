<p align="center">
<a href="https://http://slackthemes.net" target="_blank"><img src="https://raw.githubusercontent.com/paracycle/slackthemes/master/source/favicon-32.png"></a>
<br /><strong>Slack Themes</strong>
</p>
<p align="center">
<a href="https://travis-ci.org/paracycle/slackthemes" target="_blank"><img src="https://travis-ci.org/paracycle/slackthemes.svg?branch=master"></a>
</p>


### About the project

slackthemes.net is a platform for browsing and sharing themes for [Slack](https://slack.com/).
It is not affiliated with [Slack](https://slack.com/) in any way or form; but it is a great tool, use it.


### How to contribute (themes)

1. Fork this project.
2. Add your theme to the `data/themes.yml` file.
3. Create a pull request.

Themes consist of eight RGB hex colors as follows:
1. Primary background color for the sidebar (variants are used for other elements)
2. Header and footer to the sidebar
3. Highlight color for current channel
4. Text color for current channel
5. Highlight color for channel selection
6. Text color for non-current channels and other sidebar text
7. User DM / online indicator
8. Unread direct message indicator

### How to contribute (core)

1. Fork this project.
2. Install dependencies using `bundle install`
3. Make changes.
4. Build the project using `bundle exec middleman build`
5. You can [run a local webserver](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/set_up_a_local_testing_server) to test the project. (make sure to use the `./build` folder as your DocumentRoot).
6. Create a pull request.

### Contributors

* [Contributors](https://github.com/paracycle/slackthemes/graphs/contributors)
