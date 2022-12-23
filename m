Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19512C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Dec 2022 06:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiLWGKq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Dec 2022 01:10:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWGKp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Dec 2022 01:10:45 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF88BB7
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 22:10:43 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gt4so4109424pjb.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Dec 2022 22:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXPdrlpALcCWkBm8FPPkV2XlgJO2+LLb79iteN7EJJo=;
        b=dGLEQau5Zp3bvpscFMxHQgEVrw/iveBPjD0OXR7qdPyUHLojRCQxTr7gwpP5ScN3B8
         Xu6PdnRJhf0E95jDgMRinj5IheV4xSsMZy/J03g4mUa1cgbhuNK8HNCMCQXoXoXx0ndx
         b2yH30Ey4JmJrd+tdZX8sSLcuje7Z3ovMRWbxQpOXqtJFm0mE4mazzVv3i9b8Y1UM+Ue
         /r23SlqV65qu1p56ybQoyD5gMv0hwQqq4nWpmEJsLApPbuVdDmVkOhYJOC+thbs72+0N
         lXu/XE052b1l7TIAkKRwM6Fc2D2KSqRfnVYnbEl+X6t3vs6aNz9kUFOHCeS7UeIkcH0e
         LhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXPdrlpALcCWkBm8FPPkV2XlgJO2+LLb79iteN7EJJo=;
        b=BRarYEsH77nVsn+Ff6wsR4dt8beRhZtRyqZXP7Z8v8/eJMg6HOu/XPKIPnlhziZdR3
         +aoeBdRcXyhEzW8tRXrzHiOCRXBdfzxznB5buRZ35QwV0Z7jroLTnRXbp0ljmKKVVLhi
         yY2ddmfm6g1j9HNugdGr14wnpb7zyNmCiGuEuEn8qSykGM3BeeYvPR+kujER2csdvMS4
         yRAaOSCbBZI3AS88AsO1FcI6+6K1d4Gs7Ki6nRow0NlU62RFHdS5x0DSReJCazeFMaRb
         VphRc9YwkGz6aV9/S3ki7dJQcF3ZBFIcHXLY9DYTolpnhk7eisVabuy8JflgsZ1SmDkk
         fyLA==
X-Gm-Message-State: AFqh2kp9HH6vm1tbAXgXShRdyuFaCKTL4Yyszuk3V9y+YtSa7gZlrLDn
        gn9GoaAMVdmKG9Xh+niEnVJiLQ==
X-Google-Smtp-Source: AMrXdXtwTGljJ/AUqSzEc+83rOc+y0OY4t/wqHgum5eZKlI3BX9oazUJe4IGHrQ1wvanyW9N8SKCDg==
X-Received: by 2002:a17:902:ce10:b0:189:af28:fd8d with SMTP id k16-20020a170902ce1000b00189af28fd8dmr10843064plg.1.1671775843250;
        Thu, 22 Dec 2022 22:10:43 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00188f3970d4asm1503343pln.163.2022.12.22.22.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 22:10:42 -0800 (PST)
Date:   Fri, 23 Dec 2022 14:10:34 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com,
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
Subject: Re: [PATCH v2 3/7] perf: Remove remaining duplication of
 bus/event_source/devices/...
Message-ID: <Y6VGWm0LtiVNvTmI@leoy-yangtze.lan>
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222160328.3639989-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 22, 2022 at 04:03:23PM +0000, James Clark wrote:
> Use the new perf_pmu__pathname_scnprintf() instead. No functional
> changes.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/pmu.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index faaeec1e15aa..15b852b3c401 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -574,8 +574,6 @@ static void pmu_read_sysfs(void)
>   * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
>   * may have a "cpus" file.
>   */
> -#define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
> -
>  static struct perf_cpu_map *pmu_cpumask(char *name)
>  {
>  	struct perf_cpu_map *cpus;
> @@ -616,9 +614,9 @@ static char *pmu_id(const char *name)
>  	char path[PATH_MAX], *str;
>  	size_t len;
>  
> -	snprintf(path, PATH_MAX, SYS_TEMPLATE_ID, name);
> +	perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "identifier");
>  
> -	if (sysfs__read_str(path, &str, &len) < 0)
> +	if (filename__read_str(path, &str, &len) < 0)
>  		return NULL;
>  
>  	str[len - 1] = 0; /* remove line feed */
> @@ -864,16 +862,11 @@ pmu_find_alias_name(const char *name __maybe_unused)
>  	return NULL;
>  }
>  
> -static int pmu_max_precise(const char *name)
> +static int pmu_max_precise(struct perf_pmu *pmu)
>  {
> -	char path[PATH_MAX];
>  	int max_precise = -1;
>  
> -	scnprintf(path, PATH_MAX,
> -		 "bus/event_source/devices/%s/caps/max_precise",
> -		 name);
> -
> -	sysfs__read_int(path, &max_precise);
> +	perf_pmu__scan_file(pmu, "caps/max_precise", "%d", &max_precise);
>  	return max_precise;
>  }
>  
> @@ -932,7 +925,7 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  	pmu->is_uncore = pmu_is_uncore(name);
>  	if (pmu->is_uncore)
>  		pmu->id = pmu_id(name);
> -	pmu->max_precise = pmu_max_precise(name);
> +	pmu->max_precise = pmu_max_precise(pmu);
>  	pmu_add_cpu_aliases(&aliases, pmu);
>  	pmu_add_sys_aliases(&aliases, pmu);
>  
> -- 
> 2.25.1
> 
