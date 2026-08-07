Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827E12B94;
	Fri,  7 Aug 2026 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786072722; cv=none; b=mrSYoK4P92i7laq+tZHOmurElXo0H6mK9NvgNK/NKqF2/zJm4AtjkembfJdeQyfS3WGMtPQAKo+/7w9NgwDjO5PNr4eUAOZsURR8P1API4PfCxsmMp4zPxMcKjf0NcNP2ULyunDsWfOak8I3JXr/RrS1t/8m6OqYz8VK0AwjaeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786072722; c=relaxed/simple;
	bh=s23l0O6fCghOlWr/zsMY0OzB9sZzX7MTVfXtPB7jxlI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F5MF1BShN3rY3K1UByrSdRAH2gEvzMzIcZJ/EMNPKbh7iUeXQOe2YGggIPoUHXQdn1zuETbcdYCHgSTPpl1EhMU7ujAi5J3za7s9/sHVBvOZzXwZ5hkJkjl+cE/+HeWTlTbtTTQdMzdDZse1IAuuIXgwrJxOk8IADlXuV5rzTuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=La2ce4kY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="La2ce4kY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD721F000E9;
	Fri,  7 Aug 2026 03:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786072721;
	bh=Nf9aUtzxN4Fd2ktNXVpkAqfVgFak3j5BcrDp4kyVJyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=La2ce4kYXl+6fMdw/JB0W2b6eZKRqGmBTQdzn3a28YHbS+QIhcJsiE0W/qKEUvvMn
	 8S+02iCnmUgR06GlBOdCB7cIaQuZB7PY87dFiFWKC6ikUMXikKW9zlo/weap4g/Qip
	 Bj+MIzzGtz3cvdrbDic0pCFTgJwFbrLXtv9uhmRp04DufL5EypqBF9du7OTMQyzYBF
	 0m371Ibfy2Xt8BDcC814Q3p/sjhitDB3zm5CaUcSl4SnoVdxEv8EeCFgWGbj/NYQ8T
	 1lbIAB+rDlSDL/PDtCupTAXghjrW+fRFcGAQTyYct4KN63F0t7lkymu6cgilMBAwYl
	 CziK+nCJ+7+/Q==
Date: Fri, 7 Aug 2026 12:18:32 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
 Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 01/11] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260807121832.57dccaf6e6b25ef54bb0b0ca@kernel.org>
In-Reply-To: <20260806090735.0ee427ef5c18445b89d2f3cd@kernel.org>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565871750.714490.5506415865016304088.stgit@devnote2>
	<20260803065744.GU49951@noisy.programming.kicks-ass.net>
	<20260804075517.1c1c9e2dc6ff66e0e73f946d@kernel.org>
	<20260803230723.GI687043@noisy.programming.kicks-ass.net>
	<20260806090735.0ee427ef5c18445b89d2f3cd@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 09:07:35 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 4 Aug 2026 01:07:23 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Aug 04, 2026 at 07:55:17AM +0900, Masami Hiramatsu wrote:
> > > On Mon, 3 Aug 2026 08:57:44 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Sun, Aug 02, 2026 at 05:18:37PM +0900, Masami Hiramatsu (Google) wrote:
> > > > > From: Jinchao Wang <wangjinchao600@gmail.com>
> > > > > 
> > > > > Hardware breakpoint installation and removal run with IRQs disabled, but
> > > > > an NMI can still enter the same code through KGDB. The interrupted
> > > > > operation and the NMI can consequently claim the same slot or overwrite
> > > > > each other's DR7 state.
> > > > 
> > > > Is KGDB really the only way to trip this? Mostly I think we let KGDB
> > > > have the pieces if it does something 'funny'.
> > > 
> > > Hmm, I think even if so, this detection is better to be handled in
> > > hw_breakpoint layer. And I plan to use this from kprobe events,
> > > which is also a kind of NMI.
> > > 
> > > > 
> > > > > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > > > > index f846c15f21ca..9ef24b55737f 100644
> > > > > --- a/arch/x86/kernel/hw_breakpoint.c
> > > > > +++ b/arch/x86/kernel/hw_breakpoint.c
> > > > > @@ -40,6 +40,9 @@
> > > > >  DEFINE_PER_CPU(unsigned long, cpu_dr7);
> > > > >  EXPORT_PER_CPU_SYMBOL(cpu_dr7);
> > > > >  
> > > > > +/* Sequence number of the per-CPU DR7 state. */
> > > > > +DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);

This is actual sequence number.

> > > > 
> > > > > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > > > > index 3c9f60d6ca5a..f55a0cbd5927 100644
> > > > > --- a/arch/x86/kernel/nmi.c
> > > > > +++ b/arch/x86/kernel/nmi.c
> > > > > @@ -532,10 +532,13 @@ enum nmi_states {
> > > > >  static DEFINE_PER_CPU(enum nmi_states, nmi_state);
> > > > >  static DEFINE_PER_CPU(unsigned long, nmi_cr2);
> > > > >  static DEFINE_PER_CPU(unsigned long, nmi_dr7);
> > > > > +static DEFINE_PER_CPU(unsigned int, nmi_dr7_seq);

and this is a backup.

> > > > 
> > > > This is weird, why have two distinct sequence numbers for dr7?
> > > 
> > > nmi_dr7_seq is for sequence number of operation, which is for
> > > detecting dr7 overwrite in NMI.
> > > nmi_dr7 is for saving the DR7.
> > 
> > I mean cpu_dr7_seq and nmi_dr7_seq.
> 
> Oops, Indeed. Let me fix it. Thanks!

BTW, do we really need nmi_dr7 as a per-cpu variable?

Since this patch changes local_db_save()/restore() to handle both
DR7 and its sequence number, we need to save/restore both.
I thought it is used for handling nested NMI but in exc_nmi, we have
this gate check before using the nmi_dr7.

	if (this_cpu_read(nmi_state) != NMI_NOT_RUNNING) {
		this_cpu_write(nmi_state, NMI_LATCHED);
		return;
	}

Thus the nested NMI is handled serial, not stacked. So we can use
a local variable instead of per-cpu variable.

Thank you,

> 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
