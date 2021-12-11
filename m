Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B58FC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Dec 2021 19:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhLKTZR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Dec 2021 14:25:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhLKTZQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Dec 2021 14:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639250715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dIv6pkKUGV1T0mAJB7D51zRDre7thjOw+CRPJNXh72s=;
        b=fGnAyTiZmUzJ/Yg4hh88GwRoX7MKMweW0dP78i7sR3Pt0vgP8xe5i9IBS7jHdeBm1mHERI
        FFBhdOnol4Bi0L2Y864wojPTj1ljobPKZG3Xb3ZYNmarSP4s3L4SIGELjIC6YRhbs8fgVa
        hJfSh3Htzd0331GdrhlO2iHcXitrDlg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-54mLNDF4P5SvXlsxD30UYg-1; Sat, 11 Dec 2021 14:25:14 -0500
X-MC-Unique: 54mLNDF4P5SvXlsxD30UYg-1
Received: by mail-wm1-f70.google.com with SMTP id r129-20020a1c4487000000b00333629ed22dso8876650wma.6
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Dec 2021 11:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dIv6pkKUGV1T0mAJB7D51zRDre7thjOw+CRPJNXh72s=;
        b=skTP6q8USrLP5Tp2qfZwhKgqJAWF8uW12gMX1EGa/9tPepWjGOHfxeakRtEoQ2WSUy
         Xn8rdLbyq1xmWaVHh/9sXUB9p7EcZj4mfyi+rmaLbIFGvA1iFUZ03dhkx7cb9/hM7zdy
         E+EY00i6KCeNi43xqLSDquBnZ7hyUFcsAhxgx6ilom4dEYmD4cMMLMXgIvqHMdSTVQN1
         k8yd03v9vf98n6r977mOD1L8jfvyfbmw1LDdbAjR2VLIAZJD5RBEoTcw0gzoODlwOJPd
         YCdLpWKd6KnrjkKeU3Z3hWSeElySEmGDrfsJiqWFgi6ZwRjPtJI0TP8hXo8NWET6C1NW
         acQw==
X-Gm-Message-State: AOAM530d8diTjNnzHuFpSkul5UV7UBtPBuTkB29fyfCOe5tQ5d1y2jhY
        CBLc1319kCj0tFuH9TV1Gf1xdyIfhTMNM8CGHiMOcURIiTkRXZYZxbPAcYpiWFJPCuKjHs7SH3l
        3JZG5TnD3GX8bwj5zWVq+kd3/5XuElw==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr25977366wmb.82.1639250713164;
        Sat, 11 Dec 2021 11:25:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztQTZBoBdnMJaOKM6MJZD+Tf74WLX+vCpXk18rbXjj4VZdB0bXkx78rI4ZvQ9zGByCWUhwNw==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr25977331wmb.82.1639250712984;
        Sat, 11 Dec 2021 11:25:12 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id l8sm2364512wmc.40.2021.12.11.11.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:25:12 -0800 (PST)
Date:   Sat, 11 Dec 2021 20:25:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, eranian@google.com
Subject: Re: [PATCH 17/22] perf cpumap: Refactor cpu_map__build_map
Message-ID: <YbT7Fg1l8sZ3R44a@krava>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-18-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208024607.1784932-18-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 07, 2021 at 06:46:02PM -0800, Ian Rogers wrote:

SNIP

> -			perror("cannot build core map");
> -			return -1;
> -		}
> -		stat_config.aggr_get_id = perf_stat__get_core_file;
> -		break;
> +		return perf_stat__get_core_file;
>  	case AGGR_NODE:
> -		if (perf_env__build_node_map(env, evsel_list->core.cpus, &stat_config.aggr_map)) {
> -			perror("cannot build core map");
> -			return -1;
> -		}
> -		stat_config.aggr_get_id = perf_stat__get_node_file;
> -		break;
> +		return perf_stat__get_node_file;
>  	case AGGR_NONE:
>  	case AGGR_GLOBAL:
>  	case AGGR_THREAD:
>  	case AGGR_UNSET:
>  	default:
> -		break;
> +		return NULL;
>  	}
> +}
> +
> +static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
> +{
> +	struct perf_env *env = &st->session->header.env;
>  
> +	aggr_cpu_id_get_t f = aggr_mode__get_aggr_file(stat_config.aggr_mode);

we use get_id for aggr_get_id_t, maybe we could use it instead of 'f' in
here as well

> +
> +	if (!f)
> +		return 0;
> +
> +	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.cpus, f, env);
> +	if (!stat_config.aggr_map) {
> +		pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
> +		return -1;
> +	}
> +	stat_config.aggr_get_id = aggr_mode__get_id_file(stat_config.aggr_mode);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 32f9fc2dd389..ba4468f691c8 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -140,7 +140,7 @@ struct aggr_cpu_id cpu_map__get_socket_aggr_by_cpu(int cpu, void *data __maybe_u
>  	return id;
>  }
>  
> -static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
> +static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
>  {
>  	struct aggr_cpu_id *a = (struct aggr_cpu_id *)a_pointer;
>  	struct aggr_cpu_id *b = (struct aggr_cpu_id *)b_pointer;
> @@ -157,37 +157,40 @@ static int cmp_aggr_cpu_id(const void *a_pointer, const void *b_pointer)
>  		return a->thread - b->thread;
>  }
>  
> -int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
> -		       struct aggr_cpu_id (*f)(int cpu, void *data),
> -		       void *data)
> +struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
> +				       aggr_cpu_id_get_t f,
> +				       void *data)

same here

thanks,
jirka

>  {
> -	int nr = cpus->nr;
> -	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(nr);
> -	int cpu, s2;
> -	struct aggr_cpu_id s1;
> +	int cpu, idx;
> +	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);
>  
>  	if (!c)
> -		return -1;
> +		return NULL;
>  
>  	/* Reset size as it may only be partially filled */
>  	c->nr = 0;
>  
> -	for (cpu = 0; cpu < nr; cpu++) {
> -		s1 = f(cpu, data);
> -		for (s2 = 0; s2 < c->nr; s2++) {
> -			if (aggr_cpu_id__equal(&s1, &c->map[s2]))
> +	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> +		bool duplicate = false;
> +		struct aggr_cpu_id cpu_id = f(cpu, data);
> +
> +		for (int j = 0; j < c->nr; j++) {
> +			if (aggr_cpu_id__equal(&cpu_id, &c->map[j])) {
> +				duplicate = true;
>  				break;
> +			}
>  		}
> -		if (s2 == c->nr) {
> -			c->map[c->nr] = s1;
> +		if (!duplicate) {
> +			c->map[c->nr] = cpu_id;
>  			c->nr++;
>  		}
>  	}
> +
>  	/* ensure we process id in increasing order */
> -	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), cmp_aggr_cpu_id);
> +	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
> +
> +	return c;
>  
> -	*res = c;
> -	return 0;
>  }
>  

SNIP

