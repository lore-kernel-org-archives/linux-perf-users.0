Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B921DC070
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 19:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730835204; cv=none; b=ZI4efy2TJi4+pjcaurYDOwp12akn52BRr7qOUSWu3FkppX5iOgRS2IET02pocGEykQpUwDcpYxKZE/DDaaYWz8W6xcPo7FfubV4htSEy4VwYPpRIJfDfu5LMPzNOabZbk9R+VVJfTAZOrgadpSQkt94OG7SoF8TU5Th9EmsDgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730835204; c=relaxed/simple;
	bh=BGPP+6/hPX14jwU/fMSBRs+dIR8nrSSFP2GJJgrpHS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brv6llieZVQ4VRfxJnD4fyfrWBu3dTfMsnD9CPdHvS705997ONq17dpkMgdmYXY3Rs3Zeh0Dpxp/dapKzBC5DEQ6EDJ5f1iTkHgDYArvs6qlgMauIC3sVXWvZ2urcXLMNC1ZRPXXgmiiYpGyjZsCU3cm1JY5eR8R8aSVpzn6tgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9xaWXND; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9xaWXND"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c87b0332cso27265ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 05 Nov 2024 11:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730835202; x=1731440002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0+t4PurF7OyFTpLqHo8yYa5KJuBixunAjW6X46hrwc=;
        b=s9xaWXND09ZM+1rmK1ehLFbFej6Lrnw1RMBxc8DQcuPl7vvkzyXfSRFwDLsh+dmFxk
         ker219kSS3J90MX+wakoKZeXCNgv9tS+3pQEbBdUOtSwQ2PU4i2wjZplx87ThqI5JNMz
         SiF99tqFBjlMI4GEFytV1QeoDxhOVne4OtQCw25RXUR9JmEVN4lC1r99iY9AydhA/dwi
         6X2+whD35aMpPsuBAh5OlMhvPPGHiRgjVgbfg7b3OhRkwdoBnqwJfvbtguZaKdNSHTtu
         S+Kkj4XAaay5Q5b+tu25KqqCegAIJx6IEWDabJxaa7Zx2ntQTjZb5W0BZrdK5OqlEPDE
         r1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730835202; x=1731440002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0+t4PurF7OyFTpLqHo8yYa5KJuBixunAjW6X46hrwc=;
        b=Fjmau/E8xONohADZAm9uNlXpryDqW3anCjdi16Rg3G9XXro8HRyDoRKlMYDfP6BKIq
         M8lEDgFt/Qg5OPhjtsvh5xmI2/1TGc46wwCHx/URvQivPwMw14ZcopAlvOKhVLGvgCgZ
         ctuLABHFKR/flyhbbRrXo6tPoS6rXX0p89bCdUR0Bimdy+EYALuxUpwgImOw+EINON42
         d2UNYxZywykhOTY2NgmX6vYp+JeiMAUWeuCTVvI9oo89Gr+hjIvxajPPjq+lnO13RgNW
         /Olbk4U000na7FXXzNRp58slR6cURGQZN5pZ2q1HAtkqsIlsDVry8c0fuzxGgs4NYCNy
         QPNA==
X-Forwarded-Encrypted: i=1; AJvYcCVF9wYw1YsZOqHJtj/dAzClhT5EHSGEzmC6mLrT7HOIMjbBbPPfMx8L2MJJjdXZ4sXj98A5hA7DPAFZaH2CoUvz@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl12lXXFr1w7G+k/CzMkfFmEodDrE9Gxl33C0Pxq5dOdR0yw1C
	xi7+nfxRLoif+zrzn63yZdVfs6qR3uttAzylFlcE5J1lz6iNh1/DbUwI+ETUdwwaFRmo+yEFlFW
	rSvNREGAuhA0VbBuX2nQx9rFOKCA1Cp3mYPgd
X-Gm-Gg: ASbGnctPeIkHbdcIV3T3g7JvH/V53Dp50q8cEUTpHpgBNsQ5TrYH/FQln1vlur4ct8R
	L5VZYA3dVbdgpkj6rglDxiQODDW2aZsc3
X-Google-Smtp-Source: AGHT+IE8Jc+Uqbi/91h6e/fx+RANFoRBNABeESFvgJ0qEHveKP22fGFKFWQ0n753u67qFjHaGyJKA4HC64UB3PWYMFA=
X-Received: by 2002:a17:903:1108:b0:20c:8a97:1fd with SMTP id
 d9443c01a7336-2116b94508emr138655ad.19.1730835201530; Tue, 05 Nov 2024
 11:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102165400.75785-1-irogers@google.com> <20241102165400.75785-5-irogers@google.com>
 <ZypXmtlqQUxABhMI@x1>
In-Reply-To: <ZypXmtlqQUxABhMI@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 5 Nov 2024 11:33:09 -0800
Message-ID: <CAP-5=fUNR_t8R33enM1WHzR1-ZzZMUDM1hTLohPdefbKfhMSXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf evsel: Add/use accessor for tp_format
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Li <yang.lee@linux.alibaba.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Yang Jihong <yangjihong@bytedance.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Zixian Cai <fzczx123@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Paran Lee <p4ranlee@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 9:36=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Sat, Nov 02, 2024 at 09:53:58AM -0700, Ian Rogers wrote:
> > Add an accessor function for tp_format. Rather than search+replace
> > uses try to use a variable and reuse it. Add additional NULL checks
> > when accessing/using the value. Make sure the PTR_ERR is nulled out on
> > error path in evsel__newtp_idx.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-kmem.c                     | 15 ++--
> >  tools/perf/builtin-kwork.c                    |  3 +-
> >  tools/perf/builtin-script.c                   |  9 ++-
> >  tools/perf/builtin-trace.c                    | 80 +++++++++++++------
> >  tools/perf/util/data-convert-bt.c             | 10 ++-
> >  tools/perf/util/data-convert-json.c           |  8 +-
> >  tools/perf/util/evsel.c                       |  9 ++-
> >  tools/perf/util/evsel.h                       |  5 ++
> >  tools/perf/util/evsel_fprintf.c               |  4 +-
> >  .../util/scripting-engines/trace-event-perl.c |  3 +-
> >  .../scripting-engines/trace-event-python.c    |  3 +-
> >  tools/perf/util/sort.c                        | 33 +++++---
> >  tools/perf/util/trace-event-scripting.c       | 10 ++-
> >  13 files changed, 131 insertions(+), 61 deletions(-)
> >
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index a756147e2eec..8d9477d3f52b 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -761,6 +761,7 @@ static int parse_gfp_flags(struct evsel *evsel, str=
uct perf_sample *sample,
> >       };
> >       struct trace_seq seq;
> >       char *str, *pos =3D NULL;
> > +     const struct tep_event *tp_format;
> >
> >       if (nr_gfps) {
> >               struct gfp_flag key =3D {
> > @@ -772,8 +773,9 @@ static int parse_gfp_flags(struct evsel *evsel, str=
uct perf_sample *sample,
> >       }
> >
> >       trace_seq_init(&seq);
> > -     tep_print_event(evsel->tp_format->tep,
> > -                     &seq, &record, "%s", TEP_PRINT_INFO);
> > +     tp_format =3D evsel__tp_format(evsel);
> > +     if (tp_format)
> > +             tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_=
PRINT_INFO);
> >
> >       str =3D strtok_r(seq.buffer, " ", &pos);
> >       while (str) {
> > @@ -2011,14 +2013,15 @@ int cmd_kmem(int argc, const char **argv)
> >       }
> >
> >       if (kmem_page) {
> > -             struct evsel *evsel =3D evlist__find_tracepoint_by_name(s=
ession->evlist, "kmem:mm_page_alloc");
> > +             struct evsel *evsel =3D evlist__find_tracepoint_by_name(s=
ession->evlist,
> > +                                                                   "km=
em:mm_page_alloc");
>
> Try to avoid these reflows to reduce patch size, please.

Agreed, in this case check `checkpatch.pl` is complaining that the
line length is 109 columns.

> > +             const struct tep_event *tp_format =3D evsel ? evsel__tp_f=
ormat(evsel) : NULL;
> >
> > -             if (evsel =3D=3D NULL) {
> > +             if (tp_format =3D=3D NULL) {
> >                       pr_err(errmsg, "page", "page");
> >                       goto out_delete;
> >               }
> > -
> > -             kmem_page_size =3D tep_get_page_size(evsel->tp_format->te=
p);
> > +             kmem_page_size =3D tep_get_page_size(tp_format->tep);
> >               symbol_conf.use_callchain =3D true;
> >       }
> >
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index c1daf82c9b92..8834e642c4ba 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> > @@ -1103,7 +1103,8 @@ static char *evsel__softirq_name(struct evsel *ev=
sel, u64 num)
> >       char *name =3D NULL;
> >       bool found =3D false;
> >       struct tep_print_flag_sym *sym =3D NULL;
> > -     struct tep_print_arg *args =3D evsel->tp_format->print_fmt.args;
> > +     const struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +     struct tep_print_arg *args =3D tp_format ? evsel__tp_format(evsel=
)->print_fmt.args : NULL;
>
>                                  why not use tp_format, i.e.:
>
>         struct tep_print_arg *args =3D tp_format ? tp_format->print_fmt.a=
rgs : NULL;
>
> >
> >       if ((args =3D=3D NULL) || (args->next =3D=3D NULL))
> >               return NULL;
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index 6b6d4472db6e..0acdb98314f8 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2289,8 +2289,13 @@ static void process_event(struct perf_script *sc=
ript,
> >       }
> >  #ifdef HAVE_LIBTRACEEVENT
> >       if (PRINT_FIELD(TRACE) && sample->raw_data) {
> > -             event_format__fprintf(evsel->tp_format, sample->cpu,
> > -                                   sample->raw_data, sample->raw_size,=
 fp);
> > +             const struct tep_event *tp_format =3D evsel__tp_format(ev=
sel);
> > +
> > +             if (tp_format) {
> > +                     event_format__fprintf(tp_format, sample->cpu,
> > +                                           sample->raw_data, sample->r=
aw_size,
> > +                                           fp);
> > +             }
> >       }
> >  #endif
> >       if (attr->type =3D=3D PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 748b061f8678..86f159f25169 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -389,7 +389,12 @@ static struct syscall_arg_fmt *evsel__syscall_arg_=
fmt(struct evsel *evsel)
> >       }
> >
> >       if (et->fmt =3D=3D NULL) {
> > -             et->fmt =3D calloc(evsel->tp_format->format.nr_fields, si=
zeof(struct syscall_arg_fmt));
> > +             const struct tep_event *tp_format =3D evsel__tp_format(ev=
sel);
> > +
> > +             if (tp_format =3D=3D NULL)
> > +                     goto out_delete;
> > +
> > +             et->fmt =3D calloc(tp_format->format.nr_fields, sizeof(st=
ruct syscall_arg_fmt));
> >               if (et->fmt =3D=3D NULL)
> >                       goto out_delete;
> >       }
> > @@ -2154,8 +2159,12 @@ static int evsel__init_tp_arg_scnprintf(struct e=
vsel *evsel, bool *use_btf)
> >       struct syscall_arg_fmt *fmt =3D evsel__syscall_arg_fmt(evsel);
> >
> >       if (fmt !=3D NULL) {
> > -             syscall_arg_fmt__init_array(fmt, evsel->tp_format->format=
.fields, use_btf);
> > -             return 0;
> > +             const struct tep_event *tp_format =3D evsel__tp_format(ev=
sel);
> > +
> > +             if (tp_format) {
> > +                     syscall_arg_fmt__init_array(fmt, tp_format->forma=
t.fields, use_btf);
> > +                     return 0;
> > +             }
> >       }
> >
> >       return -ENOMEM;
> > @@ -3026,7 +3035,8 @@ static size_t trace__fprintf_tp_fields(struct tra=
ce *trace, struct evsel *evsel,
> >  {
> >       char bf[2048];
> >       size_t size =3D sizeof(bf);
> > -     struct tep_format_field *field =3D evsel->tp_format->format.field=
s;
> > +     const struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +     struct tep_format_field *field =3D tp_format ? tp_format->format.=
fields : NULL;
> >       struct syscall_arg_fmt *arg =3D __evsel__syscall_arg_fmt(evsel);
> >       size_t printed =3D 0, btf_printed;
> >       unsigned long val;
> > @@ -3096,6 +3106,7 @@ static int trace__event_handler(struct trace *tra=
ce, struct evsel *evsel,
> >  {
> >       struct thread *thread;
> >       int callchain_ret =3D 0;
> > +
>
> ?

Removed, checkpatch.pl again iirc.

> >       /*
> >        * Check if we called perf_evsel__disable(evsel) due to, for inst=
ance,
> >        * this event's max_events having been hit and this is an entry c=
oming
> > @@ -3149,11 +3160,13 @@ static int trace__event_handler(struct trace *t=
race, struct evsel *evsel,
> >
> >       if (evsel__is_bpf_output(evsel)) {
> >               bpf_output__fprintf(trace, sample);
> > -     } else if (evsel->tp_format) {
> > -             if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
> > -                 trace__fprintf_sys_enter(trace, evsel, sample)) {
> > +     } else {
> > +             const struct tep_event *tp_format =3D evsel__tp_format(ev=
sel);
> > +
> > +             if (tp_format && (strncmp(tp_format->name, "sys_enter_", =
10) ||
> > +                               trace__fprintf_sys_enter(trace, evsel, =
sample))) {
> >                       if (trace->libtraceevent_print) {
> > -                             event_format__fprintf(evsel->tp_format, s=
ample->cpu,
> > +                             event_format__fprintf(tp_format, sample->=
cpu,
> >                                                     sample->raw_data, s=
ample->raw_size,
> >                                                     trace->output);
> >                       } else {
> > @@ -4081,17 +4094,23 @@ static int ordered_events__deliver_event(struct=
 ordered_events *oe,
> >  static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(str=
uct evsel *evsel, char *arg,
> >                                                                  char *=
*type)
> >  {
> > -     struct tep_format_field *field;
> > +     const struct tep_format_field *field;
> >       struct syscall_arg_fmt *fmt =3D __evsel__syscall_arg_fmt(evsel);
> > +     const struct tep_event *tp_format;
> > +
> > +     if (!fmt)
> > +             return NULL;
> >
> > -     if (evsel->tp_format =3D=3D NULL || fmt =3D=3D NULL)
> > +     tp_format =3D evsel__tp_format(evsel);
> > +     if (!tp_format)
> >               return NULL;
> >
> > -     for (field =3D evsel->tp_format->format.fields; field; field =3D =
field->next, ++fmt)
> > +     for (field =3D tp_format->format.fields; field; field =3D field->=
next, ++fmt) {
>
> Since you're touching above and constifying the 'field' variable,
> probably you could make it:
>
>
>         for (const struct tep_format_field *field =3D tp_format->format.f=
ields; field; field =3D field->next, ++fmt) {
>
> ?
>
> Just tried this on top of your series, it builds:
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index e663be6f04e70640..5e80f2b4d80e0a86 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -4094,7 +4094,6 @@ static int ordered_events__deliver_event(struct ord=
ered_events *oe,
>  static struct syscall_arg_fmt *evsel__find_syscall_arg_fmt_by_name(struc=
t evsel *evsel, char *arg,
>                                                                    char *=
*type)
>  {
> -       const struct tep_format_field *field;
>         struct syscall_arg_fmt *fmt =3D __evsel__syscall_arg_fmt(evsel);
>         const struct tep_event *tp_format;
>
> @@ -4105,7 +4104,7 @@ static struct syscall_arg_fmt *evsel__find_syscall_=
arg_fmt_by_name(struct evsel
>         if (!tp_format)
>                 return NULL;
>
> -       for (field =3D tp_format->format.fields; field; field =3D field->=
next, ++fmt) {
> +       for (const struct tep_format_field *field=3D tp_format->format.fi=
elds; field; field =3D field->next, ++fmt) {

This is 114 columns long, so I've applied it but wrapped it.

>                 if (strcmp(field->name, arg) =3D=3D 0) {
>                         *type =3D field->type;
>                         return fmt;
>
> ------------------------------------------------------------
>
> >               if (strcmp(field->name, arg) =3D=3D 0) {
> >                       *type =3D field->type;
> >                       return fmt;
> >               }
> > +     }
> >
> >       return NULL;
> >  }
> > @@ -4844,13 +4863,18 @@ static void evsel__set_syscall_arg_fmt(struct e=
vsel *evsel, const char *name)
> >               const struct syscall_fmt *scfmt =3D syscall_fmt__find(nam=
e);
> >
> >               if (scfmt) {
> > -                     int skip =3D 0;
> > +                     const struct tep_event *tp_format =3D evsel__tp_f=
ormat(evsel);
> > +
> > +                     if (tp_format) {
> > +                             int skip =3D 0;
> >
> > -                     if (strcmp(evsel->tp_format->format.fields->name,=
 "__syscall_nr") =3D=3D 0 ||
> > -                         strcmp(evsel->tp_format->format.fields->name,=
 "nr") =3D=3D 0)
> > -                             ++skip;
> > +                             if (strcmp(tp_format->format.fields->name=
, "__syscall_nr") =3D=3D 0 ||
> > +                                 strcmp(tp_format->format.fields->name=
, "nr") =3D=3D 0)
> > +                                     ++skip;
> >
> > -                     memcpy(fmt + skip, scfmt->arg, (evsel->tp_format-=
>format.nr_fields - skip) * sizeof(*fmt));
> > +                             memcpy(fmt + skip, scfmt->arg,
> > +                                    (tp_format->format.nr_fields - ski=
p) * sizeof(*fmt));
> > +                     }
> >               }
> >       }
> >  }
> > @@ -4860,10 +4884,16 @@ static int evlist__set_syscall_tp_fields(struct=
 evlist *evlist, bool *use_btf)
> >       struct evsel *evsel;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > -             if (evsel->priv || !evsel->tp_format)
> > +             const struct tep_event *tp_format;
> > +
> > +             if (evsel->priv)
> > +                     continue;
> > +
> > +             tp_format =3D evsel__tp_format(evsel);
> > +             if (!tp_format)
> >                       continue;
> >
> > -             if (strcmp(evsel->tp_format->system, "syscalls")) {
> > +             if (strcmp(tp_format->system, "syscalls")) {
> >                       evsel__init_tp_arg_scnprintf(evsel, use_btf);
> >                       continue;
> >               }
> > @@ -4871,20 +4901,24 @@ static int evlist__set_syscall_tp_fields(struct=
 evlist *evlist, bool *use_btf)
> >               if (evsel__init_syscall_tp(evsel))
> >                       return -1;
> >
> > -             if (!strncmp(evsel->tp_format->name, "sys_enter_", 10)) {
> > +             if (!strncmp(tp_format->name, "sys_enter_", 10)) {
> >                       struct syscall_tp *sc =3D __evsel__syscall_tp(evs=
el);
> >
> >                       if (__tp_field__init_ptr(&sc->args, sc->id.offset=
 + sizeof(u64)))
> >                               return -1;
> >
> > -                     evsel__set_syscall_arg_fmt(evsel, evsel->tp_forma=
t->name + sizeof("sys_enter_") - 1);
> > -             } else if (!strncmp(evsel->tp_format->name, "sys_exit_", =
9)) {
> > +                     evsel__set_syscall_arg_fmt(evsel,
> > +                                                tp_format->name + size=
of("sys_enter_") - 1);
> > +             } else if (!strncmp(tp_format->name, "sys_exit_", 9)) {
> >                       struct syscall_tp *sc =3D __evsel__syscall_tp(evs=
el);
> >
> > -                     if (__tp_field__init_uint(&sc->ret, sizeof(u64), =
sc->id.offset + sizeof(u64), evsel->needs_swap))
> > +                     if (__tp_field__init_uint(&sc->ret, sizeof(u64),
> > +                                               sc->id.offset + sizeof(=
u64),
> > +                                               evsel->needs_swap))
> >                               return -1;
> >
> > -                     evsel__set_syscall_arg_fmt(evsel, evsel->tp_forma=
t->name + sizeof("sys_exit_") - 1);
> > +                     evsel__set_syscall_arg_fmt(evsel,
> > +                                                tp_format->name + size=
of("sys_exit_") - 1);
>
> If you left it as
>
> -                       evsel__set_syscall_arg_fmt(evsel, evsel->tp_forma=
t->name + sizeof("sys_exit_") - 1);
> +                       evsel__set_syscall_arg_fmt(evsel, tp_format->name=
 + sizeof("sys_exit_") - 1);
>
> It would be shorter than before and slightly faster to visually decode.

101 columns.

> >               }
> >       }
> >
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-c=
onvert-bt.c
> > index 021e9b1d5cc5..d022d3c2955e 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -426,8 +426,9 @@ static int add_tracepoint_values(struct ctf_writer =
*cw,
> >                                struct evsel *evsel,
> >                                struct perf_sample *sample)
> >  {
> > -     struct tep_format_field *common_fields =3D evsel->tp_format->form=
at.common_fields;
> > -     struct tep_format_field *fields        =3D evsel->tp_format->form=
at.fields;
> > +     const struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +     struct tep_format_field *common_fields =3D tp_format->format.comm=
on_fields;
> > +     struct tep_format_field *fields        =3D tp_format->format.fiel=
ds;
> >       int ret;
> >
> >       ret =3D add_tracepoint_fields_values(cw, event_class, event,
> > @@ -1064,8 +1065,9 @@ static int add_tracepoint_types(struct ctf_writer=
 *cw,
> >                               struct evsel *evsel,
> >                               struct bt_ctf_event_class *class)
> >  {
> > -     struct tep_format_field *common_fields =3D evsel->tp_format->form=
at.common_fields;
> > -     struct tep_format_field *fields        =3D evsel->tp_format->form=
at.fields;
> > +     const struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +     struct tep_format_field *common_fields =3D tp_format ? tp_format-=
>format.common_fields : NULL;
> > +     struct tep_format_field *fields        =3D tp_format ? tp_format-=
>format.fields : NULL;
> >       int ret;
> >
> >       ret =3D add_tracepoint_fields_types(cw, common_fields, class);
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data=
-convert-json.c
> > index 20bfb0884e9e..eb068f38ca81 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -230,12 +230,12 @@ static int process_sample_event(const struct perf=
_tool *tool,
> >
> >  #ifdef HAVE_LIBTRACEEVENT
> >       if (sample->raw_data) {
> > -             int i;
> > -             struct tep_format_field **fields;
> > +             struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +             struct tep_format_field **fields =3D tp_format ? tep_even=
t_fields(tp_format) : NULL;
> >
> > -             fields =3D tep_event_fields(evsel->tp_format);
> >               if (fields) {
> > -                     i =3D 0;
> > +                     int i =3D 0;
> > +
> >                       while (fields[i]) {
> >                               struct trace_seq s;
> >
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index f780e30aa259..a95db7e900d5 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -570,6 +570,7 @@ struct evsel *evsel__newtp_idx(const char *sys, con=
st char *name, int idx, bool
> >                       evsel->tp_format =3D trace_event__tp_format(sys, =
name);
> >                       if (IS_ERR(evsel->tp_format)) {
> >                               err =3D PTR_ERR(evsel->tp_format);
> > +                             evsel->tp_format =3D NULL;
> >                               goto out_free;
> >                       }
> >                       attr.config =3D evsel->tp_format->id;
> > @@ -3209,12 +3210,16 @@ u16 evsel__id_hdr_size(const struct evsel *evse=
l)
> >  #ifdef HAVE_LIBTRACEEVENT
> >  struct tep_format_field *evsel__field(struct evsel *evsel, const char =
*name)
> >  {
> > -     return tep_find_field(evsel->tp_format, name);
> > +     struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +
> > +     return tp_format ? tep_find_field(tp_format, name) : NULL;
> >  }
> >
> >  struct tep_format_field *evsel__common_field(struct evsel *evsel, cons=
t char *name)
> >  {
> > -     return tep_find_common_field(evsel->tp_format, name);
> > +     struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +
> > +     return tp_format ? tep_find_common_field(tp_format, name) : NULL;
> >  }
> >
> >  void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, c=
onst char *name)
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index 04934a7af174..c3e53d320bf5 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -257,6 +257,11 @@ static inline struct evsel *evsel__newtp(const cha=
r *sys, const char *name)
> >  {
> >       return evsel__newtp_idx(sys, name, 0, true);
> >  }
> > +
> > +static inline struct tep_event *evsel__tp_format(struct evsel *evsel)
> > +{
> > +     return evsel->tp_format;
> > +}
> >  #endif
> >
> >  #ifdef HAVE_LIBTRACEEVENT
> > diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fp=
rintf.c
> > index c2c0500d5da9..54c5702f8c00 100644
> > --- a/tools/perf/util/evsel_fprintf.c
> > +++ b/tools/perf/util/evsel_fprintf.c
> > @@ -81,13 +81,15 @@ int evsel__fprintf(struct evsel *evsel, struct perf=
_attr_details *details, FILE
> >  #ifdef HAVE_LIBTRACEEVENT
> >       if (details->trace_fields) {
> >               struct tep_format_field *field;
> > +             const struct tep_event *tp_format;
> >
> >               if (evsel->core.attr.type !=3D PERF_TYPE_TRACEPOINT) {
> >                       printed +=3D comma_fprintf(fp, &first, " (not a t=
racepoint)");
> >                       goto out;
> >               }
> >
> > -             field =3D evsel->tp_format->format.fields;
> > +             tp_format =3D evsel__tp_format(evsel);
> > +             field =3D tp_format ? tp_format->format.fields : NULL;
> >               if (field =3D=3D NULL) {
> >                       printed +=3D comma_fprintf(fp, &first, " (no trac=
e field)");
> >                       goto out;
> > diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/too=
ls/perf/util/scripting-engines/trace-event-perl.c
> > index e16257d5ab2c..0d63b77b5140 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> > @@ -344,7 +344,7 @@ static void perl_process_tracepoint(struct perf_sam=
ple *sample,
> >                                   struct addr_location *al)
> >  {
> >       struct thread *thread =3D al->thread;
> > -     struct tep_event *event =3D evsel->tp_format;
> > +     struct tep_event *event;
> >       struct tep_format_field *field;
> >       static char handler[256];
> >       unsigned long long val;
> > @@ -362,6 +362,7 @@ static void perl_process_tracepoint(struct perf_sam=
ple *sample,
> >       if (evsel->core.attr.type !=3D PERF_TYPE_TRACEPOINT)
> >               return;
> >
> > +     event =3D evsel__tp_format(evsel);
> >       if (!event) {
> >               pr_debug("ug! no event found for type %" PRIu64, (u64)evs=
el->core.attr.config);
> >               return;
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/t=
ools/perf/util/scripting-engines/trace-event-python.c
> > index d7183134b669..77f1ab2d3eac 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -946,7 +946,7 @@ static void python_process_tracepoint(struct perf_s=
ample *sample,
> >                                     struct addr_location *al,
> >                                     struct addr_location *addr_al)
> >  {
> > -     struct tep_event *event =3D evsel->tp_format;
> > +     struct tep_event *event;
> >       PyObject *handler, *context, *t, *obj =3D NULL, *callchain;
> >       PyObject *dict =3D NULL, *all_entries_dict =3D NULL;
> >       static char handler_name[256];
> > @@ -963,6 +963,7 @@ static void python_process_tracepoint(struct perf_s=
ample *sample,
> >
> >       bitmap_zero(events_defined, TRACE_EVENT_TYPE_MAX);
> >
> > +     event =3D evsel__tp_format(evsel);
> >       if (!event) {
> >               snprintf(handler_name, sizeof(handler_name),
> >                        "ug! no event found for type %" PRIu64, (u64)evs=
el->core.attr.config);
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 168c488f0178..710839ec3f99 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -1038,17 +1038,19 @@ static char *get_trace_output(struct hist_entry=
 *he)
> >               .data =3D he->raw_data,
> >               .size =3D he->raw_size,
> >       };
> > +     struct tep_event *tp_format;
> >
> >       evsel =3D hists_to_evsel(he->hists);
> >
> >       trace_seq_init(&seq);
> > -     if (symbol_conf.raw_trace) {
> > -             tep_print_fields(&seq, he->raw_data, he->raw_size,
> > -                              evsel->tp_format);
> > -     } else {
> > -             tep_print_event(evsel->tp_format->tep,
> > -                             &seq, &rec, "%s", TEP_PRINT_INFO);
> > +     tp_format =3D evsel__tp_format(evsel);
> > +     if (tp_format) {
> > +             if (symbol_conf.raw_trace)
> > +                     tep_print_fields(&seq, he->raw_data, he->raw_size=
, tp_format);
> > +             else
> > +                     tep_print_event(tp_format->tep, &seq, &rec, "%s",=
 TEP_PRINT_INFO);
> >       }
> > +
> >       /*
> >        * Trim the buffer, it starts at 4KB and we're not going to
> >        * add anything more to this buffer.
> > @@ -3293,9 +3295,8 @@ static int __dynamic_dimension__add(struct evsel =
*evsel,
> >  static int add_evsel_fields(struct evsel *evsel, bool raw_trace, int l=
evel)
> >  {
> >       int ret;
> > -     struct tep_format_field *field;
> > -
> > -     field =3D evsel->tp_format->format.fields;
> > +     struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +     struct tep_format_field *field =3D tp_format ? tp_format->format.=
fields : NULL;
> >       while (field) {
> >               ret =3D __dynamic_dimension__add(evsel, field, raw_trace,=
 level);
> >               if (ret < 0)
> > @@ -3328,13 +3329,19 @@ static int add_all_matching_fields(struct evlis=
t *evlist,
> >  {
> >       int ret =3D -ESRCH;
> >       struct evsel *evsel;
> > -     struct tep_format_field *field;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > +             struct tep_event *tp_format;
> > +             struct tep_format_field *field;
> > +
> >               if (evsel->core.attr.type !=3D PERF_TYPE_TRACEPOINT)
> >                       continue;
> >
> > -             field =3D tep_find_any_field(evsel->tp_format, field_name=
);
> > +             tp_format =3D evsel__tp_format(evsel);
> > +             if (tp_format =3D=3D NULL)
> > +                     continue;
> > +
> > +             field =3D tep_find_any_field(tp_format, field_name);
> >               if (field =3D=3D NULL)
> >                       continue;
> >
> > @@ -3416,7 +3423,9 @@ static int add_dynamic_entry(struct evlist *evlis=
t, const char *tok,
> >       if (!strcmp(field_name, "*")) {
> >               ret =3D add_evsel_fields(evsel, raw_trace, level);
> >       } else {
> > -             struct tep_format_field *field =3D tep_find_any_field(evs=
el->tp_format, field_name);
> > +             struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +             struct tep_format_field *field =3D
> > +                     tp_format ? tep_find_any_field(tp_format, field_n=
ame) : NULL;
> >
> >               if (field =3D=3D NULL) {
> >                       pr_debug("Cannot find event field for %s.%s\n",
> > diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/=
trace-event-scripting.c
> > index bd0000300c77..bab893587863 100644
> > --- a/tools/perf/util/trace-event-scripting.c
> > +++ b/tools/perf/util/trace-event-scripting.c
> > @@ -28,12 +28,14 @@ void scripting_context__update(struct scripting_con=
text *c,
> >                              struct addr_location *al,
> >                              struct addr_location *addr_al)
> >  {
> > -     c->event_data =3D sample->raw_data;
> > -     c->pevent =3D NULL;
> >  #ifdef HAVE_LIBTRACEEVENT
> > -     if (evsel->tp_format)
> > -             c->pevent =3D evsel->tp_format->tep;
> > +     const struct tep_event *tp_format =3D evsel__tp_format(evsel);
> > +
> > +     c->pevent =3D tp_format ? tp_format->tep : NULL;
> > +#else
> > +     c->pevent =3D NULL;
> >  #endif
> > +     c->event_data =3D sample->raw_data;
> >       c->event =3D event;
> >       c->sample =3D sample;
> >       c->evsel =3D evsel;
> > --
> > 2.47.0.199.ga7371fff76-goog
