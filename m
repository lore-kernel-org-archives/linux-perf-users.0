Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604630;
	b=xG0yMo4leqQhRkXmbTtr4xCI6sza8XdbR3BS45U7sV7xr9IKKPSqPPd3+N2TzSqV/1oy
	 0AcPk2VU3B0A5ediQkf0aiS32UeLi50XX/ZBjuiadgjFmF/jrzADN0vZgFgk+22n3jS1s
	 n7/7/pdi3FYKJJpcI3ynMidRNO+Lbpi1A35Pr5dyH/tB17t8URIgguOiQnbxXI/SxsnJq
	 f5nXyJukCBZk/5q8XHCEX4UMO6sZE9oQQk7gQ8I6bgTORrk6TIrzidwHYfdlN7nBxfwgy
	 Da1K31tt9rkkxRDwJmG85fA87NpiQETgyAF50rcpYsrcebYs6eB/Ix3jU5du9egDFxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ft8vCQdxfeluYieMBPKYmyUVEOsN0nSxnpf2nT8N4BQ=;
	b=xjKJw/0Ubiu2WqYml99rukQYn9ORf2Hs/rO4PyteWSUOGvJU2S9qEQE8vSjxMCdDV0lJ
	 TPBZtqvyZr5XzrB9tsW7AOkAlv3+0+GOODexnmHLC2BVu4CGeoyPTySiXF7/KJdKi5xO4
	 up3yv/TWBpiuB+hIGjagKkklf4acIQsr68gjX6dk3NHZLKFVkOWzSLApy0GQf80IzkZ2P
	 QLrHXj4ekUFfHhr1gjTUH+WkKh3MUAqVl2JxBeaMKwbl0XFcyZDcX2QeaIfy8eHBKv6/6
	 ro1k1/wR4m/Omy0scwkxjVMpbDft7ocwY/ClcTgxR0mAawM3MorDV99CMDOQesdRKAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eDrZ/qUp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DC6606A323
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDrZ/qUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE2D1F000C4;
	Fri, 13 Nov 2026 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794604630;
	bh=Ft8vCQdxfeluYieMBPKYmyUVEOsN0nSxnpf2nT8N4BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDrZ/qUpoww8KKpGZR4tghogHfnBjEsKfSSqa+a43IeMI1g0ai7j3fI97UDpb8Db9
	 kJ2yG+arLmITQNajbFyzahdIg6qMrXblhKOu0buJWx7wu0OOoDKIhwtxh4lhIsXx2j
	 4NL0AhdH3Jkddjz7w9ndIEqssHrYb+fd1zANK+xW5T1+PxQdtnsD6vlDJpyPHEGsox
	 6AC7oZFyPLohc3zaUufuzqHV1Zvtocp4ht+AtwCM77xHXNIGzf/OHkRqnG1mtdkmR+
	 v5TZiC+HlZy/e2emXz2dSjx1sThMPI/QGKRYkX8ud9+6RzMnui1zXhUBvLdml8Nvav
	 BRgB9YcbJrxqQ==
Message-ID: <sashiko-outbox-213707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/10] perf build: Enable jevents string compression
 when available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113210822.3112700-9-irogers@google.com>
References: <20261113210822.3112700-1-irogers@google.com>
 <20261113210822.3112700-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 21:17:09 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> Pass --compress=3D<available> to jevents.py during regular builds to
> enable block-indexed string compression (packing generated PMU event and
> metric strings into independently compressed ~8 KiB blocks decompressed
> on demand by (block_id << 16) | sub_offset), constructing the fallback
> list from CONFIG_ZSTD, CONFIG_ZLIB, CONFIG_LZMA, and none so jevents.py
> only emits decompression C code for libraries actually linked into perf
> (e.g. falling back to zlib when built with NO_LIBZSTD=3D1, or uncompressed
> strings when all three are disabled).
>=20
> Expose JEVENTS_COMPRESS=3D<zstd|zlib|lzma|none> (or a comma-separated
> preference list) in Makefile.perf to override or disable compression, and
> track NO_JEVENTS, JEVENTS_ARCH, JEVENTS_MODEL, and the active compression
> selection in $(OUTPUT)pmu-events/jevents-flags so changing build flags
> triggers regeneration without rerunning jevents.py on incremental no-op
> builds. Also cover JEVENTS_COMPRESS=3Dnone in tools/perf/tests/make.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113210822.3112=
700-1-irogers@google.com?part=3D8

