Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741040;
	b=C8vZFcJBSECqpNr7rzBfS9ROfjw7yHyR0EmRyauqGdi3m44YexuqIzb+C5ZSW0U9o6oI
	 WJ3TL3cjyfZa/tNjaeH6HK905wbLCLeFD4+5LmKLGkyHTiKbvjM7xy/m4uTehLuuj/HX9
	 rb0w7oMQu3HMtI+J8Ze887Ni9tkp8euwlFWNDq1DPU37LQgMIsc3UXXYxZ6qPWr3783GK
	 xlE5dJtDTysbSv4Gv5Ji7+GpgfiUhscbyuqpXnA1IN7toXTnJz2G6QrSo2Adx9CcBBlWs
	 sMxHw1Sit1D4sFSAJrD6Wgvu3Z7Vj4UGD6lhWhO3VaJV2l1go9Ao7Ci6minA7r4auGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8dKwRbFs0mCmiWOhLVMbuXf0oyfttsRrun6ElY4Pat4=;
	b=yIkSBQEecejXBUU35kDSssSjrJMIA/53IKqJ+TvNP731yqm+MiwOScAndhV/SSVw+LNT
	 QWdQjC3NZGtH3g7PvHgAaRgHmB9qA7JBt7k6n/x9phtmE1V1I7aeuj098vAiaZrGLzTiG
	 rY0zeiVk4v43DAiDA9xUZMcg2NOZ7QEMFRDJ4es/N0HEdvdWebsskRmp+UVWAwM0NGHTS
	 RjToIVSD3NyyUh+JzwH/G1e0FZ4TkBvlXRvnopE+6NsA5UA4nwRXbHEe9OcX8P1Lp6Kdp
	 fC6gAZ3dEeo35vVrMHSzT1tr9E0RBxlOI1ilaQWkuaAJuEG/P2FTNbfH/PxQZiY56Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwW+YLJo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D61606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EwW+YLJo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A1E1F01825;
	Fri, 23 Oct 2026 07:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792741040;
	bh=8dKwRbFs0mCmiWOhLVMbuXf0oyfttsRrun6ElY4Pat4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EwW+YLJo5BiSwNWtzoOiHYpOgDzB38rSq7fKaQsXgiNIGkl8iMu4Q5ng+ImkkKlI6
	 8OFA+XfL0CqNv3ckCZ2YsFJhdy2UVJatHl6bN+36mz031TKIPShoxnCQ6Tw2QMWqkC
	 yEd4G0UiEX0SNnyxTXeAGpuK2q63PO4qvEuuQVQ7XBsjzn2OoEU7849QRHfxM8u3NO
	 hPqG1qx/a+OJIl+Swj9YZs0eaLTIUZGDNfaaz/RD4ARcdOWg7mG7xgIj/B2coVzTXY
	 2+GA9PUtFBtU+VhhjpmNsI2pRf15ci3S5Wy0+QdAbZjZ6kePHEr2/WghSA8NJ96NLw
	 LTDnP5yESNBEQ==
Message-ID: <sashiko-outbox-182422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 09/11] perf tools: Remove redundant chroot handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023071141.134149-10-namhyung@kernel.org>
References: <20261023071141.134149-1-namhyung@kernel.org>
 <20261023071141.134149-10-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 07:37:19 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: dso__get_filename() breaks chroot resolution outside mount=
ns scope
--

commit 785ee3d34700a5d5610a1f6c522623bc56205732
Author: Namhyung Kim <namhyung@kernel.org>

perf tools: Remove redundant chroot handling

This commit removes dso__filename_with_chroot() and filename_with_chroot()
along with their fallback callers in dso__get_filename() and dso__load(),
relying on nsinfo__mountns_enter() to enter the target process's chroot.

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index ce98613868e7d..4331b48505b2b 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -585,11 +585,6 @@ static int do_open(char *name) EXCLUSIVE_LOCKS_REQUI=
RED(_dso__data_open_lock)
>  	return -1;
>  }
> =20
> -char *dso__filename_with_chroot(const struct dso *dso, const char *filen=
ame)
> -{
> -	return filename_with_chroot(nsinfo__pid(dso__nsinfo_const(dso)), filena=
me);
> -}
> -
>  char *dso__get_filename(struct dso *dso, const char *root_dir, bool *dec=
omp,
>  			enum dso_binary_type type)
>  {
> @@ -603,28 +598,8 @@ char *dso__get_filename(struct dso *dso, const char =
*root_dir, bool *decomp,
>  	if (dso__read_binary_type_filename(dso, type, root_dir, name, PATH_MAX))
>  		goto out;
> =20
> -	if (!is_regular_file(name)) {
> -		struct stat st;
> -		char *new_name;
> -
> -		/*
> -		 * errno only reflects the failure reason when stat() itself
> -		 * failed: a successful stat() on a non-regular file (e.g. a
> -		 * directory) leaves a stale errno, which a previous failed
> -		 * iteration of the try_to_open_dso() fallback loop may have
> -		 * set to ENOENT.
> -		 */
> -		if (stat(name, &st) =3D=3D 0 || errno !=3D ENOENT ||
> -		    dso__nsinfo(dso) =3D=3D NULL)
> -			goto out;
> -
> -		new_name =3D dso__filename_with_chroot(dso, name);
> -		if (!new_name)
> -			goto out;
> -
> -		free(name);
> -		name =3D new_name;
> -	}
> +	if (!is_regular_file(name))
> +		goto out;

[Severity: Medium]
Are all callers of dso__get_filename() guaranteed to execute inside an
nsinfo__mountns_enter() scope?

While open_dso() -> __open_dso() enters the mount namespace and chroot, the
other callers of dso__get_filename() run outside nsinfo__mountns_enter().
When profiling a chrooted workload whose binaries are not already populated
in the host build-id cache (such as in pipe mode, live mode, or with
perf record -N), is_regular_file(name) in dso__get_filename() checks the
host root filesystem and fails with ENOENT.

Specifically, try_to_open_dso() resolves the binary type before entering the
mount namespace in open_dso():

tools/perf/util/dso.c:try_to_open_dso() {
	...
	__dso__find_binary_type(dso);
	dso_data->fd =3D open_dso(dso, machine);
	...
}

__dso__find_binary_type() -> dso__find_binary_type_locked() calls
dso__get_filename() and filename__has_section(path, ".text") without
calling nsinfo__mountns_enter():

tools/perf/util/dso.c:dso__find_binary_type_locked() {
	...
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

Because dso__get_filename() returns NULL outside the chroot,
dso__find_binary_type_locked() sets dso->binary_type to
DSO_BINARY_TYPE__NOT_FOUND, causing the subsequent open_dso() call in
try_to_open_dso() to fail as well.

Similarly, symbol__disassemble() in tools/perf/util/disasm.c:

	dbt =3D dso__find_binary_type(dso);

	if (dbt =3D=3D DSO_BINARY_TYPE__KALLSYMS)
		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;

	mutex_lock(dso__lock(dso));
	symfs_filename =3D dso__get_filename(dso, "", &decomp, dbt);
	mutex_unlock(dso__lock(dso));

and dso__debuginfo() -> debuginfo__new() -> dso__find_dbginfo_type() in
tools/perf/util/debuginfo.c and tools/perf/util/dso.c:

	dso__find_dbginfo_type(dso);
	path =3D dso__get_filename(dso, "", &decomp, dso__dbginfo_type(dso));
	if (path =3D=3D NULL)
		return NULL;

	dinfo =3D __debuginfo__new(path);

also invoke dso__get_filename(), filename__has_section(), and
__debuginfo__new() without entering nsinfo__mountns_enter().

Should those callers enter the mount namespace via nsinfo__mountns_enter(),
or does dso__get_filename() still need chroot path resolution for callers
that use the returned path outside a mountns scope?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023071141.1341=
49-1-namhyung@kernel.org?part=3D9
