Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB22F5313
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jun 2026 06:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781159520; cv=none; b=P+gdPBWvKv3KCUG1mTyqAvnpfPpMurxMBf4gv7WiFnfcNyPL8bRbTKnCv1yGsWesh2QItcUY24SqJu4Gk95mQg3JrCqKi6baER19pMn6V6c/qHKggkxn4Beb0DHET6j+NzPvlg0MEi8Ezk7o3AqvdGA5my3egEXXJoCx+P+hRhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781159520; c=relaxed/simple;
	bh=fJq4xvF9Tmmtt/hH2ZpCpr/6TyFmYeM35F/T7OO7E/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aBCgfeHGeLMpJt0uW7em11wM8IWy94OaQgTpgDuAIxH2YI2pVXS1QWhwnlK7xy+k7Df+vsCrBLJCf7RJu+CTjSgkP6VIZ2LCzCuIlPTdr9LExtzTh8Uxz0yw3MvPmRr3RpFP6lsmYLioNDO7u2/F/AvNutiHuGRmhyOEFT7fPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSPMgkgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSPMgkgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DCC1F00893;
	Thu, 11 Jun 2026 06:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781159518;
	bh=EYtd6jUQkII4iAiyI36qOaojQWm9NPMqzV0atwJcJUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSPMgkgyRYIqrj1YSfN4WKdnRkcAR4wGWhKLuh0IkJK4mflSzXLdQUpR0025ZTyh/
	 E4weOiGmvoIdzVPoLgmrv5cpygt908vywLQQ2S0FvSmlVEcNoFJkBUTaLvbr8Szq3k
	 OM5CteK3SWOgrudUvUn8WiW1n4PAs90KjVxkfdb8Kw0cK0UEus4PRJ8vhxjxRL5SQe
	 FHZuGsGrpe2JEaQghF2nXWst8h5E0hfxbF7KPPKrJXYGz3++Jl1InQPE4fJ7awxWZD
	 XuaXlLf0m9s9O182iZx8aR0axzDVknTWqlqF+51pqlHdHntYLP4MbUwWQyMlDnkMQE
	 eyI5bZAGtAXHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] mm: use get_i_mmap_root to access the file's
 i_mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260611061915.2354307-3-huangsj@hygon.cn>
References: <20260611061915.2354307-3-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:31:58 +0000
Message-Id: <20260611063158.94DCC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] In `nommu_shrink_inode_mappings`, `get_i_mmap_root()` is incorrect=
ly called with `&inode->i_mapping` instead of `inode->i_mapping`, causing a=
n invalid pointer calculation and subsequent memory corruption.
--

commit af3e57c8cfc7072a4088af8cf0bf41f373c9261b
Author: Huang Shijie <huangsj@hygon.cn>

mm: use get_i_mmap_root to access the file's i_mmap

This patch introduces the get_i_mmap_root() helper to encapsulate direct=20
accesses to the i_mmap interval tree root within struct address_space. It=20
updates various architectures and core memory management subsystems to use=
=20
the new helper.

> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed3934bc2de48..0f18ffc658e95 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
[ ... ]
> @@ -1804,6 +1804,7 @@ EXPORT_SYMBOL_GPL(copy_remote_vm_str);
>  int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
>  				size_t newsize)
>  {
> +	struct rb_root_cached *root =3D get_i_mmap_root(&inode->i_mapping);

[Severity: High]
Does this code pass a double pointer to get_i_mmap_root()?=20

Since inode->i_mapping is already a pointer to struct address_space, passin=
g=20
&inode->i_mapping provides a struct address_space ** instead of the expecte=
d=20
struct address_space *.=20

This will cause get_i_mmap_root() to calculate an invalid address by adding=
=20
the structure offset to the address of the i_mapping pointer itself. The=20
subsequent call to vma_interval_tree_foreach() will interpret garbage memor=
y=20
as an rb_root_cached structure, leading to a panic when it attempts to=20
dereference the fake rb_node pointers. Should this be called with=20
inode->i_mapping instead?

>  	struct vm_area_struct *vma;
>  	struct vm_region *region;
>  	pgoff_t low, high;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611061915.2354=
307-1-huangsj@hygon.cn?part=3D2
