Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D026938DC5D;
	Thu, 30 Jul 2026 03:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785382597; cv=none; b=WmsdEVxEUuplokF+hmYt/OexIyHmi0ryFqEhVH3PHHJwbIXYzREiX0QlQxh4gwFbSeHfQTTIgiLzWikJAvuzH3y0Tkwy/q/brlnhAeo5d1RfR6viMRF5H7HpF2WpnWLaJhFjdzFdM2Bd2BV3omf8LSYs2PEDlHG1k6FwMgnvOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785382597; c=relaxed/simple;
	bh=Brq2O2NUj020BWdizA1Qra/clwlZgf9+GiHIfOtO7AQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RuUNxQMxqA8Brtuhr82qexLhx6NLlsm7ZLxjCPXHROW7V0fPmyXVlxvvxqeKUZgy4zU2FP6cjzq/tP7RrpXaPak1fklAMRIxvv/pKhPj2N2kX40aTpZYN10bR08ykdWtsrtT/4ycBHHXWFCVQIHIXyyIz+uottBCJSEpNntTIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABD13DBr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABD13DBr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5690F1F000E9;
	Thu, 30 Jul 2026 03:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785382594;
	bh=/F8NTVlBDU8BWWwofVpJEhV+ebxXNRLNpFOKVh13JaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ABD13DBr4Q7DY/MQkAi0/YOOzVJHdAj0jV8UgPzWpT1UDMDSquLjCjXpDKwVWExLf
	 HA1vK5VSZse2IQ6xRMxCqptH//NixFj4t+xQHuGUG8avNB+Z2hvI5ksvvB4qXWF0+g
	 xFlJvgwuxolComBVDBzZI2LrwjJ3In8uRmshmelBaOjANk3xiSAW4Xb8wO0QEM/4BA
	 qlI3IXeAxHJjyM7HwvEpcqJejooXZ7rxHxAdBGpInilZf9wk07gd8tbPfG39hBtXcX
	 szv+xzZz3OV0XOkqJf6RhpfQFNinm8/qVWBtx8HHL2jM5AzQXBxGe11xYl6ILJOHhA
	 grv5+sVrBGtYw==
Date: Thu, 30 Jul 2026 12:36:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant guard(rcu) in
 find_active_uprobe_speculative()
Message-Id: <20260730123630.5cdccc5334a0d9fa04a54f34@kernel.org>
In-Reply-To: <20260730015947.ECA9A1F000E9@smtp.kernel.org>
References: <178537593930.153254.1296986092000402239.stgit@devnote2>
	<20260730015947.ECA9A1F000E9@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Jul 2026 01:59:47 +0000
sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Removing `guard(rcu)()` from `find_active_uprobe_speculative()` eliminates standard RCU protection, exposing lockless VMA and file accesses to Use-After-Free and page faults.
> --
> 
> --- Patch [1]: [PATCH] uprobes: Remove redundant guard(rcu) in find_active_uprobe_speculative() ---
> commit 008639a39e6344f6f057b7d120c62792b7cd6ddf
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> uprobes: Remove redundant guard(rcu) in find_active_uprobe_speculative()
> 
> This commit removes the guard(rcu)() from find_active_uprobe_speculative()
> and adds a lockdep assertion for RCU Tasks Trace, assuming Tasks Trace RCU
> protection provided by the caller is sufficient.
> 
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 07f69dd3093d5..52833db53b25c 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -2416,6 +2416,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
> >  	return is_trap_insn(&opcode);
> >  }
> >  
> > +/* assumes being inside RCU Tasks Trace protected region */
> >  static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -2425,7 +2426,7 @@ static struct uprobe *find_active_uprobe_speculative(unsigned long bp_vaddr)
> >  	loff_t offset;
> >  	unsigned int seq;
> >  
> > -	guard(rcu)();
> > +	lockdep_assert(rcu_read_lock_trace_held());
> >  
> >  	if (!mmap_lock_speculate_try_begin(mm, &seq))
> >  		return NULL;
> 
> [Severity: High]
> Does removing the standard RCU protection here expose the subsequent VMA and
> file accesses to use-after-free and page faults?
> 

Oops, this guard() is for protecting VMA. OK, please ignore this.

Thanks,

> The VMA and file objects are allocated from SLAB_TYPESAFE_BY_RCU caches,
> meaning their underlying slab pages can be returned to the page allocator
> after a standard RCU grace period. RCU Tasks Trace does not block standard
> RCU grace periods.
> 
> The subsequent call to vma_lookup() briefly takes standard RCU to safely walk
> the Maple Tree, but drops it before returning the VMA pointer. If the thread
> is preempted after this point, and another thread unmaps the VMA and closes
> the file, a standard RCU grace period could complete, freeing the VMA and file
> slab pages.
> 
> When the thread wakes up and dereferences vma->vm_file or vm_file->f_inode on
> a freed page, could it cause a fatal page fault? The code relies on the VMA
> and file not being freed from under it, which appears to require standard RCU
> protection.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/178537593930.153254.1296986092000402239.stgit@devnote2?part=1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
