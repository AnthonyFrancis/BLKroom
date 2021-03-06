document.addEventListener('turbolinks:load', () => {
  const element = document.getElementById('nav-tab');
  const text = document.querySelector('.text');
  const imageVideo = document.querySelector('.image_video');
  const url = document.querySelector('.url');

  // user profile
  const post_newest = document.getElementById('post_newest');
  const post_popular = document.getElementById('post_popular'); 

  if (imageVideo != null || url != null) {
    imageVideo.classList.add('hidden');
    url.classList.add('hidden');
  }

  // post_tab_helper
  if (post_newest != null) {
    post_newest.classList.add('hidden');
  }

  function onTabClick(event) {
    const activeTabs = document.querySelectorAll('.active');

    activeTabs.forEach(function(tab) {
      tab.classList.toggle('active');
    });
    // activate new tab and panel
    event.target.parentElement.classList.add('active');
    event.preventDefault();
  }

  function determineType(event) {

    const types = {
      text: "text",
      image_video: "image_video",
      url: "url",
      post_newest: "post_newest",
      post_popular: "post_popular"
    };

    // Text
    if (event.target.parentElement.dataset.tab == types.text) {
      text.classList.remove('hidden');
      imageVideo.classList.add('hidden');
      url.classList.add('hidden');

      url.querySelector("input[type=text]").value = "";
    }

    // Image / Video
    if (event.target.parentElement.dataset.tab == types.image_video) {
      imageVideo.classList.remove('hidden');
      text.classList.add('hidden');
      url.classList.add('hidden');

      text.querySelector("textarea").value = "";
      url.querySelector("input[type=text]").value = "";
    }

    // URL
    if (event.target.parentElement.dataset.tab == types.url) {
      url.classList.remove('hidden');
      text.classList.add('hidden');
      imageVideo.classList.add('hidden');

      text.querySelector("textarea").value = "";
    }

    // Post New
    if (event.target.parentElement.dataset.tab == types.post_newest) {
      post_newest.classList.remove('hidden');
      post_popular.classList.add('hidden');
    }

    // Post Popular
    if (event.target.parentElement.dataset.tab == types.post_popular) {
      post_popular.classList.remove('hidden');
      post_newest.classList.add('hidden');
    }
  }

    if (element != null) {
    element.addEventListener('click', function(event) {
      onTabClick(event);
      determineType(event);
    });
  }
});