Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5577288505;
	Fri, 31 Jul 2026 00:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459338; cv=none; b=Volu10mUP6KghADTOlbLC6GW/CNCMzZNijvcdxkVwKkVbVHuvUtGXF/1GOuTu1IajdanMYQoJzE6qH9L5NCkitGK/WPUqYoNokuPf/xXvjj7RHIosW7ElB6IUlWxIwXt1lYNf+xn7xV6DqV5aQr24OVmRFs7rDzwPl3bVwAA+jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459338; c=relaxed/simple;
	bh=4isW7Vkn2vb9DFG3Y/Z4FSgifBL6F3E9Y0xuiTYPmsk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Bvu1nK5bwHzIi567B8eBZAwW/2L1DqkYYb6PdF2w20GOZZbl8D9ZEoUh3tLtfjc5WT9CJULREZ2pqd9EjL1Mj2l6K8FUw+rev07zecTIZH3fdmBUTvK3NVwdz2eafja3usgMTy3FnnxU7s8xJqhP8cOPEwonvBZCI0BMInofogo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTmrn170; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTmrn170"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A391F000E9;
	Fri, 31 Jul 2026 00:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459337;
	bh=Q/+aOhwzpIBdN6zguWwjEgmCIFDVXBXOdJ7Lz7wOH54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WTmrn170DuSfEf2QWe9t9qES7aE064DT0nlCcQwkqEdLGmpl2KjBPcipILf49pG8d
	 JPBRm1li/Tyzpd7D7q1nM3z5q/+lumQ7Oypmn1MuKTW0sKcNwhDKaI5ILEHnC50o5q
	 J5JZfCQhqDmbUOESQoQj2x0XwREAg9QR22X0iHx/cmeK8NuGpQMsjT9I3is+wN2HJd
	 dC85kV3bzj+alshm6vn9CYa7yzVUiARcqkLP5FQ4pDu18LGfV7aisGa0N6JS/mLfem
	 wqx9Hijb5ofP7wVEVjkTC2lJRnkO3NSf4Dx/vn3e3/2Zxpk8T5jT87BYvyjFKwLCw5
	 iIvCaoJn3atFw==
Date: Fri, 31 Jul 2026 09:55:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, James
 Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant guard(rcu) in
 find_active_uprobe_speculative()
Message-Id: <20260731095531.1647bb281888303020617719@kernel.org>
In-Reply-To: <20260730103010.GB751831@noisy.programming.kicks-ass.net>
References: <178537593930.153254.1296986092000402239.stgit@devnote2>
	<20260730103010.GB751831@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 12:30:10 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 30, 2026 at 10:45:39AM +0900, Masami Hiramatsu (Google) wrote:
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > find_active_uprobe_speculative() is called from find_active_uprobe_rcu(),
> > which is invoked by handle_swbp() and handle_syscall_uprobe().
> > Both callers already hold RCU Tasks Trace (via rcu_read_lock_trace() or
> > guard(rcu_tasks_trace)()).
> > 
> > Calling guard(rcu)() inside find_active_uprobe_speculative() is redundant
> > because the caller already guarantees RCU Tasks Trace protection.
> > Furthermore, standard RCU (rcu_read_lock()) does not protect uprobes_tree
> > against asynchronous uprobe destruction (call_rcu_tasks_trace()).
> > 
> > Remove the redundant guard(rcu)() from find_active_uprobe_speculative() and
> > replace it with lockdep_assert(rcu_read_lock_trace_held()) and a comment
> > documenting that callers must hold RCU Tasks Trace protection, matching the
> > convention used by find_active_uprobe_rcu() and find_uprobe_rcu().
> > 
> > Fixes: e0925f2dc4de ("uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution")
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/events/uprobes.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 4084e926e284..b4e253d43b30 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2424,6 +2424,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
> >  	return is_trap_insn(&opcode);
> >  }
> >  
> > +/* assumes being inside RCU Tasks Trace protected region */
> >  static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -2433,7 +2434,7 @@ static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> >  	loff_t offset;
> >  	unsigned int seq;
> >  
> > -	guard(rcu)();
> > +	lockdep_assert(rcu_read_lock_trace_held());
> >  
> >  	if (!mmap_lock_speculate_try_begin(mm, &seq))
> >  		return NULL;
> 
> Seems fine, but it this really worthy of Fixes? I mean, its just a micro
> optimization, no?

Yeah, I agree this is a kind of cleanup. But Sashiko pointed that
this guard(rcu)() is for protecting vma/vm_file access.
Maybe what we need is to add a comment that this guard(rcu)() is
for protecting vma during this operation.
(mmap_lock_speculate_try_begin() only checks a sequence number, not locking.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
