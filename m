Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEFDDDC
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744650048; cv=none; b=td271ws/DOw8TmzVCf9Q2uJJwzVDJCwGbNCnYArZVFUsT7O/tztlA1cJfwgVcft+kl+5a1C5rZ+OihnGVBLpRGhNUc54THwON+pfwsgaT2gmZMJwEaTkJ4bvfdihymHt/o0DkYqFF2wLEM0GVl0vZmQmfqUOpuGVdRqS6rI5kdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744650048; c=relaxed/simple;
	bh=T3i3Ks6KYkqogNKePbw/HvYGCtTGpF8cMDelJPNuhvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOg64ZhCydvBnHhLKiuudq7QkerA+Mx4M1b1NwozL/7ZKEGA05n0SJLpo+3lhrLSKHhZkwknOxLXykUQT2B2LPJjOAOrRzKERat2KHP9PmlQYXHp6M4VBAcd3YD4PN4E3aHmueKBo/aYY7jsKnAbIf59bk2akBncwOquhcg2ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nRAu8Kqv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nRAu8Kqv"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2264c9d0295so8185ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Apr 2025 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744650046; x=1745254846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZgX0R3k7vRMomOHwpjZi0jdYMGFvDiknbY7T9HOMsQ=;
        b=nRAu8KqvQ4kS0ybZFtgBnISSWbLsavgoE6ks5AAv1dZc6o6EpGA4RAYLotdtL4AzUF
         NEq5ux1L25rfz3rzg2dQIQHEk4puS5olEBwZWLnakB2WBPg5RFdrF0J84IaKQKPfFibh
         pxztmAynaRj73jkUNfnFVG3ORCo0WIyJA55Ad4/sqJkqjLYLUhAQVS/y/jVTX+bC6rvR
         xKNFxuR1RqfOH4hZMhhxjV3qNaMGzj4bjBWUEMPja2UxLkkyg6aG1Y4PVqzQ446HJmVi
         4vvjEFl5CcoZ4TZ4OSZ7el45eDjaUCuJ6PwhhfOXwZ2Yhz5Dqtst//fOmQPcc/O8wGOO
         NqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744650046; x=1745254846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZgX0R3k7vRMomOHwpjZi0jdYMGFvDiknbY7T9HOMsQ=;
        b=imdFja4jmz1kFfrjthMD8ucYcl0XW/XN3u4lZYSEiCllwme7Q64J7QtYy9nfVWC7mV
         P/5d3w7vGEsdbRQ7T7SmjNY/Y615WPWqsOr36cPLi9XO/GsiGHlVzGV+4TgZQX8A3nX0
         8HwsdMe0/mZpS2+8zWhZkD4pQorpvaWytPnvxrl2+Nt3mqhru+W4C5LtT5epSSE0/Er3
         DJM6uATsHNGLCpp6cRW9y2Hhr5XPNOIErAOMzgJyp4ML37ot5S0wW6vfebDuYAaPOqLM
         OnLd0VGUbsdLdyx8MX50IlBcsv78/A5CN9actpKCJGYFd5y6YXtIKEWfBP/jLxamFB7G
         rUzg==
X-Forwarded-Encrypted: i=1; AJvYcCUycCjTjQfUly9TgBOhvXU/oFF8arKJWJELEAJ/Qnse8aghyVl6r23Nso2nb4zkDbr6IYTt1xB/JhhHoy+dq7RT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0DozZfXjkOHuVV6dM/udTy0y/t+qrElbLRHkO0+yDxHqMfR7T
	nuIEoVnB2Acmax2RSLfO3NZctdQeuJOa58MZQgyHt7sYLFJb4/U7aNPrLG+pUwWWiABmzvFJopZ
	wBfaWQzjMVCVMY/aPeaMkyQizoIzIyR9/hIQt
X-Gm-Gg: ASbGncv805TYZCF6YJYFpmQ/FnusIIDlV8UqoAMdmzXwdRkiyawp7oCxbmBczvr9jeI
	kqg221E1WG+MenpZBeKAUnPxT6JmsyZGSaTSLqrmn3drzXo75Pq2FrXom/F2omy+teaHiiU8xLj
	hs6n2rWxbtT61QhOgOqBPFhglln7KTXdMmQ4gkN82IQR5ccgPP9OQ=
X-Google-Smtp-Source: AGHT+IHbWnNScRnDC9p2CxmWIsPBssiO6wqSRUmKycp5VifarINCOYVDkALgNzE72DCmcrUWFYaAK9lIrLJeqLkXimQ=
X-Received: by 2002:a17:903:230b:b0:215:42a3:e844 with SMTP id
 d9443c01a7336-22bf52cef09mr4902755ad.17.1744650045179; Mon, 14 Apr 2025
 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409061043.700792-1-irogers@google.com> <20250409061043.700792-12-irogers@google.com>
 <Z_mdvahT2i6djhj1@z2>
In-Reply-To: <Z_mdvahT2i6djhj1@z2>
From: Ian Rogers <irogers@google.com>
Date: Mon, 14 Apr 2025 10:00:34 -0700
X-Gm-Features: ATxdqUGBZuUbvz6xLLwag4Dc8Fd8WOuz04UChczVE7TzS6jr-r-Ohiw-pMK6PnI
Message-ID: <CAP-5=fWWiodHK1e6MsMfNXd=vNsHN5VTg9QOViH+2OF8d7FBZg@mail.gmail.com>
Subject: Re: [PATCH v4 11/16] perf intel-tpebs: Add mutex for tpebs_results
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Apr 08, 2025 at 11:10:38PM -0700, Ian Rogers wrote:
> > Ensure sample reader isn't racing with events being added/removed.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index f648fca17556..c5ccdbc42dc6 100644
> > --- a/tools/perf/util/intel-tpebs.c
> > +++ b/tools/perf/util/intel-tpebs.c
> > @@ -16,6 +16,7 @@
> >  #include "debug.h"
> >  #include "evlist.h"
> >  #include "evsel.h"
> > +#include "mutex.h"
> >  #include "session.h"
> >  #include "tool.h"
> >  #include "cpumap.h"
> > @@ -32,6 +33,7 @@ bool tpebs_recording;
> >  static LIST_HEAD(tpebs_results);
> >  static pthread_t tpebs_reader_thread;
> >  static struct child_process tpebs_cmd;
> > +static struct mutex tpebs_mtx;
> >
> >  struct tpebs_retire_lat {
> >       struct list_head nd;
> > @@ -51,6 +53,19 @@ struct tpebs_retire_lat {
> >
> >  static struct tpebs_retire_lat *tpebs_retire_lat__find(struct evsel *e=
vsel);
> >
> > +static void tpebs_mtx_init(void)
> > +{
> > +     mutex_init(&tpebs_mtx);
> > +}
> > +
> > +static struct mutex *tpebs_mtx_get(void)
> > +{
> > +     static pthread_once_t tpebs_mtx_once =3D PTHREAD_ONCE_INIT;
> > +
> > +     pthread_once(&tpebs_mtx_once, tpebs_mtx_init);
> > +     return &tpebs_mtx;
> > +}
> > +
> >  static int evsel__tpebs_start_perf_record(struct evsel *evsel, int con=
trol_fd[], int ack_fd[])
> >  {
> >       const char **record_argv;
> > @@ -59,13 +74,15 @@ static int evsel__tpebs_start_perf_record(struct ev=
sel *evsel, int control_fd[],
> >       char cpumap_buf[50];
> >       struct tpebs_retire_lat *t;
> >
> > +     mutex_lock(tpebs_mtx_get());
> >       list_for_each_entry(t, &tpebs_results, nd)
> >               tpebs_event_size++;
> >
> >       record_argv =3D malloc((10 + 2 * tpebs_event_size) * sizeof(*reco=
rd_argv));
> > -     if (!record_argv)
> > +     if (!record_argv) {
> > +             mutex_unlock(tpebs_mtx_get());
> >               return -ENOMEM;
> > -
> > +     }
> >       record_argv[i++] =3D "perf";
> >       record_argv[i++] =3D "record";
> >       record_argv[i++] =3D "-W";
> > @@ -101,6 +118,7 @@ static int evsel__tpebs_start_perf_record(struct ev=
sel *evsel, int control_fd[],
> >       list_for_each_entry(t, &tpebs_results, nd)
> >               t->started =3D true;
> >
> > +     mutex_unlock(tpebs_mtx_get());
> >       return ret;
> >  }
> >
> > @@ -112,9 +130,12 @@ static int process_sample_event(const struct perf_=
tool *tool __maybe_unused,
> >  {
> >       struct tpebs_retire_lat *t;
> >
> > +     mutex_lock(tpebs_mtx_get());
> >       t =3D tpebs_retire_lat__find(evsel);
> > -     if (!t)
> > +     if (!t) {
> > +             mutex_unlock(tpebs_mtx_get());
> >               return -EINVAL;
> > +     }
> >       /*
> >        * Need to handle per core results? We are assuming average retir=
e
> >        * latency value will be used. Save the number of samples and the=
 sum of
> > @@ -123,6 +144,7 @@ static int process_sample_event(const struct perf_t=
ool *tool __maybe_unused,
> >       t->count +=3D 1;
> >       t->sum +=3D sample->retire_lat;
> >       t->val =3D (double) t->sum / t->count;
> > +     mutex_unlock(tpebs_mtx_get());
> >       return 0;
> >  }
> >
> > @@ -229,7 +251,6 @@ static struct tpebs_retire_lat *tpebs_retire_lat__n=
ew(struct evsel *evsel)
> >               return NULL;
> >       }
> >       result->evsel =3D evsel;
> > -     list_add_tail(&result->nd, &tpebs_results);
> >       return result;
> >  }
> >
> > @@ -282,16 +303,22 @@ static struct tpebs_retire_lat *tpebs_retire_lat_=
_find(struct evsel *evsel)
> >  static int evsel__tpebs_prepare(struct evsel *evsel)
> >  {
> >       struct evsel *pos;
> > -     struct tpebs_retire_lat *tpebs_event =3D tpebs_retire_lat__find(e=
vsel);
> > +     struct tpebs_retire_lat *tpebs_event;
> >
> > +     mutex_lock(tpebs_mtx_get());
> > +     tpebs_event =3D tpebs_retire_lat__find(evsel);
> >       if (tpebs_event) {
> >               /* evsel, or an identically named one, was already prepar=
ed. */
> > +             mutex_unlock(tpebs_mtx_get());
> >               return 0;
> >       }
> >       tpebs_event =3D tpebs_retire_lat__new(evsel);
> >       if (!tpebs_event)
> >               return -ENOMEM;
>
> The mutex_unlock() is missing here.

Good catch, I'll fix in v5. Fwiw cleanups would have avoided this.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> > +     list_add_tail(&tpebs_event->nd, &tpebs_results);
> > +     mutex_unlock(tpebs_mtx_get());
> > +
> >       /*
> >        * Eagerly prepare all other evsels on the list to try to ensure =
that by
> >        * open they are all known.
> > @@ -317,6 +344,7 @@ static int evsel__tpebs_prepare(struct evsel *evsel=
)
> >  int evsel__tpebs_open(struct evsel *evsel)
> >  {
> >       int ret;
> > +     bool tpebs_empty;
> >
> >       /* We should only run tpebs_start when tpebs_recording is enabled=
. */
> >       if (!tpebs_recording)
> > @@ -336,7 +364,10 @@ int evsel__tpebs_open(struct evsel *evsel)
> >       if (ret)
> >               return ret;
> >
> > -     if (!list_empty(&tpebs_results)) {
> > +     mutex_lock(tpebs_mtx_get());
> > +     tpebs_empty =3D list_empty(&tpebs_results);
> > +     mutex_unlock(tpebs_mtx_get());
> > +     if (!tpebs_empty) {
> >               struct pollfd pollfd =3D { .events =3D POLLIN, };
> >               int control_fd[2], ack_fd[2], len;
> >               char ack_buf[8];
> > @@ -436,8 +467,10 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu=
_map_idx, int thread)
> >        */
> >       tpebs_stop();
> >
> > +     mutex_lock(tpebs_mtx_get());
> >       t =3D tpebs_retire_lat__find(evsel);
> >       val =3D rint(t->val);
> > +     mutex_unlock(tpebs_mtx_get());
> >
> >       if (old_count) {
> >               count->val =3D old_count->val + val;
> > @@ -460,9 +493,13 @@ int evsel__tpebs_read(struct evsel *evsel, int cpu=
_map_idx, int thread)
> >   */
> >  void evsel__tpebs_close(struct evsel *evsel)
> >  {
> > -     struct tpebs_retire_lat *t =3D tpebs_retire_lat__find(evsel);
> > +     struct tpebs_retire_lat *t;
> >
> > +     mutex_lock(tpebs_mtx_get());
> > +     t =3D tpebs_retire_lat__find(evsel);
> > +     list_del_init(&t->nd);
> >       tpebs_retire_lat__delete(t);
> > +     mutex_unlock(tpebs_mtx_get());
> >
> >       if (list_empty(&tpebs_results))
> >               tpebs_stop();
> > --
> > 2.49.0.504.g3bcea36a83-goog
> >
