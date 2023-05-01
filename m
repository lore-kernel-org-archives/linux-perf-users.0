Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E5C77B61
	for <linux-perf-users@archiver.kernel.org>; Mon,  1 May 2023 07:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjEAHfL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 1 May 2023 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEAHfI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 1 May 2023 03:35:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4F610C4
        for <linux-perf-users@vger.kernel.org>; Mon,  1 May 2023 00:35:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24ddf274039so1040790a91.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 May 2023 00:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682926504; x=1685518504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wQrzKEZuX3/5Eef7KYCRXhJKEAjq0AaAjZ6GxmmUQA=;
        b=pz6OmxP6Fg7Vb4oJk0JZFeQ+MTDUHyPTrS/XaaO/HIdZRNFns/MsY2sRHWMXintVHn
         t+M3tkRSn55imwLUUniv4dxD9C5df5uptXLGHHknGuyGPyqnMHkX6Ws9QBlEwU+rV2Wl
         p8RSHV9DpzPkzAqVjEIp8WJbPrTlBCuNI7gU/RMvw9VkWuBxmQxZFg16NYgJ4TGTxJ00
         DbDh2d1OH2GrvL0uEa+VoeXxKImM4LwPVv3CFiRmPO6Naii89aEQYJNWlMX13BQjVonl
         WUg1jYj7mdR3gcelvz+B7MddNbvBwS9JSCcXca2RiPTE9PfwimO2Waq52C1RjGAeVH54
         ZBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682926504; x=1685518504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wQrzKEZuX3/5Eef7KYCRXhJKEAjq0AaAjZ6GxmmUQA=;
        b=aermwUC72NYM4R4LTsfwV+CwhzLZkd/UVg3e6YGW8mYlXFD6CioZeUW1aLd1EoZCoJ
         TD3AInA5fzqlOkrTo+IG0bNz26FFfl3lsfqg85S3Vao5srjVHb9nob2CrQCScXPd9CrN
         QBpyUnrSdg893/vT3Fc4gGmzYSVVT+kTvUC7MUx/LFDn+OSVUBIgysm8xOaztep8CeF2
         pHCkBOIQFyIz2BKGDmkmpAk5drr7skoxVNq/cSOz7LC/5QnyELPRWQnp7dyQKVtUOchE
         Tt/dIQYicMHuLCIrHNpRgQmwSXTscg2CzePslgGh9olqE2oYLrY4X83Caelu5lgkQnNf
         6lWA==
X-Gm-Message-State: AC+VfDx4E11CZYNhhtkOMb54XEho3BAjlKx6B7H1rI74quBDmlZ/EXSO
        n731pjGQXHhkgQhqOXL0F841kA==
X-Google-Smtp-Source: ACHHUZ5t9aChF+EmTsZGawIyA2f+eNOqT6Sz8TCl4+O9Y7OcJ6pgRQb4NvOOcYnrIyx8drmrmh/Wnw==
X-Received: by 2002:a17:90b:954:b0:24d:fb2c:1ae0 with SMTP id dw20-20020a17090b095400b0024dfb2c1ae0mr2722814pjb.17.1682926503957;
        Mon, 01 May 2023 00:35:03 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.135])
        by smtp.gmail.com with ESMTPSA id h24-20020a17090adb9800b0024df0e14479sm2013816pjv.5.2023.05.01.00.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 00:35:03 -0700 (PDT)
Date:   Mon, 1 May 2023 15:34:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, coresight@lists.linaro.org,
        shy828301@gmail.com, denik@google.com,
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
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] perf: cs-etm: Validate options after applying
 themperf_pmu__format_bits
Message-ID: <20230501073452.GA4660@leoy-yangtze.lan>
References: <20230424134748.228137-1-james.clark@arm.com>
 <20230424134748.228137-5-james.clark@arm.com>
 <20230427151228.GA152865@leoy-huanghe>
 <dac76dd5-d5f0-61dd-fafe-f939f1ebc413@arm.com>
 <20230427221047.GA174797@leoy-huanghe>
 <15217b55-8a80-fbe9-7b7f-997939f42d0d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15217b55-8a80-fbe9-7b7f-997939f42d0d@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Apr 28, 2023 at 01:33:16PM +0100, James Clark wrote:

[...]

> > ETMv4 uses 'contextid' as well, since the user space needs to know which
> > exception level's PID should be traced, e.g. when CPU runs in EL2
> > 'contextid' is set as ETM_OPT_CTXTID2, the perf tool will set 'contextid2'
> > to tell driver to trace CONTEXTIDR_EL2.
> > 
> 
> That's still working because it reads the config term in the setup
> function rather than setting any one bit manually:
> 
>   if (!perf_cpu_map__empty(cpus)) {
>     evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>                                "timestamp", 1);
>     evsel__set_config_if_unset(cs_etm_pmu, cs_etm_evsel,
>                                "contextid", 1);
>   }

Okay, yeah, this change can set CTXTID or CTXTID2 bit if user doesn't
set anything.

> > We can only verify 'contextid', and set 'contextid1' or 'contextid2' based
> > on CPU running exception level, finally driver knows how to trace PID.
> > 
> > Thanks,
> > Leo
> > 
> 
> I'm not 100% sure what you mean by this. But previously the validation
> was looking at both contextid1 and contextid2 options and checking if
> either were supported if either were set.
> 
> I have the following change in mind, it fixes the backwards
> compatibility issue. And the validation should be exactly the same as it
> was before. Except for one bug that I found when both bits are requested
> which I've also fixed here:
> 
> From f1b9f56df29dfb4f2a7be25f009c79c86335587a Mon Sep 17 00:00:00 2001
> From: James Clark <james.clark@arm.com>
> Date: Fri, 28 Apr 2023 10:29:52 +0100
> Subject: [PATCH] perf cs-etm: Fix contextid validation
> 
> Pre 5.11 kernels don't support 'contextid1' and 'contextid2' so
> validation would be skipped. By adding an additional check for
> 'contextid', old kernels will still have validation done even though
> contextid would either be contextid1 or contextid2.
> 
> Additionally now that it's possible to override options, an existing bug
> in the validation is revealed. 'val' is overwritten by the contextid1
> validation, and re-used for contextid2 validation causing it to always
> fail. '!val || val != 0x4' is the same as 'val != 0x4' because 0 is also
> != 4, so that expression can be simplified and the temp variable not
> overwritten.
> 
> Fixes: 35c51f83dd1e ("perf cs-etm: Validate options after applying them")
> Signed-off-by: James Clark <james.clark@arm.com>

LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org

Thanks for the fixing!

> ---
>  tools/perf/arch/arm/util/cs-etm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 77cb03e6ff87..9ca040bfb1aa 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -78,9 +78,9 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>  	char path[PATH_MAX];
>  	int err;
>  	u32 val;
> -	u64 contextid =
> -		evsel->core.attr.config &
> -		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
> +	u64 contextid = evsel->core.attr.config &
> +		(perf_pmu__format_bits(&cs_etm_pmu->format, "contextid") |
> +		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid1") |
>  		 perf_pmu__format_bits(&cs_etm_pmu->format, "contextid2"));
>  
>  	if (!contextid)
> @@ -114,8 +114,7 @@ static int cs_etm_validate_context_id(struct auxtrace_record *itr,
>  		 *  0b00100 Maximum of 32-bit Context ID size.
>  		 *  All other values are reserved.
>  		 */
> -		val = BMVAL(val, 5, 9);
> -		if (!val || val != 0x4) {
> +		if (BMVAL(val, 5, 9) != 0x4) {
>  			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
>  			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>  			return -EINVAL;
> -- 
> 2.34.1
