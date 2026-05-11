Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE3383337
	for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538868; cv=none; b=vFbyn9RRMxFIbgH0Fy5a8wZQT87dVeLOsWCARBXaz7BFMkVXE7s5C3AvYWIgbdqE9jcztZDl52gsw/ZsyClVtARL5MhPC5u8ualRYi7AVjq9YecpmbDmLal9clx2oGHl2evuEOXVFPjKJIkg83PUdcq8JrDj68XZxwCUOYH1tbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538868; c=relaxed/simple;
	bh=ZbjnUBp6S/yEzGjt3yXzvTPiMlOt2DpzIRgMPp2zCOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TcYppUyf9KKX4hu5Yn64AI6nMavy42Z3F9IZF1Su3LOYKMTydKAj8Af3thAlXkvZdXSlwZ8rZ0X7sXQguu4TBGmGHi3e53TxfaDfEy3uxmDimLe6Y5zHZDAdiS/ZPwLNEGeubV01N8N41xjCAJD4DkYZDWhA7p1ocwe0gjE+gNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKvm1CGz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKvm1CGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064FC2BCB0;
	Mon, 11 May 2026 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778538868;
	bh=ZbjnUBp6S/yEzGjt3yXzvTPiMlOt2DpzIRgMPp2zCOY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MKvm1CGz+QUZ/AqSCUWIG0oCIMPpfI4jo1m+I3BLLcsvMww3gY3Q+3vqWrq0xfrSG
	 wtuCOffBYF1vizIhrIUkjhIrBC/MVxpu6eJhBu1bbUGJ/m24q+ptfMZaWNtFuXrusG
	 P874wbi5Ppu1eWt5bgq24TylvIMhal4Jom3TKwpVvYaw15U5piiSWdTAKidv3d157j
	 SPgAY9LEBjtINlIXpLgLEe+b5zkWRUdO235OtHCuV2w3cNVo13zFGLmViVHqd/0dgx
	 J1PpOwzCTmUUDpW7fLnLY7a4aDFSvZGHiChKrPgcks0Ho1YZOMgPfpA3Pnu+F75GZU
	 UnYJw3GeDzjuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] uprobes: Use flexible array for xol_area bitmap
Reply-To: sashiko@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260510214118.41926-1-rosenp@gmail.com>
References: <20260510214118.41926-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 22:34:27 +0000
Message-Id: <20260511223428.7064FC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling kfree() on a flexible array member triggers an invalid=
 free, leading to kernel panic or slab corruption.
--

commit 2653ad1e88bfeb53b361b9c646fc5e888019afa9
Author: Rosen Penev <rosenp@gmail.com>

uprobes: Use flexible array for xol_area bitmap

This commit converts the xol_area bitmap from a separately allocated
pointer to a flexible array member. It also updates the allocation to
use kzalloc_flex() and removes the associated error handling in
__create_xol_area().

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 4084e926e2844..9ef74c2ad3907 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -108,7 +108,6 @@ static LIST_HEAD(delayed_uprobe_list);
>   */
>  struct xol_area {
>  	wait_queue_head_t		wq;		/* if all slots are busy */
> -	unsigned long			*bitmap;	/* 0 =3D free slot */
> =20
>  	struct page			*page;
>  	/*
> @@ -117,6 +116,7 @@ struct xol_area {
>  	 * the vma go away, and we must handle that reasonably gracefully.
>  	 */
>  	unsigned long			vaddr;		/* Page(s) of instruction slots */
> +	unsigned long			bitmap[];	/* 0 =3D free slot */
>  };

Does this conversion leave a stale kfree() in uprobe_clear_state()?

Since bitmap is now a flexible array member, area->bitmap evaluates to an
interior address within the xol_area slab object.

Looking at uprobe_clear_state(), the kfree() is still present:

kernel/events/uprobes.c:uprobe_clear_state() {
...
	if (!area)
		return;

	put_page(area->page);
	kfree(area->bitmap);
	kfree(area);
}

Could this lead to slab corruption or a kernel panic when a process with a
registered uprobe is terminated, since we are passing an interior pointer to
kfree()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510214118.4192=
6-1-rosenp@gmail.com?part=3D1
