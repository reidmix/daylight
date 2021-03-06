require 'spec_helper'

describe API::V1::Blog do

  let(:blog) { Blog.new(name:'Test Blog') }
  let(:company) { Company.new(name:'Test Company') }

  before do
    blog.posts << Post.new(title:'one')
    blog.posts << Post.new(title:'two')
    company.blogs << blog
    company.save!
  end

  it 'belongs to a company' do
    blog = API::V1::Blog.first
    blog.company.name.should == 'Test Company'
  end

  it 'has many posts' do
    blog = API::V1::Blog.first
    blog.posts.count.should == 2
  end

  it 'can be created remotely' do
    API::V1::Blog.new(name:'Alpaca Fancy').save

    API::V1::Blog.where(name:'Alpaca Fancy').should_not be_empty
  end

end
