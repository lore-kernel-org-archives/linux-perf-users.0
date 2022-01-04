Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E90C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Jan 2022 14:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbiADOUH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234097AbiADOUH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Jan 2022 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641306006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tdBXcdlUZgH91vSV8gBFMtFgTf/fDf2VkDsQMplYoag=;
        b=W2syZLrtg98LPwkFetWikVPH1TWKDNIghIwTwM2jgmg65df4nrzlPeMVMzlz0ANH82WWZl
        wnOwstiWuBhLiSNEoT4nassAPQ0sSruTas1VCjdtZDdOqb3HdRVbcpfnLEqc1uf2MEcFP+
        dqIuoelHsYlIWL0iZQqaQj3QQazBqxo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-KAbhAkTJNfC8HCQmAbhv4A-1; Tue, 04 Jan 2022 09:20:05 -0500
X-MC-Unique: KAbhAkTJNfC8HCQmAbhv4A-1
Received: by mail-ed1-f70.google.com with SMTP id o20-20020a056402439400b003f83cf1e472so25407576edc.18
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 06:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tdBXcdlUZgH91vSV8gBFMtFgTf/fDf2VkDsQMplYoag=;
        b=Q+Gl09ohq6KPlr3aozV5NpbTEh32Z6GprIk2dJBxdRilvFbKTqw9uIwVlWGn4RWXza
         EbJ6JHiDYrziztjt+4pxWIwwpDyEYZC22j0gkw8hNC/r9DJyMI3EjM+slfLwPmgt0eS1
         MiktGn4SD1UiJpzg1bHmV77zL1kcjcS4ZL3wmbbQuxLk1X0N2SLPWtL1CDftv93MFb9R
         uHzHi/Gp04th0oSRBM31lWZshqD8u6R+TSQ2xKFYlS9vwRmZZ0A5gBVeWlhwkGuIweIf
         ZtPucQaFfJci0U7XPCqpdi7k/bCnixwhNrbmpFn1QUYZR8sHwsQkEFWtiGzj+rB3OWtj
         FeoQ==
X-Gm-Message-State: AOAM531WYVLFEmRxUU5BV01Weqbmp7dewKChVBEm1Gunoou4B0aA7kYT
        qJLKdeTescJPiBY4UuKciVXs9bgTO4VXY8fk/7WQU8vW6o1vntAAwHpp96ONrlbovdEE70EQdwC
        I9sjeJTB9P/fKe7jjLRZnrTLC++jQ2g==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr41248751ejc.604.1641306004276;
        Tue, 04 Jan 2022 06:20:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxDMB0s8rjFyQSN39kRHQDqc01meMLfO5JYh1JLbN/Rupu47T0fL4hC9U8RPK01PTE4BlD7MQ==
X-Received: by 2002:a17:907:3f83:: with SMTP id hr3mr41248713ejc.604.1641306004067;
        Tue, 04 Jan 2022 06:20:04 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id f14sm14766323eds.20.2022.01.04.06.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:20:03 -0800 (PST)
Date:   Tue, 4 Jan 2022 15:20:01 +0100
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
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Subject: Re: [PATCH v3 18/48] perf cpumap: Refactor cpu_map__build_map
Message-ID: <YdRXkXIVAkgO1p0d@krava>
References: <20211230072030.302559-1-irogers@google.com>
 <20211230072030.302559-20-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230072030.302559-20-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Dec 29, 2021 at 11:20:00PM -0800, Ian Rogers wrote:

SNIP

> +		return 0;
> +
> +	stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.cpus, get_id, env);
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

s/f/get_id/ ?

jirka


> +				       void *data)
>  {
> -	int nr = cpus->nr;
> -	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(nr);
> -	int cpu, s2;
> -	struct aggr_cpu_id s1;
> +	int cpu, idx;
> +	struct cpu_aggr_map *c = cpu_aggr_map__empty_new(cpus->nr);

SNIP

