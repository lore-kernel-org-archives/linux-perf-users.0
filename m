Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479213D53C
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883161; cv=none; b=kMuc5IvNOee1glsHlYUnKPP24acMt9QxdhFsWb5zwwM79YCgpOkaSe0aBPxkSZ6KPwhOcTqyG1lfASihAMdFPYStWhMtjCoxKetUVAThsqbrTkuQk3bwOU0M+hJwaJpYINaLdsSI11tYT5WVq7FOtxztFL6s3d4WW0/oXKeqESc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883161; c=relaxed/simple;
	bh=3K2Rl55AWO6vDSoZNYPKzfHXbI7dq7Tm9OPeloi0tkw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n7pLUNBee31HMAZK2f05BGyfBJH3D+3IdoYd929W+ZGpwTkjuZJiTh4UDjGR0Q5FkNqAvu6igDxZs5qyoj+2HajGztmDJwa5IGjLits5LbRUj9KwK8mClbvSXhhHeWxvHoLa027efCrhqRhysvxYn3eEDwRsmQ97wiowxJu2f1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxSE/U7A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxSE/U7A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECA91F00893;
	Mon,  8 Jun 2026 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780883159;
	bh=X8XNNyNWlC8PyFEK1YpGY4aepQyRRR+3E+zilShT4Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VxSE/U7AVkZpkAz+JlTGJYHGqDrBfsA4DvnLDb4RS3u0vNXBh4QYKN15FlhobRuzO
	 BfIz/gi088AytBd1reLsz7YFEWPQxllqXLJpP+fKdZHQTBEHXFn7AsSp8HTYVgCikx
	 ZAFcxXixRQAzqCCe2z/U1EmWyZ51xfy+bm/PB/y+ereL0hKpllQKwNlk1UytB4v7e1
	 BT9f3z64VTXzCPieAvbcFBm5E55YBScMwvAcEDNOqFZaiCqhnAOtl6q1Am7Kbqon1D
	 14eRQt+Ml7nHCQVDW0hRZ92rtTXHDUuVECZF6qR+1gFrpz8I/xpVZ3QDpSWslIk/n7
	 PV20cGLlo0QLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] perf tools: NULL bitmap pointers after
 bitmap_free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260608013057.1942953-6-acme@kernel.org>
References: <20260608013057.1942953-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 01:45:59 +0000
Message-Id: <20260608014559.9ECA91F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Setting `nodesp[i].set =3D NULL` in `memory_node__delete_nodes` is =
a dead store and fails to prevent double-frees because the parent `nodesp` =
array is immediately freed.
--

commit 96984a1b2dbcef0f5989e5cb40505523a7726dd3
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: NULL bitmap pointers after bitmap_free()

This commit modifies three call sites to set bitmap pointers to NULL after
they are freed using bitmap_free(). The purpose is to avoid double-free
scenarios if the structure is later reused or cleaned up multiple times.

[ ... ]

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index d7f41db7322cb..8d2ab440a1c8e 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1481,8 +1481,10 @@ static int memory_node__read(struct memory_node *n=
, unsigned long idx)
> =20
>  static void memory_node__delete_nodes(struct memory_node *nodesp, u64 cn=
t)
>  {
> -	for (u64 i =3D 0; i < cnt; i++)
> +	for (u64 i =3D 0; i < cnt; i++) {
>  		bitmap_free(nodesp[i].set);
> +		nodesp[i].set =3D NULL;

[Severity: Low]
Since the entire nodesp array is freed immediately after this loop, does
nullifying this pointer provide any protection against double-frees?

If a cleanup function were called twice on this structure, wouldn't it resu=
lt
in a use-after-free on the nodesp array itself before the set pointer could
even be evaluated?

> +	}
> =20
>  	free(nodesp);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608013057.1942=
953-1-acme@kernel.org?part=3D5
