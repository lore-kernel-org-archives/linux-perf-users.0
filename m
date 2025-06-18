Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8827EFE3
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247712; cv=none; b=NveEU88mpDaZN3ZALThZuQTGOEv3CrmKRY0SwUo+tXFXa6wAiDE7E2yOTQP1rmkW4ls1CesKwPnG4du7cD98IIPQ/s2WTDDrYsiOSUS6zjOw5kE68UFE/q424wPcpCkX6dvn00n/aCAqUjV4NbvQfMRfsL1l4K+RImaotCJZEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247712; c=relaxed/simple;
	bh=di7j2sI9VeQP7grby92NuI1bvE2BELjeKeHluSrZrD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nx4hJUhICrhAsZ0Y380iF64eHb134JQw7c805ELwBiERU4aAWhywdvoIQHSNrR1PFY0DBAmVXjvvdrxMY6RUN0A//hGhWCI1LAMzN/oMgdfnR2a+zskFUOnMA9Csdww2mstL5gM0sTQFX1hOcmtwtNBiEuu7i3thnm59dlEXi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TOOKe5m7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TOOKe5m7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DQ7OFDstlMo9HKGbh5TACJOXAw56Emu9AhkInMOjIkE=; b=TOOKe5m75erFMeTzhrFlw9uyh+
	VtrO/X+E/AojJI7nxD+BEIMWcKLHSvsq+5OeLq3Jwk3FYkIBBevWsOEunIPTPoD+B4akLqhdj2itH
	yLhfhKbWO/ATYNEJ3fqKCp9aBZa5w9f7i9vxOVXbDHvL0xjmNrH1VcE+nDKCGlost1Dw1HWdQgweW
	Xqwc4ybR4uV7s5h9dxY+G8xV7i6NmWxP6ieoOb/g75Y2UM+rvcPgPPvib7I/DiUXIG3qqUVWa4JgO
	kgJoMWIQScbNT0e8ynf4QLBHnaugN/J859aBLk0WbLs6rkLGWRrcT72miaUGHApfwzmx0WSHJ/L54
	QNFqPyWw==;
Received: from 2001-1c00-8d82-d000-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d82:d000:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRrNh-000000041EQ-3fff;
	Wed, 18 Jun 2025 11:55:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6F31307FB7; Wed, 18 Jun 2025 13:55:03 +0200 (CEST)
Date: Wed, 18 Jun 2025 13:55:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ian Rogers <irogers@google.com>, x86@kernel.org
Cc: Vince Weaver <vincent.weaver@maine.edu>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
Message-ID: <20250618115503.GF1613633@noisy.programming.kicks-ass.net>
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com>
 <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
 <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
 <CAP-5=fWYfMe8y-xcZkkEnppA11+H0r33Xnn0Mn2d4_y3dortmQ@mail.gmail.com>
 <20250617181738.GD1613376@noisy.programming.kicks-ass.net>
 <CAP-5=fUbEuwHKOAJhvgHbbfg_f=KcED=9a94ra++cPbNLJP5BQ@mail.gmail.com>
 <20250618084522.GE1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618084522.GE1613376@noisy.programming.kicks-ass.net>

On Wed, Jun 18, 2025 at 10:45:22AM +0200, Peter Zijlstra wrote:

> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 9f88b8a78e50..90391526acf7 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -677,6 +677,43 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> +static bool fixup_rdpmc_exception(struct pt_regs *regs)
> +{
> +	struct mm_struct *mm = current->mm;
> +	u8 buf[MAX_INSN_SIZE];
> +	struct insn insn;
> +	int len;
> +
> +	len = insn_fetch_from_user(regs, buf);
> +	if (len <= 0)
> +		return false;
> +
> +	if (!insn_decode_from_regs(&insn, regs, buf, len))
> +		return false;
> +
> +	/* RDPMC */
> +	if (insn.opcode.bytes[0] != 0x0f || insn.opcode.bytes[1] != 0x33)
> +		return false;
> +
> +	if (!atomic_read(&mm->context.perf_rdpmc_allowed))
> +		return false;
> +
> +	/*
> +	 * So userspace RDPMC is allowed and took #GP.
> +	 *
> +	 * This means they got the index wrong. But per the ABI described in
> +	 * struct perf_event_mmap_page; this means they'll also fail the
> +	 * sequence lock and will retry the operation after re-reading the
> +	 * index.
> +	 *
> +	 * Fake out the RDPMC by returning all zeros and continue.
> +	 */
> +	regs->ax = 0;
> +	regs->dx = 0;

And alternative might be to return ~0UL in both registers. All 32bit
chips have limited counter width and this will set the high bits. All
64bit chips do no expect the high words of the registers to be set.

That way one could recognise the fail case; if that was so desired.

> +	regs->ip += insn.length;
> +	return true;
> +}
> +
>  static bool fixup_iopl_exception(struct pt_regs *regs)
>  {
>  	struct thread_struct *t = &current->thread;
> @@ -812,6 +849,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	}
>  
>  	if (user_mode(regs)) {
> +		if (fixup_rdpmc_exception(regs))
> +			goto exit;
> +
>  		if (fixup_iopl_exception(regs))
>  			goto exit;
>  
