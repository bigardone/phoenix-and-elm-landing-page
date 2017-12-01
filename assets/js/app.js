import Elm from './elm/main';

const elmContainer = document.querySelector('#elm_container');

if (elmContainer) {
  const app = Elm.Main.embed(elmContainer);
}
