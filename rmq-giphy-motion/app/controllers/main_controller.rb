class MainController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :search_label)

    @query = rmq.append(UITextField, :query).focus.get

    rmq.append(UIButton, :submit_button).on(:touch) do |sender|
      search_for_images @query.text
    end
  end

  def init_nav
    self.title = 'Giphy'
  end

  def search_for_images(query)

    if query && (query != '')
      query = query.gsub(/\s/, '%20')
      # url = "http://api.giphy.com/v1/gifs/search?q=#{query}&api_key=dc6zaTOxFJmzC"

      rmq.animations.start_spinner

      MotionGiphy::Client.search(query) do |response|
        if response.success?
          images = response.data.map{|gif| gif.fixed_width_downsampled.url }
          puts images
          open_images_controller images if images.length > 0
        else
          puts response.error.message
        end
        rmq.animations.stop_spinner
      end
    #   AFMotion::HTTP.get(url) do |result|
    #     puts result.body.first
    #     if html = result.body
    #       images = html.scan(/src=\"(.+?\.jpg)\"/).map do |m|
    #         m.first
    #       end
    #       open_images_controller images if images.length > 0
    #     end
    #     rmq.animations.stop_spinner
    #   end
    end
  end

  def open_images_controller(images)
    controller = ImagesController.new
    controller.images = images
    controller.query = @query.text
    self.navigationController.pushViewController(controller, animated: true)
  end
end
