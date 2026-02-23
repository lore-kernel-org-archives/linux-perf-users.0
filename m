Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830D365A12
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Feb 2026 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849543; cv=none; b=DgxLQ4ms/g7vZYAfckedzb62EQ3b7laGgFlvp8AMF36+CZhiefE4+oA+7odv+b4GA0E5he3CfpxudYHTVOKpm7TefzejBY2xMuWTI8k2oGBb6mDeEw0AjZk8D/wWQ1nSfu6N/nao8qoPvUaHhHUVxefUfZneEWl0LM4mhdnYbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849543; c=relaxed/simple;
	bh=bhrLQQJp2WQsx6938rZMvGl+P0gSUC705eDDZ+boG5I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O/mtqU5jokwYSNDarGAfWdiHEvDGH46mzVrJLAsCUhoEuMlNwE/R+g/NZS2MEci6Tbr33QaR2N1bL1cJjgVa6w2USovm+Z822fXRoDs1usnqZkootQLOjmZTz5eqeY/R46breLsaSWN0knsd6L5F6qCzPx6kI72kXETRjqTa6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TfAgS1Lk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TfAgS1Lk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771849541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5FQ6M7OFu5xYX66DzT3ohEMtpWo7tpNCXWHYTmCBVA=;
	b=TfAgS1LksGFbmbdwt/HYPHh46Y9KpSIY0GwFSN5iL1+hAVzc0V+1JltZEICy7jMyHeyDUS
	ZMSeVRZ0EqpXMdghawaZ3qZbAVeQubwvgG8HlAEeiQr48/9cIMZBONVQt8NaiI3DcKZZYG
	x1NC7XUPZUbVDMS7xgCxDoE1EVNNmug=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-7zdBn13qPH2QtNK7Q8G8Vg-1; Mon,
 23 Feb 2026 07:25:35 -0500
X-MC-Unique: 7zdBn13qPH2QtNK7Q8G8Vg-1
X-Mimecast-MFC-AGG-ID: 7zdBn13qPH2QtNK7Q8G8Vg_1771849533
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 262B71956094;
	Mon, 23 Feb 2026 12:25:33 +0000 (UTC)
Received: from Carbon (unknown [10.44.22.3])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0116830001BE;
	Mon, 23 Feb 2026 12:25:26 +0000 (UTC)
Date: Mon, 23 Feb 2026 13:25:23 +0100 (CET)
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
Subject: Re: [PATCH v2 1/5] perf/amd/ibs: Account interrupt for discarded
 samples
In-Reply-To: <20260216042216.1440-2-ravi.bangoria@amd.com>
Message-ID: <79e0c820-e934-47a1-abd-3612e82b310@redhat.com>
References: <20260216042216.1440-1-ravi.bangoria@amd.com> <20260216042216.1440-2-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Ravi,

On Mon, 16 Feb 2026, Ravi Bangoria wrote:
> Add interrupt throttling accounting for below cases:
> 
>   o IBS Op PMU: A software filter (in addition to the hardware filter)
>     drops samples whose load latency is below the user-specified
>     threshold.
> 
>   o IBS Fetch PMU: Samples discarded due to the zero-RIP erratum (#1197).
> 
> Although these samples are discarded, the NMI cost is still incurred, so
> they should be counted for interrupt throttling.
> 

Maybe worth tagging

Fixes: 26db2e0c51fe83e1dd852c1321407835b481806e ("perf/x86/amd/ibs: Work around erratum #1197")
Fixes: d20610c19b4a22bc69085b7eb7a02741d51de30e ("perf/amd/ibs: Add support for OP Load Latency Filtering")

?

Cheers,
Michael

> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index aca89f23d2e0..705ef43325be 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1293,8 +1293,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		 * within [128, 2048] range.
>  		 */
>  		if (!op_data3.ld_op || !op_data3.dc_miss ||
> -		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF))
> +		    op_data3.dc_miss_lat <= (event->attr.config1 & 0xFFF)) {
> +			throttle = perf_event_account_interrupt(event);
>  			goto out;
> +		}
>  	}
>  
>  	/*
> @@ -1326,8 +1328,10 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  		regs.flags &= ~PERF_EFLAGS_EXACT;
>  	} else {
>  		/* Workaround for erratum #1197 */
> -		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1]))
> +		if (perf_ibs->fetch_ignore_if_zero_rip && !(ibs_data.regs[1])) {
> +			throttle = perf_event_account_interrupt(event);
>  			goto out;
> +		}
>  
>  		set_linear_ip(&regs, ibs_data.regs[1]);
>  		regs.flags |= PERF_EFLAGS_EXACT;
> -- 
> 2.43.0
> 
> 
> 

