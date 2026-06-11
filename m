Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3F309F1B
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 06:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159834; cv=none; b=GEy22NqAP/6K1F2FhgpkG+z4RQKnDIoc3RGZF8Ye31GEhqTBSWXy7TDU3gn6x4HFzsdwFawgGOmxkfLmqD31ybmZr61W8CCgdF6g80mJQBbsijHmDVbePJdgWoNy6ZMdeud/9d8FA1dsa5LI+KOSVWupmOp5AJwakzcldrrbOY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159834; c=relaxed/simple;
	bh=2grkGCGMKhD2KLmGqntBKl7Eoljb+CuwbLsvN5goHc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LvvJa0p7iU5YO5JMaRJaifYG2oQQoKUJ14T/9ei5P4Vzj/jzNVXy18sj5dBwVbokxYEZRWvhBFypoKT0+c2wsl8p99id4Jr8VTRtdValRvUppys77U4rWUsDwVK/l1upQiKc/IOIMyO29Aav+9cwZNktNYSfNMHjHwKC0Gtlo7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iwczt1Zy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iwczt1Zy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C791F00893;
	Thu, 11 Jun 2026 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781159832;
	bh=WcRo21JJ/K7xr8dJmfvtfAIxYl+0xEkwlb7EHRmieBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iwczt1ZyD/mUSq7Q0qHuMXS4mO6rQxvgicr7kPGP/P2WlbLOCHkx286W5EFP9QdZf
	 /emNKvLtUIJwe9+XCtg0S0R23JaDrn6fzNzCtW6oKT68Lwifad2+42lJZijjbUc0+Z
	 eqwdHb14W5Y2t96kusCc2tBSdKbToaJ2NnuWk5QOKDRvGBW5bk5VRhT+LEq3m4smlD
	 aamzQB3cvRY0XxhjUWa3VEZeclPbFNcO8pt5M8b0f4GaQD6qprVOwEMTpbDzB6EBNs
	 jHRxEuRRATEoZuhzHZoGuQl38pUIHgb8NXIWUlWom7uGwJEpBdk9WtJQD1yRvqBU03
	 IRkkNZSkZZvOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] mm/fs: split the file's i_mmap tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611061915.2354307-4-huangsj@hygon.cn>
References: <20260611061915.2354307-4-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:37:11 +0000
Message-Id: <20260611063712.51C791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Immediate self-deadlock in `vma_prepare()` when adjacent VMAs =
share the same `tree_idx`.
- [Critical] `vma_complete()` blindly unlocks both `vp->vma` and `vp->adj_n=
ext` trees, risking a double unlock.
- [High] Lock inversion deadlock between `vma_prepare()` and global `i_mmap=
` tree locking functions.
- [High] Massive per-inode memory bloat due to unconditional split tree all=
ocation.
- [High] `address_space_init_once()` no longer initializes `i_mmap` fields.
- [High] Lock ordering inversion between `anon_vma->rwsem` and `mapping->i_=
mmap` sibling tree locks.
- [Medium] Iterating over all `i_mmap` sibling trees triggers lockdep recur=
sive locking splats.
- [Low] Syntax error in `hugetlbfs_lockdep_set_class()` blocks compilation.
--

commit f5f0f658ce23acc54c74ca009d1b5fa489c2d03a
Author: Huang Shijie <huangsj@hygon.cn>
Subject: mm/fs: split the file's i_mmap tree

This commit splits the single i_mmap tree per file into multiple sibling
trees to reduce lock contention during VMA operations. It introduces new
fields and updates lock handling and interval tree iterators across the
memory management subsystem.

> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
[ ... ]
> @@ -891,6 +891,23 @@ static struct inode *hugetlbfs_get_root(struct super=
_block *sb,
>   */
>  static struct lock_class_key hugetlbfs_i_mmap_rwsem_key;
> =20
> +#ifdef CONFIG_SPLIT_I_MMAP
> +static void hugetlbfs_lockdep_set_class(struct address_space *mapping)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < split_tree_num; i++) {
> +		lockdep_set_class(&mapping->i_mmap[i].rwsem,

[Severity: Low]
Does this cause a compilation error? Since mapping->i_mmap is an array of
pointers to struct i_mmap_tree, using the dot operator to access rwsem
will fail. Should this be mapping->i_mmap[i]->rwsem instead?

> +				&hugetlbfs_i_mmap_rwsem_key);
> +	}
> +}

[ ... ]
> diff --git a/fs/inode.c b/fs/inode.c
> --- a/fs/inode.c
> +++ b/fs/inode.c
[ ... ]
> @@ -214,6 +214,70 @@ static int no_open(struct inode *inode, struct file =
*file)
>  	return -ENXIO;
>  }
> =20
> +#ifdef CONFIG_SPLIT_I_MMAP
[ ... ]
> +static int init_mapping_i_mmap(struct address_space *mapping, gfp_t gfp)
> +{
> +	struct i_mmap_tree *tree;
> +	int i;
> +
> +	/* The extra one is used as terminator in vma_interval_tree_foreach() */
> +	mapping->i_mmap =3D kzalloc(sizeof(tree) * (split_tree_num + 1), gfp);
> +	if (!mapping->i_mmap)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < split_tree_num; i++) {
> +		tree =3D kzalloc_node(sizeof(*tree), gfp, i);

[Severity: High]
Could this lead to significant memory bloat? By allocating the array and
multiple trees unconditionally for every instantiated inode, high-core-count
systems might consume massive amounts of memory for millions of cached
inodes, many of which may never use the i_mmap tree.

> +		if (!tree)
> +			goto nomem;
> +
> +		tree->root =3D RB_ROOT_CACHED;
> +		init_rwsem(&tree->rwsem);
> +
> +		mapping->i_mmap[i] =3D tree;
> +	}
> +	return 0;
> +nomem:
[ ... ]
> @@ -480,9 +550,7 @@ EXPORT_SYMBOL(inc_nlink);
>  static void __address_space_init_once(struct address_space *mapping)
>  {
>  	xa_init_flags(&mapping->i_pages, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCOUNT);
> -	init_rwsem(&mapping->i_mmap_rwsem);
>  	spin_lock_init(&mapping->i_private_lock);
> -	mapping->i_mmap =3D RB_ROOT_CACHED;
>  }

[Severity: High]
Will this cause issues for non-inode users of address_space? Since
address_space_init_once() no longer initializes the i_mmap fields,
standalone mappings could trigger null pointer dereferences when their
i_mmap locks are acquired.

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
[ ... ]
> +static inline void i_mmap_lock_write(struct address_space *mapping)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < split_tree_num; i++)
> +		down_write(&mapping->i_mmap[i]->rwsem);
> +}

[Severity: Medium]
Will this trigger lockdep splats for recursive locking? Because all sibling
tree semaphores share the same static lock class, acquiring them
sequentially inside this loop might cause lockdep to detect a false
recursion and exceed its maximum depth limits.

> diff --git a/mm/vma.c b/mm/vma.c
> --- a/mm/vma.c
> +++ b/mm/vma.c
[ ... ]
> @@ -318,12 +321,17 @@ static void vma_prepare(struct vma_prepare *vp)
>  	}
> =20
>  	if (vp->file) {
> +		i_mmap_tree_lock_write(vp->mapping, vp->vma);

[Severity: High]
Does this sequence invert the standard locking hierarchy? This path inside
vma_prepare() now acquires the i_mmap tree lock after acquiring the anon_vma
lock (acquired earlier in the function), whereas previously the full i_mmap
lock was acquired before locking the anon_vma.

>  		flush_dcache_mmap_lock(vp->mapping);
>  		vma_interval_tree_remove(vp->vma,
> -					get_i_mmap_root(vp->mapping));
> -		if (vp->adj_next)
> +					get_rb_root(vp->vma, vp->mapping));
> +		dec_mapping_vma(vp->mapping, vp->vma);
> +		if (vp->adj_next) {
> +			i_mmap_tree_lock_write(vp->mapping, vp->adj_next);

[Severity: Critical]
Is there a risk of an immediate self-deadlock here? If vp->vma and
vp->adj_next share the same tree index, this thread will attempt to acquire
the exact same semaphore twice in a row.

[Severity: High]
Could this also cause a lock inversion against the global tree traversal
functions? The global functions lock all trees in ascending index order,
but this path locks based on adjacent vma tree indexes which could be in
descending order.

>  			vma_interval_tree_remove(vp->adj_next,
> -					get_i_mmap_root(vp->mapping));
> +					get_rb_root(vp->adj_next, vp->mapping));
> +			dec_mapping_vma(vp->mapping, vp->adj_next);
> +		}
>  	}
[ ... ]
> @@ -340,12 +348,17 @@ static void vma_complete(struct vma_prepare *vp, st=
ruct vma_iterator *vmi,
>  			 struct mm_struct *mm)
>  {
>  	if (vp->file) {
> -		if (vp->adj_next)
> +		if (vp->adj_next) {
>  			vma_interval_tree_insert(vp->adj_next,
> -					get_i_mmap_root(vp->mapping));
> +					get_rb_root(vp->adj_next, vp->mapping));
> +			inc_mapping_vma(vp->mapping, vp->adj_next);
> +			i_mmap_tree_unlock_write(vp->mapping, vp->adj_next);
> +		}
>  		vma_interval_tree_insert(vp->vma,
> -					get_i_mmap_root(vp->mapping));
> +					get_rb_root(vp->vma, vp->mapping));
> +		inc_mapping_vma(vp->mapping, vp->vma);
>  		flush_dcache_mmap_unlock(vp->mapping);
> +		i_mmap_tree_unlock_write(vp->mapping, vp->vma);
>  	}

[Severity: Critical]
If vp->vma and vp->adj_next both map to the same sibling tree index, could
this cause a double unlock? This sequence releases the tree for vp->adj_next
and then for vp->vma, which would unlock the same semaphore twice and
corrupt its state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611061915.2354=
307-1-huangsj@hygon.cn?part=3D3
