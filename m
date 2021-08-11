Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20290C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E866160EE5
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhHKTXy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39435 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229802AbhHKTXy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 15:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628709810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QYV7yJkCGUneeZS2etenhK2/KIs8SI+lrmptDbX+IrU=;
        b=WxLNwEqjsZeDx/8RdY7q2fr2vBau4JMLE923sz5fsskFJ6cbtp8hWf+FwxsHBbroTVGus8
        Be3TOzYH+Sar3fPUH79/qZ2zznMqnPufqwKWqDTfDbZ3bw9nLXvf4uKXynJQU3My6suiNu
        TtQcTo81zccnQK4TW1RwDpNHz88RQCE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-UfJ7ztPAOgaSm6eK6_rEFA-1; Wed, 11 Aug 2021 15:23:29 -0400
X-MC-Unique: UfJ7ztPAOgaSm6eK6_rEFA-1
Received: by mail-ej1-f72.google.com with SMTP id kf21-20020a17090776d5b02905af6ad96f02so1094469ejc.12
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Aug 2021 12:23:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QYV7yJkCGUneeZS2etenhK2/KIs8SI+lrmptDbX+IrU=;
        b=QcdoccjYKPZwjGw4tRhEfSv+TDqd30gsEqVrVDciBagkHVc/Pf/XfTy7LSAsmoSmyR
         NDSgHz+zDRYjykvPvNpvcZKRkbMloGjZjUhx4C/6bVt7sT5duteViK9QjtEmxwDtWk1p
         yNrnrRRhw87SqFrMlCDGQ2TXnJqQnDcdkwm/fL8etc1xXFM1V3yAlbMpfiwDA5RqArGP
         Jgy2DVUNU24QV8ZgkNh+So92W0WDZddbYG98FpvIMi6Fk4kJieezaGyvtvuJHPBSY0n0
         5/opCEfd8QpW6KNYUNje+oikWAmSoeDVwOALjid8nGVuB+JHInqyaydrfIla9yZFhfmK
         1ufw==
X-Gm-Message-State: AOAM532H4IYy11v6dOAxzlcDmToONEUKrZoL1gnvBOVcmIqTVT5vmCxF
        n52zDKZJIaOgCHJqpDlN+1zy7YsWkJoXY5XxE4NmjahdEkHOpx8QkbCNOBqIadbsY33MwcKkuaL
        6AZoOoKrAYIDlFHBs8jHWW3FAThBgUQ==
X-Received: by 2002:aa7:d44c:: with SMTP id q12mr571041edr.57.1628709807787;
        Wed, 11 Aug 2021 12:23:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+jALKFOkws6OsCCeMk2eQauX+CWw145DXpwLY6T0Le8RYbnYyLT78ObJe3flREqQaVWWQHw==
X-Received: by 2002:aa7:d44c:: with SMTP id q12mr571017edr.57.1628709807627;
        Wed, 11 Aug 2021 12:23:27 -0700 (PDT)
Received: from krava ([83.240.61.5])
        by smtp.gmail.com with ESMTPSA id q8sm66262edv.95.2021.08.11.12.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:23:27 -0700 (PDT)
Date:   Wed, 11 Aug 2021 21:23:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
Message-ID: <YRQjreot69DL0xVV@krava>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811024827.9483-2-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 11, 2021 at 10:48:26AM +0800, Jin Yao wrote:

SNIP

>  				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index fc683bc41715..796a4be752f4 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -946,6 +946,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>  	return NULL;
>  }
>  
> +char * __weak
> +pmu_find_real_name(const char *name)
> +{
> +	return strdup(name);
> +}

hm, why does this need to return already strdup? it forces you
to add all those goto below.. could just return name and keep
the 'pmu->name = strdup(name);' below?

that should make the change simpler

jirka

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
> @@ -959,19 +971,25 @@ static int pmu_max_precise(const char *name)
>  	return max_precise;
>  }
>  
> -static struct perf_pmu *pmu_lookup(const char *name)
> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  {
> -	struct perf_pmu *pmu;
> +	struct perf_pmu *pmu = NULL;
>  	LIST_HEAD(format);
>  	LIST_HEAD(aliases);
>  	__u32 type;
> -	bool is_hybrid = perf_pmu__hybrid_mounted(name);
> +	bool is_hybrid;
> +	char *name = pmu_find_real_name(lookup_name);
> +
> +	if (!name)
> +		return NULL;
> +
> +	is_hybrid = perf_pmu__hybrid_mounted(name);
>  
>  	/*
>  	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
>  	 */
>  	if (!strncmp(name, "cpu_", 4) && !is_hybrid)
> -		return NULL;
> +		goto out;
>  
>  	/*
>  	 * The pmu data we store & need consists of the pmu
> @@ -979,23 +997,24 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  	 * now.
>  	 */
>  	if (pmu_format(name, &format))
> -		return NULL;
> +		goto out;
>  
>  	/*
>  	 * Check the type first to avoid unnecessary work.
>  	 */
>  	if (pmu_type(name, &type))
> -		return NULL;
> +		goto out;
>  
>  	if (pmu_aliases(name, &aliases))
> -		return NULL;
> +		goto out;
>  
>  	pmu = zalloc(sizeof(*pmu));
>  	if (!pmu)
> -		return NULL;
> +		goto out;
>  
>  	pmu->cpus = pmu_cpumask(name);
> -	pmu->name = strdup(name);
> +	pmu->name = name;
> +	pmu->alias_name = pmu_find_alias_name(name);
>  	pmu->type = type;
>  	pmu->is_uncore = pmu_is_uncore(name);
>  	if (pmu->is_uncore)
> @@ -1017,6 +1036,10 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  
>  	pmu->default_config = perf_pmu__get_default_config(pmu);
>  
> +out:
> +	if (!pmu)
> +		free(name);
> +
>  	return pmu;
>  }
>  
> @@ -1025,7 +1048,8 @@ static struct perf_pmu *pmu_find(const char *name)
>  	struct perf_pmu *pmu;
>  
>  	list_for_each_entry(pmu, &pmus, list)
> -		if (!strcmp(pmu->name, name))
> +		if (!strcmp(pmu->name, name) ||
> +		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>  			return pmu;
>  
>  	return NULL;
> @@ -1920,6 +1944,9 @@ bool perf_pmu__has_hybrid(void)
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
> index 926da483a141..f6ca9f6a06ef 100644
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
> +	char *alias_name;	/* PMU alias name */
>  	char *id;
>  	__u32 type;
>  	bool selectable;
> @@ -135,4 +137,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>  bool perf_pmu__has_hybrid(void);
>  int perf_pmu__match(char *pattern, char *name, char *tok);
>  
> +char *pmu_find_real_name(const char *name);
> +char *pmu_find_alias_name(const char *name);
> +
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

