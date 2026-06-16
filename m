Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF83C4167
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577878; cv=none; b=JzA1euzXgfRZyYjLMGARfk3XoEbhO6XDikMyLWSpNzFiNfOiGrl+Vt+wwbBefKVBlD5IDZzyIrn35A8bYLjiL3TaiF3J907TxNX8C8FkLiBYcSAFtd440vRtWTETInwNDNML9Qexn0AMgy2kUc8OBNkY9rFiX9IQJZPhG3tb/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577878; c=relaxed/simple;
	bh=i3aW8bOVe0DKa3SfpOWPSibjFapgJ3jgQcqI0JxKxj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eF4xzwvHJ+ITdNpBdOfJ3HfbRm+meN2ElwoHeS3Cp3YvANtfwEkVMXDtAr+fp9BxvBcVP395NNBq1lvWJbj5qZhNeXkhhb5lZVcU0Bg+q76n2kL6o3SwkLSswo5I+gVPS+Ame9oW9D1RBWKHjqOedA7WYBceIL1b2DLDRLEUw2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaF1drms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaF1drms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D8A1F01569;
	Tue, 16 Jun 2026 02:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781577872;
	bh=9ZXqv6pG03xdEiQqyXjm0nN8XNFIAEd/t7frq5WDZWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aaF1drms6HRU9H+JFMcU8gVKGAQtvk7AvAFRsehqZK/dfJcCGok1XcId3yDGYcFjS
	 w+uOvwxt5O3zPu6OlfghOyCwaP2kyFXmxCZOtEQ9PmNqgj3g+wvKJCbga45864A5EM
	 qGn95HmikaVqvYGhGhLAdomSD7ss3qaTebbybJ74PfSeInCQKWGqoSizOXnGbHgP2M
	 2dnF5pQ7znClSzntzYGpKRZ/rYmpbba7Psa5as4HzZld+xusxDJgiY3kGuUUG52Tjd
	 L3hEfHTguqD9zVLR2KFncxN+b7w3zchP0d92cZwPdwM1hcjJlrSE6lne2HlqJ0Nbj8
	 Y+6jl/wbEutdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] perf dso: Set standard errno on decompression
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260616022715.5739-10-acme@kernel.org>
References: <20260616022715.5739-10-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 02:44:32 +0000
Message-Id: <20260616024432.56D8A1F01569@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If `dso__get_filename()` returns NULL without explicitly setting `=
errno` (e.g., when the target path is a directory and `is_regular_file()` r=
eturns false without altering `errno`, or when `dso__has_build_id()` is fal=
se), `__open_dso()` computes `fd =3D -errno`, resulting in `fd =3D 0`. The =
subsequent check `if (fd >=3D 0)` in `open_dso()` incorrectly treats this a=
s a successful open and registers standard input (fd 0) as the DSO data fil=
e descriptor.
- [High] Under `REFCNT_CHECKING`, `dso__list_del()` removes a DSO from the =
open list and temporarily unlocks `_dso__data_open_lock` before decrementin=
g `dso__data_open_cnt`. This breaks the invariant between the list length a=
nd the counter. If a concurrent thread calls `close_first_dso()`, it observ=
es `dso__data_open_cnt > 0` but reads from an empty list.
--

commit 6181e27c050bdb8f633dfde54842ef5d8d538b5a
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf dso: Set standard errno on decompression failure

dso__get_filename sets errno to a negative custom DSO_LOAD_ERRNO value
when kernel module decompression fails. The caller __open_dso then computes
fd =3D -errno, producing a large positive value that looks like a valid file
descriptor. This commit sets errno to EIO instead to avoid incorrectly
closing unrelated file descriptors.

Fixes: 1d6b3c9ba756a513 ("perf tools: Decompress kernel module when reading=
 DSO data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 79f1a30f3683d..2309196d8df31 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -600,7 +600,13 @@ static char *dso__get_filename(struct dso *dso, cons=
t char *root_dir,
>  		size_t len =3D sizeof(newpath);
> =20
>  		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
> -			errno =3D *dso__load_errno(dso);
> +			/*
> +			 * Use a standard errno value, not the negative custom
> +			 * DSO_LOAD_ERRNO stored in dso__load_errno(dso):
> +			 * __open_dso() computes fd =3D -errno, so a negative
> +			 * errno produces a positive fd that looks valid.
> +			 */
> +			errno =3D EIO;
>  			goto out;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but since we are fixing errno
handling here, could a similar issue occur earlier in dso__get_filename
when it fails without explicitly setting errno?

If stat succeeds on a directory, errno is 0 but S_ISREG fails.
is_regular_file returns false and errno remains 0, jumping to out:

tools/perf/util/dso.c:dso__get_filename() {
    ...
	if (!is_regular_file(name)) {
		char *new_name;

		if (errno !=3D ENOENT || dso__nsinfo(dso) =3D=3D NULL)
			goto out;
    ...
}

In this case, __open_dso computes fd =3D -errno, resulting in fd =3D 0:

tools/perf/util/dso.c:__open_dso() {
    ...
	name =3D dso__get_filename(dso, machine ? machine->root_dir : "", &decomp);
	if (name)
		fd =3D do_open(name);
	else
		fd =3D -errno;
    ...
}

Then open_dso incorrectly treats this as a successful open and registers
standard input as the DSO data file descriptor:

tools/perf/util/dso.c:open_dso() {
    ...
	fd =3D __open_dso(dso, machine);
	if (fd >=3D 0) {
		dso__list_add(dso);
    ...
}

Could this lead to resource hijacking or blocking on stdin?

[Severity: High]
This is another pre-existing issue, but I noticed a potential race condition
with the DSO lists.

Under REFCNT_CHECKING, dso__list_del removes a DSO from the open list and
temporarily unlocks dso__data_open_lock before decrementing the counter:

tools/perf/util/dso.c:dso__list_del() {
    ...
	list_del_init(&dso__data(dso)->open_entry);
#ifdef REFCNT_CHECKING
	mutex_unlock(dso__data_open_lock());
	dso__put(dso__data(dso)->dso);
	mutex_lock(dso__data_open_lock());
#endif
	WARN_ONCE(dso__data_open_cnt <=3D 0, ...);
	dso__data_open_cnt--;
    ...
}

If a concurrent thread calls close_first_dso, it checks the counter rather
than checking if the list is empty:

tools/perf/util/dso.c:close_first_dso() {
    ...
	dso_data =3D list_first_entry(&dso__data_open, struct dso_data, open_entry=
);
#ifdef REFCNT_CHECKING
	dso =3D dso_data->dso;
#else
	...
	close_dso(dso);
    ...
}

Because dso__data_open_cnt is greater than zero even when the list is
empty, list_first_entry computes an invalid pointer from the list head.
This causes dso_data->dso to evaluate to the address of
dso__data_open_cnt, treating the integer as a struct pointer and
dereferencing it.

Can this result in a concurrent segmentation fault under REFCNT_CHECKING
builds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616022715.5739=
-1-acme@kernel.org?part=3D9
