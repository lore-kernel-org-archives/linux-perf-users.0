Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA840F756;
	Thu, 24 Sep 2026 09:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241802; cv=none; b=CHTpQtcDpy+Ld8dY1UEQFn3gNPXbPdZfZW2sb+sifRZfJftZY3Y3NBFtCdKqt8yFBc/fzJPbgF4syU+plDW9UuM5gBXFeoFwyPg3BhI0KyyyXw/QXmCqpHY4FgSfyAoVcjpJxtuo5dw0THl3aAZwgSLIVOG4282AwYf48zZM4u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241802; c=relaxed/simple;
	bh=mIWqxpXe1f/JRbhtXRH1IWJnglIazKRwROBHr9h4HSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpZFKHWeAvjvQsrbF8D1ZsJQylsafMjKdgVrDH0sKYExueSDVqguP4blhzXzXX1BrBv/9jX+y6BOZMcUV0n8oDGlz94rpu7T3IcqxOAKkXC7wvoDbCvWUa5xlJz8dA4HVuaaOAyRSgK4q5TE4i4FZynYeyj8fKv28rmGeMutTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O7eSUsFZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O7eSUsFZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zBBHsNZech7kugFPACfZViPCAUnJqI1aSxTF+T0JPTM=; b=O7eSUsFZI02my0ysO0tzCI2tR7
	bySebnV9hGlp4Rc+L3e/PI7ywwRM7R3IIemxjpWsDyNBDEehZOejSmK6zAW/I+AqXGnZNEvOlEVPm
	iEY89hNe00KdU1aS82N/bIYYfmYiZ+iq8ztIpwrOPxD85Oes4J0PDgpeWr1OQxK5hcuh+CPrLtekW
	y12oCcjFN5Y62MQPmWiBK6aHUMkkFtbte1WJiXx7A4WVJa14bj3ffxoe0qVHAuJQdPh8Hp7RzqILT
	NWZ8nIn0wOTHFcjPwHpgpJueNXl7++mggcBiuctnLrFTDv2lXucPzNJ0x3MvKGTiQyvTQlQln6x1J
	J2IvSaow==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9ffW-0000000FmXA-0Bd9;
	Thu, 24 Sep 2026 09:23:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0E42F3006DD; Thu, 24 Sep 2026 11:23:05 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:23:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sean Christopherson <seanjc@google.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Message-ID: <20260924092305.GL2009045@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2>
 <20260923091555.GX776954@noisy.programming.kicks-ass.net>
 <arPw-N3HF3ehNGTQ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPw-N3HF3ehNGTQ@google.com>

On Wed, Sep 23, 2026 at 08:32:08AM -0700, Sean Christopherson wrote:

> > > +		return -EBUSY;
> > > +
> > >  	for (i = 0; i < HBP_NUM; i++) {
> > >  		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > >  
> > 
> > Note how the other -EBUSY return is a WARN. Why is silently not doing
> > anything not a WARN in this case?
> 
> Probably because the WARN would trigger anytime KGDB's NMI craziness happens to
> hit a vCPU, i.e. isn't a kernel bug.

Yeah, but using KGDB to install a watchpoint would then have
perf/ptrace/whatnot trip the "Can't find any breakpoint slot" case and
WARN, even though it isn't actually their fault either.

