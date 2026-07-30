Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075F37F725;
	Thu, 30 Jul 2026 03:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382721; cv=none; b=ZviLvJxeKPmh9KVT1RW5peq4Evero8dN64jcjqOuFpCHr+cQFKLh+G03QH6HQWV+CVdEfUKXQ7HtOhY9wktnljzcHz3pzrRFnJAyIMKIHe1/bFIRqc3Qc9NVfenF7hPfVBgUVPowjo/q3eIb8ZcC0HmkpwjO6hX38RRChwW66Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382721; c=relaxed/simple;
	bh=ZjdlBuT83fWwIskIVoyRm6bAu1/lFcLL0bxBZmascIo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QJnweOY8M7k+7cjyCSmBKETHjEFpsVtAmGk6/tmSDHX8SSDzM/W99xPiooOWK0yY0jsybhHipzIXRzfJuo+XxcfWOK7JONBB525GQseeZ7ROOvS4t1b4iqZeRWDHEr+diU75m22/Huy0j5FeljFWP6ENKE2jMJjVt0QFW0pfD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCOXLv9m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCOXLv9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E18C1F000E9;
	Thu, 30 Jul 2026 03:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785382720;
	bh=wEfJUHAwyyexkwLVITbPZO8WKWBL8aoa0QA+h6kjDuQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kCOXLv9mPWutBPKVeNn94NEnRK7xPG8U+DAsJs1C7M4u+LW2U9CUi9zFzW3S4+yiD
	 nrEAHlhAnIAixJDFrFLDm18MJ5LTEt/JggYEwUl6T5vVOyherdN3dHsCC2/NkxY24N
	 e7e9EIQDhzMUzrgg8PVCC+KH01QjudYwLf3lo0TBpRZTKweI3nrc/EunPeLOzoS7Qc
	 00q2GFilnW8G35sguS5zgodrjMbTfI0JdKUmFYwFMIKoeOvJQXGqAhPgc3EVRgSXJc
	 MO+dylj5Dd8Un8t7GwI7Yex8x8H2H7o5DIxUmkfjj61KKrx9Y70BYCOGtV7TucM09b
	 O0Mhsf05O0Ksw==
Date: Thu, 30 Jul 2026 12:38:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian Hunter
 <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant guard(rcu) in
 find_active_uprobe_speculative()
Message-Id: <20260730123835.e94483b966bc7cfcd5645e79@kernel.org>
In-Reply-To: <178537593930.153254.1296986092000402239.stgit@devnote2>
References: <178537593930.153254.1296986092000402239.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 10:45:39 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> find_active_uprobe_speculative() is called from find_active_uprobe_rcu(),
> which is invoked by handle_swbp() and handle_syscall_uprobe().
> Both callers already hold RCU Tasks Trace (via rcu_read_lock_trace() or
> guard(rcu_tasks_trace)()).
> 
> Calling guard(rcu)() inside find_active_uprobe_speculative() is redundant
> because the caupller already guarantees RCU Tasks Trace protection.
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

Sashiko mentioned that this guard is not for uprobes_tree, but VMA lookup.
Please ignore this.

Thanks,

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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
