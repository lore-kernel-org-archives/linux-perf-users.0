Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733861AAE28
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468976; cv=none; b=n3MvXCrv5bJh8yw/7+hXaYNHllHkV6yVGf2TzNBAI/JeF7kaCCk1oBOAPNxU346I+97Jflf6ODiiedMxb9Gf+j1d+Mdk71Fe3I2boWmd2c4+5wQXvzDumFnNdL/6Dv8t45HnXQOCDA9l0ZtI5RuPFenvU6TDYZrqxRG1nkM2GkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468976; c=relaxed/simple;
	bh=GSvLpc4xtpqjotKX3G+0V8G3/MvEZzWiZs8XmMqE2r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MB8UbC/D0TICzffOAxBSWubG/nRWVKsvxnIPyIzA0yTYho2z3ANjHQbx4pKmJRQIKn/uWkA5jtHuoOo+L03d3mchTYj2yuvS1NLmrgZKzyuo9FArxlqzQ2alzh9C3VHwStdn31Bbhkz1T5t/Ulf6hvaKSv35mOVaae7uiwk14s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gmrm+p4P; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gmrm+p4P"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e2429bd4b3so20035ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753468973; x=1754073773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B5aTzC0GJ9P8gZTegKzbu/NlYD9QLEwqWnleaiYlZcs=;
        b=Gmrm+p4PwOLa6DFlRPILPhecLZ/nKinEAOuw6/00U4b5P91tyrGd0e3/RiU9EWe+6l
         4XtdpLycNWjXy/cSe5gt/EBkTrFJ2kSRQS/+aFIdJg4GC54/vDiwHE7mADDzD+r4tRJo
         Wix8o0RQ8+wuVC/As5lil9eMhQmW4J7b0aDUlfJlIomSg6EVo7A5dNNNxmDrtrj2c2qy
         SIxIy4F7ZtAr9UZRCFEoUaVcUaoGMAjL+kwbqSd46TFFhmdydXuxFwjGd90vSQqEftxo
         UpV6UIyqryA0G+DM5p/oUUE07WjRv6RILHtOC2KP/J4mWCKsMj/74pcmfE2DRoyFWKJc
         trNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468973; x=1754073773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5aTzC0GJ9P8gZTegKzbu/NlYD9QLEwqWnleaiYlZcs=;
        b=j1aSj/ZNUOXMDS3ng6/mJzczlWxIazSk38H3S5g/zN3EMfAj+E8gcg+q90jqx23isU
         mM1kOjr325n9XEF+w0qwMrVSM1LL4TFKsz6F8wb04ryDae4gHAr8ba2qGG76R7C8SWmE
         YSG1IQ4VFcJt4AhCZ4tAbdBuqit2iH25ZqSLjTcGfiUjUHcghpMTsyXtDpxTtwf95A/c
         cDkiFVFjqKAmHFTVbpqTv7pSbcvOHX6yfD7ITIbfzPDSdvg9KwWBHkQSvhvKoKtGYqHS
         qxJN1E7AlGSTzUFEpifpjCG5IPO6gLKIrV2RI/HfSf+LA4xnUNLx3N7zy7ELnMDBaF0a
         f/4w==
X-Forwarded-Encrypted: i=1; AJvYcCVLF0prjLubl0yBnx00ZzphJKntoBVsYvYEn8FXlvS3U4QOSMqyzftgxdN3ws+BVM8WXYrU9RpbYV26m1IxCqil@vger.kernel.org
X-Gm-Message-State: AOJu0YyYOe7ORzwt7or9ddZY0TiIZ6LaOPMuS9eC8OFP5lrIPMrP+urt
	VWbdascTfMyEaMDa2JrTmnJW6hYbS0P4NQVWHmFCZdx6bXXu3ZsXVhCQcavfRTV5aKu2l7IxbW2
	PPQPYqpM5JZ8rfSr0fYSgqHtWmX5IxXtS5qWtw0CXbvfM7IUAEzyxaC3byi4=
X-Gm-Gg: ASbGncu8fZx9/y9QYVqF2jm4RwhcyDTd3X25/x0VijQhlbTE8PKHyV4rrYJLBEKX+b3
	U+GXN5A1TeyNHibZy0Ruh51GXgTNan7gg8sDoqLDCHS/c0Fo7yn1bSes9CjFw62g5r+ror99z+Y
	zgXn20VY8tdPWw8GuNauG1oF/osMVIwL2OE9zQS/LKMsqKrAaVbfAI94g+/DrDBLZHft2CZKITc
	Epxhiju6DOPxXjwijQcmoq7z4ziLIpYrrQ=
X-Google-Smtp-Source: AGHT+IHe45kLWWoUQQ2i+vdkxiiAAFl8FcCkHVk3zt2WXRdMUKwyt4pCJU9YSx4p9ffO4J/F89fsUhY48Jhd4WrOvlA=
X-Received: by 2002:a05:6e02:2194:b0:3e2:c215:1388 with SMTP id
 e9e14a558f8ab-3e3cc1012b5mr262805ab.19.1753468972954; Fri, 25 Jul 2025
 11:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723232217.516179-1-irogers@google.com> <20250723232217.516179-16-irogers@google.com>
 <fui4zmtpolivpmrmhwwacahlh5ld256lhsd5pdnsvr4l3iicqp@lttgjcpumt4v>
In-Reply-To: <fui4zmtpolivpmrmhwwacahlh5ld256lhsd5pdnsvr4l3iicqp@lttgjcpumt4v>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Jul 2025 11:42:41 -0700
X-Gm-Features: Ac12FXz9w9WsHrkLlMLi3JGhHDmYiMxZe3J-NhUyt_ukNS8R5smvEvQW19nKUJ0
Message-ID: <CAP-5=fWz2o=4uQ7dmRPF1fYDpO2vx0rYhn4+fP81vaPCUptxcQ@mail.gmail.com>
Subject: Re: [PATCH v8 15/16] perf python: Add metrics function
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Collin Funk <collin.funk1@gmail.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Chun-Tse Shao <ctshao@google.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 10:48=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Hi Ian,
>
> On Wed, Jul 23, 2025 at 04:22:16PM -0700, Ian Rogers wrote:
> > The metrics function returns a list dictionaries describing metrics as
> > strings mapping to strings, except for metric groups that are a string
> > mapping to a list of strings. For example:
> > ```
> > >>> import perf
> > >>> perf.metrics()[0]
> > {'MetricGroup': ['Power'], 'MetricName': 'C10_Pkg_Residency',
> >  'PMU': 'default_core', 'MetricExpr': 'cstate_pkg@c10\\-residency@ / TS=
C',
> >  'ScaleUnit': '100%', 'BriefDescription': 'C10 residency percent per pa=
ckage'}
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/python.c | 83 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index bee7c8a69bad..a8ba1379cf21 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -2073,7 +2073,90 @@ static PyObject *pyrf__parse_metrics(PyObject *s=
elf, PyObject *args)
> >       return result;
> >  }
> >
> > +static PyObject *pyrf__metrics_groups(const struct pmu_metric *pm)
> > +{
> > +     PyObject *groups =3D PyList_New(/*len=3D*/0);
> > +     const char *mg =3D pm->metric_group;
> > +
> > +     if (!groups)
> > +             return NULL;
> > +
> > +     while (mg) {
> > +             PyObject *val =3D NULL;
> > +             const char *sep =3D strchr(mg, ';');
> > +             size_t len =3D sep ? (size_t)(sep - mg) : strlen(mg);
> > +
> > +             if (len > 0) {
> > +                     val =3D PyUnicode_FromStringAndSize(mg, len);
> > +                     if (val)
> > +                             PyList_Append(groups, val);
> > +
> > +                     Py_XDECREF(val);
> > +             }
> > +             mg =3D sep ? sep + 1 : NULL;
> > +     }
> > +     return groups;
> > +}
> > +
> > +static int pyrf__metrics_cb(const struct pmu_metric *pm,
> > +                         const struct pmu_metrics_table *table __maybe=
_unused,
> > +                         void *vdata)
> > +{
> > +     PyObject *py_list =3D vdata;
> > +     PyObject *dict =3D PyDict_New();
> > +     PyObject *key =3D dict ? PyUnicode_FromString("MetricGroup") : NU=
LL;
> > +     PyObject *value =3D key ? pyrf__metrics_groups(pm) : NULL;
> > +
> > +     if (!value || PyDict_SetItem(dict, key, value) !=3D 0) {
> > +             Py_XDECREF(key);
> > +             Py_XDECREF(value);
> > +             Py_XDECREF(dict);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     if (!add_to_dict(dict, "MetricName", pm->metric_name) ||
> > +         !add_to_dict(dict, "PMU", pm->pmu) ||
> > +         !add_to_dict(dict, "MetricExpr", pm->metric_expr) ||
> > +         !add_to_dict(dict, "MetricThreshold", pm->metric_threshold) |=
|
> > +         !add_to_dict(dict, "ScaleUnit", pm->unit) ||
> > +         !add_to_dict(dict, "Compat", pm->compat) ||
> > +         !add_to_dict(dict, "BriefDescription", pm->desc) ||
> > +         !add_to_dict(dict, "PublicDescription", pm->long_desc) ||
> > +         PyList_Append(py_list, dict) !=3D 0) {
> > +             Py_DECREF(dict);
> > +             return -ENOMEM;
> > +     }
> > +     Py_DECREF(dict);
> > +     return 0;
> > +}
> > +
> > +static PyObject *pyrf__metrics(PyObject *self, PyObject *args)
> > +{
> > +     const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
> > +     PyObject *list =3D PyList_New(/*len=3D*/0);
> > +     int ret;
> > +
> > +     if (!list)
> > +             return NULL;
> > +
> > +     ret =3D pmu_metrics_table__for_each_metric(table, pyrf__metrics_c=
b, list);
> > +     if (ret) {
> > +             Py_DECREF(list);
> > +             errno =3D -ret;
> > +             PyErr_SetFromErrno(PyExc_OSError);
> > +             return NULL;
> > +     }
>
> Could the system metric be supported?
>
> I notice that "perf list metric" shows some system metrics, but this pyth=
on
> binding doesn't show these metrics:
>
> root@imx93evk:~/python# perf list metric
>
> List of pre-defined events (to be used in -e or -M):
>
> Metrics:
>
>   imx93_bandwidth_usage.lpddr4x
>        [bandwidth usage for lpddr4x evk board]
>   imx93_ddr_read.all
>        [bytes all masters read from ddr]
>   imx93_ddr_write.all
>        [bytes all masters write to ddr]
>
> root@imx93evk:~/python# python3
> >>> import perf
> >>> perf.metrics()
> []
> >>>
>
> If I add below code here, it can be shown too.
>
> pmu_for_each_sys_metric(pyrf__metrics_cb, list);

Good suggestion, I'll check it out and add for v9.

Thanks,
Ian


> Thanks,
> Xu Yang
>
> > +     return list;
> > +}
> > +
> >  static PyMethodDef perf__methods[] =3D {
> > +     {
> > +             .ml_name  =3D "metrics",
> > +             .ml_meth  =3D (PyCFunction) pyrf__metrics,
> > +             .ml_flags =3D METH_NOARGS,
> > +             .ml_doc   =3D PyDoc_STR(
> > +                     "Returns a list of metrics represented as string =
values in dictionaries.")
> > +     },
> >       {
> >               .ml_name  =3D "tracepoint",
> >               .ml_meth  =3D (PyCFunction) pyrf__tracepoint,
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
