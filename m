Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117307;
	b=g55nXfqXCXGjlL6YITK19US4XP31MCxAHhet6SoM7OawaH+EDxmLduLt531zCJwd0TCQ
	 Y+oSbfZkIyhwZ1C9/WhjcCKlkUWSo3+5XYVnM6RXc/FNvhlLudQhCIbQadivvAyzs/aRF
	 2MKFEnndj/67KamLsF/VHjPAcXJDcfJ4zIGPXpL4YkBQi03rEru1/n8/6wfPNNoUDtYs/
	 mrsa4Dw+ycwv0LzzPJ88oE42tB2uPUKRT4R3ye8vX4F+eoSf6BOXff+cfqRBQNiyV606s
	 +OhXJpjA5alu0Pn5fCWYnNJvZ0fGawTI4I/3rJSMmY8jaSkMAMmdm7bk74WEpFx2XJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117307;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4MX40vMMhwSIHoMJnZpT+uK1BwJ4FDZXqJbJwtrNmj0=;
	b=BMA49qimvqKIDeMKBVm/cn1xwfPca80zGKBRlSeD5SYbOjVW0dvc/oNwoAWMyg/gSfPc
	 4G+yMiUxfQUQYYsh7H3mu9v2g8UH8+1i6zDttlBmPdFlN9+6qLJrMaEghe5xspL/yP9dP
	 ct+EjaV+bTeDNH43bY9UUng5/NexaQECgctrOJ15PCHMZArgX7kugorUp4//jyR6cWqeY
	 wgZZRYwNKPhLNPdFi4z/Tkhgq5lu0QFK8F2oVDtxziVgnt0YqZdQI4AnYh7fAtW8brD0z
	 bPFtCwT5FzgzGSM6cTQ4/Ns1+cvsdiSsChA/R5Na8T7RB3rDTtWxxy5yyIJgHHXJZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJOQ4Ie7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FA606A31A;
	Tue, 27 Oct 2026 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bJOQ4Ie7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7811F01825;
	Tue, 27 Oct 2026 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793117306;
	bh=4MX40vMMhwSIHoMJnZpT+uK1BwJ4FDZXqJbJwtrNmj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJOQ4Ie75jztOfmmLJtR3Zr7sfWZTccT4f3F6H7QMypZ/Ed5q0hF2WzJZgNabVjGZ
	 eDHxKLaQa4cCxSJN6CnJSwmQtAYe+YAROMgsCX5hyWKDGfet1YRv7o/PcbziDuyzy4
	 o1LuIUObpKr2q2h4qYW486ZcsECR/lMVXBRXl4AC/WTJ+EuB+ZGShnTBBtdWcpsSgT
	 K6WogJB4fsz5WN81jPNmqGkLNRXj57jMdCk07RN/yTaZDfg61LcTJ5HmnkdoZZt69C
	 ZUsleMbuBFv5/0hDPpnXE7Fyruczg4OfN73Vp44wrr6l0FvbNLECErGsgO6JzYFjug
	 oVRFOeN+MdolA==
Date: Tue, 27 Oct 2026 16:08:17 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, 
	mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, 
	surenb@google.com, david@kernel.org, vbabka@kernel.org, jannh@google.com, 
	hughd@google.com, kees@kernel.org, mingo@redhat.com, tglx@kernel.org, 
	x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 7/9] fork: Let the new task point to its mm
 before uprobes can find it
Message-ID: <auDGKwWWNuhuB3IE@gremlin>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022015712.1297331-8-alexei.starovoitov@gmail.com>

On Thu, Oct 22, 2026 at 01:57:10AM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> uprobe_perf_filter() compares event->hw.target->mm with mm. The target of
> an inherited event is the new task. copy_mm() sets tsk->mm after dup_mm()
> returned, but register_for_each_vma() can find the new mm as soon as
> dup_mmap() releases dup_mmap_sem. No task points to this mm yet, so
> the filter says that nobody wants it.
>
> The walk that removes the breakpoint, because another consumer of the same
> uprobe goes away, sees !filter_chain() and removes it from the child.
> Nobody installs it again, and the inherited event doesn't see this child.
>
> It's an old bug with a short window. The previous patch releases
> dup_mmap_sem before dup_userfaultfd_complete(), so with UFFD_EVENT_FORK
> the window is as long as the monitor likes.
>
> Set tsk->mm at the end of dup_mmap() before it releases dup_mmap_sem.
> Not earlier. The new task can be reached via its perf events and from bpf
> progs. They shouldn't find mm that is half copied. Clear tsk->mm when
> dup_mm() fails after dup_mmap(). Do both under task_lock() like exec_mmap()
> and exit_mm().
>
> The tasks with such event fork, while another consumer of the same uprobe
> comes and goes. 5 cpu VM, 90 sec and 7000 children per run. The number of
> children that the inherited event didn't see:
>
>   without this series          11 to 24, 8 runs
>   patches 1, 2, 5, 6 only      23, 12, 21
>   this series                  0, 0, 0
>
> With UFFD_EVENT_FORK monitor that reads the event after 5 sec the child
> lost the breakpoint in 5 of 5 runs without this patch, and in 0 of 5 with.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This feels like a 'fix in the wrong place' thing again really.

What would a fix in uprobe code look like?

I don't love that core mm fork code is being changed to address uprobe
problems in general.

> ---
>  kernel/fork.c |  9 ++++++++-
>  mm/internal.h |  3 ++-
>  mm/mmap.c     | 14 +++++++++++++-
>  mm/nommu.c    |  3 ++-
>  4 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8fd6be932afe..5a2f571b64b7 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1539,7 +1539,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	if (!mm_init(mm, tsk))
>  		goto fail_nomem;
>
> -	err = dup_mmap(mm, oldmm);
> +	err = dup_mmap(tsk, mm, oldmm);
>  	if (err)
>  		goto free_pt;
>
> @@ -1552,6 +1552,13 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
>  	return mm;
>
>  free_pt:
> +	/*
> +	 * dup_mmap() has set it if it succeeded. get_task_mm() must not find
> +	 * it after the mmput() below.
> +	 */
> +	task_lock(tsk);
> +	tsk->mm = NULL;
> +	task_unlock(tsk);

It's not great to straddle some task stuff here, and some in
dup_mmap(). Could it all just live in copy_mm(), where other task stuff is
done?

It seems like changes you did in the previous patch dictate a move here,
but the fix that David mentions moves the mmap lock back to dup_mm() anyway
so a rework should hopefully avoid all that :)

>  	/* don't put binfmt in mmput, we haven't got module yet */
>  	mm->binfmt = NULL;
>  	mm_init_owner(mm, NULL);
> diff --git a/mm/internal.h b/mm/internal.h
> index 9e3be236f18c..70e40306d881 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1520,7 +1520,8 @@ int walk_page_range_debug(struct mm_struct *mm, unsigned long start,
>  			  pgd_t *pgd, void *private);
>
>  void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
> -int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
> +int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
> +	     struct mm_struct *oldmm);
>
>  int remap_pfn_range_prepare(struct vm_area_desc *desc);
>  int remap_pfn_range_complete(struct vm_area_struct *vma,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6ce654e33e3b..3167272a77ad 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -46,6 +46,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
> +#include <linux/sched/task.h>
>  #include <linux/ksm.h>
>  #include <linux/memfd.h>
>
> @@ -1705,7 +1706,8 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
>  	return true;
>  }
>
> -__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> +__latent_entropy int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
> +			      struct mm_struct *oldmm)
>  {
>  	struct vm_area_struct *mpnt, *tmp;
>  	int retval;
> @@ -1897,6 +1899,16 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  	mmap_write_unlock(mm);
>  	flush_tlb_mm(oldmm);
>  	mmap_write_unlock(oldmm);
> +	if (!retval) {
> +		/*
> +		 * As soon as dup_mmap_sem is released uprobes can find mm via
> +		 * the rmap tree and ask the consumers if they want it. The
> +		 * filter of an inherited perf event looks for mm in tsk->mm.
> +		 */
> +		task_lock(tsk);
> +		tsk->mm = mm;
> +		task_unlock(tsk);
> +	}

Yeah this isn't lovely, it feels like you're having mm logic handle
uprobe's problems. I don't like the idea of changing the signature here and
having core mm deal with the task stuff like this, and now it's being
fiddled with over 3 separate functions.

You should be doing this in the more generic fork code.

Or, ideally, if you could find a solution that doesn't involve changing
core fork code but rather modified uprobe to stop making what are,
currently, seemingly broken or at least sub-optimal assumptions that'd be a
lot better!

>  	uprobe_end_dup_mmap();
>  	if (!retval)
>  		dup_userfaultfd_complete(&uf);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 68b05565e15a..7529e03d3f2c 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1885,7 +1885,8 @@ static int __meminit init_admin_reserve(void)
>  }
>  subsys_initcall(init_admin_reserve);
>
> -int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
> +int dup_mmap(struct task_struct *tsk, struct mm_struct *mm,
> +	     struct mm_struct *oldmm)
>  {
>  	mmap_write_lock(oldmm);
>  	dup_mm_exe_file(mm, oldmm);
> --
> 2.55.0
>

--
Cheers, Lorenzo
