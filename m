Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741186;
	b=xz5oEUhwLVbOO4d6CxiyBEaWpselFrGcmyN/HvMOgJsLk+qU7pBXJqgPKpPXYzJ7FJVr
	 WvDPsAeRyEWZo2S/wr7Q3ekMVVJ/69FFFdoa7R4ocj5/ilQBc9xtVlKNxONaL51Weyr2H
	 LBztViQU1bTM3IL8rFkceWK9J7l3ja8cHHFB6oPEw3jyz+enZgY2y4E+F4S8aJzPNsdym
	 Z4heZWzyzI0raazAdP386Zz8OlTMWPjaWhpjfB37Pj3ubp0BPJIRAcNtQQFYaudT9eWUZ
	 czrur6tiY79w2yu3kcUcrE4DKHEpvGI9l3gPwVc4/be2X5AhZCEE0lA6BTWWFYYgaeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741186;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5wE3f/JIPIpVvliT6GpmFOFi8576avi51kjvleSFsFw=;
	b=43aee2TVu/w+EuYarET6U5Sx9hDSVjTXE/2saBPHLehMbViEARQfgVTBB84Oln3tZaV/
	 2CpATFK0C2PvET8/xRRGQsc73s4YJWgAx6aXs/0JX4zyxQLJcb6P1JN9DXQasLfj1MJXW
	 dEQGLdJ6hQGiIPKC1yOvP3wQCUvHpLf9qewPCe0nYGq6QZKqo+g0OIeqs5M0aGH+kNlX1
	 rSerwkCyut+BY+8CkzaZotyt5Lc/sFActOqK+IL0r5SCAkG5Ir2/Px/iqJaEoNdF6xE8e
	 P4iUBhSNvFp5M5oIX3YgoY0BTaQzEYlt6JkplDw4YHkw+cLCQ19zT1imaF5N1QIYXtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrVEOKji;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E5606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrVEOKji
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5085B1F01825;
	Fri, 23 Oct 2026 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741185;
	bh=5wE3f/JIPIpVvliT6GpmFOFi8576avi51kjvleSFsFw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XrVEOKjiWA3QNN3LX2o3b7w6yqk9Su9oGfp1GUBY3g1v/NTDXVso5Bm2GJaX1lbhs
	 ykrBydav/2iiWzEcoEYvFIg6ATlJ3oiNZ1kX/lwGPLz0lc3qsKOStEAiLF1Epo26So
	 rdACc+5YY3OUTqOv6Z4/jl4qyXzPPKqDw45uJLis0LCCbasVg3nf/tFVagWEsRYIqs
	 J2vCP3j1FXiiLSW0vME2Rzk3FRqzR8qO7aVZCIsp0bc6Tl2RLgKSK4NuxGLKDJEtvn
	 EEeliTnTzR8mik/tjmAfQ3u2dAraJPtuv7kfKzXBMTIWcb9hpywhv1E8Eb/k3QvOsL
	 qfikxN/hcaDxA==
Message-ID: <sashiko-outbox-182426@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/11] perf tools: Scope mount namespace entry in
 dso__load()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-12-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-12-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:39:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf symbol: dso__load() skips mountns entry for distro debuginf=
o types
- [Medium] perf symbol: dso__load() exits mountns before minimal dso__load_=
sym()
--

commit 427f0e7b67c8f82ef4840db188e00127e13b171a
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Scope mount namespace entry in dso__load()

This commit narrows the scope of mount namespace entry in dso__load() so
that the target mount namespace is entered only when reading perf maps,
reading build-ids, or probing binary types where dso_binary_type__needs_ns()
returns true.

> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 807e433c77081..063e9da0878e9 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c

[ ... ]

> @@ -1882,24 +1879,25 @@ int dso__load(struct dso *dso, struct map *map)
>  		struct symsrc *ss =3D &ss_[ss_pos];
>  		bool next_slot =3D false;
>  		bool is_reg;
> -		bool nsexit;
> +		bool nsenter;
>  		int bfdrc =3D -1;
>  		int sirc =3D -1;
> =20
>  		enum dso_binary_type symtab_type =3D binary_type_symtab[i];
> =20
> -		nsexit =3D (symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
> -		    symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO);
> -
>  		if (!dso__is_compatible_symtab_type(dso, kmod, symtab_type))
>  			continue;
> =20
> +		nsenter =3D dso_binary_type__needs_ns(symtab_type);
> +		if (nsenter)
> +			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);

[Severity: Medium]
Could gating namespace entry on dso_binary_type__needs_ns() break separate
distro debuginfo lookup for processes in containers or chroots?

Previously, dso__load() stayed in the target mount namespace for all
binary_type_symtab[] entries except DSO_BINARY_TYPE__BUILD_ID_CACHE and
DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO.

In tools/perf/util/dso.h, dso_binary_type__needs_ns() returns false for
distro debuginfo types:

tools/perf/util/dso.h:dso_binary_type__needs_ns() {
	switch (type) {
	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
	case DSO_BINARY_TYPE__DEBUGLINK:
	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
		return true;
	...
	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
	...
	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
	...
		return false;
	}
}

Just before this loop, dso__load() reads the build-id inside the target
mount namespace specifically for DSO_BINARY_TYPE__BUILDID_DEBUGINFO:

tools/perf/util/symbol.c:dso__load() {
	/*
	 * Read the build id if possible. This is required for
	 * DSO_BINARY_TYPE__BUILDID_DEBUGINFO to work.
	 */
	if (!dso__has_build_id(dso)) {
		struct build_id bid =3D { .size =3D 0, };

		__symbol__join_symfs(name, PATH_MAX, dso__long_name(dso));
		if (filename__read_build_id_ns(name, &bid, dso__nsinfo(dso)) > 0)
			dso__set_build_id(dso, &bid);
	}
}

When dso_binary_type__needs_ns() returns false for those debuginfo types,
dso__read_binary_type_filename(), is_regular_file(), dso__load_bfd_symbols(=
),
and symsrc__init() will check the host filesystem instead of the target
container or chroot filesystem (unlike build_id_cache__find_debug() in
tools/perf/util/build-id.c, which enters the target mount namespace when
resolving /usr/lib/debug/.build-id/ paths).

> +
>  		if (dso__read_binary_type_filename(dso, symtab_type,
> -						   root_dir, name, PATH_MAX))
> +						   root_dir, name, PATH_MAX)) {
> +			if (nsenter)
> +				nsinfo__mountns_exit(&nsc);
>  			continue;
> -
> -		if (nsexit)
> -			nsinfo__mountns_exit(&nsc);
> +		}
> =20
>  		is_reg =3D is_regular_file(name);
> =20
> @@ -1910,8 +1908,8 @@ int dso__load(struct dso *dso, struct map *map)
>  		if (is_reg && bfdrc < 0)
>  			sirc =3D symsrc__init(ss, dso, name, symtab_type);
> =20
> -		if (nsexit)
> -			nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> +		if (nsenter)
> +			nsinfo__mountns_exit(&nsc);

[Severity: Medium]
In NO_LIBELF=3D1 builds, will exiting the mount namespace here cause the
minimal dso__load_sym() to overwrite the DSO build-id with the host binary's
build-id?

After this loop finishes and the target mount namespace has been exited,
dso__load() calls dso__load_sym():

tools/perf/util/symbol.c:dso__load() {
	if (syms_ss)
		ret =3D dso__load_sym(dso, map, syms_ss, runtime_ss, kmod);
}

In tools/perf/util/symbol-minimal.c, dso__load_sym() opens ss->name by path
without entering dso__nsinfo(dso):

tools/perf/util/symbol-minimal.c:dso__load_sym() {
	struct build_id bid =3D { .size =3D 0, };
	int ret;

	ret =3D fd__is_64_bit(ss->fd);
	if (ret >=3D 0)
		RC_CHK_ACCESS(dso)->is_64_bit =3D ret;

	if (filename__read_build_id(ss->name, &bid) > 0)
		dso__set_build_id(dso, &bid);
	return 0;
}

If the container DSO path in ss->name also exists on the host (for example,
/lib64/libc.so.6), wouldn't filename__read_build_id() read the host file and
clobber the build-id that filename__read_build_id_ns() read from the target
namespace earlier in dso__load()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D11
