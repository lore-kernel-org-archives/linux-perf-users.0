Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7474820E01B;
	Wed, 16 Apr 2025 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830506; cv=none; b=R8XubSaUflzW20pn22S4nWi+Aepg4ZRzpTJJ6vSgesSoGpuGnlAoesxHCwzXotcs4szEAJH+4nOAYiP4S+PevcZT4nN7UETbGwMg2Knf2brMKzqHjiWgDQ1kcs7WID2i4RdEfTvHRg6f6BZ5Y6kMCaXQZkSuz9GhGCQ4m0LnV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830506; c=relaxed/simple;
	bh=F0FWw8K56TAPzfRt8l/VSOM9RT1/VGs6vCusPtxq0U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqYLfF14zG3PhU547IpGazCuw/M9e13jhjG6BdNUf8IMEaZ3wYhBMdNOtJp2JfZKhdskIPXUHymuUFTpkcToOD5mxzsoSjI8w/s82DYJjRLwwi+3CYJwQYr50CjpoefvsJiDwKMeGFwC1Qa9OwYq3JmRGYPg59f2JvLxBRzIb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eKkjyTEL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eKkjyTEL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wlXYbOhDlMhkMrq7m6QP+iyZwiwLXqT70nBz4FXDtJQ=; b=eKkjyTELjVZgNES073CmOxLCok
	iZewS6LNlg20ZvcGIjbd8g9WMpg/GSx8BuMqw0yrQy3ksdqDdaCxWn2hrZiReJrI4iSV9Nyh1mIJ7
	SkQSJvKHaP6d5p/zm+nSQY8wJ45WqyNBN4Yi4nWkOUXp6sbqwC7YvtFCvl//v9TFddIuxmPqH5pd3
	e5xBoARn/LDNCzVzu2ouMvOgvOmmO++kSUxPp/uuqJ1ccCv2wV4A740+HQIRlVFhwVF9KSMYuijTu
	aOONDp9pHcTLhRuiVVMb/57Exul1KL+b0PcwTcYbYBnMEpEXatqRYCjYFhAsD72KpGTeenCaCTRso
	RzjbQ07A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u587O-0000000AS5E-2PEw;
	Wed, 16 Apr 2025 19:08:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DE17D3003C4; Wed, 16 Apr 2025 21:08:17 +0200 (CEST)
Date: Wed, 16 Apr 2025 21:08:17 +0200
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
Message-ID: <20250416190817.GD6580@noisy.programming.kicks-ass.net>
References: <202504131701.941039cd-lkp@intel.com>
 <20250414190138.GB13096@noisy.programming.kicks-ass.net>
 <Z/3krxHJLaWJTj4R@xsang-OptiPlex-9020>
 <5bc5f54b-ce6a-4834-86d4-5014d44c7217@linaro.org>
 <20250415100840.GM5600@noisy.programming.kicks-ass.net>
 <20250415131446.GN5600@noisy.programming.kicks-ass.net>
 <77036114-8723-4af9-a068-1d535f4e2e81@linaro.org>
 <20250416084610.GI4031@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416084610.GI4031@noisy.programming.kicks-ass.net>

On Wed, Apr 16, 2025 at 10:46:10AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 04:52:56PM +0100, James Clark wrote:
> > Unrelated to the pointer deref issue, I'm also seeing perf stat not working
> > due to this commit. And that's both with and without this fixup:
> > 
> >  -> perf stat -- true
> > 
> >  Performance counter stats for 'true':
> > 
> >      <not counted> msec task-clock
> > 
> >      <not counted>      context-switches
> > 
> >      <not counted>      cpu-migrations
> > 
> >      <not counted>      page-faults
> > 
> >      <not counted>      armv8_cortex_a53/instructions/
> > 
> >      <not counted>      armv8_cortex_a57/instructions/
> > 
> >      <not counted>      armv8_cortex_a53/cycles/
> > 
> >      <not counted>      armv8_cortex_a57/cycles/
> > 
> >      <not counted>      armv8_cortex_a53/branches/
> > 
> >      <not counted>      armv8_cortex_a53/branch-misses/
> > 
> >      <not counted>      armv8_cortex_a57/branch-misses/
> > 
> > 
> >        0.074139992 seconds time elapsed
> > 
> >        0.000000000 seconds user
> >        0.054797000 seconds sys
> > 
> > Didn't look into it more other than bisecting it to this commit, but I can
> > dig more unless the issue is obvious. This is on Arm big.LITTLE, although I
> > didn't test it elsewhere so I'm not sure if that's relevant or not.
> 
> I can reproduce on x86 alderlake (first machine I tried), so let me go
> have a quick poke.

Could you please try queue.git/perf/core ? I've fixed this and found
another problem.

I'll post the patches tomorrow, after the robot has had a go.
