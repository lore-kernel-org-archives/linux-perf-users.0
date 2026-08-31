Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DE2EEE6C
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203500; cv=none; b=kapgtvnHDdKo9EL1fu0jooifQmGa6WZ8IlkFAhJGI3Rb2tmmO3zPFnu9tBA0J7uLpbK+eFC74Re3Xb4YY0wyKdqBC66RqBX38vuLjUJ8HXnzPFsC5a/WLrmuwty8rIW5Xrba5lWjGEcYubaS5d9Wj3SJQWsN/AP4JCeC3nQIij8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203500; c=relaxed/simple;
	bh=VgVYKjbBWdrwKyW2lfOrHpiBymFayk2FWAxwk5kCGF4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B+iHv8NVKvHZB3gPcpxreTZW6iH21VKlsRnqXoBUDjQeg1Y3Abcdy5ONUQMnZAenC4CDP1/aSKzEH/CFAWhgdN4wB97mW6ODSFGf4/VQB9a5pkTZu0GzhBoSthQDu7BJaGgUnyLXJeiqXNspy3CBt64HqThySdNai5NfGvqXiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkAmYNvn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkAmYNvn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A421F000E9;
	Mon, 31 Aug 2026 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203499;
	bh=mf9PwlnmsAk70zbCWtkYULCZ0MM97moycAKDYGZ8d8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OkAmYNvn45GVG72Zqa5PyHATraZ6ZyhvuSTLcbEBCrwpGmAAySgCoiyblq9Z+VKif
	 Qimqa8GRTQP5ITCH75jyofsvkunbYLh2UMLV6zA0muDJPz3qItDb2mLjNWRIPSixtX
	 qw+c93crTUIKXq0J4Eg9DPAqmtHBOAKond7ZqEwJ7vlxnamTFeQBMxmY66tKZICUz0
	 4E7Ci8uXuinr8m6LQI8tGMeK/yVYK4VEYt4xLRlFosNFzZN+BESFvkAYA0iR0tOZJO
	 gl1KxrP9pCqJCFHFYyL5R5J/p88FK/2XWVdUJosWKmMYt/f/yPxgmnRRDySu+lNq1c
	 Ncdnwr4+QFE9A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC v1 05/19] ptwrite uprobes: Add minimal low level support
 for x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260831150651.1134594-6-ak@kernel.org>
References: <20260831150651.1134594-1-ak@kernel.org>
 <20260831150651.1134594-6-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:11:38 +0000
Message-Id: <20260831191139.09A421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Calling synchronize_rcu() inside a loop in arch_uprobe_clear_state=
() causes O(N) grace period delays while holding mmap_write_lock.
- [High] find_ptwrite_page_area bypasses mmap_min_addr security protections.
- [High] Child processes execute the parent's ptwrite page due to missing V=
M_WIPEONFORK/VM_DONTCOPY on the special mapping.
--

commit eb94d55c50bf768d31e8cac28283dd4258bc8a40
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add minimal low level support for x86

This commit adds low-level x86 support for generating and executing
PTWRITE instructions for uprobes. It pre-generates instructions into
templates and patches them when setting up the user page.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd29..df652c56414b5 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
[ ... ]
> @@ -717,6 +721,68 @@ static struct vm_area_struct *get_uprobe_trampoline(=
struct mm_struct *mm, unsign
[ ... ]
> +void arch_uprobe_clear_state(struct mm_struct *mm)
> +{
> +	struct uprobes_state *state =3D &mm->uprobes_state;
> +	struct uprobe_ptwrite_page *ptw;
> +	struct hlist_node *n;
> +
> +	hlist_for_each_entry_safe(ptw, n, &state->head_ptwrite, node) {
> +		hlist_del_rcu(&ptw->node);
> +		synchronize_rcu();

[Severity: High]
Does calling synchronize_rcu() inside this loop cause an O(N) grace period
delay while holding the mmap_write_lock?

As shown in arch_uprobe_dup_ptwrite() below, arch_uprobe_clear_state() is
called on the failure path while both the parent and child's mmap_write_lock
are held by dup_mmap(). An attacker could potentially fork and intentionally
cause memory allocation failures to stall the parent's mmap_write_lock for
several RCU grace periods, leading to a Denial of Service.

> +		__free_page(ptw->page);
> +		kfree(ptw);
> +	}
> +}
> +
> +int arch_uprobe_dup_ptwrite(struct mm_struct *oldmm, struct mm_struct *n=
ewmm)
> +{
> +	struct uprobes_state *old_state =3D &oldmm->uprobes_state;
> +	struct uprobes_state *new_state =3D &newmm->uprobes_state;
> +	struct uprobe_ptwrite_page *ptw, *new;
> +
> +	mmap_assert_write_locked(oldmm);
> +	mmap_assert_write_locked(newmm);
[ ... ]
> +fail:
> +	arch_uprobe_clear_state(newmm);
> +	return -ENOMEM;
> +}
[ ... ]
> @@ -1102,6 +1223,508 @@ static int copy_from_vaddr(struct mm_struct *mm, =
unsigned long vaddr, void *dst,
[ ... ]
> +static unsigned long find_ptwrite_page_area(struct mm_struct *mm,
> +					    unsigned long vaddr)
> +{
> +	VMA_ITERATOR(vmi, mm, 0);
> +	struct vm_area_struct *vma;
> +	unsigned long low, high, prev, call_end;
> +	const unsigned long call_range =3D (unsigned long)INT_MAX + 1;
> +
> +	mmap_assert_write_locked(mm);
> +	if (check_add_overflow(vaddr, 5UL, &call_end))
> +		return -ENOMEM;
> +	if (call_end < call_range)
> +		low =3D PAGE_SIZE;
> +	else
> +		low =3D call_end - call_range;
> +	if (low < PAGE_SIZE)
> +		low =3D PAGE_SIZE;

[Severity: High]
Does hardcoding the lower bound to PAGE_SIZE bypass mmap_min_addr security
protections?

If a traced user-space process installs a probe near the bottom of its
address space, find_ptwrite_page_area() will search starting at PAGE_SIZE
(0x1000). If a gap is found, _install_special_mapping() could map the
executable ptwrite VMA near NULL, which undermines the sysctl protection
against kernel NULL-pointer dereference exploits.

> +	if (low > ULONG_MAX - (PAGE_SIZE - 1))
> +		return -ENOMEM;
> +	low =3D PAGE_ALIGN(low);
[ ... ]
> +static struct uprobe_ptwrite_page *
> +create_uprobe_ptwrite_page(struct mm_struct *mm, unsigned long vaddr)
> +{
> +	struct uprobe_ptwrite_page *ptw;
> +	struct vm_area_struct *vma;
> +	unsigned long area;
> +
> +	area =3D find_ptwrite_page_area(mm, vaddr);
> +	if (IS_ERR_VALUE(area))
> +		return NULL;
> +
> +	mmap_assert_write_locked(mm);
> +
> +	ptw =3D kzalloc_obj(*ptw);
> +	if (!ptw)
> +		return NULL;
> +
> +	ptw->page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> +	if (!ptw->page) {
> +		kfree(ptw);
> +		return NULL;
> +	}
> +	ptw->vaddr =3D area;
> +
> +	vma =3D _install_special_mapping(mm, area, PAGE_SIZE,
> +			VM_READ|VM_EXEC|VM_MAYEXEC|VM_MAYREAD|VM_IO,
> +			&ptwrite_mapping);

[Severity: High]
Can child processes incorrectly execute the parent's ptwrite page because
VM_WIPEONFORK or VM_DONTCOPY are missing here?

When a traced process forks, the child's VMA will receive PTEs pointing to
the parent's physical ptwrite page. Later, arch_uprobe_dup_ptwrite()
allocates a new page for the child's metadata, but the VMA still executes
the parent's page. This can cause the child to execute invalid instructions
or zeroes.

> +	if (IS_ERR(vma)) {
> +		__free_page(ptw->page);
> +		kfree(ptw);
> +		return NULL;
> +	}
> +	return ptw;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831150651.1134=
594-1-ak@kernel.org?part=3D5
