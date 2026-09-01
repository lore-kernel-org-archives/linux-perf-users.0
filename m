Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCD376A0C
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Sep 2026 15:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275969; cv=none; b=t11aHH/3bVSA4ixoAk0ft9+rrvx8w0siHcXMy2+jTh3+FnS7n3iDMpTxSPuK+XS5yGYXAkGURhriqAFq0S1BZ8KF/ZOCej2Z8y87wc/ImqhQwz3KFUL9Ku4izI8k9gWN+PVSBENUEYSvN5iioevTXWZvQZw2dwS9Jxt6QF45jTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275969; c=relaxed/simple;
	bh=ikM77BQb3gSVV9MV1IUUSeyWdagCQY8N1pGkDBFfNd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XidqJ2IiSGNLYi5SScf8zcLUZE41VZh/Xhgq8AmkE+keUj8gUsvlIJo324lQm8eGPlvOvLDSco5Cy8AU7ZEFaB8pVhY36GYVP6O8LH2iQF6EPbViRlsglNY70+wrgZlfF/2ivwL9Ro+0b1zOOPchN26jjovAEbhfm+o58ndGUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErmvdPLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErmvdPLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A91D1F000E9;
	Tue,  1 Sep 2026 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275967;
	bh=M5GJgH7tK/aB+QY7+3Giqrrf1wZG66CEieyPFriSz+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErmvdPLfkO439I3BeFUpf/2f/M9vHHRm23VX2O6xltwvmlcdcVpglCFhtKrCy67Z5
	 FKuAvrCo4MfFxdOVSY63/LRe8J7nOGu6PnQTm2fDcjLzi1+bnRek/U25YgyGf5adZM
	 PxJQeOWdM3xsoai3cFJg1XJYryPsywatvIQo01GiPGMxoMJF22G7MeUAsAxqLav7/y
	 jRt+XHCSqnmr0iYOIev1EpSRBheuUpqVs5W5O3r0FACq1b6adioAzN07VUQZn/cCYF
	 hJ9MI80wUcpb+Gg5x0TYr4kWZNowINCI2uL2O5YtG9ERi01axtK1KkUoyK2JNdJMQz
	 8UTzJD3zasXBw==
Date: Tue, 1 Sep 2026 08:19:14 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Gennady Kupava <gennady.kupava@gmail.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
Message-ID: <apbs8gywyAfFVzqm@google.com>
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com>
 <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com>

Hello,

On Mon, Aug 31, 2026 at 10:35:06AM +0530, Ravi Bangoria wrote:
> >>> 2. perf: precise events and DWARF call graphs are mutually exclusive on this
> >>>    hardware, so arguably perf should simply not let the two be combined.  I
> >>>    would suggest two rules rather than one, because a blanket refusal would
> >>>    make the common case worse:
> >>>
> >>>    - for the default event, drop the P when --call-graph dwarf is requested,
> >>>      silently and on PMUs where precision means IBS.  Otherwise a plain
> >>>      "perf record -g --call-graph dwarf" starts failing outright on every AMD
> >>>      box, which is worse than today.  The s390 case in evlist.c suggests this
> >>>      kind of substitution is considered acceptable;
> >>>
> >>>    - if the user asked for a precise event explicitly and also asked for
> >>>      DWARF call chains, refuse with a message that says why and what to do,
> >>>      instead of quietly producing a useless result.
> >>>
> >>>    Note that this should be scoped to IBS.  On Intel, PEBS records the whole
> >>>    register set, so precise events and DWARF unwinding work together there
> >>>    and nothing needs restricting.  Frame-pointer call graphs are also fine
> >>>    with precise events - only the leaf frame is off.
> >>
> >> I think we can enable both precise IP and dwarf callchains by using
> >> PERF_SAMPLE_REGS_INTR.  For unwinding, it should use PERF_REG_X86_IP
> >> from the REGS_INTR instead of sample.ip
> > 
> > Ok, it seems we already do this in the perf tools but it looks like the
> > kernel already overwrote the PERF_REG_X86_IP with the precise IP.  I
> > feel like we should fix the kernel.
> 
> This should resolve the DWARF unwinding issue with IBS PMUs:
> 
> --- a/arch/x86/events/amd/ibs.c
> +++ b/arch/x86/events/amd/ibs.c
> @@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>  			goto out;
>  		}
>  
> -		set_linear_ip(&regs, ibs_data.regs[1]);
> -		regs.flags |= PERF_EFLAGS_EXACT;
> +		if (event->attr.sample_type & PERF_SAMPLE_IP) {
> +			data.ip = ibs_data.regs[1];
> +			data.sample_flags |= PERF_SAMPLE_IP;
> +			regs.flags |= PERF_EFLAGS_EXACT;
> +		}
>  	}
>  
>  	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
> ---

Right, that's what I thought.  And I believe we should do similar on
Intel and not update other registers.

> 
> However, there's no way to address the stack being out of sync with the
> IBS RIP, since the IBS HW does not capture GPRs alongside the sample.

I think it's ok and we don't need to sync IP and stack.  The dwarf
unwind should start from stack and we can see the skid between IP and
the first entry of the callchain.

Thanks,
Namhyung

