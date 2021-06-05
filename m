Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C56C4743C
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 00:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529F4613DE
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 00:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbhFEAfR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 20:35:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4475 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhFEAfQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 20:35:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxgXH6WHczYmBc;
        Sat,  5 Jun 2021 08:30:39 +0800 (CST)
Received: from dggpemm000003.china.huawei.com (7.185.36.128) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 08:33:26 +0800
Received: from [10.67.102.248] (10.67.102.248) by
 dggpemm000003.china.huawei.com (7.185.36.128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 08:33:26 +0800
Subject: Re: [PATCH] perf annotate: Add itrace options support
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210527015510.5719-1-yangjihong1@huawei.com>
From:   Yang Jihong <yangjihong1@huawei.com>
Message-ID: <2193a839-076a-3b5e-8ded-395531310d96@huawei.com>
Date:   Sat, 5 Jun 2021 08:33:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210527015510.5719-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.248]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm000003.china.huawei.com (7.185.36.128)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

ping :)

Please take time to review this patch.

Thanks,
Yang

On 2021/5/27 9:55, Yang Jihong wrote:
> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> "annotate". As a result, perf annotate does not support parsing itrace data.
> 
> A simple example is as follows:
> 
>    # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>    [ perf record: Woken up 9 times to write data ]
>    [ perf record: Captured and wrote 20.874 MB perf.data ]
>    # perf annotate --stdio
>    Error:
>    The perf.data data has no samples!
> 
> Solution:
> 1.Add itrace options in help,
> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>   tools/perf/builtin-annotate.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 49627a7bed7c..84ef52177d63 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -474,6 +474,8 @@ int cmd_annotate(int argc, const char **argv)
>   			.attr	= perf_event__process_attr,
>   			.build_id = perf_event__process_build_id,
>   			.tracing_data   = perf_event__process_tracing_data,
> +			.auxtrace_info	 = perf_event__process_auxtrace_info,
> +			.auxtrace	 = perf_event__process_auxtrace,
>   			.feature	= process_feature_event,
>   			.ordered_events = true,
>   			.ordering_requires_timestamps = true,
> @@ -483,6 +485,9 @@ int cmd_annotate(int argc, const char **argv)
>   	struct perf_data data = {
>   		.mode  = PERF_DATA_MODE_READ,
>   	};
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = 0,
> +	};
>   	struct option options[] = {
>   	OPT_STRING('i', "input", &input_name, "file",
>   		    "input file name"),
> @@ -547,6 +552,9 @@ int cmd_annotate(int argc, const char **argv)
>   	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>   		     "Set percent type local/global-period/hits",
>   		     annotate_parse_percent_type),
> +	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
> +			    itrace_parse_synth_opts),
>   
>   	OPT_END()
>   	};
> @@ -591,6 +599,8 @@ int cmd_annotate(int argc, const char **argv)
>   	if (IS_ERR(annotate.session))
>   		return PTR_ERR(annotate.session);
>   
> +	annotate.session->itrace_synth_opts = &itrace_synth_opts;
> +
>   	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>   						      HEADER_BRANCH_STACK);
>   
> 
