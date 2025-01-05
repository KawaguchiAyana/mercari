class CourtesController < ApplicationController
  def create
    
      item = Item.find(params[:item_id])
  
      if current_user.carts.exists?(item_id: item.id)
        redirect_to items_path, alert: "この商品は既にカートに追加されています。"
      else
        # カートに追加
        current_user.carts.create(item: item)
        redirect_to mypage_path, notice: "商品をカートに追加しました！"
      end
  end
    

  def destroy
    # ユーザーのカートから指定されたアイテムを検索
    court = current_user.courts.find_by(id: params[:id])
    
    # カートが存在する場合のみ削除処理を実行
    if court
      court.destroy
      redirect_to mypage_path, notice: "商品をカートから取り消しました。"
    else
      redirect_to mypage_path, alert: "指定された商品はカートに存在しません。"
    end
  end

end
