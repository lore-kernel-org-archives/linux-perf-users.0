Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2737BC432BE
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC46461053
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 13:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244347AbhIAN66 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhIAN66 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 09:58:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F5F961027;
        Wed,  1 Sep 2021 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630504681;
        bh=4W4xcNeNj8GfQiciEBIsSsUKEEzijV2sr68dhE9kOVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtktZLdDjwmU0v5d2MJEiClFYk6aeiKcvi04xWnnV3pBAEdmVMq0UUQ+OCh7VVNUB
         jJ9GIfQ7Jke/cpiKmdrNenHrU/411YDEQyufpIBYpq9DYGeLY2A8EUH5SU5tgyCjGm
         Hzz/O2ukOy8mWIaerSlVkgW4BRnQalTajkAaR8QoiPgPzLd1l6btkxCq7dw88kmP3Q
         HYEKItyWDZzKMHD4wkbYokkNYCW12B4t0yZpr5M6NshlRWxUfd/o3rCeLVNWELywx/
         cOLOB5C4uzuEHUr/IWWbceFp9bTVjbXEL77bGUtSWQHtt7Jzs3HkxTZH4MfJXVnvmc
         Vq3TP8iG1IJIw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BBC14007E; Wed,  1 Sep 2021 10:57:58 -0300 (-03)
Date:   Wed, 1 Sep 2021 10:57:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v6 1/2] perf pmu: Add PMU alias support
Message-ID: <YS+G5s41RWX0GIqG@kernel.org>
References: <20210901054602.17010-1-yao.jin@linux.intel.com>
 <20210901054602.17010-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901054602.17010-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Sep 01, 2021 at 01:46:01PM +0800, Jin Yao escreveu:
<SNIP>

> +++ b/tools/perf/arch/x86/util/pmu.c

<SNIP>

> +static int setup_pmu_alias_list(void)
> +{
> +	char path[PATH_MAX];
> +	DIR *dir;
> +	struct dirent *dent;
> +	const char *sysfs = sysfs__mountpoint();
> +	struct perf_pmu_alias_name *pmu;
> +	char buf[MAX_PMU_NAME_LEN];
> +	FILE *file;
> +	int ret = 0;
> +
> +	if (!sysfs)
> +		return -1;
> +
> +	snprintf(path, PATH_MAX,
> +		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> +
> +	dir = opendir(path);
> +	if (!dir)
> +		return -1;
> +
> +	while ((dent = readdir(dir))) {
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		snprintf(path, PATH_MAX,
> +			 TEMPLATE_ALIAS, sysfs, dent->d_name);
> +
> +		if (!file_available(path))
> +			continue;
> +
> +		file = fopen(path, "r");
> +		if (!file)
> +			continue;
> +
> +		if (!fgets(buf, sizeof(buf), file)) {
> +			fclose(file);
> +			continue;
> +		}
> +
> +		fclose(file);
> +
> +		pmu = zalloc(sizeof(*pmu));
> +		if (!pmu) {
> +			ret = -ENOMEM;
> +			break;
> +		}
> +
> +		/* Remove the last '\n' */
> +		buf[strlen(buf) - 1] = 0;
> +
> +		pmu->alias = strdup(buf);
> +		if (!pmu->alias)
> +			goto mem_err;

This isn't returning -ENOMEM like when zalloc() fails above. Also you're
mixing 'return -1' with 'return -ENOMEM', please be consistent. Please
find some -E errno for the !sysfs case, perhaps -ENODEV?

> +
> +		pmu->name = strdup(dent->d_name);
> +		if (!pmu->name)
> +			goto mem_err;
> +
> +		list_add_tail(&pmu->list, &pmu_alias_name_list);
> +		continue;


Don't we have a 'struct pmu' constructor/destructor pair? I.e. instead
of doing all this in an open coded way as above, why not have:

void pmu__delete(struct pmu *pmu)
{
	if (!pmu)
		return;

	zfree(&pmu->name);
	zfree(&pmu->alias);
	free(pmu);
}

struct pmu *pmu__new(const char *name, const char *alias)
{
	struct pmu *pmu = zalloc(sizeof(*pmu));

	if (pmu) {
		pmu->name = strdup(name);
		if (!pmu->name)
			goto out_delete;

		pmu->alias = strdup(alias);
		if (!pmu->alias)
			goto out_delete;
	}

	return pmu;
out_err:
	pmu__delete(pmu);
	return NULL;
}

	And then just:

	pmu = pmu__new(dent->d_name, buf);
	if (!pmu)
		goto out_closedir;

	list_add_tail(&pmu->list, &pmu_alias_name_list);

And then you don't need the 'continue', as this is the end of the loop
block.
		
That 'ret' probably should start with -ENOMEM and you end the function
with:

	ret = 0;
out_closedir:
	closedir(dir);
	return ret;
}


The pmu__delete() should be used in perf's shutdown when running it
using memory leak detectors, when not using it, its ok to just leave it
as is to speed up the shutdown.

- Arnaldo

> +mem_err:
> +		free(pmu->alias);
> +		free(pmu->name);
> +		free(pmu);
> +		break;
> +	}
> +
> +	closedir(dir);
> +	return ret;
> +}
> +
> +static char *__pmu_find_real_name(const char *name)
> +{
> +	struct perf_pmu_alias_name *pmu;
> +
> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +		if (!strcmp(name, pmu->alias))
> +			return pmu->name;
> +	}
> +
> +	return (char *)name;
> +}
> +
> +char *pmu_find_real_name(const char *name)
> +{
> +	if (cached_list)
> +		return __pmu_find_real_name(name);
> +
> +	setup_pmu_alias_list();
> +	cached_list = true;
> +
> +	return __pmu_find_real_name(name);
> +}
> +
> +static char *__pmu_find_alias_name(const char *name)
> +{
> +	struct perf_pmu_alias_name *pmu;
> +
> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
> +		if (!strcmp(name, pmu->name))
> +			return pmu->alias;
> +	}
> +	return NULL;
> +}
> +
> +char *pmu_find_alias_name(const char *name)
> +{
> +	if (cached_list)
> +		return __pmu_find_alias_name(name);
> +
> +	setup_pmu_alias_list();
> +	cached_list = true;
> +
> +	return __pmu_find_alias_name(name);
> +}
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 9321bd0e2f76..d94e48e1ff9b 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>  			if (!strncmp(name, "uncore_", 7) &&
>  			    strncmp($1, "uncore_", 7))
>  				name += 7;
> -			if (!perf_pmu__match(pattern, name, $1)) {
> +			if (!perf_pmu__match(pattern, name, $1) ||
> +			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>  				if (parse_events_copy_term_list(orig_terms, &terms))
>  					CLEANUP_YYABORT;
>  				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6cdbee8a12e7..1a35915edf68 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -945,6 +945,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>  	return NULL;
>  }
>  
> +char * __weak
> +pmu_find_real_name(const char *name)
> +{
> +	return (char *)name;
> +}
> +
> +char * __weak
> +pmu_find_alias_name(const char *name __maybe_unused)
> +{
> +	return NULL;
> +}
> +
>  static int pmu_max_precise(const char *name)
>  {
>  	char path[PATH_MAX];
> @@ -958,13 +970,15 @@ static int pmu_max_precise(const char *name)
>  	return max_precise;
>  }
>  
> -static struct perf_pmu *pmu_lookup(const char *name)
> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  {
>  	struct perf_pmu *pmu;
>  	LIST_HEAD(format);
>  	LIST_HEAD(aliases);
>  	__u32 type;
> +	char *name = pmu_find_real_name(lookup_name);
>  	bool is_hybrid = perf_pmu__hybrid_mounted(name);
> +	char *alias_name;
>  
>  	/*
>  	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
> @@ -995,6 +1009,16 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  
>  	pmu->cpus = pmu_cpumask(name);
>  	pmu->name = strdup(name);
> +	if (!pmu->name)
> +		goto err;
> +
> +	alias_name = pmu_find_alias_name(name);
> +	if (alias_name) {
> +		pmu->alias_name = strdup(alias_name);
> +		if (!pmu->alias_name)
> +			goto err;
> +	}
> +
>  	pmu->type = type;
>  	pmu->is_uncore = pmu_is_uncore(name);
>  	if (pmu->is_uncore)
> @@ -1017,15 +1041,22 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  	pmu->default_config = perf_pmu__get_default_config(pmu);
>  
>  	return pmu;
> +err:
> +	if (pmu->name)
> +		free(pmu->name);
> +	free(pmu);
> +	return NULL;
>  }
>  
>  static struct perf_pmu *pmu_find(const char *name)
>  {
>  	struct perf_pmu *pmu;
>  
> -	list_for_each_entry(pmu, &pmus, list)
> -		if (!strcmp(pmu->name, name))
> +	list_for_each_entry(pmu, &pmus, list) {
> +		if (!strcmp(pmu->name, name) ||
> +		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>  			return pmu;
> +	}
>  
>  	return NULL;
>  }
> @@ -1919,6 +1950,9 @@ bool perf_pmu__has_hybrid(void)
>  
>  int perf_pmu__match(char *pattern, char *name, char *tok)
>  {
> +	if (!name)
> +		return -1;
> +
>  	if (fnmatch(pattern, name, 0))
>  		return -1;
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 033e8211c025..6b122f97acf3 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -21,6 +21,7 @@ enum {
>  #define PERF_PMU_FORMAT_BITS 64
>  #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>  #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
> +#define MAX_PMU_NAME_LEN 128
>  
>  struct perf_event_attr;
>  
> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>  
>  struct perf_pmu {
>  	char *name;
> +	char *alias_name;
>  	char *id;
>  	__u32 type;
>  	bool selectable;
> @@ -136,4 +138,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  bool perf_pmu__has_hybrid(void);
>  int perf_pmu__match(char *pattern, char *name, char *tok);
>  
> +char *pmu_find_real_name(const char *name);
> +char *pmu_find_alias_name(const char *name);
> +
>  #endif /* __PMU_H */
> -- 
> 2.17.1
