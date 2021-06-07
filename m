Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9566FC47082
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 10:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEC611C0
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Jun 2021 10:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFGKZX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:25:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:1083 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFGKZW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Jun 2021 06:25:22 -0400
IronPort-SDR: 2zjjMgRhiUzi/VvT3pcdxuW4VTv/NCsVMBYMb8Zb++SupHjsnnoRhMXlN8RFtDHjTOuFvb9ubA
 WmQWv/TEN2Uw==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="265750749"
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="265750749"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 03:23:30 -0700
IronPort-SDR: 6KMKnIbtqCdKX6P8IKQCGifSJPd27S+5hs7Sg2E/hDInGVq3EvHkHIlOxuDoyPdh33ib2f0jAL
 Tl6R3qQTFOqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,254,1616482800"; 
   d="scan'208";a="484727860"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2021 03:23:25 -0700
Subject: Re: [PATCH v2 8/8] perf record: Directly bail out for compat case
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
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
 <20210602123847.GE10272@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <96e5fac6-17a2-ea03-9b15-338b84321ecf@intel.com>
Date:   Mon, 7 Jun 2021 13:23:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602123847.GE10272@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2/06/21 3:38 pm, Leo Yan wrote:
> Hi Adrain,
> 
> On Wed, Jun 02, 2021 at 02:18:47PM +0300, Adrian Hunter wrote:
>> On 2/06/21 1:30 pm, Leo Yan wrote:
>>> Since the 64-bit atomicity is not promised in 32-bit perf, directly
>>> report the error and bail out for this case.
>>>
>>> Now only applies on x86_64 and Arm64 platforms.
>>>
>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>
>> Maybe we can do better for the compat case.
>>
>> We can assume the upper 32-bits change very seldom,
>> and always increase. So for the 'read' case:
>>
>> 	u64 first, second, last;
>> 	u64 mask = (u64)((u32)-1) << 32;
>>
>> 	do {
>> 		first = READ_ONCE(pc->aux_head);
>> 		rmb();
>> 		second = READ_ONCE(pc->aux_head);
>> 		rmb();
>> 		last = READ_ONCE(pc->aux_head);
>> 	} while ((first & mask) != (last & mask));
>> 	return second;
>>
>> For the write case, we can cause a fatal error only if the new
>> tail has non-zero upper 32-bits.  That gives up to 4GiB of data
>> before aborting:
>>
>> 	if (tail & mask)
>> 		return -1;
>> 	smp_mb();
>> 	WRITE_ONCE(pc->aux_tail, tail);
> 
> Seems to me, it's pointless to only support aux_head for 64-bit and
> support aux_tail for 32-bit.  I understand this can be helpful for the
> snapshot mode which only uses aux_head, but it still fails to support
> the normal case for AUX ring buffer using 64-bit head/tail.

I am not sure why you say it is pointless.  'perf record' would still be
able to capture up to 4GiB of data. Do you mean you usually capture more
than 4GiB of data?

I was thinking we would separate out the compat case:

#if BITS_PER_LONG == 32
	if (kernel_is_64_bit)
		return compat_auxtrace_mmap__[read_head/write_tail]()
#endif

So the non-compat cases would not be affected.
