Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797E4ABBD2;
	Thu, 17 Sep 2026 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789687525; cv=none; b=jkQfklRgvKPzH7G5/PUzaTB2rSabfl7DkXjog6AdABAwv3uGfheL/9QeKc0x5pmQJbTwC2Vl5+cbJS3jiDYw6x/NpkPuBV9Y3wFPuBEnwvmKPDbtl8MqLpGUUwzUBRydxsqld83XBdNPvwjFMtm9tlp8tVXRYH3hacmJHWqJDjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789687525; c=relaxed/simple;
	bh=Qw8GjSiWpvL6pXqV3MkRrxhIyhCjMT5W521zlsQDB3s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmLBqxPq7GBbnBwy+Gpc9R/bHGjc6JbgN8HRmcz/GX3zNctnrRvVUVUoixfGGxSCh2hZVUBeBwBvyo43t+B4LXLQJh9Y0ul5GOCPkQXQKMleXh7b4vCfPYIxAUTAsoLmGrsehPDok2E82qz4839t52V6UIfshGPtP22QPd4hS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXCs5sn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXCs5sn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341AD1F000FF;
	Thu, 17 Sep 2026 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789687520;
	bh=z9hx31HdQrM/nifpYzlM7glgHYAFxR0+1ZDEDYayjmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXCs5sn7oofKxbvA5A+wYcWehzpSdLsj0PRHTtWPpb9IBaC5F6KeIDbwQi5n7B2Z2
	 1PC3eE5cmWJOIRqQKuBt6vh47eing8LNMFLJoYTkcQUjYQVv/LRx8aUnUaW7S6jZgV
	 Jaj6JNpNWdZlixJPw8cca8og4FBR7dAYuN/BjkrcSdrol4Q28zqRTZy5j/8rSzzNBj
	 D3jm/6HDe+XIBpVdrjjgkLBr67slVUm+oXxIQGDRQJQ9RQQWTkmLoCP7kqxykzADxi
	 ooFTWxxtGwANVjhIoe7K1jtmQjVietbkyzBvvSE+0I7tyM9zX4UW/VjasH3SQ2EJ80
	 o1TI2hhTjIh0g==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 02/11] ptwrite uprobes: Add minimal low level
 support for x86
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260917230127.924985-3-ak@kernel.org>
References: <20260917230127.924985-1-ak@kernel.org>
 <20260917230127.924985-3-ak@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 23:25:19 +0000
Message-Id: <20260917232520.341AD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] x86/uprobes: Uninitialized variable first_phase_done causes invali=
d fallback
- [High] x86/uprobes: Missing __GFP_ACCOUNT bypasses memcg and GFP_KERNEL d=
eadlocks
- [Medium] x86/uprobes: GFP_HIGHUSER allocation pins unmigratable pages in =
movable zones
--

commit 692de39e6024ec893235089efa2253699ad076bf
Author: Andi Kleen <ak@kernel.org>

ptwrite uprobes: Add minimal low level support for x86

Add more data structures and the x86 machinery to generate the PTWRITE
instructions for a ptwrite uprobe. The probe executes PTWRITEs and then
jumps back to the original code. In this variant only patching
5 byte nops is supported.

> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 65a2de82ecd29..7fcdc4bf5197a 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
[ ... ]
> @@ -719,6 +723,134 @@ static struct vm_area_struct *get_uprobe_trampoline=
(struct mm_struct *mm, unsign
[ ... ]
> +int uprobe_ptwrite_dup_mmap(struct mm_struct *oldmm, struct mm_struct *n=
ewmm)
> +{
> +	struct uprobes_state *old_state =3D &oldmm->uprobes_state;
> +	struct uprobes_state *new_state =3D &newmm->uprobes_state;
> +	struct uprobe_ptwrite_page *ptw, *new;
> +	struct vm_area_struct *vma;
> +	struct hlist_node *n;
> +
> +	mmap_assert_write_locked(oldmm);
> +	mmap_assert_write_locked(newmm);
> +	hlist_for_each_entry(ptw, &old_state->head_ptwrite, node) {
> +		void *src, *dst;
> +
> +		/*
> +		 * Not using __GFP_ACCOUNT here because it triggered
> +		 * a deadlock.
> +		 */
> +		new =3D kzalloc_obj(*new, GFP_KERNEL);
> +		if (!new)
> +			goto fail;
> +		new->page =3D alloc_page(GFP_KERNEL | __GFP_ZERO);

[Severity: High]
Does stripping __GFP_ACCOUNT here allow containers to bypass memory cgroup
limits? By repeatedly forking processes with active ptwrite uprobes, a local
user could potentially consume unbounded kernel memory without being charge=
d.

Also, since this is called under the mmap_write_lock of both the old and new
mm_structs, is it safe to use GFP_KERNEL allocations? GFP_KERNEL can enter
direct reclaim, which might attempt to reacquire the same or other locks via
page writeback or swap-out, leading to deadlocks.

[ ... ]
> @@ -1102,6 +1287,475 @@ static int copy_from_vaddr(struct mm_struct *mm, =
unsigned long vaddr, void *dst,
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
> +	ptw =3D kzalloc_obj(*ptw, GFP_KERNEL);
> +	if (!ptw)
> +		return NULL;
> +
> +	ptw->page =3D alloc_page(GFP_HIGHUSER | __GFP_ZERO);

[Severity: Medium]
Will this allocation pin an unmigratable page in a movable zone?

The GFP_HIGHUSER mask includes the __GFP_MOVABLE flag, but the returned page
is a raw page mapped via _install_special_mapping(). Since it lacks movable=
_ops
or LRU linkage, it is fundamentally unmigratable. This breaks the page
allocator's mobility contract and can cause permanent memory fragmentation.

[ ... ]
> +static int ptwrite_text_poke(struct arch_uprobe *auprobe,
> +			     struct vm_area_struct *vma, unsigned long vaddr,
> +			     unsigned long stub_addr)
> +{
> +	u8 jmp5[5] =3D { 0xe9, 0, 0, 0, 0 };
> +	bool first_phase_done;
> +	s32 rel;
> +	int err;
> +
> +	if (!ptwrite_rel32(vaddr + 5, stub_addr, &rel))
> +		return -ERANGE;
> +	memcpy(jmp5 + 1, &rel, 4);
> +
> +	err =3D text_poke_5byte(auprobe, vma, vaddr, jmp5,
> +			      auprobe->ptwrite.orig[0], false, true, true,
> +			      false, &first_phase_done);
> +	if (err && first_phase_done) {

[Severity: High]
Can this evaluate uninitialized memory on the error path?

If text_poke_5byte() fails during its first uprobe_write() call (when setti=
ng
the INT3 breakpoint), it returns the error immediately without initializing=
 the
first_phase_done out-parameter:

arch/x86/kernel/uprobes.c:text_poke_5byte() {
    ...
	if (!skip_int3) {
		err =3D uprobe_write(auprobe, vma, vaddr, &int3, 1, verify_insn,
				   is_register, false, &ctx);
		if (err)
			return err;
	}
	if (first_phase_done)
		*first_phase_done =3D true;
    ...
}

If the uninitialized first_phase_done variable happens to be non-zero (true=
),
ptwrite_text_poke() will attempt a rollback by calling text_poke_5byte() ag=
ain
to remove an INT3 breakpoint that was never successfully installed, which c=
ould
further fail or corrupt the instruction stream.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917230127.9249=
85-2-ak@kernel.org?part=3D2
