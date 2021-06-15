Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A91BC48BE5
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 09:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A5261429
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 09:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFOJav (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 05:30:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:10072 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbhFOJau (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 05:30:50 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G42x94bJCzZfBH;
        Tue, 15 Jun 2021 17:25:49 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:28:44 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:28:43 +0800
Subject: Re: [PATCH v3] perf annotate: Add itrace options support
To:     Adrian Hunter <adrian.hunter@intel.com>, <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
References: <20210615024036.181427-1-yangjihong1@huawei.com>
 <2cbf0c35-f600-22b6-0695-02eec3f81960@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <5b0e6138-854a-2996-3551-7e10ba0ce2b7@huawei.com>
Date:   Tue, 15 Jun 2021 17:28:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <2cbf0c35-f600-22b6-0695-02eec3f81960@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello, Adrain,

On 2021/6/15 16:22, Adrian Hunter wrote:
> On 15/06/21 5:40 am, Yang Jihong wrote:
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
>>
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v2:
>>   - Updating tools/perf/Documentation/perf-annotate.txt.
>>   - Add test result to commit message.
>>
>> Changes since v1:
>>   - Adjust spaces to maintain alignment in "tool".
>>
>>   tools/perf/Documentation/perf-annotate.txt |  7 +++++++
>>   tools/perf/builtin-annotate.c              | 10 ++++++++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
>> index 80c1be5d566c..33c2521cba4a 100644
>> --- a/tools/perf/Documentation/perf-annotate.txt
>> +++ b/tools/perf/Documentation/perf-annotate.txt
>> @@ -58,6 +58,13 @@ OPTIONS
>>   --ignore-vmlinux::
>>   	Ignore vmlinux files.
>>   
>> +--itrace::
>> +	Options for decoding instruction tracing data. The options are:
>> +
>> +include::itrace.txt[]
>> +
>> +	To disable decoding entirely, use --no-itrace.
>> +
>>   -m::
>>   --modules::
>>           Load module symbols. WARNING: use only with -k and LIVE kernel.
>> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
>> index 49627a7bed7c..8f87658eff31 100644
>> --- a/tools/perf/builtin-annotate.c
>> +++ b/tools/perf/builtin-annotate.c
>> @@ -474,6 +474,8 @@ int cmd_annotate(int argc, const char **argv)
>>   			.attr	= perf_event__process_attr,
>>   			.build_id = perf_event__process_build_id,
>>   			.tracing_data   = perf_event__process_tracing_data,
>> +			.auxtrace_info	= perf_event__process_auxtrace_info,
>> +			.auxtrace	= perf_event__process_auxtrace,
> 
> For sample mode, Intel PT also needs:
> 
> 			.id_index	 = perf_event__process_id_index,
> 
Thanks for testing this patch in the Intel PT environment.
OK, I add the id_index processing function to the v4 patch:
https://lore.kernel.org/patchwork/patch/1446727/

Thanks,
Jihong
