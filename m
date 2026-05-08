Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACF35C1B1
	for <linux-perf-users@vger.kernel.org>; Fri,  8 May 2026 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243459; cv=none; b=GdShbsB1ebiAiGn3JUIVF6jfQJuPFnu/RyqGNVhAksvsShtYMz1XEPBNrLHs/rRJPXuR0HbShyFgt6dQbOjkWNE+zpoNkIGbVFYwtYtnks7u51ecmcXOy9h5pqy6ZIWWu7bzcHdTrZv16Hs4O69emg2iYbzTCwL7NngU450MWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243459; c=relaxed/simple;
	bh=NccT4MRc27AVbj5ZIoC/grcEYsU4ip7hwwnrNGPUSOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ooZhnVJtZ/10UUP/KiJ8urCih2GAlNYl0u5ln5xg076lxz0cNY2QBs0bGKGZR0JnmxlRo6fRiTIs9r1VvgoDydI+4C4sjRSAeuymyGKOzNerQqUOPmBv/XXTHmVOrn9B7WoGVZMkMmRjftPTzE32gDlvCpH0FvwJmqP44KPi6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB1+g6bx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB1+g6bx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314F1C2BCB0;
	Fri,  8 May 2026 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243459;
	bh=NccT4MRc27AVbj5ZIoC/grcEYsU4ip7hwwnrNGPUSOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JB1+g6bxt+zXSzvnIeFExhlgTi1NHPWNukuvezIvvHRskFhcsnhKySMog9zigBFUf
	 AA0yW8WhZ5OmmI1V+qgsPps92lJXcPuFtoQahGc6QzuDFbzc2BP7zMMCGy/MbBUjEG
	 N9kMll9kxYSPWZOmW68t5Q6IeUM3ovt+e+bsF77gyaKObyemADRgI90JECXr/wPASe
	 ACZBXFrEN63749ZhUUTL+HDoiWN7mWptOU4Qz6GmT5HV1KlbpzKGJRK0c7vGGVY019
	 m/IFDQKyrbiKk0p9fpj8jdbg0eDZ5bU/y5C3rSCk2iHDLUOPTX/Suqb1QKGkxpyZN6
	 Iln3p4Advqm9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] perf trace: Update beautifier script for clone
 flags
Reply-To: sashiko@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507072632.37152-8-namhyung@kernel.org>
References: <20260507072632.37152-8-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 12:30:58 +0000
Message-Id: <20260508123059.314F1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The beautifier script regex update drops all legacy clone flags (0=
-31), breaking flag decoding for standard `clone()` syscalls.
- [High] Processing clone flags with indices >=3D 32 in `strarray__scnprint=
f_flags()` causes Undefined Behavior on 32-bit platforms, leading to incorr=
ect flag decoding.
--

commit 47293f130dab2e91781452bd39a472811835f8a9
Author: Namhyung Kim <namhyung@kernel.org>

perf trace: Update beautifier script for clone flags

This commit updates the clone_flags beautifier script to parse the new bit
shift definitions in sched.h. It changes the regex to match the 1ULL bit
shift pattern instead of the previous hexadecimal values.

>   $ cat tools/perf/trace/beauty/generated/clone_flags_array.c
>   static const char *clone_flags[] =3D {
>         [32 + 1] =3D "CLEAR_SIGHAND",
>         [33 + 1] =3D "INTO_CGROUP",
>         [34 + 1] =3D "AUTOREAP",
>         [35 + 1] =3D "NNP",
>         [36 + 1] =3D "PIDFD_AUTOKILL",
>         [37 + 1] =3D "EMPTY_MNTNS",
>   };

When the array has entries up to index 38, does this cause an issue on 32-b=
it
builds of perf?

Looking at strarray__scnprintf_flags(), it computes the flag bit using:

    unsigned long bit =3D 1UL << (i - 1);

On 32-bit platforms, unsigned long is 32 bits. Shifting by 32 or more invok=
es
undefined behavior. On architectures like x86, the shift amount is masked
(e.g., modulo 32), so 1UL << 32 evaluates as 1UL << 0.

Could this cause perf trace to erroneously report clone3 flags like
CLEAR_SIGHAND whenever unrelated lower bits are set?

> diff --git a/tools/perf/trace/beauty/clone.sh b/tools/perf/trace/beauty/c=
lone.sh
> index 18b6c0d756937..f807372519fe2 100755
> --- a/tools/perf/trace/beauty/clone.sh
> +++ b/tools/perf/trace/beauty/clone.sh

[ ... ]

>  printf "static const char *clone_flags[] =3D {\n"
> -regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnu=
m:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> +regex=3D'^[[:space:]]*#[[:space:]]*define[[:space:]]+CLONE_([^_]+[[:alnu=
m:]_]+)[[:space:]]+\(1ULL[[:space:]]*<<[[:space:]]*([[:digit:]]+)\)[[:space=
:]]*.*'

Does this new regex miss the legacy clone flags?

In include/uapi/linux/sched.h, legacy flags like CLONE_VM, CLONE_FS, and
CLONE_THREAD are still defined using hexadecimal notation.

Since the updated regex strictly requires the (1ULL << digit) format,
it appears all lower 32 flags are excluded from the generated
clone_flags_array.c.

Could this prevent perf trace from translating standard clone flags into
human-readable strings?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507072632.3715=
2-1-namhyung@kernel.org?part=3D7
