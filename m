Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F003D7D8D
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781213; cv=none; b=p+LNI2lM9y8Hy9ovsdlMK+xJaZvEhArYsW0Tce3LSPX66kij17JhgezlC4ZSTYCX3SB1up1Is8QNwSg8TDim6DmtJf1UMGxlCOKhbmynQf+USOGquNPjth7j7aX1u5wtnfYrmnODj4U4TiNxVIqhgjjUb8jES0jUmS2xskz1dY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781213; c=relaxed/simple;
	bh=5IB9lqw+mz6Tskyz56EWlWJxPelFuW+MU16QzNSfeRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oSl08vPYnzLKuw8lS9KVDtx0FB2yU+LFF7Le1uu5NBJVJvJVkbbpJEq4GumSgaD2gdM8dg2u66aiwYEj0hE/SgskS4MtzL5O2joH6gv9btJ2Wux1XqigGp5d9yCgMit7iKdzBaRIWUmuqbdJ/5y7fDoC76PNr0ttgv5FHrRilgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jk5jK2dj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jk5jK2dj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso49337485e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776781210; x=1777386010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gWWMZ/XGb+roMC5rDdb0/e8GJ+Anq2iEJhqHT77U8c=;
        b=jk5jK2djtxuFJ2tTg0nN6FqNmD/GaeVmZQGlx7IKcfUE4Zbq3ZKmGeIemW5be+c9mg
         kEtjqtdjYmhq/jJnHPBnH66Tpgdd1fcznk68ahS06I6Ji7RhwIJal4TMuqKdM85vzIvu
         JQ4DQUSbqbuejOLhd62MLNdvsAPNrwGFLjNPIW37VR6BYCHicjJbnOxloipSOz2Dj/yt
         lpCgjGDO/MYo1pf5Xl2pzQX3n4lJyPHMYzyLHwNnJgBS1RhlHHS06hPSrDU3g8tjoNTe
         ZrGJyVl9rxKEyQA4bbI7OOXO9ZHSZV7/xCsY3kn2x7FTXMiHZrx07kXvvLEfq73PyONU
         lk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781210; x=1777386010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gWWMZ/XGb+roMC5rDdb0/e8GJ+Anq2iEJhqHT77U8c=;
        b=OVfw+fdJi5SwVbGvKJvEiMXOGJzZk8dx0fYevh5B1fVuKBOkpCrjzs6HOWZoWp9bBg
         3m+Ifc0fxyKdrqWssE2hpUGhUfZFXnPGY923LZcAJyOo/f6Ti8pmxXsS6eHQwgt/mmTX
         JDiDOL6+nofoPrKYx3i2L7LYSAGE0pXRrWUoQ2Sc0bKE4hpNHmnqijxC5ahBlm4ppLh+
         eaJ2W+qS9U9sFJqu3g7ps15csznWR2DWXS9yuE4DUFvrLLlFH/+zDsDx/X65R7+LsqIj
         Wc+kzdYNpIEPMKpDRH3uIL8X7pEcCYuOPr5x19ISbIreWgiRsgfVmFxt78tQrsIJK8mV
         exNw==
X-Gm-Message-State: AOJu0YwWcg8pOokGdNhbeym8XXG2NEHoQ+MnE0XgZXvGOPoLhanw9iWD
	+Wt6TSmbhuZ+pVCZBawrxXg7qKBQXj28uZrittwi2SR8Nx9pAq/cMs7Cpt7bgZv4ikc=
X-Gm-Gg: AeBDievzm3PqBZk9VsiwBGxkuyeI6GjFMAn3DfIgOrovNbpq2CyhCTaLGK3MRbZtxuF
	lhRL+IhQceQhpIsJcrUbydgBITzprP5KcZKZtp7gN4+7xF3qqFZcyJV4Yb9vtQ37q7u4bREaAQr
	3uZ114OaofesDu6kjH13rEVdywyNTsXrdmfkVzSwHkOFYPQG42tcSBKPxs0EoKDz+5qlo3RoBWk
	rFDizjFmKJO9CGhk2oKYPlALDp4Z4RQGkwNK/0d5aLUgZntaHOIzM/U5rWhrT9p/4+XOp8sYrG/
	WSU7yxp9qZ9/rJQn+/lVn1ZXHDz3Z5s9okx0ZpN2+8UkdZhdQAZdxXdH+KEXP50uzQotrB70Qq0
	SpPCfyS3twupSnPokt784/MXM5KBOYgLR/rz3EisIVERksICTSC5s2CMvVvFdWxgNVmO5pSl0Hh
	DXaAfiNhY/ogcxoOd7lSn2G8GLykz5rjOfncNcW4Dm688=
X-Received: by 2002:a05:600c:1d86:b0:48a:53ea:1405 with SMTP id 5b1f17b1804b1-48a53ea14f5mr68676215e9.12.1776781210113;
        Tue, 21 Apr 2026 07:20:10 -0700 (PDT)
Received: from [192.168.178.64] ([84.246.200.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1393f5sm348999685e9.9.2026.04.21.07.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:20:09 -0700 (PDT)
Message-ID: <98ddaa65-747a-4b3e-9f72-05b90fc4eadb@linaro.org>
Date: Tue, 21 Apr 2026 15:20:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf pmu: Skip test on Arm64 when #slots is zero
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260410-perf_fix_pmu_metrics_test-v2-1-61826ab3ca8b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/04/2026 12:13, Leo Yan wrote:
> Some Arm64 PMUs expose 'caps/slots' as 0 when the slot count is not
> implemented, tool_pmu__read_event() currently returns false for this,
> so metrics that reference #slots are reported as syntax error.
> 
> Since the commit 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax
> error in expr__find_ids()"), these syntax errors are populated as
> failures and make the PMU metric test fail:
> 
>      9.3: Parsing of PMU event table metrics:
>      --- start ---
>      ...
> 
>      Found metric 'backend_bound'
>      metric expr 100 * (stall_slot_backend / (#slots * cpu_cycles)) for backend_bound
>      parsing metric: 100 * (stall_slot_backend / (#slots * cpu_cycles))
>      Failure to read '#slots'
>      literal: #slots = nan
>      syntax error
>      Fail to parse metric or group `backend_bound'
> 
>      ...
>      ---- end(-1) ----
>      9.3: Parsing of PMU event table metrics    : FAILED!
> 
> This commit introduces a new function is_expected_broken_metric() to
> identify broken metrics, and treats metrics containing "#slots" as
> expected broken when #slots == 0 on Arm64 platforms.
> 
> Fixes: 3a61fd866ef9 ("perf expr: Return -EINVAL for syntax error in expr__find_ids()")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
> Changes in v2:
> - Checked pm->metric_expr instead of pm->metric_name and removed the
>    negation before strstr() suggested by sashiko.
> - Link to v1: https://lore.kernel.org/r/20260410-perf_fix_pmu_metrics_test-v1-1-18a5d80f71b6@arm.com
> ---
>   tools/perf/tests/pmu-events.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index a997168621688007c85495e2d9f6f459c2471516..b1609a7e1d8c9427e6bf9500380e8aac6167c7fa 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -15,6 +15,7 @@
>   #include "util/expr.h"
>   #include "util/hashmap.h"
>   #include "util/parse-events.h"
> +#include "util/tool_pmu.h"
>   #include "metricgroup.h"
>   #include "stat.h"
>   
> @@ -817,6 +818,26 @@ struct metric {
>   	struct metric_ref metric_ref;
>   };
>   
> +static bool is_expected_broken_metric(const struct pmu_metric *pm)
> +{
> +	if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
> +	    !strcmp(pm->metric_name, "M3"))
> +		return true;
> +
> +#if defined(__aarch64__)
> +	/*
> +	 * Arm64 platforms may return "#slots == 0", which is treated as a
> +	 * syntax error by the parser. Don't test these metrics when running
> +	 * on such platforms.
> +	 */
> +	if (strstr(pm->metric_expr, "#slots") &&
> +	    !tool_pmu__cpu_slots_per_cycle())
> +		return true;
> +#endif
> +
> +	return false;
> +}
> +
>   static int test__parsing_callback(const struct pmu_metric *pm,
>   				  const struct pmu_metrics_table *table,
>   				  void *data)
> @@ -852,8 +873,7 @@ static int test__parsing_callback(const struct pmu_metric *pm,
>   
>   	err = metricgroup__parse_groups_test(evlist, table, pm->metric_name);
>   	if (err) {
> -		if (!strcmp(pm->metric_name, "M1") || !strcmp(pm->metric_name, "M2") ||
> -		    !strcmp(pm->metric_name, "M3")) {
> +		if (is_expected_broken_metric(pm)) {
>   			(*failures)--;
>   			pr_debug("Expected broken metric %s skipping\n", pm->metric_name);
>   			err = 0;
> 
> ---
> base-commit: 4cf1f549bbcdfea9c20df52994bb342677472dcd
> change-id: 20260408-perf_fix_pmu_metrics_test-73c4dedc8585
> 
> Best regards,

