Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF3C07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 03:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD16E60200
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 03:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhGUC27 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 22:28:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:40963 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232187AbhGUC24 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 22:28:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="296924415"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="296924415"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 20:08:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="501122354"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 20:08:02 -0700
Subject: Re: [PATCH] perf pmu: Fix alias matching
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org, kjain@linux.ibm.com,
        alexander.shishkin@linux.intel.com, irogers@google.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
Date:   Wed, 21 Jul 2021 11:07:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Garry,

On 7/20/2021 11:10 PM, John Garry wrote:
> Commit c47a5599eda32 ("perf tools: Fix pattern matching for same substring
> in different PMU type"), may have fixed some alias matching, but has broken
> some others.
> 
> Firstly it cannot handle the simple scenario of PMU name in form
> pmu_name{digits} - it can only handle pmu_name_{digits}.
> 
> Secondly it cannot handle more complex matching in the case where we have
> multiple tokens. In this scenario, the code failed to realise that we
> may examine multiple substrings in the PMU name.
> 
> Fix in two ways:
> - Change perf_pmu__valid_suffix() to accept a PMU name without '_' in the
>    suffix
> - Only pay attention to perf_pmu__valid_suffix() for the final token
> 
> Also add const qualifiers as necessary to avoid casting.
> 
> Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same substring in different PMU type")
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> @Jin Yao, please test for your scenarios
> 

For x86, the form uncore_pmu_{digits} or the uncore_pmu itself are supported. We don't have more 
complex case such as the name in the form aaa_bbbX_cccY. So my test didn't cover that complex form.

For my test, your patch works, thanks! :)

> Note:
> About any effect in perf_pmu__match() -> perf_pmu__valid_suffix()
> callchain, this seems to be called for wildcard in PMU names in metric
> expressions. We don't have any metrics for arm64 which use feature.
> However, I hacked an existing metric to use a wildcard and it looks ok.
> Also the "DRAM_BW_Use" metric on my broadwell uses this feature, and it
> looks ok.
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index a1bd7007a8b4..fc683bc41715 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -742,9 +742,13 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
>   	return perf_pmu__find_map(NULL);
>   }
>   
> -static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
> +/*
> + * Suffix must be in form tok_{digits}, or tok{digits}, or same as pmu_name
> + * to be valid.
> + */
> +static bool perf_pmu__valid_suffix(const char *pmu_name, char *tok)
>   {
> -	char *p;
> +	const char *p;
>   
>   	if (strncmp(pmu_name, tok, strlen(tok)))
>   		return false;
> @@ -753,12 +757,16 @@ static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
>   	if (*p == 0)
>   		return true;
>   
> -	if (*p != '_')
> -		return false;
> +	if (*p == '_')
> +		++p;
>   
> -	++p;
> -	if (*p == 0 || !isdigit(*p))
> -		return false;
> +	/* Ensure we end in a number */
> +	while (1) {
> +		if (!isdigit(*p))
> +			return false;
> +		if (*(++p) == 0)
> +			break;
> +	}
>   

Do we check *p before first isdigit? For example,

if (*p == 0)
	return false;

While (*p) {
	if (!isdigit(*p)
		return false;
	++p;
}

But maybe isdigit can handle the null string well. I'm just feeling a bit unsure.

>   	return true;
>   }
> @@ -789,12 +797,19 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>   	 *	    match "socket" in "socketX_pmunameY" and then "pmuname" in
>   	 *	    "pmunameY".
>   	 */
> -	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
> +	while (1) {
> +		char *next_tok = strtok_r(NULL, ",", &tmp);
> +
>   		name = strstr(name, tok);
> -		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
> +		if (!name ||
> +		    (!next_tok && !perf_pmu__valid_suffix(name, tok))) {
>   			res = false;
>   			goto out;
>   		}
> +		if (!next_tok)
> +			break;
> +		tok = next_tok;
> +		name += strlen(tok);
>   	}
>   
>   	res = true;
> 

My test didn't cover the tokens which were delimited by ','. I assume you have tested that on arm64 
system. :)

Thanks
Jin Yao
