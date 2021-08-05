Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EDBC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 05:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B24D60F94
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 05:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhHEFnQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 01:43:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:17661 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhHEFnQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 01:43:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="214105164"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="214105164"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 22:43:01 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="512542713"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 22:42:58 -0700
Subject: Re: [PATCH v3] perf vendor events: Add metrics for Icelake Server
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210721070702.2075-1-yao.jin@linux.intel.com>
 <2811bea3-4589-2f76-83b4-83b91f4db1c6@linux.intel.com>
 <85e07b9a-c826-b4cc-188a-4e735d7342bc@linux.intel.com>
 <CAP-5=fUGzso7f2rGG5_YkuOr72qY5EmkckDsayb47vLHxhJ9FQ@mail.gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1838b532-19b4-6f92-0057-d71bfa740a3c@linux.intel.com>
Date:   Thu, 5 Aug 2021 13:42:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAP-5=fUGzso7f2rGG5_YkuOr72qY5EmkckDsayb47vLHxhJ9FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian,

On 8/5/2021 1:09 PM, Ian Rogers wrote:
> Hi,
> 
> I'm not sure what's happening but when I generate this using:
> https://github.com/intel/event-converter-for-linux-perf
> 
> I see here:
>          "MetricExpr": "1 / IPC",
> 
> There are various other differences and so I've included the generated file.
> 
> Thanks,
> Ian

Please see following commit in event-converter-for-linux-perf repo.

commit b2265b953d57130a2ad8255d126bb69cf8552898
Author: Jin Yao <yao.jin@linux.intel.com>
Date:   Thu Jun 3 09:57:01 2021 +0800

     Don't expand inner metric if possible

     Before:

         {
             "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
             "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
             "MetricGroup": "Pipeline",
             "MetricName": "CPI"
         },

     After:

         {
             "MetricExpr": "1 / IPC",
             "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
             "MetricGroup": "Pipeline",
             "MetricName": "CPI"
         },

     We also provide a new option '--expr-events' for checking if it's a complex
     metric. For a simple metric, we probablly don't need to reuse the inner
     metric. For a complex metric, it's useful to reuse the inner metric.

I enable the option '--expr-events' when generating the metrics JSON. Since CPI is a simple metric, 
so the inner metric is still expanded.

For cstate metrics, only Core C1/C6 and Package C2/C6 are supported for ICX. The cstate metrics are 
appended manually right now.

Thanks
Jin Yao
