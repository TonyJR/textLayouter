

Vue.component('TOPage', {
              render: function (createElement) {
              return createElement(
                                   'h' + this.level,   // 标签名称
                                   this.$slots.default // 子节点数组
                                   )
              },
              props: {
                pageWidth: {
                    type: Number,
                    required: true
                },
                pageHeight: {
                    type: Number,
                    required: true
                }
              },
              
              data:function(){
                return{blockList :[{type:1,text:'1234'}]};
              }
              })

Vue.component('Block', {
              props: ['type','text'],
              
              })

