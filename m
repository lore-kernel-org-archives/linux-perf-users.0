Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE70433A6
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Jun 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749233605; cv=none; b=bp7DYrBJ1won7mqolebLaSBU0teQUuM6bMyzZVYlJC9C/GEmPvhVcHLAUUvYjBwsRzVh/fDfgNWEAIvD9PUf9+l+OgYhQpDiYr7wsEvDdjuE5sY+y8RQ1lNO/eDxxDwVgW5r5Kb2tYusqnB6k14q/FIkaRntRZvumSSTYvRC+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749233605; c=relaxed/simple;
	bh=uOgM+clqQQCqi8eGfdAcZYzgfyhN44h7yJUkAF6YUdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIU+7N0u/vvXriC1LF1UNH/JcuaU1sE3EKgoPw7kgw/8Tv/dx4SY3jDaomN8OawSqNCi9vugWPPhWHJcW1/vLCSwgv9jynKZoHOlZBuR1nOsmN2F2lDYGHxyrU2Yo/0cFEijlGysxm6CWhiSP8l0aMpHdOP4AjoCgnnNf11SGdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lST+aomr; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lST+aomr"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so18025ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Jun 2025 11:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749233602; x=1749838402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zt8+YlsWUWtVNI1tXIPQN5PMXhCaHc68mpFbT3w923o=;
        b=lST+aomrFtI0yu2pTptD6br2jY6FgNKG9Wv5Wls9Njm4E7/kSeJugLMd8lDYxGOIfr
         EJTP6llHqgFzYvO6vc45Y9dJg1dv1eH2CPdPdqhbUeWUeE6CUzcPXlJOQPYxQajN+P1O
         Ew5l8qNKSX2AaTBTCW00VOoVi9m2/gizCKHwGCbRBwpfnuWzsGvo8vlFan8AVVCC2gdk
         Z3WYXpGuC7uIeCcL+oCyDBBUEy1s6n6EOacDi0irJMZtkrpXeOUV8PJ0EWFF3iaszCt8
         T3BzgG87gzCX7BXEWQeDDIq7zvl31gGqBtQ3Q9pJdnozckjS7Ke7G1p8tVFj+LD2biyr
         GFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749233602; x=1749838402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zt8+YlsWUWtVNI1tXIPQN5PMXhCaHc68mpFbT3w923o=;
        b=VIK8vJTUza/8PkOAdlSiiBZTK6AJzu+wRAsnfQy36DcSP3AeYR7PxJgUhnCihSLhmi
         7tQWgBB1OEPmnPDZNQ9PdqfSng3mfWOg0iBT/3mywHR81fuZmkBC9Vvp+s7KHctc7o2s
         QczkO3r0O+HOg9TlAJnOMVZqY15U29Y9suZ/DfTxrjTEGxdKx6oFkYg+pnhMOvPhyI3/
         eipNEZjG5o7dwx7DEjc4/NInVaGVREtbxo5tHgV4IfQMraChRd+e7Va4di/Uz59PZO9y
         T5gozqqcznxmu72xiuBLkHJxwPtS9Lt+mTGZHq7O6bFgWYSvyKEONDWu07BXUxZNK1Ik
         3+1g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3GnFIDvllzDs6Qyi/9tYUds5pKlLZWzvW5iw45emB4WYrg36hIMdqejVakFeWtCN2z8N8d/bJt1Q3gNgOJ0/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgs8ymy34g+bGI7UdVa3qFgJcUfseKivYULrXUwFOS16twfvst
	s1A7VxZTi/9raZ1/XGl2RjaQvFslF6RJDsTfHM826fb8ChbZ+n77W0fdhgYxkIAZKCMFiaWnSU/
	R+4nBHhXUTDSTOv3EAMLAtm29w1387dkwXbg/Leti
X-Gm-Gg: ASbGncvH+1Zowkv6kzz2ZmMBCtL0cqKiobcFeqZ4NpGmO7F8C3IIWydx23DAVF77Srq
	98ja2A1pbsHHhabacE0Lei3ZbWvw5iy8KYFfwsaoUH4fuQHC0KlSXC1L9gAtmsLyHMIAlaQxp3c
	DrP7X8OjME0gzM6j3byuPaO8sZS6sjy0p1HwB5+AwY0Ewh
X-Google-Smtp-Source: AGHT+IEP1tIKhbdH4lqSSc295DJ6xTef6f7Idag/2cBRhGqPw5sYxBJgOV57opfblDqW6p+d7sX840GMamXgEQHqKMA=
X-Received: by 2002:a05:6e02:4416:10b0:3dd:bdcc:5b29 with SMTP id
 e9e14a558f8ab-3ddd766ba6amr92655ab.21.1749233601372; Fri, 06 Jun 2025
 11:13:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com> <20250604174545.2853620-4-irogers@google.com>
 <aEMoSj0kmWo9LEaF@google.com>
In-Reply-To: <aEMoSj0kmWo9LEaF@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Jun 2025 11:13:10 -0700
X-Gm-Features: AX0GCFufpphanskcS_VgTeM5MLC0aivwUbtBDsVA8RxKaTOFneXfioIpUTtMSWM
Message-ID: <CAP-5=fWDaJwC6uzkbmcT1tD1jOuPT8rNEaAuO+MSq6X8BH7shw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] perf parse-events: Add parse_uid_filter helper
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Gautam Menghani <gautam@linux.ibm.com>, Tengda Wu <wutengda@huaweicloud.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 10:41=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Ian,
>
> On Wed, Jun 04, 2025 at 10:45:37AM -0700, Ian Rogers wrote:
> > Add parse_uid_filter filter as a helper to parse_filter, that
> > constructs a uid filter string. As uid filters don't work with
> > tracepoint filters, add a is_possible_tp_filter function so the
> > tracepoint filter isn't attempted for tracepoint evsels.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.c | 33 ++++++++++++++++++++++++++++++++-
> >  tools/perf/util/parse-events.h |  1 +
> >  2 files changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index d96adf23dc94..7f34e602fc08 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -25,6 +25,7 @@
> >  #include "pmu.h"
> >  #include "pmus.h"
> >  #include "asm/bug.h"
> > +#include "ui/ui.h"
> >  #include "util/parse-branch-options.h"
> >  #include "util/evsel_config.h"
> >  #include "util/event.h"
> > @@ -2561,6 +2562,12 @@ foreach_evsel_in_last_glob(struct evlist *evlist=
,
> >       return 0;
> >  }
> >
> > +/* Will a tracepoint filter work for str or should a BPF filter be use=
d? */
> > +static bool is_possible_tp_filter(const char *str)
> > +{
> > +     return strstr(str, "uid") =3D=3D NULL;
> > +}
> > +
> >  static int set_filter(struct evsel *evsel, const void *arg)
> >  {
> >       const char *str =3D arg;
> > @@ -2573,7 +2580,7 @@ static int set_filter(struct evsel *evsel, const =
void *arg)
> >               return -1;
> >       }
> >
> > -     if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT) {
> > +     if (evsel->core.attr.type =3D=3D PERF_TYPE_TRACEPOINT && is_possi=
ble_tp_filter(str)) {
> >               if (evsel__append_tp_filter(evsel, str) < 0) {
> >                       fprintf(stderr,
> >                               "not enough memory to hold filter string\=
n");
> > @@ -2609,6 +2616,30 @@ int parse_filter(const struct option *opt, const=
 char *str,
> >                                         (const void *)str);
> >  }
> >
> > +int parse_uid_filter(struct evlist *evlist, uid_t uid)
>
> It failed to build on alpine 3.18.
>
> util/parse-events.h:48:45: error: unknown type name 'uid_t'
>    48 | int parse_uid_filter(struct evlist *evlist, uid_t uid);
>       |                                             ^~~~~
>
> I'll add this.

Thanks Namhyung! I see this in tmp.perf-tools-next so I'll assume
there's no need for a v5.

Ian

> Thanks,
> Namhyung
>
>
> ---8<---
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index ab242f6710313993..931780911e071ec6 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -11,6 +11,7 @@
>  #include <linux/perf_event.h>
>  #include <stdio.h>
>  #include <string.h>
> +#include <sys/types.h>
>
>  struct evsel;
>  struct evlist;
>
>
>
> > +{
> > +     struct option opt =3D {
> > +             .value =3D &evlist,
> > +     };
> > +     char buf[128];
> > +     int ret;
> > +
> > +     snprintf(buf, sizeof(buf), "uid =3D=3D %d", uid);
> > +     ret =3D parse_filter(&opt, buf, /*unset=3D*/0);
> > +     if (ret) {
> > +             if (use_browser >=3D 1) {
> > +                     /*
> > +                      * Use ui__warning so a pop up appears above the
> > +                      * underlying BPF error message.
> > +                      */
> > +                     ui__warning("Failed to add UID filtering that use=
s BPF filtering.\n");
> > +             } else {
> > +                     fprintf(stderr, "Failed to add UID filtering that=
 uses BPF filtering.\n");
> > +             }
> > +     }
> > +     return ret;
> > +}
> > +
> >  static int add_exclude_perf_filter(struct evsel *evsel,
> >                                  const void *arg __maybe_unused)
> >  {
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index ab242f671031..46e5a01be61c 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -45,6 +45,7 @@ static inline int parse_events(struct evlist *evlist,=
 const char *str,
> >  int parse_event(struct evlist *evlist, const char *str);
> >
> >  int parse_filter(const struct option *opt, const char *str, int unset)=
;
> > +int parse_uid_filter(struct evlist *evlist, uid_t uid);
> >  int exclude_perf(const struct option *opt, const char *arg, int unset)=
;
> >
> >  enum parse_events__term_val_type {
> > --
> > 2.50.0.rc0.604.gd4ff7b7c86-goog
> >
