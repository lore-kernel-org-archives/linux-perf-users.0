Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81612C83F37
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 18:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbjHaSdC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbjHaSdA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 14:33:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11610E9;
        Thu, 31 Aug 2023 11:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693506759; x=1725042759;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=6NBysbEDPd7/m/e1FL9aRowoioDdr6R8vovTyHsXtmo=;
  b=OWmSdTxb8rP+eO7gXVZEQU9Eetnr5KQmzE6liQSz1UgXRC5eWU3R5R21
   OmKBrkpvNFXropIkSqZ2kPHzVk5wNRVjo9bi34AQGSI3kyGjd86ILOtzT
   wIXWfeVdRvtAuvY/ZFvptPM8yTj4Et7WBpe9iXdbYJz6KZKB/cKZXQljT
   7gqzNedUHC9xjGehkBFLweuP5FBt+3fBM31RjTEeWQOuAfJJhjmbMG4/x
   E5z7juTdKI1HlI0hjPpMm4B2UBhjT3+7Q/3cGP2DyDOLrgcO36wUHRydi
   /LBv13Wk9NRhm4RqG1vcb+OZ6Fc5iXXQlaiN7oMmiuv8XDaYphgYYb37v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407024840"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="407024840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:32:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854379386"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="854379386"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:32:38 -0700
Received: from [10.212.25.104] (kliang2-mobl1.ccr.corp.intel.com [10.212.25.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B4BF3580ABF;
        Thu, 31 Aug 2023 11:32:36 -0700 (PDT)
Message-ID: <3eda8956-f131-3772-1df5-c7c0fb7335f9@linux.intel.com>
Date:   Thu, 31 Aug 2023 14:32:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] perf parse-events: Minor help message improvements
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230830070753.1821629-1-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230830070753.1821629-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


The other thread address the only issue I found when I tested the patch
series on a hybrid machine.
https://lore.kernel.org/lkml/c2affcc9-468f-bf4c-a080-65b31e05a83f@linux.intel.com/

The patch series looks good.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

On 2023-08-30 3:07 a.m., Ian Rogers wrote:
> Be more specific and fix a typo.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 3a9d4e2513b5..4a370c36a0d5 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -342,7 +342,7 @@ PE_NAME opt_pmu_config
>  			struct parse_events_error *error = parse_state->error;
>  			char *help;
>  
> -			if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
> +			if (asprintf(&help, "Unable to find PMU or event on a PMU of '%s'", $1) < 0)
>  				help = NULL;
>  			parse_events_error__handle(error, @1.first_column,
>  						   strdup("Bad event or PMU"),
> @@ -368,7 +368,7 @@ PE_NAME sep_dc
>  		struct parse_events_error *error = parse_state->error;
>  		char *help;
>  
> -		if (asprintf(&help, "Unabled to find PMU or event on a PMU of '%s'", $1) < 0)
> +		if (asprintf(&help, "Unable to find event on a PMU of '%s'", $1) < 0)
>  			help = NULL;
>  		parse_events_error__handle(error, @1.first_column, strdup("Bad event name"), help);
>  		free($1);
