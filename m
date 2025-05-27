Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643421E4BE;
	Tue, 27 May 2025 13:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351219; cv=none; b=ES0bJw4C50abG9OEirDhCgrgUkqwuFCTb0Uufbn55gbvAeLNgjawnlxn9O/fcg8Pe7UgO7ykL8/Pl/LKT3g7JNtgNnUFpNFTn0bAXa86bARrcsXDJvmsFACipa8UlFWL1UxhgHBv1/5oaGtSnCoLm2mfLYMYCWwyKZ2dzb0fgzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351219; c=relaxed/simple;
	bh=J/kzqgFZuQJnCLBIhfO4WyhTv+nsnJm0UqFIpedFc6c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YahzAA/UWPzpoZMGIWc8zI/IJ5qhx6lEbbFzvkx0ej776LULhf+8pr5TiJLIEbiXwsT+J5KekrW8bSSu2wIw1qJ9nUsfK4yqqPgz5KmVTWoLKXv6wSjGDIlNAWJWS8kQWcgbAFg2d4teTaWLWjo4+tVjcyPO6tw9AalGRsvtvs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81FDA14BF;
	Tue, 27 May 2025 06:06:39 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AD593F673;
	Tue, 27 May 2025 06:06:54 -0700 (PDT)
Date: Tue, 27 May 2025 14:06:50 +0100
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_spe: Relax period restriction
Message-ID: <20250527130650.GH2566836@e132581.arm.com>
References: <20250527121827.3919495-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527121827.3919495-1-leo.yan@arm.com>

Hi all,

On Tue, May 27, 2025 at 01:18:27PM +0100, Leo Yan wrote:

[...]

> @@ -309,15 +309,22 @@ static u64 arm_spe_event_to_pmscr(struct perf_event *event)
>  static void arm_spe_event_sanitise_period(struct perf_event *event)
>  {
>  	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +	struct device *dev = &spe_pmu->pdev->dev;
>  	u64 period = event->hw.sample_period;
>  	u64 max_period = PMSIRR_EL1_INTERVAL_MASK;
>  
> -	if (period < spe_pmu->min_period)
> -		period = spe_pmu->min_period;
> -	else if (period > max_period)
> +	if (period < spe_pmu->min_period) {
> +		/* Period must set to a non-zero value */
> +		if (!period)
> +			period = 1;

I read the document again and found the interval granluarity is 256
(8-bit).  So the change above is incorrect.

I will send a new patch.  Sorry for inconvenience.

Thanks,
Leo

> +
> +		dev_warn_ratelimited(dev, "Period %llu < %u (recommended minimum interval).\n",
> +				     period, spe_pmu->min_period);
> +	} else if (period > max_period) {
>  		period = max_period;
> -	else
> +	} else {
>  		period &= max_period;
> +	}
>  
>  	event->hw.sample_period = period;
>  }
> -- 
> 2.34.1
> 
