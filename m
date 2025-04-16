Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9E5230D0D;
	Wed, 16 Apr 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793179; cv=none; b=OAJdzmdslozz8Kz5q2HqE8rsRS/NRwhnoZUz0khHR/nO2hDlkXr0qYt7I3MDnEISPEkfg/NfegHKT940X7GVe4xGF1eIeC/mTXkuMmaXdLgKyMmyf/yFzak56rd66byapgKbSGxk02551WlXMOqwyBrrtM5qAUBW6heAovH8Gq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793179; c=relaxed/simple;
	bh=sgfq/sjo4KcVlI97Zo4VCiXUjL7HbZVp1G7Dq913hXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aETxgnknt0ADsQpDjHzN6Bfrn9HbaLvZTrDV6GnztcRJun3kA2/OPbVRn9UwqQqxLEX9rE/WTaC75rf0x/sYyowPWSMkHlWErhrTWOLGkGuhGq/Ph+LHQoya2IZjPJsjXoxcmNImNwSegTnmtA8k/GKAWwHmGhm/pRWjqb2Kv1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DQvbupuV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQvbupuV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=utT1YVXkOVco/1TLCd3HJTg8je+9W8OCVRPlZ7QnIIA=; b=DQvbupuVnqjY1VRZVMasyCI1ED
	silJbqbQ3VPNencqBudbdP31eaEoYDR3M5l5Y1aykocLPb311T09+ZcoccriNSlChR4+Dsw9iiyfO
	T1ym+W0/t5aSYjygZJglyxd/txsoo1nDPWe+3jIudnFpiqty6C5fUbl9fXp4V/t4rup661F8NxMVM
	rrgOutKpkQSxwDhsey5HUoMs2gCiPsRSuvAbN7m83GRl1NHeM+36H1UyF+6GNW5WStISRYFh7bS/Z
	pOMcuy/WpWRjBFqdvs1wr3UMDrp7HBdISZZGacHRDOYWVcjPdt+dKcUrMTNM0TrC/NBafXU469Pwp
	SxT9Tyvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4yPK-00000009w0f-0bSc;
	Wed, 16 Apr 2025 08:46:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 332ED3003C4; Wed, 16 Apr 2025 10:46:10 +0200 (CEST)
Date: Wed, 16 Apr 2025 10:46:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: James Clark <james.clark@linaro.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [tip:perf/core] [perf] da916e96e2:
 BUG:KASAN:null-ptr-deref_in_put_event
Message-ID: <20250416084610.GI4031@noisy.programming.kicks-ass.net>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
 <20250415131446.GN5600@noisy.programming.kicks-ass.net>
 <77036114-8723-4af9-a068-1d535f4e2e81@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77036114-8723-4af9-a068-1d535f4e2e81@linaro.org>

On Tue, Apr 15, 2025 at 04:52:56PM +0100, James Clark wrote:
> Unrelated to the pointer deref issue, I'm also seeing perf stat not working
> due to this commit. And that's both with and without this fixup:
> 
>  -> perf stat -- true
> 
>  Performance counter stats for 'true':
> 
>      <not counted> msec task-clock
> 
>      <not counted>      context-switches
> 
>      <not counted>      cpu-migrations
> 
>      <not counted>      page-faults
> 
>      <not counted>      armv8_cortex_a53/instructions/
> 
>      <not counted>      armv8_cortex_a57/instructions/
> 
>      <not counted>      armv8_cortex_a53/cycles/
> 
>      <not counted>      armv8_cortex_a57/cycles/
> 
>      <not counted>      armv8_cortex_a53/branches/
> 
>      <not counted>      armv8_cortex_a53/branch-misses/
> 
>      <not counted>      armv8_cortex_a57/branch-misses/
> 
> 
>        0.074139992 seconds time elapsed
> 
>        0.000000000 seconds user
>        0.054797000 seconds sys
> 
> Didn't look into it more other than bisecting it to this commit, but I can
> dig more unless the issue is obvious. This is on Arm big.LITTLE, although I
> didn't test it elsewhere so I'm not sure if that's relevant or not.

I can reproduce on x86 alderlake (first machine I tried), so let me go
have a quick poke.
