Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF2DC4708F
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EECB9613AE
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 11:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFBLWc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 07:22:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:44699 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhFBLWc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 07:22:32 -0400
IronPort-SDR: yRXCL5WybYVQ8m/h1msb1SZ+vVQYyLzU5V8sCqZguFmu5+igSSmV2bmvyhxKWY2bZa5XUurZ4u
 ZXgo+KvO9g0g==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="267636760"
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="267636760"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 04:20:49 -0700
IronPort-SDR: 4m0gHXhGvtUJ1qswUHHxLfFeUPjV8wDPYc6Muh1nqT8FTFRUcP7OzZQmHFhf8RLKScCzNbSImJ
 CTLA0JZuG18Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,242,1616482800"; 
   d="scan'208";a="479673306"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2021 04:20:44 -0700
Subject: Re: [PATCH v2 6/8] perf auxtrace: Drop legacy __sync functions
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-7-leo.yan@linaro.org>
 <fc7bfa25-d96e-ea6d-2756-f94653dc4771@intel.com>
 <20210602111620.GD10272@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d179137e-4bbc-0026-3273-622f6dedb002@intel.com>
Date:   Wed, 2 Jun 2021 14:21:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602111620.GD10272@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2/06/21 2:16 pm, Leo Yan wrote:
> Hi Adrian,
> 
> On Wed, Jun 02, 2021 at 01:47:42PM +0300, Adrian Hunter wrote:
> 
> [...]
> 
>>> @@ -451,11 +445,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
>>>  static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
>>>  {
>>>  	struct perf_event_mmap_page *pc = mm->userpg;
>>> -#if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
>>
>> The test and setup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT is not needed anymore either.
> 
> Yes, I think there have two files should be cleaned:
> 
>   Makefile.config
>   util/auxtrace.c
> 
> If still miss anything, please let me know (I remembered there have a
> test case for __sync_xxx_compare_and_swap, but I cannot find it now,
> so this is why I am concern if I miss anything not).

tools/build/feature/test-sync-compare-and-swap.c
