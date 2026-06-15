Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759552D97AA
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560293; cv=none; b=HBVgpbzbszjteZOfgpj6qn3mEeSZog1URU4XPhmd8ZLWKpdbpI/oQHVo2wUADE6digIeg4/Stg0N+WLjqvO8w5SlQ4SLt30UZWsA4kAREq3cwsMLAZZapFMjCdEqkWQGRflF+ESGI/h3PmxSOGnv+MRDp7IcyW/rih2wACXnp5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560293; c=relaxed/simple;
	bh=dGhPlNwlmmUP2a+nPAhr6UtbLlDnbzB4aY4f7fFtfsQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EaTsHFNM+FlpjeHSutvBVHMBpwy/QeT1Vzv/5t8iTVvigGnBqwpP2BcD2QH1o89xdwQJSjj5kbhKgIDU/rco6cqQAza1mhMdRw3G0qFz9kkZ0xVZ7hEBq1nmWwU4W9vwu0epEy0vdP+NEtjEY/bKlbA5qWV/3XoGE/0Hlxx+T8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2fUnu0B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2fUnu0B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87ED1F000E9;
	Mon, 15 Jun 2026 21:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781560292;
	bh=6JHTo2TMThqwCS3Q0c428hFFcuCjH/VbT51lA6ScVhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2fUnu0BqCm4iQiffh9RlErYBrqk0knXY3R+zPlk3/NPY780dc+73ohctVZGJwqJz
	 9nCmIUdpqIbGkT5q/jML5Xv4sGaMbD0P7tzcZW5vrbjizLlJ1FBW0PjFXzzJS+cfWZ
	 2Jh91C7NnWOsSU5X5ZpHvVBfC4sKZ6gc5fEYjiyDBDBDez/+ts62CIIZfX4v49CTBB
	 uxfc28dbSJxpe2gdiK0Y14jO1qZc7KVk74XCbaDRtzfoTGX2b27h/0Wnj7jKebnH7Z
	 xir8Isx53DpfjFpYAx9cLDMIl4agKs/UMwzCSl+ZfefSRkwmBukyGxgtoGp3Ad6zDB
	 Z5lRZoxgRPWtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] perf machine: Use snprintf() for guestmount path
 construction
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260615213657.35776-3-acme@kernel.org>
References: <20260615213657.35776-3-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:51:31 +0000
Message-Id: <20260615215131.E87ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional memory leak of `dirent` elements returned by `scandi=
r()`.
- [High] NULL pointer dereference when `strlist__new()` fails.
- [High] NULL pointer dereference when `machine__findnew_thread()` fails to=
 allocate a parent thread.
- [Medium] Loop iteration logic bug causes silent skipping of valid guest V=
M directories if one directory is inaccessible.
- [Medium] File descriptor leak on an early error return during nested dire=
ctory processing.
- [Medium] Improper error handling missing `errno =3D 0` before `strtol()` =
can cause valid PIDs to be skipped.
--

commit 02cca33a0758d115755760c916ffc005383e2736
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Use snprintf() for guestmount path construction

This commit replaces sprintf() with snprintf() when constructing guestmount
paths. This prevents potential stack buffer overflows caused by unbounded
user-provided guestmount lengths.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 7cf20ace3dbb5..fb960fda55f4f 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -334,7 +334,7 @@ struct machine *machines__findnew(struct machines *ma=
chines, pid_t pid)
>  	if ((pid !=3D HOST_KERNEL_ID) &&
>  	    (pid !=3D DEFAULT_GUEST_KERNEL_ID) &&
>  	    (symbol_conf.guestmount)) {
> -		sprintf(path, "%s/%d", symbol_conf.guestmount, pid);
> +		snprintf(path, sizeof(path), "%s/%d", symbol_conf.guestmount, pid);
>  		if (access(path, R_OK)) {
>  			static struct strlist *seen;

[Severity: High]
This is a pre-existing issue, but can this cause a null pointer dereference
if strlist__new() fails?=20

Looking just below this in machines__findnew():

			if (!seen)
				seen =3D strlist__new(NULL, NULL);

			if (!strlist__has_entry(seen, path)) {

If memory allocation fails, seen becomes null, and it is immediately passed
to strlist__has_entry() which might try to dereference it.

[ ... ]
> @@ -1261,9 +1261,9 @@ int machines__create_guest_kernel_maps(struct machi=
nes *machines)
>  					 namelist[i]->d_name);
>  				continue;
>  			}
> -			sprintf(path, "%s/%s/proc/kallsyms",
> -				symbol_conf.guestmount,
> -				namelist[i]->d_name);
> +			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
> +				 symbol_conf.guestmount,
> +				 namelist[i]->d_name);
>  			ret =3D access(path, R_OK);
>  			if (ret) {
>  				pr_debug("Can't access file %s\n", path);

[Severity: Medium]
This is a pre-existing issue, but should this loop continue instead of
failing completely? Looking just below this in
machines__create_guest_kernel_maps(), the code jumps to the failure label:

				goto failure;
			}
			machines__create_kernel_maps(machines, pid);

By jumping to the failure label, it seems we skip processing all remaining
valid guest directories if just one is inaccessible.

While reviewing this file, I noticed a few other pre-existing issues:

[Severity: Medium]
This is a pre-existing issue, but does this correctly handle errno?

tools/perf/util/machine.c:machines__create_guest_kernel_maps() {
...
			pid =3D (pid_t)strtol(namelist[i]->d_name, &endp, 10);
			if ((*endp !=3D '\0') ||
			    (endp =3D=3D namelist[i]->d_name) ||
			    (errno =3D=3D ERANGE)) {
...
}

The code checks if errno is ERANGE, but errno isn't set to 0 before calling
strtol(). Could a previous operation leave errno as ERANGE, causing valid
PIDs to be skipped here?

[Severity: High]
This is a pre-existing issue, but does this leak the individual directory
entries returned by scandir()?

tools/perf/util/machine.c:machines__create_guest_kernel_maps() {
...
failure:
		free(namelist);
	}

	return ret;
}

The namelist array is freed here, but it looks like the individual struct
dirent pointers allocated by scandir() and stored in namelist[i] are never
freed before the array itself is freed.

[Severity: High]
This is a pre-existing issue, but in machine__process_fork_event(), is it
possible to dereference a null pointer if thread allocation fails?

tools/perf/util/machine.c:machine__process_fork_event() {
...
	struct thread *parent =3D machine__findnew_thread(machine,
							event->fork.ppid,
							event->fork.ptid);
	...
	if (thread__pid(parent) !=3D (pid_t)event->fork.ppid) {
...
}

If machine__findnew_thread() returns null due to memory pressure, it seems
the pointer is accessed without a check.

[Severity: Medium]
This is a pre-existing issue, but does maps__set_modules_path_dir() leak a
file descriptor on an early return?

tools/perf/util/machine.c:maps__set_modules_path_dir() {
...
	io_dir__init(&iod, open(path, O_CLOEXEC | O_DIRECTORY | O_RDONLY));
	...
	/* Bounds check, should never happen. */
	if (root_len >=3D path_size)
		return -1;
...
}

If the bounds check fails, the function returns immediately and skips the
close() call for the directory file descriptor.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615213657.3577=
6-1-acme@kernel.org?part=3D2
