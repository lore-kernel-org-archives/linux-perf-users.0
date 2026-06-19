Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC83026F288;
	Fri, 19 Jun 2026 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883083; cv=none; b=Vlv9+2MEf35nnSyHbe8vTJOx5OIIPQlIz+9kjSA1UySRuZrpBIQgvAuP8v4QgqT6sgeImT5lB/VcZlW/ZHW9iOF/nqhYr/v/E+tSLR4LPDx+gLloR5KktkQlPt8EVtJkLIbr2BlGUIEUVtrZu1amyZkOJtPzsSxL82RU77rK1/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883083; c=relaxed/simple;
	bh=n0BxXaelWt7hVoWvLEi8VdepdVYC6znVH4F/sIdhy/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUvgOTP8+s9eCynl8zu1RT5nwXSzI2gX/XLPSo6KBRhK3PrLvJ2QAP3OSQ7Tn6ebLs/0pv+0PyFjdu6BkaMGiUU8t5N7XP9TnWnGMLmsvRJWMUTI8feQXrRKygypJriojrXC97rPMDZx3qkcRABs2u+CFxr5oWv1ZZWM6G7fAtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlMgV1cE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlMgV1cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454DB1F000E9;
	Fri, 19 Jun 2026 15:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781883082;
	bh=GKYWa/kKv1FUIk4EMf+/2smVEZNT8x+DETzoP4RcXu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QlMgV1cE6tVSJJtcjO3IAoVO8QeR02Q1zvHqIiCw4J1DztrwmVSTyv/zvRTiVxJdp
	 hYwxhhQfpaSUHeMYCHCvNefRO8iES/W8FA2MqXJgnfML08HePpIyek48scePYPLsEL
	 VxJinvk+RJTDshiNIGF24cC4+tDTxOasXwUqdh4X+f49L3jX2qpOM7JiX6/yXZQByW
	 BeTjqCGGUBIYKAzhnrSvtoiXQMvJf2yzD3q+s6cTzAddXbzAZuF0/wGoy6YJlpB/9O
	 gB4ay+GChKVb68jzzvr4D+XugLsIBLp90wxt4s5eGH91yCA21YkGR+1y+Enj1AaWU3
	 6x7G0ZRjAfhug==
Date: Fri, 19 Jun 2026 16:31:14 +0100
From: Will Deacon <will@kernel.org>
To: Fredrik Markstrom <fredrik.markstrom@est.tech>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Olof Johansson <olof@lixom.net>, Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	Ivar Holmqvist <ivar.holmqvist@est.tech>,
	Malin Jonsson <malin.jonsson@est.tech>
Subject: Re: [PATCH v2 0/3] arm64: perf: Skip device memory during user
 callchain unwinding
Message-ID: <ajVgwgSl1Pf7d_Z8@willie-the-truck>
References: <20260430-master-with-pfix-v3-v2-0-bd526ec04a75@est.tech>
 <agsq4wZMGth-T3BG@willie-the-truck>
 <agweYAbxRWOs41BE@elx-5cg6022w5t>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agweYAbxRWOs41BE@elx-5cg6022w5t>

On Tue, May 19, 2026 at 10:25:04AM +0200, Fredrik Markstrom wrote:
> On Mon, May 18, 2026 at 04:06:11PM +0100, Will Deacon wrote:
> > On Thu, Apr 30, 2026 at 12:55:12PM +0200, Fredrik Markstrom wrote:
> > > Perf callchain unwinding follows userspace frame pointers via
> > > copy_from_user. A corrupted or malicious frame pointer can point
> > > into device I/O memory mapped into the process (e.g. via UIO or
> > > /dev/mem), causing the kernel to read from MMIO regions in PMU
> > > interrupt context. Such reads can have side effects on hardware
> > > (clearing status registers, advancing FIFOs, triggering DMA) and
> > > on arm64 can produce a synchronous external abort that panics the
> > > kernel.
> > 
> > Hmm, but why is unwinding special in this case? If userspace has access
> > to sensitive MMIO/device mappings, it can presumably pass them to
> > syscalls and trigger crashes all over the place?
> 
> You’re totally right, a broken app with access to hardware like this can
> already cause chaos by passing bad pointers to syscalls etc. But the big
> difference here is who is to blame when things crash.
>  
> If an app passes a bad pointer to a syscall, it’s self-inflicted.

So I was going to argue that building arm64 code without frame-pointers
is self-inflicted, but it looks like that's the default in GCC for some
bizarre reason.

> Unwinding here is asynchronous and unrelated to the application.
> Perf interrupts a perfectly healthy app at a random moment. If that app
> is using the frame pointer as a normal register (totally legal in
> optimized code), it might hold a junk value that points to MMIO memory.
>
> If the kernel blindly follows that junk pointer during an unwind, perf
> causes the crash. I think it's acceptable that an app (with hardware
> access) causes a crash if buggy, but I don't think it's acceptable that
> a profiling tool is causing a crash just by looking at it.

I can see your argument, but I'm also not hugely keen to add fastgup to
our stack unwinder for each frame record. It's also not clear to me how
you avoid the mapping changing between the check and the access, given
that you still appear to use the user mapping for the unwind. Do other
architectures have this issue and, if so, how do they solve it?

If we could guarantee that the fault is synchronous, then we could
presumably hook up the uaccess exception fixup handlers.

Will
