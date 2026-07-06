Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5D3B19D0
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382221; cv=none; b=lIZBbWpfEMOaJek51gqCth8DXtYsJo8ouQsM7nLvskB+cme/3/VXtBtt7jvU9D5550ETa6+mmZ0tSZSvhRJLhToCAid1sNMxiTtZ2ls20a23/t8k0/kKtS7vNJ1nPO/QdLa6IsqzFdfhIpX4llcRzM2Tsa23Mb8CimQV3sotit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382221; c=relaxed/simple;
	bh=VDdsrnbxJ9QqIz358NP5YGE9BLyGpteiLkhyt0iz7K0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCH6DE5D7gtxGSIgKBWy1/ca6YOw9oRLfDGBY3KydCFfG7UgLYKVOyQ4zCWIlfEWe44kThqirPA+fd1+N9ZjcuyVDIKbccCHomwygUIiX47AUqQbUTi1cQ+Aa24fo0rJII0dlTzvXAX++dcgk+MJyEgo7r1MA4u4fJeb2G4FlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEUdhWZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEUdhWZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B941F000E9;
	Mon,  6 Jul 2026 23:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783382220;
	bh=8llISZPmnBVGc18M2ls3cVxLmlT3N9mBJIyIvncwwNA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nEUdhWZpWou1uMbE9OHqnj9WhcdCpTVwxG5N6Tu0J/Xe8BP2HQJnPASwIwWqhW3QB
	 IJ4NQ8QCz7v+IGmb+r2wh8f58PLaO41wyldpuBXCpMTWRNANDJrv4U4C+Bq+zmvyCn
	 D5ULqQaLKVKUVNvKN6rbrYJbwhCRrWZj7X/lICv0my9G630kpwt34hptT835zwXBkW
	 VtbhPuEyNzLLDZFSsIXnagnc35dqYixlBJkQGbqjUgi1slkZaDhZ0H+sTAIRoHhBYn
	 V2BVGz4YAe0cFy3fMqZOBfffzfL0hc8GpjpMQOcw+szMHfj5y6R959NiHQhC0diG94
	 j7I8w9EYRpT0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf build: Fix compiler errors with old capstone
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260706234836.815254-1-namhyung@kernel.org>
References: <20260706234836.815254-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 23:56:59 +0000
Message-Id: <20260706235700.53B941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked `struct map *` reference in `print_capstone_detail` due to =
missing `map__put()`.
--

--- Patch [1]: [PATCH v2] perf build: Fix compiler errors with old capstone=
 ---
commit 290412dd8be8c32690d86ead2197a90f8b8eb074
Author: Namhyung Kim <namhyung@kernel.org>

perf build: Fix compiler errors with old capstone

This commit fixes build failures on older capstone versions (prior to v5) by
defining missing RISC-V architectural and mode constants.

> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
> index 5ad537fea4360..0247142a77ba3 100644
> --- a/tools/perf/util/capstone.c
> +++ b/tools/perf/util/capstone.c
> @@ -24,6 +24,13 @@
>  #include "symbol.h"
>  #include "thread.h"
> =20
> +#if CS_VERSION_MAJOR < 5
> +#define CS_ARCH_RISCV    15
> +#define CS_MODE_RISCV32  1
> +#define CS_MODE_RISCV64  2
> +#define CS_MODE_RISCVC   4
> +#endif

[ ... ]

Later in tools/perf/util/capstone.c:print_capstone_detail():

> 		if (dso__kernel(map__dso(map))) {
> 			/*
> 			 * The kernel maps can be split into sections, let's
> 			 * find the map first and the search the symbol.
> 			 */
> 			map =3D maps__find(map__kmaps(map), addr);

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the map
reference?

When disassembling instructions with X86 memory operands using RIP-relative
addressing, maps__find() returns a new reference to the kernel section map.
Since this new reference is assigned to the local map variable, is there a
missing map__put() before the function returns or the loop continues? This
might lead to a resource leak and reference count imbalance.

> 			if (map =3D=3D NULL)
> 				continue;
> 		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706234836.8152=
54-1-namhyung@kernel.org?part=3D1
