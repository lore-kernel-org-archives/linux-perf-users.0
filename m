Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618423C1991;
	Wed, 23 Sep 2026 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790153203; cv=none; b=XzG80pU06556Oc5jtov+67FPGa3Ry+eqI3L2AOFQHv+wFSVpa695iPkbDwduanXtRvjxTuAu1P5ClxENgEQobZCH5jH9bfZxq9ImGELyWboGCgI35s62DTxBEhZ+E4BGQwoOUJ3WEPYKD7/EWQhpGueYoA0+BdHkNyvuYHYyNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790153203; c=relaxed/simple;
	bh=NXVbL8Dnm38giafzdfqcBD1+4SyHpCDG68q4yX60GQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORltSuK7rkuNPjF65e0RwZoR2CO1YYb9x5JDa133nPMQxFi6N61hQZs/B5TRwLnE7LDQLjkc1zjC00//LRk/CCi4C28fC776zJWIkNDEq4a2LXdPj6Bok+URIqNG8c4XBjbwV4fAnJqVaqlvJbGKIJ0741fKqsHx9RLtI5+XeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dbny1RW9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dbny1RW9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LTd5nts/Uid9R1zFOrsh9+tTULjAPWbAqPd4sFcaWJw=; b=Dbny1RW9ln/XMazqWntLxE4nU3
	HRnAPsxG3u1PkV87C8uij+5oiA1RuoodYVQ0oI70qXIDocz8ntXKvp2nQ1EdopwmyFFqKUE8FRvGd
	CHPxudPSaQKc6UHYrk2qWApnOH/4A4jLdGG67d1BqPNiqmGwVWCLQCPTSb3+PbIGKvhxJP/Wq7aUk
	PDLJ2goFkEfUcqkcdlXGG6ZN4Km4YLj7NFtmSvbS22mjr3TTQU9MW9hxGZW5j6OHvQdffdw8H3n/8
	58mAt3Ywi9403F3l3Ix9GiBUlYT5qlsLX8JIyfeIMQJ//eTr5dlG8V4v4mv9sUq0yCKxYx4/PKDbb
	9YNR3gUA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9IcQ-0000000EXba-2TAp;
	Wed, 23 Sep 2026 08:46:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0B81300478; Wed, 23 Sep 2026 10:46:21 +0200 (CEST)
Date: Wed, 23 Sep 2026 10:46:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 01/13] x86/mce: Fix hardware debug register
 corruption on task migration
Message-ID: <20260923084621.GU776954@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005109564.388919.3937970081044095776.stgit@devnote2>
 <20260923002740.GAarMc_PJBsgo8Z-G9@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923002740.GAarMc_PJBsgo8Z-G9@fat_crate.local>

On Tue, Sep 22, 2026 at 05:27:40PM -0700, Borislav Petkov wrote:
> On Tue, Sep 22, 2026 at 01:24:55PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In exc_machine_check_user(), local_db_save() and local_db_restore() are
> > invoked in the outer entry stubs (DEFINE_IDTENTRY_MCE_USER,
> > DEFINE_FREDENTRY_MCE, and DEFINE_IDTENTRY_RAW), surrounding
> > exc_machine_check_user().
> > 
> > However, exc_machine_check_user() calls irqentry_exit_to_user_mode(),
> > which handles pending thread work and may schedule() if TIF_NEED_RESCHED
> > is set. If the task migrates to another CPU during schedule(),
> > local_db_restore() runs on the new CPU with the dr7 state saved from the
> > old CPU. This corrupts the new CPU's DR7 hardware debug register and
> > leaves the old CPU's DR7 disabled.
> > In short, local_db_save() and local_db_restore() pair must be run
> > on the same CPU.
> > 
> > To fix this, move local_db_save() and local_db_restore() inside
> > exc_machine_check_user() and exc_machine_check_kernel(). In
> > exc_machine_check_user(), DR7 is saved and restored strictly around
> > do_machine_check() to avoid schedule() during migration. In
> > exc_machine_check_kernel(), local_db_save() is called at the entry point
> > to prevent early memory accesses from triggering nested #DB exceptions,
> > and restored on all exits.
> > 
> > Fixes: cd840e424f27 ("x86/entry, mce: Disallow #DB during #MC")
> > Assisted-by: Antigravity:gemini-3.8-flash
> 
> verify_tags: WARNING: Zapping LLM ads tag: ['Antigravity:gemini-3.8-flash'].
> 
> Needs to be:
> 
> Assisted-by: LLM
> 
> Please fix all your patches.
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v15:
> >  - Move local_db_save() to the entry of exc_machine_check_kernel() and
> >    restore it on early return from mce_check_crashing_cpu() to prevent
> >    nested #DB on watched variables.
> > Changes in v14:
> >  - Newly added.
> > ---
> >  arch/x86/kernel/cpu/mce/core.c |   27 ++++++++++-----------------
> >  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> Yah, makes sense.
> 
> I'm thinking this needs to be CC:stable and I should take it in now.
> 
> Peter?

Yep is right.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
