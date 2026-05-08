Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA64135C1B1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243458; cv=none; b=adsVN2pfm8rOlGtyOIXvY5BL3X+oGbW2ufwQd9mjhXB9RinubLObkpnlJSuGWCmLV9n+k325bDAXqWMuOSJsfHDjYPuItWZlljCcViSqp19IHvalTvnBvVRsFJ6NOucrj0BsQnGQ+fTuAngYngjYC4IXvK5UD+Dj4k5ULlC2KYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243458; c=relaxed/simple;
	bh=YfbbdsJrhnsOBnnt7eOQL2zjxHcG/jSm7sP3bTlqLnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAKwLGkthiDYdnSLjLDg390z9ljAWeYoTGhfr88/tVA82s67WeducVb/ZS23thrGbNhecCWayediT+MJxhP5TtRApjgPUgq2N+YdPgmMTrp4zI4mulvekLJ5ch+YJCzzaKYOJqgDhV3XYsRjX9zCTqhgPhwc6o1o2q0e7P4u+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+jhw23P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+jhw23P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65338C2BCF5;
	Fri,  8 May 2026 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243458;
	bh=YfbbdsJrhnsOBnnt7eOQL2zjxHcG/jSm7sP3bTlqLnE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U+jhw23PY0F2+POKXrIl/r81r1Wp2003AEgc2sdNCI2rxRxZ32l5XwisJCstaKkJ6
	 oSr0NOSeqqstHFUJRUL73zkHY5tfXOmgUHb538N2CxhPKwx9V0kjQ5yKFkyCCJpyYc
	 mbIPe9QfeucDDt173AX5NpwWeMISokZf3xhA1IkGuuFlWe1m4jhUiE7pABBPiPPrno
	 w1HTV6NR5rdYXmKmzBnCiZSfvMXN8yak/hLcdOh4xzgosRq0fQB6rkZmlkk4YSPrre
	 PcWM3NvBqwO/JQ/LkoHV2sNr/DBDlh4YPYQFEFxlzrF8Vg1gcai2N5KebiC8f2X9ZU
	 rOgi7S1+qMNKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] perf trace: Add beautifier script for fsmount
 flags
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507072632.37152-7-namhyung@kernel.org>
References: <20260507072632.37152-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 12:30:57 +0000
Message-Id: <20260508123058.65338C2BCF5@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The replacement of STRARRAY_FLAGS with a custom formatter initia=
lization silently drops the `.strtoul` handler and `.show_zero` property fo=
r the `fsmount` flags argument.
- [Low] The newly generated `fsmount_attr_arrays.c` file is not removed dur=
ing `make clean`.
- [Low] The commit message falsely claims that the source file `fsmount.c` =
was renamed.
--

commit 3df6eed17e58d1e1ddb3e75a7cd7fc70c8f3735f
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Add beautifier script for fsmount flags

This commit updates the fsmount beautifier to generate fsmount_flags[]
directly from mount.h. It also splits out the attribute flags generation in=
to
a separate fsmount_attr.sh script.

> And rename the existing one to fsmount_attr.{sh,c} to be more precise.

This isn't a bug, but the commit message says fsmount.c was renamed to
fsmount_attr.c, while the patch only modifies fsmount.c without renaming it.

Should the commit message be updated to reflect this?

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -564,6 +564,12 @@ fsmount_tbls :=3D $(srctree)/tools/perf/trace/beauty=
/fsmount.sh
>  $(fsmount_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_tbls)
>  	$(Q)$(SHELL) '$(fsmount_tbls)' $(beauty_uapi_linux_dir) > $@
> =20
> +fsmount_attr_arrays :=3D $(beauty_outdir)/fsmount_attr_arrays.c
> +fsmount_attr_tbls :=3D $(srctree)/tools/perf/trace/beauty/fsmount_attr.sh
> +
> +$(fsmount_attr_arrays): $(beauty_uapi_linux_dir)/mount.h $(fsmount_attr_=
tbls)
> +	$(Q)$(SHELL) '$(fsmount_attr_tbls)' $(beauty_uapi_linux_dir) > $@

Does the clean target in Makefile.perf need to be updated to remove the new
fsmount_attr_arrays.c file? Without it, the generated file might be left
behind during a make clean operation.

> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
[ ... ]
> @@ -1202,7 +1197,7 @@ static const struct syscall_fmt syscall_fmts[] =3D {
>  	{ .name     =3D "fsconfig",
>  	  .arg =3D { [1] =3D STRARRAY(cmd, fsconfig_cmds), }, },
>  	{ .name     =3D "fsmount",
> -	  .arg =3D { [1] =3D STRARRAY_FLAGS(flags, fsmount_flags),
> +	  .arg =3D { [1] =3D { .scnprintf =3D SCA_FSMOUNT_FLAGS, /* fsmount_fla=
gs */ },
>  		   [2] =3D { .scnprintf =3D SCA_FSMOUNT_ATTR_FLAGS, /* attr_flags */ }=
, }, },

Does replacing STRARRAY_FLAGS drop the .strtoul parser and .show_zero
properties?

The original STRARRAY_FLAGS macro assigned .strtoul =3D STUL_STRARRAY_FLAGS=
 and
.show_zero =3D true. By dropping these, does perf trace lose the ability to
parse symbolic names for the fsmount flags argument, such as during filter
expressions like -e 'fsmount(flags=3D=3DCLOEXEC)'?

Additionally, without .show_zero =3D true, will a flags value of 0 be skipp=
ed in
the output, causing positional ambiguity with the remaining trailing
arguments?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507072632.3715=
2-1-namhyung@kernel.org?part=3D6
