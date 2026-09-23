Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6A3F23C5
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790179521; cv=none; b=n1QDLi5yDOi5MT+arzoFC9xbNzo+xKpVs5m1lmKZzdK6um0OYdekrEb6XnD1k5QCxU57vkf25eymsX2c7DEgIbpi0jVyxpVfZAZ9+9OZWkpQ3/PV/CaAVjotEZ3YPslNpks0dhUArGKumvDwD7zU4skvr07B9ElZRRVcLtbB7GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790179521; c=relaxed/simple;
	bh=N/pfNFEYUbGbRRSvptd7d9/TyezAO85Hts6jAwmPWjE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AjqK8LvEDqpoat+tM+DOJauQgWYAEotCK4RutCNMZXOajo8xd6GM0xXGKjugu36yj7Vtv0rPZoFnw+ikZxPQWQyFbLzHfoRZDeJGwJ8Z1feTvqXhH6fJQf/s2RHt0HiNSgSGvgKCREP7gJ0bDdOkvg1FUe/bmmmFT3ZXIK2LKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULlaFplB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULlaFplB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CCD1F000FF;
	Wed, 23 Sep 2026 16:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790179519;
	bh=Fnv/BVkRQ+KcdTesPJNT/tVAsEXW/2en9Q/texYJM7g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ULlaFplBD6OJ/ZsKWuU/wnJhzO15ZbH/j/teCOQNcyvT8JFoeOy8LpfBpcDW6JCJa
	 e337oWu/2gJQEg3saZ+fo8fywkhNEg7zrpJ7o6GOjXiZBwx7d9bYvfuHSBE5R4PnZF
	 DgB8tSN/bdDfZ5tEuzsjkmexTtd6wpuikqBBcAK0b4seRucecqc/RCbQ9Bk7oJFtoi
	 3jMsPTKHX5WQ+2LZCEcM+OAc4NlUbCwnVc7Etyd5OllCfkofug0z2NbXiJj4+DP3zv
	 Z6hOhfBjA2K/OeUnLet0RCzGAaq7+Oa6eDj5+j3eFK9iSO2BJe6RHSZOnAt9jLSG7M
	 dVW0CeOwMkc6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 6/6] perf c2c: print memory region data with stdio
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260923155703.34814-7-thomas.falcon@intel.com>
References: <20260923155703.34814-1-thomas.falcon@intel.com>
 <20260923155703.34814-7-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 16:05:18 +0000
Message-Id: <20260923160519.45CCD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Print memory range data in perf-c2c subcommand. Only available in stdio
> mode currently. If memory ranges are not supported or present, print
> nothing.
>=20
> Example output of perf c2c report --stdio:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                   Memory Ranges
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Range 0: [0x0000000000000000-0x00000000bfffffff] Node 0, local region id =
0, remote region id 255
> Range 1: [0x0000000100000000-0x000000203fffffff] Node 0, local region id =
0, remote region id 255
> Range 2: [0x0000008000000000-0x0000027fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 3: [0x0000028000000000-0x0000047fffffffff] Node -2, local region id=
 1, remote region id 255
> Range 4: [0x0000048000000000-0x000004ffffffffff] Node -2, local region id=
 1, remote region id 255
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923155703.3481=
4-1-thomas.falcon@intel.com?part=3D6

