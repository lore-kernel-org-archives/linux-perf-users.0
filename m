Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0A22617F;
	Tue, 11 Mar 2025 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693059; cv=none; b=nquXRAR7dmuCiCze2qKf6BnsWpbJk4rIMbVzIxVIQX4aElT0m4xDcSek/HZv7zZGAQ8CpnVQ1kcHpw5/Wwwbz2FKIqoc1I/FRGftT9O05AL9KKEDlzCP+IgnSl8L5M0fCxJft9VpourHPOzJpauZTlbCeRJ7nF+tjEzxXmhU8m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693059; c=relaxed/simple;
	bh=u5+36wvoqdMpgnssw/dMcbGSPAcoctY9pOKe849a86Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmOGeh2vD2zaY2K1qPTcx7qeXW04MvluhBSlA5mSZsH0tP57iqUWGlEuXQ4FHqKGEdmUa8FITcgJAkF2nzggBuJ2P2lBDLKDJb6Ykb7oNpTU5VekpQ1MpGHxf3Dajepd0mIN6jL1SljkVousGiwPGy0O2BYkrn9F45+DGuy7weU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nRv1eHpM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRv1eHpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+TSkJ/CLUn0erEj6Eb5oYVx4T0mqKWD6ulalhCQevTY=; b=nRv1eHpMSjU2DB1tU3WcGykNUH
	qYT2t7fDcKx0//VfL5kGnFrjZMT/MsKEjx47ARAFxh2BxtjdskAYMYKvLtY+e1v2krIz4KvvChJ2I
	/1+xypbWdJLLUOAdTq3wxihbKXXIDsiKfsZlz+rWu9M1pvPK3NGpXvyyN4+F4K3anWgWzaVUDVMxb
	HQObBuMFRGOlW1mmgDpbSu64OS0Jngc8CqqS6OJo45GrTZJ2xLpAKTjyUN2wgbwXldvg7xwjvEit3
	A2ZlghIFCyYig4PsXG9KD3GLwAVIZwZ0THYZ7S4uD4x5ZqZevhUpvhiZmeytYKIZp9TRtRmGGh7pj
	Fp0wLxpQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trxvM-0000000Gzhj-3xou;
	Tue, 11 Mar 2025 11:37:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A5DA13002C7; Tue, 11 Mar 2025 12:37:27 +0100 (CET)
Date: Tue, 11 Mar 2025 12:37:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mark.barnett@arm.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, ben.gainey@arm.com, deepak.surti@arm.com,
	ak@linux.intel.com, will@kernel.org, james.clark@arm.com,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/5] perf: Allow adding fixed random jitter to the
 alternate sampling period
Message-ID: <20250311113727.GB9968@noisy.programming.kicks-ass.net>
References: <20250307202247.648633-1-mark.barnett@arm.com>
 <20250307202247.648633-4-mark.barnett@arm.com>
 <20250311113128.GD19424@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311113128.GD19424@noisy.programming.kicks-ass.net>

On Tue, Mar 11, 2025 at 12:31:29PM +0100, Peter Zijlstra wrote:
> +	sample_period = hwc->sample_period_base;
> +	if (hwc->state & PERF_HES_HF_RAND) {
> +		u64 rand = 1 << event->attr.hf_sample_rand;
> +		sample_period -= rand / 2;
> +		sample_period += prandom_u32_state(&perf_rand) & (rand - 1);
> +	}
> +	if (hwc->state & PERF_HES_HF_ON) {
> +		u64 hf_sample_period = event->attr.hf_sample_period;
> +
> +		if (sample_period < hf_sample_period) {
> +			hwc->state &= ~PERF_HES_HF_ON;
> +			goto set_period;
> +		}
> +
> +		if (!(hwc->state & PERF_HES_HF_SAMPLE)) {
> +			hwc->sample_period -= hf_sample_period;
> +			hwc->state |= PERF_HES_HF_SAMPLE;
> +		} else {
> +			hwc->sample_period = hf_sample_period;
> +			hwc->state &= ~PERF_HES_HF_SAMPLE;

and obviously this should be the local sample_period modified above, not
the hwc one.

> +		}
> +	}
> +set_period:
> +	hwc->sample_period = sample_period;
