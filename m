Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DC33D6DD
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Jul 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109847; cv=none; b=S5shx7ZO2azOp3L4XRKmLNSDHJlupifR7GxP2FMH8tx9eMEworDaLriLsDsJFYgns0bC9ID4F858ia6+Gj+J7fHmclAvG30QlxBkDZPI52I5CNwOG+oecqscZe94Xc7OBXe06TGrwYAhxIb5OwREZyqVTQ7FAVc3n4BvRZPApsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109847; c=relaxed/simple;
	bh=+9Y9mdzYNarI/Ne8ZgEjAG+8paVdSQUcV1v5uJq+cVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K9wAtKmGxIYR6r6R7O4KDeCF+ZxPsqyfoeoXxU1RndQSnj8eg1S2kjsg895xdc9MV3+cViFH4eKETIJxcH3i3qwC2PeTPqJElijXhE8B+K0S1iE3PiX0sQj5ERa86i6mFyTOe155XmAjIWDRon0vh7EFjOc56PfFt2H5irqHwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsEAXDZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsEAXDZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0E21F000E9;
	Sun, 26 Jul 2026 23:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109845;
	bh=t2Q/yDB7vretBvXJRJw/o3B3QlOHCAj+bCnmRmgpP0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LsEAXDZA4SaqPB2Yiio5mCqcfDs4+kD0Xn0D5pZVyXdfwdI7RrolLtGnINwfJXYay
	 fsxs+kGgSng/elo5u3nJwomPm6bWosoXZ7CDvyg5YDDAesjmN/FGd4FuQHTU8iQedk
	 xxkFHOvktGh1sbWoI5TS3455NM7sNQpP2SmL3eIlwGacD+IhW+JeP+9Wnbpg+5RSw5
	 kWgBQNiYroEzk0cgMOwRRRdKclgcgbDyl1quyB+dwnKEzqze7owV7g9sxwlz5HufLb
	 S81kuw3XQnqed3iRENIGX6I89kP10HyCf7mrwlX/vth3RXY+4EUp9cj6y6I0usxSqS
	 NvlufZ+Xjyhug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] perf machine: Don't abort guest map creation on
 first inaccessible dir
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260726234014.63111-6-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
 <20260726234014.63111-6-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 23:50:45 +0000
Message-Id: <20260726235045.AA0E21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] errno is checked for ERANGE after calling strtol() without explici=
tly clearing it to 0 beforehand, causing a logic error where one invalid di=
rectory skips all subsequent valid guest directories.
--

--- Patch [5]: [PATCH 5/8] perf machine: Don't abort guest map creation on =
first inaccessible dir ---
commit 3942aff28b363eb417be58b368d8c95bd54e8551
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf machine: Don't abort guest map creation on first inaccessible dir

machines__create_guest_kernel_maps() is modified to use 'continue'
instead of jumping to a failure label when a guest directory's
kallsyms file is inaccessible. This allows the loop to process
remaining valid guest directories rather than aborting early.

> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 05724277c2a97..83d38637afe34 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1269,14 +1269,12 @@ int machines__create_guest_kernel_maps(struct mac=
hines *machines)

[Severity: High]
This is a pre-existing issue, but does this loop correctly handle errno
after a failed strtol() call?

Looking at machines__create_guest_kernel_maps(), the loop checks errno
for ERANGE after calling strtol(), but there doesn't appear to be an
explicit reset of errno beforehand:

tools/perf/util/machine.c:machines__create_guest_kernel_maps() {
    ...
    pid =3D (pid_t)strtol(namelist[i]->d_name, &endp, 10);
    if ((*endp !=3D '\0') ||
        (endp =3D=3D namelist[i]->d_name) ||
        (errno =3D=3D ERANGE)) {
    ...
}

If a directory name causes an overflow (e.g., exceeding LONG_MAX), strtol()
sets errno to ERANGE. In the next loop iteration, if errno is not cleared
to 0, it will retain the ERANGE value. When strtol() processes a valid PID,
it succeeds, but the (errno =3D=3D ERANGE) check evaluates to true, causing=
 the
valid directory to be incorrectly skipped.

Since this loop processes directories from guestmount, could an unprivileged
user create a bogus directory to prevent symbol resolution for all subseque=
nt
guests?

>  			snprintf(path, sizeof(path), "%s/%s/proc/kallsyms",
>  				 symbol_conf.guestmount,
>  				 namelist[i]->d_name);
> -			ret =3D access(path, R_OK);
> -			if (ret) {
> +			if (access(path, R_OK)) {
>  				pr_debug("Can't access file %s\n", path);
> -				goto failure;
> +				continue;
>  			}
>  			machines__create_kernel_maps(machines, pid);
>  		}
> -failure:
>  		free(namelist);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726234014.6311=
1-1-acme@kernel.org?part=3D5
