Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9F1C48BDF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 03:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3796140C
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 03:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbhFODUM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:20:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7265 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhFODUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 23:20:12 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3tg66Qf4z1BM95;
        Tue, 15 Jun 2021 11:13:06 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:18:06 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:18:05 +0800
Subject: Re: [PATCH v2] perf annotate: Add itrace options support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20210607025918.118603-1-yangjihong1@huawei.com>
 <YMOG04alB0OoBEKz@kernel.org>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <d957a6c1-8fa3-e143-3d81-d16e9f45ed5d@huawei.com>
Date:   Tue, 15 Jun 2021 11:18:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YMOG04alB0OoBEKz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hell Arnaldo,

On 2021/6/11 23:52, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 07, 2021 at 10:59:18AM +0800, Yang Jihong escreveu:
>> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
>> "annotate". As a result, perf annotate does not support parsing itrace data.
>>
>> A simple example is as follows:
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
> 
> So, while we wait for someone to ack/review this, please send a v2
> updating tools/perf/Documentation/perf-annotate.txt to have references
> to these new 'perf annotate' options.
> 
> It all looks ok, so if nobody chimes in, I'll process v2 on my own.

OK, I have submitted the v3 patch, which updates 
tools/perf/Documentation/perf-annotate.txt:
https://lore.kernel.org/patchwork/patch/1446618/

Please take time to review the new patch. :)

Thanks,
Yang
> 
> Thanks,
> 
> - Arnaldo
>   
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>> ---
>>
>> Changes since v1:
>>   - Adjust spaces to maintain alignment in "tool".
>>
>>   tools/perf/builtin-annotate.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
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
>>   			.feature	= process_feature_event,
>>   			.ordered_events = true,
>>   			.ordering_requires_timestamps = true,
>> @@ -483,6 +485,9 @@ int cmd_annotate(int argc, const char **argv)
>>   	struct perf_data data = {
>>   		.mode  = PERF_DATA_MODE_READ,
>>   	};
>> +	struct itrace_synth_opts itrace_synth_opts = {
>> +		.set = 0,
>> +	};
>>   	struct option options[] = {
>>   	OPT_STRING('i', "input", &input_name, "file",
>>   		    "input file name"),
>> @@ -547,6 +552,9 @@ int cmd_annotate(int argc, const char **argv)
>>   	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>>   		     "Set percent type local/global-period/hits",
>>   		     annotate_parse_percent_type),
>> +	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
>> +			    "Instruction Tracing options\n" ITRACE_HELP,
>> +			    itrace_parse_synth_opts),
>>   
>>   	OPT_END()
>>   	};
>> @@ -591,6 +599,8 @@ int cmd_annotate(int argc, const char **argv)
>>   	if (IS_ERR(annotate.session))
>>   		return PTR_ERR(annotate.session);
>>   
>> +	annotate.session->itrace_synth_opts = &itrace_synth_opts;
>> +
>>   	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>>   						      HEADER_BRANCH_STACK);
>>   
>> -- 
>> 2.30.GIT
>>
> 
