Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E44CC27D
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498472; cv=none; b=tZtR9A5SKCewrZkY578sGeF6kNC+oIMMx3r6m/Vk9D9xOLeOKqfrp8fZ1RbOwj/VlMi4twjX8fYP6q8lEgLkWtS5BSxps/BAH0PAmUNUFTHRZalnwypSzBfihaaaFcd20cVcHvruCDwnum4YxTqzYfuMMBuP2an3x+DdT7jCSc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498472; c=relaxed/simple;
	bh=RcDwoQWknRHHDILqel5R41s7oZBoUD+P5bFcjciISiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ViTguRqTnWjxUkT3cwVSGSezsFnsLHyaDQrzEmRdnW2LnJ3oRLW//8tWMZBxfHl/zvAMsK30xkN1fI90b57289cTCLXPh5qptM4Rz4TOvt01jqcc2o5b7Eg4hXW7JBmHHXy5bB0dKojDBv527tLMSUjF2chxsaZa7xdmD8Li6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT/EUSYl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT/EUSYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B345F1F00893;
	Tue, 15 Sep 2026 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789498471;
	bh=WMfC6Fu/vZySuer5i9PHffxitpDpY34HtZ0aBRdoNVo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MT/EUSYl5NnaFtTI/3GvsfP8akuof748rfy4I4nwstO2cssILsos0xqxRpEbuU1jZ
	 fryXxdzRtTddIWjpW+BwVTiN0jGg8YTQwwT0vnlEfv+fqrwO5uUAG8h4xv6CQbpl3g
	 tu4Rxz7a0zxMSeZSmoR/EjJRS5+g/k4ariQ709utDHwzgm472YBgXQRJIxKfF5vjbJ
	 iWFeBF6vrVmmH91JMHexv17Lpd/WO4dkAkD/GvjVaR5qcx0JzbY5x6zD0pjGOMqssD
	 Jz+HPUoOlFd0+BGL8H98mgweeiSZwRFUK+8NazaiOCKZpYFyuUUXVlsik/3bWZnnii
	 7b3NqIwUYBLXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] perf script: Add --lazy-load-symbols for lazy
 symbol loading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alireza Haghdoost" <haghdoost@uber.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-3-1d3360e21f07@uber.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:54:29 +0000
Message-Id: <20260915185430.B345F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: memory exhaustion in ondemand_read_name() via truncated ELF
--

commit 9189c705674e1061e4de963daab5ec07bd55d920
Author: Alireza Haghdoost <haghdoost@uber.com>

perf script: Add --lazy-load-symbols for lazy symbol loading

This commit introduces lazy symbol loading for userspace ELF DSOs in perf
script. It builds a sorted in-memory index of symbols and resolves them via
binary search, reading symbol names on-demand from the string table using
pread() to reduce memory footprint.

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 914e42d21f70f..e4d77e46e8830 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c

[ ... ]

> +static const char *ondemand_read_name(int fd, u64 strtab_offset,
> +				      u64 strtab_size, u64 name_off,
> +				      char *buf, size_t buflen,
> +				      char **to_free)
> +{

[ ... ]

> +	/*
> +	 * Slow path: the name is longer than buflen.  Grow a heap buffer
> +	 * geometrically, doubling until the terminator appears, so a long
> +	 * name costs O(name length), not O(remaining strtab size).
> +	 */
> +	cap =3D 4096;
> +	for (;;) {
> +		char *tmp;
> +		size_t want =3D cap;
> +
> +		if (want > remain)
> +			want =3D remain;
> +		if (want =3D=3D 0)
> +			break;
> +
> +		tmp =3D *to_free ? realloc(*to_free, want + 1) : malloc(want + 1);
> +		if (!tmp) {
> +			free(*to_free);
> +			*to_free =3D NULL;
> +			return NULL;
> +		}
> +		*to_free =3D tmp;
> +
> +		n =3D pread(fd, *to_free, want, file_off);
> +		if (n <=3D 0) {
> +			free(*to_free);
> +			*to_free =3D NULL;
> +			return NULL;
> +		}
> +		(*to_free)[n] =3D '\0';
> +
> +		if (memchr(*to_free, '\0', n))
> +			return *to_free;
> +
> +		/*
> +		 * Read the whole remaining strtab (or hit EOF) with no
> +		 * terminator: corrupt file, bail instead of re-reading.
> +		 */
> +		if (want >=3D remain || (u64)n >=3D remain)
> +			break;

[Severity: Medium]
Does this loop properly handle a short read (EOF) on a truncated ELF file?

If pread() hits EOF before filling the requested want bytes, n will be smal=
ler
than want but greater than 0. The loop condition currently checks if
want >=3D remain or (u64)n >=3D remain, but it appears to miss an explicit
short-read/EOF check like (size_t)n < want.

Because of this, if remain is very large (based on an unvalidated sh_size
in the ELF header), the loop could continuously geometrically reallocate up
to remain bytes while reading the exact same short bytes from the constant
file_off. Could this cause memory exhaustion / an OOM allocation failure?

> +
> +		/* Avoid size_t overflow on absurdly large strtabs. */
> +		if (cap > SIZE_MAX / 2)
> +			break;
> +		cap *=3D 2;
> +	}
> +
> +	free(*to_free);
> +	*to_free =3D NULL;
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-perf-symbo=
l-memory-send-v1-0-1d3360e21f07@uber.com?part=3D3
