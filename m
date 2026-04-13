Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387E9392C28
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065158; cv=none; b=VT44dcxucOn4aWN+PsVYQ6QGvurC51tHwNS+c98lUbPRCLHIeEg1DY//J+ujofeV3rouM5lM9uuYKjWP0l9IcgbPO8lOiHlWn8b7GprTZEIxECH48IbhiR36V2WgXd9STtNR69S6/NLm9q0dKQcpWG1Zcjd/9DeAcYDOPOGGbaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065158; c=relaxed/simple;
	bh=rmy4nhDne/7uE+mUw2Hbh/Eu69x8cN+cl5swxXZ9pO0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AGYyT8F50Df9AIWWsWj+YLMKnqJy0+eESy6BsTHJiMCR4XGFPcLvX65jamu4Wsx5Ce/p2ezYW7D0Pm7TbiyPXeSECRHZQfoloMPONltGJ2YL8vt/z8r1pMWMOBKUfiMe3AbrxoZvK60F3SzQ/A4NtMjJ6PynIozkLe1Xw9kwXCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga2AZel4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga2AZel4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BFEC116C6;
	Mon, 13 Apr 2026 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776065157;
	bh=rmy4nhDne/7uE+mUw2Hbh/Eu69x8cN+cl5swxXZ9pO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ga2AZel4MNC/jgO2MBoEGj3M+mJhYfs/CCLe/6BFhUVzcqaw5a/pqz/78LsNFijAU
	 wh+vorswiXCWdXi8Hlqk3nVkDBhFpfwHJjX8r6c5j2b6SL9TjzzX9xiOkuo4rPWrBt
	 /gRtTQ2ogEvb9YH2c38u1Ir0eVpVCRhvXJU8I/60jpsAPNhEhTQuir335UQF+XzqBO
	 mlROFdU6pk478DOaIrTpb6D5mryJ98YWzFs4eF4FrYAg2Zb5WO9BrmhMtkPUxmTsm9
	 ILpfuwfY4ymy0BNpeNRiam/l0xUcHFQGJLpXvtaQwcU7o5Fve6S6mT07imCUL6CnY/
	 Jg0Lp+V1zeaow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] mm: split the file's i_mmap tree for NUMA
Reply-To: sashiko@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413062042.804-4-huangsj@hygon.cn>
References: <20260413062042.804-4-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 07:25:57 +0000
Message-Id: <20260413072557.B2BFEC116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [Critical] Type confusion and kernel panic in `vma_interval_tree_foreach(=
)` macro.
- [High] Memory leak of LSM security blob on `init_mapping_i_mmap()` failur=
e.
- [High] Hardcoded `GFP_KERNEL` ignores caller's allocation constraints, ca=
using deadlocks.
- [High] Massive memory bloat and allocation overhead per inode.
- [High] NULL pointer dereference in `first_vma()` for uninitialized `i_mma=
p`.
- [Medium] Integer truncation in `mapping_mapped()` leading to logic errors.
--

commit 8f800a00de85443e08da55055eb7cfb4938865a5
Author: Huang Shijie <huangsj@hygon.cn>
Subject: mm: split the file's i_mmap tree for NUMA

This commit splits the i_mmap tree into multiple NUMA-node-specific
trees to reduce lock contention during VMA operations. It introduces
a vma_count field and rewrites vma_interval_tree_foreach to iterate
over the new structure.

> diff --git a/fs/inode.c b/fs/inode.c
> index cc12b68e021b2..3067cb2558da0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
[ ... ]
> +#ifdef CONFIG_NUMA
> +static void free_mapping_i_mmap(struct address_space *mapping)
[ ... ]
> +static int init_mapping_i_mmap(struct address_space *mapping)
> +{
> +	struct rb_root_cached *root;
> +	int i;
> +
> +	/* The extra one is used as terminator in vma_interval_tree_foreach() */
> +	mapping->i_mmap =3D kzalloc(sizeof(root) * (nr_node_ids + 1), GFP_KERNE=
L);

Does hardcoding GFP_KERNEL here ignore the caller's allocation constraints?

inode_init_always_gfp() is passed a gfp_t mask because it can be called in
restricted contexts where blocking is not permitted, such as with GFP_NOFS
or GFP_ATOMIC. Could using GFP_KERNEL unconditionally cause filesystem
recursion or deadlocks under memory pressure?

> +	if (!mapping->i_mmap)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_node_ids; i++) {
> +		root =3D kzalloc_node(sizeof(*root), GFP_KERNEL, i);

Will allocating these arrays and root nodes for every single inode cause
significant memory bloat?

Since this applies to all inodes, including those that are never
memory-mapped like directories, pipes, or sockets, does this negate the
performance and scalability benefits of the optimized inode_cachep slab
cache?

[ ... ]
> @@ -307,6 +357,9 @@ int inode_init_always_gfp(struct super_block *sb, str=
uct inode *inode, gfp_t gfp
>  	if (unlikely(security_inode_alloc(inode, gfp)))
>  		return -ENOMEM;
> =20
> +	if (init_mapping_i_mmap(mapping))
> +		return -ENOMEM;
> +

Does returning -ENOMEM here leak the LSM security blob?

If init_mapping_i_mmap() fails, the function returns directly without
calling security_inode_free(inode) to clean up the allocation made just
above it.

[ ... ]
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9fe59b8cc2e4e..9f337a56389d8 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
[ ... ]
> @@ -547,6 +552,27 @@ static inline void i_mmap_assert_write_locked(struct=
 address_space *mapping)
>  	lockdep_assert_held_write(&mapping->i_mmap_rwsem);
>  }
> =20
> +#ifdef CONFIG_NUMA
> +static inline int mapping_mapped(const struct address_space *mapping)
> +{
> +	return	READ_ONCE(mapping->vma_count);
> +}

Can this truncate the unsigned long vma_count?

The vma_count field is defined as an unsigned long, but this function
returns an int. On 64-bit systems, if the count reaches a multiple of 2^32,
could it be implicitly cast to 0 and cause core MM routines to mistakenly
treat the file as unmapped?

[ ... ]
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4c775e5ed50cc..eda527424e225 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
[ ... ]
> @@ -4045,9 +4050,36 @@ struct vm_area_struct *vma_interval_tree_iter_next=
(struct vm_area_struct *node,
>  				unsigned long start, unsigned long last);
> =20
>  /* Please use get_i_mmap_root() to get the @root */
> +#ifdef CONFIG_NUMA
> +/* Find the first valid VMA in the sibling trees */
> +static inline struct vm_area_struct *first_vma(struct rb_root_cached ***=
__r,
> +				unsigned long start, unsigned long last)
> +{
> +	struct vm_area_struct *vma =3D NULL;
> +	struct rb_root_cached **tree =3D *__r;
> +
> +	while (*tree) {

Can this dereference a NULL pointer if mapping->i_mmap is uninitialized?

Address spaces initialized via address_space_init_once() (like
swapper_spaces) will have i_mmap set to NULL. If a caller iterates without
checking mapping_mapped() first, could get_i_mmap_root() return NULL,
assigning NULL to tree and causing a panic here?

> +		vma =3D vma_interval_tree_iter_first(*tree++, start, last);
> +		if (vma)
> +			break;
> +	}
> +
> +	/* Save for the next loop */
> +	*__r =3D tree;
> +	return vma;
> +}
> +
> +/* @_tmp is referenced to avoid unused variable warning. */
> +#define vma_interval_tree_foreach(vma, root, start, last)		\
> +	for (struct rb_root_cached **_r =3D (void *)(root),		\

Is it safe to use a (void *) cast here?

If an unmodified caller (e.g. an external driver) passes &mapping->i_mmap
instead of using get_i_mmap_root(), the cast suppresses type checking. Since
mapping->i_mmap is now a pointer to an array, evaluating it as an
rb_root_cached node pointer could lead to a fatal out-of-bounds dereference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413062042.804-=
1-huangsj@hygon.cn?part=3D3
