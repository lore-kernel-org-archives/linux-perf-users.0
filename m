Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741622;
	b=cgFGhtfrtDxuxIXp7/3AWaCBfLoddDTnuFsm7szJ6EE/l/TrMtEsgN75X0Kyrjitxl7N
	 6iHK3frhVx8zLHYlxK8WhFt4Vr/CI4LZrs8M8qGpt88uC6JYOlxUbGp93ZN6o1GmbdpWH
	 NqfGNyuM9aleUQl8yZ+4q7ZqIO2RAkPOTpo0UaigrXwOF2oZF17aJY4MN1K5C5aU74tCT
	 KKAEzlLmGOhPrRu+wB+foMChAaWEN0SIEUET8cZRnXF+i0YbAh4GKLPL27DhYLXses/eR
	 aENhmmHarMooZ6Aed0odss35o1SbuUaWaR70o1NyahjaupdRNJK3yd4HBavP4KyRiDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741622;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cIWuyHyTupV1aNVBpi8qiw/8xl/uN//Uj4h45Wlq+0s=;
	b=uq2CBesjGJm6zPZOpu7+rzaCwpwJlgBUMIMlix+xomcMS1EmBqSo4TSdNgBxijFHR/Wh
	 nV2xZtIuWEM/XEvpdo1Am2cDBpkzB+O4H2jXTu0wB0k1PL78xFwhw9oz9kQXPTcSBpu12
	 nOcCus53qC+vkfU5ayC6M3g6jf1fK8CfNDMWm39DcirdahdH47nEP431Ma0LULG4mhbyC
	 c5rYuCUCQvbcsa5L3g32y6O27+ITPIEDLdxQwnmDonz9YiPAWVKux9kmgoiSk4JMZ2RRN
	 LTGT9g3jnRRLHBr+3NqgUL7gJKPAXHVh7+17Nu3KUtIYQGlMs62QQ7fVtKc6d2qAXSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4EUI16C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D4606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4EUI16C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABF11F01828;
	Fri, 23 Oct 2026 07:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741621;
	bh=cIWuyHyTupV1aNVBpi8qiw/8xl/uN//Uj4h45Wlq+0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W4EUI16CfUalbaWagpgwjyWCzJMeAKuIj5MAy269FHh2omCrmAX1DYgx3lWr8xOQm
	 Cs/+p9Nhjr0qqTEG6BnpQQzDFB277DivMMbqc0JT3MgQxaVihEaTc35PvX7alk8cPW
	 cRI62G2Noox0LaAAVJlkwy48SvPJFHbpy8IkYihDpXJ483KsxOHuPm8ezgG9iQr10S
	 iDDUKAGO3Brnsr5fLm6Gsv/D+0biczWv38A2juGDnAj35g5X2TdvVF1rvnyvY8pIpz
	 cbozUjnw+B1J3t7MZxxN6t+A/TA6ZUKH2tK+qs0KuQ4QPJ68NemhK4lx5mwVLqDs75
	 HY4vVdYDGvdPg==
Message-ID: <sashiko-outbox-182439@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/11] perf tools: Only enter mount namespace if
 necessary
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-11-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-11-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:47:01 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf tools: dso_binary_type__needs_ns() omits distro debuginfo t=
ypes
- [Medium] perf tools: commit message describes functions not modified by p=
atch
- [Medium] perf dso: missing mountns entry in dso__find_binary_type_locked(=
) and callers
--

commit 3413efb0cc2f846225d0adf449e8d23f1e99d575
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Only enter mount namespace if necessary

This commit adds dso_binary_type__needs_ns() to identify DSO binary types
that reside in a target process's mount namespace and chroot, and uses it
to gate nsinfo__mountns_enter() and nsinfo__mountns_exit() calls.

>     perf tools: Only enter mount namespace if necessary
>    =20
>     Add dso_binary_type__needs_ns() to distinguish DSO binary types that
>     reside inside the target process's mount namespace and chroot from
>     host-side paths.
>    =20
>     Gate mount namespace entry in dso__data_file_size() and do_open() usi=
ng
>     dso_binary_type__needs_ns().  And remove redundant outer mountns entry
>     in around dso__data_get_fd().
>    =20
>     Assisted-by: LLM
>     Signed-off-by: Namhyung Kim <namhyung@kernel.org>

[Severity: Medium]
Does the commit message match the functions modified in this patch?

The description mentions gating mount namespace entry in
dso__data_file_size() and do_open(), and removing an outer mountns entry
around dso__data_get_fd(), but the patch actually modifies open_dso(),
__dso__read_symbol(), and symbol__disassemble_capstone_powerpc().

[ ... ]

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 4331b48505b2b..50dd215f81f67 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -682,14 +682,15 @@ static int open_dso(struct dso *dso, struct machine=
 *machine)
>  {
>  	int fd;
>  	struct nscookie nsc;
> +	bool nsenter =3D dso_binary_type__needs_ns(dso__binary_type(dso));
> =20
> -	if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE) {
> +	if (nsenter) {
>  		mutex_lock(dso__lock(dso));
>  		nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
>  		mutex_unlock(dso__lock(dso));
>  	}
>  	fd =3D __open_dso(dso, machine);
> -	if (dso__binary_type(dso) !=3D DSO_BINARY_TYPE__BUILD_ID_CACHE)
> +	if (nsenter)
>  		nsinfo__mountns_exit(&nsc);

[Severity: Medium]
Will dso__binary_type(dso) ever be set to a namespace-dependent type if
dso__find_binary_type_locked() does not enter the mount namespace while
probing candidate paths?

In the call chain try_to_open_dso() -> __dso__find_binary_type() ->
dso__find_binary_type_locked(), each candidate type in binary_type_data[]
is tested before open_dso() is called:

tools/perf/util/dso.c:dso__find_binary_type_locked() {
	...
	do {
		dso__set_binary_type(dso, binary_type_data[i++]);

		errno =3D 0;
		path =3D dso__get_filename(dso, "", &decomp, dso__binary_type(dso));
		if (path =3D=3D NULL) {
			if (errno =3D=3D EMFILE)
				goto open_err;
			continue;
		}

		errno =3D 0;
		found =3D filename__has_section(path, ".text");
	...
}

Because dso__find_binary_type_locked() does not call
nsinfo__mountns_enter(dso__nsinfo(dso), &nsc) when
dso_binary_type__needs_ns() is true (and an earlier commit in this series,
"perf tools: Remove redundant chroot handling", removed the
dso__filename_with_chroot() fallback from dso__get_filename()), probing a
binary that only exists inside the target's mount namespace or chroot will
fail to find the file on the host and leave dso->binary_type set to
DSO_BINARY_TYPE__NOT_FOUND. When open_dso() then checks
dso_binary_type__needs_ns(DSO_BINARY_TYPE__NOT_FOUND), nsenter will be
false and __open_dso() will fail with -ENOENT (or inspect a host file if
one happens to share the same path).

Similarly, symbol__disassemble() in tools/perf/util/disasm.c calls
dso__find_binary_type(dso) and dso__get_filename(dso, "", &decomp, dbt)
outside the mount namespace before reaching __dso__read_symbol() or
symbol__disassemble_capstone_powerpc(), and dso__find_dbginfo_type() and
debuginfo__new() also call dso__get_filename() and inspect ELF sections
without entering the target's mount namespace.

[ ... ]

> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index e53c83c23c578..c4ff19f575b88 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -141,6 +141,40 @@ enum dso_binary_type {
>  	DSO_BINARY_TYPE__NOT_FOUND,
>  };
> =20
> +static inline bool dso_binary_type__needs_ns(enum dso_binary_type type)
> +{
> +	switch (type) {
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
> +	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__DEBUGLINK:
> +	case DSO_BINARY_TYPE__GNU_DEBUGDATA:
> +		return true;
> +	case DSO_BINARY_TYPE__KALLSYMS:
> +	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
> +	case DSO_BINARY_TYPE__VMLINUX:
> +	case DSO_BINARY_TYPE__GUEST_VMLINUX:
> +	case DSO_BINARY_TYPE__JAVA_JIT:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
> +	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
> +	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
> +	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
> +	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE:
> +	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
> +	case DSO_BINARY_TYPE__KCORE:
> +	case DSO_BINARY_TYPE__GUEST_KCORE:
> +	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
> +	case DSO_BINARY_TYPE__BPF_PROG_INFO:
> +	case DSO_BINARY_TYPE__BPF_IMAGE:
> +	case DSO_BINARY_TYPE__OOL:
> +	case DSO_BINARY_TYPE__NOT_FOUND:
> +	default:
> +		return false;
> +	}
> +}

[Severity: Medium]
Should dso_binary_type__needs_ns() also return true for
DSO_BINARY_TYPE__FEDORA_DEBUGINFO, DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO,
DSO_BINARY_TYPE__BUILDID_DEBUGINFO, and
DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO?

In dso__read_binary_type_filename(), those five distribution debuginfo
types construct target-filesystem paths via __symbol__join_symfs() (such as
/usr/lib/debug/... or <dso_dir>/.debug/...), rather than host build-id
cache paths like DSO_BINARY_TYPE__BUILD_ID_CACHE and
DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO.

In tools/perf/util/symbol.c, dso__load() only exits the target's mount
namespace for DSO_BINARY_TYPE__BUILD_ID_CACHE and
DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:

	nsexit =3D (symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE ||
	    symtab_type =3D=3D DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO);

When dso__find_binary_type_locked() falls back to dso__symtab_type(dso) in
binary_type_data[] (or when a later commit in this series, "perf tools:
Scope mount namespace entry in dso__load()", replaces the nsexit check in
dso__load() with dso_binary_type__needs_ns(symtab_type)), returning false
for these five debuginfo types causes perf to skip entering the target
container's mount namespace and chroot when resolving or opening them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D10
