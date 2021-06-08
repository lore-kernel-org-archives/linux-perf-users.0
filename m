Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EFBC47082
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2969C61351
	for <linux-perf-users@archiver.kernel.org>; Tue,  8 Jun 2021 17:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhFHRMy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231577AbhFHRMx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 13:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73CA26128E;
        Tue,  8 Jun 2021 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623172260;
        bh=fIFXMNOPncbehiYawZCqgwcpQLjYu42rGGv8QKpCbR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJZQMcj1c/sJ3AEiX+Tnds0qpkHAuPYiX7SUXq0bLuswZRw7gReLo9RjrwocVm0C6
         ThJIEvjAxBQBxsOtplVMCzq9UpeVz7dFGQPCL5FVay+KSxFDKuk1IuBwJK7HBGcAV9
         T+ePsDg+W1gKHMXQqMGO5Y9IcTFkdWCz/p96x3ghM3GdM3tcw36W17OmXVSMX529cf
         UBS4hE0M5hZrVXxuaZHsR+4J9O1TTtiB5ytyGLjmoZAwLJ+znjvsQArMqeYOPJufIC
         CZT/p5QZq5JecgxakbyNLF/LDQXuks3rIhZLlSlKruFEwGZC3A9VqZFoOaTJyc+12L
         0dBWzcJWMj7BA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3BE3940B1A; Tue,  8 Jun 2021 14:10:58 -0300 (-03)
Date:   Tue, 8 Jun 2021 14:10:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf annotate: Add itrace options support
Message-ID: <YL+kovO5jK1zlR1j@kernel.org>
References: <20210607025918.118603-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607025918.118603-1-yangjihong1@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Jun 07, 2021 at 10:59:18AM +0800, Yang Jihong escreveu:
> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> "annotate". As a result, perf annotate does not support parsing itrace data.
> 
> A simple example is as follows:
> 
>   # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>   [ perf record: Woken up 9 times to write data ]
>   [ perf record: Captured and wrote 20.874 MB perf.data ]
>   # perf annotate --stdio
>   Error:
>   The perf.data data has no samples!

Can I get an Acked-by/Reviewed-by for this? I don't have a machine where
I can test this.

- Arnaldo
 
> Solution:
> 1.Add itrace options in help,
> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.
> 
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
> 
> Changes since v1:
>  - Adjust spaces to maintain alignment in "tool".
> 
>  tools/perf/builtin-annotate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
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
> -- 
> 2.30.GIT
> 

-- 

- Arnaldo
