Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5B44302FC;
	Thu, 24 Sep 2026 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241513; cv=none; b=tF66IZVqNEWs61T1BZvwaupdKDe8cmXWDWNn59cHJINVP/P9jUQ8lzhxmowID43w/LzawYlKlPRG5dpbCfCpB3uU/egPDABG5l+xMPs+ysdy2BsrWEND6cTjoPrPXvJez/tVxffFLHj80gZuPCHHarzJKV9b7Fc7HN+LUrNYHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241513; c=relaxed/simple;
	bh=Xy5UjMdWN6PnwmI7Kav/rLuij8mjxL12LE9fxNWuNwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbUMspIhSH+3+JUvzvBSOYO7qFSUuFFheS0q+LUQZW1Y0wGkUtT5YOxZ8x2kFvu7RJrS5M8ExAkN5So82Uy24Ah3z4SfmhADLehGI/QpTfe2aGfvvixRGkGhyLloEtHzCQ65F7BCLXvve2dTUYPjSzRoUybnH2m4np7U9PE7KdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VJWu9ELP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VJWu9ELP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sq8IQX43VCY+mY4lRo9UW1Z2K8jDVFU5QT7rUU6s4go=; b=VJWu9ELPI9sFvejc6W5rDtP1qW
	Us9SliXDTMuS469DTpE8DSMQT4ViELKJaqfQuI+AGL0fSQrmwrbB4Q1zVwcfOe/JgORDW0lWbY4S3
	wFpWb3VCAas1tbcCvPcy5uPAs6s1ZNHgx8wbosYGsdFciGa/4C5BIxQSxd7lkvU0uMXE/vEWe9nvh
	4kR9yQq3wympV4HMW9d0mMCWUSC7sfDDh23z8ikC0inZAy16kYqBghOxr1lJJB/S/w/CBTgwIFCAn
	QWNKCON8LW+OUw/29c0wnMSON2EYd6esseDRR+OMEIlTtbhyNRFdBzc40ziL/jui6RFYI74GHe72u
	obMyNWjA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9fai-0000000FmLd-0OWu;
	Thu, 24 Sep 2026 09:18:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27B733006DD; Thu, 24 Sep 2026 11:18:06 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:18:06 +0200
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
Message-ID: <20260924091806.GK2009045@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005110742.388919.1509641807739909065.stgit@devnote2>
 <20260923085139.GV776954@noisy.programming.kicks-ass.net>
 <arPjK1-PVp_UqAsQ@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arPjK1-PVp_UqAsQ@google.com>

On Wed, Sep 23, 2026 at 07:33:15AM -0700, Sean Christopherson wrote:
> On Wed, Sep 23, 2026, Peter Zijlstra wrote:
> > On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > When KVM enters a guest OS, host hardware breakpoints are disabled
> > > before running the guest. However, an NMI can occur while executing
> > > in guest mode or during guest transition, where
> > > arch_install_hw_breakpoint() can be invoked from NMI context.
> > 
> > How? AFAICT perf doesn't do that. arch_install_hw_breakpoint() is called
> > through pmu::add() which is strictly IPI context.
> 
> I assume it's:
> 
>   kgdb_nmi_handler()
>   |
>   -> kgdb_nmicallin()
>      |
>      -> kgdb_cpu_enter()
>         |
>         -> arch_kgdb_ops.correct_hw_break()
>            |
>            -> kgdb_correct_hw_break()
>               |
>               -> arch_install_hw_breakpoint()

So I would *love* to delete KGDB support for x86. Is anybody actually
using this turd?
