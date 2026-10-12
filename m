Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36D2DECD3
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783508; cv=none; b=WmAfKXBdRzsPJW1KmAQFD+AdmqGULpR8sdKhwbWHWTzLAjZoGGbrSwjSZnj+TP+QK2Mr7DzbBgJZ1cVyFovbucthcGRY0h9aNGDEcpyv5aT12wxuygIrCC40iqZQcMbgaTCexU8IE6Zrkpcy316xoOSb0jpQRff5nQrN07ixypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783508; c=relaxed/simple;
	bh=cO2Edf8R2JZXXVE357TBNk1EH+GlPInMk3CQdGZ9WQk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=afudjCuxZuNDhY2FWrzDPx9aSnP0rcWEArgeO/E7Bhm0Z4bjvCGUNAl5WN3HKB9L0X9XqHtd8OJP3mqb3RuAkAYbj2orDFID3/lNdXdfD4DgZCF4I8bxaPlNKLxxAiKc5Jdvrukh58sodQKkfcnp1lwUhdePJmRk+M1mUhDQ0sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+QMyD/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+QMyD/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E01F0089B;
	Mon, 12 Oct 2026 05:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791783506;
	bh=OoWub8gNQ1SLqps0kiRa42OTqxJPVimLxLQIpADh2Rs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+QMyD/vpwzTLuoY5mwUgYVcRcEH4yLPhZo37iyJeL5RjEoaYo2xSPXqOKTmaYqMj
	 ph+AsdAue9oIBp82K7otFNq6lfFwBn5Uhc/znF1dWn+u85aWcUB5msx9B+dN19SjXo
	 Y4iG1/gufEYaA4U7l6PSNxTx0wABOYmEWM1QoMddLmMNSOTsjJh1bLllA+kDfeX6GE
	 4QaiXKBSXN8S8DbobPC+dughEPSCu8qRLBNbG68opD51WMoNSADEk6rcIHRJhucxML
	 c/zbMhjVt+a6T7CSH2zIiS4EHsIJ8ZenArOe8Qww+UyxbWcHpZV3cwhBoGDUgSHu1T
	 8WbXK+tJ1x+ww==
Message-ID: <sashiko-outbox-167681@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/10] perf symbol: Do not set binary type from
 symtab type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261012052601.13920-9-namhyung@kernel.org>
References: <20261012052601.13920-1-namhyung@kernel.org>
 <20261012052601.13920-9-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 05:38:26 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] perf/dso: out-of-bounds access in close_first_dso() on empty list
- [Medium] perf/dso: deadlock in __dso__find_binary_type() during EMFILE re=
try
- [Medium] perf: stale errno causes false failure in dso__find_binary_type_=
locked()
--

commit bda2b4581480880eb2e75b857a614dacf9c33795
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Do not set binary type from symtab type

The DSO binary type is intended to access binary data, while the symtab
type is for the symbol table. This commit separates their tracking by
leaving the binary type info intact and only updating it when actually
opening the DSO.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 851b39c63ec86..a8e531766f1b5 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1485,9 +1485,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, st=
ruct machine *machine, uint32_
>  			       bool *is_big_endian)
>  {
>  	uint16_t e_machine =3D EM_NONE;
> +	enum dso_binary_type dbt =3D dso__find_binary_type(dso);

[Severity: Medium]
This new call to dso__find_binary_type() can expose a potential deadlock.

If dso__find_binary_type_locked() returns -1 due to an open file limit,
__dso__find_binary_type() acquires dso__data_open_lock() but does not relea=
se
it before jumping back:

tools/perf/util/dso.c:__dso__find_binary_type() {
    ...
	if (ret =3D=3D -1 && retry++ < FIND_MAX_RETRY) {
		if (needs_open_lock)
			mutex_lock(dso__data_open_lock());
		close_first_dso();
		goto again;
	}
    ...
}

Could this cause a double-lock deadlock on dso__data_open_lock() if
ret =3D=3D -1 happens again on the next iteration?

[Severity: High]
When __dso__find_binary_type() encounters EMFILE, it unconditionally calls
close_first_dso():

tools/perf/util/dso.c:__dso__find_binary_type() {
    ...
		close_first_dso();
    ...
}

Does close_first_dso() extract the first entry from the dso__data_open list
without verifying if the list is actually populated?

tools/perf/util/dso.c:close_first_dso() {
    ...
	dso_data =3D list_first_entry(&dso__data_open, struct dso_data, open_entry=
);
    ...
}

If the list is empty, couldn't this yield an invalid pointer and lead to
out-of-bounds memory corruption when closing the fd?

[Severity: Medium]
Inside dso__find_binary_type_locked(), it appears we read errno uncondition=
ally
when filename__has_section() returns false:

tools/perf/util/dso.c:dso__find_binary_type_locked() {
    ...
		found =3D filename__has_section(path, ".text");
		if (!found)
			saved_errno =3D errno;
		dso__put_filename(dso, path, decomp);

		if (found)
			return dso__binary_type(dso);
		else if (saved_errno =3D=3D EMFILE)
			goto open_err;
    ...
}

Since a false return legitimately occurs when the .text section is missing
(without updating errno), could a stale EMFILE value be erroneously captured
here and cause false failures?

>  	int fd;
> =20
> -	switch (dso__binary_type(dso)) {
> +	switch (dbt) {
>  	case DSO_BINARY_TYPE__KALLSYMS:
>  	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>  	case DSO_BINARY_TYPE__VMLINUX:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012052601.1392=
0-1-namhyung@kernel.org?part=3D8
