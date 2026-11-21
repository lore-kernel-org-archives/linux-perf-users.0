Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795232044;
	b=hnCQu3ip2sYG3emdUrDCFUsLuP78Ipywe6PmG7G1hDG5AJaf9TKulXYzk5JTDyOJD+EC
	 8TlnhtUXTEOQBpkneIRdlmJtvmKhkC3izjy/eyw690S7N4zas9h/VE6E6i7c8sgHM2Xfx
	 GndgzLOPngyqF7TqiaVtSRp7bkZ4i2HQo0YVeOe7/ZwMAj3iC0sHRHGV7rhzDBag8qy8P
	 SrYnDzh6tXYZsX9Ksm4WY2Jwb/NAvBB0ow/ns6YvRgtbvO4C2jaJyUS64Xy4Z+y0nE/On
	 Rc9NTMAXSR6gurh9FKFG8kpvoeFuRQfiA7exPEpW4xLfbxFk+SfPP7Q+l9DG6xwFANA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795232044;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZIWvd7a6hJidkfQVMmLGy+4d4JcKz+3yom1HeMpaKVk=;
	b=vftwCz08AkUFeY0DpVL+iqDzumfhuiIiou5+1RXwh/ST6UOg+u65KlOaaQxb+s6eFV/R
	 yNNvPFuFyoMVy7SPj6VOaV7mOaSK0KIv1+MOipa/12ZbB2Dl8gOznNboK6jJ3bZaHo8Dw
	 sLc3f7G+l6aj5ejZp445CMavDYPnqmXX8oxXvXZC+M1v8QPPkcnYmT+ORrzTGKwRcGBlz
	 9bPrWaY5311lLzcOgybt6WHRT8tkwZRe9kY+23SmqfMNs4YN8H/SvGYJHrpMa7cNxEMR8
	 YMM8eDyUBFT75qOiKkddx5xxTWMVn3VwJOLnWcC6sVU37soYya35OBFQs1VEKHeV6NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnWn4Mul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA8606A6A0
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Nov 2026 03:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnWn4Mul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512E21F000C6;
	Sat, 21 Nov 2026 03:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795232044;
	bh=ZIWvd7a6hJidkfQVMmLGy+4d4JcKz+3yom1HeMpaKVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnWn4Muln/lcaKriGQGHHqD6/IibmwKTM8rTyhwIBSINS+e55YAB3UkpbQiLuiv0x
	 qYdVEaKRfmwz4Suh+nVhU7LZwJXFnwCs/LgZuV/g11YU1YF7wytEy2Rj0B/nMRRBUY
	 vzWugXT25uwfd3Mlg9qn/SjAJTycAh9LtFmtCXoJYeheZSWYR6tNh+2SF2dn58zWhu
	 k4BqLj2EstLMrc0i8/xbrXUSYQwZ+RYQ83+0mg3wNo3rjrKfBwuSTYLXSL7u72YrAp
	 5E+3eeX+R/EB5NEx+0s5aoMQra1B2ud4jO7abtiAyGrANQEOVtsBm3sYIqXd2dPpmA
	 MiPUvOdxzsCnA==
Message-ID: <sashiko-outbox-226587@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/16] perf scripts: Add a coverage table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261121032052.1392234-17-acme@kernel.org>
References: <20261121032052.1392234-1-acme@kernel.org>
 <20261121032052.1392234-17-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 03:34:03 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf scripts: unbounded prefix stripping in under_build()
  drops source files
--

commit 4ac2ff16920b880b37f2d7980a454661167aa1a9
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf scripts: Add a coverage table

This commit adds tools/perf/scripts/coverage-table.sh and a coverage-table
make target to render the last coverage run's report.txt as a text table.

> diff --git a/tools/perf/scripts/coverage-table.sh b/tools/perf/scripts/co=
verage-table.sh
> new file mode 100755
> index 0000000000000..8aa538255e9be
> --- /dev/null
> +++ b/tools/perf/scripts/coverage-table.sh
> @@ -0,0 +1,310 @@

[ ... ]

> +# An in-tree build has the sources below BUILD_DIR, so only a separate
> +# build directory can tell generated files apart from the tree's sources.
> +BUILD_AWK_DIR=3D$BUILD_DIR
> +[ "$BUILD_DIR" =3D "$PERF_DIR" ] && BUILD_AWK_DIR=3D
> +
> +# llvm-cov strips the prefix every reported file has in common, so a
> +# tools/perf source can read as perf/util/evsel.c.
> +AWK_PERF=3D'
> +function perf_relpath(p) {
> +	sub(/^.*tools\/perf\//, "", p)
> +	sub(/^perf\//, "", p)
> +	return p
> +}
> +function under_build(p,    b, n) {
> +	if (build =3D=3D "")
> +		return 0
> +	b =3D build
> +	while (1) {
> +		n =3D length(b)
> +		if (substr(p, 1, n + 1) =3D=3D b "/")
> +			return 1
> +		if (index(b, "/") =3D=3D 0)
> +			return 0
> +		sub(/^[^\/]*\//, "", b)
> +		if (b =3D=3D "")
> +			return 0
> +	}
> +}

[Severity: Medium]
Can under_build() match every tools/perf source file in report.txt when
BUILD_DIR shares a parent directory with PERF_DIR and ends with a path
component like perf or tools/perf?

under_build() strips leading path components from build all the way down
to its basename instead of stopping where BUILD_DIR diverges from
PERF_DIR.  For an out-of-tree build such as O=3D/path/to/linux/tools/build/=
perf
(or O=3D/home/user/build/perf for a tree at /home/user/perf), llvm-cov
strips the common prefix so source paths in report.txt begin with perf/,
and b shrinks to perf.  generated() then returns 1 for every source file,
leaving table_rows() empty and causing print_table() to exit with an
error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121032052.1392=
234-1-acme@kernel.org?part=3D16
