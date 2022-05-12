<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<br />
<div align="center">
  <!-- Logo? -->
  <!-- <a href="https://github.com/v0hm/anonimaizer">
    <img src="Artwork/logo.png" alt="Logo" width="80" height="80">
  </a> -->

<h3 align="center">Anonymizer</h3>
  <p align="center">
    Anonymizes everyone on a photo without making it look edited by swapping the faces for generated ones
    <br />
    <br />
    <a href="https://example.com">View Demo</a>
    ·
    <a href="https://github.com/v0hm/anonimaizer/issues">Report Bug</a>
    ·
    <a href="https://github.com/v0hm/anonimaizer/issues">Request Feature</a>
  </p>
</div>


<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>


## About The Project
[![Product Name Screen Shot][product-screenshot]](https://github.com/v0hm/anonimaizer)

<p align="right">(<a href="#top">back to top</a>)</p>


### Built With
* Backend
  * [Python](https://www.python.org/) & [Flask](https://flask.palletsprojects.com/en/2.1.x/) - API Server
  * [MTCNN](https://pypi.org/project/mtcnn/) - Face detection based on multitask cascaded convolutional networks
* Frontend
  * [Dart](https://dart.dev/) & [Flutter](https://flutter.dev/) - User interface

<p align="right">(<a href="#top">back to top</a>)</p>


## Getting Started
### Prerequisites
* [Docker](https://www.docker.com/) - v20.0+ 

### Installation
1. Clone the repository
2. Build the image from Dockerfile (`docker build -t <tag> .`)
3. Run the container & forward port 8080 => 80 (`docker run --name <name> -p 80:8080/tcp -p 80:8080/udp -d <tag>`)

<p align="right">(<a href="#top">back to top</a>)</p>


## Usage
The app is served on port 80 and can either be accessed for a browser or installed as a PWA.

<p align="right">(<a href="#top">back to top</a>)</p>


## Roadmap
- [ ] Backend
  - [x] Basic API server
  - [x] Face recognition on images
  - [ ] Custom face generation
  - [ ] Face replacement
  - [ ] Delete cached files (cron job?)
- [ ] Frontend
  - [x] Basic frontend
  - [x] Integration with the API
  - [ ] Visual improvements

See the [open issues](https://github.com/v0hm/anonimaizer/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>


## License
Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>


## Acknowledgments
* [K. Zhang, Z. Zhang, Z. Li and Y. Qiao, "Joint Face Detection and Alignment Using Multitask Cascaded Convolutional Networks"](https://ieeexplore.ieee.org/abstract/document/7553523) - Face detection algorithm

<p align="right">(<a href="#top">back to top</a>)</p>


[contributors-shield]: https://img.shields.io/github/contributors/v0hm/anonimaizer.svg?style=for-the-badge
[contributors-url]: https://github.com/v0hm/anonimaizer/graphs/contributors
[stars-shield]: https://img.shields.io/github/stars/v0hm/anonimaizer.svg?style=for-the-badge
[stars-url]: https://github.com/v0hm/anonimaizer/stargazers
[issues-shield]: https://img.shields.io/github/issues/v0hm/anonimaizer.svg?style=for-the-badge
[issues-url]: hhttps://github.com/v0hm/anonimaizer/issues
[license-shield]: https://img.shields.io/github/license/v0hm/anonimaizer.svg?style=for-the-badge
[license-url]: https://github.com/v0hm/anonimaizer/blob/master/LICENSE
[product-screenshot]: Artwork/Frontend-Screenshot.png

*Shamelessly stolen from: https://github.com/othneildrew/Best-README-Template*
