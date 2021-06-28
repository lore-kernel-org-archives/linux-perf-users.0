Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A53C11F66
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3E661C93
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Jun 2021 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhF1Tch (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 15:32:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:1186 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236553AbhF1Tcf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Jun 2021 15:32:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="188399721"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="188399721"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:30:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="419287684"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2021 12:30:05 -0700
Subject: Re: [PATCH V2 00/10] perf script: Add API for filtering via
 dynamically loaded shared object
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210627131818.810-1-adrian.hunter@intel.com>
 <e2a57ee8-6489-40d5-04d0-7d985eba961f@linux.intel.com>
 <ea9a04ad-26b2-7072-9f45-9ddbd8f61c10@intel.com>
 <65fc17a8-cefa-f7a8-8ffc-8ef88b773991@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4e94511d-858b-bd46-add8-cb525be4875b@intel.com>
Date:   Mon, 28 Jun 2021 22:30:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <65fc17a8-cefa-f7a8-8ffc-8ef88b773991@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/06/21 5:57 pm, Andi Kleen wrote:
> 
> On 6/28/2021 12:23 AM, Adrian Hunter wrote:
>> On 27/06/21 7:13 pm, Andi Kleen wrote:
>>> On 6/27/2021 6:18 AM, Adrian Hunter wrote:
>>>> Hi In some cases, users want to filter very large amounts of data
>>>> (e.g. from AUX area tracing like Intel PT) looking for something
>>>> specific. While scripting such as Python can be used, Python is 10
>>>> to 20 times slower than C. So define a C API so that custom filters
>>>> can be written and loaded.
>>> While I appreciate this for complex cases, in my experience filtering
>>> is usually just a simple expression. It would be nice to also have a
>>> way to do this reasonably fast without having to write a custom C
>> I do not agree that writing C filters is a hassle e.g. a minimal do-nothing
>> filter is only a few lines:
> 
> It still doesn't seem user friendly. Maybe it's obvious to you, but I suspect we left behind most of even the sophisticated perf users here.
> 

Fair enough.

> 
>>
>>>                   Maybe we could have some kind of python fast path
>>> just for filters?
>> I expect there are ways to make it more efficient, but I doubt it would ever
>> come close to C.
> 
> If it's within 2-3x I guess it would be ok. For any larger data files we should parallelize anyways, and that works fine with the --time x/y method (although it usually also needs some custom scripting, perhaps need to figure out how to make it more user friendly)

I am not sure Python could do that, maybe something else.

Parallelization is on the list of things to do.  Splitting by time is OK but gets trickier if you want to put the results back together in time order.  Also call chains get broken at the splits in time.

> 
> 
>>
>>> just for filters? Or maybe the alternative would be to have a
>>> frontend in perf that can automatically generate/compile such a C
>>> filter based on a simple expression, but I'm not sure if that would
>>> be much simpler.
>> If gcc is available, perf script could, in fact, build the .so on the fly
>> since the compile time is very quick.
>>
>> Another point is that filters can be used for more than just filtering.
>> Here is an example which sums cycles per-cpu and prints them, and the difference
>> to the last print, at the beginning of each line.  I think this was something
>> you were interested in doing?
> 
> Yes that's great and useful, but I would prefer to not maintain custom plugins for it. Often when I write a script it has to run in all kinds of weird environments that some random person installed, and it's not clear how portable building C will be there. And I doubt I can just copy the .so files around.

That is true.  .so files have limitations.

> 
> BTW I'm not arguing to not do the plugin (I can imagine extreme cases where such a plugin is the best option), but really for most of these things there should be easier and more portable alternatives, even if they are slightly slower.

Right.  The documentation could definitely point out limitations and more user-friendly alternatives like using Python scripting.




