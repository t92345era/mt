
/**
 * 文書構成コンポーネント
 */
class WordKousei extends React.Component {

  /** コンストラクタ */
  constructor(props) {
    super(props);
    this.state = {
      name: 'James'
    }
  }

  /** レンダリング */
  render () {
    return (
<div>
  <div>
    <textarea rows="20" style={ { width: "50em" } }></textarea>
  </div>
  <div>
    <button>送信</button>
  </div>
  <div>
    <p>処理結果</p>
    <div>
      
    </div>
  </div>
</div>
    );
  }
}


