Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0882874FF
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771955848; cv=pass; b=SdYLZqBMDa6MoK/zuFsQuOP/t0BgI8NuYmJxQi2XcqwnSeJ01HHw257BaMWcfFTRP93kwj9SVPlxTt+aIxiRsD+3kP7Ht/NOwO9pTdyHTKAv2aaNWfJd/JN8QgF/WixKiNrW+eQJOTFluFWIzE5++nU3GulAGgAwQe4oeOHcRhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771955848; c=relaxed/simple;
	bh=JVcOerPZfnXVp/OoAwg32ad7JBMzpjI9e3R9/n/imAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkSbkvMZks/q83F4trvqEiQwRFmV8MSN1tWAW4hoJ9V1YMEcigq/xRBQPaKnhifWAPTbCtOOkOf2Ziqvbuzf1UYSP1/BZ93i4NRUuMi3hygjuzs1ZDaP1hKyUSg9ZGtAX4Ga8uGtEoBtVyJ521wHE6g1jZCD6Ml6+SqQMIezJak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LC22l4er; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LC22l4er"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a964077671so3755ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Feb 2026 09:57:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955846; cv=none;
        d=google.com; s=arc-20240605;
        b=i3VAirWXS7bkfbUJWkA0VqXmee2zV9Sv5FxNp1YbFJzoDIzqyz+GrtZiTuelcFjrrQ
         9JtpiquxBtNewYgr1PKaxqNXGu22+yF/Z7mAus9Nly6G0pfjYMORn65lzriw9woo9X1P
         U7HJJowMiQXvffgfJWWpxBU7gBqS4Bf4GLcZJLnpkRWV5uRE7TEWhSHEpZAvy3xXZOBT
         s4LMP6kAMhJSgdehUYOJ9d2/QkcVgY3572TGsJfFVsTRKKWZazqBXt2jyh9dCiF3ve5e
         XvQhJ7/h6IeK2VunuLw34G0hdXfYNazJByUI4JQc0WqhEv7KKbNdSlxhlV8cYyelh1H/
         Li8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8uMhmpEPM85k2hvcueiCP0ESdfRzNa9PWgsYzq1LvYw=;
        fh=FCLgEVRgxTc+31PYMfzQNhFRBOTHmpTa6LDSPlR4Esw=;
        b=U9i+8B3x6KQ81w5324dLMuW1Ql9neFodzbhWclfqf+vqSkJq/tQyl4naV2FkxMu7d7
         j9B8HvLz9tD9HmS9Xn7iZ046m/0jchIraTl8Jjqj0BivbDmEGd5atrYw3cyYCy5SdAom
         XvCisolv4dgmfxcy0/KOeosG1/bKybDlGXfBu6r29JaRbGQGLG8iIOgx0k9FOh8uJx97
         1Ox+fo8pxxX1ha81RX8p/6k6xquukBucvMwvtl5p+Z19TvFDsLGObIDFoR+A24hP8PdT
         05WRnBI/6q7S/E5KPhHyOSZjsINddlLBqeSNwxH5rJ3pHqfDkNQNdaBFF2ABX9QQl5O1
         04cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771955846; x=1772560646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uMhmpEPM85k2hvcueiCP0ESdfRzNa9PWgsYzq1LvYw=;
        b=LC22l4erqSsCeYTnvIY+2GCUh8v8t4bDOlunxFPVNGF6LIxLoVTpvaPdD+CPW29Sl9
         C0TVyBWiFxcuo6qVwtQ8k6SHuO44wbEjzqnQK1Wvp/dC/fEReZ8dHAuaOMyLF6OnlvJ6
         q3/jOXO+5HUe/lUlkA6rSNJqinqrCwbB98hCmJWKFip+7/OMUawuXKpII2OVmMo5xlYP
         V1FlmNY/cPPsBzeavDWuX+uFyPIBVvML10LGU9tiSDcWtj1PvPxXv31Umi00pOOnzRFQ
         yaLsd5e4WVT6lqaYFPsB4UTwDdzIiE66870X96H+4OYdgaestEwRztrxy3v2WLzZiECa
         WECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771955846; x=1772560646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8uMhmpEPM85k2hvcueiCP0ESdfRzNa9PWgsYzq1LvYw=;
        b=DPD/TZpjzQpAlj+aDibd9rP8qL034l1xVti/rJ2ca+OLOCwWAae56jYBx5nzpzqeoh
         jOiIgJC78Sw3zimOWNPKxfVTeg2BCOrEwITjBjujlszLCeI92XJudlzuHOquu8jB5oUa
         i3LFV8JDZBcinPrgURcMuZ3JWcTxe48KVHKZu7b5sT4hLFkvJvQDeDVeT5J3bLMchjKH
         QXvTw4iKfVPP/1umaeL4QiHNCs+72I+YD9qMoe0OnYmLBjv7KrBY7nxIHf4bR1IEV5HY
         8cRGZGN+qFUteesqIjurP5UwgTi4/CgOdE3A3knFIlqGJgqhcgLUUAiMpc3L0/oetSFe
         28cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm6WNsB/XDdAKJZScZJ8ID9MXhWMqJWHI6nkX1cVP3BqZA898ZhYfmEHkTUZyToaKeGaQj0CN5hhMAyV5vLXnd@vger.kernel.org
X-Gm-Message-State: AOJu0YznToI5N2F8RRWSwSiCexd4C5pLx+lfAWJoRLq4tLNElpNtDtiM
	t9Xc9tE5nvDCniUpwZzv+r7Y7H9ZEuuAomotDJ5qAVNGeRPMcgKOYwgOVmXnMItKLkYPh8Q5DNk
	xeOb1BolZKAkMZYhBgnHTgB5NeJQUBA45St53PCyQ
X-Gm-Gg: ATEYQzyUfV+c3MJIQFrjxDYDqIkClQUfdcXRKtZxB9uoQu0HHP3UKmHhHwapjKk0isP
	Ns+Bet+kUzUtHYLoZZYU2gCso6Bg1dXNq7ZXMbwTj+y/+smQLLC+CWT6pv84BPXejCW+N42CYhk
	fOj/UA5pIJ0GOuI/mpV5cUkRDAj5LnpMDRfOvMv7UCCTp5O2zoIpbKL4+xpqYSphcmhfkUXy5aC
	9JDpFCA/eg3IBSXPtf3G3oTKZrQGyO5iMM5EJdGP5VHKwhZaL5CnYs++j3j020e5EeGrArVoK0q
	axOlVgfHbej3WcxLcs4/wws0bUwN2jbLsmcPPA==
X-Received: by 2002:a17:902:d592:b0:2a7:6c4e:5924 with SMTP id
 d9443c01a7336-2adca6e950fmr4755ad.12.1771955845640; Tue, 24 Feb 2026 09:57:25
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212025127.841090-1-liqb365@163.com> <CAP-5=fWqP43QH0=+Cx+s=GM0uwJ9Lzt9Zw2Xw-NxOP-tXkoOJQ@mail.gmail.com>
 <xz46vvcv5u5hpxbvwhvxsnkmgqgadyhoqyponmrs673sklkmap@7voxutqxozy2>
In-Reply-To: <xz46vvcv5u5hpxbvwhvxsnkmgqgadyhoqyponmrs673sklkmap@7voxutqxozy2>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Feb 2026 09:57:13 -0800
X-Gm-Features: AaiRm53WsJQfPYQReLm82U8GcnhFZTipb3tU3872i51JAN41Jz4Pi1P28O0uB3M
Message-ID: <CAP-5=fU9N_TB53NrN_gCOWoabQ9to41Hj4Wovv5n4t6=5ANHnw@mail.gmail.com>
Subject: Re: [PATCH] libperf cpumap: Fix argument x range [] exceeds maximum
 object size
To: Chingbin Li <liqb365@163.com>
Cc: james.clark@linaro.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 1:34=E2=80=AFAM Chingbin Li <liqb365@163.com> wrote=
:
>
> Hi, Ian:
>
> -------------------------------------------------------------------------=
------------
> About whether this issue is unique to the RISC-V architecture, my test re=
sult is:
>
> Machine / OS / Whether it occurred
> AMD9950x / Ubuntu 24.04 / No
> qemu-system-x86_64 / Ubuntu 24.04 / No
> qemu-system-riscv64 / Ubuntu 24.04 / Yes
>
> So I haven't observed the same issue on computers other than riscv64 yet.
>
> -------------------------------------------------------------------------=
------------
> I think there are several ways to fix this issue.
>
> a. Add the volatile qualifier to the tmp_len variable.
> b. Use #pragma to ignore the warning.
> c. Change the type of the tmp_len variable to size_t.
>    However, After trying it out, changing the type alone does not fix thi=
s issue;
>    a numerical range check also needs to be added.
>
> These methods seem to have some shortcomings.
>
> My current thought is that adding a numerical range check seems to be a m=
ore appropriate solution.
> It can effectively resolve the issue even without changing the type of tm=
p_len.
>
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 4160e7d2e120f..e0407796fcd9d 100644
> --- a/tools/lib/perf/cpumap.c
> @@ -413,6 +413,8 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, s=
truct p
> +++ b/tools/lib/perf/cpumap.c
> @@ -413,6 +413,8 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, s=
truct perf_cpu_map *other)
>         int tmp_len;
>         int i, j, k;
>         struct perf_cpu_map *merged;
> +       int orig_nr =3D __perf_cpu_map__nr(*orig);
> +       int other_nr =3D __perf_cpu_map__nr(other);
>
>         if (perf_cpu_map__is_subset(*orig, other))
>                 return 0;
> @@ -422,7 +424,11 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig, =
struct perf_cpu_map *other)
>                 return 0;
>         }
>
> -       tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(other)=
;
> +       if (orig_nr < 0 || other_nr < 0 || orig_nr + other_nr > INT_MAX) =
{
> +               return -EINVAL;
> +       }
> +       tmp_len =3D orig_nr + other_nr;
>         tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
>         if (!tmp_cpus)
>                 return -ENOMEM;
>
> This method has good compatibility while keeping `tmp_len` and other vari=
ables used for comparison the same type.
> If you agree with this idea, I will submit it as a v2 patch.
>
> -------------------------------------------------------------------------=
------------
> I agree that the nr field type should be changed to size_t.
> I tried making the modification. It seems that after this modification,
> there will be comparisons between `int` and `size_t` variables,
> which will require some type casting.

It'd be great to have this clean up, int to size_t and making the nr
in the cpumap unsigned. I'm less keen on the volatile or range checks
to avoid the "-Werror=3Dalloc-size-larger-than=3D". There is a
MAX_NR_CPUS which may be marginally better than INT_MAX. The sign
comparison is somewhat of a pain :-(

Thanks,
Ian

> Thanks,
> Chingbin
>
> On Thu, Feb 12, 2026 at 10:24:12AM -0800, Ian Rogers wrote:
> > On Wed, Feb 11, 2026 at 6:54=E2=80=AFPM Chingbin Li <liqb365@163.com> w=
rote:
> > >
> > > On RISC-V 64-bit Ubuntu 24.04 Server (Running on QEMU), the following=
 error might occur when compiling perf:
> > >
> > > cpumap.c: In function =E2=80=98perf_cpu_map__merge=E2=80=99:
> > > cpumap.c:429:20: error: argument 1 range [18446744069414584320, 18446=
744073709551614] exceeds maximum object size 9223372036854775807 [-Werror=
=3Dalloc-size-larger-than=3D]
> > >   429 |         tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu)=
);
> > >       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > In file included from cpumap.c:4:
> > > /usr/include/stdlib.h:672:14: note: in a call to allocation function =
=E2=80=98malloc=E2=80=99 declared here
> > >   672 | extern void *malloc (size_t __size) __THROW __attribute_mallo=
c__
> > >       |              ^~~~~~
> > > cc1: all warnings being treated as errors
> > >
> > > We use the volatile qualifier to prevent unnecessary errors caused by=
 the compiler's constant propagation.
> >
> > This shouldn't be a RISC-V specific problem.Does changing tmp_len to a
> > size_t fix it? __perf_cpu_map__nr and  perf_cpu_map__nr should
> > probably both return a size_t too, and the type of nr in struct
> > perf_cpu_map should not be signed.
> >
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/lib/perf/cpumap.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > > index 4160e7d2e120..ccf473994111 100644
> > > --- a/tools/lib/perf/cpumap.c
> > > +++ b/tools/lib/perf/cpumap.c
> > > @@ -410,7 +410,7 @@ bool perf_cpu_map__is_subset(const struct perf_cp=
u_map *a, const struct perf_cpu
> > >  int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_=
map *other)
> > >  {
> > >         struct perf_cpu *tmp_cpus;
> > > -       int tmp_len;
> > > +       volatile int tmp_len;
> > >         int i, j, k;
> > >         struct perf_cpu_map *merged;
> > >
> > > --
> > > 2.43.0
> > >
>
