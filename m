Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287CE22ACFB
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 20:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056616; cv=none; b=Ltu1lP+j5lzFlsxiVzxZMtu4SwoSN7XC92yORnY833ETqBbImIWfvx/M3zv85UUvxn9Diusr5Hl9KKtbFJP3wfnk9EKpihfZpcVxaODJINs+gV9jBfSdnM72QhN8/yKSzbrFLjvoovW0vcDce5Xj9j0oVFcoEuCbNF6QclV8N3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056616; c=relaxed/simple;
	bh=XK+Af6O6Hgo87rDFwo5UDElsSKT3WIcxVBFG+7S95I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUHhz1hRGr+tdskzRHd7sgtdbq/9ychF46YTWl9jdc7FSZ+m9U0kr2NDXF+iO/8BbKiuQo7X/puBfloZ7xw0qcG/LPmc7XKAoTMdWUZup2r6yjhdKfDJrmw/LmXYYywWJeMBDjYCxEOBZFOfg+VZj8b/R1XKC6apy/dLK1wJWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OEvaoENE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OEvaoENE"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2263428c8baso10625ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Apr 2025 13:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744056613; x=1744661413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sbJLbDgV00YszfDeeq8tXF6PpKgxMF6D2zjsFK2NWE=;
        b=OEvaoENEPxTjOBaRsDtV2wxGzKNoq5IPrLg13mqhuhtU6iMZaiZhhzzeZ5/cpit6Ej
         HyWh3k1+tgaTrrvBivPv/9I4GHjGsg3uB59zN7PE6XMNuRXhQTMu8gUK4/YTgz5mdsvN
         CZ/dR6K08ivqdJk6gx7C+XzcATIRzA4f8nQhIlo/SdkV57dUYgsVZppTd8U6xwprGxzR
         cj9ZD4yekLn5H2baY5KZWRoNZO/VD/1ZDZnuYaeEu3nphkU8RQS48c2q9aPxHeJvJfVF
         nTQIY3nXFbnI+5haEhQxDDUl0u0OrJaNVmnlqbNFbCyt8pSmEU5Qt+xK0DuX4RJ6xYHD
         qW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744056613; x=1744661413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7sbJLbDgV00YszfDeeq8tXF6PpKgxMF6D2zjsFK2NWE=;
        b=hqUb1ImjxeiWAZy/llKFX8XZoAQchAGBITcG7jSpWih6brouokfz4PmQHcft9i5sDf
         ZeTyag68S4RbJn6ssbCJSxrgae6DjO9LDVSnGiaQ84peDq/0VY+jRbhfof+mOBGGht8C
         GvwBY3y54wU/BHvpirhzLk6ecKHA8p8fuFI9qjtQMoYNpZ74ml0vv5PZWgbRaiWHo2Fw
         xQPONFyihC3bEcWJ3N7oll2nyNbkW51rTIdbaYWlMzC/MFxyvlGHC4rPiyZ6zbH0CJEU
         xdQjfMg96ovkutFVvT1SZ3glTUt4fiF+AMhV3tFL6TyhS+a7Qv1vo1hxr2mPDOoVFQiO
         eRnA==
X-Forwarded-Encrypted: i=1; AJvYcCUE7dmsxe3qyhKC+Z9dRRIjdwYOlhxEr+ljiCoBTFmTei59si1YfauNDHPnp+p8uu6fACb+b9WpD/RvzZStdrjW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho9l0hJh4OV/6MviQ6EZNq2Rfny8sHHsuI7VnFvRCp8hvHryn
	t3DWiionntpLXqRaNctWlpwfIW+kojoN8Ou1hLM4zdGJXb/FVikd5EF6FC9C+oYHzjqTdIc6T2r
	0/qQud91VvfD0c4EqBTsu4G0nSX9yw/rcfiNg
X-Gm-Gg: ASbGncuvoTJ3F8xr6QMwG4t/ZzNFnpeqRYtozGYm7PDJzNcsdSWRFvAkCjM5YhW3s68
	U2oRJWCsIxOCGuNTbGuvrIQSPjgjd0xh4NVyqK6li+/xQXbTtqqEJXbxScK8/9tS+5Z8vTQy8gL
	rxwKWQEMsDsEaj/+wlzD5IgT4rKlFaibp9uf9a4pn97pWxgfJ+0Qit72Y=
X-Google-Smtp-Source: AGHT+IG3pfQ60naXGCzm339BeOD/nJbzOmZwFIQ5VsId9IK+f2StEPUia7MLAQXM7gWryiHf1gg4/LenqCMIQ7uu1Gs=
X-Received: by 2002:a17:903:41c8:b0:21f:9f4:4a03 with SMTP id
 d9443c01a7336-22ab737816amr150715ad.21.1744056613089; Mon, 07 Apr 2025
 13:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407050101.1389825-1-irogers@google.com> <20250407050101.1389825-12-irogers@google.com>
 <26916c80-f42b-47a4-8d6e-7d9b3d84163a@linux.intel.com>
In-Reply-To: <26916c80-f42b-47a4-8d6e-7d9b3d84163a@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 7 Apr 2025 13:10:02 -0700
X-Gm-Features: ATxdqUGL1XcrAwjQ0IU_b8XRRekjF67B4j5scWzRqgq2MrEr7A4b8-BgCGDLrjg
Message-ID: <CAP-5=fUVu1nhSZ2KehLdEMTHCW393EXuk3UjnNjwBpe4EOMt4w@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] perf intel-tpebs: Add mutex for tpebs_results
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

On Mon, Apr 7, 2025 at 12:49=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> > Ensure sample reader isn't racing with events being added/removed.
>
> Is it a bug fix?
>
> I think the tpebs have been merged for a while. Should the backport be
> required?

Because things like interval mode aren't currently working with tpebs
I think the issues that could arise are minimal. A fixes tag would
drag in this whole series and I'm not sure that's what we want.

Thanks,
Ian

> Thanks,
> Kan>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/intel-tpebs.c | 51 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 44 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpeb=
s.c
> > index 452ce3698221..29616d087bce 100644
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
>
