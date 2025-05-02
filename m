Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601E1946DA
	for <linux-perf-users@vger.kernel.org>; Fri,  2 May 2025 17:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746207067; cv=none; b=oh/vbZCZ7i5rm31pXwG05GH5GbwEAuuDQyAjijugqjOiQ8G2jlH8W0a+X3U8DqmBHRi/PMBXRci0Uu+CO+b6MbIb/U37I3k7UXKGZ0pa3ZY1XMupcqNIR7ub8hEM49uFMvvqTq7GSl0Fqj3ouLvPoc8mPvfXzbC2ntj7MseqBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746207067; c=relaxed/simple;
	bh=M+7B4daGccErNTyFVD7UF/LbMQuW1ksDcmHRoalpovQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaW8ffCe/lQrDebJgetiQXnn+22TMY31Xw98IX9/ZFcCUe1at8iqp12hgAAW09YPojiOCsL5iHd5fKvxM3sALimrK6R0N3I7wKO0uD+LOzbwA1ljDXE0mAIdbOCj22/Awc6fPcXFkfH1YtW4UAibCvVD0v+pAt2NdDRmO0yljAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wwyYbNKk; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wwyYbNKk"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f2b05f87fdso23923016d6.2
        for <linux-perf-users@vger.kernel.org>; Fri, 02 May 2025 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746207064; x=1746811864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMCFjcDYKufJvMwFbFoS0kPacOFt/H1BGkqn/nrFgq0=;
        b=wwyYbNKk1EMrF3zPLpzPKtn/CSx+s/VoMRedmf1z2AkF7gse4ql+Gzu+WtjllAgfaS
         f0N4MnMCxkU8BI/h2Ukx54jjyTKwfeBZkJZbSUynQyaRinOMFiIw6xy7NDrM9a1hf3rF
         iRmZKF75teBngCGTC4LQ+CKHV6cvjsHj3AKQJYknG46zCYVwDtmaAkV1iRgLKdfZpIwI
         5iH/k0vyQc6RgKJi6meIYNqzVr6IYDhih7bpXoWjhDmAkA6GovK1QTGaOVxQq83nFCiN
         jRY+fI81X+mzS3Tonw7RKz3DbKu/lLpWX/vRapP3LGdcZxhXUuOD9CuA6PkLN2ZmwLT/
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746207064; x=1746811864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMCFjcDYKufJvMwFbFoS0kPacOFt/H1BGkqn/nrFgq0=;
        b=ihj9O8EfQuQoFxkHNdtnMH8MfXDQXWHnNN+Isrdrgj6a4ZPdvTIN0VOGItLyc5Nb6+
         vzETxDkGB2O0eB+oegQj5Bmd70+9w7WUzJZsHcJqBlznZ6DhXQH3sRcSakw1rpZbc8KE
         Bjp/lLQ53696P7ymwJGa31Xpk7ygbk5O8ZpTOr7bh2lwDmwRg2RSTtJckw0a6JOxHg+K
         visBFhCnR3+xN7Y9jYSMVBkROrj1eo/dVKS5O/EN+T8eejxtWqEy6tahrH7gZygA5jtj
         BtMBQEm/3Fi1HpivzMZA53pJWnub1ixB6nsizeA+CUKPnRoyXAFyqPXPq8hiofWt2sd6
         jHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlAbWRDaAgNY7t2Z2MK5xmlUNNo/IqXwRE+8q1Xd2yXQhqFWxsoNEoxMYMwdz5jBGrfafi0o4NGZvzPfrviyp/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OOmNZlzdxnen0qnspk2GUQAZc766rDLpoI9jyA81/3Vyq0h9
	PgxYR68U4NnAIAHjgLMb7YBUJBGebcA3WLEQuVS68fiXXHCcn8b+emoZZoPYwBVq7jWgEoGwptQ
	X3Iew3wlaJg2wqNyICchZdHsQ7EekrGtoSrw=
X-Gm-Gg: ASbGncslR2ncm+/dH7IkaJcy4C+9p7gtQBGHnd8DDO4q9aNitBssHSUc85lVNeNanm9
	7hknRLYRUFXoF4lcEw9Wxfevdcl4fPyHPYrltg0oSP7sRQspERBRcHvH2nbQkf7P7vFxkjQgomQ
	7y1Hn/VywJEX3mH+od/IPXD+iEHed4AGDbXGsawMAZl8F3AYILmIBGbag=
X-Google-Smtp-Source: AGHT+IFketDgIAyIg1nzLpZwpgdnRMDBObLxDNHG1f3j9ZJ7VtHRnYWzb9gAuuD1s4QoK/s07tDlq6e1k6CDT2Gw9WA=
X-Received: by 2002:ad4:5d63:0:b0:6e6:6c7f:1116 with SMTP id
 6a1803df08f44-6f51578445fmr53465476d6.24.1746207063804; Fri, 02 May 2025
 10:31:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501193556.23473-1-yabinc@google.com> <02c125c9-7a1f-4dfd-b058-02a38ed5b598@arm.com>
In-Reply-To: <02c125c9-7a1f-4dfd-b058-02a38ed5b598@arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Fri, 2 May 2025 10:30:52 -0700
X-Gm-Features: ATxdqUFmx2hBUO3uk91d37roh8hs55lc6aLf5LBhD3FNcxdPEhGgyk4RnUvPDUU
Message-ID: <CALJ9ZPMYj=+ZsbPDWHe80R_i3GiMmKBviZ+WBRaj3jm96ZH+VQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf: Allocate non-contiguous AUX pages by default
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	James Clark <james.clark@linaro.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 3:51=E2=80=AFAM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> On 5/2/25 01:05, Yabin Cui wrote:
> > perf always allocates contiguous AUX pages based on aux_watermark.
> > However, this contiguous allocation doesn't benefit all PMUs. For
> > instance, ARM SPE and TRBE operate with virtual pages, and Coresight
> > ETR allocates a separate buffer. For these PMUs, allocating contiguous
> > AUX pages unnecessarily exacerbates memory fragmentation. This
> > fragmentation can prevent their use on long-running devices.
> >
> > This patch modifies the perf driver to be memory-friendly by default,
> > by allocating non-contiguous AUX pages. For PMUs requiring contiguous
> > pages (Intel BTS and some Intel PT), the existing
> > PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
> > require but can benefit from contiguous pages (some Intel PT), a new
> > capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
> > existing behavior.
> >
> > Signed-off-by: Yabin Cui <yabinc@google.com>
> > ---
> > Changes since v2:
> > Let NO_SG imply PREFER_LARGE. So PMUs don't need to set both flags.
> > Then the only place needing PREFER_LARGE is intel/pt.c.
> >
> > Changes since v1:
> > In v1, default is preferring contiguous pages, and add a flag to
> > allocate non-contiguous pages. In v2, default is allocating
> > non-contiguous pages, and add a flag to prefer contiguous pages.
> >
> > v1 patchset:
> > perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
> > cs_etm
> >
> >  arch/x86/events/intel/pt.c  |  2 ++
> >  include/linux/perf_event.h  |  1 +
> >  kernel/events/ring_buffer.c | 20 +++++++++++++-------
> >  3 files changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> > index fa37565f6418..25ead919fc48 100644
> > --- a/arch/x86/events/intel/pt.c
> > +++ b/arch/x86/events/intel/pt.c
> > @@ -1863,6 +1863,8 @@ static __init int pt_init(void)
> >
> >       if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
> >               pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_NO_SG;
> > +     else
> > +             pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_PREFER_LARGE=
;
> >
> >       pt_pmu.pmu.capabilities         |=3D PERF_PMU_CAP_EXCLUSIVE |
> >                                          PERF_PMU_CAP_ITRACE |
>
> Why this PMU has PERF_PMU_CAP_AUX_PREFER_LARGE fallback option but
> not the other PMU in arch/x86/events/intel/bts.c even though both
> had PERF_PMU_CAP_AUX_NO_SG ?

Because Intel BTS always use NO_SG, while in some cases Intel PT
doesn't use NO_SG.
>
> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> > index 0069ba6866a4..56d77348c511 100644
> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
> >  #define PERF_PMU_CAP_AUX_OUTPUT                      0x0080
> >  #define PERF_PMU_CAP_EXTENDED_HW_TYPE                0x0100
> >  #define PERF_PMU_CAP_AUX_PAUSE                       0x0200
> > +#define PERF_PMU_CAP_AUX_PREFER_LARGE                0x0400
> >
> >  /**
> >   * pmu::scope
> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> > index 5130b119d0ae..4d2f1c95673e 100644
> > --- a/kernel/events/ring_buffer.c
> > +++ b/kernel/events/ring_buffer.c
> > @@ -679,7 +679,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >  {
> >       bool overwrite =3D !(flags & RING_BUFFER_WRITABLE);
> >       int node =3D (event->cpu =3D=3D -1) ? -1 : cpu_to_node(event->cpu=
);
> > -     int ret =3D -ENOMEM, max_order;
> > +     int ret =3D -ENOMEM, max_order =3D 0;
>
> 0 order is now the default allocation granularity. This might benefit
> from a comment above explaining that max_order could change only with
> PERF_PMU_CAP_AUX_NO_SG or PERF_PMU_CAP_AUX_PREFER_LARGE PMU flags etc.
>
Will add the comment in the next respin.
> >
> >       if (!has_aux(event))
> >               return -EOPNOTSUPP;
> > @@ -689,8 +689,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct per=
f_event *event,
> >
> >       if (!overwrite) {
> >               /*
> > -              * Watermark defaults to half the buffer, and so does the
> > -              * max_order, to aid PMU drivers in double buffering.
> > +              * Watermark defaults to half the buffer, to aid PMU driv=
ers
> > +              * in double buffering.
> >                */
> >               if (!watermark)
> >                       watermark =3D min_t(unsigned long,
> > @@ -698,16 +698,22 @@ int rb_alloc_aux(struct perf_buffer *rb, struct p=
erf_event *event,
> >                                         (unsigned long)nr_pages << (PAG=
E_SHIFT - 1));
> >
> >               /*
> > -              * Use aux_watermark as the basis for chunking to
> > +              * For PMUs that need or prefer large contiguous buffers,
> > +              * use aux_watermark as the basis for chunking to
> >                * help PMU drivers honor the watermark.
> >                */
> > -             max_order =3D get_order(watermark);
> > +             if (event->pmu->capabilities & (PERF_PMU_CAP_AUX_NO_SG |
> > +                                             PERF_PMU_CAP_AUX_PREFER_L=
ARGE))
> > +                     max_order =3D get_order(watermark);
> >       } else {
> >               /*
> > -              * We need to start with the max_order that fits in nr_pa=
ges,
> > +              * For PMUs that need or prefer large contiguous buffers,
> > +              * we need to start with the max_order that fits in nr_pa=
ges,
> >                * not the other way around, hence ilog2() and not get_or=
der.
> >                */
> > -             max_order =3D ilog2(nr_pages);
> > +             if (event->pmu->capabilities & (PERF_PMU_CAP_AUX_NO_SG |
> > +                                             PERF_PMU_CAP_AUX_PREFER_L=
ARGE))
> > +                     max_order =3D ilog2(nr_pages);
> >               watermark =3D 0;
> >       }
> >
>
> Although not really sure, could event->pmu->capabilities check against th=
e ORed
> PMU flags PERF_PMU_CAP_AUX_NO_SG and PERF_PMU_CAP_AUX_PREFER_LARGE be con=
tained
> in a helper pmu_prefers_cont_alloc(struct *pmu ...) or something similar =
?

Sure, but I feel it's not very worthwhile. Maybe add a local variable
use_contiguous_pages? It can also work as another comment near
max_order.
