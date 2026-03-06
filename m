Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A5481FB3
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772831633; cv=none; b=PDGT4LSdUshHP0oCwPcZU13cKfl+OpuKnhhHWv9W/9zhoSeToA9ToGTZwzj4dRPjOv+lp/z/QvG/YaJ4MRdeAdJY/aLBwgNhJZM6ut6FDPD8Fw2SxW2ndlZCwz4iStUT1lGTolQfZV3hLtk333vS8s8CWZ6DKsghg+QZGfebS2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772831633; c=relaxed/simple;
	bh=xLeiiAuxWI4SWc08bgqVdeXt16JUlRLlLuCLPKDnrWA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HWqv6OWvk5YvdTJugV08YmXzQSXDLTR+jgJHxjQr8/BzIEWI893DKAoWa24RUdvb7kgyOTXn/1txxfQ3dUzEkD0rjyujAB2pRfe3PWZBmk8XWsTHhwARSaZ7QtRKQ4kSrmUN9uzaa4d+mfOX5c1r4z9CfgQwfcNIx3UBxXEWdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWpikRpF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWpikRpF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772831631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wjUwOnsjFj7x2OOTndf56oD3Bdw2XZlDeep7pBKBPdQ=;
	b=YWpikRpFVUuZd2mATBNl5UbiqXT1fTvz43M6B/rncDRNAKfM4/SuQdj6EoNIQPUSLM2GtA
	cS8utO7YXMhy+rZb3UzhemTQzRuAuP5+j1AWlAS+BvkBf9RchTm1ce9n5IiqXGYyBaZZqG
	3nwLKq2CdW88UlKqyfW/TLaXiThCbjU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-wlCPo-W2OZ-cmwgxRCxpPQ-1; Fri,
 06 Mar 2026 16:13:46 -0500
X-MC-Unique: wlCPo-W2OZ-cmwgxRCxpPQ-1
X-Mimecast-MFC-AGG-ID: wlCPo-W2OZ-cmwgxRCxpPQ_1772831623
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9481E19560A3;
	Fri,  6 Mar 2026 21:13:43 +0000 (UTC)
Received: from Carbon (unknown [10.45.242.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 792931958DC5;
	Fri,  6 Mar 2026 21:13:33 +0000 (UTC)
Date: Fri, 6 Mar 2026 22:13:27 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
    Dapeng Mi <dapeng1.mi@linux.intel.com>, 
    James Clark <james.clark@linaro.org>, 
    Sadasivan Shaiju <sadasivan.shaiju2@amd.com>, x86@kernel.org, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Manali Shukla <manali.shukla@amd.com>, 
    Santosh Shukla <santosh.shukla@amd.com>, 
    Ananth Narayan <ananth.narayan@amd.com>, 
    Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 4/5] perf/amd/ibs: Avoid calling perf_allow_kernel()
 from the IBS NMI handler
In-Reply-To: <20260216042216.1440-5-ravi.bangoria@amd.com>
Message-ID: <e0c9b76-29a3-45c0-d2b9-039b9fc5025@redhat.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com> <20260216042216.1440-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, 16 Feb 2026, Ravi Bangoria wrote:
> Calling perf_allow_kernel() from the NMI context is unsafe and could be
> fatal. Capture the permission at event-initialization time by storing it
> in event->hw.flags, and have the NMI handler rely on that cached flag
> instead of making the call directly.
>

Hi Ravi.

I have tested this fix on a machine (below), which without this fix can
be easily crashed by recording ibs_op/l3missonly=1/ event.

With this fix, it survived 4900+ iterations without any crash.

CPU details
===========
BIOS CPU family:      107
CPU family:            26
Model:                  2
Stepping:               1

Thanks for fixing.

Cheers,
Michael

> Reported-by: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>
> Fixes: 50a53b60e141d ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>

Tested-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  arch/x86/events/amd/ibs.c          | 5 ++++-
>  arch/x86/events/perf_event_flags.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 05b7c9f2ec33..004226b52ac7 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -313,6 +313,9 @@ static int perf_ibs_init(struct perf_event *event)
>  	if (ret)
>  		return ret;
>  
> +	if (perf_allow_kernel())
> +		hwc->flags |= PERF_X86_EVENT_UNPRIVILEGED;
> +
>  	if (hwc->sample_period) {
>  		if (config & perf_ibs->cnt_mask)
>  			/* raw max_cnt may not be set */
> @@ -1349,7 +1352,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  	 * unprivileged users.
>  	 */
>  	if ((event->attr.sample_type & PERF_SAMPLE_RAW) &&
> -	    perf_allow_kernel()) {
> +	    (hwc->flags & PERF_X86_EVENT_UNPRIVILEGED)) {
>  		perf_ibs_phyaddr_clear(perf_ibs, &ibs_data);
>  	}
>  
> diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
> index 70078334e4a3..47f84ee8f540 100644
> --- a/arch/x86/events/perf_event_flags.h
> +++ b/arch/x86/events/perf_event_flags.h
> @@ -23,3 +23,4 @@ PERF_ARCH(PEBS_LAT_HYBRID,	0x0020000) /* ld and st lat for hybrid */
>  PERF_ARCH(NEEDS_BRANCH_STACK,	0x0040000) /* require branch stack setup */
>  PERF_ARCH(BRANCH_COUNTERS,	0x0080000) /* logs the counters in the extra space of each branch */
>  PERF_ARCH(ACR,			0x0100000) /* Auto counter reload */
> +PERF_ARCH(UNPRIVILEGED,		0x0200000) /* Unprivileged event (wrt perf_allow_kernel()) */
> -- 
> 2.43.0
> 
> 
> 

