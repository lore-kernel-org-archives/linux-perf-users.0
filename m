Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B013BB68F;
	Fri,  4 Sep 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537252; cv=none; b=c9mR511N0Va81FUr2QFn9e1M/ZLEOarZTp0YlaBTe8z9n+X647z7anoqurOWO7lbk2JCVRyV+xXBx+W+c7p81v0EkuDDgx+26yUrRVA4X+94cTszZwwe/d4GSR/YKckjwOuWlfHHsZfEJq8kst1nvH7ViX+lr71BSpFYr2qZzPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537252; c=relaxed/simple;
	bh=fcE0qjmbQqnYiiwIMHIZXUGkLQxdfs+4zYEUQ4kPtYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPf3+Jljj7Ufkw2XWynM170GSr6sfPBEOcFfvUcf6WBQ1dNZI3M3/3Fc7wl3s1kH6rNtgO9sa9zrPBslVphwrkl43qGee6l9kJSLZJPK76jhuxGmrsgypHE3RIfblTlUAcaLAAqX8JwnxQB3WSvSF2Ba6YCUCSpRgxcVSwHsaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NR7VB0Ss; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PRf96zVM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NR7VB0Ss";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PRf96zVM"
Date: Fri, 4 Sep 2026 17:54:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788537246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPpOywhxUYpvbT8zIkFDQanZWuSbRMA9e7oK1b0gVM4=;
	b=NR7VB0SshEkCn8ekHb2VuYQmahkOVmFj0T4HAtnof/y45LI4Ur9o8FVFNKcCHcBczLkVH4
	5uW1CZ9m1/QixjwrJKM02hfNBizz/QbvR02e3Yg7l8uAhsegQw0p9vseu4uuah8MU3uIxB
	btZemSlkgPWGzBNl8d94W0M13DPyXEekq7LG84YlkNTzD3Lb60j8oICOQJlYKi2AxFOCdA
	QZH4JilKdFKek7TfoLvYfaY6gk0snmiDQAktXy/zZqnOuq/h6lSQJ6IT045UgRTEyKrqtd
	r2xBzacRa3vQWnsizQlyKGwfZPXXnLklqoLoACulN5mb6Wrbv0pcmXMR3xhXRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788537246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZPpOywhxUYpvbT8zIkFDQanZWuSbRMA9e7oK1b0gVM4=;
	b=PRf96zVMAqAIN/FHuit61LZUjh9q3Y2QWtWZZfbGqwKuSYPGqdsu0syV75ICLNaKC1XXKf
	KsR24XFsPNaLl5DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	James Clark <james.clark@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Waiman Long <longman@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH v2] ARM, ARM64, LONGARCH: Delay HW BP notification to
 task_work()
Message-ID: <20260904155404.ESPFg3zi@linutronix.de>
References: <20260814085118.OPEA_Ssn@linutronix.de>
 <20260903160710.vVf4gEL2@linutronix.de>
 <apmknG55qFAn8EPf@shell.armlinux.org.uk>
 <20260903133146.07095885@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903133146.07095885@gandalf.local.home>

On 2026-09-03 13:31:46 [-0400], Steven Rostedt wrote:
> On Thu, 3 Sep 2026 17:47:24 +0100
> Russell King <linux@armlinux.org.uk> wrote:
> 
> > What do you expect to happen with this? Which arch maintainer should
> > apply this patch that affects three different independently maintained
> > architectures?

Well, if you as the ARM person are fine with ARM part, an ACK would be
appreciated. If you have something to object, it would be nice to let me
know so I can adjust accordingly.

> Looks like the patch should be broken up into a 4 part series.
> 
> One to add the ARCH_NEED_PERF_HW_NOTIF code to the generic code.
> 
> Then one for each architecture to add the code needed to set that.
> 
> Then the architecture maintainers could ack their patch and the perf
> maintainer can pull it all in.

We could first agree if this is the right way of fixing it (from both,
perf side and ARCH side).
Then we could either route this via perf with ARCH's acks or split it
and route via individual trees if needed. Having it routed separately 
needs to be coordinated since the ARCH bits can't be applied without
having the perf bits first.
Then there is also the question if this should get fixes tag on commit
d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.") (which would also
cover loongarch and arm).

As of today I have just Luis responding that it works for him. 

> -- Steve

Sebastian
