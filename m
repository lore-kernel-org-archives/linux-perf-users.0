Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA6C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 24 Nov 2022 02:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiKXCSw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiKXCSv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 21:18:51 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1C27C009;
        Wed, 23 Nov 2022 18:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669256329; x=1700792329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hd/CA+AqpxNj+oylnAnOQIda+Prjkled9nsCoQeGtoc=;
  b=N+D15SLwclRh2eR4RXSyY8zxuZHjm2IQmqCySCX3hmp0iFwDtyZUltqg
   4Rj2tm/O1vhgdSYzxG/4qTPHfhPH7yAF0xS4qjbyHIyTtqhL3IIDmA2vx
   nOoiefsSrUjljQMLbFAjQBsmWpDG+Hhj55TreE8itcMRZclcx+UVmOHDE
   Y68lNd0eWHL/FjjuEUTIQ89K328rA63dZ/tT0ZtZzjTXhOpHygYBU2jGs
   QGJwbz/9YUPAsOR3gTkBOy/memgiq091olYWfPJfg3wrfmJpZak4B7BSn
   WOgMnwf4KtUi/jhzNg5Hi08rdxwe9Yv52gETvKmk/gGBdvA6FaR5KTWCz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="294585009"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="294585009"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 18:18:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="730978517"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="730978517"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.77]) ([10.238.4.77])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 18:18:44 -0800
Message-ID: <41a60078-52c1-92bc-f8c1-178ac8994681@linux.intel.com>
Date:   Thu, 24 Nov 2022 10:18:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/5] perf vendor events intel: Add core event list for
 Alderlake-N
To:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@linux.intel.com
References: <20221121082058.64578-1-zhengjun.xing@linux.intel.com>
 <CAP-5=fUQUe0UvLhaSBnm-dAPHc3_k8vZWNxhZajg8mg6R8og0g@mail.gmail.com>
 <Y34iAVLGAGhVH/ta@kernel.org> <Y34irx0jffj8NXRY@kernel.org>
 <CAP-5=fVKXRcswFAMkTTBHTnvnEErhr0HExJ-HFKLHgZO71cbTw@mail.gmail.com>
Content-Language: en-US
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CAP-5=fVKXRcswFAMkTTBHTnvnEErhr0HExJ-HFKLHgZO71cbTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/24/2022 7:33 AM, Ian Rogers wrote:
> On Wed, Nov 23, 2022 at 5:40 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Wed, Nov 23, 2022 at 10:37:05AM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Mon, Nov 21, 2022 at 01:17:12PM -0800, Ian Rogers escreveu:
>>>> On Mon, Nov 21, 2022 at 12:19 AM <zhengjun.xing@linux.intel.com> wrote:
>>>>>
>>>>> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>>>
>>>>> Alderlake-N only has E-core, it has been moved to non-hybrid code path on
>>>>> the kernel side. Add core event list for Alderlake-N, it is based on the
>>>>> ADL gracemont v1.16 JSON file.
>>>>>
>>>>> https://github.com/intel/perfmon/tree/main/ADL/events/
>>>>>
>>>>> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>>>>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>>>>
>>>> Acked-by: Ian Rogers <irogers@google.com>
>>>
>>> Is this just for 1/5? Or can I stick it to the whole series?
>>
>> But, after applying 1/5 I get:
>>
>>    CC      /tmp/build/perf/util/data-convert-bt.o
>>    CC      /tmp/build/perf/util/data-convert-json.o
>> /tmp/build/perf/pmu-events/pmu-events.c:55354:39: error: ‘pme_alderlaken’ defined but not used [-Werror=unused-const-variable=]
>> 55354 | static const struct compact_pmu_event pme_alderlaken[] = {
>>        |                                       ^~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>> make[3]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
>> make[2]: *** [Makefile.perf:711: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
>> make[2]: *** Waiting for unfinished jobs....
>>    CC      /tmp/build/perf/util/lzma.o
>>    CC      /tmp/build/perf/util/zlib.o
>>    CC      /tmp/build/perf/util/jitdump.o
>>    CC      /tmp/build/perf/util/bpf-event.o
>>    LD      /tmp/build/perf/util/perf-in.o
>>    LD      /tmp/build/perf/perf-in.o
>> make[1]: *** [Makefile.perf:240: sub-make] Error 2
>> make: *** [Makefile:113: install-bin] Error 2
>> make: Leaving directory '/var/home/acme/git/perf/tools/perf'
>>
>>   Performance counter stats for 'make -k BUILD_BPF_SKEL=1 CORESIGHT=1 O=/tmp/build/perf -C tools/perf install-bin':
>>
>>      26,049,918,108      cycles:u
>>      47,580,273,158      instructions:u                   #    1.83  insn per cycle
>>
>>         4.655423698 seconds time elapsed
>>
>>         6.211852000 seconds user
>>         5.060661000 seconds sys
>>
>>
>> ⬢[acme@toolbox perf]$
>>
>> Please fix it and send a v2.
>>
>> - Arnaldo
> 
> Thanks Arnaldo, my acked-by was for the whole series (missing cover
> letter in v2). The mapfile.csv change was reordered in v2, I asked for
> this. I think that change needs squashing into this one to avoid the
> unused case.
> 
> Thanks,
> Ian
The whole series should have no build issue, the issue caused by the 
mapfile .csv changes reordered from 0000 to 0004 in v2, I will merge the 
mapfile.csv changes and this into one patch, and the build issue should 
be fixed.

-- 
Zhengjun Xing
