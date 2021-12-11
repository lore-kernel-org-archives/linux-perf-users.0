Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BBDC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Dec 2021 19:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbhLKTYy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Dec 2021 14:24:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230170AbhLKTYy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Dec 2021 14:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639250693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGYIOmJ2zjGn+fUhHgq4NRxWkx6+azyaRHTbsJwZhRY=;
        b=U/y8IRz/LgZAXHUTX8DEsqPO6Z4f9kYYLmbhpSnmAUP5Hg0z455c1sLsHvnhWvg27nteXK
        eCvxZsb+yBegponQO6z2bVxOcZ29N+Zeo+07716UNVhjphAznSAbHkvVGerkBtT3rSf1b0
        udIOJKjSSmxr4z5lC/IQ40UPE7r4ZzA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-nYRNXbN8PlaxmxIuFJ4QnA-1; Sat, 11 Dec 2021 14:24:52 -0500
X-MC-Unique: nYRNXbN8PlaxmxIuFJ4QnA-1
Received: by mail-wm1-f70.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so5165462wms.8
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Dec 2021 11:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGYIOmJ2zjGn+fUhHgq4NRxWkx6+azyaRHTbsJwZhRY=;
        b=ebKnUnhVq1BcNYzLUPBszDXddD+jMpBZi7dJ/6w8Wacv9snkAXvoWbeaUVg02iteaS
         GEFBIl5kRz8i6pmowDAuco4p3Eo1XBXKIiVYk1rDfbOJau0gun+PiEjGN1+kXe9NuCOu
         2z3l59IesHKffjTUeyB446sdIyCypFsfpXpapbV3mv0pIZBPwjUTtMM32NC+vKXtn1yW
         vWzMqTQyBEz40DZ5SKhFQx+jSr7k4V59/ZU1DqgFTjHUQaJlwYribPteEpXoMI9Qijhw
         Yv1fwqiV6L3L/6flOWhUN46AYQLtH22QaeSzQ1j6q+OH2VIneyKzQLbgkY87+2pN32pp
         cxnw==
X-Gm-Message-State: AOAM530hPyavOXiomVtzWlES10vVy5fdyegmMNvb1yeoesASjYZK4lWh
        K/J2ciqdYlgg4JYnO3bXkcu/fCrgyFSEMIwOvspOJ/inz4J5xEJG7mHWqg6JYOdTg+51x0esSV9
        qg4SjYWH9LimGKRvfXsg/hXeNbWGFmA==
X-Received: by 2002:a05:600c:3788:: with SMTP id o8mr25186231wmr.82.1639250689059;
        Sat, 11 Dec 2021 11:24:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwa/3BISCKTvKxuMjkiQQIWAJRL5ggw9TxlZ7vsysO2Hk3jaZV+Ycso4fQpJ7VM8oYT4MJC0g==
X-Received: by 2002:a05:600c:3788:: with SMTP id o8mr25186186wmr.82.1639250688821;
        Sat, 11 Dec 2021 11:24:48 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id h18sm6196422wre.46.2021.12.11.11.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 11:24:48 -0800 (PST)
Date:   Sat, 11 Dec 2021 20:24:46 +0100
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
Subject: Re: [PATCH 21/22] perf cpumap: Trim the cpu_aggr_map
Message-ID: <YbT6/kEmnAmkxrJC@krava>
References: <20211208024607.1784932-1-irogers@google.com>
 <20211208024607.1784932-22-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208024607.1784932-22-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Dec 07, 2021 at 06:46:06PM -0800, Ian Rogers wrote:
> cpu_aggr_map__new removes duplicates, when this happens shrink the
> array.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/cpumap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 8a72ee996722..985c87f1f1ca 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -185,7 +185,12 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>  			c->nr++;
>  		}
>  	}
> -
> +	/* Trim. */
> +	if (c->nr != cpus->nr) {
> +		c = realloc(c, sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
> +		if (!c)
> +			return NULL;
> +	}

curious.. we should do this, but did you detect some big waste in here?

thanks,
jirka

>  	/* ensure we process id in increasing order */
>  	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
>  
> -- 
> 2.34.1.400.ga245620fadb-goog
> 

