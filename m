Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69406223DFF
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Jun 2026 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780956294; cv=pass; b=YyzKI60p4Y8NreRaZI/6IhZUHHJAbae9jYTImYwl79ehgfuvmtHHx3hySTz+xpsXf3yFkS/PODoiON5P4KFd+0GqO2dFsCDcb/N2mu7FQm7Ce2clYW0a20QnXKgpvhNSG/EUT1JN7xZkvEg6i4swHNPx2UpdoJzxNnTV3bLayMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780956294; c=relaxed/simple;
	bh=96Bl2Le2SrDLYs7lwbXp5ggsEebB71g/kJ2r9eR2AWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHg6fIfR+S9AROVQHFvnEwSwszlVG2ue/uRcngS+ss+NfxNdonMxRaUoimLVt/KmFTR15XOMLeZ0ToWFiYKCfkq1cXJWnWUkxmConjYDJioe/vd7P/XQ8N3B/dyj6cKORhlJhIoG+LIhjSEU4tdc2Zi0S+vSC+RM7NdFG2JIimI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZeF6R/u; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZeF6R/u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0b1a48855so444125ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Jun 2026 15:04:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780956293; cv=none;
        d=google.com; s=arc-20240605;
        b=Uyy5YySHj3PCE3Xs/NTh2he/Y42ikkOlnqfw91v7LLDRD1hRlm46z01a2L5NCzgVGx
         HnDvchvQDY71rrnzKfUtKmWVti0NmHuFB8UnoImqhgI0wqDZj0BBRQOhpWW29YfZUzEL
         R6qirMKHAahYr94IipyktP2Xbw9Ij9V7/r0CbcMq1PpwyL1j2OZelqS1DL/rsMa8OUj4
         QwRGDhyWB1fcC4R8KI5N3V+Ib4cGySF/hQj9ew7OB2N5uBe/TXFWGTppR5yhSBPY3yzv
         evIDmlGX+wtZkmbETefM1r0Sm4obmkd4F+2vGm4hDazTFlOFMjdZD0oaiHeT8o+3XZI4
         ZoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dknO3aOZ4qOTvh6ubTcjTOWHYovHPuYZpoxCCZ0yRgw=;
        fh=jpWtGk381+wG+OOO+gkAgfDI4pyntd6rlr2S0qYGLZo=;
        b=EpaJUdK/8ijdfNMvDy1T29oo4RmlocSLSJZ8EELPaZ47Z2+xha68132EAlGTr9udd7
         A6v2wldnech7ZmWsIa2Ck3+P/FgEKsliUAUI8YctcWBJNNDT5N+f/iw+nw3AEUkWkwqR
         1cTcS5K3ZRiRHsiLr9wkjHq/OVoFaBgzGL7erIPIpzNDU6ibjMS5yplyY6dCFxTbXi9N
         xQPVla1fhqCZamY0c+HxWcSNbqR6OxuJ9SE0x0gufBmE3QirptZXpD89rBBJJkHoKTJX
         DwR8DPII6Ny4Nw0tc0HpvhrMiPeBN7ju1vsGlHO6xMebBDXvCOcB2Lg2JdLwcykm66OI
         T1Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780956293; x=1781561093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dknO3aOZ4qOTvh6ubTcjTOWHYovHPuYZpoxCCZ0yRgw=;
        b=WZeF6R/udGEPnRI1Bnvb/EGDYIdwTwGAickwG9QFAjKVuaWiK6AIQ4wHFU1e1E4znZ
         aPtq2dtzLtCSG8GSk+DssGO44dEJEVpyAHwShBUYrm9suboeuSqwIOaReJXh5rrSEiuW
         Xs/n05Mm1HQ0ItT9xC73/xv3yI+K1liOUON1Of2gIvHVRk1TBQp/pAbAV7V4jRKmR9j5
         2K5Q/7+6psBwCJV+mQ4tnxjX6ykEMd2wcjSFiHfs6X+usY3YiWhjym1GwK/X6EYKs0+4
         esgQleQ1nyvVzPwgW7Za3Nzx3KfadnsNKQFLqszLeFPKtuNph2bjGU6k4aj5a4orhpS5
         G+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780956293; x=1781561093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dknO3aOZ4qOTvh6ubTcjTOWHYovHPuYZpoxCCZ0yRgw=;
        b=mZQUFXiVMK77oghSuxZCCJ0IlfpgxvbZ15sjFwcy38koLNOloFs11ZKAZcl3aJYZGX
         WIK8LG+Nu0JOLtT8Ao1E9tVeIuYSqkrTlfwv4f+UyvDT4ZiZ8fSa0sRTq81IMQYOR5EM
         Uvt3HKsOSGbtkYHO0HatSzjwq4cJuWmKLgGxFl/TC9UwE4MapZCjeu+uHxTrT1AzDqni
         Egxd5LCgTrXkPdHOfbVAUC0WRiZh6vLzP64srHiVt6nHzq+6TBrYWSLv0QdWKpTwEE7r
         4auKmu6Tipy30pK3Em/5z1qcL4JQct1A0z95tnDR5jZ3g9niyiQb9VNVLd12fj+bfsu5
         Nv2g==
X-Forwarded-Encrypted: i=1; AFNElJ8sQCuI1D/NBArmeJoEbBfX0bbHaARHPfJYH+HwJfqKlXlq/G242alJt84m/9gypjoKJHv3xSuJXY9Tq4JyDNkO@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3fvTpY5POoLmp3dDtod75Xg85wMc43X8ArT5MsM29DB7IDx+U
	rozaMshaugVXxajYUD+fvIlswcl4nE5nffilK0GOwQBbwA4GEQN35oHsIaY9rJ2jCRHecYbdA66
	q8dSywtNU+AHkrLJD0q3vvCdT/pamfpg3Qcq4YpAc
X-Gm-Gg: Acq92OGC2hYEgIPjHt0i0Zo8WvcEeJIpEVN8LKQohHcGlcDLt/tJq1/vwsEcVYsMNpG
	AdVn+iN/jPNhBrG1Lkx6Ub2iyVmmgUMhhVx2YzBZpubWB/KMTu78+atnQb3rzk1tud2qCCH/MQ8
	KWMXje/OjOcwGSiqOXr43A84c3ALVuflVVrzoG68p/WB4fFDHQA3oNV5UqMty59JDltu9UkepS3
	waESmQC8Y2w2Lwa4N8GgJ1Q7hSO4WVAnvhlE6q1LHBeS3CM6tY76JqEm8NlWhsO/bKdXY60/a1F
	DgmcjY/8zLYAzPpwOc/YL7fmzXBD534bF8+TAWNY6AhDSP/p
X-Received: by 2002:a17:903:1aed:b0:2b9:e831:5e5c with SMTP id
 d9443c01a7336-2c1eb72a130mr5883515ad.4.1780956292384; Mon, 08 Jun 2026
 15:04:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608201753.1979464-12-acme@kernel.org> <20260608204539.0E0C91F00893@smtp.kernel.org>
In-Reply-To: <20260608204539.0E0C91F00893@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 8 Jun 2026 15:04:40 -0700
X-Gm-Features: AVVi8CcVd-nogTnr5Rt3DF724JTHentVjWsxZLchea7M2K-aDoqhaR-7Mh_XVyo
Message-ID: <CAP-5=fV+trJGAEKhS2YTea0A39VgoYUxbcp=E0csPepD751N3A@mail.gmail.com>
Subject: Re: [PATCH 11/11] libperf: Document code simplification case for
 widening struct perf_cpu
To: sashiko-reviews@lists.linux.dev
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 1:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] The documentation added to `tools/lib/perf/TODO` incorrectly stat=
es that narrowing values > 32767 to `int16_t` wraps them to 'small positive=
 numbers'. In two's complement arithmetic, values from 32768 to 65535 wrap =
to negative numbers (-32768 to -1) when truncated to a signed 16-bit intege=
r.
> --
>
> commit e8f5b26d672396c3173a77e6aaeee613f6d309bd
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> libperf: Document code simplification case for widening struct perf_cpu
>
> Add a bullet point to the libperf ABI TODO explaining the code
> simplification benefit of widening struct perf_cpu.cpu from int16_t
> to int.
>
> > diff --git a/tools/lib/perf/TODO b/tools/lib/perf/TODO
> > index 486dd95dc5720..1a3644aa1f38d 100644
> > --- a/tools/lib/perf/TODO
> > +++ b/tools/lib/perf/TODO
> > @@ -11,6 +11,13 @@ together.
> >       (x86_64 max is 8192, arm64 is 4096), but NR_CPUS limits keep
> >       growing.  perf clamps to INT16_MAX in set_max_cpu_num() as a
> >       safety net.
> > +   - Code simplification: the int16_t forces defensive truncation

I think Sashiko just wants this to be uint16_t :-)

Thanks,
Ian

> > +     checks at every boundary where a wider CPU index (int from
> > +     sample->cpu, al->cpu, etc.) is narrowed into struct perf_cpu.
> > +     Without these checks, values > 32767 silently wrap to small
> > +     positive numbers, bypassing bounds validation.  Widening to int
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> [Severity: Low]
> This isn't a bug, but is the arithmetic description accurate here?
>
> In two's complement arithmetic, truncating values between 32768 and 65535
> into a signed 16-bit integer (int16_t) wraps them to negative numbers
> (-32768 to -1), rather than small positive numbers.
>
> The overall conclusion remains correct since negative values trivially
> bypass bounds checks, but the description of the wrapping behavior appear=
s
> mathematically inaccurate.
>
> > +     eliminates this entire class of silent truncation bugs and
> > +     removes the need for the INT16_MAX clamp in set_max_cpu_num().
> >     - Scope: struct perf_cpu is embedded everywhere =E2=80=94 perf_cpu_=
map__cpu(),
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608201753.19=
79464-1-acme@kernel.org?part=3D11
>
