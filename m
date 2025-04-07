Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E561EE032
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056482; cv=none; b=odcKWUz4SkadP+BMXuhGVktzS/0xECKtwxLzj8Ct6cHhuCO51kfBidvnhsKC+qO2C1YFZ7rktuu/Vjzx6cWDsiDZxepQ3Sr6lK8PYoH2H8Zmj7UsjNKRyi27z7YZu0MxDdy1k1FH+1dOLT1DbziRQIRZdrfGfAJvSNzAXjDPoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056482; c=relaxed/simple;
	bh=Wdxj0RMJJbjbsiHjVVrnYK8H10Hqx5zGNUyAuRCHhjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7wcDwjxv1nk2wNj/Hu204ZhSQLgYp5zDglkTZO6E7eqFAVDlU9LQdiQw+PRnIdt9Ke9VFS8BXF1XLnvoMf7SHB7PTz78h4TYxKS4uNbAt4ftfsiMedYAP1rlOV5lJeFvH6go1l/zJmKIZJJerGSWfIu2/mlBW+qQe9h7De7QOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UbQzICul; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UbQzICul"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2263428c8baso10045ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744056480; x=1744661280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iU71LTnmTfjueDtizJoOvXCtaZuyhxwq3EymCCag3Xc=;
        b=UbQzICulue3R/SW9R2wbB7pzqjCOu7GidPxqte7OVMDti8VDapueFK8WMm+a/KoQxO
         UFsaTL/ifOAZFEHx7491BU5XKRBWL4sa+eX3DfkbYYhud51Hg9iOQ2nTjw9ZZk63PWwj
         BJNfSH/vXnTzskksedQ/yL4/wjvp975fpGLQQRB7MGvaPe3ePDHy4P1JbrgPWVS9NiuR
         JIfahUYERWtLZFsoz4gQwynoPN8VgsEX05UGl5djQz+mRYBmzIlmZNxhqovegTFJYpN4
         Hq7NWvwPUQPRA5zy//+FVXdL3kJ52CslhSvorgdxF2nyN+x+WEGxpSfDwBXmAb83IiVh
         OQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056480; x=1744661280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iU71LTnmTfjueDtizJoOvXCtaZuyhxwq3EymCCag3Xc=;
        b=YpD5zzhkp3iqFqhv4F5nGIb6usAv2xHG+WWdsJu/F8W8nobZEmuJ/lb/BxYcoDVHvp
         g50+heEiU6Zk7WrKQK3c5vWxQGmhQKBQmLwt77KEYeJpFwpxq8N+SNTyEpt5I/3DARgT
         FhVvwlf+rLmqwubAkf+UH1fj6wy7F1ykAVkVCzN8iDB1e3JobnvVyHKr2KcCPchMPfBe
         It++mcpDJKQagFBH6JxXEGlbcN2JHRVEP8/PHhUdOmj33T9KaVtkc9VvmWGHuLmK4XkQ
         eeoLpH0czNOgBfNWnYLjuJIQ1WCgF5DHkAaiLTf1F8Ot7ibOxc7HjiAQfvWg34QLOawO
         IYSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyQEOo1TCVnPPZMv6QruCxAfSuCDNEwHep8xM3TOILYpDUu7Vx6zXnQOteYErp7Wxh3IytYTg+CCso56BZZ1/h@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1hLckJ0AAWWZrrfb4/HhcytVUg1Fra/CRnbAjLQ8FHehvZBKg
	gCeYnpEcTeKTf0sPbEKpNBt3wsG29azvlmTxqipfB5jhcS+ZfTzwYgpcSvJFNG5v5kMLrC49nFt
	/urb4kbgu0OC0O7ftZMMwMzwj0RIyfOolD3gb
X-Gm-Gg: ASbGncvmBkEWksp+ndy5Zr8qHDgFZ6w4OB7uDGblEphJtixdfHB6hjJsKuhZUph0lRD
	WCAjr0OzaXXQ4KUXBnu7H/C9/c/5LPi3UiN4i3j5n/FWoUiVrbJzoK7zFwg8p2LabqHDp3jaWYZ
	bkxiZ1A0awDroCICzmbBkH9GL0CTNV06HKyke77VilzN9vJOMDP1hMYb0=
X-Google-Smtp-Source: AGHT+IHqZAwOhY7baA0xSHqDcUXrr1Ciqh9JILC2Oc/LH9HdzVIuFqICQeaCMOqUwhEOY+S/sT37MoaaAYqbF5WmtmE=
X-Received: by 2002:a17:903:41c8:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-22ab737816amr141665ad.21.1744056480060; Mon, 07 Apr 2025
 13:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com> <20250407050101.1389825-11-irogers@google.com>
 <b7e707fb-c362-4005-9ff5-e69928732eec@linux.intel.com>
In-Reply-To: <b7e707fb-c362-4005-9ff5-e69928732eec@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Apr 2025 13:07:49 -0700
X-Gm-Features: ATxdqUFD19vU3Tw0l-0eV6gDJvaOX1BW9RChGPpPQkhlOjp9isCAc59YsPRuKqs
Message-ID: <CAP-5=fVEmFPn-p_=1noG7sNMncS0MXcKqnZ=KqihfJp4YE2x4w@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] perf intel-tpebs: Add support for updating
 counts in evsel__tpebs_read
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, Howard Chu <howardchu95@gmail.com>, 
	Levi Yun <yeoreum.yun@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 12:37=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> > Rename to reflect evsel argument and for consistency with other tpebs
> > functions. Update count from prev_raw_counts when
> > available. Eventually this will allow inteval mode support.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/evsel.c       | 11 ++------
> >  tools/perf/util/intel-tpebs.c | 52 ++++++++++++++---------------------
> >  tools/perf/util/intel-tpebs.h |  2 +-
> >  3 files changed, 25 insertions(+), 40 deletions(-)
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 554252ed1aab..1d343f51225b 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -1718,11 +1718,6 @@ static int evsel__read_one(struct evsel *evsel, =
int cpu_map_idx, int thread)
> >       return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count)=
;
> >  }
> >
> > -static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx=
, int thread)
> > -{
> > -     return tpebs_set_evsel(evsel, cpu_map_idx, thread);
> > -}
> > -
> >  static void evsel__set_count(struct evsel *counter, int cpu_map_idx, i=
nt thread,
> >                            u64 val, u64 ena, u64 run, u64 lost)
> >  {
> > @@ -1730,8 +1725,8 @@ static void evsel__set_count(struct evsel *counte=
r, int cpu_map_idx, int thread,
> >
> >       count =3D perf_counts(counter->counts, cpu_map_idx, thread);
> >
> > -     if (counter->retire_lat) {
> > -             evsel__read_retire_lat(counter, cpu_map_idx, thread);
> > +     if (evsel__is_retire_lat(counter)) {
> > +             evsel__tpebs_read(counter, cpu_map_idx, thread);
> >               perf_counts__set_loaded(counter->counts, cpu_map_idx, thr=
ead, true);
> >               return;
> >       }
> > @@ -1889,7 +1884,7 @@ int evsel__read_counter(struct evsel *evsel, int =
cpu_map_idx, int thread)
> >               return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
> >
> >       if (evsel__is_retire_lat(evsel))
> > -             return evsel__read_retire_lat(evsel, cpu_map_idx, thread)=
;
> > +             return evsel__tpebs_read(evsel, cpu_map_idx, thread);
> >
> >       if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
> >               return evsel__read_group(evsel, cpu_map_idx, thread);
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index e3227646a9cc..452ce3698221 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -415,49 +415,39 @@ int evsel__tpebs_open(struct evsel *evsel)
> >       return ret;
> >  }
> >
> > -
> > -int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
> > +int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread=
)
> >  {
> > -     __u64 val;
> > +     struct perf_counts_values *count, *old_count =3D NULL;
> >       struct tpebs_retire_lat *t;
> > -     struct perf_counts_values *count;
> > +     uint64_t val;
> > +
> > +     /* Only set retire_latency value to the first CPU and thread. */
> > +     if (cpu_map_idx !=3D 0 || thread !=3D 0)
> > +             return 0;
> > +
> > +     if (evsel->prev_raw_counts)
> > +             old_count =3D perf_counts(evsel->prev_raw_counts, cpu_map=
_idx, thread);
> >
> > -     /* Non reitre_latency evsel should never enter this function. */
> > -     if (!evsel__is_retire_lat(evsel))
> > -             return -1;
> > +     count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> >
> >       /*
> >        * Need to stop the forked record to ensure get sampled data from=
 the
> >        * PIPE to process and get non-zero retire_lat value for hybrid.
> >        */
> >       tpebs_stop();
> > -     count =3D perf_counts(evsel->counts, cpu_map_idx, thread);
> >
> >       t =3D tpebs_retire_lat__find(evsel);
> > -
> > -     /* Set ena and run to non-zero */
> > -     count->ena =3D count->run =3D 1;
> > -     count->lost =3D 0;
> > -
> > -     if (!t) {
> > -             /*
> > -              * Set default value or 0 when retire_latency for this ev=
ent is
> > -              * not found from sampling data (record_tpebs not set or =
0
> > -              * sample recorded).
> > -              */
> > -             count->val =3D 0;
> > -             return 0;
> > +     val =3D rint(t->val);
> > +
> > +     if (old_count) {
> > +             count->val =3D old_count->val + val;
> > +             count->run =3D old_count->run + 1;
> > +             count->ena =3D old_count->ena + 1;
> > +     } else {
> > +             count->val =3D val;
> > +             count->run++;
> > +             count->ena++;
> >       }
>
> It seems utilizing the prev_raw_counts has been used in other place,
> e.g., hwmon_pmu. Is it possible to factor out a common function for it?

Thanks Kan, I also use it for the (unmerged) DRM PMU:
https://lore.kernel.org/lkml/20250403202439.57791-4-irogers@google.com/
I think adding a common function for this can be follow up work.

Thanks,
Ian

> Thanks,
> Kan> -
> > -     /*
> > -      * Only set retire_latency value to the first CPU and thread.
> > -      */
> > -     if (cpu_map_idx =3D=3D 0 && thread =3D=3D 0)
> > -             val =3D rint(t->val);
> > -     else
> > -             val =3D 0;
> > -
> > -     count->val =3D val;
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpeb=
s.h
> > index 5c671181ec60..218a82866cee 100644
> > --- a/tools/perf/util/intel-tpebs.h
> > +++ b/tools/perf/util/intel-tpebs.h
> > @@ -12,6 +12,6 @@ extern bool tpebs_recording;
> >
> >  int evsel__tpebs_open(struct evsel *evsel);
> >  void evsel__tpebs_close(struct evsel *evsel);
> > -int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
> > +int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread=
);
> >
> >  #endif /* __INTEL_TPEBS_H */
>
