from src.metaquery import meta_query

mq = meta_query(path='metadata/metadata.csv')

mq.get_lang()
mq.filter_lang('es', how='only')
print(mq.get_ids())

print(mq.get_lang_counts())