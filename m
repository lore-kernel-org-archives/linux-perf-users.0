Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A03446C3;
	Mon,  3 Aug 2026 23:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785798529; cv=none; b=ksmrT82aO/WCfvjXvHk0c7ZQorq0rHX9XS9TyuLWWmZuiWQHRJzFtUPFmdzflF8dwUiXlBJHyTCOro/6ibJLSCnZilUFEenEG+CpN2G6HH2WwncGASppqzV8N9ZKP88vrElxtj3mFDvE+gcuJ3wTHXfBasHG3NXD8nsv7vACKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785798529; c=relaxed/simple;
	bh=HoglUgCFZoEowKApPKS9MhwYlbuRhQEtX7E3nLI4538=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5dlAPWvgDk6rcHNvZkAJT5jwUPm+mUQ4So48gHNIoXFL77j8OS37f1hz8YARRyjGwLKM2QgOlCrdIRxPY43XkDB0KmteKk3opkms71nVGnfKiOIvdjvHxoU1U9E0Eftus954yw4oAjjZ63WtsHgZcRlDpqoF8AWodYDRChJsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r9XjxFXa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9XjxFXa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SA2dlnI/MmT0FWL+U+ME23/wbCe0VZl/s+QIV1MkBtw=; b=r9XjxFXaz1up9cUV50ogjUWrgP
	Z260+h9zsDsYaWRu4v6IDKcju+bfpqvIovDkVaSoyhay+iHjpjJEL/f322FSLPRqGWrP/QbtwWyuM
	G+wOiW61XX4HeLl2uMM36AhrrC3jA3mlV1rqvIg4pkQlpH7zP/fGBQn00kZNLQgS5eG3lCFaRlMW+
	9ixao8CbFZGtfXQow4bYrAseHGFIdvhaKBj4QL8kmUUa2fIEEJACgSjWdvWm59o31jE6mx9rlYo9J
	VzWdS8KQ525mUZ9ozQWg+qTjD871iKgFKb0FObM3KVIK2/alBuoYyEuUC8QSPEFY6beOUEmb/py40
	hRXIjqZg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr1lw-0000000Ewpj-2aXh;
	Mon, 03 Aug 2026 23:08:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 427B030063F; Tue, 04 Aug 2026 01:08:40 +0200 (CEST)
Date: Tue, 4 Aug 2026 01:08:40 +0200
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
Subject: Re: [PATCH v11 04/11] tracing: wprobe: Add watchpoint probe event
 based on hardware breakpoint
Message-ID: <20260803230840.GJ687043@noisy.programming.kicks-ass.net>
References: <178565870538.714490.11309825813968306287.stgit@devnote2>
 <178565875046.714490.17724442147958346980.stgit@devnote2>
 <20260803070356.GV49951@noisy.programming.kicks-ass.net>
 <20260804080035.6b719368c9328bbdd8219867@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804080035.6b719368c9328bbdd8219867@kernel.org>

On Tue, Aug 04, 2026 at 08:00:35AM +0900, Masami Hiramatsu wrote:
> On Mon, 3 Aug 2026 09:03:56 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Aug 02, 2026 at 05:19:10PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Add a new probe event for the hardware breakpoint called wprobe-event.
> > > This wprobe allows user to trace (watch) the memory access at the
> > > specified memory address.
> > 
> > s/the memory/the kernel memory/
> 
> Indeed.
> 
> > 
> > > The new syntax is;
> > > 
> > >  w[:[GROUP/]EVENT] [r|w|rw]@[ADDR|SYM][:SIZE] [FETCH_ARGs]
> > > 
> > > User also can use $addr to fetch the accessed address and $value to fetch
> > > the accessed memory value (shorthand for '+0($addr)'). No other variables
> > > are supported.
> > 
> > This seems limited to kernel addresses only? Should not also userspace
> > addresses be supported?
> 
> Hmm, for x86, yes, since it causes a trap after executing (all page fault
> are handled). But other architecture like arm64 may not be able to support
> it because it needs to enable watchpoint after major page fault.
> At this step, I would like to limit it just for kernel memory.

Sure, but suppose you were to add userspace, what would the ABI be?

That is, don't paint yourself in a corner etc.
