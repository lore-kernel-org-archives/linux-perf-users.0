Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86A47580A;
	Thu, 15 Aug 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746378; cv=none; b=rwwMwNodAYy2wKHJGg1pdYgm3RhuaNm13rqTWBhTHB02EinpwYqE4/xHIb5eMt9TuZvbuR6kAKAZiC7aerNJU78rdISQs7MfhZQCFCsaIdTQnkM5OLwev31ji+RzmqDRVVwMA+ACMjMoatLxAAlqG2x/2T082pdSal4DppAC/xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746378; c=relaxed/simple;
	bh=crBNRdn3kANa0ObAmxWIhECCPK3KEeUgb3NkYmOc3kM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IzE8HnkOXxIXFWwfKflv9ZwONEpcxeLSFTKgG8RkC24d/BPy3dFuMLug9CpMsjgOGyZUQShJ5tdFMus6IDUCf896RU6fqXqf2P7uxL4xszil5ETSdaKXPos5VqBhOsjGyvbNtJXRpoYxiXwTzQOWAITY6Xlcx6zhbskZW6NhD+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oamQmRRO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GBePjJMg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oamQmRRO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GBePjJMg"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723746375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJC5UQOmLRaMOBBeNLpJyWreaWEOwAcESvL0GCeVa8=;
	b=oamQmRROEzg9EQsqvNkfihspZtEOcSxLiAdqrqY4QeohZ9hzCiNDgHM37rlz/K3NgPNhv+
	8mJaYiBapSyt4GlHnghYQNO0ZVnVPaJmh0YHXaRmMKEw/c9/wfBr3m2nwcZme+h93LJwZb
	l9e28OhqgKlwk3+9LZL3tdcErV0YJkM8XiXX8bGEVx1i80QPUAKLCJ9E64nSW8dcG+JkGe
	QfN4subGe/AMDw0NnUyQVQ894hyHhDbrGLxO+TwxC9bMDuf9Ndeo4ib4a63Pyo8+4Rq/WO
	r87ssegtaLEJhefDYAeNg0v4dfL/MrLt8KO7eaek+rjoc50UoDp05o72GciWYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723746375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zyJC5UQOmLRaMOBBeNLpJyWreaWEOwAcESvL0GCeVa8=;
	b=GBePjJMgsSTCpPNMKoRevjqPskY1RxKmG3w2k1sRC8CUCabawoY6Gr/hbNUdNkvh8QizLc
	ErPhUfUbkYBR+mAg==
To: "Liang, Kan" <kan.liang@linux.intel.com>, Li Huafei
 <lihuafei1@huawei.com>, peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Vince
 Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
In-Reply-To: <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
 <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
 <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com>
Date: Thu, 15 Aug 2024 20:26:14 +0200
Message-ID: <87wmkhlk1l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kan!

On Thu, Aug 15 2024 at 11:39, Kan Liang wrote:
> On 2024-08-14 6:47 p.m., Thomas Gleixner wrote:
>> Now the conclusion of this fun exercise is:
>>=20
>>     1) The hardware behaves differently when the perf event happens
>>        concurrently on HT siblings
>
> I think I found a related erratum.

> HSM154. Fixed-Function Performance Counter May Over Count Instructions
> Retired by 32 When Intel=C2=AE Hyper-Threading Technology is Enabled
>
> Problem: If, while Intel Hyper-Threading Technology is enabled, the
> IA32_FIXED_CTR0 MSR
> (309H) is enabled by setting bits 0 and/or 1 in the
> IA32_PERF_FIXED_CTR_CTRL MSR
> (38DH) before setting bit 32 in the IA32_PERF_GLOBAL_CTRL MSR (38FH) then
> IA32_FIXED_CTR0 may over count by up to 32.
>
> Implication: When this erratum occurs, the fixed-function performance
> counter IA32_FIXED_CTR0 may over count by up to 32.

Sure. That's only explaining half of the problem.

As I demonstrated in the non-contended case even with a count of 2 (I
tried 1 too) the status bit is never set on the second check.

Which is weird, because the number of instructions between setting the
count and re-checking the status MSR is definitely larger than 2 (or 1).

> Workaround: The following sequence avoids this erratum (steps 1 and 2
> are needed if the counter was previously enabled):
> 1. Clear bit 32 in the IA32_PERF_GLOBAL_CTRL MSR (38FH) and clear bits 1
> and 0 in the IA32_PERF_FIXED_CTR_CTRL MSR (38DH).
> 2. Zero the IA32_FIXED_CTR0 MSR.
> 3. Set bit 32 in the IA32_PERF_GLOBAL_CTRL MSR.
> 4. Set bits 0 and/or 1 in the IA32_PERF_FIXED_CTR_CTRL MSR as desired.
>
> It should explains that the issue is gone with the magic number 32 or
> disabling the Hyper-Threading.

It explains only half of it. If you use 32, then the counter is set to
-32 so the overcount of 32 will still bring it to 0, which should set
the status bit, no?

> I also found a related discussion about 9 years ago.
> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-=
weaver-1.umelst.maine.edu/
> Vince tried the workaround but it seems not work.

Let me play with that. :)

>>     2) The frequency estimation algorithm is broken
>
> For the events which occurs frequently, e.g., instructions, cycles, yes,
> the frequency estimation algorithm doesn't work well.
>
> But there are events that may not occur frequently. If a big init period
> is set, it may be impossible to get the required freq for those events.
>
> It's really hard to pick a universal init period that works for all
> events.

I understand that, but especially for RETIRED it's obvious :)

> I'm thinking perf may only calculate/pre-set a init period for the Linux
> defined architectural events, e.g., instructions, cycles, branches,
> cache related events, etc. For the other ARCH specific events, I'm
> afraid the period has to start 1.

Yes, that would be way better than what we have now.

>>=20
>>     3) Using a 'limit' guestimate is just papering over the underlying
>>        problems
>
> It's possible that a user set a small number with -c. If the number is
> less than the 'limit', it needs to be adjusted to avoid HW failure.
> I think the 'limit' is still required.

I'm not against the limit per se. I'm against guestimated limits which
are thrown into the code without understanding the underlying problem.

The just paper over it up to the point where they bite back because the
guestimate was off by $N.

Thanks,

        tglx
