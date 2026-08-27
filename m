Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7783F107D
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787867718; cv=none; b=LtDmeW57GWFK+6z3omVO+EUgUSuscBV+yLz9SsVzp4l1uHhCgLujX5TqXs4cq4H+rkiKye/q6/24e+qXHT11kqcfMAc4IqFjxJbsnDYeFQjtt04/KGLPsTeIE0xIW1L0/tBVWIP9KIKC04UFwZ7XaCP/+yeDCGcxvALXMRuCfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787867718; c=relaxed/simple;
	bh=0Zz1Wedbck01DSQhuAE3VTKd6DsNDpeBLEGbDJaTxy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvGaZWiu3QiSVra44IGIGYLgvfWTp6uEss1UI7v+lTyFE9zTqOC9Phv0kQQuqbjh+0BtwjgGJdAFlc5Wk20f9i9hc1dTJqGCw1fNgWd19+LP6JhFs7nBmaima7erGbR5yMiaRfS23ieWj/oaGqqy83AGIFdNi/pgDVzbAi/X0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dphhwz9v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dphhwz9v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1CA1F00A3A;
	Thu, 27 Aug 2026 21:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787867717;
	bh=uNtRa3WsbwV8YWEJkJ2wUF0W4jSoTvwivPTTpmsMLuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dphhwz9vnQybFcGU8T4pNMiFNkDaP+yAUYuK70JhMfSdvIP36fvBdFRl2ZjxALbHN
	 rASv0Q38OTZElJ6gNk0HR8F/EbrTxjXxoM0dWqfk+iuqkMH3NYc6FLWZs5sx/hMF2e
	 dg9oxHznmTm1gMr8ZRN4CJDL5UvpYqd+mg3Frd2SopmNlVjmSdaUUdlOqpZZVNnus+
	 j8Fe4gd82AlVyhJFNgtk4jq9mCgf2+OIjNkPlcBwXq2U+pPdKnaxc2ITutVCGPa2KL
	 Pje0Z7i7zXQTgzh5YreysWx5BZ3SId5oupn2D12iWgTCJD6sCxUce3dWjCgyO9dSoa
	 fKWl50p/o+Qag==
Date: Thu, 27 Aug 2026 14:55:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Gennady Kupava <gennady.kupava@gmail.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
Message-ID: <apCyQ93c48Dy4H-S@google.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>

Hello,

Thanks a lot for your detailed report!  It's good but let me jump into
the action items directly.

On Fri, Aug 21, 2026 at 10:49:59PM +0100, Gennady Kupava wrote:
[SNIP]
> Suggestions and questions
> =========================
> 
> 1. Kernel: the fix that was applied to the kernel-side call chain -
>    passing iregs rather than the modified regs - looks like it applies
>    verbatim to PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER.  Should
>    those be derived from iregs too when the event requests a user stack
>    dump?  If the precise IP is worth keeping in the sample regardless,
>    should such samples carry a flag, so that userspace knows the IP and the
>    stack do not belong together?  Today nothing distinguishes them.

As Ravi said, you can check the misc field if the IP is from precise
events.

And there's PERF_SAMPLE_REGS_INTR which I believe captures registers
from the interrupt handler.  I don't remember why we have both REGS_USER
and REGS_INTR but it seems REGS_INTR would work for callchains.

> 
> 2. perf: precise events and DWARF call graphs are mutually exclusive on this
>    hardware, so arguably perf should simply not let the two be combined.  I
>    would suggest two rules rather than one, because a blanket refusal would
>    make the common case worse:
> 
>    - for the default event, drop the P when --call-graph dwarf is requested,
>      silently and on PMUs where precision means IBS.  Otherwise a plain
>      "perf record -g --call-graph dwarf" starts failing outright on every AMD
>      box, which is worse than today.  The s390 case in evlist.c suggests this
>      kind of substitution is considered acceptable;
> 
>    - if the user asked for a precise event explicitly and also asked for
>      DWARF call chains, refuse with a message that says why and what to do,
>      instead of quietly producing a useless result.
> 
>    Note that this should be scoped to IBS.  On Intel, PEBS records the whole
>    register set, so precise events and DWARF unwinding work together there
>    and nothing needs restricting.  Frame-pointer call graphs are also fine
>    with precise events - only the leaf frame is off.

I think we can enable both precise IP and dwarf callchains by using
PERF_SAMPLE_REGS_INTR.  For unwinding, it should use PERF_REG_X86_IP
from the REGS_INTR instead of sample.ip

> 
> 3. perf: a single-frame result should probably not count as unwinder success
>    and suppress the fallback.  This one looks like a small, contained fix.

Sounds ok.

> 
> 4. perf: a way to choose the unwinder explicitly - an option or an
>    environment variable - would have saved most of this investigation.

It seems we have --unwind-style option in perf report but not in perf
annotate.  But we can try "unwind.style" config option.  Unfortunately
it doesn't seem to have documentation.

> 
> 5. libdw: the lld layout case is worth fixing, or at least worth recording
>    somewhere, given how much clang output it covers.

Have you checked the latest version?

> 
> 6. Documentation: perf-amd-ibs(1) and perf-record(1) could say that precise
>    events on AMD are incompatible with --call-graph dwarf.  A single sentence
>    would have saved a day here.

We can improve documentation always, but as I said I think we can make
them work.

[SNIP]
> == end of AI description
> 
> I hope it was an interesting read!
> Let me know if I could do anything here, I will be happy to help fixing
> these problems.  Hope this would help anybody, and looking for the feedback.

Thanks, it was a long but interesting read. :)

Sorry for your inconvenience you faced.  I haven't look at dwarf
unwinding for a while and thought libdw was good enough.  But supporting
multiple libraries for the same purpose is hard so we wanted to go with
libdw and deprecated libunwind.  I'm not sure if we need to revisit it.

Thanks,
Namhyung

