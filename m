Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF153242D9
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773047251; cv=none; b=EfBy0MoRBgPa1vZhXlb/jq+0TAiKmN/adMOhAh0lNncll9tAb1SVOfTC5kleFN/PqWnIiZET5IlkOzItc+f5wV1rzPkx128VT2vk8A0iX0jEewcH54FfyurEmlvLQEY1Nf4JpJSeuZWH5hInsIy/NwBtiP7jD74NGZboHHcSsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773047251; c=relaxed/simple;
	bh=QhxXiXekcZm8Po9Np0iAPZoz/l5lb9YjQD4zTGA17gQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iT28tVjfnfF5DnhRZj/cEnav1eSDJtyDokSD1plI0aKQGQ0oL3Jtv+7fgMFHgDs1JX1fLyMKwD/REExAX1i5ImHXzC36AU9VZYxWztxnJbh5ANJ4J8JinEFOxszpoW+3ri6BeFQ1AS78BiqTkZ5GjFhkaZtwpaHXt4wHPt2yXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpsxJ28O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpsxJ28O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773047249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awTj8i86ypHKRz0ho2QP5VuJQavyhccBkYAt/5NH9HU=;
	b=fpsxJ28O17uzRgthIPAigfjNuXS7vlC5e6p9/egY01PUnGqOCkxxTH1O0jW/HWydmjMhKr
	QwT8OY6WQghLxB4ScB2bfj2P+FepTGWVZfSjw8cMIH6mLL1GN35zDmESuSSfv7CrI5Neti
	8HYhuh+nTgOM6xDVurmwxcOo0ElIp6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-0BK9Q8JGN7yG96CCMYGcdw-1; Mon,
 09 Mar 2026 05:07:26 -0400
X-MC-Unique: 0BK9Q8JGN7yG96CCMYGcdw-1
X-Mimecast-MFC-AGG-ID: 0BK9Q8JGN7yG96CCMYGcdw_1773047244
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 13EF01955DE2;
	Mon,  9 Mar 2026 09:07:23 +0000 (UTC)
Received: from Carbon (unknown [10.45.242.17])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C45CA30001BB;
	Mon,  9 Mar 2026 09:07:16 +0000 (UTC)
Date: Mon, 9 Mar 2026 10:07:12 +0100 (CET)
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
Message-ID: <81204aa7-9d81-8d53-b82b-6c4ad8c89c2@redhat.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com> <20260216042216.1440-5-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hello Ravi.

By evaluating the privileges at the event-init moment and using cached
value later, couldn't it lead to the cached value being obsolete at
some point? E.g. a setuid program later dropping the privileges but
still being able to read physical addresses? I don't think it can be
a solid attack-surface, but still may be worth of a thought... ?

Michael

On Mon, 16 Feb 2026, Ravi Bangoria wrote:
> Calling perf_allow_kernel() from the NMI context is unsafe and could be
> fatal. Capture the permission at event-initialization time by storing it
> in event->hw.flags, and have the NMI handler rely on that cached flag
> instead of making the call directly.
> 
> Reported-by: Sadasivan Shaiju <sadasivan.shaiju2@amd.com>
> Fixes: 50a53b60e141d ("perf/amd/ibs: Prevent leaking sensitive data to userspace")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
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

