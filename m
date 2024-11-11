Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A01A2567
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731349232; cv=none; b=MZtyxNqrG36zQvjWvU611kTQ5VBxS/zrw97Rl6CdKTVjvlBSQGYEDr7JL8ZwQ7TGFh2nsN5xFY9C+kUuguajPt62FGX06VLZQ0x0RfghggPLe4qhH9G+UtO0zNp87oUasauox1zCvZagod6chs7v4xj177vMjR/ahF+NWgExWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731349232; c=relaxed/simple;
	bh=BjBfjJdldjSvoJiOX4p+lvkjb82Phfr9vuxzVSaa6Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sOt9S093lasGJ765OPZq/2ZTceBS/vxOIzOQ8LyDKmPSxhjvVEttr8FyaExmEteWJjBpWEzKTDnzljW4XqtMrMHLBr2eOerReLvTTorgE798wMeBU9wGZserCERWa4a0/RrsmFR5k4IL6UoXsRuCkbA8BiONYPyM1PvJ/McEkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBZl4qAW; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBZl4qAW"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a4e4776f79so7545ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731349229; x=1731954029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3sA5IBP5XfCzOqDGRj5yXsIlkQEa9Ya5EuikdBBSd8=;
        b=NBZl4qAWDIbK3jylnwZ96f2EEgC1GI7sivkrnhqHX0qp49ffyGKyuNRadKYvQGvHGq
         dX6bfUOvAj1k58IZx0xc4I44xc9wr65z/Nt1QsRGfl7pZPlz7U5BKzBMfo2wLmSUrcMb
         l6GhX4dCnn/zkCQxZs6IJhP7Cv2Gx0jmuJV7pm/Q34gNYjvV+u4xTUByh6T35hLuFDi7
         +hHD01L9KY64D3Hr43fA/XLYWlvOMM2fOylcHSuWRYm5duBfj5oaXcsGtgnFct2eoins
         5M8bGRJK2k50VQvR7Tc5zeO8u9RQ8S5dUfCKuqzy1wRAe20piWdxKBCXOECrIfrRcSJk
         Usdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731349229; x=1731954029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3sA5IBP5XfCzOqDGRj5yXsIlkQEa9Ya5EuikdBBSd8=;
        b=csS0i9XAZknD3wvxw2pHnSFxKzJxriW/tVGSBbCjkiJQTey7SAOY6Qjofm+Rhad360
         uX0d6npr44gwSTEp1hpghK9wAoO1WgVc1mewZ4X61E43ZoEGPreTKjIy0OvYptEXisqO
         BXPFNEYHqRVr+UaW8Y4/AlmpHP2+TlT9NdNtBxoOv+BlSP+koSUzKhW56rR5yZxJWyuL
         gSdGzeMmE5Yt8uiCEfQ3kqgNPJrQfc5Jeavif3iExWZaBBEJxkqKRmpu2HtDk8eoZSPH
         StdlImXtgqmIg+c47sexOrB+Q382xmsG89HKiGbTO+r3I1EM6IZflKNK/pFbyOqgXiWp
         0d/w==
X-Forwarded-Encrypted: i=1; AJvYcCUHPaFqMon4yNqKrRpU3BiMRsZtNNXJYq1ASNzKHQAf7VQztmM2h0joSJFlZC8sf3DOEO+Qv+dYrXlK+EpBjRD2@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3YCExlivVLb9LfgUS6KuSvOUEskiZTeDYGIu9oa8kPjZfP92
	vCNJphPmGbaWycGgy1roOJRaStwIeI0sR/w5kf59adnEvZ4SPmx4PsK0uLcHmxKT8sp9VZUYL6h
	Aty3rYGDjScuQhwCi5c6fRpUqYAMCK+XKzaSd
X-Gm-Gg: ASbGncsQYNEmRurJ7lZvRV5KcCoIPaKfZixsNoBEKZcv5CbiS4ZcKifskMPqJrA8awX
	/XaC48ZmmRlK1vi0Aq10i5GtesDtVbYz9hJ1yjPV/Aqt5GQfRreHAu+BvCfBfhB8=
X-Google-Smtp-Source: AGHT+IE6rUjryIlk/oYvovqa8d72bal0qewnNOnb64tZJbTtsQ71iPHXvuK4GcoX5nuQMqeVgHtcmzmOzdXp+73DabY=
X-Received: by 2002:a05:6e02:1605:b0:3a6:b0a3:540b with SMTP id
 e9e14a558f8ab-3a6f8a97e8fmr7719985ab.20.1731349229254; Mon, 11 Nov 2024
 10:20:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109025801.560378-1-irogers@google.com> <7676a058-e7ae-4c6b-a9f8-be450b64f5e1@linux.intel.com>
 <ZzJAQeHqFT_Z9JiW@x1>
In-Reply-To: <ZzJAQeHqFT_Z9JiW@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 10:20:18 -0800
Message-ID: <CAP-5=fXEe+O+pctnO-MhCLrX071uvkLzA-L9AWP=LR81YKYG6Q@mail.gmail.com>
Subject: Re: [PATCH v1] perf list: Fix topic and pmu_name argument order
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 9:35=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Nov 11, 2024 at 09:48:41AM -0500, Liang, Kan wrote:
> >
> >
> > On 2024-11-08 9:58 p.m., Ian Rogers wrote:
> > > From: Jean-Philippe Romain <jean-philippe.romain@foss.st.com>
> > >
> > > Fix function definitions to match header file declaration. Fix two
> > > callers to pass the arguments in the right order.
> > >
> > > On Intel Tigerlake, before:
> > > ```
> > > $ perf list -j|grep "\"Topic\""|sort|uniq
> > >         "Topic": "cache",
> > >         "Topic": "cpu",
> > >         "Topic": "floating point",
> > >         "Topic": "frontend",
> > >         "Topic": "memory",
> > >         "Topic": "other",
> > >         "Topic": "pfm icl",
> > >         "Topic": "pfm ix86arch",
> > >         "Topic": "pfm perf_raw",
> > >         "Topic": "pipeline",
> > >         "Topic": "tool",
> > >         "Topic": "uncore interconnect",
> > >         "Topic": "uncore memory",
> > >         "Topic": "uncore other",
> > >         "Topic": "virtual memory",
> > > $ perf list -j|grep "\"Unit\""|sort|uniq
> > >         "Unit": "cache",
> > >         "Unit": "cpu",
> > >         "Unit": "cstate_core",
> > >         "Unit": "cstate_pkg",
> > >         "Unit": "i915",
> > >         "Unit": "icl",
> > >         "Unit": "intel_bts",
> > >         "Unit": "intel_pt",
> > >         "Unit": "ix86arch",
> > >         "Unit": "msr",
> > >         "Unit": "perf_raw",
> > >         "Unit": "power",
> > >         "Unit": "tool",
> > >         "Unit": "uncore_arb",
> > >         "Unit": "uncore_clock",
> > >         "Unit": "uncore_imc_free_running_0",
> > >         "Unit": "uncore_imc_free_running_1",
> > > ```
> > >
> > > After:
> > > ```
> > > $ perf list -j|grep "\"Topic\""|sort|uniq
> > >         "Topic": "cache",
> > >         "Topic": "floating point",
> > >         "Topic": "frontend",
> > >         "Topic": "memory",
> > >         "Topic": "other",
> > >         "Topic": "pfm icl",
> > >         "Topic": "pfm ix86arch",
> > >         "Topic": "pfm perf_raw",
> > >         "Topic": "pipeline",
> > >         "Topic": "tool",
> > >         "Topic": "uncore interconnect",
> > >         "Topic": "uncore memory",
> > >         "Topic": "uncore other",
> > >         "Topic": "virtual memory",
> > > $ perf list -j|grep "\"Unit\""|sort|uniq
> > >         "Unit": "cpu",
> > >         "Unit": "cstate_core",
> > >         "Unit": "cstate_pkg",
> > >         "Unit": "i915",
> > >         "Unit": "icl",
> > >         "Unit": "intel_bts",
> > >         "Unit": "intel_pt",
> > >         "Unit": "ix86arch",
> > >         "Unit": "msr",
> > >         "Unit": "perf_raw",
> > >         "Unit": "power",
> > >         "Unit": "tool",
> > >         "Unit": "uncore_arb",
> > >         "Unit": "uncore_clock",
> > >         "Unit": "uncore_imc_free_running_0",
> > >         "Unit": "uncore_imc_free_running_1",
> > > ```
> > >
> > > Fixes: e5c6109f4813 ("perf list: Reorganize to use callbacks to allow=
 honouring command line options")
> > > Signed-off-by: Jean-Philippe Romain <jean-philippe.romain@foss.st.com=
>
> > > Tested-by: Ian Rogers <irogers@google.com>
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> > > ---
> > > Note from Ian, I fixed the two callers and added it to
> > > Jean-Phillippe's original change.
>
> I think that in this case we need:
>
> [ I fixed the two callers and added it to Jean-Phillippe's original chang=
e. ]
> Signed-off-by: Ian Rogers <irogers@google.com>
>
> Ok?

Sgtm.

Thanks,
Ian

> > > ---
> > >  tools/perf/builtin-list.c | 4 ++--
> > >  tools/perf/util/pfm.c     | 4 ++--
> > >  tools/perf/util/pmus.c    | 2 +-
> > >  3 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > > index b8378ba18c28..9e7fdfcdd7ff 100644
> > > --- a/tools/perf/builtin-list.c
> > > +++ b/tools/perf/builtin-list.c
> > > @@ -113,7 +113,7 @@ static void wordwrap(FILE *fp, const char *s, int=
 start, int max, int corr)
> > >     }
> > >  }
> > >
> > > -static void default_print_event(void *ps, const char *pmu_name, cons=
t char *topic,
> > > +static void default_print_event(void *ps, const char *topic, const c=
har *pmu_name,
> > >                             const char *event_name, const char *event=
_alias,
> > >                             const char *scale_unit __maybe_unused,
> > >                             bool deprecated, const char *event_type_d=
esc,
> > > @@ -354,7 +354,7 @@ static void fix_escape_fprintf(FILE *fp, struct s=
trbuf *buf, const char *fmt, ..
> > >     fputs(buf->buf, fp);
> > >  }
> > >
> > > -static void json_print_event(void *ps, const char *pmu_name, const c=
har *topic,
> > > +static void json_print_event(void *ps, const char *topic, const char=
 *pmu_name,
> > >                          const char *event_name, const char *event_al=
ias,
> > >                          const char *scale_unit,
> > >                          bool deprecated, const char *event_type_desc=
,
> > > diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
> > > index 5ccfe4b64cdf..0dacc133ed39 100644
> > > --- a/tools/perf/util/pfm.c
> > > +++ b/tools/perf/util/pfm.c
> > > @@ -233,7 +233,7 @@ print_libpfm_event(const struct print_callbacks *=
print_cb, void *print_state,
> > >     }
> > >
> > >     if (is_libpfm_event_supported(name, cpus, threads)) {
> > > -           print_cb->print_event(print_state, pinfo->name, topic,
> > > +           print_cb->print_event(print_state, topic, pinfo->name,
> > >                                   name, info->equiv,
> > >                                   /*scale_unit=3D*/NULL,
> > >                                   /*deprecated=3D*/NULL, "PFM event",
> > > @@ -267,8 +267,8 @@ print_libpfm_event(const struct print_callbacks *=
print_cb, void *print_state,
> > >                             continue;
> > >
> > >                     print_cb->print_event(print_state,
> > > -                                   pinfo->name,
> > >                                     topic,
> > > +                                   pinfo->name,
> > >                                     name, /*alias=3D*/NULL,
> > >                                     /*scale_unit=3D*/NULL,
> > >                                     /*deprecated=3D*/NULL, "PFM event=
",
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index 107de86c2637..6d4c7c9ecf3a 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -501,8 +501,8 @@ void perf_pmus__print_pmu_events(const struct pri=
nt_callbacks *print_cb, void *p
> > >                     goto free;
> > >
> > >             print_cb->print_event(print_state,
> > > -                           aliases[j].pmu_name,
> > >                             aliases[j].topic,
> > > +                           aliases[j].pmu_name,
> > >                             aliases[j].name,
> > >                             aliases[j].alias,
> > >                             aliases[j].scale_unit,
