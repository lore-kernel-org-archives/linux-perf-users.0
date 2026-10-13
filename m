Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417B61FCE
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 00:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791850094; cv=none; b=aYqFyzUGrSevwrXgMQkv6W7wcryxRqNMXV4aSogPNGKAusgyWmCvZzfcKigZbBGQvWrVfqmfO79r+kBoeHNl0adQY6qGxD/PfJyDLSXbUApYSv/x+JYSfgTlWGAOyVTsiZ2DnP+dGeKIfWCes8wo6hMx/v/5TAct4q8DmPF+xek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791850094; c=relaxed/simple;
	bh=WQ1YZ5t55gEQhgQBy+9LC2xLLYxgJ66m0kT6akYwnCQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gVAEUobTv7FmmO+A5st8/ip/X3xuNOD+Dv/Ff+LAgKFNiFA63wG+YQkU5Up4diWDE7h0mTJ1ZePXV3TSeaK/z253nK3m6ixVog9enwgn1RLE6tJOlIGPGa1o8XcYDpNUCOhmDNuQQ3lUnhsTR9Tty6F19osapgg4lXovDUrYlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF2Wdn7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF2Wdn7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371101F008A1;
	Tue, 13 Oct 2026 00:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791850093;
	bh=/PzsziUn78xrQmnfV8x6tMCVZL/wfrAHvufhDtnTnFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LF2Wdn7x3NSnVTAUktm42lJI/tSdMjfAi/5YSkLSvhBdt6SW48mr4CEp9ZRt4oob5
	 9k5Ri0dIu5z9tvIsbWMU4y38R/L701PBXhBlvhFTYQCjJtt5Wx8XozyIMta6v+Herm
	 X0C1NgNAcqSCtYIqherFd1F5JCorzba5OPBn9n3bueyTSx4+z3O+K+83tF5iUjkDIp
	 TsKMmjvbtO5WLFsjloBNSIJwkNWlPgPNu+TV2M7BqtDFhJed9jGxrGNeKa+XsbQ7JQ
	 yVZJdV4RZrNaSHx85dg6Zs91mlVV/KYaOkxwVXIAA4QywT3bSClpTCZ3QF2pPC4H0r
	 xWnFQApnV5zBg==
Message-ID: <sashiko-outbox-168778@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/10] perf symbol: Do not set binary type from
 symtab type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012234654.60666-9-namhyung@kernel.org>
References: <20261012234654.60666-1-namhyung@kernel.org>
 <20261012234654.60666-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 00:08:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: fully stripped executables falsely rejected for data access
--

commit 6b9e46855d4e0d8df1dcaaed600da2f693471adb
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Do not set binary type from symtab type

This commit separates tracking of the DSO binary type from the symtab type.
It removes the explicit setting of the binary type during symbol loading,
deferring it until the DSO is actually opened.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 4a8c298039447..116870595f75c 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1943,19 +1943,6 @@ int dso__load(struct dso *dso, struct map *map)
> =20
>  		if (next_slot) {
>  			ss_pos++;
> -
> -			/*
> -			 * The binary type is used to find the file containing
> -			 * the executed instructions, so prefer the types that
> -			 * refer to the actual object over debug-only files such
> -			 * as DSO_BINARY_TYPE__DEBUGLINK.
> -			 */
> -			if (dso__binary_type(dso) =3D=3D DSO_BINARY_TYPE__NOT_FOUND ||
> -			    symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> -			    (symtab_type =3D=3D DSO_BINARY_TYPE__SYSTEM_PATH_DSO &&
> -			     dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE))
> -				dso__set_binary_type(dso, symtab_type);
> -

[Severity: Medium]
Will removing this explicit assignment cause fully stripped executables to =
be
falsely rejected during data access operations like perf annotate?

By leaving the DSO binary type as NOT_FOUND here, disassembly paths are for=
ced
to fall back to dso__find_binary_type_locked() to identify the file type.
That logic attempts to verify the file using filename__has_section() for the
.text section:

tools/perf/util/dso.c:dso__find_binary_type_locked() {
    ...
    found =3D filename__has_section(path, ".text");
    ...
}

For stripped executables (which have had their section headers removed but
still have valid PT_LOAD segments), this check returns false. Previously,
because dso__load() set the binary type directly when locating the system
path DSO, it bypassed the strict .text check.

Consequently, tools like objdump that can parse PT_LOAD segments are never
invoked, and operations fail with COULDNT_DETERMINE_FILE_TYPE.

Additionally, could this cause debuginfo files to be incorrectly selected f=
or
data reads, since their SHT_NOBITS .text sections might falsely satisfy the
check?

>  			if (syms_ss && runtime_ss)
>  				break;
>  		} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012234654.6066=
6-1-namhyung@kernel.org?part=3D8
