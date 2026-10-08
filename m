Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8313CB2D5;
	Thu,  8 Oct 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487317; cv=none; b=PoBIhV8l8/PvsQvJNop1pqy/Uh4n979XZSkkmtbxDWKXXYJ7Mu6FXkBWCNGPsp6ZvJeKQeWnFtkFSkHxCQ0gJorCwGlBZnhVJzqb6yIf/1yyf6AEuKqJLG5z8FRa6hESga8z6d1sdTA2VDw7aIGrzG44qH6dm+GxeQNVRX/80IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487317; c=relaxed/simple;
	bh=KT5xxYs+F7TiyjMFMgj05iMIowCQI/KNSCor0NVfsHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTy4FnRRGfvhKMXzIhvhvuSkK1XxKz3oGpPx6WSyo/tJP3eMYWJVt7ylDgmiLNe62hSorFkspjrr4Jry6ee3DFHwHXQIDp+5e7S2ftAwCHPuY/fXybLiEV8I34jP6VVhADx99PxF8uKVwQPzB4DK4Il7ArkOqy3PjvWQLUVh/AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3NiQg1KM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BVMxivl8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3NiQg1KM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BVMxivl8"
Date: Thu, 8 Oct 2026 21:21:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791487313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+63oyHFpVlKLm2fFB+eRfZfb7Yox0WTva56stGfeC/M=;
	b=3NiQg1KM/RxrWv3Es8saISg/XEX0a7lyhAveiP9Hacs4na48cGEdg7ueZ1y22mY3KnoMyU
	jcvyh81zOjXYkNaa2mXRBXgDBEGBbADfkvOOxhfHxWRyINmeqWf6GGE8B6SGP6air25VHU
	9UuUkjEbbXEGmJTMP3+N4KmRJYmgd60xG4O0cdc0CTC65f+SMWWQHkDqnMqvxPBQ1Ses3r
	PN7v0XLiJtAk5G/z3itnHA4lbVcrKIKbQ4WqSbQLmSXDUwx0gWJgo4Iu1bbCuiPpPPpdDB
	l2wzUjmSbwTefo1Y7dNvDZSu4ZF4HGeUciWM85uoo1cz97dT38k75mzXtuTyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791487313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+63oyHFpVlKLm2fFB+eRfZfb7Yox0WTva56stGfeC/M=;
	b=BVMxivl8vZ4TUv3H5NJDMo+/BPW5ck32et6AZKG7cYAm1fHunVmkFylJ54M2+v26uqsj6S
	TKtEAhN0jmgfFyDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	WANG Xuerui <kernel@xen0n.name>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Linus Walleij <linusw@kernel.org>
Subject: Re: [PATCH v3] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Message-ID: <20261008192117.ZIKKU3Yh@linutronix.de>
References: <20261001143516.Ew8C97WS@linutronix.de>
 <fd405cda-51bd-4b1c-803c-f2597b2b128e@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd405cda-51bd-4b1c-803c-f2597b2b128e@arm.com>

On 2026-10-06 18:17:52 [+0100], Ada Couprie Diaz wrote:
> Hi Sebastian,
Hi Ada,

> I find the function names a bit counter-intuitive, compared to the other
> arch-specific perf functions.
> Given the name `perf_arch_...`, I would have expected them to be defined
> in arch code, rather than in the generic perf code.
> From what I can see, usually perf functions calling an arch-specific
> function lack the `_arch_` infix of their `arch_` counterpart.
> 
> I do not know very well what we expect in perf, so I might be off-base,
> but would calling them `perf_hwbp_send_sig()` and `perf_hwbp_notify()`
> make sense ?

Thanks for looking at this. I renamed them as:
- perf_arch_hwbp_notify() -> perf_hwbp_notify() (generic)
- arch_hwbp_send_sig() -> perf_arch_hwbp_send_sig() (arch specific)
- perf_arch_hwbp_send_sig() -> perf_hwbp_send_sig() (generic)

> Otherwise, it looks good to me on the arm64 side !
> I had a look on the arm side as well, given the debug handling architecture
> is similar, and I think it is OK on there as well, though I wouldn't mind
> a more experienced arm review :)
> 
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> 
> I also tested the patch with pNMI and CONFIG_PREEMPT_RT on arm64 : I can
> confirm that the atomic sleep warning is gone and everything works
> as expected !
> 
> Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com> (arm64)
> 
> Thanks a lot for looking into this, combined with[0] the hardware debug
> handling should be much cleaner ! :)

great.

> Kind regards,
> Ada

Sebastian
