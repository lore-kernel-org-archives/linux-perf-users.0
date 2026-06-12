Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE725A2BB
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jun 2026 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781240256; cv=none; b=ME8Wv1Q7fwC1YTgTz5zARu/pz4Nf7NfB9azv8krZdo5tKCxhuqWKT+Yvi/jwLashkNLGxd3UwPStcNGVm2GXwuk7A5W5+PwrBpj67+/XVNXOT6x3QAG5DG4eiX8Bn7him30d1surYqWq7++oiACWB5EoI92g+pOpUJzZA2OUVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781240256; c=relaxed/simple;
	bh=0Qgc+SSsyLDAH/YxxBHReWauTPvXgf2E/5CDt8XlWcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XdAB7d+hFX/e6Lg3XUOBYjmqfDT+ZE00RkPiB1pmTqVJOHiU0hJNnhVRq5D4GNvxgVaQSdzkQaTo9+2qjvNMHbDaV0qeKr6dYEB2DNnalgcu9mSmeYgMojcM/wwOT36ZjFu0DM26WWcUZxgtSmMq8v+8NIOrQl80ZOpPKoxmYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQBBOMzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQBBOMzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAAF1F000E9;
	Fri, 12 Jun 2026 04:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781240254;
	bh=0WCRyxq0Lik1U9j4VRgtxJ1amKWsRGuoTDwb1r/+Wtw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQBBOMzvcNMfCk7i9FotE4XLaUjxd7FkVeMfJ1X54kcITgcu+UaOKb8R+YcpEllzm
	 ZjcF0Taz5C2EOJhqfbP/N/pBwxo3YDu9yGW2QWzuvwtwcuRFSHEG54UbZIL+BJ/YMQ
	 wQpzUYjoxZHMZaCoa5pv7zaWH8s42pAQhf8JZa1xrRei/MlChzTIHnkTUxpaD2eseo
	 4qLLnDVK5qEV5C3+tBlAKrCGIlv7HlgmQz46rhfn/orY83zkY4aAU3LJvv8F3Dkbh8
	 JksqIKjZ8RYJOrTCg5TXYcD+PlMBfxmKPYh0bl7PbZrFxNA3426v5QauUHOPcNd5iU
	 40MOcZ9lflCCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] perf symbols: Add O_NONBLOCK to DSO open() calls
 for untrusted paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260612003444.50723-15-acme@kernel.org>
References: <20260612003444.50723-15-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 04:57:34 +0000
Message-Id: <20260612045734.9AAAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fails to comprehensively mitigate indefinite hangs cause=
d by crafted perf.data DSO paths pointing to FIFOs because it misses numero=
us fallback, compression, and auxiliary code paths.
- [Low] Type punning via pointer casting violates the strict aliasing rule =
for tools code.
--

commit 8ad114a12f8caea55970c5c9b35f35f0df11e5b4
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf symbols: Add O_NONBLOCK to DSO open() calls for untrusted paths

DSO paths from perf.data MMAP events could reference FIFOs, device
nodes, or other special files.  Opening such paths without O_NONBLOCK
can hang perf report/script indefinitely waiting for a writer or device.

Fixes: a08cae03f430b971 ("perf tools: Allow to close dso fd in case of open=
 failure")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/finding/6
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> Add O_NONBLOCK to all open() calls in the DSO symbol resolution paths:
> filename__read_build_id(), filename__read_debuglink(), symsrc__init(),
> do_open(), filename__decompress(), and __dso__read_symbol().

[Severity: High]
This isn't a bug introduced by this patch, but are there several other
DSO resolution paths missing this protection?

For example, decompression checks seem to perform blocking open() calls
before filename__decompress() is reached:

- tools/perf/util/zlib.c:gzip_is_compressed()
- tools/perf/util/lzma.c:lzma_is_compressed()

Additionally, blocking opens appear to still be used in:

- tools/perf/util/symbol-elf.c:sysfs__read_build_id()
- tools/perf/util/capstone.c:symbol__disassemble_capstone_powerpc()
- tools/perf/util/unwind-libunwind.c:read_unwind_spec_debug_frame()

Since crafted perf.data paths ending in .xz or .gz might hit these checks
first, will they still cause an indefinite hang?

> diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-mi=
nimal.c
> index ea2de3d50d33c..dc4a06b2a03ad 100644
> --- a/tools/perf/util/symbol-minimal.c
> +++ b/tools/perf/util/symbol-minimal.c

[ ... ]

> @@ -234,7 +234,7 @@ int sysfs__read_build_id(const char *filename, struct=
 build_id *bid)
>  	char buf[BUFSIZ] __aligned(4);
>  	ssize_t len;
> =20
> -	fd =3D open(filename, O_RDONLY);
> +	fd =3D open(filename, O_RDONLY | O_CLOEXEC | O_NONBLOCK);
>  	if (fd < 0)
>  		return -1;

[Severity: Low]
This is a pre-existing issue, but is it possible this function violates the
strict aliasing rule for tools code?

Later in this function, the char buffer is passed into read_build_id():

    len =3D read(fd, buf, sizeof(buf));
    if (len > 0)
        ret =3D read_build_id(buf, len, bid, false);

If read_build_id() casts this buffer to a u32 struct pointer to read the
ELF note header, this would be type punning. Although perf is built with
-fno-strict-aliasing, tools code assumes standard -fstrict-aliasing per
the subsystem guidelines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612003444.5072=
3-1-acme@kernel.org?part=3D14
