Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A5DEEC0
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376789; cv=none; b=ffrCZnrXDbMZSbiv/DphCTUclsrp3wrzPgF1mRULzEylPYivz6a3ASVTdn9gwBjBGWah25uj7ipeU8sUpa/Q6jk1c6+6PXlJGoRB79l5WKM7I7lb4ymLeFD+WuW3jye9U2WTDyZrv8+OYT1b2z1DIjSqJGyV/V3ik9Q3iyuQ9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376789; c=relaxed/simple;
	bh=MJ96hmMC7tGW5a5w1oQrCn2zYzaKm/lOvRrkBNbRNsc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pa7NFLaL04z8Rh8l4nS4U8ukvMhTGplQT5KBpGq0m+CWXF1pRTGG2TLU8so0aB0DBrZO5wdlKP6FYB7bDx5ipsZ3k8Au9/NWzlJdM0dS+3ixbxlp2/1D7Jtnd9jU3tIA5WOi70IDitQzXm4sTV4VFJfpsEV6V+tGQgHkPu3MxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HW0nPWjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HW0nPWjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA9A1F000E9;
	Thu, 30 Jul 2026 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785376788;
	bh=0OHz5dZrO25xp8cUEijXwVq7dEvRGmriLYd27tLTIgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HW0nPWjJWzKQyE1FLxsHFDkE6xHDWDPpe2/7fyrbCU4By+BXe4l/+1P2rzgqNwUHs
	 EbYH5yo0XbXhPGxJP5FT3w15dw/9Emck0fS+CZxDo8cb/AwtB7VBtyDrQqmUFjun5K
	 RkUZQlw5AONYsgUVBxmD+ZW+dHsuyppy9U/lsE662pz9h8BrmtJeh+DtMI2HA9zBsz
	 Uug5xlhElCF1JqO2nNdV/b8rQHjrJMiXmLw71ffc0SWW0OKRazSClCe9gac9mFSsYj
	 e+BY+K2yt6OcgfkWFsoVzaslw9rmH0BeAIEO2/Y+Q1ozMMfiQsHuZz9Q57zTQUxZzS
	 Neag8PNXzmPgg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes: Remove redundant guard(rcu) in
 find_active_uprobe_speculative()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178537593930.153254.1296986092000402239.stgit@devnote2>
References: <178537593930.153254.1296986092000402239.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:59:47 +0000
Message-Id: <20260730015947.ECA9A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing `guard(rcu)()` from `find_active_uprobe_speculative()` el=
iminates standard RCU protection, exposing lockless VMA and file accesses t=
o Use-After-Free and page faults.
--

--- Patch [1]: [PATCH] uprobes: Remove redundant guard(rcu) in find_active_=
uprobe_speculative() ---
commit 008639a39e6344f6f057b7d120c62792b7cd6ddf
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

uprobes: Remove redundant guard(rcu) in find_active_uprobe_speculative()

This commit removes the guard(rcu)() from find_active_uprobe_speculative()
and adds a lockdep assertion for RCU Tasks Trace, assuming Tasks Trace RCU
protection provided by the caller is sufficient.

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 07f69dd3093d5..52833db53b25c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2416,6 +2416,7 @@ static int is_trap_at_addr(struct mm_struct *mm, un=
signed long vaddr)
>  	return is_trap_insn(&opcode);
>  }
> =20
> +/* assumes being inside RCU Tasks Trace protected region */
>  static struct uprobe *find_active_uprobe_speculative(unsigned long bp_va=
ddr)
>  {
>  	struct mm_struct *mm =3D current->mm;
> @@ -2425,7 +2426,7 @@ static struct uprobe *find_active_uprobe_speculativ=
e(unsigned long bp_vaddr)
>  	loff_t offset;
>  	unsigned int seq;
> =20
> -	guard(rcu)();
> +	lockdep_assert(rcu_read_lock_trace_held());
> =20
>  	if (!mmap_lock_speculate_try_begin(mm, &seq))
>  		return NULL;

[Severity: High]
Does removing the standard RCU protection here expose the subsequent VMA and
file accesses to use-after-free and page faults?

The VMA and file objects are allocated from SLAB_TYPESAFE_BY_RCU caches,
meaning their underlying slab pages can be returned to the page allocator
after a standard RCU grace period. RCU Tasks Trace does not block standard
RCU grace periods.

The subsequent call to vma_lookup() briefly takes standard RCU to safely wa=
lk
the Maple Tree, but drops it before returning the VMA pointer. If the thread
is preempted after this point, and another thread unmaps the VMA and closes
the file, a standard RCU grace period could complete, freeing the VMA and f=
ile
slab pages.

When the thread wakes up and dereferences vma->vm_file or vm_file->f_inode =
on
a freed page, could it cause a fatal page fault? The code relies on the VMA
and file not being freed from under it, which appears to require standard R=
CU
protection.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178537593930.153254=
.1296986092000402239.stgit@devnote2?part=3D1
