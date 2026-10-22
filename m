Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792635625;
	b=vEHFkz5Ac9oxZbWCuHPtJ7BDkppnPOHTVXrDi12FxsXW2JzsL8j8ZAf/ljU+sUvZmLEg
	 GFBLe8z7laeNPpYWEIW/8S5u0ul8WY0xoX8N0SldjMXWJ4Kj/D/US6DS2xnVYtTfP8tEN
	 11AIoKbva9VZFAEV7CrBHKcVFg5bximHWjw0Bc5n72xdHOJbQG1Amubtuipit5cI9MUR6
	 uRcKFKpIfxyjMYMq1iwxQwkFR5vTUqNru7UiOzCH2RXDJkFaLQ7SERNyWMmx2HyzNn365
	 /9pKBdN7KosWf51EFVAULrYtdIn7go6zJKpTjTkECh/qiSSklBvk8temuL//NOXUjHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792635625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UnjqwNlN/vgrrn7ctvV07+vISpDnk/w+Es11vkxy9hs=;
	b=wwvsmLJyFzQa00uOf6S01tHVKaVue98l3hCxZgFqUoc/W3zh2BxGRyA1TF1B9xQLFEi7
	 tNVF763zXQY11IwJDjMQOe2xVKC1bEiZ7PEN6/qrxO7SK7N0JUdO2Z13BqNt6nlAJ8eK6
	 OH4BWOLGAEWUzkDwD2J8rjMes1u2V78dr1GFFz699Fw0BcLRUlkLWaYavJWysQbOCnQ9A
	 33ZiGK6FtDeuTPk4lGG6OxGybLeHO0YeqRnjd2YdHsJ3sLpIJzl572LpYPLMh8Jrcr/f5
	 xfGEzMGhB3DmGtSDsUOW9O0h8bCww8/aeJ+TWI16Pe50ZWNAVOFRmWVloHrlZyvQj3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhoztoFB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B59B606A319;
	Thu, 22 Oct 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhoztoFB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA521F000C1;
	Thu, 22 Oct 2026 02:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792635625;
	bh=UnjqwNlN/vgrrn7ctvV07+vISpDnk/w+Es11vkxy9hs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mhoztoFBxeJzIKv5S8KNo8pPx85vjezglEBZFDx4h8bvdssEmMaTYAzrht0KuT1Z1
	 IJcH2Qrb2viK3SZTlQLm5c4GQX+ViSbh4h2PRH5UkgYDsJ1n3IQ40VjW+IMKgz5+ky
	 BWRmUwUFBwG9kAhGXgLCSPDD8bmssDM3XU+KCdwjLmstncYEjN9PFGOlM1/OMssGHl
	 eh8/HD+Czzfhk5KE3tvcryz0AZggK3Z9B0EjeQatYECEWVKGtD01NaGT0Mz+t3WcnB
	 cwYEU8O9RQ9xZ3qes8TrsMFhTmrTCNNHoJBMnwnkKRuG3R7elCAJF1g6H5FPEIFVrf
	 E1Kr6n2NZWnyw==
Message-ID: <sashiko-outbox-180864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 8/9] uprobes: Don't leak the breakpoints if the
 unregistering task is killed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, oleg@redhat.com, peterz@infradead.org, mhiramat@kernel.org, jolsa@kernel.org, akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, surenb@google.com, david@kernel.org, vbabka@kernel.org, jannh@google.com, hughd@google.com, kees@kernel.org, mingo@redhat.com, tglx@kernel.org, x86@kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261022015712.1297331-9-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
 <20261022015712.1297331-9-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:20:23 +0000
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
- [Medium] uprobes: double ref_ctr decrement and breakpoint leak in unregis=
ter_all_vmas()
--

commit 02db19b4afb60ef4b8ca6aaa98c8fe074f02d199
Author: Alexei Starovoitov <ast@kernel.org>

uprobes: Don't leak the breakpoints if the unregistering task is killed

This commit offloads breakpoint removal in uprobe_unregister_nosync() and
uprobe_apply() to an unbound workqueue item when the file is mapped by user
processes, preventing a fatal signal on the unregistering task from failing
get_user_pages_remote() with -EINTR and leaking breakpoints.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 92ccb730278f3..361b52c9c3bcf 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -1426,6 +1426,68 @@ register_for_each_vma(struct uprobe *uprobe, struc=
t uprobe_consumer *new)
>  	return walk.err;
>  }
> =20
> +struct unregister_work {
> +	struct work_struct work;
> +	struct uprobe *uprobe;
> +	int err;
> +};
> +
> +static void unregister_work_fn(struct work_struct *work)
> +{
> +	struct unregister_work *uw =3D container_of(work, struct unregister_wor=
k, work);
> +
> +	uw->err =3D register_for_each_vma(uw->uprobe, NULL);
> +}
> +
> +/*
> + * Remove the breakpoints. If current is killed, get_user_pages_remote()=
 fails
> + * with -EINTR from then on: the breakpoints which are left stay for goo=
d, and
> + * the removal which was interrupted can be left half-way, with the refe=
rence
> + * counter decremented but the breakpoint still there. So let a kworker =
do the
> + * job, it has no signals. It takes the locks we would take ourselves.
> + * (A fork() of an mm with busy mmap_lock can still do one removal in a =
task
> + * which is being killed, see register_one_mm().)
> + *
> + * A kernel thread can do it itself. So can anybody if nobody maps the f=
ile:
> + * then there is no breakpoint, and uprobe_mmap() installs none which we=
 would
> + * have to remove.
> + */
> +static int unregister_all_vmas(struct uprobe *uprobe)
> +{
> +	struct address_space *mapping =3D uprobe->inode->i_mapping;
> +	struct unregister_work uw =3D { .uprobe =3D uprobe };
> +	bool mapped;
> +	int err;
> +
> +	/*
> +	 * vma_prepare() takes a vma out of the tree and vma_complete() puts it
> +	 * back, under i_mmap_lock_write(). Don't mistake that for an empty tre=
e.
> +	 */
> +	i_mmap_lock_read(mapping);
> +	mapped =3D mapping_mapped(mapping);
> +	i_mmap_unlock_read(mapping);
> +
> +	if (!mapped || (current->flags & PF_KTHREAD)) {
> +		err =3D register_for_each_vma(uprobe, NULL);
> +		/*
> +		 * An error with a fatal signal pending: the file was mapped
> +		 * meanwhile, and get_user_pages_remote() returned -EINTR before
> +		 * it could see that there is nothing to remove. Nothing was
> +		 * written, so it is safe to let the kworker repeat the walk.
> +		 * (Kernel threads which unregister uprobes don't allow SIGKILL.)
> +		 */
> +		if (likely(!err) || !fatal_signal_pending(current))
> +			return err;
> +	}

[Severity: Medium]
Can the !mapped path in unregister_all_vmas() still leave ref_ctr decrement=
ed
and then decrement it a second time when the kworker repeats the walk?

When !mapped is observed under i_mmap_lock_read(mapping), unregister_all_vm=
as()
drops the lock and calls register_for_each_vma(uprobe, NULL) in the killable
user task instead of returning 0 directly.

While i_mmap_lock_read(mapping) is dropped, a process can map the file.
uprobe_mmap() runs without uprobe->register_rwsem and installs the breakpoi=
nt
if any consumer in filter_chain(uprobe, vma->vm_mm) matches at that moment:

kernel/events/uprobes.c:uprobe_mmap() {
    ...
	list_for_each_entry_safe(uprobe, u, &tmp_list, pending_list) {
		if (!fatal_signal_pending(current) &&
		    filter_chain(uprobe, vma->vm_mm)) {
			unsigned long vaddr =3D offset_to_vaddr(vma, uprobe->offset);
			install_breakpoint(uprobe, vma, vaddr);
		}
		put_uprobe(uprobe);
	}
}

Before register_for_each_vma() -> register_one_mm() inspects that mm,
filter_chain(uprobe, mm) can become false without taking
uprobe->register_rwsem. For example, another thread can run
uprobe_perf_close(), which updates the filter before calling uprobe_apply():

kernel/trace/trace_uprobe.c:uprobe_perf_close() {
	tu =3D container_of(tp, struct trace_uprobe, tp);
	if (trace_uprobe_filter_remove(tu->tp.event->filter, event))
		return 0;

	list_for_each_entry(tu, trace_probe_probe_list(tp), tp.list) {
		ret =3D uprobe_apply(tu->uprobe, &tu->consumer, false);
		if (ret)
			break;
	}
    ...
}

Or the target thread of a per-task perf event in a multithreaded process can
exit and clear tsk->mm in exit_mm().

Then the first register_for_each_vma(uprobe, NULL) call in unregister_all_v=
mas()
sees !filter_chain(uprobe, mm) and calls remove_breakpoint() -> uprobe_writ=
e().
If the anonymous page is COW-shared (for instance, the process forked after
uprobe_mmap()), the initial pass without FOLL_WRITE decrements ref_ctr via
update_ref_ctr(uprobe, mm, -1), gets -EFAULT from __uprobe_write(), and loo=
ps
to retry with FOLL_WRITE:

kernel/events/uprobes.c:uprobe_write() {
    ...
	if (do_update_ref_ctr && !ref_ctr_updated && uprobe->ref_ctr_offset) {
		ret =3D update_ref_ctr(uprobe, mm, is_register ? 1 : -1);
		if (ret) {
			folio_put(folio);
			goto out;
		}

		ref_ctr_updated =3D 1;
	}
    ...
	switch (ret) {
	case -EFAULT:
		gup_flags |=3D FOLL_WRITE | FOLL_SPLIT_PMD;
		fallthrough;
	case -EAGAIN:
		goto retry;
	default:
		break;
	}

out:
	/* Revert back reference counter if instruction update failed. */
	if (do_update_ref_ctr && ret < 0 && ref_ctr_updated)
		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
}

If current now receives SIGKILL, both get_user_pages_remote() at retry and =
the
revert call in update_ref_ctr(uprobe, mm, 1) fail with -EINTR, leaving ref_=
ctr
decremented and the breakpoint still installed. When unregister_all_vmas()
falls through to queue uw.work, the kworker runs register_for_each_vma() ag=
ain
and decrements ref_ctr a second time (or fails with -EINVAL if ref_ctr would
go negative, leaking the uprobe and breakpoint).

If !mapped is true under i_mmap_lock_read(mapping), could unregister_all_vm=
as()
return 0 immediately instead of calling register_for_each_vma(uprobe, NULL)?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022015712.1297=
331-1-alexei.starovoitov@gmail.com?part=3D8
