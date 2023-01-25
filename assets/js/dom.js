import { objEach, objMap } from './util';

export const puts = (s) => console.log(s);
export const getElementsByClassName = (className) => Array.from(document.getElementsByClassName(className));
export const getElementById = (id) => document.getElementById(id);
export const getElementByQuerySelector = (selector) => document.querySelector(selector);
export const getElementsByQuerySelectorAll = (selector) => Array.from(document.querySelectorAll(selector));

const displayShow = (elm) => (elm.style.display = 'block');
const displayNone = (elm) => (elm.style.display = 'none');
export const show = (elm) => {
  if (Array.isArray(elm)) {
    elm.map((e) => displayShow(e));
  } else {
    displayShow(elm);
  }
};
export const hide = (elm) => {
  if (Array.isArray(elm)) {
    elm.map((e) => displayNone(e));
  } else {
    displayNone(elm);
  }
};
export const createElement = (name, attrs = {}) => {
  const elm = document.createElement(name);
  objEach(attrs, (key, value) => {
    switch (key) {
      case 'text':
        elm.textContent = attrs['text'];
        break;
      default:
        attr(elm, key, value);
        break;
    }
  });
  return elm;
};

const click = (elm, func) => {
  elm.addEventListener('click', (e) => {
    func(elm, e);
  });
};

export const onClick = (elm, func) => {
  if (Array.isArray(elm)) {
    elm.map((e) => click(e, func));
  } else {
    click(elm, func);
  }
};

export const insertBefore = (receiver, elm) => {
  receiver.insertAdjacentElement('beforebegin', elm);
};

export const fadeOut = (elm, msec, callback) => {
  if (Array.isArray(elm)) {
    elm.map((e) => fadeOutBehavior(e, msec, callback));
  } else {
    fadeOutBehavior(elm, msec, callback);
  }
};

const fadeOutBehavior = (elm, msec, callback) => {
  const fadeEffect = setInterval(() => {
    if (!elm.style.opacity) {
      elm.style.opacity = 1;
    }
    if (elm.style.opacity > 0) {
      elm.style.opacity -= 0.1;
    } else {
      elm.style.display = 'none';
      clearInterval(fadeEffect);
      if (callback !== undefined) {
        callback();
      }
    }
  }, msec);
};

export const fadeIn = (elm, msec, callback) => {
  if (Array.isArray(elm)) {
    elm.map((e) => fadeInBehavior(e, msec, callback));
  } else {
    fadeInBehavior(elm, msec, callback);
  }
};

const fadeInBehavior = (elm, msec, callback) => {
  let opacity = 0;
  const fadeEffect = setInterval(() => {
    elm.style.display = 'block';
    if (!elm.style.opacity) {
      elm.style.opacity = opacity;
    }

    if (elm.style.opacity < 1) {
      opacity += 0.1;
      elm.style.opacity = opacity;
    } else {
      clearInterval(fadeEffect);
      if (callback !== undefined) {
        callback();
      }
    }
  }, msec);
};

export const fadeToggle = (elm, msec) => {
  if (Array.isArray(elm)) {
    elm.map((e) => fadeToggleBehavior(e, msec));
  } else {
    fadeToggleBehavior(elm, msec);
  }
};

const fadeToggleBehavior = (elm, msec) => {
  if (elm.style.display === 'none') {
    fadeInBehavior(elm, 50);
  } else {
    fadeOutBehavior(elm, msec);
  }
};

// eslint-disable-next-line no-unused-vars
export const slideToggle = (elm, duration = 400) => {
  if (window.getComputedStyle(elm).display === 'none') {
    return slideDown(elm, duration);
  }
  return slideUp(elm, duration);
};

/* eslint no-param-reassign: ["error", { "props": false }] */
const slideUp = (elm, duration = 400) => {
  elm.style.height = `${elm.offsetHeight}px`;
  // eslint-disable-next-line no-unused-expressions
  elm.offsetHeight;
  elm.style.transitionProperty = 'height, margin, padding';
  elm.style.transitionDuration = `${duration}ms`;
  elm.style.transitionTimingFunction = 'ease';
  elm.style.overflow = 'hidden';
  elm.style.height = 0;
  elm.style.paddingTop = 0;
  elm.style.paddingBottom = 0;
  elm.style.marginTop = 0;
  elm.style.marginBottom = 0;
  setTimeout(() => {
    elm.style.display = 'none';
    elm.style.removeProperty('height');
    elm.style.removeProperty('padding-top');
    elm.style.removeProperty('padding-bottom');
    elm.style.removeProperty('margin-top');
    elm.style.removeProperty('margin-bottom');
    elm.style.removeProperty('overflow');
    elm.style.removeProperty('transition-duration');
    elm.style.removeProperty('transition-property');
    elm.style.removeProperty('transition-timing-function');
  }, duration);
};

// slideDown
const slideDown = (elm, duration = 300) => {
  elm.style.removeProperty('display');
  let { display } = window.getComputedStyle(elm);
  if (display === 'none') {
    display = 'block';
  }
  elm.style.display = display;
  const height = elm.offsetHeight;
  elm.style.overflow = 'hidden';
  elm.style.height = 0;
  elm.style.paddingTop = 0;
  elm.style.paddingBottom = 0;
  elm.style.marginTop = 0;
  elm.style.marginBottom = 0;
  // eslint-disable-next-line no-unused-expressions
  elm.offsetHeight;
  elm.style.transitionProperty = 'height, margin, padding';
  elm.style.transitionDuration = `${duration}ms`;
  elm.style.transitionTimingFunction = 'ease';
  elm.style.height = `${height}px`;
  elm.style.removeProperty('padding-top');
  elm.style.removeProperty('padding-bottom');
  elm.style.removeProperty('margin-top');
  elm.style.removeProperty('margin-bottom');
  setTimeout(() => {
    elm.style.removeProperty('height');
    elm.style.removeProperty('overflow');
    elm.style.removeProperty('transition-duration');
    elm.style.removeProperty('transition-property');
    elm.style.removeProperty('transition-timing-function');
  }, duration);
};

export const attr = (elm, name, value) => {
  elm.setAttribute(name, value);
};
