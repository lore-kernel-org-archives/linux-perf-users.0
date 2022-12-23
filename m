Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1077DC4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Dec 2022 06:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLWG0f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Dec 2022 01:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiLWG0d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Dec 2022 01:26:33 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC222DC0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 22:26:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d7so4115707pll.9
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 22:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RGmoXJ75UXpNguUssjM7gnVJdq2PHsHw6DOwMdQhd2Q=;
        b=LiYGPk+RqxHs5M5OWdfSnYZT6kJZi867YaEu8A6+RNNoFt2PoNKtMwLDAW9Rt4Iivv
         1qwY5zE8Rw4/08Be+4hmRMmhaUfsJwUgK1B8+bEBvvS7Xz/bUZfK7mNS7Wf1R5UYdvWF
         TXPhqFs6tJd3F7vueo2hkRDF50OORGLirfd7x3LopSqorYYCHYZt1aLVYZLSDG2Ad4Q3
         3Kux99K40eoK6tKRRcRyoeu+vD+Jxh9P/gwoMYXp0wPMo4EwTAWdumjrbNDdqKmTAcwG
         wEjx/wpt+HfyDsnzwlRzIkqCIZbpX1sxg2XcYWimTnk5eDRExqL3Q1SQYz1Fjte71ov1
         FEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGmoXJ75UXpNguUssjM7gnVJdq2PHsHw6DOwMdQhd2Q=;
        b=j88wwWQY0wX+OEmp6K6NQe5plfoox5GInOpA96u9yZ6AWeihJMCCZoXr64QLTvxid7
         7thwNUFNDtgyeE7X7fv+oXUGzsxgdronqE/zLMFVoY/W0LMu6P+yYBwXKIIP5QW5kNsg
         YEezvFuTmK9b0pQXRov97j06N/VAphfJ8by+0yXnFzd8JsO301zrJ0dezUelf6fog+mB
         MuD27pd1CPPlmOiGDTh4934TrFBa885SUW7BXgQMFTLEjb5isXK6V/k28MQxm2njOfOA
         BUh5l59aunAovRDu7zjQy2fb3gkiCz2nk+c0RGN6Q2mxLe/2CbWxBHUFLABqTi/64n3O
         oxGA==
X-Gm-Message-State: AFqh2ko2COckj38gaKThHo0Y3VxrN1koED4jhV+I5pvBwJIFpykdNr1L
        J2TGRSSX+m2gXoRGdlnKCecalA==
X-Google-Smtp-Source: AMrXdXtY8I/N4ldtzRd+EoFIog+Fh+aszryhhGlTn3TaciroaBWQKNCtk/Do3bV1ZV7huZPBInglgA==
X-Received: by 2002:a17:90a:7803:b0:223:fe74:eb0b with SMTP id w3-20020a17090a780300b00223fe74eb0bmr9731120pjk.12.1671776792405;
        Thu, 22 Dec 2022 22:26:32 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b002191e769546sm1553663pjf.4.2022.12.22.22.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 22:26:31 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:26:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com, German Gomez <german.gomez@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] perf pmu: Add function to check if a pmu file
 exists
Message-ID: <Y6VKEfsGu0Pteb8e@leoy-yangtze.lan>
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222160328.3639989-5-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 22, 2022 at 04:03:24PM +0000, James Clark wrote:
> From: German Gomez <german.gomez@arm.com>
> 
> Add a utility function perf_pmu__file_exists() to check if a given pmu
> file exists in the sysfs filesystem.
> 
> Signed-off-by: German Gomez <german.gomez@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/pmu.c | 14 ++++++++++++++
>  tools/perf/util/pmu.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 15b852b3c401..b72b2d892949 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1739,6 +1739,20 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>  	return ret;
>  }
>  
> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name)
> +{
> +	char path[PATH_MAX];
> +	struct stat statbuf;
> +
> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, pmu->name, name))
> +		return false;
> +
> +	if (!file_available(path))
> +		return false;
> +
> +	return stat(path, &statbuf) == 0;

Can we simply return the returned value from file_available() and skip
calling stat()?  Because file_available() invokes access() to detect if
a file is existed or not, so here calling stat() is redundant.

Thanks,
Leo

> +}
> +
>  static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
>  {
>  	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 8f39e2d17fb1..c1d138fe9602 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -230,6 +230,8 @@ bool pmu_have_event(const char *pname, const char *name);
>  
>  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
>  
> +bool perf_pmu__file_exists(struct perf_pmu *pmu, const char *name);
> +
>  int perf_pmu__test(void);
>  
>  struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
> -- 
> 2.25.1
> 
