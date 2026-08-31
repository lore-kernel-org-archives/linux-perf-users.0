Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6C37C0E6
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206378; cv=none; b=Jb4+HL1zHox7mSH7d8ZQZQBdhs1fkyOO7rdltnpl/5QOK4tgUf4BLMpKi3ubzkXHZ35ocKxfEfXZj3Vj+FGoQaLl6N9Br7jFOYnDZhFqrjF49lC5FwmdNKyILUOAWnd6CAlic6W5uR9u2KmpL+z7tdyqp+BAM01CNUonoBIWvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206378; c=relaxed/simple;
	bh=SDOT1TyHSe8fLxywSxutpeq0upy+Ko61a90gYzCaorQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HNk1+JaeM5e8s4d05nNFNAP8mBFF5jMtxOPj+yaRGSj2fWKEZOXVfQykE575YTVV8f/ZArA/NSo811W3kmWNAYuSklCS39xa+iqOUGCq+n9omy5OkPj5hSDEb01eT5wBY8QsAAD7NATPXyfCkni9XoujRTsmwTL7vMP4JOE0MP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V14VgPec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V14VgPec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451161F000E9;
	Mon, 31 Aug 2026 19:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788206376;
	bh=F8E/IcVZQCrtK3NH/fJ6lcWpSdp8cHHpo+CcsZkIl8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V14VgPecG8tMkIi4jYEWs52vG5+kqh4Fnw/DvnfVGuYydgIqnvIugpfkyCi2Q7BT9
	 scsGV2nR9MMvW31I1bWzjLBADznHaobuZQlo2PNueEe5bYUyCSfVnWAWgCaxwWfUpF
	 AMC+LEEikJNpFDu/ZvCIMJp1fnTCQqvKYbv29kQP/eu1PbLhcN5V76O4+08JMDXtGo
	 KnrypO7ZuGq3fIV98p2BE8QraVwMt4lZTYSlQ/RcRVNq08F3BU6SVXcXfopslWt2jc
	 4MwMxGE0Ubfp5RV7rhDJd+gq4MTt7HcpnXAUkgo3cWLk9wXIhGULx7jm3kT525XmGP
	 jY454bTd8xd2Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 10/19] ptwrite uprobes: Minimal memory references and
 fault handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-11-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-11-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:59:35 +0000
Message-Id: <20260831195936.451161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Premature publication of `ptw->nblocks` without memory barriers =
exposes uninitialized memory to concurrent page fault handlers.
- [Medium] Rolling back `ptw->nblocks` on error allows in-place reuse of ar=
ray slots without an RCU grace period, causing torn reads in concurrent fau=
lt handlers.
--

commit 925690411c45029e0f0a323ac69035b5e1cc8c87
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Minimal memory references and fault handling

Add support for memory references. Currently this is only simple cases,
no indirect memory references or strings. This requires fault handling
using the fault notifier hook added earlier.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index df652c56414b5..90e702a4a8e99 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
[ ... ]
> @@ -1689,13 +1852,22 @@ int arch_uprobe_install_ptwrite(struct arch_uprob=
e *auprobe,
>  		return -ENOMEM;
> =20
>  	block_off =3D ptw->cursor;
> -	if (block_off > PAGE_SIZE ||
> -	    ptw_a->stub_len > PAGE_SIZE - block_off)
> +	if (block_off > PAGE_SIZE || ptw_a->stub_len > PAGE_SIZE - block_off)
> +		return -ENOMEM;
> +	if (ptw->nblocks >=3D ARRAY_SIZE(ptw->index))
>  		return -ENOMEM;
>  	stub_addr =3D ptw->vaddr + block_off;
>  	if (!ptwrite_rel32(stub_addr + ptw_a->jmp_off + 4,
>  			   vaddr + 5, &rel))
>  		return -ERANGE;
> +	site_delta =3D (s64)vaddr - (s64)ptw->vaddr;
> +	if (site_delta < INT_MIN || site_delta > INT_MAX)
> +		return -ERANGE;
> +
> +	ptw->index[ptw->nblocks].off =3D block_off;
> +	ptw->index[ptw->nblocks].len =3D ptw_a->stub_len;
> +	ptw->index[ptw->nblocks].ft_off =3D ptw_a->ft_off;
> +	ptw->nblocks++;
> =20
>  	kaddr =3D kmap_local_page(ptw->page);
>  	memcpy(kaddr + block_off, ptw_a->stub, ptw_a->stub_len);

[Severity: Medium]
Does this code expose uninitialized memory to concurrent page fault handler=
s?

Since ptw->nblocks is incremented before memcpy() initializes the stub
block memory, a concurrent lockless reader in uprobe_ptwrite_handle_fault()
might observe the incremented nblocks and read the uninitialized fault table
while memcpy() is actively writing to it.

> @@ -1704,9 +1876,13 @@ int arch_uprobe_install_ptwrite(struct arch_uprobe=
 *auprobe,
>  	kunmap_local(kaddr);
> =20
>  	ret =3D ptwrite_text_poke(auprobe, vma, vaddr, stub_addr);
> -	if (!ret)
> -		ptw->cursor =3D block_off + ptw_a->stub_len;
> -	return ret;
> +	if (ret)
> +		/* Publish rollback before readers use the reduced block count. */
> +		smp_store_release(&ptw->nblocks, ptw->nblocks - 1);
> +		return ret;
> +	}

[Severity: Medium]
Can this rollback of ptw->nblocks cause use-after-free or torn reads for
concurrent readers?

If ptwrite_text_poke() fails, ptw->nblocks is rolled back. However, a
lockless reader executing uprobe_ptwrite_handle_fault() under rcu_read_lock=
()
might have already read the old ptw->nblocks and be actively iterating over
this slot. A subsequent probe installation could then immediately reuse this
array slot and block_off memory without waiting for a synchronize_rcu()
grace period, causing the lockless reader to observe torn data.

> +	ptw->cursor =3D block_off + ptw_a->stub_len;
> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D10
