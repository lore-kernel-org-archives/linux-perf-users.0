From: Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [PATCH v11 17/24] perf config: Collect configs to handle config
 variables
Date: Fri, 4 Mar 2016 21:45:44 +0900
Message-ID: <56D98378.4080208@gmail.com>
References: <1447768424-17327-1-git-send-email-treeze.taeung@gmail.com>
 <1447768424-17327-17-git-send-email-treeze.taeung@gmail.com>
 <20151118051525.GP7062@sejong>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34998 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932AbcCDMpt (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 4 Mar 2016 07:45:49 -0500
In-Reply-To: <20151118051525.GP7062@sejong>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>, perf group <linux-perf-users@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>

Hi, Namhyung and all

(I'm modifying this patch to be tidy)
I have a mere question about name of a variable for
current config list that contains section list which has key-value
pairs from ~/.perfconfig or $(sysconfdir)/perfconfig config file.

(This variable is designed to be used by several functions
that handle config information(key-value pairs).)

I used 'sections' for this variable (type is 'struct list_head'),
but IMHO, I think that renaming it is better e.g.

1) 'cfglist'
2) 'configlist'
3) 'config_list'
4) 'cfgset'
5) 'configset'
6) 'config_set'
... :-\

It is trivial question,
but I wanna know a opinion of other people. :-)

Thanks,
Taeung

On 11/18/2015 02:15 PM, Namhyung Kim wrote:
> On Tue, Nov 17, 2015 at 10:53:37PM +0900, Taeung Song wrote:
>> Collecting configs into list because of two reason.
>>
>> First of all, if there are same variables both user
>> and system config file, they all will be printed
>> when 'list' command work. But if config variables are
>> duplicated, user config variables should only be printed
>> because it has priority.
>>
>> Lastly, list into which configs is collected
>> will be required to keep and handle config variables
>> and values in the near furture. For example,
>> getting or setting functionality.
>>
>> And change show_config() function.
>> Old show_config() worked depending on perf_config().
>> New show_config() work using collected configs list.
>>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
>
>> ---
>>   tools/perf/builtin-config.c | 150 ++++++++++++++++++++++++++++++++++++++++++--
>>   tools/perf/util/cache.h     |  13 ++++
>>   2 files changed, 158 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/builtin-config.c b/tools/perf/builtin-config.c
>> index e0f8b41..185aa5e 100644
>> --- a/tools/perf/builtin-config.c
>> +++ b/tools/perf/builtin-config.c
>> @@ -32,13 +32,148 @@ static struct option config_options[] = {
>>   	OPT_END()
>>   };
>>
>> -static int show_config(const char *key, const char *value,
>> -		       void *cb __maybe_unused)
>> +static struct config_section *find_section(struct list_head *sections,
>> +					   const char *section_name)
>>   {
>> +	struct config_section *section;
>> +
>> +	list_for_each_entry(section, sections, list)
>> +		if (!strcmp(section->name, section_name))
>> +			return section;
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct config_element *find_element(const char *name,
>> +					   struct config_section *section)
>> +{
>> +	struct config_element *element;
>> +
>> +	list_for_each_entry(element, &section->element_head, list)
>> +		if (!strcmp(element->name, name))
>> +			return element;
>> +
>> +	return NULL;
>> +}
>> +
>> +static void find_config(struct list_head *sections,
>> +			struct config_section **section,
>> +			struct config_element **element,
>> +			const char *section_name, const char *name)
>> +{
>> +	*section = find_section(sections, section_name);
>> +
>> +	if (*section != NULL)
>> +		*element = find_element(name, *section);
>> +	else
>> +		*element = NULL;
>> +}
>> +
>> +static struct config_section *init_section(const char *section_name)
>> +{
>> +	struct config_section *section;
>> +
>> +	section = zalloc(sizeof(*section));
>> +	if (!section)
>> +		return NULL;
>> +
>> +	INIT_LIST_HEAD(&section->element_head);
>> +	section->name = strdup(section_name);
>> +	if (!section->name) {
>> +		pr_err("%s: strdup failed\n", __func__);
>> +		free(section);
>> +		return NULL;
>> +	}
>> +
>> +	return section;
>> +}
>> +
>> +static int add_element(struct list_head *head,
>> +			      const char *name, const char *value)
>> +{
>> +	struct config_element *element;
>> +
>> +	element = zalloc(sizeof(*element));
>> +	if (!element)
>> +		return -1;
>> +
>> +	element->name = strdup(name);
>> +	if (!element->name) {
>> +		pr_err("%s: strdup failed\n", __func__);
>> +		free(element);
>> +		return -1;
>> +	}
>>   	if (value)
>> -		printf("%s=%s\n", key, value);
>> +		element->value = (char *)value;
>>   	else
>> -		printf("%s\n", key);
>> +		element->value = NULL;
>> +
>> +	list_add_tail(&element->list, head);
>> +	return 0;
>> +}
>> +
>> +static int collect_current_config(const char *var, const char *value,
>> +				  void *spec_sections)
>> +{
>> +	int ret = -1;
>> +	char *ptr, *key;
>> +	char *section_name, *name;
>> +	struct config_section *section = NULL;
>> +	struct config_element *element = NULL;
>> +	struct list_head *sections = (struct list_head *)spec_sections;
>> +
>> +	key = ptr = strdup(var);
>> +	if (!key) {
>> +		pr_err("%s: strdup failed\n", __func__);
>> +		return -1;
>> +	}
>> +
>> +	section_name = strsep(&ptr, ".");
>> +	name = ptr;
>> +	if (name == NULL || value == NULL)
>> +		goto out_err;
>> +
>> +	find_config(sections, &section, &element, section_name, name);
>> +
>> +	if (!section) {
>> +		section = init_section(section_name);
>> +		if (!section)
>> +			goto out_err;
>> +		list_add_tail(&section->list, sections);
>> +	}
>> +
>> +	value = strdup(value);
>> +	if (!value) {
>> +		pr_err("%s: strdup failed\n", __func__);
>> +		goto out_err;
>> +	}
>> +
>> +	if (!element)
>> +		add_element(&section->element_head, name, value);
>> +	else {
>> +		free(element->value);
>> +		element->value = (char *)value;
>> +	}
>> +
>> +	ret = 0;
>> +out_err:
>> +	free(key);
>> +	return ret;
>> +}
>> +
>> +static int show_config(struct list_head *sections)
>> +{
>> +	struct config_section *section;
>> +	struct config_element *element;
>> +
>> +	if (list_empty(sections))
>> +		return -1;
>> +	list_for_each_entry(section, sections, list) {
>> +		list_for_each_entry(element, &section->element_head, list) {
>> +			printf("%s.%s=%s\n", section->name,
>> +				       element->name, element->value);
>> +		}
>> +	}
>>
>>   	return 0;
>>   }
>> @@ -46,6 +181,7 @@ static int show_config(const char *key, const char *value,
>>   int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
>>   {
>>   	int ret = 0;
>> +	struct list_head sections;
>>
>>   	argc = parse_options(argc, argv, config_options, config_usage,
>>   			     PARSE_OPT_STOP_AT_NON_OPTION);
>> @@ -57,18 +193,22 @@ int cmd_config(int argc, const char **argv, const char *prefix __maybe_unused)
>>   		return -1;
>>   	}
>>
>> +	INIT_LIST_HEAD(&sections);
>> +
>>   	if (use_system_config)
>>   		config_exclusive_filename = perf_etc_perfconfig();
>>   	else if (use_user_config)
>>   		config_exclusive_filename = mkpath("%s/.perfconfig", getenv("HOME"));
>>
>> +	perf_config(collect_current_config, &sections);
>> +
>>   	switch (actions) {
>>   	case ACTION_LIST:
>>   		if (argc) {
>>   			pr_err("Error: takes no arguments\n");
>>   			parse_options_usage(config_usage, config_options, "l", 1);
>>   		} else {
>> -			ret = perf_config(show_config, NULL);
>> +			ret = show_config(&sections);
>>   			if (ret < 0)
>>   				pr_err("Nothing configured, "
>>   				       "please check your ~/.perfconfig file\n");
>> diff --git a/tools/perf/util/cache.h b/tools/perf/util/cache.h
>> index d1eb75f..e503371 100644
>> --- a/tools/perf/util/cache.h
>> +++ b/tools/perf/util/cache.h
>> @@ -1,6 +1,7 @@
>>   #ifndef __PERF_CACHE_H
>>   #define __PERF_CACHE_H
>>
>> +#include <linux/list.h>
>>   #include <stdbool.h>
>>   #include "util.h"
>>   #include "strbuf.h"
>> @@ -19,6 +20,18 @@
>>   #define PERF_DEBUGFS_ENVIRONMENT "PERF_DEBUGFS_DIR"
>>   #define PERF_TRACEFS_ENVIRONMENT "PERF_TRACEFS_DIR"
>>
>> +struct config_element {
>> +	char *name;
>> +	char *value;
>> +	struct list_head list;
>> +};
>> +
>> +struct config_section {
>> +	char *name;
>> +	struct list_head element_head;
>> +	struct list_head list;
>> +};
>> +
>>   extern const char *config_exclusive_filename;
>>
>>   typedef int (*config_fn_t)(const char *, const char *, void *);
>> --
>> 1.9.1
>>
