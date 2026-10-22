Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635828;
	b=tg4M+aEna0RUXzVWZNWiDLf4LtbDHYwPwCdzI9DbKhh6OSRR/4XDRoqrlTbc5wF2HeWm
	 tQQrC1hPHbh+q+s4Ap7WlX0SeZ4x/AjgX+lE59xDu7AB/ORF5J/GtsFWc4M1INzVIx8aW
	 Shl0iM1s9HAGtBBjJnxzEfkKiQQK9eqyYGaZkbydmcL15iSMTFy2TsM5CKlvg2H0GUaY6
	 EmrVVtdPW5gSGJGCUhcWqDC28TPSrQJgk+rI8A7I4maZ0zDHgdpUlNg3cSUV8eY4JGOCr
	 T1Z8ecoQnax1iaBMzmFXenZIL8JC9CW7U62Tv852O1pFR4kBbQQHdTI69MKYcVbsD6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mBLFTHurzlOVyM6uH/HHo/O74KxQ81dFv20NSPnPgsE=;
	b=VcxICI6IGlaqPC0dgCoEdPnzLCrhp9nFXld1rGsANVdMpkf9vIuBSRhHbe5Wvx1+x+jE
	 VuZltqNPua2Il9eJV2zD2JkMpGGeQD4W9icwGuTtSGjPyFx6NMtonlXpxUP9/gPfipd0U
	 NzlqUUHvmUfsuvs6vFzvG5UcjTvb+LNUBZs/ysPeqJrv/aUFZ1wSQ9NgMXLe77eInEigy
	 sYGwN9OakjzpLGHLOVG79d4PXJWmdwriVe1mRInie7tjEbouXfa1TYT9ptWEf0xiE0hbL
	 ZE5UFXfWNO8JTOwiD+8wRkPV7EmqDWBBITPIn8mKch5CWgP2YzTsodKmR5WrzATI55g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q15zNXKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1A606A31A;
	Thu, 22 Oct 2026 02:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q15zNXKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D9D1F000C1;
	Thu, 22 Oct 2026 02:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635827;
	bh=mBLFTHurzlOVyM6uH/HHo/O74KxQ81dFv20NSPnPgsE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q15zNXKKzoqGf8aAZ5Pu3S3PrJGW0I6NP4zEdzaVJ3YREoUIdN7leXcVKZ9DnnQfH
	 eRk8fLDOhhNB/3DyUYR2cfpwOF0o7BKb/Z59liUY/1fdQQRa+4ptJJr5g+5J39TlI5
	 i7tKgkQcwBwdK9fike9k6Qp59yQ5qWcTVRGpLSPW0x2kdVyxkSvZl1CmvRMSiYTTmj
	 d/EDpLB3WMoJHOvJDw/UiSROEimsHsNOc+8tjCEU5UN5Z1WgtUcceEyN3xPMzoH1dU
	 q1suCFGadz+fcFEtwQYF2ZjRFYk8i1XTuZdB9E+PuKqUwgR3yI1tb8DNlPrUr1/sd0
	 6OTs6rHF7br2g==
Message-ID: <sashiko-outbox-180866@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 7/9] fork: Let the new task point to its mm
 before uprobes can find it
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, mingo@redhat.com, tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-8-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:23:45 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] fork: clear p->mm under task_lock() before mmput() in bad_fork_cle=
anup_mm
--

commit ec1e952207350f8b07e6038358df3fabd0496801
Author: Alexei Starovoitov <ast@kernel.org>

fork: Let the new task point to its mm before uprobes can find it

This commit sets tsk->mm under task_lock() at the end of dup_mmap() before
uprobe_end_dup_mmap() releases dup_mmap_sem, so that uprobe filters on
inherited perf events can match the child's mm. It also clears tsk->mm under
task_lock() if dup_mm() fails after dup_mmap() succeeds.

> diff --git a/kernel/fork.c b/kernel/fork.c
> index 2e125623cdbc3..a1042e370bdb8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1537,7 +1537,7 @@ static struct mm_struct *dup_mm(struct task_struct =
*tsk,
>  	if (!mm_init(mm, tsk))
>  		goto fail_nomem;
> =20
> -	err =3D dup_mmap(mm, oldmm);
> +	err =3D dup_mmap(tsk, mm, oldmm);
>  	if (err)
>  		goto free_pt;
> =20
> @@ -1550,6 +1550,13 @@ static struct mm_struct *dup_mm(struct task_struct=
 *tsk,
>  	return mm;
> =20
>  free_pt:
> +	/*
> +	 * dup_mmap() has set it if it succeeded. get_task_mm() must not find
> +	 * it after the mmput() below.
> +	 */
> +	task_lock(tsk);
> +	tsk->mm =3D NULL;
> +	task_unlock(tsk);
>  	/* don't put binfmt in mmput, we haven't got module yet */
>  	mm->binfmt =3D NULL;
>  	mm_init_owner(mm, NULL);

[Severity: High]
dup_mm() clears tsk->mm under task_lock(tsk) before calling mmput(mm) so
that get_task_mm() cannot find a freed mm when dup_mm() fails. However,
what happens if copy_process() fails after copy_mm() has already succeeded?

In kernel/fork.c:copy_process(), perf_event_init_task() runs before
copy_mm() and links inherited perf events (with event->hw.target =3D p) onto
parent_event->child_list and uprobe filter->perf_events:

kernel/fork.c:copy_process() {
	...
	retval =3D perf_event_init_task(p, clone_flags);
	if (retval)
		goto bad_fork_sched_cancel_fork;
	...
	retval =3D copy_mm(clone_flags, p);
	if (retval)
		goto bad_fork_cleanup_signal;

If a later step in copy_process() fails (for example, copy_namespaces(),
copy_io(), copy_thread(), alloc_pid(), cgroup_can_fork(), or
fatal_signal_pending(current) after waiting in dup_userfaultfd_complete()),
execution jumps to bad_fork_cleanup_mm:

bad_fork_cleanup_mm:
	sched_cache_fork_cleanup(p);
	if (p->mm) {
		mm_clear_owner(p->mm, p);
		mmput(p->mm);
	}
	...
bad_fork_cleanup_security:
	security_task_free(p);
bad_fork_cleanup_audit:
	audit_free(p);
bad_fork_cleanup_perf:
	perf_event_free_task(p);

Here mmput(p->mm) drops the reference and frees the mm, but p->mm is left
non-null while teardown continues through exit_fs(p), exit_files(p), and
security_task_free(p) before perf_event_free_task(p) detaches the inherited
events.

During this window, can a concurrent caller of get_task_mm(p) (such as
perf_event_set_addr_filter() -> perf_event_for_each_child() ->
perf_event_addr_filters_apply() in kernel/events/core.c) or bpf helpers like
bpf_find_vma() and bpf_iter_task_vma_new() in kernel/bpf/task_iter.c (for
instance from security_task_free(p)) observe the non-null p->mm under
task_lock(p) and call mmget() on the already-freed mm_struct?

Similarly, when perf_event_free_task(p) -> uprobe_perf_close() runs (or a
concurrent uprobe_perf_filter() runs), trace_uprobe_filter_remove() and
__uprobe_perf_filter() in kernel/trace/trace_uprobe.c read
event->hw.target->mm and compare that dangling pointer against active
mm_structs.

Should bad_fork_cleanup_mm in copy_process() also clear p->mm under
task_lock(p) before calling mmput()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D7
