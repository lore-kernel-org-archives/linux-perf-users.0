Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE23D9037
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 18:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674056; cv=none; b=iU8VYgYALeiKEO4IGj+VRUJpcMWMmINeC3XaWaShMUOJRERkvV3XTPcdbjf2fDbVxP7+N0Y4n17Q3NkX4ve/Ku572mqxNiiPYqqzQtjw6hDr/l3Nx8KszjFacFwZ72Q9XUNxExoe9OPQUQf450oEPUB7lbrVO1PHAVazoLn68cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674056; c=relaxed/simple;
	bh=IZ7x+vG3/l6geRoWUchY6MmJRNGLX8uF6TOWwb8Bc4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MpzI8qYS8jcovuiciK4Yot6FTj6P0l/ZUNn8jvE/P1tzAvTO1Ca6lCgocMnt400EW2mYo61JOw9w683ZceCn2gF5YarvNQCO/y3wny997x48Gji8hvRuZDyaa/8FfxQX764wipHTLKCUC0LQQyfBpolQIac9DHk4xdNGnYkz/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1Ksoo7x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1Ksoo7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F572C19425;
	Wed,  8 Apr 2026 18:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775674056;
	bh=IZ7x+vG3/l6geRoWUchY6MmJRNGLX8uF6TOWwb8Bc4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=N1Ksoo7x+7oix66tkAhd5L025iVY+gOO3DN0CEzJhJuxn+WQhvWcL/YiX6o0Wif6e
	 5fHtj1EzHrA+QrOoAC/wB7QgmDWHTB/w4fQSR2aRu0QSZFJQhooMrEyrhKKGFR7C40
	 nLXBS+NvHkOHZ3QidAvPrKfobLOvRJbmLt5/5oP+mfjUz5uP8E6euzDbMMt3bBzCco
	 6AUUd2xfZu9RaRuNVR4+Tr6QC/r2U/pwL+Lj/bhq8C6hUPxCGbsMftr/0TYb+YalKs
	 d/+h7MaXxb0wtvOW815s0y0rTfy6urzWB8AlN3KM9tKxKXiH16f0ByhCBTIFHuZ82v
	 69D15o9b/OvWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] perf tools: Use calloc() where applicable
Reply-To: sashiko@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408173203.96700-8-acme@kernel.org>
References: <20260408173203.96700-8-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 18:47:35 +0000
Message-Id: <20260408184736.6F572C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Integer truncation in process_mem_topology() leads to an undersize=
d allocation and a heap buffer overflow when parsing a crafted perf.data fi=
le.
- [High] Integer truncation in mem2node__init() via bitmap_weight() and tes=
t_bit() causes an undersized allocation and heap buffer overflow.
--

commit 06556b26772333b2ba2aa88d01fed0ea985e6ec4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf tools: Use calloc() where applicable

This commit replaces instances of zalloc with calloc across the perf tools
codebase to better handle array allocations. It also adjusts includes for
the standard library and kernel zalloc headers where dependencies changed.

> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
[ ... ]
> @@ -3260,7 +3260,7 @@ static int process_mem_topology(struct feat_fd *ff,
>  	if (do_read_u64(ff, &nr))
>  		return -1;
> =20
> -	nodes =3D zalloc(sizeof(*nodes) * nr);
> +	nodes =3D calloc(nr, sizeof(*nodes));

While not introduced by this patch, nr is read as a u64 from the file.
On 32-bit architectures, passing it to calloc, which takes size_t,
truncates it. For example, if nr is 0x100000002, calloc allocates space for
only 2 elements.

However, the subsequent loop for (i =3D 0; i < nr; i++) uses the full 64-bit
nr value. Could this result in a heap buffer overflow when reading the
entries if parsing a crafted perf.data file?

> diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
> --- a/tools/perf/util/mem2node.c
> +++ b/tools/perf/util/mem2node.c
[ ... ]
> @@ -59,7 +59,7 @@ int mem2node__init(struct mem2node *map, struct perf_en=
v *env)
>  		max +=3D bitmap_weight(n->set, n->size);
>  	}
> =20
> -	entries =3D zalloc(sizeof(*entries) * max);
> +	entries =3D calloc(max, sizeof(*entries));

Similarly, in the preceding loop, n->size is a u64, but bitmap_weight
expects an unsigned int for the number of bits. If n->size exceeds 32 bits,
it is truncated, resulting in max being too small and an undersized
allocation here.

Later, the loop for (bit =3D 0; bit < n->size; bit++) iterates u64 times
and calls test_bit(bit, n->set). Since test_bit expects an int or unsigned
int, bit is also truncated. Will this repeatedly re-test the first 32 bits
and cause out-of-bounds writes into the entries array?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408173203.9670=
0-1-acme@kernel.org?part=3D7
