Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A55401495
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jun 2026 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030688; cv=pass; b=QbX8U8lBXi15RFTgcXso/zLX/supFq5mjj2MeLIMyzPBW2pLD2A0MbECyTVAHDXoEflgbAcdI1NkBde4hWPMti4cjTCR2Cdn5DKL18MR9QRa6KgWy++XLETTpoXivkUU/FMP2b3X8NscRwpn6wIlLk0Me6g3k0QQJqd6AzDi0xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030688; c=relaxed/simple;
	bh=ODCv2k0U5GVud9ySmYUgNUmgrz7TDrR5daHo0W94vgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bhzw4ROy5VP/uDGjK0kb6cdGzi8g5rcT1aOuegebR7pBHI2nTegIRFtVfAigvJKF2zw038FN/zndXuwB4I0O2WHEiNhB8FZN1OaqDZcK35ZFJH9NkP2KWl2Y7xE4X+ZIsdIRiZ5kjPiZKox3exfIHmVXbLR7GDxf8SBrgqQMazo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7979Sz5; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7979Sz5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-137ec563a95so7399014c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jun 2026 11:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781030685; cv=none;
        d=google.com; s=arc-20240605;
        b=BV2R5fQlLF0mDZ4fJHAKGBf9EPZr/my5iM1H/Ix6c1SHH09ZetJ+snyEtQyLxx8Gze
         fJcbVbkc8CMAFX7ZTNhKGLUYYa5Fu4IlhNQQHsEynhD9TSOTphFG/ju6GUFAREyUjDcP
         sVXNafr++DESqO5bdOnTyNRpEXXDn3ity/VbNmrGYmc/l+y+90DOIiaSmlaTRIgpk8+W
         /ZWxyl4zmqxVC3idp7+ne2/RnRl1fiT/QrjDoDQLz+/bMSpDQAnSd7Rp8PZnoXeOVm2j
         yCyu9ikS/UKNDayH7BPgTRYMV3Os+jjN3XiZgj8v/K22i7pjUER+EDhEe0q2dDNk7wAs
         mq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=he7b64zbcrvU+vymPMODxxdaMXBZ9Apliqjw/B8rSFc=;
        fh=hETZDGCIydWZ2fKk69LgHWHSKtz4ZpyV/Kj8/5FzVBY=;
        b=e6ORzAxanzp/SXGzr9JasHmDaYM80ER/J9c4vHFCz3DkOmRECEuzPsDodmJvgQFqGX
         eS4Hs7pLlYjuLe1cvyPbaNlAbYYU2U6ese91Wbicg4C524hI0fbAF2JmxeFxHnMUVhdv
         8OERoELSd3M7W9qLIhvxJiOiMEjwQvbECc5WIgvr5Gey4vezzb51wdNGwgrNwmiPByWp
         JzZBEZ72f/5nvvoAZ/4RTTfFGm/odBkYayIJNxKfnfWuENiIy6X/K1TpLuU3ONbzE/lx
         XCRbBpmy694hS45SLVZw0fJbtKm4ngPMM2ZvXdR0uh+59jU/R19wXGJp2H7XGhaPcdnS
         HkCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781030685; x=1781635485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he7b64zbcrvU+vymPMODxxdaMXBZ9Apliqjw/B8rSFc=;
        b=M7979Sz5VvSDixAmRN605Y4x7A905l2vKviH8QXxr1Ns429ky/xGI7ZgKs4ZSDsD4X
         /pGzULA1t5V24AP2kr9rhuuugQd0YNaSYfJadYBqJbFN8ncHCR/FGUP+pTHPpssm60FB
         RQ5xZ22mi9r73zs45TS+euXQ3+VVRR9jm4f5lma8vlnqx+lwwquXALOLw5a/+ADkVZdD
         lyShghCbxsof0wgo74eQ+oaBMLZinGnN20jkBI0538HOxmdldommjs/wh8Lu0ef0JaOP
         XvEoGDOAdmD8svxjIvJoLZRjAT5ZnKfdZWXwCpYKy0uROZoU8CTi7pq703VIZANdLiVT
         ED3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030685; x=1781635485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=he7b64zbcrvU+vymPMODxxdaMXBZ9Apliqjw/B8rSFc=;
        b=joffNZcYLvvIBGtOR7yCJIz2WSXAvY2riCPvjkVCSU7xrIs4yb016XstX4u1mux2Ol
         nx74xah+KgVjrha+3LMmVCU7ocS6D3cd6lyeXgSKkrOBbgrpftYPVxGu/jyLH8wq2bW8
         Ga23zLaMklNGRfTZB+Nt2a/5soBhX3A78i4CPwHOt0e7BdAngegt0Y6XpANQaNMm4B9a
         UbKV3jaKbRfmLaX56E1ZeEnnc8da9Qal9eQawM2t8rd9wo4ROO9QvhfEViQ5YXXpTBnF
         UeWTC8RKbDvCmoVZ30riky+BqRqP5cQ9Cxqd1/Y42VhBFIurYf90GzSANcBsqJIVuX+3
         0Byw==
X-Gm-Message-State: AOJu0YxuIjdBSU4dsaXTY6TCJ751JKfltHRd3bgXyomixGv+nYtpRRau
	GzfMy0db3XbkLDFEezYCq9vnVRhiANnF8euBMAMvD0udYmOUW6MhGtoUOJ/++tpejfdTEFnUprE
	YQYjpYiO3UglfvXg9NQl5ghxT6guJRNWnHk/Xc5u2
X-Gm-Gg: Acq92OEkYWIQOlDvsI+kygnQHyIg0qtb5J+xIMrHvnOaLfxxV04LBgJYE1za5AFEZR6
	HpPY/qYK74wPX6gekmaZ5yu4ce4ibfNsaqsXzJIrryAsWDhuN21GiTkp/CDavwiORXfPWpK51SY
	3H+Q50clVGk7yzq8kP3enYi+A46eI42MAdyTIDbBRz4q8CnixlhcAmiliqa0/9wqs/NHdX/aaA3
	MqTDq3wvsOO6K+aIYY9rO39t+7CLpGWkeXY6O0jbM9rg28OwGKxnYmhAZmH0WdQFSpn3pjx/ho2
	kMvCi/sEc+ILR3FTResWgf0RZ2+Qr75EQ405YTB+UU4BjLIC
X-Received: by 2002:a05:7022:618c:b0:138:717:9ae0 with SMTP id
 a92af1059eb24-13807179f75mr11168790c88.12.1781030684609; Tue, 09 Jun 2026
 11:44:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527221934.3830896-1-ctshao@google.com> <20260528001117.3BBF11F00A3A@smtp.kernel.org>
 <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
In-Reply-To: <CAJpZYjUiNdN3a6y+8rs=YP2Mgtj6EQJnkiB9TN_suWd8fGkoEg@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 9 Jun 2026 11:44:32 -0700
X-Gm-Features: AVVi8Cfiaqpo2xDili8W-0VNrzil-BILglmCfX-05Ux8Uwa5ZjVGx3Nc3QWxJVU
Message-ID: <CAJpZYjUhw8+ouKTS82G6ih457=pHn18AtvwMCAcaTL9csKmdTg@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 1/2] perf pmu intel: Generalize SNC cpumask
 adjustment for multiple platforms
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Zide Chen <zide.chen@intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chun-Tse Shao <ctshao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping for attention.

Thanks,
CT

On Thu, May 28, 2026 at 2:31=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> On Wed, May 27, 2026 at 5:11=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> >
> > Pre-existing issues:
> > - [Critical] An integer overflow in `uncore_cha_snc()` can result in a =
negative Sub-NUMA Clustering (SNC) node index. This bypasses the upper-boun=
d check against `MAX_SNCS` and causes subsequent out-of-bounds array access=
es.
> > --
> >
> > commit be394e8b7ddbe730c3fc40fb608337fe19c7b33b
> > Author: Chun-Tse Shao <ctshao@google.com>
> >
> > perf pmu intel: Generalize SNC cpumask adjustment for multiple platform=
s
> >
> > This commit generalizes the Sub-NUMA Clustering (SNC) logic previously
> > specific to Granite Rapids to support multiple Intel platforms. It uses
> > CPUID to determine SNC support and caches various PMU configurations
> > to improve thread safety.
> >
> > > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/uti=
l/pmu.c
> > > index 7c9d238922a6c..9b00d5720fb7a 100644
> > > --- a/tools/perf/arch/x86/util/pmu.c
> > > +++ b/tools/perf/arch/x86/util/pmu.c
> >
> > [ ... ]
> >
> > > @@ -121,46 +142,73 @@ static int uncore_cha_snc(struct perf_pmu *pmu)
> > >               return 0;
> > >       }
> > >       chas_per_node =3D num_cha / snc_nodes;
> > > +     if (chas_per_node =3D=3D 0) {
> > > +             pr_warning("Unexpected: chas_per_node is 0 (num_cha=3D%=
d, snc_nodes=3D%d)\n",
> > > +                        num_cha, snc_nodes);
> > > +             return 0;
> > > +     }
> > >       cha_snc =3D cha_num / chas_per_node;
> > >
> > >       /* Range check cha_snc. for unexpected out of bounds. */
> > >       return cha_snc >=3D MAX_SNCS ? 0 : cha_snc;
> >
> > [Severity: Critical]
> > This is a pre-existing issue, but does this range check safely handle v=
ery
> > large values for cha_num?
> >
> > Since cha_num is parsed as an unsigned int via sscanf() from the PMU na=
me,
> > and cha_snc is a signed int, a sufficiently large cha_num could cause t=
he
> > division result to overflow into a negative value.
>
> I think it is very unlikely we would see cha_num > INT_MAX.
> Since that is a pre-existing issue, I prefer to fix it separately.
>
> Thanks,
> CT
>
> >
> > If cha_snc becomes negative, the cha_snc >=3D MAX_SNCS check evaluates =
to
> > false, allowing the function to return a negative index.
> >
> > Could this negative index then cause out-of-bounds array accesses when =
used
> > later in uncore_cha_imc_compute_cpu_adjust()?
> >
> > uncore_cha_imc_compute_cpu_adjust() {
> >     static bool checked_cpu_adjust[MAX_SNCS];
> >     ...
> >     if (checked_cpu_adjust[pmu_snc])
> >     ...
> > }
> >
> > --
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527221934.=
3830896-1-ctshao@google.com?part=3D1
