Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5115ECD7;
	Wed,  9 Apr 2025 14:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208667; cv=none; b=DWBfqMKOm5/rbD6tncRZY7Ov3d9YNdrKsZzPsEydI6zbZ2BiOpBfzsQhMXY7NZqIPk/OVlOym6RiwJkxida2xDxjoLnSJ5MU0ffMKzpRN7NcG0yUTDGvzL66HTU2+8sGMJQqW5Nv49qBUAQw8CnX2cbddK5zMNVlJlwwYX2aEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208667; c=relaxed/simple;
	bh=xjRcRXL5ATlpoMXpxbIOd/1cQN8m5nW34dkCBKaINjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktSg7cSxfmBKSEM0Bxl0lv6EnftWrJE2hiz7jB2to/+Zc2OM6wNq35ufEXyEpROvX4GbZqWQ1LSgYelYTyIQ/sSnVlxmyV9hodQQxFcIA43Hje9n8M7acUeiI88k6N56nIvkgqSU2ZTAP2IwDZzvh35WLU1vVDdPdSFdx6Dyd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KTfCf3c8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTfCf3c8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QDUIJBUfUWetOQ9XbfKqZntOyLdSRCgncZqRn4gs3n8=; b=KTfCf3c8JRBefviFsqU+m7kWm+
	Sj2845Sdimp6jX0y275HopAZl44AeT36Kjv54ltI5NyUHgLevjKv43NxpThdXzfcHo9dRVHegRGjQ
	e/NE9h96bkM/Acyq8fczLJQEcOuUn97dkCTfXG7hTbEcDIhuthdHfH8dcoL/N71Q5wLDKb57buzIq
	rmobayGJc8GuAB2UIBPg3FxlodVRwWvCuyM98e+l/VJZv+EofA0bHMU/Lf57RjzSGKeyV1ToEDRQt
	g/dwSgYjVfT5pI3LFuniTt+fzZBU460QxhVZO9GC26rF8xXLanqYRkDxKjzG9h80H4yPgiXsdtSBh
	ODPFq3BQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2WLh-00000001ZhH-3Axy;
	Wed, 09 Apr 2025 14:24:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E9B433003FA; Wed,  9 Apr 2025 16:24:17 +0200 (CEST)
Date: Wed, 9 Apr 2025 16:24:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] perf: Allow adding fixed random jitter to the
 sampling period
Message-ID: <20250409142417.GC9833@noisy.programming.kicks-ass.net>
References: <20250408171530.140858-1-mark.barnett@arm.com>
 <20250408171530.140858-4-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171530.140858-4-mark.barnett@arm.com>

On Tue, Apr 08, 2025 at 06:15:28PM +0100, mark.barnett@arm.com wrote:
> @@ -10224,6 +10227,19 @@ static int __perf_event_overflow(struct perf_event *event,
>  	 *
>  	 * By ignoring the HF samples, we measure the actual period.
>  	 */
> +
> +	/*
> +	 * Apply optional jitter to the overall sample period
> +	 */
> +	if (hwc->sample_period_state & PERF_SPS_HF_RAND
> +			&& !(hwc->sample_period_state & PERF_SPS_HF_SAMPLE)) {

Coding style nit: when breaking lines, the operator goes on the end of
the preceding line.

> +		struct rnd_state *state = &get_cpu_var(sample_period_jitter_rnd);
> +		u64 rand_period = 1 << event->attr.hf_sample_rand;
> +
> +		sample_period -= rand_period / 2;
> +		sample_period += prandom_u32_state(state) & (rand_period - 1);
> +	}
> +
>  	if (hwc->sample_period_state & PERF_SPS_HF_ON) {
>  		u64 hf_sample_period = event->attr.hf_sample_period;
>  
