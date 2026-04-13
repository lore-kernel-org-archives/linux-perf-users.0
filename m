Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65D311C1D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 06:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062671; cv=none; b=WZv3X+z1r61q/LSwXSJe0YrkAbHj4kzMkVdIAUQHH9sQKrUlXuWeoW250p5m58VfPxKJp8m2nvzsNpRavZxC6IvvtU8dAiqq3fubBdj05Cw7v7E+0GYzjpMrr9IKP7xQISGybAoEVpa/i9G+g0NDXgc/XLSGTZlerr4iLAjcdKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062671; c=relaxed/simple;
	bh=I4QmrNTxe84Evb92QdN9LGoIewP72CQvz52dmcvvB6U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ljRkP/rLW6TCyAXnn1NJ6Kq0QTpbQu46Brhyczvy+FCED4NuAZqGAwj2/cczpZikoS9MWanXaPHY6sJRRZOnzbzlfOQzyUZex+n5s6wbuftelMsukwt8QUPNvRfWALsYG+WYkQy3mB3Qlfz5vUbsxivSAf6kXq+BzkI6uKc6zGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcYT5nnX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcYT5nnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12603C116C6;
	Mon, 13 Apr 2026 06:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776062671;
	bh=I4QmrNTxe84Evb92QdN9LGoIewP72CQvz52dmcvvB6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rcYT5nnXcWsBS0rP+tD2xLrVQn2McdzAaYaRVgXE5khPgiyUy7KkNHq8NGPK39/+B
	 OQKEa5MENHPYNoNKjlDXHGaY854RYq1KoPICcp+2sQ8zvBlRdbu1N610IknxYHdkbB
	 gMexG2i0Cvc0zrdWjytPaehT+1wL2T4Vp+KU1JY5MZ86uMH+Z2TS+irDwNemNC4QRK
	 y3yCxUWXwMmF6/tmeQ6Xh6jGZRjt4AirfooShZTTGnbmO7Wa7etD9eOk7n4FfcfHmA
	 FtKtvydwavhpLOxhNj14Qi1CN5ytsJQOIcvQrOk5H54omKQvYAKdBjSiaxv0ViZeoX
	 BexSl3vw7LkLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] mm: use get_i_mmap_root to access the file's i_mmap
Reply-To: sashiko@lists.linux.dev
To: "Huang Shijie" <huangsj@hygon.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413062042.804-3-huangsj@hygon.cn>
References: <20260413062042.804-3-huangsj@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 06:44:30 +0000
Message-Id: <20260413064431.12603C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Compilation error in mm/nommu.c due to incorrect struct inode membe=
r access.
--

commit e38eaf1de7eaee855cd4763bac9c006d3d26fa76
Author: Huang Shijie <huangsj@hygon.cn>

mm: use get_i_mmap_root to access the file's i_mmap

This commit introduces get_i_mmap_root() to access the i_mmap interval tree=
=20
in struct address_space and refactors multiple architectures and subsystems=
=20
to use this new helper.

> diff --git a/mm/nommu.c b/mm/nommu.c
> index ed3934bc2de48..418c8c91689df 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c

[ ... ]

> @@ -1804,6 +1804,7 @@ EXPORT_SYMBOL_GPL(copy_remote_vm_str);
>  int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
>  				size_t newsize)
>  {
> +	struct rb_root_cached *root =3D get_i_mmap_root(&inode->mapping);

Does this cause a compilation error for nommu configurations? It looks like
struct inode uses the member name i_mapping, rather than mapping.

Also, since i_mapping is a pointer to an address_space, taking its address
with the & operator passes a pointer-to-pointer, whereas get_i_mmap_root()
expects a struct address_space *. Could this be updated to use
get_i_mmap_root(inode->i_mapping) instead?

>  	struct vm_area_struct *vma;
>  	struct vm_region *region;
>  	pgoff_t low, high;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413062042.804-=
1-huangsj@hygon.cn?part=3D2
