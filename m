Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B65DC47080
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D8C6138C
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Jun 2021 09:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhFAJJB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Jun 2021 05:09:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:29385 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233505AbhFAJI4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Jun 2021 05:08:56 -0400
IronPort-SDR: Cn/TsQoruwtUJSmJ35EbyHqI9IToNkb8G+iRTegZTMREuyFAZkCMRpwi7DviutWTbfXbN10mG7
 jYqcFgCdZLPA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190622460"
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="190622460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 02:07:13 -0700
IronPort-SDR: 1mj7VSAfwuEOCtvUGdjZroTOsoAYwZDy+fFuRfC4yOFLtUdVoOtHtKyXxcuZ3iFgE/e15GgLwY
 eEZLirFLLkhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,239,1616482800"; 
   d="scan'208";a="482410643"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2021 02:07:10 -0700
Subject: Re: [PATCH v1 2/2] perf auxtrace: Optimize barriers with load-acquire
 and store-release
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210519140319.1673043-1-leo.yan@linaro.org>
 <20210519140319.1673043-2-leo.yan@linaro.org>
 <20210531151049.GE9324@leoy-ThinkPad-X240s>
 <cc3810cd-5edc-26d3-9c77-8bb6479152c1@intel.com>
 <20210601063342.GB10026@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <71b0e395-0e20-fdd1-b105-0ca1706c8ed1@intel.com>
Date:   Tue, 1 Jun 2021 12:07:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210601063342.GB10026@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 1/06/21 9:33 am, Leo Yan wrote:
> On Mon, May 31, 2021 at 10:03:33PM +0300, Adrian Hunter wrote:
>> On 31/05/21 6:10 pm, Leo Yan wrote:
>>> Hi Peter, Adrian,
>>>
>>> On Wed, May 19, 2021 at 10:03:19PM +0800, Leo Yan wrote:
>>>> Load-acquire and store-release are one-way permeable barriers, which can
>>>> be used to guarantee the memory ordering between accessing the buffer
>>>> data and the buffer's head / tail.
>>>>
>>>> This patch optimizes the memory ordering with the load-acquire and
>>>> store-release barriers.
>>>
>>> Is this patch okay for you?
>>>
>>> Besides this patch, I have an extra question.  You could see for
>>> accessing the AUX buffer's head and tail, it also support to use
>>> compiler build-in functions for atomicity accessing:
>>>
>>>   __sync_val_compare_and_swap()
>>>   __sync_bool_compare_and_swap()
>>>
>>> Since now we have READ_ONCE()/WRITE_ONCE(), do you think we still need
>>> to support __sync_xxx_compare_and_swap() atomicity?
>>
>> I don't remember, but it seems to me atomicity is needed only
>> for a 32-bit perf running with a 64-bit kernel.
> 
> 32-bit perf wants to access 64-bit value atomically, I think it tries to
> avoid the issue caused by scenario:
> 
>         CPU0 (64-bit kernel)           CPU1 (32-bit user)
> 
>                                          read head_lo
>         WRITE_ONCE(head)
>                                          read head_hi
> 
> 
> I dumped the disassembly for reading 64-bit value for perf Arm32 and get
> below results:
> 
>   perf Arm32 for READ_ONCE():
> 
> 	case 8: *(__u64_alias_t *) res = *(volatile __u64_alias_t *) p; break;
>      84a:	68fb      	ldr	r3, [r7, #12]
>      84c:	e9d3 2300 	ldrd	r2, r3, [r3]
>      850:	6939      	ldr	r1, [r7, #16]
>      852:	e9c1 2300 	strd	r2, r3, [r1]
>      856:	e007      	b.n	868 <auxtrace_mmap__read_head+0xb0>
> 
> It uses the instruction ldrd which is "Load Register Dual (register)",
> but this doesn't mean the instruction is atomic, especially based on
> the comment in the kernel header include/asm-generic/rwonce.h, I think
> the instruction ldrd/strd will be "atomic in some cases (namely Armv7 +
> LPAE), but for others we rely on the access being split into 2x32-bit
> accesses".
> 
> 
>   perf Arm32 for __sync_val_compare_and_swap():
> 
> 	u64 head = __sync_val_compare_and_swap(&pc->aux_head, 0, 0);
>      7d6:	68fb      	ldr	r3, [r7, #12]
>      7d8:	f503 6484 	add.w	r4, r3, #1056	; 0x420
>      7dc:	f04f 0000 	mov.w	r0, #0
>      7e0:	f04f 0100 	mov.w	r1, #0
>      7e4:	f3bf 8f5b 	dmb	ish
>      7e8:	e8d4 237f 	ldrexd	r2, r3, [r4]
>      7ec:	ea52 0c03 	orrs.w	ip, r2, r3
>      7f0:	d106      	bne.n	800 <auxtrace_mmap__read_head+0x48>
>      7f2:	e8c4 017c 	strexd	ip, r0, r1, [r4]
>      7f6:	f1bc 0f00 	cmp.w	ip, #0
>      7fa:	f1bc 0f00 	cmp.w	ip, #0
>      7fe:	d1f3      	bne.n	7e8 <auxtrace_mmap__read_head+0x30>
>      800:	f3bf 8f5b 	dmb	ish
>      804:	e9c7 2304 	strd	r2, r3, [r7, #16]
> 
> For __sync_val_compare_and_swap(), it uses the instructions
> ldrexd/ldrexd, these two instructions rely on the exclusive monitor
> for accessing 64-bit value, so seems to me this is more reliable way
> for accessing 64-bit value in CPU's 32-bit mode.
> 
> Conclusion: seems to me __sync_xxx_compare_and_swap() should be kept
> in this case rather than using READ_ONCE() for 32-bit building.  Or
> any other suggestions?  Thanks!

__sync_xxx_compare_and_swap is out-of-date now. This page:

https://gcc.gnu.org/onlinedocs/gcc/_005f_005fsync-Builtins.html#g_t_005f_005fsync-Builtins

recommends '__atomic' builtins instead.

Since atomics are needed only for the "compat" case (i.e. 32-bit perf with 64-bit kernel)
you could try to find an elegant way to check for a 64-bit kernel, and avoid the atomics
for a 32-bit perf with 32-bit kernel.
