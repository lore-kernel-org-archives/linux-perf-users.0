Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65ABC7618A
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 08:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCTIGk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCTIGj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 04:06:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E73314EA9;
        Mon, 20 Mar 2023 01:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679299598; x=1710835598;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LX4bHunO8Bs/+FUk6ngKiatmfaFuGolt7aHuneAn7nU=;
  b=VGoLojVD7B6OxfJbaqHx7G7DFA7v/QcdEKlESezILHSMRWa4u/KfVrmT
   Z/6GTKM2G9hfEHGzdh72i4ig7FeNjoSw8y+zor2it++CjB1ZZROH6Op/2
   Uhs7RAKmo7z+MirM6Oybt3CdJl60QVHf1V6Y0KzyhAi4Rx/kD/MHEogge
   laxWkr3iwssRsUriKh9q4Aeae2mFWoImrPNgRbNCCe5fz/wm2K9CYQUoD
   T4ZyFcwNcEOjqYhsBoT3iVeh7gn5wGDBUpv5NbqHHG6yWW0MgWlqOXCkL
   B6h+8NVXkXElU6Y+n4D88N02j7E5JWY9pfu8TiYqgQLmH0SVfWeV7qkZw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="403471360"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="403471360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 01:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="683372338"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="683372338"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.182])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 01:06:28 -0700
Message-ID: <58d0eb4c-5c58-5ff3-ee26-130247244df7@intel.com>
Date:   Mon, 20 Mar 2023 10:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v4 04/22] perf test: Fix memory leak in symbols
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>
References: <20230320033810.980165-1-irogers@google.com>
 <20230320033810.980165-5-irogers@google.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230320033810.980165-5-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/03/23 05:37, Ian Rogers wrote:
> machine__delete doesn't delete threads.

Which begs the question: Shouldn't it?

>                                         Add call to delete threads
> ahead of deleting the machine.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/symbols.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> index 057b16df6416..0793f8f419e2 100644
> --- a/tools/perf/tests/symbols.c
> +++ b/tools/perf/tests/symbols.c
> @@ -38,6 +38,7 @@ static int init_test_info(struct test_info *ti)
>  static void exit_test_info(struct test_info *ti)
>  {
>  	thread__put(ti->thread);
> +	machine__delete_threads(ti->machine);
>  	machine__delete(ti->machine);
>  }
>  

