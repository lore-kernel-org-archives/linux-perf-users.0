Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1528CF6F
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Sep 2025 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915020; cv=none; b=h30658NJWxqwoDjIMiGCpP/qwz0GQ3pyjKlaatyM+OdxrERExWgLmNvQ2cDMrjfBdlf6C4HDQpcl7pccL1WhcUcGcE+m0A4e7JMwM4VtO2I6i82J0CVC5EmsFRURvGcbjCPJB1GYfpm1fqdGP46gQLyRcI6DPrRqzgjIO/tcpho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915020; c=relaxed/simple;
	bh=FcggE/uWbBl8JnTOxhEzX/59JtK477cFmCG/JIhhW3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR/xZeEIVQSe5NhUiJZHr0wRPZono6NFHn8uNA/5vSzjEiFOTjeJ3sBN7rsgkPUj+ojqyx8uHYE/elPUaEievgOT3tcVtsdcoCszyduz4ECzYxL8lfuyX1w4ayMizKxFgU6v5X4wruuyMk6DV466xqwNWCccu5qL3XEzh77Vdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AGXE/Y6i; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AGXE/Y6i"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24b2d018f92so184665ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756915018; x=1757519818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnwvHxPjTnx+N5RJFuwb32JKGXTS/g25wdy/xSnxsQ0=;
        b=AGXE/Y6ioV1ChN14WDTDmCYbIntt3VsxJRwMMGBG5Fdilc+pdPoLi1LjgA4OU414VK
         4rvPPOjB1lnlbJYP0Z6PHZYYg0XSbBkF+E6Gp8gC8z2w7Y9jsO5cQ88S/VXnawp/URyO
         M0LLUJF+WHb92Mjt/4go4HIe9AIGp3VVlAHE9PxkgaG8t/l5hbx8QI7x4L7vR495z7qU
         YYbU7sbf72N3wRF3nl6GqG/rAzcBF/q/07txGl+3flywEBtZJw8VgBTKnvksmU0/siVV
         FwWG6bQQAc/OU0mrkfSR4GrstXZYGBj68qVMizTsx9ZzvIa8X5sR+Ld5vm39f+U89pqN
         ifIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915018; x=1757519818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnwvHxPjTnx+N5RJFuwb32JKGXTS/g25wdy/xSnxsQ0=;
        b=rEM0kBV2RjTrqSuq4N4a1bduFSGqjuH0jZqCBqNDSK8AOacEwbh/ylycwoOPOX6hMe
         MMmw111l5T7L3M0UcmxAqQLsdp1PLnScyDyJDnVbo1vAwTEACkvWVPUuH3HAZSLkS2Zf
         SMieFOPN5q7fxIYMZ9Uu0roTv20+92cmzP5GGJOxVxpGbPCFVhj4tVwgGb8ZzG993mOn
         13xCvBCVBq7M+hQI0S7jeB1ey+JHbD2VosDOSryg6zZGgLBnTYJmIc9z3pCMDnrk7Jh6
         sw4q60e6N4I3YggIbIlU57t260P98i/ACpM0Z8mOjC7dARjfNsaZI/hxsnPCHQihfKVe
         UXsw==
X-Forwarded-Encrypted: i=1; AJvYcCVQPLT0mH/cuAA9QSnP37Qu99nABrYJ7arka0LXa3R5zzMBD+xVWXT+FsLfcPYejs6OizMLi21ZFPeGNCOEwuow@vger.kernel.org
X-Gm-Message-State: AOJu0YwA+AR2gtjnpe23eJiVkFLKSvAZu5f37uDWUygSKYWmk+OZajoG
	jQ40cXp8uUBd6ihvBfJ07JVcEXiZyTR1I3H8Evq6nEF+f4lJymFSr/C2xQKx5h2EKBUmhQ/zYZW
	4MXpGbtI/154RDhvXtPWDt8njncqb/7O1Kb40zX5a
X-Gm-Gg: ASbGncuq613+V3DFshZSqXtHgFVqXPeoYB2v0WHB5ACQCQRYzOgta9vHCTYebggc1In
	NNh6uyf7X7RD6XemfFozuvvD56HV9eNCtXLMesauiUgQfRAjFVV88XPIvBDh1FujRWO/lLiJRx8
	RVNs7efmenreQ2j7x/nttRmh5sQi5qKtNgAoOssxSikmPOVKq/ITkq07loX0uBY3X5oUCIv7nHv
	A0Gp4RFfsxRqHAJ4wc3ECHVaguZmKxA1UcCHCMbrFIEKnZ4IIaMC3I=
X-Google-Smtp-Source: AGHT+IFTHvqoT2OR2s8c3xI4+CoVeU3XaezOnH2pFs4JroQifqwas8t1FP5KdmIJpifdt8xokNii5GMRjd3DjlmuCBE=
X-Received: by 2002:a17:902:fc84:b0:248:79e8:9a3b with SMTP id
 d9443c01a7336-2493e913330mr4680795ad.12.1756915017605; Wed, 03 Sep 2025
 08:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819013941.209033-1-irogers@google.com> <20250819013941.209033-9-irogers@google.com>
 <aLhEPS6T-Sxnujrp@x1>
In-Reply-To: <aLhEPS6T-Sxnujrp@x1>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Sep 2025 08:56:45 -0700
X-Gm-Features: Ac12FXyjVzG7iBvy-OpM-PJdZ2JFNs5MlhRwmm3Tz8fcQKuseaxxI30ja6Ey-qc
Message-ID: <CAP-5=fWDbpKzwSOo0rCHNLa6hBDjG4wMO3MKQt3wUQzVaVj6jA@mail.gmail.com>
Subject: Re: [PATCH v10 08/11] perf python: Add evlist compute_metric
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 6:36=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Mon, Aug 18, 2025 at 06:39:38PM -0700, Ian Rogers wrote:
> > Add a compute_metric function that computes a metric double value for a
> > given evlist, metric name, CPU and thread. For example:
> > ```
> > >>> import perf
> > >>> x =3D perf.parse_metrics("TopdownL1")
> > >>> x.open()
> > >>> x.enable()
> > >>> x.disable()
> > >>> x.metrics()
> > ['tma_bad_speculation', 'tma_frontend_bound', 'tma_backend_bound', 'tma=
_retiring']
> > >>> x.compute_metric('tma_bad_speculation', 0, -1)
> > 0.08605342847131037
> > ```
>
> Added the following to fix the build on the still not EOLed OpenSUSE
> 15, ok?

Looks good to me!

Thanks,
Ian

> - Arnaldo
>
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 56102034d5b8c469..47178404802f4069 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -1386,7 +1386,7 @@ static int prepare_metric(const struct metric_expr =
*mexp,
>  static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevlist=
,
>                                              PyObject *args, PyObject *kw=
args)
>  {
> -       int ret, cpu =3D 0, cpu_idx, thread =3D 0, thread_idx;
> +       int ret, cpu =3D 0, cpu_idx =3D 0, thread =3D 0, thread_idx =3D 0=
;
>         const char *metric;
>         struct rb_node *node;
>         struct metric_expr *mexp =3D NULL;
>
> Committer notes:
>
> Initialize thread_idx and cpu_idx to zero as albeit them not possibly
> coming out unitialized from the loop as mexp would be not NULL only if
> they were initialized, some older compilers don't notice that and error
> with:
>
>     GEN     /tmp/build/perf/python/perf.cpython-36m-x86_64-linux-gnu.so
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c: In function =E2=80=98pyr=
f_evlist__compute_metric=E2=80=99:
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c:1363:3: error: =E2=80=98t=
hread_idx=E2=80=99 may be used uninitialized in this function [-Werror=3Dma=
ybe-uninitialized]
>      evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c:1389:41: note: =E2=80=98t=
hread_idx=E2=80=99 was declared here
>     int ret, cpu =3D 0, cpu_idx, thread =3D 0, thread_idx;
>                                            ^~~~~~~~~~
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c:1363:3: error: =E2=80=98c=
pu_idx=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe=
-uninitialized]
>      evsel__read_counter(metric_events[i], cpu_idx, thread_idx);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c:1389:20: note: =E2=80=98c=
pu_idx=E2=80=99 was declared here
>     int ret, cpu =3D 0, cpu_idx, thread =3D 0, thread_idx;
>                       ^~~~~~~
>   /git/perf-6.17.0-rc3/tools/perf/util/python.c: At top level:
>   cc1: error: unrecognized command line option =E2=80=98-Wno-cast-functio=
n-type=E2=80=99 [-Werror]
>   cc1: all warnings being treated as errors
>   error: command 'gcc' failed with exit status 1
>   cp: cannot stat '/tmp/build/perf/python_ext_build/lib/perf*.so': No suc=
h file or directory
>
> - Arnaldo
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Reviewed-by: Howard Chu <howardchu95@gmail.com>
> > ---
> >  tools/perf/util/python.c | 125 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 125 insertions(+)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index 31089f8e5519..e0769538b8d9 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -14,6 +14,7 @@
> >  #include "evlist.h"
> >  #include "evsel.h"
> >  #include "event.h"
> > +#include "expr.h"
> >  #include "print_binary.h"
> >  #include "record.h"
> >  #include "strbuf.h"
> > @@ -1330,6 +1331,124 @@ static PyObject *pyrf_evlist__metrics(struct py=
rf_evlist *pevlist)
> >       return list;
> >  }
> >
> > +static int prepare_metric(const struct metric_expr *mexp,
> > +                       const struct evsel *evsel,
> > +                       struct expr_parse_ctx *pctx,
> > +                       int cpu_idx, int thread_idx)
> > +{
> > +     struct evsel * const *metric_events =3D mexp->metric_events;
> > +     struct metric_ref *metric_refs =3D mexp->metric_refs;
> > +
> > +     for (int i =3D 0; metric_events[i]; i++) {
> > +             char *n =3D strdup(evsel__metric_id(metric_events[i]));
> > +             double val, ena, run;
> > +             int source_count =3D evsel__source_count(metric_events[i]=
);
> > +             int ret;
> > +             struct perf_counts_values *old_count, *new_count;
> > +
> > +             if (!n)
> > +                     return -ENOMEM;
> > +
> > +             if (source_count =3D=3D 0)
> > +                     source_count =3D 1;
> > +
> > +             ret =3D evsel__ensure_counts(metric_events[i]);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* Set up pointers to the old and newly read counter valu=
es. */
> > +             old_count =3D perf_counts(metric_events[i]->prev_raw_coun=
ts, cpu_idx, thread_idx);
> > +             new_count =3D perf_counts(metric_events[i]->counts, cpu_i=
dx, thread_idx);
> > +             /* Update the value in metric_events[i]->counts. */
> > +             evsel__read_counter(metric_events[i], cpu_idx, thread_idx=
);
> > +
> > +             val =3D new_count->val - old_count->val;
> > +             ena =3D new_count->ena - old_count->ena;
> > +             run =3D new_count->run - old_count->run;
> > +
> > +             if (ena !=3D run && run !=3D 0)
> > +                     val =3D val * ena / run;
> > +             ret =3D expr__add_id_val_source_count(pctx, n, val, sourc=
e_count);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     for (int i =3D 0; metric_refs && metric_refs[i].metric_name; i++)=
 {
> > +             int ret =3D expr__add_ref(pctx, &metric_refs[i]);
> > +
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static PyObject *pyrf_evlist__compute_metric(struct pyrf_evlist *pevli=
st,
> > +                                          PyObject *args, PyObject *kw=
args)
> > +{
> > +     int ret, cpu =3D 0, cpu_idx, thread =3D 0, thread_idx;
> > +     const char *metric;
> > +     struct rb_node *node;
> > +     struct metric_expr *mexp =3D NULL;
> > +     struct expr_parse_ctx *pctx;
> > +     double result =3D 0;
> > +
> > +     if (!PyArg_ParseTuple(args, "sii", &metric, &cpu, &thread))
> > +             return NULL;
> > +
> > +     for (node =3D rb_first_cached(&pevlist->evlist.metric_events.entr=
ies);
> > +          mexp =3D=3D NULL && node;
> > +          node =3D rb_next(node)) {
> > +             struct metric_event *me =3D container_of(node, struct met=
ric_event, nd);
> > +             struct list_head *pos;
> > +
> > +             list_for_each(pos, &me->head) {
> > +                     struct metric_expr *e =3D container_of(pos, struc=
t metric_expr, nd);
> > +
> > +                     if (strcmp(e->metric_name, metric))
> > +                             continue;
> > +
> > +                     if (e->metric_events[0] =3D=3D NULL)
> > +                             continue;
> > +
> > +                     cpu_idx =3D perf_cpu_map__idx(e->metric_events[0]=
->core.cpus,
> > +                                                 (struct perf_cpu){.cp=
u =3D cpu});
> > +                     if (cpu_idx < 0)
> > +                             continue;
> > +
> > +                     thread_idx =3D perf_thread_map__idx(e->metric_eve=
nts[0]->core.threads,
> > +                                                       thread);
> > +                     if (thread_idx < 0)
> > +                             continue;
> > +
> > +                     mexp =3D e;
> > +                     break;
> > +             }
> > +     }
> > +     if (!mexp) {
> > +             PyErr_Format(PyExc_TypeError, "Unknown metric '%s' for CP=
U '%d' and thread '%d'",
> > +                          metric, cpu, thread);
> > +             return NULL;
> > +     }
> > +
> > +     pctx =3D expr__ctx_new();
> > +     if (!pctx)
> > +             return PyErr_NoMemory();
> > +
> > +     ret =3D prepare_metric(mexp, mexp->metric_events[0], pctx, cpu_id=
x, thread_idx);
> > +     if (ret) {
> > +             expr__ctx_free(pctx);
> > +             errno =3D -ret;
> > +             PyErr_SetFromErrno(PyExc_OSError);
> > +             return NULL;
> > +     }
> > +     if (expr__parse(&result, pctx, mexp->metric_expr))
> > +             result =3D 0.0;
> > +
> > +     expr__ctx_free(pctx);
> > +     return PyFloat_FromDouble(result);
> > +}
> > +
> >  static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
> >                                  PyObject *args, PyObject *kwargs)
> >  {
> > @@ -1564,6 +1683,12 @@ static PyMethodDef pyrf_evlist__methods[] =3D {
> >               .ml_flags =3D METH_NOARGS,
> >               .ml_doc   =3D PyDoc_STR("List of metric names within the =
evlist.")
> >       },
> > +     {
> > +             .ml_name  =3D "compute_metric",
> > +             .ml_meth  =3D (PyCFunction)pyrf_evlist__compute_metric,
> > +             .ml_flags =3D METH_VARARGS | METH_KEYWORDS,
> > +             .ml_doc   =3D PyDoc_STR("compute metric for given name, c=
pu and thread")
> > +     },
> >       {
> >               .ml_name  =3D "mmap",
> >               .ml_meth  =3D (PyCFunction)pyrf_evlist__mmap,
> > --
> > 2.51.0.rc1.167.g924127e9c0-goog
