from src.metaquery import meta_query

mq = meta_query(path='metadata/metadata.csv')

mq.get_lang()
mq.filter_lang('es', how='any')
print(mq.get_lang_counts())