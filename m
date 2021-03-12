Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2052CC433E6
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Mar 2021 12:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D970764FF5
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Mar 2021 12:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLM5J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Mar 2021 07:57:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231821AbhCLM5F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Mar 2021 07:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615553825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgncmMqhr4dHPhdE9BWfq/XyXMHQvttFAM4981INv84=;
        b=A2EQJM/7+J79JV0nbwUeoXaY/sG6etjC4kAjyEmeuaGbhk/0HmbEiiMdrPDr3oXKRYozDB
        b3kq1rLAN8Yae3+KoKUpRIhwFBLkHjFTpf8wlofd8gJt15WoB/a8CHXa+Sh/WvrhtTTEoD
        f2zABTaF5MAVR872Zc4xdwhA4I6of+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-IBQGRFjSNOe0qKlVlhp4UQ-1; Fri, 12 Mar 2021 07:57:00 -0500
X-MC-Unique: IBQGRFjSNOe0qKlVlhp4UQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63BF11015C84;
        Fri, 12 Mar 2021 12:56:56 +0000 (UTC)
Received: from krava (unknown [10.40.192.54])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC311197F9;
        Fri, 12 Mar 2021 12:56:52 +0000 (UTC)
Date:   Fri, 12 Mar 2021 13:56:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mpe@ellerman.id.au,
        acme@kernel.org, jolsa@kernel.org, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, kjain@linux.ibm.com,
        kan.liang@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH 4/4] tools/perf: Support pipeline stage cycles for powerpc
Message-ID: <YEtlEyb2z33qHhvO@krava>
References: <1615298640-1529-1-git-send-email-atrajeev@linux.vnet.ibm.com>
 <1615298640-1529-5-git-send-email-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615298640-1529-5-git-send-email-atrajeev@linux.vnet.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Mar 09, 2021 at 09:04:00AM -0500, Athira Rajeev wrote:
> The pipeline stage cycles details can be recorded on powerpc from
> the contents of Performance Monitor Unit (PMU) registers. On
> ISA v3.1 platform, sampling registers exposes the cycles spent in
> different pipeline stages. Patch adds perf tools support to present
> two of the cycle counter information along with memory latency (weight).
> 
> Re-use the field 'ins_lat' for storing the first pipeline stage cycle.
> This is stored in 'var2_w' field of 'perf_sample_weight'.
> 
> Add a new field 'p_stage_cyc' to store the second pipeline stage cycle
> which is stored in 'var3_w' field of perf_sample_weight.
> 
> Add new sort function 'Pipeline Stage Cycle' and include this in
> default_mem_sort_order[]. This new sort function may be used to denote
> some other pipeline stage in another architecture. So add this to
> list of sort entries that can have dynamic header string.
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/Documentation/perf-report.txt |  1 +
>  tools/perf/arch/powerpc/util/event.c     | 18 ++++++++++++++++--
>  tools/perf/util/event.h                  |  1 +
>  tools/perf/util/hist.c                   | 11 ++++++++---
>  tools/perf/util/hist.h                   |  1 +
>  tools/perf/util/session.c                |  4 +++-
>  tools/perf/util/sort.c                   | 24 ++++++++++++++++++++++--
>  tools/perf/util/sort.h                   |  2 ++
>  8 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index f546b5e9db05..9691d9c227ba 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -112,6 +112,7 @@ OPTIONS
>  	- ins_lat: Instruction latency in core cycles. This is the global instruction
>  	  latency
>  	- local_ins_lat: Local instruction latency version
> +	- p_stage_cyc: Number of cycles spent in a pipeline stage.

please specify in here that it's ppc only

SNIP

> +struct sort_entry sort_p_stage_cyc = {
> +	.se_header      = "Pipeline Stage Cycle",
> +	.se_cmp         = sort__global_p_stage_cyc_cmp,
> +	.se_snprintf	= hist_entry__p_stage_cyc_snprintf,
> +	.se_width_idx	= HISTC_P_STAGE_CYC,
> +};
> +
>  struct sort_entry sort_mem_daddr_sym = {
>  	.se_header	= "Data Symbol",
>  	.se_cmp		= sort__daddr_cmp,
> @@ -1853,6 +1872,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
>  	DIM(SORT_CODE_PAGE_SIZE, "code_page_size", sort_code_page_size),
>  	DIM(SORT_LOCAL_INS_LAT, "local_ins_lat", sort_local_ins_lat),
>  	DIM(SORT_GLOBAL_INS_LAT, "ins_lat", sort_global_ins_lat),
> +	DIM(SORT_P_STAGE_CYC, "p_stage_cyc", sort_p_stage_cyc),

this might be out of scope for this patch, but would it make sense
to add arch specific sort dimension? so the specific column is
not even visible on arch that it's not supported on


>  };
>  
>  #undef DIM
> diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
> index 63f67a3f3630..23b20cbbc846 100644
> --- a/tools/perf/util/sort.h
> +++ b/tools/perf/util/sort.h
> @@ -51,6 +51,7 @@ struct he_stat {
>  	u64			period_guest_us;
>  	u64			weight;
>  	u64			ins_lat;
> +	u64			p_stage_cyc;
>  	u32			nr_events;
>  };
>  
> @@ -234,6 +235,7 @@ enum sort_type {
>  	SORT_CODE_PAGE_SIZE,
>  	SORT_LOCAL_INS_LAT,
>  	SORT_GLOBAL_INS_LAT,
> +	SORT_P_STAGE_CYC,

we could have the whole 'SORT_PEPELINE_STAGE_CYC',
so it's more obvious

thanks,
jirka

