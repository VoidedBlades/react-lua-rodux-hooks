## 0.4.0

- Changed roact to use react-lua. This specific package does not work with roact/roact17 anymore and only functions with react-lua

## 0.3.1

- Fix selectors not properly updating selector function enclosures

## 0.3.0

- Fix `useSelector` and `useCustomSelector` not properly updating when the selector returns a non-table value

## 0.2.2

- Expose `shallowEqual`

## 0.2.1

- Make `equalityFn` param of `useSelector` and `useCustomSelector` optional

## 0.2.0

- Fix useSelector not caching mappedState
- Add useCustomSelector
- Add useCustomDispatch

## 0.1.0

- Initial release
