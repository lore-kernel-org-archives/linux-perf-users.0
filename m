Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5E61DC985;
	Thu,  6 Aug 2026 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974866; cv=none; b=bE5rklQkEvMBwZsqRlBZ9qhV3pWEkSQviH6pKA4nPVy62wMnvdIyyk3GuK10YKGNiOc8gqTi77HqXkcmO4BG7lSFSZySh8oMJvlC3GZ1OMxlRcGq87dx64kv8uWRfx2hN+LuO6UGSKZNFpzwoXu1OJRjwX+RxZQ4vWQpmu3Visg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974866; c=relaxed/simple;
	bh=wXylmxewTYBhW4McsYwSxB07thOf9YPPTzqAKwpV7CM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bWo+ShiUAwGLvhxPiP51O84s7kjglVxSIgB7eTFpKicwEnn84g8kQkTlU+EXYCUqumuyi1CV8Ts6arEMjBE1T7p+0NdzT+nwdL8kTXXjlZgQneVes/SUUKDfy42xh8GMmgE6y6BowvjGJ0oQ1AWQKlK0inFAwcu2I6Kg1ui2syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Llm3elE3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Llm3elE3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21491F000E9;
	Thu,  6 Aug 2026 00:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974861;
	bh=r+o9nSPE+sJH2kzglqwMqLUgDYGI789gXecC5Xqpk6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Llm3elE3wFD7YihG80E3v5sG8LzhTCZUzU3Ki+1LsQx58AYxocc+uJ2O/6jIjhfUb
	 ZisjrRW1ov2NxVyFev1yXhwzpW70EB304yTDUfdBVCOfMfzaFQTMQlOcDlNhnC1l0v
	 lvsMBneqTn2/QyFpPy0aDB6qvniMJnnLWYzTQ0g6VLGmfw7VRWH51qTMtPwaohdBhf
	 DNsC2l3OeoFPMbfkkUJGOsxARFThUa7Mp3cpWcs6RsDGxjvZVpzwiZ5ULL/FC6Gk7Z
	 rd5Oyq8DbfW3v0KoUMtjYZon3tBbn1KrPECXf4+7hpGTmH1S75fXwDbeWx8Qt2TlBS
	 RsGntYqXCwixg==
Date: Thu, 6 Aug 2026 09:07:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v11 01/11] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260806090735.0ee427ef5c18445b89d2f3cd@kernel.org>
In-Reply-To: <20260803230723.GI687043@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565871750.714490.5506415865016304088.stgit@devnote2>
	<20260803065744.GU49951@noisy.programming.kicks-ass.net>
	<20260804075517.1c1c9e2dc6ff66e0e73f946d@kernel.org>
	<20260803230723.GI687043@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 01:07:23 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 04, 2026 at 07:55:17AM +0900, Masami Hiramatsu wrote:
> > On Mon, 3 Aug 2026 08:57:44 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Sun, Aug 02, 2026 at 05:18:37PM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Jinchao Wang <wangjinchao600@gmail.com>
> > > > 
> > > > Hardware breakpoint installation and removal run with IRQs disabled, but
> > > > an NMI can still enter the same code through KGDB. The interrupted
> > > > operation and the NMI can consequently claim the same slot or overwrite
> > > > each other's DR7 state.
> > > 
> > > Is KGDB really the only way to trip this? Mostly I think we let KGDB
> > > have the pieces if it does something 'funny'.
> > 
> > Hmm, I think even if so, this detection is better to be handled in
> > hw_breakpoint layer. And I plan to use this from kprobe events,
> > which is also a kind of NMI.
> > 
> > > 
> > > > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > > > index f846c15f21ca..9ef24b55737f 100644
> > > > --- a/arch/x86/kernel/hw_breakpoint.c
> > > > +++ b/arch/x86/kernel/hw_breakpoint.c
> > > > @@ -40,6 +40,9 @@
> > > >  DEFINE_PER_CPU(unsigned long, cpu_dr7);
> > > >  EXPORT_PER_CPU_SYMBOL(cpu_dr7);
> > > >  
> > > > +/* Sequence number of the per-CPU DR7 state. */
> > > > +DEFINE_PER_CPU(unsigned int, cpu_dr7_seq);
> > > 
> > > > diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> > > > index 3c9f60d6ca5a..f55a0cbd5927 100644
> > > > --- a/arch/x86/kernel/nmi.c
> > > > +++ b/arch/x86/kernel/nmi.c
> > > > @@ -532,10 +532,13 @@ enum nmi_states {
> > > >  static DEFINE_PER_CPU(enum nmi_states, nmi_state);
> > > >  static DEFINE_PER_CPU(unsigned long, nmi_cr2);
> > > >  static DEFINE_PER_CPU(unsigned long, nmi_dr7);
> > > > +static DEFINE_PER_CPU(unsigned int, nmi_dr7_seq);
> > > 
> > > This is weird, why have two distinct sequence numbers for dr7?
> > 
> > nmi_dr7_seq is for sequence number of operation, which is for
> > detecting dr7 overwrite in NMI.
> > nmi_dr7 is for saving the DR7.
> 
> I mean cpu_dr7_seq and nmi_dr7_seq.

Oops, Indeed. Let me fix it. Thanks!



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
