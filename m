Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F9239A061
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210501; cv=none; b=LQd2/JImqoJV4CNeWBMIJ9EChqyc9zlHNLJyJFK0asrbx9YBvsmAN+du5U1onj6SS5aMFGFg3H3Q2kLQiBCWWooeGsOOpcBiSX6xQGOuyOOdH/TUSTVXlzbl2DOWSCKmGU3nXkm8LOKSGWwNbbpajTADpnzgY6RkIs3F8ldi2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210501; c=relaxed/simple;
	bh=tER9RlUelSZjhH7VAlTJuqQai2Vz/rEHUtbniXkgggQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGexSzk40HvGswtyuFgMLPq5f2uAYXV8/IFLytCpwNj49fwTpxYBHxviLS5n7I97Gsf8WndbjMJ+1Ai42hmr/9Ad3TA2uDAJwfELoafJSl7/HtPJqz/+m1qZMnIXrzXwQr0lTyxcXu1v1Cg1p/cAAxYNY99vM2yDHW0uRSDq3Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIeaosZP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIeaosZP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645B1F000E9;
	Mon, 31 Aug 2026 21:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210499;
	bh=yyBuSR+wh2YwoFNWF24j5gM/rfo756uWzokMQ7A9Okk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cIeaosZPY3Quh/9kBNXA4P35Q2M1VwkwnJU9tn8EOK/Pna1cej+jSTpue2VOPrlqO
	 C0bBGGRLdm6QaXGSJ4uvqGUHOqI1XFl+bTOL8JsWfq78Apif/5JKUXnWOyFXWf1NYt
	 XrnDRKxf7eRYqAquxYkEiLA7XCjM511SJbvnfoTOu2vkhrfCTypjfmVX8KeYd2nC5f
	 FLFUxfgAttF7lCr8cqQObpjeP75EqRe/J6fnWXYM1ZemUkQGxYoVJUaevCFTqrn7H9
	 NrCQ8UOm9f/BI/WKMmgBasMY0vQSGcweLAzB4tBtuScUA/Sh9E1BakGdNoRd1TJuyU
	 6vZFghNmneffA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 14/19] ptwrite uprobes: Use atomic patching for
 multinop sites
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-15-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-15-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:08:18 +0000
Message-Id: <20260831210819.C645B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Structurally unsafe patching of multinop sequences in user space d=
ue to thread preemption.
- [High] Unaligned multinops silently fall back to the unsafe INT3 patching=
 method, violating the patch's safety guarantees.
- [Medium] Lockless Read-Modify-Write (RMW) of user memory resulting in a T=
OCTOU race and lost updates.

Pre-existing issues:
- [High] O(N) sequential synchronize_rcu() calls inside an RCU teardown loo=
p causing severe process exit delays.
--

commit 5a4cb6048cbb1f8b37fe6998acf1c5e1ac8b2670
Author: Andi Kleen <ak@kernel.org>

    ptwrite uprobes: Use atomic patching for multinop sites

This commit modifies the patching mechanism for 5-byte NOP sequences
(multinop) in ptwrite uprobes. It enforces 8-byte alignment for these sites
and replaces the earlier INT3 patching method with an atomic 8-byte
read-modify-write store.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 806e40f7b0ab3..8d9dadc2b1fc6 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c

[ ... ]

> @@ -2224,6 +2232,9 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe =
*auprobe,
>  	ret =3D copy_from_vaddr(mm, vaddr, orig, sizeof(orig));
>  	if (ret)
>  		return ret;
> +	if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run) &&
> +	    (vaddr & 7))
> +		return pun_install(auprobe, vma, vaddr, orig);

[Severity: High]
Does this silently apply the unsafe INT3 patching method to unaligned NOP
sequences?

The commit message states that the earlier multinop patching is unsafe and
enforces 8-byte alignment. However, when an unaligned 5-byte NOP sequence
is requested (vaddr & 7 is true), the code delegates to pun_install().

Looking at pun_install(), this triggers the fallback path:

arch/x86/kernel/uprobes.c:pun_install() {
    ...
	bool nop_fallback =3D ptwrite_site_is_multinop(orig,
						     ptw_a->allow_nop_run) &&
			    (vaddr & 7);
    ...
	if (nop_fallback)
		ret =3D ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
    ...
}

Will this expose the traced process to the same user-space crash issues
that this patch intends to fix?

>  	if (ptwrite_is_installed(mm, vaddr, orig))
>  		return 0;

[ ... ]

> @@ -2249,9 +2260,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe=
 *auprobe,
>  			continue;
>  		if (!__in_uprobe_ptwrite(mm, ptw->vaddr))
>  			continue;
> -		ret =3D ptwrite_text_poke(auprobe, vma, vaddr,
> -					ptw->vaddr + ptw->index[b].off);
> -		goto out;
> +		if (ptwrite_site_is_multinop(orig, ptw_a->allow_nop_run))
> +			ret =3D ptwrite_multinop_text_poke(auprobe, vma, vaddr,
> +							ptw->vaddr + ptw->index[b].off);

[Severity: High]
Is this structural patching safe against thread preemption?

If a user thread executes the first byte of a 5-byte NOP sequence (such as
one generated by -fpatchable-function-entry) and is preempted, the kernel
will patch the sequence with a 5-byte JMP.

When the thread resumes at vaddr + 1, won't it execute the relative offset
bytes of the JMP as garbage instructions and crash with SIGILL or SIGSEGV?
While an atomic store prevents fetch anomalies, does it prevent a preempted
thread from resuming execution in the middle of the patched instructions?

[Severity: Medium]
Can this lockless Read-Modify-Write result in a TOCTOU race and lost
updates?

Looking at ptwrite_multinop_text_poke():

arch/x86/kernel/uprobes.c:ptwrite_multinop_text_poke() {
    ...
	err =3D copy_from_vaddr(mm, vaddr, patch, sizeof(patch));
	if (err)
		return err;
	patch[0] =3D 0xe9;
	memcpy(&patch[1], &rel, sizeof(rel));
	err =3D uprobe_write(auprobe, vma, vaddr, patch, sizeof(patch),
			   verify_insn, true, false, &ctx);
    ...
}

If a user process concurrently modifies the trailing bytes (bytes 5-7) of
the 8-byte aligned word between the copy_from_vaddr() read and the
uprobe_write(), won't those modifications be silently overwritten and lost?

[Severity: High]
This is a pre-existing issue, but does the process cleanup path force an
extremely slow O(N) grace-period wait?

Looking at arch_uprobe_clear_state():

arch/x86/kernel/uprobes.c:arch_uprobe_clear_state() {
    ...
	hlist_for_each_entry_safe(ptw, n, &state->head_ptwrite, node) {
		hlist_del_rcu(&ptw->node);
		synchronize_rcu();
		__free_page(ptw->page);
		kfree(ptw);
	}
    ...
}

If a traced process has many ptwrite uprobes and exits, it will block
sequentially for an RCU grace period for every single page. Could this
cause severe process exit delays or hung task timeouts?

> +		else
> +			ret =3D ptwrite_text_poke(auprobe, vma, vaddr,
> +						ptw->vaddr + ptw->index[b].off);
> +		return ret;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D14
