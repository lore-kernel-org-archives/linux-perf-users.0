Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D47C48BDF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 07:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD9661419
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 07:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhFOHV4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 03:21:56 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10071 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhFOHVz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 03:21:55 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G404Q247MzZcJD;
        Tue, 15 Jun 2021 15:16:54 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:19:48 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 15:19:48 +0800
Subject: Re: [PATCH v3] perf annotate: Add itrace options support
To:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210615024036.181427-1-yangjihong1@huawei.com>
 <20210615040447.GB9844@leoy-ThinkPad-X240s>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <52532fa6-8883-ee5a-7047-53415f9d34f9@huawei.com>
Date:   Tue, 15 Jun 2021 15:19:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210615040447.GB9844@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, Leo and Arnaldo,

On 2021/6/15 12:04, Leo Yan wrote:
> Hi Jihong,
> 
> Loop in Adrain to be aware this AUX trace change.
> 
> On Tue, Jun 15, 2021 at 10:40:36AM +0800, Yang Jihong wrote:
>> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
>> "annotate". As a result, perf annotate does not support parsing itrace data.
>>
>> Before:
>>
>>    # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>>    [ perf record: Woken up 9 times to write data ]
>>    [ perf record: Captured and wrote 20.874 MB perf.data ]
>>    # perf annotate --stdio
>>    Error:
>>    The perf.data data has no samples!
>>
>> Solution:
>> 1.Add itrace options in help,
>> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.
>>
>> After:
>>
>>    # perf record --all-user -e arm_spe_0/branch_filter=1/ ls
>>    Couldn't synthesize bpf events.
>>    perf.data
>>    [ perf record: Woken up 1 times to write data ]
>>    [ perf record: Captured and wrote 0.010 MB perf.data ]
>>    # perf annotate --stdio
> 
>>     Percent |      Source code & Disassembly of libc-2.28.so for branch-miss (1 samples, percent: local period)
>>    ------------------------------------------------------------------------------------------------------------
>>             :
>>             :
>>             :
>>             :           Disassembly of section .text:
>>             :
>>             :           0000000000066180 <__getdelim@@GLIBC_2.17>:
>>        0.00 :   66180:  stp     x29, x30, [sp, #-96]!
>>        0.00 :   66184:  cmp     x0, #0x0
>>        0.00 :   66188:  ccmp    x1, #0x0, #0x4, ne  // ne = any
>>        0.00 :   6618c:  mov     x29, sp
>>        0.00 :   66190:  stp     x24, x25, [sp, #56]
>>        0.00 :   66194:  stp     x26, x27, [sp, #72]
>>        0.00 :   66198:  str     x28, [sp, #88]
>>        0.00 :   6619c:  b.eq    66450 <__getdelim@@GLIBC_2.17+0x2d0>  // b.none
>>        0.00 :   661a0:  stp     x22, x23, [x29, #40]
> 
> [...]
> 
> Nitpick: the above example is not typical for annotation, since it
> doesn't show any C source code with samples.  At my side, I tested this
> patch and confirmed the patch works well with below commands:
> 
>    # gcc -ggdb -O0 -o task_migration task_migration.c
>    # perf record -e cs_etm/@tmc_etr0/u --per-thread ./task_migration
>    # perf annotate --itrace=i1000 --stdio
> 
> The complete annotation result can be reviewed at [1].
> 
> Thus for this patch:
> 
> Tested-by: Leo Yan <leo.yan@linaro.org>
> 
> [1] https://paste.ubuntu.com/p/pHz74MYRPJ/
> 
> [...]
> .
> 
Thank you very much for the detailed testing of this patch :)

Yes, this example may not be well written.
Arnaldo, please check whether the commit message needs to be modified. 
If yes, I will resubmit a new v4 patch

Thanks,
Jihong
