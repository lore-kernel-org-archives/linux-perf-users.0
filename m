Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604403;
	b=efenNamm/xXWNvY6BrPjYIAQNUjunGChFOPXQfshhodTFzZOCnd+dIixbqioC6mO9G46
	 A4i8KIsvYvOVRnQHveYUoUvhfbCu/5RQMNiIpGWR3L840xMnSjyVN1KzI5ZLnDE9YTWpV
	 yXDl/4kNteOhCJds7HHwQk60Q4qOrUp9TvTZ1xDQrobBkTvjbBq6Aclp476gw6bTnA+1n
	 5C1mPKSgbtiitNDsFzC5WCkJfjCLxqdM4R+K84uzODv3w//f30ruhTl8kA47K14bUQomi
	 LxDcWPQIhFRnP+V0Jh50m9/w8Q+NXBoPb5qBRt/eAWAiI/SEDkT72frFnOdgTHng7pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ak0WTYrKHkNi7vac78FHPWfRNMZcT80LYBQZzf2gU9Y=;
	b=yM8t7oPhDkqzmpt+tKAdrgyXNU3AWm6xVadJytxz+0CSsJ4cZjngHn+prGKEisy8R7Pm
	 QI5g5OL53U3vExy8Wow4eGGM6AoG87DIVQJUecPrhk9+iMVSNqqZJTcqbxSKIadd4um37
	 Q1hXD+YmRvaKSbX6P1EjIZ+myc4wA4m/+dYH8nTU2zsQz7eUabfPIEN92rn0r9yKzIZD5
	 jUgoqeeWPY+0ANfsI4CvEfYnvvHdPxESjCTZfT14glnGPmBb1LyrFeTCvar3SQatL2e7X
	 otG/p4JRNTWitGRzGxsQa/9ETvRiBm0zqz6IF3HV+MaN9StWYO5xCaDk3rRjV2KHZPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnSND6nZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A4C606A33A
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnSND6nZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6EC1F000C5;
	Fri, 13 Nov 2026 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604402;
	bh=ak0WTYrKHkNi7vac78FHPWfRNMZcT80LYBQZzf2gU9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XnSND6nZh2VWnxo8V6GuNecWER0nyabdGV7eaPbqzvYRFkzyqlTiVZBZah2j/rzpM
	 wz9/YnUHkJxLMhP00lseTqiuFfw+r5q/xWdJgdN6RJk7p1igX1EbuBlwD/fDZgqzoC
	 UCVq4E6jz9pAPdooHpCYc6+ZRNf326zohECIRdmaUHG+pEBjFFI2aDxeQbGJCRS7ao
	 qKiV6IHdQLxqblwXifJDWwOKPq9pR2IbT3NMbysFckv3dPM2gtn+WLh8O+AuhSgdDm
	 LXi+jEA+8XF+0XG+tc+84HCd+z7Q/GJh9pI+DaaHCiA09YQcPuQ4JAqJAbHx6dbjDP
	 4aNmvmocEJ3ZQ==
Message-ID: <sashiko-outbox-213697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/10] perf jevents: Add --compress=zstd block
 compression backend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-8-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:13:22 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Add a 'zstd' block-indexed string compression backend to jevents.py that
> trains a single shared 64 KiB Zstandard dictionary across all ~8 KiB
> string blocks (itself stored zstd-compressed in .rodata and digested
> once on demand into a shared ZSTD_DDict freed at exit) and compresses
> each ~8 KiB block independently with ZSTD_compress_usingCDict().
>=20
> Without a dictionary, each ~8 KiB block starts with an empty match
> window and must emit its own Huffman/FSE entropy tables from scratch.
> Sharing a trained 64 KiB dictionary pre-seeds both common event/metric
> substrings and precomputed entropy tables across all blocks, shrinking
> compressed .rodata by ~26% compared to dictionary-free ~8 KiB zstd
> blocks (738 KiB vs 1,003 KiB across all architectures, recovering over
> half the gap toward a single non-seekable 521 KiB whole-table stream)
> while keeping every block independently decompressible via
> (block_id << 16) | sub_offset.
>=20
> To avoid mandatory third-party Python package dependencies across Python
> versions, lazily probe three Zstandard bindings in order:
>   1. Python 3.14+ standard-library compression.zstd
>   2. python-zstandard (zstandard) if installed
>   3. ctypes binding to the system libzstd shared library
>=20
> When total string data is too small to train a dictionary, gracefully
> fall back to dictionary-free Zstandard frames. On x86, --compress=3Dzstd
> shrinks pmu-events-string.o from ~6.90 MB to ~587 KB (~11.8x reduction).
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D7

