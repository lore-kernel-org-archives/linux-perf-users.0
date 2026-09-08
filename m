Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B38583AD9
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888864; cv=pass; b=kObu5vcvhcwVRo+54oRXxampG45yRTDZOx+kGOjc0+1vL6mrp/o+Dbrkd0Poa5itLjPlM8Lw4H9eSLlx9Q1BlTqzXB+naWDQvc/rR14EhMakS/jP85ZnWewsa8/8JUyCYyF2Mf/rfjXWG05zmA5LTOLh+8Htb7+xjMPF4X+9nxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888864; c=relaxed/simple;
	bh=Kpsdib3yveLvtr+TwAAnvePLKmzzJ6hy8KzpROZRl7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPUic/R1CHMpfzraMGKmlKqV7qi+/lrNlShs0RjnmvVXSyrK38kjmWcmfISSykfl03x17/sJUCr1dFBsvHSPFBgL57rQCz0vO7ULHzUoRD5LeWSVWIY2Y9cOKlIzP2aem3yvmJ8H6Ep6+KmAILShFw1Ixs0r8l+7RemPQ/yiMHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PW1j1Scu; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PW1j1Scu"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so630151cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 10:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788888860; cv=none;
        d=google.com; s=arc-20260327;
        b=XeN10Ro4p9B8XeQX10lGmEuViYLRPXLsuMgMkViEYbyJrifYjKKZgvVxZc76x0wEiJ
         fA1/32ZB+0xPl/8PO3qGfQTYI7JyyY2t171rRvCpOeTGxNBQt5I9t6mBzsevw22bqoOC
         5J9FfwG7m2+uL5jLkon75SyGtBkZiHz0HWMFYrgCTz3z7yED7SmkKlJJh82byHV5g8eZ
         RgoQ+sZ4AvgopvVFylS3ZbORg4xNsz/Ekf1qj1gb5UlgNGR/XAIfSqgqzsy8DHJzQYQb
         wj0gdDxfGc0YIMSdau4svgeOB/1v/Gs1g/X/0YFpNBMGuq0tNL4aH45KRsBqCHIYIHGr
         bQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=omWZRuBXmshwMIMUzDzFqHdcDfrk6JUnymxZAFhWUNA=;
        fh=ExWP6lFfh5Ti+unGiJsSR4LsZwwpZnhjiztvv3R+cU0=;
        b=hDiGYlZrwxDsFx/n3CuJqAROS7Q89cMX+oHqkIA7ftdS6xKt2Ylq4lSDxiyBX8xdux
         4f6h7Y2ngmGCh1cU5H2zRpZaHCI0tsCOyx06eEMtHfLdqTtx5mG331wI1htTh1ZtVIyn
         BuPoD9wDip2nZS2VEyKBSFlKmhOO2HWXlx97JUyZtHcco8w7w71Aq+Go79bJanPicegh
         XC+Px+mWPcskOpzEoF0zuSQqhRW9wx/OFACx/fXJHVfzRcZG/YoTuQGmSlCMEnNtX32+
         xJcPn+gNaXoCPbDFS5KyvsKB6VJrd3GvHqpLGxL2vG8l7dkgljYZxW04IwToCLEQ2Ibo
         7n1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788888860; x=1789493660; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=omWZRuBXmshwMIMUzDzFqHdcDfrk6JUnymxZAFhWUNA=;
        b=PW1j1Scum4R6ZOlP90lmIi2jkn/N8nfed7CL+rSoYHNGLjDt8qXzMCaw4J+kEsJbvG
         y+p56y+5dLWOtLFQ/76/9CgoQGWppj0N5goAOZjKX1QoCJpsyAW4c7Im2WFnwETsfuZP
         wWJBKQc4jKyYm8C4aGv8UgNFK2haSYJ9rV6oIG62tJnC/P34FO8unfOdKM6nDSJ/5wDA
         4iH+PdKFDiFXLUIZyey0RWHj9hq/k/NsgYX2VD7fIMWf97kzHybvbg1z13G5atDx9Rtc
         tIm39IV0NkdXX8KokIgFGXPIanf6XlQg6hMfA/w5O405Wh0TcjhZEqG/cWLPADYFNdfD
         IHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888860; x=1789493660;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=omWZRuBXmshwMIMUzDzFqHdcDfrk6JUnymxZAFhWUNA=;
        b=N3NGxUJ/D/Mo72Jo6khb4vF9taTlVnxjdUDslWgB4yHvZt3A4WSMHu14wymHUgbYN/
         6hInnZiHW9a7vdQToFl8jQ8sJeqbcZeAtfAg1RDx+HUv5kgxP9QQGDhwwa0XVhfmBl0i
         fy9ZFNv6zoI4Tsg0SaKinT0H2q6AZQoeAc1px41eJ+pxp/N88SvPil2QT5GJ25Bg4/X4
         uxEQShYHupbzVn829nJp5lLCqYsr/z73JHpnP38vz9+tLYsbrGUZ39fq6QNLVK37gGlQ
         4xzgelSrdQbH7BpCaZKOo6XsaqBnp9nN4Z6WvcdELDg/SfsXm616SQ7b4CuhPfhHSNxc
         wxZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpS7cB2/dc7ZpM3skESjY79bfv4USIv7+wZ6ff21cj9fRn4zDWWas68Q4b8TCEBCTqiZS/NsKDk5ONxBMtcsdy@vger.kernel.org
X-Gm-Message-State: AFuF++lmfEY8oUip7AXcDqspcNczcn4dbkE2GhGZpJ5Pdn+7ItCvViBy
	HKurlxdeKvQ+lzRzPsWP0YrLGm3tVKo+l1tuiuQBn6v/NT5Jy0fS6NV7p1Z2TaJLSzie2OgAgLl
	RUXhYeGTARy1WE/bRqu7j1tYvNVo5iPCneyYmWVpu
X-Gm-Gg: AYBFou1t7HbcIqBlZfIjdpYEf3ZXsTuun7Oz6EJq22ELW55LFt4Jlucgb3DaEdAmFP9
	oLrPRd+n4LEbTR3TSp20mZcR8ezUJVQLfwgK1ALcOVPULzdG1nx0W9sYgJzzmPaYy7EJgybRSwk
	EtGoZ/FjiCc+HTmDUH1y+fkL/ODnB7zA5ugWUQr5DRImub+Z/K33ZZVfrTbPStw85X7ALVeXGHf
	x+joo56NG0nA/fpbYwxf3B3t/nP+X4YcEMBV/pHnyJL/15nHfHqpMuAZXGGTRgiO5Eihpsh7lnS
	SLlxIxMswqEFKjcnuGqTluqDL5OhD5lez42XIKS7SnI9rq4Y1JPUK9ahGhy1kml6R7zyu29UkQ=
	=
X-Received: by 2002:a05:622a:1e0c:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-53065e23602mr52855001cf.8.1788888859773; Tue, 08 Sep 2026
 10:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-perf-alpha-annotate-v1-0-97380433ccb6@gmail.com> <20260905-perf-alpha-annotate-v1-1-97380433ccb6@gmail.com>
In-Reply-To: <20260905-perf-alpha-annotate-v1-1-97380433ccb6@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Sep 2026 10:34:06 -0700
X-Gm-Features: AcwNN1VnRSeIMSxxTIBjRtlgP36FAJ13oWgxRAbUHx51GtBEhbZN5UuqcIKyc48
Message-ID: <CAP-5=fUb_GEq+A84pa0Kf_4An_XxEedPpAysTWwmt0Vsz6jirw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf thread: Fix live-session detection in thread__e_machine()
To: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:54=E2=80=AFPM Matt Turner <mattst88@gmail.com> wro=
te:
>
> When the per-thread e_machine cannot be determined from the DSOs in the
> thread's maps, thread__e_machine_endian() decides between reading
> /proc/<pid>/exe and falling back to the recorded session environment:
>
>         bool is_live =3D machine->machines =3D=3D NULL;
>
>         if (!is_live) {
>                 /* Check if the session has a data file. */
>                 struct perf_session *session =3D container_of(...);
>
>                 is_live =3D !!session->data;
>         }
>
> Neither half of that works.
>
> The back pointer added by commit a088031c4998 ("perf tools: Add machine t=
o
> machines back pointer") is set by machines__add(), which only ever adds
> guests; the host machine never gets one.  Host-machine threads, which is =
to
> say almost all of them, therefore see machine->machines =3D=3D NULL and a=
re
> declared live before the session is consulted at all.
>
> The session test is also inverted.  A session with a perf_data attached i=
s
> one being read from a perf.data file, i.e. exactly the case that is not
> live, while a live session such as 'perf top' passes data=3DNULL to
> __perf_session__new().
>
> So a file-based session takes the live path and reads /proc/<pid>/exe on
> the analysing host, which at best describes an unrelated process that has
> since been given the recorded pid, and normally just fails, leaving
> e_machine as EM_NONE.  The perf_env fallback that would have supplied the
> recorded architecture is never reached, and thread__e_machine() returns
> EM_HOST.
>
> For a same-architecture recording this is invisible, since EM_HOST is the
> right answer anyway.  Cross-architecture it is not: annotating an Alpha
> perf.data on an x86_64 host selects the x86 struct arch, so the Alpha
> disassembly is matched against the x86 instruction table.  Alpha's 'ret'
> collides with x86's and gets ret_ops, while its calls and branches match
> nothing and are left unparsed, so no call target is resolved and no jump
> arrows are drawn.
>
> Set the back pointer for the host machine and correct the session test.
> The new back pointer does not disturb the other reader of the field,
> machine__findnew_guest_code(), which machine__resolve() only calls when
> !machine__is_host(machine).
>
> Fixes: 70351029b556 ("perf thread: Add support for reading the e_machine =
type for a thread")
> Signed-off-by: Matt Turner <mattst88@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/machine.c | 1 +
>  tools/perf/util/thread.c  | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f86b3b7df742..a1288fbed833 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -237,6 +237,7 @@ int machines__init(struct machines *machines)
>  {
>         int err =3D machine__init(&machines->host, "", HOST_KERNEL_ID);
>
> +       machines->host.machines =3D machines;
>         machines->guests =3D RB_ROOT_CACHED;
>         return err;
>  }
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index e483ffcb5d93..f0d3773d87db 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -536,7 +536,7 @@ uint16_t thread__e_machine_endian(struct thread *thre=
ad, struct machine *machine
>                                                                     struc=
t perf_session,
>                                                                     machi=
nes);
>
> -                       is_live =3D !!session->data;
> +                       is_live =3D !session->data;
>                 }
>                 /* Read from /proc/pid/exe if live. */
>                 if (is_live) {
>
> --
> 2.54.0
>
