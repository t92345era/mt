
/**
 * 文書構成コンポーネント
 */
class WordKousei extends React.Component {

  /** コンストラクタ */
  constructor(props) {
    super(props);
    this.state = {
      source_text: "",
      summary: null
    }
  }

  /** textarea 変更時の処理 */
  handleChange(input_text) {
    this.setState({
      source_text: input_text
    });
  }

  /** 送信ボタンクリック時の処理 */
  handleSend() {
    this.sendKoseiData().then(data => {
      this.setState({
        summary: data
      });
    }, err => {
      alert(err);
    });
  }

  /** 校正データの送信 */
  sendKoseiData() {
    return $.ajax({
      url: '/work-kousei/ap/kousei',
      type: 'POST',
      data: {
        source_text: this.state.source_text,
        authenticity_token: $("[name='authenticity_token']").val()
      }
    });
  }

  /** レンダリング */
  render () {
    return (
<div>
  <div>
    <textarea ref="source_text"
      rows="5" 
      style={ { width: "50em" } } 
      onChange={ e => (this.handleChange($(e.target).val())) }></textarea>
  </div>
  <div>
    <button onClick={ e => this.handleSend() }>送信</button>
  </div>
  <div>
    <p>処理結果</p>
    <div>
      {this.state.summary != null && this.state.summary.map((item, i)=> {
      return (
        <div key={i}>
          ["{item[0]}","{item[1]}"]
        </div>
      );
      })}
    </div>
  </div>
</div>
    );
  }
}


