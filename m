Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9FC48BE8
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 10:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3303B61450
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 10:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFOK3M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:29:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:11576 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231682AbhFOK3J (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 06:29:09 -0400
IronPort-SDR: w9JP9fHEP2fP/X1qdzponsvWMyyKgG520b+hMN1u+BHuFoJTZFIaLTx1shgoA3qA1K7yLSl77b
 6/m4cVGTt86Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205996701"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="205996701"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 03:27:04 -0700
IronPort-SDR: Dc/UuwqYpLexUGovS688c3ElHBenjKQ7uy5lnV/W1IHYteDbWngiahi7lYcqSGeNOVRYno2YTF
 WRs53V2gyQEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="487735848"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2021 03:26:59 -0700
Subject: Re: [PATCH v4] perf annotate: Add itrace options support
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615091704.259202-1-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1e2f6d0e-e171-e0be-4f33-02722b0c50d9@intel.com>
Date:   Tue, 15 Jun 2021 13:27:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615091704.259202-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 15/06/21 12:17 pm, Yang Jihong wrote:
> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> "annotate". As a result, perf annotate does not support parsing itrace data.
> 
> Before:
> 
>   # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>   [ perf record: Woken up 9 times to write data ]
>   [ perf record: Captured and wrote 20.874 MB perf.data ]
>   # perf annotate --stdio
>   Error:
>   The perf.data data has no samples!
> 
> Solution:
> 1.Add itrace options in help,
> 2.Set hook functions of "id_index", "auxtrace_info" and "auxtrace" in perf_tool.
> 
> After:
> 
>   # perf record --all-user -e arm_spe_0/branch_filter=1/ ls
>   Couldn't synthesize bpf events.
>   perf.data
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.010 MB perf.data ]
>   # perf annotate --stdio
>    Percent |      Source code & Disassembly of libc-2.28.so for branch-miss (1 samples, percent: local period)
>   ------------------------------------------------------------------------------------------------------------
>            :
>            :
>            :
>            :           Disassembly of section .text:
>            :
>            :           0000000000066180 <__getdelim@@GLIBC_2.17>:
>       0.00 :   66180:  stp     x29, x30, [sp, #-96]!
>       0.00 :   66184:  cmp     x0, #0x0
>       0.00 :   66188:  ccmp    x1, #0x0, #0x4, ne  // ne = any
>       0.00 :   6618c:  mov     x29, sp
>       0.00 :   66190:  stp     x24, x25, [sp, #56]
>       0.00 :   66194:  stp     x26, x27, [sp, #72]
>       0.00 :   66198:  str     x28, [sp, #88]
>       0.00 :   6619c:  b.eq    66450 <__getdelim@@GLIBC_2.17+0x2d0>  // b.none
>       0.00 :   661a0:  stp     x22, x23, [x29, #40]
>       0.00 :   661a4:  mov     x22, x1
>       0.00 :   661a8:  ldr     w1, [x3]
>       0.00 :   661ac:  mov     w23, w2
>       0.00 :   661b0:  stp     x20, x21, [x29, #24]
>       0.00 :   661b4:  mov     x20, x3
>       0.00 :   661b8:  mov     x21, x0
>       0.00 :   661bc:  tbnz    w1, #15, 66360 <__getdelim@@GLIBC_2.17+0x1e0>
>       0.00 :   661c0:  ldr     x0, [x3, #136]
>       0.00 :   661c4:  ldr     x2, [x0, #8]
>       0.00 :   661c8:  str     x19, [x29, #16]
>       0.00 :   661cc:  mrs     x19, tpidr_el0
>       0.00 :   661d0:  sub     x19, x19, #0x700
>       0.00 :   661d4:  cmp     x2, x19
>       0.00 :   661d8:  b.eq    663f0 <__getdelim@@GLIBC_2.17+0x270>  // b.none
>       0.00 :   661dc:  mov     w1, #0x1                        // #1
>       0.00 :   661e0:  ldaxr   w2, [x0]
>       0.00 :   661e4:  cmp     w2, #0x0
>       0.00 :   661e8:  b.ne    661f4 <__getdelim@@GLIBC_2.17+0x74>  // b.any
>       0.00 :   661ec:  stxr    w3, w1, [x0]
>       0.00 :   661f0:  cbnz    w3, 661e0 <__getdelim@@GLIBC_2.17+0x60>
>       0.00 :   661f4:  b.ne    66448 <__getdelim@@GLIBC_2.17+0x2c8>  // b.any
>       0.00 :   661f8:  ldr     x0, [x20, #136]
>       0.00 :   661fc:  ldr     w1, [x20]
>       0.00 :   66200:  ldr     w2, [x0, #4]
>       0.00 :   66204:  str     x19, [x0, #8]
>       0.00 :   66208:  add     w2, w2, #0x1
>       0.00 :   6620c:  str     w2, [x0, #4]
>       0.00 :   66210:  tbnz    w1, #5, 66388 <__getdelim@@GLIBC_2.17+0x208>
>       0.00 :   66214:  ldr     x19, [x29, #16]
>       0.00 :   66218:  ldr     x0, [x21]
>       0.00 :   6621c:  cbz     x0, 66228 <__getdelim@@GLIBC_2.17+0xa8>
>       0.00 :   66220:  ldr     x0, [x22]
>       0.00 :   66224:  cbnz    x0, 6623c <__getdelim@@GLIBC_2.17+0xbc>
>       0.00 :   66228:  mov     x0, #0x78                       // #120
>       0.00 :   6622c:  str     x0, [x22]
>       0.00 :   66230:  bl      20710 <malloc@plt>
>       0.00 :   66234:  str     x0, [x21]
>       0.00 :   66238:  cbz     x0, 66428 <__getdelim@@GLIBC_2.17+0x2a8>
>       0.00 :   6623c:  ldr     x27, [x20, #8]
>       0.00 :   66240:  str     x19, [x29, #16]
>       0.00 :   66244:  ldr     x19, [x20, #16]
>       0.00 :   66248:  sub     x19, x19, x27
>       0.00 :   6624c:  cmp     x19, #0x0
>       0.00 :   66250:  b.le    66398 <__getdelim@@GLIBC_2.17+0x218>
>       0.00 :   66254:  mov     x25, #0x0                       // #0
>       0.00 :   66258:  b       662d8 <__getdelim@@GLIBC_2.17+0x158>
>       0.00 :   6625c:  nop
>       0.00 :   66260:  add     x24, x19, x25
>       0.00 :   66264:  ldr     x3, [x22]
>       0.00 :   66268:  add     x26, x24, #0x1
>       0.00 :   6626c:  ldr     x0, [x21]
>       0.00 :   66270:  cmp     x3, x26
>       0.00 :   66274:  b.cs    6629c <__getdelim@@GLIBC_2.17+0x11c>  // b.hs, b.nlast
>       0.00 :   66278:  lsl     x3, x3, #1
>       0.00 :   6627c:  cmp     x3, x26
>       0.00 :   66280:  csel    x26, x3, x26, cs  // cs = hs, nlast
>       0.00 :   66284:  mov     x1, x26
>       0.00 :   66288:  bl      206f0 <realloc@plt>
>       0.00 :   6628c:  cbz     x0, 66438 <__getdelim@@GLIBC_2.17+0x2b8>
>       0.00 :   66290:  str     x0, [x21]
>       0.00 :   66294:  ldr     x27, [x20, #8]
>       0.00 :   66298:  str     x26, [x22]
>       0.00 :   6629c:  mov     x2, x19
>       0.00 :   662a0:  mov     x1, x27
>       0.00 :   662a4:  add     x0, x0, x25
>       0.00 :   662a8:  bl      87390 <explicit_bzero@@GLIBC_2.25+0x50>
>       0.00 :   662ac:  ldr     x0, [x20, #8]
>       0.00 :   662b0:  add     x19, x0, x19
>       0.00 :   662b4:  str     x19, [x20, #8]
>       0.00 :   662b8:  cbnz    x28, 66410 <__getdelim@@GLIBC_2.17+0x290>
>       0.00 :   662bc:  mov     x0, x20
>       0.00 :   662c0:  bl      73b80 <__underflow@@GLIBC_2.17>
>       0.00 :   662c4:  cmn     w0, #0x1
>       0.00 :   662c8:  b.eq    66410 <__getdelim@@GLIBC_2.17+0x290>  // b.none
>       0.00 :   662cc:  ldp     x27, x19, [x20, #8]
>       0.00 :   662d0:  mov     x25, x24
>       0.00 :   662d4:  sub     x19, x19, x27
>       0.00 :   662d8:  mov     x2, x19
>       0.00 :   662dc:  mov     w1, w23
>       0.00 :   662e0:  mov     x0, x27
>       0.00 :   662e4:  bl      807b0 <memchr@@GLIBC_2.17>
>       0.00 :   662e8:  cmp     x0, #0x0
>       0.00 :   662ec:  mov     x28, x0
>       0.00 :   662f0:  sub     x0, x0, x27
>       0.00 :   662f4:  csinc   x19, x19, x0, eq  // eq = none
>       0.00 :   662f8:  mov     x0, #0x7fffffffffffffff         // #9223372036854775807
>       0.00 :   662fc:  sub     x0, x0, x25
>       0.00 :   66300:  cmp     x19, x0
>       0.00 :   66304:  b.lt    66260 <__getdelim@@GLIBC_2.17+0xe0>  // b.tstop
>       0.00 :   66308:  adrp    x0, 17f000 <sys_sigabbrev@@GLIBC_2.17+0x320>
>       0.00 :   6630c:  ldr     x0, [x0, #3624]
>       0.00 :   66310:  mrs     x2, tpidr_el0
>       0.00 :   66314:  ldr     x19, [x29, #16]
>       0.00 :   66318:  mov     w3, #0x4b                       // #75
>       0.00 :   6631c:  ldr     w1, [x20]
>       0.00 :   66320:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   66324:  str     w3, [x2, x0]
>       0.00 :   66328:  tbnz    w1, #15, 66340 <__getdelim@@GLIBC_2.17+0x1c0>
>       0.00 :   6632c:  ldr     x0, [x20, #136]
>       0.00 :   66330:  ldr     w1, [x0, #4]
>       0.00 :   66334:  sub     w1, w1, #0x1
>       0.00 :   66338:  str     w1, [x0, #4]
>       0.00 :   6633c:  cbz     w1, 663b8 <__getdelim@@GLIBC_2.17+0x238>
>       0.00 :   66340:  mov     x0, x24
>       0.00 :   66344:  ldr     x28, [sp, #88]
>       0.00 :   66348:  ldp     x20, x21, [x29, #24]
>       0.00 :   6634c:  ldp     x22, x23, [x29, #40]
>       0.00 :   66350:  ldp     x24, x25, [sp, #56]
>       0.00 :   66354:  ldp     x26, x27, [sp, #72]
>       0.00 :   66358:  ldp     x29, x30, [sp], #96
>       0.00 :   6635c:  ret
>     100.00 :   66360:  tbz     w1, #5, 66218 <__getdelim@@GLIBC_2.17+0x98>
>       0.00 :   66364:  ldp     x20, x21, [x29, #24]
>       0.00 :   66368:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   6636c:  ldp     x22, x23, [x29, #40]
>       0.00 :   66370:  mov     x0, x24
>       0.00 :   66374:  ldp     x24, x25, [sp, #56]
>       0.00 :   66378:  ldp     x26, x27, [sp, #72]
>       0.00 :   6637c:  ldr     x28, [sp, #88]
>       0.00 :   66380:  ldp     x29, x30, [sp], #96
>       0.00 :   66384:  ret
>       0.00 :   66388:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   6638c:  ldr     x19, [x29, #16]
>       0.00 :   66390:  b       66328 <__getdelim@@GLIBC_2.17+0x1a8>
>       0.00 :   66394:  nop
>       0.00 :   66398:  mov     x0, x20
>       0.00 :   6639c:  bl      73b80 <__underflow@@GLIBC_2.17>
>       0.00 :   663a0:  cmn     w0, #0x1
>       0.00 :   663a4:  b.eq    66438 <__getdelim@@GLIBC_2.17+0x2b8>  // b.none
>       0.00 :   663a8:  ldp     x27, x19, [x20, #8]
>       0.00 :   663ac:  sub     x19, x19, x27
>       0.00 :   663b0:  b       66254 <__getdelim@@GLIBC_2.17+0xd4>
>       0.00 :   663b4:  nop
>       0.00 :   663b8:  str     xzr, [x0, #8]
>       0.00 :   663bc:  ldxr    w2, [x0]
>       0.00 :   663c0:  stlxr   w3, w1, [x0]
>       0.00 :   663c4:  cbnz    w3, 663bc <__getdelim@@GLIBC_2.17+0x23c>
>       0.00 :   663c8:  cmp     w2, #0x1
>       0.00 :   663cc:  b.le    66340 <__getdelim@@GLIBC_2.17+0x1c0>
>       0.00 :   663d0:  mov     x1, #0x81                       // #129
>       0.00 :   663d4:  mov     x2, #0x1                        // #1
>       0.00 :   663d8:  mov     x3, #0x0                        // #0
>       0.00 :   663dc:  mov     x8, #0x62                       // #98
>       0.00 :   663e0:  svc     #0x0
>       0.00 :   663e4:  ldp     x20, x21, [x29, #24]
>       0.00 :   663e8:  ldp     x22, x23, [x29, #40]
>       0.00 :   663ec:  b       66370 <__getdelim@@GLIBC_2.17+0x1f0>
>       0.00 :   663f0:  ldr     w2, [x0, #4]
>       0.00 :   663f4:  add     w2, w2, #0x1
>       0.00 :   663f8:  str     w2, [x0, #4]
>       0.00 :   663fc:  tbz     w1, #5, 66214 <__getdelim@@GLIBC_2.17+0x94>
>       0.00 :   66400:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   66404:  ldr     x19, [x29, #16]
>       0.00 :   66408:  b       66330 <__getdelim@@GLIBC_2.17+0x1b0>
>       0.00 :   6640c:  nop
>       0.00 :   66410:  ldr     x0, [x21]
>       0.00 :   66414:  strb    wzr, [x0, x24]
>       0.00 :   66418:  ldr     w1, [x20]
>       0.00 :   6641c:  ldr     x19, [x29, #16]
>       0.00 :   66420:  b       66328 <__getdelim@@GLIBC_2.17+0x1a8>
>       0.00 :   66424:  nop
>       0.00 :   66428:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   6642c:  ldr     w1, [x20]
>       0.00 :   66430:  b       66328 <__getdelim@@GLIBC_2.17+0x1a8>
>       0.00 :   66434:  nop
>       0.00 :   66438:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   6643c:  ldr     w1, [x20]
>       0.00 :   66440:  ldr     x19, [x29, #16]
>       0.00 :   66444:  b       66328 <__getdelim@@GLIBC_2.17+0x1a8>
>       0.00 :   66448:  bl      e3ba0 <pthread_setcanceltype@@GLIBC_2.17+0x30>
>       0.00 :   6644c:  b       661f8 <__getdelim@@GLIBC_2.17+0x78>
>       0.00 :   66450:  adrp    x0, 17f000 <sys_sigabbrev@@GLIBC_2.17+0x320>
>       0.00 :   66454:  ldr     x0, [x0, #3624]
>       0.00 :   66458:  mrs     x1, tpidr_el0
>       0.00 :   6645c:  mov     w2, #0x16                       // #22
>       0.00 :   66460:  mov     x24, #0xffffffffffffffff        // #-1
>       0.00 :   66464:  str     w2, [x1, x0]
>       0.00 :   66468:  b       66370 <__getdelim@@GLIBC_2.17+0x1f0>
>       0.00 :   6646c:  ldr     w1, [x20]
>       0.00 :   66470:  mov     x4, x0
>       0.00 :   66474:  tbnz    w1, #15, 6648c <__getdelim@@GLIBC_2.17+0x30c>
>       0.00 :   66478:  ldr     x0, [x20, #136]
>       0.00 :   6647c:  ldr     w1, [x0, #4]
>       0.00 :   66480:  sub     w1, w1, #0x1
>       0.00 :   66484:  str     w1, [x0, #4]
>       0.00 :   66488:  cbz     w1, 66494 <__getdelim@@GLIBC_2.17+0x314>
>       0.00 :   6648c:  mov     x0, x4
>       0.00 :   66490:  bl      20e40 <gnu_get_libc_version@@GLIBC_2.17+0x130>
>       0.00 :   66494:  str     xzr, [x0, #8]
>       0.00 :   66498:  ldxr    w2, [x0]
>       0.00 :   6649c:  stlxr   w3, w1, [x0]
>       0.00 :   664a0:  cbnz    w3, 66498 <__getdelim@@GLIBC_2.17+0x318>
>       0.00 :   664a4:  cmp     w2, #0x1
>       0.00 :   664a8:  b.le    6648c <__getdelim@@GLIBC_2.17+0x30c>
>       0.00 :   664ac:  mov     x1, #0x81                       // #129
>       0.00 :   664b0:  mov     x2, #0x1                        // #1
>       0.00 :   664b4:  mov     x3, #0x0                        // #0
>       0.00 :   664b8:  mov     x8, #0x62                       // #98
>       0.00 :   664bc:  svc     #0x0
>       0.00 :   664c0:  b       6648c <__getdelim@@GLIBC_2.17+0x30c>
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Leo Yan <leo.yan@linaro.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Changes since v3:
>  - Set hook function of "id_index" for Intel PT sample mode.
> 
> Changes since v2:
>  - Updating tools/perf/Documentation/perf-annotate.txt.
>  - Add test result to commit message.
> 
> Changes since v1:
>  - Adjust spaces to maintain alignment in "tool".
> 
>  tools/perf/Documentation/perf-annotate.txt |  7 +++++++
>  tools/perf/builtin-annotate.c              | 11 +++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
> index 80c1be5d566c..33c2521cba4a 100644
> --- a/tools/perf/Documentation/perf-annotate.txt
> +++ b/tools/perf/Documentation/perf-annotate.txt
> @@ -58,6 +58,13 @@ OPTIONS
>  --ignore-vmlinux::
>  	Ignore vmlinux files.
>  
> +--itrace::
> +	Options for decoding instruction tracing data. The options are:
> +
> +include::itrace.txt[]
> +
> +	To disable decoding entirely, use --no-itrace.
> +
>  -m::
>  --modules::
>          Load module symbols. WARNING: use only with -k and LIVE kernel.
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 49627a7bed7c..cebb861be3e3 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -474,6 +474,9 @@ int cmd_annotate(int argc, const char **argv)
>  			.attr	= perf_event__process_attr,
>  			.build_id = perf_event__process_build_id,
>  			.tracing_data   = perf_event__process_tracing_data,
> +			.id_index	= perf_event__process_id_index,
> +			.auxtrace_info	= perf_event__process_auxtrace_info,
> +			.auxtrace	= perf_event__process_auxtrace,
>  			.feature	= process_feature_event,
>  			.ordered_events = true,
>  			.ordering_requires_timestamps = true,
> @@ -483,6 +486,9 @@ int cmd_annotate(int argc, const char **argv)
>  	struct perf_data data = {
>  		.mode  = PERF_DATA_MODE_READ,
>  	};
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = 0,
> +	};
>  	struct option options[] = {
>  	OPT_STRING('i', "input", &input_name, "file",
>  		    "input file name"),
> @@ -547,6 +553,9 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
> +	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
> +			    itrace_parse_synth_opts),
>  
>  	OPT_END()
>  	};
> @@ -591,6 +600,8 @@ int cmd_annotate(int argc, const char **argv)
>  	if (IS_ERR(annotate.session))
>  		return PTR_ERR(annotate.session);
>  
> +	annotate.session->itrace_synth_opts = &itrace_synth_opts;
> +
>  	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>  						      HEADER_BRANCH_STACK);
>  
> 

