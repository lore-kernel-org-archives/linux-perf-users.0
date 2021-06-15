Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC599C48BDF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 08:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD4F613D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 08:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFOIYl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 04:24:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:4943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbhFOIYl (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 04:24:41 -0400
IronPort-SDR: diO6FMzYXYSgFgNGHS2GclJFuwrqO7xuNib0LFgkIXrpvRBOyYgKN/My3ohrZN8+iIvAddxGxd
 usz7cIZOG1lQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="227411697"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="227411697"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 01:22:17 -0700
IronPort-SDR: sk/4WqhudFR+Mhh+onAg4uQ3wpUcyfUQuHnFCwKGFqY5QkO0j6JhDi8MfN7OHRMFKTIRsBRi3i
 pfddGXp1+q4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="487695156"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.79]) ([10.237.72.79])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2021 01:22:14 -0700
Subject: Re: [PATCH v3] perf annotate: Add itrace options support
To:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210615024036.181427-1-yangjihong1@huawei.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2cbf0c35-f600-22b6-0695-02eec3f81960@intel.com>
Date:   Tue, 15 Jun 2021 11:22:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615024036.181427-1-yangjihong1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 15/06/21 5:40 am, Yang Jihong wrote:
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
> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.
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
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v2:
>  - Updating tools/perf/Documentation/perf-annotate.txt.
>  - Add test result to commit message.
> 
> Changes since v1:
>  - Adjust spaces to maintain alignment in "tool".
> 
>  tools/perf/Documentation/perf-annotate.txt |  7 +++++++
>  tools/perf/builtin-annotate.c              | 10 ++++++++++
>  2 files changed, 17 insertions(+)
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
> index 49627a7bed7c..8f87658eff31 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -474,6 +474,8 @@ int cmd_annotate(int argc, const char **argv)
>  			.attr	= perf_event__process_attr,
>  			.build_id = perf_event__process_build_id,
>  			.tracing_data   = perf_event__process_tracing_data,
> +			.auxtrace_info	= perf_event__process_auxtrace_info,
> +			.auxtrace	= perf_event__process_auxtrace,

For sample mode, Intel PT also needs:

			.id_index	 = perf_event__process_id_index,


>  			.feature	= process_feature_event,
>  			.ordered_events = true,
>  			.ordering_requires_timestamps = true,
> @@ -483,6 +485,9 @@ int cmd_annotate(int argc, const char **argv)
>  	struct perf_data data = {
>  		.mode  = PERF_DATA_MODE_READ,
>  	};
> +	struct itrace_synth_opts itrace_synth_opts = {
> +		.set = 0,
> +	};
>  	struct option options[] = {
>  	OPT_STRING('i', "input", &input_name, "file",
>  		    "input file name"),
> @@ -547,6 +552,9 @@ int cmd_annotate(int argc, const char **argv)
>  	OPT_CALLBACK(0, "percent-type", &annotate.opts, "local-period",
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
> +	OPT_CALLBACK_OPTARG(0, "itrace", &itrace_synth_opts, NULL, "opts",
> +			    "Instruction Tracing options\n" ITRACE_HELP,
> +			    itrace_parse_synth_opts),
>  
>  	OPT_END()
>  	};
> @@ -591,6 +599,8 @@ int cmd_annotate(int argc, const char **argv)
>  	if (IS_ERR(annotate.session))
>  		return PTR_ERR(annotate.session);
>  
> +	annotate.session->itrace_synth_opts = &itrace_synth_opts;
> +
>  	annotate.has_br_stack = perf_header__has_feat(&annotate.session->header,
>  						      HEADER_BRANCH_STACK);
>  
> 

