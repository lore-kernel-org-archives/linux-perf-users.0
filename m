Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EAB388392
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208760; cv=none; b=vF1+nipk6bp9FL5c4vvKSPXXrZah1R+4GVnQIaQ7i23C2z1P/LOrK+SNY9MOPih+mb9dkKfGk6snScsAUCFKjZuX5ohEmtEljAKK3Kwhpinrfi20tU8KpFTS7D1hgQYgH6ofp5flmn+MGSBeGIde+0lHHuDaP0dSXJx+NnHhI0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208760; c=relaxed/simple;
	bh=Fxtg7pcYiKV7NEC4fA1qJXQN3RUgUfrlVIHqb5qGNQw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TNP2u+Nqu8BkJ2ibtZydl8fTpILKlhfhHCtVtoyVAaaYujmW8xLHem07JM7vxQQAZkfBK35jfUWsttn27Og4YguzOhYxJ9AgxNDNyMX+Y3E/sYaHw2qL86tEhWEN46NrGwhCw0AiNUpxStPvTctr4MjjVEYRVC7JGxNhXhLXEfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiN63Zbq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiN63Zbq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5861F000E9;
	Mon, 31 Aug 2026 20:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788208758;
	bh=l3nyTtlCpdP3nldPfA1SRj7Cti94xPWA/KnOLjonHag=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aiN63ZbqcTiOsBIzBCLwDIjNf7tPXBhRGPj94npJz0eeZ2PP+7DfQ/1mYcul0lcQf
	 NJ2QGHU+uJntztBagckN8xmd1vGiBqtw81QgkDS4CBe+4++i8HrgM/bEhZLtSM7Gal
	 W84nAYUcLaDB3YHHTocOu4MBu8SYlB8yH/R/W5L7UpNPRSAM2yc4oy/lMsC0O7O7dS
	 jPEUBtEB9NNk05fc8MLLdbJfw4ugdAoFc1YvYOnnpY33hjwJ41nwMSVeN/rcIt4gFq
	 VC7sMkTnJTnwFiKDCmrTxDt+d4CkJ9v5yt27gq2kG2jkLNIfVRDuGxBMljWnkplRKQ
	 cx2PzKF+AnlLA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 13/19] ptwrite uprobes: Support instruction puning
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-14-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-14-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:39:17 +0000
Message-Id: <20260831203918.5A5861F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Stack out-of-bounds read in `pun_install` when copying the origina=
l instruction.
- [High] Uninstalling a punned uprobe fails and permanently corrupts proces=
s memory if the user modifies the instruction's subsequent bytes.
--

commit bfefc3cb6738d81a0fc8093e66776a8584e4deed
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Support instruction puning

The previous ptwrite instrumentation only worked on 5 byte+ nops because
it needs to patch in a 5 byte branch. But the instruction may be shorter
and the kernel cannot prove that nobody jumps to the next instruction.

[ ... ]

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 20557423690f9..806e40f7b0ab3 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1866,10 +2001,210 @@ static int ptwrite_text_poke(struct arch_uprobe =
*auprobe,
>  	return err;
>  }
> =20
> +/*
> + * Replace an aligned five-byte NOP run with a JMP in one eight-byte sto=
re.
> + * The trailing three bytes are read from the existing text. We assume
> + * nobody else is changing it. This is covered by the Intel/AMD "aligned=
 store"
> + * cross modifying guarantee.
> + */

[ ... ]

> +static int pun_install(struct arch_uprobe *auprobe,
> +			       struct vm_area_struct *vma, unsigned long vaddr,
> +			       const u8 *orig)
> +{
> +	struct mm_struct *mm =3D vma->vm_mm;
> +	struct uprobe_ptwrite_page *ptw;
> +	struct uprobe_ptwrite_arch *ptw_a =3D &auprobe->ptwrite;
> +	struct uprobes_state *state =3D &mm->uprobes_state;
> +	struct write_opcode_ctx ctx =3D {
> +		.base =3D vaddr,
> +		.expect =3D EXPECT_BYTE,
> +		.expect_byte =3D orig[0],
> +	};
> +	unsigned long t, page_base, block_off, stub_addr;
> +	s64 site_delta;
> +	s32 jump_rel, disp32, orig_rel;
> +	u8 site_len;
> +	bool found =3D false;

[ ... ]

> +	/*
> +	 * A NOP fallback needs a synthetic rel32 at the site, so it uses
> +	 * the full five-byte poke and restore path rather than punning.
> +	 */
> +	site_len =3D nop_fallback ? 5 : ptw_a->len;
> +	ptw->index[ptw->nblocks].off =3D block_off;
> +	ptw->index[ptw->nblocks].len =3D ptw_a->stub_len;
> +	ptw->index[ptw->nblocks].ft_off =3D ptw_a->ft_off;
> +	ptw->index[ptw->nblocks].pun =3D !nop_fallback;
> +	ptw->index[ptw->nblocks].orig0 =3D orig[0];
> +	ptw->index[ptw->nblocks].site_len =3D site_len;
> +	ptw->index[ptw->nblocks].site_off =3D (s32)site_delta;
> +	memcpy(ptw->index[ptw->nblocks].site_insn, orig, site_len);

[Severity: High]
Does this memcpy() read out-of-bounds?=20

The original instruction is passed down via the orig parameter from
arch_uprobe_install_ptwrite(). In arch_uprobe_install_ptwrite(), orig is
declared as a 5-byte array on the stack.

However, site_len here can be up to 15 bytes (MAX_UINSN_BYTES) for generic
instructions when punning is active. If site_len is greater than 5, this wi=
ll
copy uninitialized kernel stack memory into the permanent site_insn array.

Later, when attempting to reinstall the uprobe, the memcmp() against the tr=
ue
original instruction will fail due to the garbage bytes. This breaks the
collision check and could cause a trampoline slot leak on every reinstall.

> +	smp_store_release(&ptw->nblocks, ptw->nblocks + 1);

[ ... ]

> @@ -1937,15 +2301,63 @@ int arch_uprobe_uninstall_ptwrite(struct arch_upr=
obe *auprobe,
>  		struct vm_area_struct *vma, unsigned long vaddr)
>  {
>  	struct mm_struct *mm =3D vma->vm_mm;
> +	struct uprobe_ptwrite_arch *ptw_a =3D &auprobe->ptwrite;
> +	struct uprobes_state *state =3D &mm->uprobes_state;
>  	u8 cur[5];
> +	int b;
> +	struct write_opcode_ctx ctx =3D {
> +		.base =3D vaddr,
> +		.expect =3D EXPECT_BYTE,
> +		.expect_byte =3D 0xe9,
> +	};
> =20
>  	mmap_assert_write_locked(mm);
> -	if (copy_from_vaddr(mm, vaddr, cur, sizeof(cur)) ||
> -	    !ptwrite_is_installed(mm, vaddr, cur))
> -		return;
> +	{
> +		struct uprobe_ptwrite_page *ptw;
> +		struct uprobe_ptwrite_page *fpw =3D NULL;
> +		s32 rel;
> +		s64 target;
> +		unsigned long page_base, boff;
> +		int ret;
> +
> +		ret =3D copy_from_vaddr(mm, vaddr, cur, sizeof(cur));
> +		if (ret)
> +			return ret;
> +		if (!ptwrite_is_installed(mm, vaddr, cur))
> +			return 0;

[Severity: High]
Does this validation incorrectly abandon punned uprobes?

If a punned uprobe is installed on an instruction with a relative offset,
bytes 1-4 are mutable user code. The user application (e.g., a JIT compiler
or dynamic linker) might legitimately update the relative offset in these
subsequent bytes.

When the uprobe is uninstalled, ptwrite_is_installed() strictly requires the
JMP target to still point to the trampoline. Since the user modified the
relative displacement, ptwrite_is_installed() returns false.

This assumes the probe was entirely overwritten and aborts the uninstall
prematurely, returning 0. As a result, the injected 0xe9 (JMP) opcode is le=
ft
permanently in the user's execution stream, which can corrupt the instructi=
on
stream and cause crashes or erratic behavior.

> +
> +		memcpy(&rel, cur + 1, sizeof(rel));
> +		target =3D (s64)vaddr + 5 + (s64)rel;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D13
