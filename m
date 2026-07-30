Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35E3E3145;
	Thu, 30 Jul 2026 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407421; cv=none; b=KNCpDaaxsw8kVlyVz5DmUYNPUuXPj4LKF9ACnLvzXX2zrfdXyjdZRfWcLf+W1LzIp191kp4WVUAomy9PJJFFlofaFTbP0p+Fmo8c8oBeTkHTyyS9cUsk5g15BBGotd9vLLqXM47rfPGsXetz0KSsnfch//lnug4uKv66kzOyLE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407421; c=relaxed/simple;
	bh=cruTOrVgeIay3RArHO3PIZL15OhdQhEDsr/ybcqn8zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOECA4ig4l99tptFZicV1VYyDfohbebFwxXSydjhAw3O9XOoEuZN1rttAiqNvSwM3JxuTLVQYD0zJ+Wa+j53eA6B4It7WFO3Ey+RSJJmQNUtMs/c0SL2DfVKumlBC18l0Cw9MSDpQ9WbsHWQllKoKZCBl4338LyVy+XRZN2ChA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E6TWgn4Q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6TWgn4Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z4EtOb6WWZDaaMfVpdmqlablLwrSmKXIS61nbIl9xGE=; b=E6TWgn4QtI89tvfrVK9G5W+BCJ
	d0cflC31WHyhyl5sYaqaBWbrZLntHZeaGCHqfh5MfJBWP5k0xCq4OaN2cfmSs/krfmVyN2x5j4pJc
	UM1BP5Dsn2HSDeDQ7Zhjbj08wE7BXh5dhfxM1GgaZPN10iePmHVDZYfSzDHfdLFF0fI/WP4IEh+JU
	BQ4Mi5cds339OY1wslHZZLJGuTDNxoQJ+jeRfA5zqKftMz7eX3mM2p4n4X8BhPjniBQEHmTepotmU
	fzBQm6DB0vW82HYs2sGwaJTIHdSBygCQsIbx/kd1ZyhxNliQXe9gpQN0QNUQ6sLovBnee4QxXaqLb
	cszHbGDA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wpO1k-00000006aE4-0zUG;
	Thu, 30 Jul 2026 10:30:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9F11530095A; Thu, 30 Jul 2026 12:30:10 +0200 (CEST)
Date: Thu, 30 Jul 2026 12:30:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant guard(rcu) in
 find_active_uprobe_speculative()
Message-ID: <20260730103010.GB751831@noisy.programming.kicks-ass.net>
References: <178537593930.153254.1296986092000402239.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178537593930.153254.1296986092000402239.stgit@devnote2>

On Thu, Jul 30, 2026 at 10:45:39AM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> find_active_uprobe_speculative() is called from find_active_uprobe_rcu(),
> which is invoked by handle_swbp() and handle_syscall_uprobe().
> Both callers already hold RCU Tasks Trace (via rcu_read_lock_trace() or
> guard(rcu_tasks_trace)()).
> 
> Calling guard(rcu)() inside find_active_uprobe_speculative() is redundant
> because the caller already guarantees RCU Tasks Trace protection.
> Furthermore, standard RCU (rcu_read_lock()) does not protect uprobes_tree
> against asynchronous uprobe destruction (call_rcu_tasks_trace()).
> 
> Remove the redundant guard(rcu)() from find_active_uprobe_speculative() and
> replace it with lockdep_assert(rcu_read_lock_trace_held()) and a comment
> documenting that callers must hold RCU Tasks Trace protection, matching the
> convention used by find_active_uprobe_rcu() and find_uprobe_rcu().
> 
> Fixes: e0925f2dc4de ("uprobes: add speculative lockless VMA-to-inode-to-uprobe resolution")
> Assisted-by: Antigravity:gemini-3.6-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/events/uprobes.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e284..b4e253d43b30 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2424,6 +2424,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
>  	return is_trap_insn(&opcode);
>  }
>  
> +/* assumes being inside RCU Tasks Trace protected region */
>  static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -2433,7 +2434,7 @@ static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
>  	loff_t offset;
>  	unsigned int seq;
>  
> -	guard(rcu)();
> +	lockdep_assert(rcu_read_lock_trace_held());
>  
>  	if (!mmap_lock_speculate_try_begin(mm, &seq))
>  		return NULL;

Seems fine, but it this really worthy of Fixes? I mean, its just a micro
optimization, no?
