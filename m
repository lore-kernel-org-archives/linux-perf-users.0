Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB34344D91;
	Mon,  3 Aug 2026 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798042; cv=none; b=uVDqrZT5crRey1e7I2pylUD+rjLS91IGKXWU+/zr9puuGQKWK2S4CerVFuVFCtM9og28uW9cSUda26QYWCBQtJIG5a8e7QhprBxBSrxNSv7kINSd8aYCN9w36beETsfE1GfJRUwMjt+qQagJui1jRHWpz5g4tHoyODPoCmwL1+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798042; c=relaxed/simple;
	bh=YF5+/9H2xV6xvo6lRJ2MMOWcjOwld/NW7J8V1HI3g4w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nLOC9wqsbfiBv8wvx1ZFEv5QHCYxXWQsJOhj/yHnL3WBoKUZW4lqCzoOSgyAuuo21mK2HiEEhlqtfGaOFk719xHQoD2MvoxsTh8bFMDl5NurqdHVFi66p8BrzVsqUewtnqepneWXLvJPqiH++52H/RP+TbhsGpUweULP/bhRsTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj1FJiLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj1FJiLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8BD1F000E9;
	Mon,  3 Aug 2026 23:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785798041;
	bh=ODXR5dipyjzg+KUI475fueZXSulmDm0R6sqEfjhXAFg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Lj1FJiLCgoVDcGdR3ID0q2FvRl0IcLMAW57Hd012RIyo46fGoXKzHTLTNvQ88pX4a
	 0PsdB97shbTK14mgdrwC68bHhiHQUkFwWO3FKuRa97SNI4TCQNUtxXhNzic9pPXTqJ
	 YQeVHrKlbauRcqEP/MmlXSYGi5l5ZrYL1dpOSYgRvtUmSgwm1FM8x2I9ZDBZOIbYFL
	 nAlPNCz2zpNQDxNQgXYedpVzepmFdosrIxFa2p2reGkChGHagnp4Q/7eYyNqkbX/k2
	 rKMnLfMferO29KNK39QBNGxZZIGI1p1vLh+LDWZQOt0dP/2KW7XaRr8+tezwCf8Se7
	 3NRMiSrHidxyg==
Date: Tue, 4 Aug 2026 08:00:35 +0900
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
Message-Id: <20260804080035.6b719368c9328bbdd8219867@kernel.org>
In-Reply-To: <20260803070356.GV49951@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
	<178565875046.714490.17724442147958346980.stgit@devnote2>
	<20260803070356.GV49951@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Aug 2026 09:03:56 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Aug 02, 2026 at 05:19:10PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a new probe event for the hardware breakpoint called wprobe-event.
> > This wprobe allows user to trace (watch) the memory access at the
> > specified memory address.
> 
> s/the memory/the kernel memory/

Indeed.

> 
> > The new syntax is;
> > 
> >  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> > 
> > User also can use $addr to fetch the accessed address and $value to fetch
> > the accessed memory value (shorthand for '+0($addr)'). No other variables
> > are supported.
> 
> This seems limited to kernel addresses only? Should not also userspace
> addresses be supported?

Hmm, for x86, yes, since it causes a trap after executing (all page fault
are handled). But other architecture like arm64 may not be able to support
it because it needs to enable watchpoint after major page fault.
At this step, I would like to limit it just for kernel memory.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
