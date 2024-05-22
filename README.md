* このパッケージはpub.dev非公開のパッケージである。

# このパッケージの目的
* 任意のObjectに対して、Object.onDispose((){})といった形で処理を書くことが出来る。
* 利用することで、InitState等に処理をまとめて書くことができる。
* 通常はInitStateとdisposeに分けて書くが、InitStateの中にdispose関連の処理もまとめて
* 書いてしまうことで初期化と廃棄を同じ箇所に書くことができる。

```
class _MyState extends State<_Child> with CallbacksOnStateMethod {
    late final ScrollController _scrollController =
        ScrollController().onDispose(this, () {
        _scrollController.dispose();
    });
   //...
}
```