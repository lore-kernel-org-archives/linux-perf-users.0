Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D79C433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 13:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439ED60E0B
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 13:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbhD1NRL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 09:17:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:5634 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhD1NRL (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 09:17:11 -0400
IronPort-SDR: SzV/G+6mgLhE+ThIPlqbSQH9GeUnABbZGTpyTu0CFl6L/G9rQFEqOp40hwnHcDlZivnH9583ih
 Zo/m4y/+GgnA==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="196291593"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="196291593"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 06:16:26 -0700
IronPort-SDR: XWgVG/CwpmqKGAnEwM8j+fatDehBexOHhlV97a9IDvGlsPLycx7h5J8HQMFP5o6gZ6oonAzfbC
 GKB95FicqMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="403677600"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2021 06:16:22 -0700
Subject: Re: [PATCH v3 1/4] perf tool: Change fields type in
 perf_record_time_conv
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210428120915.7123-1-leo.yan@linaro.org>
 <20210428120915.7123-2-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a3bcac42-f268-fe65-b871-3d5e3718a30b@intel.com>
Date:   Wed, 28 Apr 2021 16:16:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428120915.7123-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/04/21 3:09 pm, Leo Yan wrote:
> C standard claims "An object declared as type _Bool is large enough to
> store the values 0 and 1", bool type size can be 1 byte or larger than
> 1 byte.  Thus it's uncertian for bool type size with different
> compilers.
> 
> This patch changes the bool type in structure perf_record_time_conv to
> __u8 type, and pads extra bytes for 8-byte alignment; this can give
> reliable structure size.
> 
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/lib/perf/include/perf/event.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
> index d82054225fcc..48583e441d9b 100644
> --- a/tools/lib/perf/include/perf/event.h
> +++ b/tools/lib/perf/include/perf/event.h
> @@ -346,8 +346,9 @@ struct perf_record_time_conv {
>  	__u64			 time_zero;
>  	__u64			 time_cycles;
>  	__u64			 time_mask;
> -	bool			 cap_user_time_zero;
> -	bool			 cap_user_time_short;
> +	__u8			 cap_user_time_zero;
> +	__u8			 cap_user_time_short;
> +	__u8			 reserved[6];	/* For alignment */
>  };
>  
>  struct perf_record_header_feature {
> 

