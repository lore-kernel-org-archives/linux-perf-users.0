Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F802EDD58
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788119040; cv=none; b=qj8CTWelRULmXqiuF7MEZznfzf8ANAEcje0NmEhuhKSEKRhfNdBPlw3V4bVSeNtPfHwqoOObB7IxyS4P45WaivhbQbKcasL21NtBVfGGZjlNRqN+FlIXjvoumD9O6V/GK8uXmXPXGIlOUZlK3O6chSCmIK4WapHgO6gGvGy2FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788119040; c=relaxed/simple;
	bh=Jh3p5nAUrVPZ7tZfsvYKG8T6UOlBJ2S6fuvONxUZ3lU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LUDKY80aU1kCqvedI1bm3GBubHGwmwIJSrA0h6fRUyJ9P1EEDkpt7KhHqRWEPM9g+prVIb/aXXi0iF2Ii9OmMdRMbhj+NN9E64huX62TRgB4LyMdC1SoytMpMneP3odV/y9DhoEyXQ8l/MiA5w+mlOVV8H2DN8OTw/npHh47ZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn5wwNPT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn5wwNPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0584A1F000E9;
	Sun, 30 Aug 2026 19:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788119038;
	bh=taWMtPJOMUIFvjjAIDtC3BXttZFxqrOtTujatJie5NM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kn5wwNPTnUCa4ajm4ibbzzECU+iRXElXMXxDfdwWu04T1d1Un8lShD5cvMsTXENWw
	 NB/Fcs/lGRaNZepeb/kxEEujIX1zXonsi9empKh6F96fRk7FJ075hwjqSm4ChL0i5Y
	 807ZtUhC73rSKzkLsEqPkUfgFg9IafGEBdST0PzuJgVRW/h9gFCGHoRHtwB2l74Dx8
	 Ren5yAMOk9yoOX7b6/WaUbV1lBiXZk05Bho8hQncT3d6sEagWtUk+mXzlPgCyZETuU
	 zTJOlXNAw5D9axVUk3+xGxnE5hMmyIH6ya1vRp4UKIQooCrUgyQrNBkLMBexc9zu4r
	 Y0ih059bPgvew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] perf tools top: Add --weight option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andi Kleen" <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260830193459.2840519-3-ak@linux.intel.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
 <20260830193459.2840519-3-ak@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 19:43:57 +0000
Message-Id: <20260830194358.0584A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Buffer overflow or NULL pointer dereference in for_each_drm_fdinfo=
_in_dir() due to unchecked reallocarray() failure.
- [High] Use-After-Free and memory leak in add_event() when strndup() fails.
--

commit f1674c1fafe728985095507f0cfd95caa7a7179c
Author: Andi Kleen <ak@linux.intel.com>

perf tools top: Add --weight option
   =20
Add a -W/--weight option to perf top to collect weights too. Useful with
follow on patches.

> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documenta=
tion/perf-top.txt
> index af3e4230c72f4..2da2a16bbf260 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -25,6 +25,12 @@ OPTIONS
>  --count=3D<count>::
>  	Event period to sample.
> =20
> +-W::
> +--weight::
> +Enable weighted sampling. One or more additional weights can be recorded=
 per sample

[ ... ]

While reviewing this, I noticed some pre-existing issues in
tools/perf/util/drm_pmu.c:

tools/perf/util/drm_pmu.c:for_each_drm_fdinfo_in_dir() {
    ...
		if (minors->minors_num =3D=3D minors->minors_len) {
			unsigned int *tmp =3D reallocarray(minors->minors, minors->minors_len + =
4,
							 sizeof(unsigned int));

			if (tmp) {
				minors->minors =3D tmp;
				minors->minors_len +=3D 4;
			}
		}
		minors->minors[minors->minors_num++] =3D minor;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this code write out of bounds or
dereference a NULL pointer?

If reallocarray() fails, tmp is NULL, so minors->minors and minors->minors_=
len
are not updated.

However, the function proceeds to unconditionally assign minor to
minors->minors[minors->minors_num++].

If the array was initially NULL, this dereferences a NULL pointer. If it was
already allocated, this writes past the end of the un-resized buffer.


tools/perf/util/drm_pmu.c:add_event() {
    ...
	tmp =3D reallocarray(*events, *num_events + 1, sizeof(struct drm_pmu_event=
));
	if (!tmp)
		return -ENOMEM;
	tmp[*num_events].unit =3D unit;
	tmp[*num_events].desc =3D desc;
	tmp[*num_events].name =3D strndup(line, colon - line);
	if (!tmp[*num_events].name)
		return -ENOMEM;
	(*num_events)++;
	*events =3D tmp;
	return 0;
}

[Severity: High]
This is a pre-existing issue, but does this code leave a dangling pointer a=
nd
leak memory when strndup() fails?

If reallocarray() succeeds and moves the memory block, the old memory point=
ed
to by *events is freed.

If strndup() then fails, the function returns -ENOMEM without updating
*events to point to tmp.

This leaks the newly allocated tmp block and leaves *events as a dangling
pointer to the old, freed memory block.

Since the caller read_drm_pmus_cb() ignores the return value of add_event()
and continues parsing, a subsequent match could pass this dangling *events
pointer back into reallocarray(), triggering a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830193459.2840=
519-1-ak@linux.intel.com?part=3D2
