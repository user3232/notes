
# vs code editing tips

## Creating files from command line

http://justinmunn.co/blog/vscode-terminal/

```console
$ mkdir src/components
$ touch src/components/Child1.js && code -r src/components/Child1.js
```


# Separate default projects ASP Core and React

```console
$ # create folder for projects
$ mkdir QandA
$ cd QandA/
$ # create subfolder for backend
$ mkdir backend
$ cd backend/
$ # create C# ASP .net core web API project template
$ dotnet new webapi -n QandA
$ # return to main folder
$ cd ..
$ # create TypeScript React template project
$ # in frontend subfolder
$ # using create-react-app node module
$ # npx belongs to npm suite and automatically uses
$ # and installs dependencies locally
$ npx create-react-app frontend --template typescript
$ # now lets nawigate to frontend subfolder
$ cd frontend/
$ # and check if frontend works
$ npm start
Compiled successfully!

You can now view frontend in the browser.

  Local:            http://localhost:3000
  On Your Network:  http://192.168.0.192:3000

Note that the development build is not optimized.
To create a production build, use npm run build.

^C
$ # ctrl+c kills running
$ # (live reload local folder contents) server
$
```

# React is served in developement by Live Reload Server

Live reloading:

- https://www.npmjs.com/package/live-server#how-it-works
- https://github.com/livereload/livereload-js
- https://stackoverflow.com/questions/45622125/how-can-i-add-live-reload-to-my-nodejs-server
- https://www.browsersync.io/

# Expres server, tutorials on MDN

- https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs/development_environment
- https://developer.mozilla.org/en-US/docs/Learn/Server-side/Express_Nodejs


# Debug react project

...?


# CSS Styling of React components

React components uses `className` instead of `class` to associate CSS
styling with component!!!

## Problems with classical styling

CSS is global in nature. So, if we use a CSS class name called
container within a Header component, it would collide with another CSS
class called container in a different CSS file if a page references
both CSS files.

As the app grows and new team members join the development team, the
risk of CSS changes impacting areas of the app we don't expect
increases. We reduce this risk by being careful when naming and
structuring our CSS by using something such as 
[BEM (Block, Element and Modifier. strict naming rules)](http://getbem.com/introduction/).

Reusability in CSS is also a challenge. CSS custom properties give us
the ability to use variables, but they are global variables and are
not supported in IE. CSS preprocessors such as **SCSS** can, of
course, help us with this.

Ideally, we want to easily scope styles to a component. It would also
be nice if local styles were defined in the component code, so that we
can see and understand the structure, logic, and styling for a
component without having to navigate through different files. This is
exactly what CSS in JS libraries do, and **Emotion** is a popular CSS in
the JS library. The syntax for defining the styling properties is
exactly the same as defining properties in CSS, which is nice if we
already know CSS well. We can even nest CSS properties in a similar
manner to how we can do this in SCSS.

## Emotion

```console
$ npm install @emotion/core @emotion/styled --save-dev
```

```tsx
// comment below is pragma for babel
// to transpile using jsx function
/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import { fontFamily, fontSize, gray2 } from './Styles';
import React from 'react';

const App: React.FC = () => (
  <div
    css={css`
      font-family: ${fontFamily};
      font-size: ${fontSize};
      color: ${gray2};
    `}
  >
  </div>
);

export default App;
```

This produce:

```html
<head>
  <!-- other things -->
  <style data-emotion="css">
    .css-12pa6je-App {
      font-family:'Segoe UI','Helvetica Neue',sans-serif;
      font-size:16px;
      color:#5c5a5a;
    }
  </style>
</head>
<body>
  <div class="css-12pa6je-App"></div>
  <!-- other things (scripts) -->
</body>
```

The styles aren't inline styles on the elements as we might have
thought. Instead, the styles are held in unique CSS classes.

# Container and presentation components

Container components are responsible for how things work, fetching any
data from a web API, and managing state.


Presentational components are responsible for how things look.
Presentational components receive data via their props and also have
property event handlers so that their containers can manage user
interactions.

# Events of React components

Event listeners in JSX can be attached using a function prop that is
named with on before the native JavaScript event name in camel case.
So, a native click event can be attached using an onClick function
prop. React will automatically remove the event listener for us before
the element is destroyed.

## List of supported events

To find a list of all the available events, along with their
corresponding types, take a look in the `index.d.ts` file, which can
be found in the `node_modules/@types/react` folder.




# React Router

```console
$ npm install react-router-dom
$ npm install @types/react-router-dom --save-dev
```

Typically clicking `<a href='./home'>home</a>` causes:
- a requests for resource send to server. 
- Server than respond with data 
- which browser than renders.

Other model for clicking is to change page using JS and dom.

In react to change which components are displayed, display
settings must be put to state, than changing this state
can change witch components are displayed.

For common scenarios there is React library `React-Router`
implementing this as components.

React-Router needs to wrap custom components in:
- `<BrowserRouter></BrowserRouter>`
- `<Switch></Switch>`
- `<route/>`
- `<Redirect/>`
- `<Link></Link>`


## Routes

By default, **BrowserRouter does the partial matching** to the browser
location path and will match and render all the Route components it
can find.


```tsx
const App: React.FC = () => (
  // default component is DOM router
  // it will add display state associated to child components
  // and display them accordingly to specified rules
  // (in React-Router subcomponents e.g. <switch>, <link>, <route>, ...)
  <BrowserRouter>
    <div>
      <Header />
      {/* all matching routes will be displayed!!! */}
      {/* 
        We can tell the Route component that renders 
        the HomePage component to do an exact match on
        the location in the browser:

        ( Unlike other attributes, you don't need to specify 
        the value of a Boolean attribute (e.g. exact) on an 
        HTML element. Its presence on an element automatically 
        means the value is true and its absence means the 
        value is false. )
      */}
      <Route exact path="/" component={HomePage} />
      <Route path="/search" component={SearchPage} />
      <Route path="/ask" component={AskPage} />
      <Route path="/signin" component={SignInPage} />
    </div>
  </BrowserRouter>
);
export default App;
```

## Switch, Route and Redirect

The Switch component renders just the first Route or Redirect
component that matches the browser location path and doesn't render
any other matching routes.

The Redirect component needs to be nested inside a Switch component,
along with the Route components, in order for it to function
correctly.

```tsx
<BrowserRouter>
  {/* all matching routes will be displayed!!! */}
  <Switch>
    <Redirect from="/home" to="/" />
    <Route exact path="/" component={HomePage} />
    <Route path="/search" component={SearchPage} />
    <Route path="/ask" component={AskPage} />
    <Route path="/signin" component={SignInPage} />
  </Switch>
</BrowserRouter>

```

## Links and history


```tsx
import { Link } from 'react-router-dom';
// ....

<Link
  to="/"
  css={ ... }
>
  Q & A
</Link>
```

History:

```tsx
import { RouteComponentProps } from 'react-router-dom';
```

The history object in React Router keeps track of the locations that
have been visited in the app and contains quite a few different
properties and methods. The push method pushes a new entry into the
history stack and performs navigation to the location that's passed in
as a parameter.

```tsx
export const myComp: FC<RouteComponentProps> = ({history}) => {
  history.push('/ask');
};
```

## Route parameters

If for example route is: `/questions`, than
route with params (relative to previous) could be: `/questions/1`.

Route param can be generated as fallows:

```tsx
<Link
  css={css`
  text-decoration: none;
  color: ${gray2};
  `}
  to={`questions/${data.questionId}`}
>
  {data.title}
</Link>
```

And can be accessed:

```tsx
interface RouteParams {
  questionId: string;
}
export const QuestionPage: FC<RouteComponentProps<RouteParams>> = ({
  match,
}) => {
  // route param can be accessed as fallows:
  return <Page>Question Page {match.params.questionId}</Page>;
};
```

## Query parameters

A query parameter is part of the URL that allows additional parameters
to be passed into a path. For example, `/search?criteria=typescript`
has a query parameter called `criteria` with a value of `typescript` .

```tsx
export const SearchPage: FC<RouteComponentProps> = ({ location }) => {
  const [questions, setQuestions] = useState<QuestionData[]>([]);
  const searchParams = new URLSearchParams(location.search);
  const search = searchParams.get('criteria') || '';
  return <Page title="Search Results" />;
};
```
- React Router gives us access to all the query parameters in a search
  string inside the `location.search` object. 
  - The search string from React Router for the
    `/search?criteria=type` path is `?criteria=type` . 
- We need to parse this string in order to get the criteria value. 
- We use the native URLSearchParams JavaScript function to do this.

## Lazy loading routes

Normally, all the JavaScript for our app is loaded when the app first
loads.

There may be large pages that are rarely used in the app that we want
to load the JavaScript for on demand. This process is called lazy
loading.

```tsx
const AskPage = lazy(() => import('./AskPage'));
```


The `lazy` function in React lets us render a dynamic import as a regular component. A
dynamic import returns a promise for the requested module that is resolved after it
has been fetched, instantiated, and evaluated.

# React elements

## Rendering multiple components

In React, a component can only return a single element. This rule
applies to conditional rendering logic where there can be only a
single parent React element being rendered. React Fragment allows us
to work around this rule because we can nest multiple elements within
it without creating a DOM node.

For example to render `<p>...</p>` and `<span>...</span>`,
one may use `<Fragment>...</Fragment>` container:

```tsx
import React from 'react';
const paragraphAndSpan: React:FC = () => (
  <Fragment>
    <p>
      some text
    </p>
    <span>other text</span>
  </Fragment>
);
/*
// This would cause error (FC is one component possibly having children):
const paragraphAndSpan: React:FC = () => <p>some text</p><span>other text</span>;
*/
```


# Forms

One may create simple yet generic components,
and than combain them to do a lot of work.

There are also libraries with form components,
for example [Formik](https://github.com/jaredpalmer/formik).

# Redux and Redux Thunk

(This is shit, but many projects use this...)

```console
$ npm install redux
$ npm install react-redux
$ npm install @types/react-redux --save-dev
$ npm install redux-thunk
```

# gRPC support

```console
$ # communication driver for web browser:
$ npm install @aspnet/signalr

```

