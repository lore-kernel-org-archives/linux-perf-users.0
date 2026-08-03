Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347A139CD18;
	Mon,  3 Aug 2026 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740276; cv=none; b=XOVDccuOt7AdabT7SH1fUQYF5QHqsilycf+9iMe2w121w23abwPaPhrg396hWy4Q1V4hbc5NM7JRVU5m9dzu2gDpL5l0mqdXFtF+algpyXWPpt9qGOsvgvWWGd42/nce6Qsr7qLcLqRonXquPAHQmHmBgIrShrOSjcD24w7Gj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740276; c=relaxed/simple;
	bh=+Mv1NMXsr7rE6/f60LNjBlSpEQTm2YKOFDckKAG175k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRKODPE+NZXgjAdYm0372+AZ8eswKOLgd/Og+1kz0MQ9UIZ795XfamB9Ud6AJisRLIUuh59RTle9gszTlz4FBsdZ0X8Lj5+nnXR/HxMP4hFZqhZKeAfwZpQg1QJE9j7AL3QdHJx9lpu46Q2RlHXq/PBJEIsF5yLDR9eiLdolVuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LONXz4zM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LONXz4zM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gzp2V4d1Na4g1k1ABobiI65PmcOtyi96M8gvnAKH0bc=; b=LONXz4zMkEgieSL4FnSzrIDart
	JLwzm1ClwikORF7xnwuh8mkvAIdAt6vKfjt0Z/M1/WiF5J9R/5oB7GkbcnVK3Vd5ycuKYG53RSXpm
	r6sN9VRa9pbFbnG+JsggcQK+HdY+ISgWhDrDLfBMl6jT8fhRqyzkCJjR1AU07/qBPedNhnyaht3GU
	AfhRCo1+ai/txL3609mMPDrWhTyOAlEdp9rwpGAGoSWF/owoalrkccccp8VLAnrbpmrRkFCRNqUtP
	jYym1UtCgge7m+6K7LaIMEAsKzAbwUpMBCJE2woiprzEL3NWrtrg584St0cEelND4x+t6/F7+HtXr
	d0Rojuag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqmcK-00000008Ksq-49x4;
	Mon, 03 Aug 2026 06:57:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 127A630045A; Mon, 03 Aug 2026 08:57:44 +0200 (CEST)
Date: Mon, 3 Aug 2026 08:57:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 01/11] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-ID: <20260803065744.GU49951@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565871750.714490.5506415865016304088.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178565871750.714490.5506415865016304088.stgit@devnote2>

On Sun, Aug 02, 2026 at 05:18:37PM +0900, Masami Hiramatsu (Google) wrote:
> From: Jinchao Wang <wangjinchao600@gmail.com>
> 
> Hardware breakpoint installation and removal run with IRQs disabled, but
> an NMI can still enter the same code through KGDB. The interrupted
> operation and the NMI can consequently claim the same slot or overwrite
> each other's DR7 state.

Is KGDB really the only way to trip this? Mostly I think we let KGDB
have the pieces if it does something 'funny'.

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index f846c15f21ca..9ef24b55737f 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -40,6 +40,9 @@
>  DEFINE_PER_CPU(unsigned long, cpu_dr7);
>  EXPORT_PER_CPU_SYMBOL(cpu_dr7);
>  
> +/* Sequence number of the per-CPU DR7 state. */
> +DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);

> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 3c9f60d6ca5a..f55a0cbd5927 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -532,10 +532,13 @@ enum nmi_states {
>  static DEFINE_PER_CPU(enum nmi_states, nmi_state);
>  static DEFINE_PER_CPU(unsigned long, nmi_cr2);
>  static DEFINE_PER_CPU(unsigned long, nmi_dr7);
> +static DEFINE_PER_CPU(unsigned int, nmi_dr7_seq);

This is weird, why have two distinct sequence numbers for dr7?
