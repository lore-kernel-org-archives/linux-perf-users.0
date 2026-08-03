Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF4D36B91B;
	Mon,  3 Aug 2026 23:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798467; cv=none; b=NqeiCJ22LCc0A4kkDENjY8xIYW90gNNAsJMxxnYzhOd3i0ADtnK4cfKlQV2lyoM7LX6zEHdt3RVZWlF4eP2u1eUsTxoYP6iIqiywCryfLvuBrRi6kH8SO3sKJzaqDiZpPEPSdZB1uqvD/BvOGIjnuD/G1tsvO9m/wA6qxFvkHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798467; c=relaxed/simple;
	bh=amXPFJ8CZHSnBlYniZ+PCleD1O16gx/BvELGX+UHbrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJlt8Z725nINMsnGR2us7rS+TZqlnQc0puR+E8pzR+19bMtFVjVUKTtlqaabYakExAtEwtfRCwRZw4H6WFeajeDu+U3GdiS1qUV56jOCj77tx5cf8PKlCHdv6j9Z4lDWYKWYuaVTWkPQ+xcaeJ68Eo4rXPDksnA0RIUrpnRy/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IlAB5D0f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlAB5D0f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7uIytpNge6chqys4rdDMfTYC2pXeWLCVjD81QhMZJmI=; b=IlAB5D0fNA5obkRDZHBVHlPkca
	KSK+H6BGdCwDLpnzXunhn3k6KfOzBlCIhmw+JQS2IxyPZxYQ1E78zEyLozBz+dLDdh/+IE5y1qalY
	v4aa64HFzGKybBUXuiDPnIpjmbqCRbKa8niSVdqE/P94jVdHOVeDPl+pJHSQ1UnBR1aB0YCvz1W8a
	pBr6ULwL83zkq+CSesOU/fDaIpgwMG7QacTdRg92e8D4+cXwWk/To6Fr/yrKDnjVolY9+LUS5CrgO
	GcVftxXA7xMQpmda4vsT/tiC8wkk8xmewGv8NJF1OJ+oEKpz2oBcS8XLQynoaxd/lKL1AdR5+lfSq
	ogyXsc4w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr1ki-0000000Ewhx-3KoB;
	Mon, 03 Aug 2026 23:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id CC55130063F; Tue, 04 Aug 2026 01:07:23 +0200 (CEST)
Date: Tue, 4 Aug 2026 01:07:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20260803230723.GI687043@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565871750.714490.5506415865016304088.stgit@devnote2>
 <20260803065744.GU49951@noisy.programming.kicks-ass.net>
 <20260804075517.1c1c9e2dc6ff66e0e73f946d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804075517.1c1c9e2dc6ff66e0e73f946d@kernel.org>

On Tue, Aug 04, 2026 at 07:55:17AM +0900, Masami Hiramatsu wrote:
> On Mon, 3 Aug 2026 08:57:44 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Aug 02, 2026 at 05:18:37PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Jinchao Wang <wangjinchao600@gmail.com>
> > > 
> > > Hardware breakpoint installation and removal run with IRQs disabled, but
> > > an NMI can still enter the same code through KGDB. The interrupted
> > > operation and the NMI can consequently claim the same slot or overwrite
> > > each other's DR7 state.
> > 
> > Is KGDB really the only way to trip this? Mostly I think we let KGDB
> > have the pieces if it does something 'funny'.
> 
> Hmm, I think even if so, this detection is better to be handled in
> hw_breakpoint layer. And I plan to use this from kprobe events,
> which is also a kind of NMI.
> 
> > 
> > > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > > index f846c15f21ca..9ef24b55737f 100644
> > > --- a/arch/x86/kernel/hw_breakpoint.c
> > > +++ b/arch/x86/kernel/hw_breakpoint.c
> > > @@ -40,6 +40,9 @@
> > >  DEFINE_PER_CPU(unsigned long, cpu_dr7);
> > >  EXPORT_PER_CPU_SYMBOL(cpu_dr7);
> > >  
> > > +/* Sequence number of the per-CPU DR7 state. */
> > > +DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);
> > 
> > > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > > index 3c9f60d6ca5a..f55a0cbd5927 100644
> > > --- a/arch/x86/kernel/nmi.c
> > > +++ b/arch/x86/kernel/nmi.c
> > > @@ -532,10 +532,13 @@ enum nmi_states {
> > >  static DEFINE_PER_CPU(enum nmi_states, nmi_state);
> > >  static DEFINE_PER_CPU(unsigned long, nmi_cr2);
> > >  static DEFINE_PER_CPU(unsigned long, nmi_dr7);
> > > +static DEFINE_PER_CPU(unsigned int, nmi_dr7_seq);
> > 
> > This is weird, why have two distinct sequence numbers for dr7?
> 
> nmi_dr7_seq is for sequence number of operation, which is for
> detecting dr7 overwrite in NMI.
> nmi_dr7 is for saving the DR7.

I mean cpu_dr7_seq and nmi_dr7_seq.
