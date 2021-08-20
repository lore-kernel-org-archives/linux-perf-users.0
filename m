Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057EC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 12:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B363F610CA
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 12:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbhHTM3r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:29:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:31979 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240262AbhHTM3q (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 08:29:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="216799037"
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="216799037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 05:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,337,1620716400"; 
   d="scan'208";a="680077110"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga006.fm.intel.com with ESMTP; 20 Aug 2021 05:29:03 -0700
Subject: Re: [PATCH] perf tests: dlfilter: free desc and long_desc in
 check_filter_desc
To:     Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210820113132.724034-1-rickyman7@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1c426e33-d918-23d4-59ca-b96071491933@intel.com>
Date:   Fri, 20 Aug 2021 15:29:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820113132.724034-1-rickyman7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/08/21 2:31 pm, Riccardo Mancini wrote:
> In dlfilter-test, the function check_filter_desc calls get_filter_desc
> which allocates desc and long_desc.
> However, these variables are never deallocated.
> 
> This patch adds the missing frees.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: 9f9c9a8de2d5e96c ("perf tests: Add dlfilter test")
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/tests/dlfilter-test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
> index 7eba7955d53154e1..bc03b5df6828d6fa 100644
> --- a/tools/perf/tests/dlfilter-test.c
> +++ b/tools/perf/tests/dlfilter-test.c
> @@ -239,15 +239,20 @@ static int get_dlfilters_path(char *buf, size_t sz)
>  
>  static int check_filter_desc(struct test_data *td)
>  {
> -	char *long_desc;
> -	char *desc;
> +	char *long_desc = NULL;
> +	char *desc = NULL;
> +	int ret;
>  
>  	if (get_filter_desc(td->dlfilters, "dlfilter-test-api-v0.so", &desc, &long_desc) &&
>  	    long_desc && !strcmp(long_desc, "Filter used by the 'dlfilter C API' perf test") &&
>  	    desc && !strcmp(desc, "dlfilter to test v0 C API"))
> -		return 0;
> +		ret = 0;
> +	else
> +		ret = -1;
>  
> -	return -1;
> +	free(desc);
> +	free(long_desc);
> +	return ret;
>  }
>  
>  static int get_ip_addr(struct test_data *td)
> 

