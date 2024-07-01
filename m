Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD8757CBA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jul 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719817488; cv=none; b=PrVIQAVNNpgjO2Q0kJo/c9GLWAqCZXeGEO/qSSY1ZhvHu4Qf0xovApm3FP4pfbCt3rRPcbPipagLFePqopmIbrpj7I+m3gO/1CMavfjUWK5Tj4NlAmMBhthgZf9QpA4JtBNAL7A7Dl/ayEwcs85HKOYyLPSPzNI6wtgzrEByflo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719817488; c=relaxed/simple;
	bh=HzH63+31CffggOQJfu/2LqiwyDAQp5h2eo2DtvHmnE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLQevHqqJLo5skNWe2zvz/2Gt62BlvTN62t3qRAyLdifLVJupaU7LHpU/Zem/M832AKRiA6ErUaj49a2BY7uLZEv/qOVSdfOIGCGkjJF+VZklEWliNOYCYevdEWZ94oemv6tEAUnxHnSj8aVzb5CvTVndq9O2KOd+ipQCNd+BYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OY+73AeT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OY+73AeT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719817485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7IWbgI8OpLFL5NLVkU/tGT5K5w+kDRhC9wqoAvlMj8=;
	b=OY+73AeT0Xbn6CfoPzguZL53FfN0JvT1jIFIpnRoC6rKyzfR6OMseKbC+8BS2Z0rzuZp/Z
	TbwQrlwlMCRP6ulXedx4D2iH3MI9lxEzS3iL6/J0TNmEiZzQT+tQVUX+OH1eU+KVIH2J6w
	dxYTV83tTAPVbpnnW6haVIlNwzIbFYY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-mSaOVyHeMg2ZCrA_uiJeqw-1; Mon,
 01 Jul 2024 03:04:43 -0400
X-MC-Unique: mSaOVyHeMg2ZCrA_uiJeqw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B0DA196CE12;
	Mon,  1 Jul 2024 07:04:42 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B1721955E80;
	Mon,  1 Jul 2024 07:04:41 +0000 (UTC)
Date: Mon, 1 Jul 2024 09:04:38 +0200
From: Artem Savkov <asavkov@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <20240701070438.GA12242@alecto.usersys.redhat.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
 <20240626090924.GA56952@alecto.usersys.redhat.com>
 <Zn8M39dHtqYpRa0o@tassilo>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zn8M39dHtqYpRa0o@tassilo>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 28, 2024 at 12:19:59PM -0700, Andi Kleen wrote:
> > This works, however there seems to be yet another issue on
> > perf-tools-next branch that breaks script metrics.
> >
> > 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
> > events over legacy, 2024-04-15) changes event priority so on
> > my host "instructions" have type PERF_TYPE_RAW instead of
> > PERF_TYPE_HARDWARE.
>
> FWIW I don't see this on my build on Intel, even with that commit.
>
> > This results in evsel__stat_type no longer recognizing these as
> > STAT_INSTRUCTIONS.
>
> I guess we could just fix evsel__stat_type to handle that case
>
> Does this patch work?

It does for this specific example, but there are other events as well.
From arch/x86/events/intel/core.c:

        static u64 intel_perfmon_event_map[PERF_COUNT_HW_MAX] __read_mostly =
        {
                [PERF_COUNT_HW_CPU_CYCLES]		= 0x003c,
                [PERF_COUNT_HW_INSTRUCTIONS]		= 0x00c0,
                [PERF_COUNT_HW_CACHE_REFERENCES]	= 0x4f2e,
                [PERF_COUNT_HW_CACHE_MISSES]		= 0x412e,
                [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]	= 0x00c4,
                [PERF_COUNT_HW_BRANCH_MISSES]		= 0x00c5,
                [PERF_COUNT_HW_BUS_CYCLES]		= 0x013c,
                [PERF_COUNT_HW_REF_CPU_CYCLES]		= 0x0300, /* pseudo-encoding */
        };

The list is probably different on other arches.

> perf: Workaround event priority problems
>
> When instructions is not of HARDWARE types anymore, but raw,
> which breaks the shadow stat metrics detection for IPC.
>
> Reported-by: Artem Savkov <asavkov@redhat.com>
> Fixes: 617824a7f0f73 (perf parse-events: Prefer sysfs/JSON hardware
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 3466aa952442..87a503e47ff0 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -97,9 +97,11 @@ static enum stat_type evsel__stat_type(const struct evsel *evsel)
>
>  	if (evsel__is_clock(evsel))
>  		return STAT_NSECS;
> -	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES))
> +	else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES) ||
> +			!strcmp(evsel__name((struct evsel *)evsel), "cycles"))

It is also probably worth to add a PERF_TYPE_RAW check.

>  		return STAT_CYCLES;
> -	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS))
> +	else if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS) ||
> +			!strcmp(evsel__name((struct evsel *)evsel), "instructions"))
>  		return STAT_INSTRUCTIONS;
>  	else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
>  		return STAT_STALLED_CYCLES_FRONT;
>

--
 Artem

