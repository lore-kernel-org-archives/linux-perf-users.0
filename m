Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A6517C219;
	Wed, 18 Dec 2024 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528947; cv=none; b=Rx4b4MTV2FZ4RxoCaklxRZSPMFamjmHNwfEci1uOzWOIUTMHYjdRWMXDByGUTJqXAMGydnwSmzt9+1TGfPJ3EMhMdjYps26/IcyhEQgGBrkCGWf7pF6CzgO9ZRkprOcbCNRc/y+/X4ASLxq2kVHSC4A31V2JlvPz5hSwHay94q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528947; c=relaxed/simple;
	bh=D7cWWIvQwh5O9tC5oJbHE5MumiHQazOr6xkufVGYW/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdcpqxrBUu5KKdpTPymyziz9c8gfQFudp7I5T64U3t00DX++6zhpNobKlg6sAoX4X+2Rbgg7SXVw4odrq2dHY56rvI7J9rdeqk9E85Kv77EcQYD9dZtPnHPIHbP3B263xS4gaPBcHZ7C7Wgi6gJk1kJ01vgZUlz+6qPSZsZQcP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Se7f1PHB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Se7f1PHB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l1AuHd9GDhtVRCmR2f4GyFxYugPGmi36Q0VUqqJOy/s=; b=Se7f1PHBNk/JOyzY4wG5IRqsrT
	06lFMgneLv/QcmcevlB0zQsqixH5obNtJYscWJpscbEKKA2sVK+YC1EGytvjPzseKPZwEr6y6DY2B
	RJuLtRAxnRLiU5y+x+MGf4QJkJ0EwRW1vM4fwSyNB9yJtDhjVayEAsafBHC44FQcx1uvndwXFYZBJ
	330qW7GToKiCg5G0MdqQYdJKitilnTdONkaHwGWWiyILTYDSJ00dXYDJF/0QucfCLjk8D4TjMYhs2
	erqdVjEn1ryKmUtMwNj0LktdpSHRsgC/tC0rAd2iyTt4KOcPD/RbgX645SjK9WDICyOGeCbbndLwk
	bUxvMZng==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNuD8-000000004C4-1bnl;
	Wed, 18 Dec 2024 13:35:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 22F7D3002A0; Wed, 18 Dec 2024 14:35:34 +0100 (CET)
Date: Wed, 18 Dec 2024 14:35:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@redhat.com, namhyung@kernel.org, acme@kernel.org,
	eranian@google.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	santosh.shukla@amd.com, ananth.narayan@amd.com,
	sandipan.das@amd.com
Subject: Re: [PATCH v3 02/10] perf/amd/ibs: Remove pointless sample period
 check
Message-ID: <20241218133533.GD2354@noisy.programming.kicks-ass.net>
References: <20241210093449.1662-1-ravi.bangoria@amd.com>
 <20241210093449.1662-3-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093449.1662-3-ravi.bangoria@amd.com>

On Tue, Dec 10, 2024 at 09:34:41AM +0000, Ravi Bangoria wrote:
> Valid perf event sample period value for IBS PMUs (Fetch and Op both)
> is limited to multiple of 0x10. perf_ibs_init() has this check:
> 
>   if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
>           return -EINVAL;
> 
> But it's broken since hwc->sample_period will always be 0 when
> event->attr.sample_freq is 0 (irrespective of event->attr.freq value.)
> 
> One option to fix this is to change the condition:
> 
>   - if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
>   + if (!event->attr.freq && hwc->sample_period & 0x0f)
> 
> However, that will break all userspace tools which have been using IBS
> event with sample_period not multiple of 0x10.
> 
> Another option is to remove the condition altogether and mask lower
> nibble _silently_, same as what current code is inadvertently doing.
> I'm preferring this approach as it keeps the existing behavior.

Urgh... :/

> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  arch/x86/events/amd/ibs.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
> index 4ca8006d2221..bd8919e7c3b1 100644
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -307,13 +307,8 @@ static int perf_ibs_init(struct perf_event *event)
>  		if (config & perf_ibs->cnt_mask)
>  			/* raw max_cnt may not be set */
>  			return -EINVAL;
> -		if (!event->attr.sample_freq && hwc->sample_period & 0x0f)
> -			/*
> -			 * lower 4 bits can not be set in ibs max cnt,
> -			 * but allowing it in case we adjust the
> -			 * sample period to set a frequency.
> -			 */
> -			return -EINVAL;
> +
> +		/* Silently mask off lower nibble. IBS hw mandates it. */
>  		hwc->sample_period &= ~0x0FULL;
>  		if (!hwc->sample_period)
>  			hwc->sample_period = 0x10;
> -- 
> 2.43.0
> 
