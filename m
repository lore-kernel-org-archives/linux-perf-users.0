Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDF9C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Nov 2021 17:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345438AbhK2RQ7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Nov 2021 12:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20432 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346730AbhK2RO6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Nov 2021 12:14:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638205899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YQeXdayCnkvjWc51N14x/4MfGt9KFvQgOqWRPynFEGY=;
        b=g1f/xAha33Wg2esaNx7b1TLo6fH1Qc4m1v6HyKi26acr+GyEZEFslEyXfzaGIRXTMmQ3No
        W1kxcdzNc+8xZKdM2Ag/XFnHhSlynLQaqDnuX4mAj2KZvSoJnovU7mYsL4nvX7SSX02+KB
        sRVy559B/9/H8aeVMysxo3YzcwNJjpk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-yw2twgPwM8icDxaE02NcEQ-1; Mon, 29 Nov 2021 12:11:38 -0500
X-MC-Unique: yw2twgPwM8icDxaE02NcEQ-1
Received: by mail-wm1-f70.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so12177906wmc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Nov 2021 09:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQeXdayCnkvjWc51N14x/4MfGt9KFvQgOqWRPynFEGY=;
        b=X7KCyVMVTE9iLaxWksHsrC9HRfsgCWImcYXr23FFbCiC/TTKBpjrepK2QcX1veqltN
         jyeC+hWprLajN5+qd6OhKwWTVCv8meaME9BSl8o23HDSyPVPWYyl/dx6glsLOHBTSibB
         kOhr7kOfKhkNju6OK2EZupA6BZjIbRtv+cJYOHeuJ0Ok1agVdmCWNIAAojvpFCLVflt8
         N2gTV0BcKfTGppb2MGz3RcbUZeGsA6K+YPuXevSSbOYcQrcgv3CYw2qVdJDcylZ37X45
         auZX1pQJ6XiIFBmEhOpgqdEpPqmsQK2xYnzr+XfPhy2u1pTpuXtOfD5pHKz15xG5p8ow
         nuYw==
X-Gm-Message-State: AOAM531rXE5ATYF5kxedMlshHXX7nSbKNKyDjEaH/h1CG0k6MVi9uYzr
        SrpFJARIxYliK+ouyNFFencG0ojPR13DGmM1JulwyjnDHVgcF/B95KwVbFEqv4Hgx/SKqt0yEMk
        nHHi0/D8ZDT6dU3/m/JX2mJaPIidmhQ==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr38118071wrs.291.1638205896883;
        Mon, 29 Nov 2021 09:11:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHpkPDO/3JJftsa0KO/wQW2joNogZAU7drv1A4fLjU/VAKwmh8O+A4HaIDtCq1J/G2bry+DQ==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr38118039wrs.291.1638205896656;
        Mon, 29 Nov 2021 09:11:36 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k187sm272819wme.0.2021.11.29.09.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 09:11:33 -0800 (PST)
Date:   Mon, 29 Nov 2021 18:11:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, namhyung@kernel.org
Subject: Re: [PATCH 1/2] tools/perf: Include global and local variants for
 p_stage_cyc sort key
Message-ID: <YaUJwxHPTz1J7K1e@krava>
References: <20211125024851.22895-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125024851.22895-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 25, 2021 at 08:18:50AM +0530, Athira Rajeev wrote:
> Sort key p_stage_cyc is used to present the latency
> cycles spend in pipeline stages. perf tool has local
> p_stage_cyc sort key to display this info. There is no
> global variant available for this sort key. local variant
> shows latency in a sinlge sample, whereas, global value
> will be useful to present the total latency (sum of
> latencies) in the hist entry. It represents latency
> number multiplied by the number of samples.
> 
> Add global (p_stage_cyc) and local variant
> (local_p_stage_cyc) for this sort key. Use the
> local_p_stage_cyc as default option for "mem" sort mode.
> Also add this to list of dynamic sort keys.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Reported-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/hist.c |  4 +++-
>  tools/perf/util/hist.h |  3 ++-
>  tools/perf/util/sort.c | 34 +++++++++++++++++++++++++---------
>  tools/perf/util/sort.h |  3 ++-
>  4 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index b776465e04ef..0a8033b09e28 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -211,7 +211,9 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
>  	hists__new_col_len(hists, HISTC_MEM_BLOCKED, 10);
>  	hists__new_col_len(hists, HISTC_LOCAL_INS_LAT, 13);
>  	hists__new_col_len(hists, HISTC_GLOBAL_INS_LAT, 13);
> -	hists__new_col_len(hists, HISTC_P_STAGE_CYC, 13);
> +	hists__new_col_len(hists, HISTC_LOCAL_P_STAGE_CYC, 13);
> +	hists__new_col_len(hists, HISTC_GLOBAL_P_STAGE_CYC, 13);
> +
>  	if (symbol_conf.nanosecs)
>  		hists__new_col_len(hists, HISTC_TIME, 16);
>  	else
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 5343b62476e6..2752ce681108 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -75,7 +75,8 @@ enum hist_column {
>  	HISTC_MEM_BLOCKED,
>  	HISTC_LOCAL_INS_LAT,
>  	HISTC_GLOBAL_INS_LAT,
> -	HISTC_P_STAGE_CYC,
> +	HISTC_LOCAL_P_STAGE_CYC,
> +	HISTC_GLOBAL_P_STAGE_CYC,
>  	HISTC_NR_COLS, /* Last entry */
>  };
>  
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index e9216a292a04..e978f7883e07 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -37,7 +37,7 @@ const char	default_parent_pattern[] = "^sys_|^do_page_fault";
>  const char	*parent_pattern = default_parent_pattern;
>  const char	*default_sort_order = "comm,dso,symbol";
>  const char	default_branch_sort_order[] = "comm,dso_from,symbol_from,symbol_to,cycles";
> -const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,p_stage_cyc";
> +const char	default_mem_sort_order[] = "local_weight,mem,sym,dso,symbol_daddr,dso_daddr,snoop,tlb,locked,blocked,local_ins_lat,local_p_stage_cyc";
>  const char	default_top_sort_order[] = "dso,symbol";
>  const char	default_diff_sort_order[] = "dso,symbol";
>  const char	default_tracepoint_sort_order[] = "trace";
> @@ -46,8 +46,8 @@ const char	*field_order;
>  regex_t		ignore_callees_regex;
>  int		have_ignore_callees = 0;
>  enum sort_mode	sort__mode = SORT_MODE__NORMAL;
> -const char	*dynamic_headers[] = {"local_ins_lat", "p_stage_cyc"};
> -const char	*arch_specific_sort_keys[] = {"p_stage_cyc"};
> +const char	*dynamic_headers[] = {"local_ins_lat", "ins_lat", "local_p_stage_cyc", "p_stage_cyc"};

so you also add global ins_lat, right? will this change
some default behaviour?

> +const char	*arch_specific_sort_keys[] = {"local_p_stage_cyc", "p_stage_cyc"};

nit.. both dynamic_headers and arch_specific_sort_keys could be static right?

thanks,
jirka

>  
>  /*
>   * Replaces all occurrences of a char used with the:
> @@ -1392,22 +1392,37 @@ struct sort_entry sort_global_ins_lat = {
>  };
>  
>  static int64_t
> -sort__global_p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
> +sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
>  {
>  	return left->p_stage_cyc - right->p_stage_cyc;
>  }
>  
> +static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
> +					size_t size, unsigned int width)
> +{
> +	return repsep_snprintf(bf, size, "%-*u", width,
> +			he->p_stage_cyc * he->stat.nr_events);
> +}
> +
> +
>  static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
>  					size_t size, unsigned int width)
>  {
>  	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
>  }
>  
> -struct sort_entry sort_p_stage_cyc = {
> -	.se_header      = "Pipeline Stage Cycle",
> -	.se_cmp         = sort__global_p_stage_cyc_cmp,
> +struct sort_entry sort_local_p_stage_cyc = {
> +	.se_header      = "Local Pipeline Stage Cycle",
> +	.se_cmp         = sort__p_stage_cyc_cmp,
>  	.se_snprintf	= hist_entry__p_stage_cyc_snprintf,
> -	.se_width_idx	= HISTC_P_STAGE_CYC,
> +	.se_width_idx	= HISTC_LOCAL_P_STAGE_CYC,
> +};
> +
> +struct sort_entry sort_global_p_stage_cyc = {
> +	.se_header      = "Pipeline Stage Cycle",
> +	.se_cmp         = sort__p_stage_cyc_cmp,
> +	.se_snprintf    = hist_entry__global_p_stage_cyc_snprintf,
> +	.se_width_idx   = HISTC_GLOBAL_P_STAGE_CYC,
>  };
>  
>  struct sort_entry sort_mem_daddr_sym = {
> @@ -1858,7 +1873,8 @@ static struct sort_dimension common_sort_dimensions[] = {
>  	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
>  	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
>  	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
> -	DIM(SORT_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_p_stage_cyc),
> +	DIM(SORT_LOCAL_PIPELINE_STAGE_CYC, "local_p_stage_cyc", sort_local_p_stage_cyc),
> +	DIM(SORT_GLOBAL_PIPELINE_STAGE_CYC, "p_stage_cyc", sort_global_p_stage_cyc),
>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 3c7518378d62..83abe5e6812a 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -235,7 +235,8 @@ enum sort_type {
>  	SORT_CODE_PAGE_SIZE,
>  	SORT_LOCAL_INS_LAT,
>  	SORT_GLOBAL_INS_LAT,
> -	SORT_PIPELINE_STAGE_CYC,
> +	SORT_LOCAL_PIPELINE_STAGE_CYC,
> +	SORT_GLOBAL_PIPELINE_STAGE_CYC,
>  
>  	/* branch stack specific sort keys */
>  	__SORT_BRANCH_STACK,
> -- 
> 2.27.0
> 

