Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA17C33986D
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099610; cv=pass; b=MONpsD3dJsYv33mjAKIGa5bg1KNh/N3sKpZCTm287YHrPXrDCXOmGykNVW1LodOJaNQqjU6pLPmAEGvV5VeWwdQ5lDo2yoZVt/zvz4JGEldMBBZpAIFQKmt9jo3W9uEyVVQW198Hm4AVlzGp9ycS5gLts3ZItBYi9fxLMux5o1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099610; c=relaxed/simple;
	bh=p4Ur90rP9gGawmmRylEhAW90YOCXuEJwtVlZSnxMo5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJQna0LFDekEkLxZBXhKJqZa0FHWuqmiSAQEHHWxhEsPqOHJE7r9S/Ea+t+jwvN4ZEJ6EAFVAocg0CEVYBgXZtdCMle25BwrFKXtGGPXpq+vCGVtAQqLN3k+JRZ7qatrjnXvSbLb4uAj3iGEchwn+NV6rfBObTiq8qHmH98+070=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nld8RX/r; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nld8RX/r"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2591757fbso490875ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 10:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776099609; cv=none;
        d=google.com; s=arc-20240605;
        b=Ph9k5A46ySGIxP/vz70Ze5wlFva0cyRvVljFRJd5jgY3wq5pOk7zYOZjt/o5mVo+nr
         Ci33ntUAO4h9SdMK6tjbvazI466NzfwPR+vOQdpqRGe508JPVarrNH9ApOW6MOuCosQq
         IRKXgwV9grzG8d0BDoq6g84M7kVtq1CObnRN1tGqUvoNXgxZS/1qeNM+hUSG9uCiionS
         ClqTqGSt2lr+6XLHatucfkKLJ9kUGre/VT9dBql7DQ9D7gslJEAHzePTOSf4moVOiol3
         QMHFv0UBXxFlvP2KnqUkQP/UPs01SSzYu/v63zr5hjvFAv3n7wZw+kg/DjkWQWAKneOo
         o9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v+yBzwpxyievHPpHPqbBVEu3G8kcZqNeaLP2bLQmZas=;
        fh=Ylrz3XMjn/1dTmM3nfwuo4GhkFsRvsxx1npg7gJBTnQ=;
        b=CFBbpQGuf+AK8uwfPz2T1dvVDLxRHJb8Bi37pAqBP2nteHtrk+X/F3R5Z57s1MlUGn
         FitwoPl0r8utZ6XMDKezz4mXD8Ki/vhWhQIeoI/9k20PxRN+qdNsDzbp3O9B1yLVTi/v
         34w1hVXrvFiLPiCAId5Q2x1KBXpi6/91RCKxy7TE1szAhEVHeZfS68Jv3yoawcAd/LML
         h8NaLWmGTg9eUceyHuihlyQ9sQXuvhYBKiDgz8Lwrq+6U6HewOBqG816g5LjoURZz5pz
         rci4adf0FFR3pCZ4E0QjWHnGGyXaLm6W192VlboU3Jeh+INf74HjIl9tP5fib7aDKkNI
         fthA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776099609; x=1776704409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+yBzwpxyievHPpHPqbBVEu3G8kcZqNeaLP2bLQmZas=;
        b=Nld8RX/rGwTb2+W1660oy52xE7FPwnopmaK6BB60z66P0/6ppKjiuztpjXxQBb3I+G
         42qU7Hc1H/Usoj2KvRV/A19Ml/C/u5Z9LXpx5iC5b4zKMsJTxe6fZgO5xA4BInUnfvvj
         WIJpT8R4BxowThnniw+Q9MdA1yZh+4nlxpufhRPlCa92sM0bAPm40h00Y8siTUzcwgGb
         /eBBlirEZEYRyHAHKTkpIDXE6acO9Xsq034dViy1vz+X9Mwy4Z/1G/82ckG2/SyXUzsU
         ke/YlC473Vjcopqjwyr95Ig/tNAH+d995hWhr4izfg+hh/uQeyPr3WXQDvns6k5Puq2P
         w+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776099609; x=1776704409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v+yBzwpxyievHPpHPqbBVEu3G8kcZqNeaLP2bLQmZas=;
        b=S6StErCkjgD/WR7Naj/bbtsjp1ceBM7zR41hR6YaI2JM5Ha03t2GpWmYPhSKph0Ldl
         kVqeQyi1IDZdAIB+DOT84NV7osOKW5L1m1lWF8swPUSX1MXPMsktoh5y57MjO5JvSnXu
         4hLiAa6ov38xbedrRxKBE5l5+IiXp9JINAZVVNTPsXvWFxBGcHG2mDcU+8cTdxv4a8j6
         gUK4mBG9rJZ0MAMvoh/PIGyJWNVvRQxeQckWV6Hc8PSGXo88FPDG7S+B+kOnTP1q9bSr
         rzkprxevnBpAqLtZUO51YtAVQM03SOZbD+/L4EmfklkAlz1z2p0f7KNI1SRtGDvcKJwA
         TRkw==
X-Forwarded-Encrypted: i=1; AFNElJ9sUIFED9I9pNAfTcgp7ZkpCLwl2x6CLvRmpAiEzAAfCKfz8xNaJgfFlRb/8b/8PomfWvel+G1MEaYgoMaUMRaK@vger.kernel.org
X-Gm-Message-State: AOJu0YxKKmTfgiEWUUecKtNzOIbatREVpxOhdxFwEMGGsrmtHRZllGq+
	vwxEXoalIeXHjkx+Y7ursFFE3HxzG9SAfVSzebcZ6Uc4ijEnbz663qZdeYRrgQoDT8e+aSg7OJC
	o9Rf76qzSRomgGa7Y4cu0h+TEJnO2+hhHkOEk88fX
X-Gm-Gg: AeBDieuX3VNrcSRxwheO4aSmEyN5vrtzR4Wfm+MBok6J1vQAOtige4Kv5C7LCQpWag3
	WR40YOMm1s+WHr3rd7pAV92GtG+33hGxAQ0f+2TUOYgqAt99aJZS7XL/HbWhcF82/FAL2zyb7qe
	YrG/PLvbbAedRicbn25q0UawLI5yFneX1AR1gWubIB/lgarD/22NGn+rc9pkKsNJxKD0GbyQV8O
	HBKd0LBuNnxf54umOiK0VEPAJQ+RtMzJ26G/8DyggHfPNiZq1k68995OMsCqpXGiid2arq/r2YU
	Q//Nmy4aFbQtsj4rFxi/5doJpCzrtMhGDH18xkRqCNGlTzJ/
X-Received: by 2002:a17:903:2a87:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2b4641a70a9mr2230145ad.13.1776099608419; Mon, 13 Apr 2026
 10:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411191710.524998-1-irogers@google.com> <20260412020833.641177-1-irogers@google.com>
 <20260412020833.641177-23-irogers@google.com> <ad0cxk1PJ4EcZi_H@google.com>
In-Reply-To: <ad0cxk1PJ4EcZi_H@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Apr 2026 09:59:56 -0700
X-Gm-Features: AQROBzC_enmc322irxyXZ-2DA2ur_P7yJe0lbBKCyq5Ym21pp4dbFvP6SEo7YBA
Message-ID: <CAP-5=fUjXQgQWYZGQthYAcABn-rXtSGC4U2=OkaYMgjLif2x6g@mail.gmail.com>
Subject: Re: [PATCH v10 22/29] perf s390-sample-raw: Don't pass evsel or its
 PMU with sample
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 9:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sat, Apr 11, 2026 at 07:08:25PM -0700, Ian Rogers wrote:
> > The sample contains the evsel and its PMU so it is unnecessary to pass
> > the evsel as well.
>
> This patch is changed to minimize the diff.

I'm not sure what this means as the patch already attempted to
minimize the diff. I'm worried that not sending changes to my patches
via the list introduces errors because they don't go through Sashiko.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/s390-sample-raw.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/util/s390-sample-raw.c b/tools/perf/util/s390-s=
ample-raw.c
> > index c6ae0ae8d86a..52bbca5c56c8 100644
> > --- a/tools/perf/util/s390-sample-raw.c
> > +++ b/tools/perf/util/s390-sample-raw.c
> > @@ -222,8 +222,9 @@ static char *get_counter_name(int set, int nr, stru=
ct perf_pmu *pmu)
> >       return result;
> >  }
> >
> > -static void s390_cpumcfdg_dump(struct perf_pmu *pmu, struct perf_sampl=
e *sample)
> > +static void s390_cpumcfdg_dump(struct perf_sample *sample)
> >  {
> > +     struct perf_pmu *pmu =3D sample->evsel->pmu;
> >       size_t i, len =3D sample->raw_size, offset =3D 0;
> >       unsigned char *buf =3D sample->raw_data;
> >       const char *color =3D PERF_COLOR_BLUE;
> > @@ -284,8 +285,9 @@ static bool s390_pai_all_test(struct perf_sample *s=
ample)
> >       return true;
> >  }
> >
> > -static void s390_pai_all_dump(struct evsel *evsel, struct perf_sample =
*sample)
> > +static void s390_pai_all_dump(struct perf_sample *sample)
> >  {
> > +     struct evsel *evsel =3D sample->evsel;
> >       size_t len =3D sample->raw_size, offset =3D 0;
> >       unsigned char *p =3D sample->raw_data;
> >       const char *color =3D PERF_COLOR_BLUE;
> > @@ -332,31 +334,32 @@ void evlist__s390_sample_raw(struct evlist *evlis=
t, union perf_event *event,
> >                            struct perf_sample *sample)
> >  {
> >       const char *pai_name;
> > -     struct evsel *evsel;
> >
> >       if (event->header.type !=3D PERF_RECORD_SAMPLE)
> >               return;
> >
> > -     evsel =3D evlist__event2evsel(evlist, event);
> > -     if (!evsel)
> > -             return;
> > +     if (!sample->evsel) {
> > +             sample->evsel =3D evlist__event2evsel(evlist, event);
> > +             if (!sample->evsel)
> > +                     return;
> > +     }
> >
> >       /* Check for raw data in sample */
> >       if (!sample->raw_size || !sample->raw_data)
> >               return;
> >
> >       /* Display raw data on screen */
> > -     if (evsel->core.attr.config =3D=3D PERF_EVENT_CPUM_CF_DIAG) {
> > -             if (!evsel->pmu)
> > -                     evsel->pmu =3D perf_pmus__find("cpum_cf");
> > +     if (sample->evsel->core.attr.config =3D=3D PERF_EVENT_CPUM_CF_DIA=
G) {
> > +             if (!sample->evsel->pmu)
> > +                     sample->evsel->pmu =3D perf_pmus__find("cpum_cf")=
;
> >               if (!s390_cpumcfdg_testctr(sample))
> >                       pr_err("Invalid counter set data encountered\n");
> >               else
> > -                     s390_cpumcfdg_dump(evsel->pmu, sample);
> > +                     s390_cpumcfdg_dump(sample);
> >               return;
> >       }
> >
> > -     switch (evsel->core.attr.config) {
> > +     switch (sample->evsel->core.attr.config) {
> >       case PERF_EVENT_PAI_NNPA_ALL:
> >               pai_name =3D "NNPA_ALL";
> >               break;
> > @@ -370,8 +373,8 @@ void evlist__s390_sample_raw(struct evlist *evlist,=
 union perf_event *event,
> >       if (!s390_pai_all_test(sample)) {
> >               pr_err("Invalid %s raw data encountered\n", pai_name);
> >       } else {
> > -             if (!evsel->pmu)
> > -                     evsel->pmu =3D perf_pmus__find_by_type(evsel->cor=
e.attr.type);
> > -             s390_pai_all_dump(evsel, sample);
> > +             if (!sample->evsel->pmu)
> > +                     sample->evsel->pmu =3D perf_pmus__find_by_type(sa=
mple->evsel->core.attr.type);
> > +             s390_pai_all_dump(sample);
> >       }
> >  }
> > --
> > 2.53.0.1213.gd9a14994de-goog
> >
