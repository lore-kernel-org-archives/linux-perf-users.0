Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAC1A680A;
	Thu,  6 Aug 2026 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974811; cv=none; b=Efhod+5WBJuBhZR9zdAaIfFGOS9qCC+LpUJkddmo1+86VFRjokz08waCg56Gg8j4DZn87OcSlfeX7lE7a1lljZj2f0xsp9dCFE11JJ+AE89NQK137mB7ei3Ltf8eTqe8CSJC/O+XUscItV/kjxGp6bPrxvdf6tMxSz/J60rZcIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974811; c=relaxed/simple;
	bh=j0iXAhzq/EXZrl5z7Bgshe2QkzJBiTLBxvu1KXFBzrw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XXpEyCNeTmYvnM0042GKy5L/hxOWxQ3ti1FLtcW0RTofvExBJZh5xNwIvHL698q6zoZeohErQhpGLkXsZPUp4gGDIBFFiXIZgiRBFYs50c4YTSeKtQKIw6GpX7GgJ78XqcoJQ6MlNkCde+faI7DaF2C7WNQqRheWQV+b2tIKVFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q876qwC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q876qwC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37A21F000E9;
	Thu,  6 Aug 2026 00:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974807;
	bh=1xgvjthnyVe567/MSXkAs2MyNkBdDIpQh6/KOVGBMck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q876qwC3uvGRG7VHFA0m0T6I5IhlK4WUxj1lgf4oQ2+VJKQaLC2jKxsXe+9Iqtdb4
	 qQD65IQ0utOqG8tbeaKoR0SLyBBpin9veCGrWDgv/cgFTCZ1qabG5Oa2VzPJM8a9aa
	 SBR2VuDPwvCJBe/896cAI0c2KAzXzuDYTEcv+2ZHQ+vqF7U7UsHiebXL5YPsNCPfnB
	 MoxSK1IwpEkRWD+AQdXgc/XsGamJrUr0wu/HKEcitJa4d1OxVS7iwcmSsJouk4Sjl5
	 lg9lLdP+KDFBbtNuoe9w4MWfjnWwhftWfu2n8MN6F8aXDkvOEmrw2s57G3sUd6A8nk
	 VpppsWj0G3Fhg==
Date: Thu, 6 Aug 2026 09:06:41 +0900
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
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-Id: <20260806090641.e59484ac570b0f842bc930bc@kernel.org>
In-Reply-To: <20260803230840.GJ687043@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565875046.714490.17724442147958346980.stgit@devnote2>
	<20260803070356.GV49951@noisy.programming.kicks-ass.net>
	<20260804080035.6b719368c9328bbdd8219867@kernel.org>
	<20260803230840.GJ687043@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Aug 2026 01:08:40 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Aug 04, 2026 at 08:00:35AM +0900, Masami Hiramatsu wrote:
> > On Mon, 3 Aug 2026 09:03:56 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Sun, Aug 02, 2026 at 05:19:10PM +0900, Masami Hiramatsu (Google) wrote:
> > > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > 
> > > > Add a new probe event for the hardware breakpoint called wprobe-event.
> > > > This wprobe allows user to trace (watch) the memory access at the
> > > > specified memory address.
> > > 
> > > s/the memory/the kernel memory/
> > 
> > Indeed.
> > 
> > > 
> > > > The new syntax is;
> > > > 
> > > >  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> > > > 
> > > > User also can use $addr to fetch the accessed address and $value to fetch
> > > > the accessed memory value (shorthand for '+0($addr)'). No other variables
> > > > are supported.
> > > 
> > > This seems limited to kernel addresses only? Should not also userspace
> > > addresses be supported?
> > 
> > Hmm, for x86, yes, since it causes a trap after executing (all page fault
> > are handled). But other architecture like arm64 may not be able to support
> > it because it needs to enable watchpoint after major page fault.
> > At this step, I would like to limit it just for kernel memory.
> 
> Sure, but suppose you were to add userspace, what would the ABI be?

Ahh, sorry. It was misreading, I mean it should be only for the kernel address,
not for user space. So I don't want to add userspace. (I answered the first one)

Thank you,

> 
> That is, don't paint yourself in a corner etc.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
