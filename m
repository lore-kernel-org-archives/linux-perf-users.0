Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1176D488231
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912929; cv=none; b=sNILueoPAd/LG9Y+CbJGW3jU4Q5es+gVpIcgZHwGoIECRJeNg7NSA01tpC9vo0ecwmuT4j1bkn6XQECcqfCl/VU2wHcRoOa6YU7n3ioES+Ue6kaEQ60jO9qPoxuYfIe1mTG/OCjKbfVtoqAtV6N8i/z1UqTdTLjRQy8FvIu8EI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912929; c=relaxed/simple;
	bh=bnNvmBX20IzmLIdEcoFqAvYjTYJv6r16n7yE5Su4w8M=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SAgxVFqQamhmbJKfJ5jguqzhJ3SGhZo7WGA6cTIeB2lP5xJdPwgvGjQ+86RcIkFxtrXWY+Ag9DxoR7w3hrmv9z+VfK5OOxnxI9g34WOEt3azj/Q/cG5x/u3wRkBl3iaHLCFZxsHSb1iFdTqXQJqMCt+ZkC7b1ZSjnftN/VC4tEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJYVV62t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJYVV62t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A71F1F000FF;
	Tue, 13 Oct 2026 17:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912927;
	bh=08tQeK2LmloIwrA4wN1Zsib6/WJTdo22wqHSL96OcKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RJYVV62tnqFE6AexxJP4RMNCROED8Zz3Cjv0pCL+IsfGmg527pRb4TrO6E8I+CA82
	 DopN5qyj67ncgdGtSyU/BBEDDTRT1FXPuyT8tBb5q7GMDDAWwvTEo02s57XYi9AE/w
	 i1SWsHHIc9ksHHN70grzZ1+Xi6Tq0IW34bxLDKEU1glCYesDxt0ALzNJ3RtV59uX/p
	 T8wqZw6dVxZWchJfWYcktxnebRd036DkQzc7ezPoBKR/5GCkgqxWqO2bY1DEpKM4IO
	 nj3JkSWsdejkhxzZqfGw7Y3d8yKH4ktNJhGW+JqOaKsHR/bSodhR8ZBgwB3GYfU6Lx
	 2b2L7rAYa8uIw==
Message-ID: <sashiko-outbox-170239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/11] perf symbol: Do not set binary type from
 symtab type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261013172155.160869-10-namhyung@kernel.org>
References: <20261013172155.160869-1-namhyung@kernel.org>
 <20261013172155.160869-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 17:35:27 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: guest kmodules misidentified as host system path DSOs
--

commit 509bcd616550a20de7fa8d41090d38531f89cf60
Author: Namhyung Kim <namhyung@kernel.org>

perf symbol: Do not set binary type from symtab type

The DSO binary type is used to access the binary data, while the symtab
type is for the symbol table. This commit avoids setting the binary type
from the symtab type when loading symbols, and instead updates the binary
type only when opening the DSO.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 47241077ad260..1ca4cc5ec7db0 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1491,9 +1491,10 @@ uint16_t dso__e_machine_endian(struct dso *dso, st=
ruct machine *machine, uint32_
>  			       bool *is_big_endian)
>  {
>  	uint16_t e_machine =3D EM_NONE;
> +	enum dso_binary_type dbt =3D dso__find_binary_type(dso);
>  	int fd;
> =20
> -	switch (dso__binary_type(dso)) {
> +	switch (dbt) {

[Severity: High]
Will this change cause guest kmodules to be misidentified as host system
path DSOs?

By executing dso__find_binary_type() first, the code evaluates the priority
list in dso__find_binary_type_locked(), which checks
DSO_BINARY_TYPE__SYSTEM_PATH_DSO before falling back to dso__symtab_type(ds=
o).

If the host filesystem happens to contain a module at the exact same absolu=
te
path as the guest kernel module (e.g., /lib/modules/x.y.z/...), the
SYSTEM_PATH_DSO file check will succeed. This causes dso__find_binary_type()
to return SYSTEM_PATH_DSO instead of DSO_BINARY_TYPE__GUEST_KMODULE.

Because dso__e_machine_endian() receives SYSTEM_PATH_DSO, it will fall
through this fast-path switch, open the host file, and return the host's ELF
machine architecture. Could this break cross-platform perf analysis (such as
an x86_64 host analyzing an arm64 guest) by parsing the host's headers
instead of the guest's?

>  	case DSO_BINARY_TYPE__KALLSYMS:
>  	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
>  	case DSO_BINARY_TYPE__VMLINUX:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013172155.1608=
69-1-namhyung@kernel.org?part=3D9
