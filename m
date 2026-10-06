Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2A3BBFB4
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 23:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331036; cv=none; b=cgzx5D7Bazqk909uJU/k90P/0JAcrY2SODVbeeQsfqMmkxYkRuucP97hn9jyu8rWDwhUhFpIMGhfz8E+kTClc0+LKq/nfsZAbqVXQUn3zes57XXhbkOpPfDcj7ulMUlbn59Uc7aHVDrBrJ21VuTKFoD8UjKQNng+56Ts5O92urM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331036; c=relaxed/simple;
	bh=f8khyF+J15m6n42ZFuce6nm5VECtBYA7Urmq/dJuU5c=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dXgYeqyiNfYMqouI40smDkc6Ot2YYM4Kt3XgJt2ROAMcdvK6z/foMKjI+/HyGmlnPVmsjhiBF5V1AVg23FJeOq+hyvvTApNlSQvB91WJdJ7rp/prShTwk0Oi6/dVuueGhYTamg+94BGZ1FcdApCDD+EZV4+rR6kNx1ZEY8TBGTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihXBadAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihXBadAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDDD1F0089B;
	Tue,  6 Oct 2026 23:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791331034;
	bh=KJ93hq9LiIZ1emwM3blsFxAzZgs9pmGcRFg2M37HJAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihXBadAR+6JpZHBVVGbI7aUR88I4iZb+Fq7UVmpqAygl79auddN/Cq9rvmhWsR1gS
	 z06fok900z5YeKa3svy2lNPhxKzcy/rmVRh1yrqTHON+VlVu9HPHyX3BLoCK3Sa5RT
	 gGWXeDBUx4HIkA/M17SXBUYcXHy46H/iBINgbZBK9/xtZsf9DVQB/EfEkxE599SZZB
	 1LfDHowJV+4nQJe3VKsVs89JZf7lZbvZ4Hb4eVfmaN9QrChioGXbb+LtznZg0UXYWd
	 2kPenqryoAUAeMrCNxpOKio+lfs8wPWdiwXuiTk61jNkNrxF7cgoKs6oYnTBJK212o
	 WwMkqaxMiqQ3Q==
Message-ID: <sashiko-outbox-162539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] perf symbol: Do not set binary type from
 symtab type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261006234315.920817-9-namhyung@kernel.org>
References: <20261006234315.920817-1-namhyung@kernel.org>
 <20261006234315.920817-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 23:57:13 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf: data-only DSOs fail to open due to strict .text section requ=
irement
- [High] perf: compat offline DWARF unwinding broken due to missing binary_=
type
- [Medium] perf: redundant double-decompression of compressed kernel modules
--

commit 0528580a893b2b2066f28586347977aa4bf1e268
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Do not set binary type from symtab type

The DSO binary type is to access the binary (e.g. instruction) data
while symtab type is for the symbol table.  They may or may not be in
the same file.  We should track them separately and correctly.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 389dbd7e5192f..1175cb60f8206 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1956,19 +1956,6 @@ int dso__load(struct dso *dso, struct map *map)
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

[Severity: High]
Does removing this fallback prevent opening data-only DSOs?

Without this early assignment, DSOs remain as DSO_BINARY_TYPE__NOT_FOUND.
Any profiling workload attempting to access symbols in a DSO without
executable code might hit this path:

try_to_open_dso()
  __dso__find_binary_type()
    filename__has_section(path, ".text")

Because the ".text" check fails for data-only DSOs, the binary type remains
DSO_BINARY_TYPE__NOT_FOUND. This bypasses the correct opening logic in
open_dso() and permanently marks the DSO with DSO_DATA_STATUS_ERROR. Can we
still open data-only DSOs (like eBPF maps or data-only kernel modules)
after this change?

[Severity: Medium]
Without the early binary type assignment, does this introduce redundant
decompression for compressed kernel modules?

When try_to_open_dso() is called for a compressed kernel module, it first
calls __dso__find_binary_type(), which uses dso__get_filename() to fully
decompress the module to a temporary file just to check for a ".text"
section, and then unlinks it.

Immediately following this, try_to_open_dso() calls open_dso() which again
calls dso__get_filename(), triggering a second complete decompression of the
exact same module. Can this cause severe performance degradation when
processing profiles containing compressed kernel modules?

[Severity: High]
Could this removal also break offline DWARF stack unwinding for compat task=
s?

Because user-space maps now have a binary type of DSO_BINARY_TYPE__NOT_FOUND
during early processing, when thread__e_machine_endian() calls
dso__e_machine_endian() to determine the architecture, it hits the fallback:

tools/perf/util/dso.c:dso__e_machine_endian() {
    ...
    switch (dso__binary_type(dso)) {
    ...
    case DSO_BINARY_TYPE__NOT_FOUND:
    default:
        if (e_flags)
            *e_flags =3D 0;
        return EM_NONE;
    }
}

It immediately fails and returns EM_NONE without attempting to open the fil=
e.
Consequently, thread__e_machine_endian() fails to extract the architecture
from any map and falls back to perf_env__e_machine(), which incorrectly
applies the host architecture to the compat thread.

>  			if (syms_ss && runtime_ss)
>  				break;
>  		} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006234315.9208=
17-1-namhyung@kernel.org?part=3D8
