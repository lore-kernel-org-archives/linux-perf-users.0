Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636650;
	b=cnJMEUboowI9QslXdEoMkkec+DtLDdmHtreUPNdznIHu0igDc5i6Ao5etIVU/889fipZ
	 xNxBs4262GfhG272qkfOjZA3pLd7eK4+2hy6n09CfpkP11yjlL0Dl0tswyO1CQEhKZCiN
	 EGBuoPA0xrI3Os9P+Ek4ol4kyYw1QrnYox3tJAGUSFN0F5/rH7JPM0b+ZZ9SpRlcOYhIe
	 QlPisIG8VBtNhjafiYVLoyEZABiMkY7kiJgIBwIxKH1fprcLVb8Ou3P08cbhNzMiUyukq
	 52b+yEAhB+rDsoabzCl/tbiL8YRzjyMlodIy00lt25mLbO+0B6qHH9EUKVS7v+OKfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636650;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HE+3rCvUY47UpTl2ZHSutTG/UW4Ug8nC9fT+NbrJFCg=;
	b=n/NWpDGy46gMnhYnu32a1RunZbnS/Rl33pROWHGeiLcK8fg6NIDc1u2cHlr8Z6a3jiqn
	 eEBhPanQ2c9W/zpnrE4VS+FAhXTwiEv2S0eAGgSW90HGEWBLF9KHfag3ssW+1yvn4FiNz
	 wySUAtNgQXZbdqNV6FVfyNnCpu46EzQNmkrmj1bBQCjw6xeRNPp9CfD8ihbKg7S2u6H2i
	 ev6kr3C4w2u2fAmzq1bV8RIQRHK2t7TtKJlHS8YoUu3HoheaeTYMttZZ+qH5lt+y//xRD
	 QN11udlCcS371tERsS6W0R8fX+mYqgK54jNCGmaJr9n1jMcwABL08kvaBun63qnMQbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwuehG8n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087B3606A322;
	Thu, 22 Oct 2026 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwuehG8n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325D61F000C8;
	Thu, 22 Oct 2026 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792636649;
	bh=HE+3rCvUY47UpTl2ZHSutTG/UW4Ug8nC9fT+NbrJFCg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cwuehG8nqKWmnvGciE5SgD1NChwhoKyhe8hO/5bLbdtgMQSD9gOzOacuMpdSdcUXw
	 w8RY7uwhgwnhYOHDDIvulKZjtAHPTeuuITqZtzmBlRY2JD+sbhBwI0uBFVDQ5+Hlxv
	 2sb/ZKQ7jyOH+L43lzkRv01jGrVCAxdacxSDxKHmlcqMEIyhboUqNhp04IrfVjFaot
	 DIdigI8sECfJpdoWEhpAScd6llt+gzcmHSDFYevbbmlV9ak5mDiR3CSo5SHQ7EZf6X
	 M9/cVYgLYdQVyy85ZTZRBsZ/fhJCfVW9faFU8a9D2eZ+sN1clB+n9hekMS+tGoCTLF
	 p7YS7HbM04O+w==
Content-Type: multipart/mixed; boundary="===============7594496370134435936=="
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <778cae554b4280123e66d54fd1a7a92759259acc26f80e41c8779fce9b268ac7@mail.kernel.org>
In-Reply-To: <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 5/9] uprobes: Don't sleep on mmap_lock under dup_mmap_sem
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,oleg@redhat.com,peterz@infradead.org,mhiramat@kernel.org,jolsa@kernel.org,akpm@linux-foundation.org,liam@infradead.org,ljs@kernel.org,surenb@google.com,david@kernel.org,vbabka@kernel.org,jannh@google.com,hughd@google.com,kees@kernel.org,mingo@redhat.com,tglx@kernel.org,x86@kernel.org,linux-trace-kernel@vger.kernel.org,linux-mm@kvack.org,linux-perf-users@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 22 Oct 2026 02:37:29 +0000 (UTC)

--===============7594496370134435936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> uprobes: Don't sleep on mmap_lock under dup_mmap_sem

TL;DR: Question, possibly not a bug: uprobe_dup_mmap() edits oldmm page tables
inside dup_mmap() before vma_start_write(), so it may race with per-VMA read
lockers (page fault, MADV_DONTNEED); the review suspects it is safe.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c

[ ... ]

>  void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
>  {
> +	struct uprobe_walk *walk;
> +	struct map_info *info;
> +
> +	list_for_each_entry(walk, &uprobe_walks, list) {
> +		/*
> +		 * fork() that is being killed fails in copy_process().
> +		 * There will be no child. Leave oldmm to the walk.
> +		 */
> +		if (fatal_signal_pending(current))
> +			break;
> +		for (info = walk->busy; info; info = info->next)
> +			if (info->mm == oldmm)
> +				register_one_mm(walk, info, true);
> +	}
> +

A subsystem pattern flags this call as potentially concerning, so this may
not be a bug.

uprobe_dup_mmap() is called from dup_mmap() with mmap_write_lock_killable()
held on oldmm, and before the copy loop reaches vma_start_write_killable()
on each vma:

dup_mmap()
    mmap_write_lock_killable(oldmm)
    uprobe_dup_mmap(oldmm, mm)
        register_one_mm(walk, info, true)
            install_breakpoint() / remove_breakpoint()
                set_swbp() / set_orig_insn()
                    uprobe_write()
                        get_user_pages_remote()
                        folio_walk_start() + __uprobe_write()
                        collapse_pte_mapped_thp()   (unregister path)
                            try_collapse_pte_mapped_thp()
                                pmdp_collapse_flush() + pte_free_defer()
    ...
    vma_start_write_killable(mpnt)

The guide for the VMA locking code says to report functions that hold
mmap_write_lock and access page tables or PTE pages before calling
vma_start_write(vma), because other threads of the forking process may
still hold per-VMA read locks on the same vma, for example in a page fault
or in MADV_DONTNEED with CONFIG_PT_RECLAIM.

Can uprobe_write() and collapse_pte_mapped_thp() run against oldmm here
while another thread of the forking process holds a per-VMA read lock on
the same vma?

For context, the existing register_for_each_vma() -> register_one_mm()
walk already did this with only mmap_write_lock held.  What this patch adds
is a second caller of that code inside dup_mmap(), which did no page table
access on oldmm before vma_start_write().

On the other side, uprobe_write() takes the page table lock through
folio_walk_start() and retries when fw.page does not match the expected
page, and try_collapse_pte_mapped_thp() re-checks pmd_same() under the
locks before pmdp_collapse_flush().  khugepaged's retract_page_tables()
also retracts page tables without mmap_lock at all.  So it may be that
this access is safe without the per-VMA write lock.

Could you confirm whether the vma_start_write() rule is meant to apply to
the uprobe_write() path called from uprobe_dup_mmap()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39710454342
--===============7594496370134435936==--
