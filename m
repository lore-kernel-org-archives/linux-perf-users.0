Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A78221568
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056230; cv=none; b=Wa4novllXVLHdEYpGw2W55Ngu38zyk4CTAaHqp87GCUbjOj9kXUMDYd6A9ZCx/f26l3FFe3C7mPgGyNe/vzg0dK6e0Xh+oXsoaDnye6o4PESg2ipzXfFzpb8nmccfgEvBkXwuYVe3jLoJ6EXneFrvlVwWHNTWJyYJgy8a/fKcK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056230; c=relaxed/simple;
	bh=cDrBYe6exV+m+ngF1awmy5VsoI1Vh0Wr4z3vXaz86Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhdKT6u28bgoYknKzNG7UwB035dEFRRXe34lkL+nzMwt9JFaUI/Z6v1MZfkm4E4f0iTaGRjpR4YSu7Emr7gVCLMiYOxpg9Uw5IXof4RbnvwfUbpjqDagWhFQj2W4dG1yobFE2DHQ7LfwJwjIuxNyB98TS3VxYkb4FW07lUk5zhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O5aqtGzn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5aqtGzn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2240aad70f2so62925ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 13:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744056228; x=1744661028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozXxQbmDOq0Ot53JLPwfP47E8G3cyUjGXbh5l0RkX3M=;
        b=O5aqtGznkqXV0BOG6jW0yttQfKoNCk6qRmnG/6GOHqF1qf/zfW9r467ak+rAUJUaRz
         z/aqWXj2KvRLP7zu+ESgWZfKpq2EqGx9yANcYQkMv/IW44G86fqmJjzJa0Rc47XnVAAW
         naCl3VFxUzAmPzSlOWM19Saz8KKCCIRmXPd+rTxrREa01w2PR6IUXmh6hqEZBEewkOzP
         fgvw4IZ6hS1F9OFRszf4XYqQWaF9bSWJKs0OQpiXY3RERwBavw3yVhvjdctTOTQp9CCS
         bZy7R9bqegDRGB7mFXMS2IdZfN/AaCQ+GWOkw9PnEKSaN/zgvRsYU3X2Qyyifl9y1eAy
         FAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056228; x=1744661028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozXxQbmDOq0Ot53JLPwfP47E8G3cyUjGXbh5l0RkX3M=;
        b=B7CZmXPmc8jsRjtkGJOjjCy0LDjbZXklj0z+EnZ2J3cEeWoi7JyjBPg8ESAGVVGJGe
         oQQrjxSlLuRYUlscVvqCgiECl7pr/Ey2hNB+d4/giuBWd70MgnOPvHkDgZn5M2tzOUcP
         f6ilaYpSaB/GELlQO8DTUTozjpOP3FTjAmaXYZS81ZABHDYTkWUQlG/LphGsE4s3o3J2
         idtQW3RcFRas48CzqywHMSItDwyJUgBvcf2U6Pj7VYh6+N+2AczU9kVa110ztQhyr2HF
         nva74Rx+RN5HSJpZwd6cZ48BEjmqpCL3Uyq1N2kUIy4beC8MOKXs+IJYTvqEOnrIrDaZ
         DsAg==
X-Forwarded-Encrypted: i=1; AJvYcCU39Hndxl+Hlq1czI1NfOo2YnqRyuBplSj9cjKrc86PRrsBMl1BtLCtBZ5+d6+aqit6wRyZQuQeh+q6VmIi2h0b@vger.kernel.org
X-Gm-Message-State: AOJu0YyfE7aAJL/yeO9iP3Eroo6TCA1/oCv2rZYOO3L9MXvYrTPdX6pB
	FUfibDx+xj5YOS5YpmS2EIFlFudC+it399jPEdSHohlAyYF88T14YhETQR3jD3NuC/x7TtDSGeA
	0BVPt/2qE6x11GfC9Zxx8ZOFXGA/ykUiLbOfl
X-Gm-Gg: ASbGnctlvGTvAMhXc93eIWM3JMipJ7pEvsOmcUAqQCAJHh3FMi1/Wjq1kZMIfJt6n4A
	XQ1o+Q4VxeFqCorwU1dOb/7unh6mV4kpMdzN5yFMxpFNOhvT0+4GKUhHsNUnw9frdGV5ZzLsAmq
	uT93MseQbKadx9Fn7PCffSk8Ub/EzcZYqzSNBbq2n7sXbh7NXumeOhD1s=
X-Google-Smtp-Source: AGHT+IGufJKe10g9MTTNBKZgHUWIeiRFsGalKKNSZj7CUIi6wlhtFBn8cQjNqApPJFba/dW65u+N3tzKRWP80h+fDg8=
X-Received: by 2002:a17:902:6bc8:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-22ab7254af4mr129095ad.15.1744056227537; Mon, 07 Apr 2025
 13:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com> <20250407050101.1389825-10-irogers@google.com>
 <7457b450-9f13-4528-b5e1-2f10f0a7be12@linux.intel.com>
In-Reply-To: <7457b450-9f13-4528-b5e1-2f10f0a7be12@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Apr 2025 13:03:36 -0700
X-Gm-Features: ATxdqUGaE0PXuQCl6QreV7WlAnObe8CtaTFNe2hNakuFY4MClb0XTiFs3vqRVTU
Message-ID: <CAP-5=fWj4aaT2VQNRVOZoqfJB-Cnjw05=PoAoi4DL9kqdhYA0g@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] perf intel-tpebs: Refactor tpebs_results list
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

On Mon, Apr 7, 2025 at 12:33=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> > evsel names and metric-ids are used for matching but this can be
> > problematic, for example, multiple occurrences of the same retirement
> > latency event become a single event for the record. Change the name of
> > the record events so they are unique and reflect the evsel of the
> > retirement latency event that opens them (the retirement latency
> > event's evsel address is embedded within them). This allows an evsel
> > based close to close the event when the retirement latency event is
> > closed. This is important as perf stat has an evlist and the session
> > listen to the record events has an evlist, knowing which event should
> > remove the tpebs_retire_lat can't be tied to an evlist list as there
> > is more than 1, so closing which evlist should cause the tpebs to
> > stop? Using the evsel and the last one out doing the tpebs_stop is
> > cleaner.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-stat.c     |   2 -
> >  tools/perf/util/evlist.c      |   1 -
> >  tools/perf/util/evsel.c       |   2 +-
> >  tools/perf/util/intel-tpebs.c | 152 ++++++++++++++++++++--------------
> >  tools/perf/util/intel-tpebs.h |   2 +-
> >  5 files changed, 94 insertions(+), 65 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 68ea7589c143..80e491bd775b 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -681,8 +681,6 @@ static enum counter_recovery stat_handle_error(stru=
ct evsel *counter)
> >       if (child_pid !=3D -1)
> >               kill(child_pid, SIGTERM);
> >
> > -     tpebs_delete();
> > -
> >       return COUNTER_FATAL;
> >  }
> >
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index c1a04141aed0..0a21da4f990f 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -183,7 +183,6 @@ void evlist__delete(struct evlist *evlist)
> >       if (evlist =3D=3D NULL)
> >               return;
> >
> > -     tpebs_delete();
> >       evlist__free_stats(evlist);
> >       evlist__munmap(evlist);
> >       evlist__close(evlist);
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 121283f2f382..554252ed1aab 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -2759,7 +2759,7 @@ int evsel__open(struct evsel *evsel, struct perf_=
cpu_map *cpus,
> >  void evsel__close(struct evsel *evsel)
> >  {
> >       if (evsel__is_retire_lat(evsel))
> > -             tpebs_delete();
> > +             evsel__tpebs_close(evsel);
> >       perf_evsel__close(&evsel->core);
> >       perf_evsel__free_id(&evsel->core);
> >  }
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index e42f3ec39a64..e3227646a9cc 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -35,10 +35,10 @@ static struct child_process tpebs_cmd;
> >
> >  struct tpebs_retire_lat {
> >       struct list_head nd;
> > -     /* Event name */
> > -     char *name;
> > -     /* Event name with the TPEBS modifier R */
> > -     const char *tpebs_name;
> > +     /** @evsel: The evsel that opened the retire_lat event. */
> > +     struct evsel *evsel;
> > +     /** @event: Event passed to perf record. */
> > +     char *event;
> >       /* Count of retire_latency values found in sample data */
> >       size_t count;
> >       /* Sum of all the retire_latency values in sample data */
> > @@ -49,6 +49,8 @@ struct tpebs_retire_lat {
> >       bool started;
> >  };
> >
> > +static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *e=
vsel);
> > +
> >  static int evsel__tpebs_start_perf_record(struct evsel *evsel, int con=
trol_fd[], int ack_fd[])
> >  {
> >       const char **record_argv;
> > @@ -85,7 +87,7 @@ static int evsel__tpebs_start_perf_record(struct evse=
l *evsel, int control_fd[],
> >
> >       list_for_each_entry(t, &tpebs_results, nd) {
> >               record_argv[i++] =3D "-e";
> > -             record_argv[i++] =3D t->name;
> > +             record_argv[i++] =3D t->event;
> >       }
> >       record_argv[i++] =3D NULL;
> >       assert(i =3D=3D 10 + 2 * tpebs_event_size || i =3D=3D 8 + 2 * tpe=
bs_event_size);
> > @@ -108,27 +110,20 @@ static int process_sample_event(const struct perf=
_tool *tool __maybe_unused,
> >                               struct evsel *evsel,
> >                               struct machine *machine __maybe_unused)
> >  {
> > -     int ret =3D 0;
> > -     const char *evname;
> >       struct tpebs_retire_lat *t;
> >
> > -     evname =3D evsel__name(evsel);
> > -
> > +     t =3D tpebs_retire_lat__find(evsel);
> > +     if (!t)
> > +             return -EINVAL;
> >       /*
> >        * Need to handle per core results? We are assuming average retir=
e
> >        * latency value will be used. Save the number of samples and the=
 sum of
> >        * retire latency value for each event.
> >        */
> > -     list_for_each_entry(t, &tpebs_results, nd) {
> > -             if (!strcmp(evname, t->name)) {
> > -                     t->count +=3D 1;
> > -                     t->sum +=3D sample->retire_lat;
> > -                     t->val =3D (double) t->sum / t->count;
> > -                     break;
> > -             }
> > -     }
> > -
> > -     return ret;
> > +     t->count +=3D 1;
> > +     t->sum +=3D sample->retire_lat;
> > +     t->val =3D (double) t->sum / t->count;
> > +     return 0;
> >  }
> >
> >  static int process_feature_event(struct perf_session *session,
> > @@ -183,50 +178,98 @@ static int tpebs_stop(void)
> >       return ret;
> >  }
> >
> > -static char *evsel__tpebs_name(struct evsel *evsel)
> > +/**
> > + * evsel__tpebs_event() - Create string event encoding to pass to `per=
f record`.
> > + */
> > +static int evsel__tpebs_event(struct evsel *evsel, char **event)
> >  {
> >       char *name, *modifier;
> > +     int ret;
> >
> >       name =3D strdup(evsel->name);
> > -     if (!name)
> > -             return NULL;
> > +     if (!*name)
> > +             return -ENOMEM;
>
> if (!name)?

Thanks! Will fix in v3.

Ian

> Thanks,
> Kan
>
> >
> >       modifier =3D strrchr(name, 'R');
> >       if (!modifier) {
> > -             pr_err("Tpebs event missing modifier '%s'\n", name);
> > -             free(name);
> > -             return NULL;
> > +             ret =3D -EINVAL;
> > +             goto out;
> >       }
> > -
> >       *modifier =3D 'p';
> > -     return name;
> > +     modifier =3D strchr(name, ':');
> > +     if (!modifier)
> > +             modifier =3D strrchr(name, '/');
> > +     if (!modifier) {
> > +             ret =3D -EINVAL;
> > +             goto out;
> > +     }
> > +     *modifier =3D '\0';
> > +     if (asprintf(event, "%s/name=3Dtpebs_event_%p/%s", name, evsel, m=
odifier + 1) > 0)
> > +             ret =3D 0;
> > +     else
> > +             ret =3D -ENOMEM;
> > +out:
> > +     if (ret)
> > +             pr_err("Tpebs event modifier broken '%s'\n", evsel->name)=
;
> > +     free(name);
> > +     return ret;
> >  }
> >
> >  static struct tpebs_retire_lat *tpebs_retire_lat__new(struct evsel *ev=
sel)
> >  {
> >       struct tpebs_retire_lat *result =3D zalloc(sizeof(*result));
> > +     int ret;
> >
> >       if (!result)
> >               return NULL;
> >
> > -     result->tpebs_name =3D evsel->name;
> > -     result->name =3D evsel__tpebs_name(evsel);
> > -     if (!result->name) {
> > +     ret =3D evsel__tpebs_event(evsel, &result->event);
> > +     if (ret) {
> >               free(result);
> >               return NULL;
> >       }
> > +     result->evsel =3D evsel;
> >       list_add_tail(&result->nd, &tpebs_results);
> >       return result;
> >  }
> >
> > +static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> > +{
> > +     zfree(&r->event);
> > +     free(r);
> > +}
> > +
> >  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *e=
vsel)
> >  {
> >       struct tpebs_retire_lat *t;
> > +     uint64_t num;
> > +     const char *evsel_name;
> >
> > +     /*
> > +      * Evsels will match for evlist with the retirement latency event=
. The
> > +      * name with "tpebs_event_" prefix will be present on events bein=
g read
> > +      * from `perf record`.
> > +      */
> > +     if (evsel__is_retire_lat(evsel)) {
> > +             list_for_each_entry(t, &tpebs_results, nd) {
> > +                     if (t->evsel =3D=3D evsel)
> > +                             return t;
> > +             }
> > +             return NULL;
> > +     }
> > +     evsel_name =3D strstr(evsel->name, "tpebs_event_");
> > +     if (!evsel_name) {
> > +             /* Unexpected that the perf record should have other even=
ts. */
> > +             return NULL;
> > +     }
> > +     errno =3D 0;
> > +     num =3D strtoull(evsel_name + 12, NULL, 16);
> > +     if (errno) {
> > +             pr_err("Bad evsel for tpebs find '%s'\n", evsel->name);
> > +             return NULL;
> > +     }
> >       list_for_each_entry(t, &tpebs_results, nd) {
> > -             if (t->tpebs_name =3D=3D evsel->name ||
> > -                 !strcmp(t->tpebs_name, evsel->name) ||
> > -                 (evsel->metric_id && !strcmp(t->tpebs_name, evsel->me=
tric_id)))
> > +             if ((uint64_t)t->evsel =3D=3D num)
> >                       return t;
> >       }
> >       return NULL;
> > @@ -363,8 +406,12 @@ int evsel__tpebs_open(struct evsel *evsel)
> >               close(ack_fd[0]);
> >               close(ack_fd[1]);
> >       }
> > -     if (ret)
> > -             tpebs_delete();
> > +     if (ret) {
> > +             struct tpebs_retire_lat *t =3D tpebs_retire_lat__find(evs=
el);
> > +
> > +             list_del_init(&t->nd);
> > +             tpebs_retire_lat__delete(t);
> > +     }
> >       return ret;
> >  }
> >
> > @@ -414,34 +461,19 @@ int tpebs_set_evsel(struct evsel *evsel, int cpu_=
map_idx, int thread)
> >       return 0;
> >  }
> >
> > -static void tpebs_retire_lat__delete(struct tpebs_retire_lat *r)
> > -{
> > -     zfree(&r->name);
> > -     free(r);
> > -}
> > -
> > -
> > -/*
> > - * tpebs_delete - delete tpebs related data and stop the created threa=
d and
> > - * process by calling tpebs_stop().
> > - *
> > - * This function is called from evlist_delete() and also from builtin-=
stat
> > - * stat_handle_error(). If tpebs_start() is called from places other t=
hen perf
> > - * stat, need to ensure tpebs_delete() is also called to safely free m=
em and
> > - * close the data read thread and the forked perf record process.
> > +/**
> > + * evsel__tpebs_close() - delete tpebs related data. If the last event=
, stop the
> > + * created thread and process by calling tpebs_stop().
> >   *
> > - * This function is also called in evsel__close() to be symmetric with
> > - * tpebs_start() being called in evsel__open(). We will update this ca=
ll site
> > - * when move tpebs_start() to evlist level.
> > + * This function is called in evsel__close() to be symmetric with
> > + * evsel__tpebs_open() being called in evsel__open().
> >   */
> > -void tpebs_delete(void)
> > +void evsel__tpebs_close(struct evsel *evsel)
> >  {
> > -     struct tpebs_retire_lat *r, *rtmp;
> > +     struct tpebs_retire_lat *t =3D tpebs_retire_lat__find(evsel);
> >
> > -     tpebs_stop();
> > +     tpebs_retire_lat__delete(t);
> >
> > -     list_for_each_entry_safe(r, rtmp, &tpebs_results, nd) {
> > -             list_del_init(&r->nd);
> > -             tpebs_retire_lat__delete(r);
> > -     }
> > +     if (list_empty(&tpebs_results))
> > +             tpebs_stop();
> >  }
> > diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpeb=
s.h
> > index cc98203719c8..5c671181ec60 100644
> > --- a/tools/perf/util/intel-tpebs.h
> > +++ b/tools/perf/util/intel-tpebs.h
> > @@ -11,7 +11,7 @@ struct evsel;
> >  extern bool tpebs_recording;
> >
> >  int evsel__tpebs_open(struct evsel *evsel);
> > -void tpebs_delete(void);
> > +void evsel__tpebs_close(struct evsel *evsel);
> >  int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
> >
> >  #endif /* __INTEL_TPEBS_H */
>
