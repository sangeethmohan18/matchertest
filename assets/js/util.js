export const objEach = (obj, func) => {
  Object.keys(obj).forEach((key) => func(key, obj[key]));
};
export const objMap = (obj, func) => {
  const res = [];
  Object.keys(obj).forEach((key) => {
    res.push(func(key, obj[key]));
  });
  return res;
};

// js で動的作成した input 要素に対してユニークな属性を付与するために UUID を生成する
export const createUuid = () => {
  let S4 = () => {
    return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
  };
  return S4() + S4() + '-' + S4() + '-' + S4() + '-' + S4() + '-' + S4() + S4() + S4();
};
