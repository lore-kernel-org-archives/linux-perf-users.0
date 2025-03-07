Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DC21A44C
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368972; cv=none; b=PvRQuU1SbBdjXIds744ChPu03D5PaIwlB5RsmE84odgQwih3I+faiOvnrC6w6kEiKwpwouU210ywcWHdvKRy1c+iJtrbMSXH+3D/zVTd8dJ4gv8FoJYwBs3CBnD9QkKsXTVc+cqSd2g7wjO1A8F41RdMBIPSTLG4ryJEmOweqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368972; c=relaxed/simple;
	bh=Mj4I71vmGcViF0pS0YuRQq3nWpdZq7aHhc2Qk5J3d40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6xJqdt8EdGT+BtfaIIDA5DBwLAJfp7CffbNoVoF4xqYwuUzHzkpCQvgZLjm64MyDJcNyR9IP66OXWC5IymbkY3Ulv2aGti5BsWq8qEoJUMumJALVcJCYRD7acYfzq0qJRekKfKlFU9jouhXl6+nPJwTHNbqTD4Fs9Oc0ffg/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jPb4kpFX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jPb4kpFX"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2242ac37caeso133355ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741368970; x=1741973770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMEdet0PWL/MVZ4rPjZVDjuPrMML8ZWDlWINUqqcvE4=;
        b=jPb4kpFXrXlUWLRKlOkfWxaju+mvfQjk5sSe5tKDKoGTibFzQFyx6QQjViOIHkj6TY
         BIOYyrGqPBSC7B+8KhDfUKBsf0arkbSjv1HOugR9k+6TzqK7CoBOezrLLePxzcLU+vMh
         002Mbslgtb0vqpE+Z/Z8caw2mRv4GAWAKbGMPeCktrrYm0ELHD0OtKOkA9Nh0Up7OmT+
         rUosblkWoz7eDay8zyY0I0eYEY840sZ3Puwg9JaS9XAos+D3bVnWyUpBjAmrKjE3jr3E
         WNVcNV9pBMQMkxA7qFEZY2OVNhIl9o4BtkNU5+8vJDyMIB1TmbxVVY2i3pjyidEOp0p7
         fxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741368970; x=1741973770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMEdet0PWL/MVZ4rPjZVDjuPrMML8ZWDlWINUqqcvE4=;
        b=oieyjPJRyACCPg9IPqJbD9Fr1tEfd7g/Z7mZCPcvgW+boBergz7ZOVfBHVlD8NW+vv
         ll3smEduA6qQvqc6FhFMkxk3HJiGCmC3EqXJUr5AmZ/5w87A4OUZdQ3j90PUmsGHIONE
         Nue7OH+dXUfuNVxI9dgGIi2Pum4bqLjEQtBVkLDNr8TRWMhbIPmmF/Hc/jPlCFsfsHaH
         nOYitKPdOftRdV5BxRt8XirHGQKZVczK5yhtggCRy2vH555z+t58lH2H+KPUWunIFf/k
         9FvSxcUdcey9B/GEkKzf0lAZlFcuWyEqTcV/7wOKGRLdyS6HLFi9gTEmOez6J8SPngyQ
         UjKA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8JKsBvBxN3AgdWXngElUE6nbYSkN7Yu8rvaZfW5gUIXfNpEcHTTH6Qqg+j4BwIwWqF+QvQ18X3fhQ2ZqKcxX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1WUO/bupuI+nzaXgECNMEcpqSy7UroKeHPGIL+i0ubIpD3XSE
	ENVHa3iXAyIMTdiVYr57js+JPsPXVB88zen4+fyXNqXoAoX58gC9d4AtwAzseLb9mwsppWgSGDY
	+EwLQy70V3XxCWixEdqcaIaRP+LTXuHaAYJC4
X-Gm-Gg: ASbGncvPHs67qo/EVvrmC9eR4vdOVoPPZyZMFaZAk5Dzn3qfETyZejGxhaZrYqT+fUS
	Sgg050n9GZIoQIBPUP0XYpfVXe5k8NV44vXShp/Ilcd9nIqjIaUK8ImM4eSfOxoVGcELKFdnRz/
	WHwp+ZvGSaypBfwTyUkFfowZ37DNs=
X-Google-Smtp-Source: AGHT+IEq/ZSpGchbW6QkUEuvQtmGiuTU9hScEXfCaoH9cjYsbUB6FJ9XKRYhHxs9lBIsysXSUvWnKN7svpPRZY44sHk=
X-Received: by 2002:a17:902:e5c1:b0:216:27f5:9dd7 with SMTP id
 d9443c01a7336-22434a42e02mr971865ad.11.1741368969927; Fri, 07 Mar 2025
 09:36:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304-james-perf-hybrid-list-v1-0-a363ffac283c@linaro.org>
 <20250304-james-perf-hybrid-list-v1-2-a363ffac283c@linaro.org>
 <CAP-5=fX+aSDLMDL3DMNCQ4tDuhaZPv-L6OgfOso3q5wf7anoGg@mail.gmail.com> <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org>
In-Reply-To: <12da919e-5674-4b12-a51d-ed767cc0b1ac@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Mar 2025 09:35:58 -0800
X-Gm-Features: AQ5f1JpN3gZ_WNTTyzjs3l5NZ7XIwS4pn2agGlXg0KjzWSDb9xxl6tCUCJrs1U0
Message-ID: <CAP-5=fWVw499hZ7WM7A+vUmxALX7M-kYXoEehQkv-fh6qHOoOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf list: Collapse similar events across PMUs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 6:08=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 05/03/2025 9:40 pm, Ian Rogers wrote:
> > On Tue, Mar 4, 2025 at 5:50=E2=80=AFAM James Clark <james.clark@linaro.=
org> wrote:
> >>
> >> Instead of showing multiple line items with the same event name and
> >> description, show a single line and concatenate all PMUs that this
> >> event can belong to.
> >>
> >> Don't do it for json output. Machine readable output doesn't need to b=
e
> >> minimized, and changing the "Unit" field to a list type would break
> >> backwards compatibility.
> >>
> >> Before:
> >>   $ perf list -v
> >>   ...
> >>   br_indirect_spec
> >>         [Branch speculatively executed,indirect branch. Unit: armv8_co=
rtex_a53]
> >>   br_indirect_spec
> >>         [Branch speculatively executed,indirect branch. Unit: armv8_co=
rtex_a57]
> >>
> >> After:
> >>
> >>   $ perf list -v
> >>   ...
> >>   br_indirect_spec
> >>         [Branch speculatively executed,indirect branch. Unit: armv8_co=
rtex_a53,armv8_cortex_a57]
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/builtin-list.c      |  2 ++
> >>   tools/perf/util/pmus.c         | 75 ++++++++++++++++++++++++++++++++=
+++++-----
> >>   tools/perf/util/print-events.h |  1 +
> >>   3 files changed, 70 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> >> index fed482adb039..aacd7beae2a0 100644
> >> --- a/tools/perf/builtin-list.c
> >> +++ b/tools/perf/builtin-list.c
> >> @@ -516,6 +516,7 @@ int cmd_list(int argc, const char **argv)
> >>                  .print_event =3D default_print_event,
> >>                  .print_metric =3D default_print_metric,
> >>                  .skip_duplicate_pmus =3D default_skip_duplicate_pmus,
> >> +               .collapse_events =3D true
> >
> > So collapse_events is put in the callbacks but isn't a callback. I
> > think skipping duplicates and collapsing are the same thing, I'd
> > prefer it if there weren't two terms for the same thing. If you prefer
> > collapsing as a name then default_skip_duplicate_pmus can be
> > default_collapse_pmus.
> >
>
> I can use the existing callback and rename it. That does have the effect
> of disabling this behavior in verbose mode which may be useful or may be
> unexpected to some people. But it seems pretty 50/50 so fewer callbacks
> are probably better.
>
> >>          };
> >>          const char *cputype =3D NULL;
> >>          const char *unit_name =3D NULL;
> >> @@ -574,6 +575,7 @@ int cmd_list(int argc, const char **argv)
> >>                          .print_event =3D json_print_event,
> >>                          .print_metric =3D json_print_metric,
> >>                          .skip_duplicate_pmus =3D json_skip_duplicate_=
pmus,
> >> +                       .collapse_events =3D false
> >>                  };
> >>                  ps =3D &json_ps;
> >>          } else {
> >> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> >> index 4d60bac2d2b9..cb1b14ade25b 100644
> >> --- a/tools/perf/util/pmus.c
> >> +++ b/tools/perf/util/pmus.c
> >> @@ -453,17 +453,50 @@ static int cmp_sevent(const void *a, const void =
*b)
> >>          /* Order by PMU name. */
> >>          if (as->pmu =3D=3D bs->pmu)
> >>                  return 0;
> >> -       return strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> >> +       ret =3D strcmp(as->pmu_name ?: "", bs->pmu_name ?: "");
> >> +       if (ret)
> >> +               return ret;
> >> +
> >> +       /* Order by remaining displayed fields for purposes of dedupli=
cation later */
> >> +       ret =3D strcmp(as->scale_unit ?: "", bs->scale_unit ?: "");
> >> +       if (ret)
> >> +               return ret;
> >> +       ret =3D !!as->deprecated - !!bs->deprecated;
> >> +       if (ret)
> >> +               return ret;
> >> +       ret =3D strcmp(as->desc ?: "", bs->desc ?: "");
> >> +       if (ret)
> >> +               return ret;
> >> +       return strcmp(as->long_desc ?: "", bs->long_desc ?: "");
> >>   }
> >>
> >> -static bool pmu_alias_is_duplicate(struct sevent *a, struct sevent *b=
)
> >> +enum dup_type {
> >> +       UNIQUE,
> >> +       DUPLICATE,
> >> +       SAME_TEXT
> >> +};
> >> +
> >> +static enum dup_type pmu_alias_duplicate_type(struct sevent *a, struc=
t sevent *b)
> >>   {
> >>          /* Different names -> never duplicates */
> >>          if (strcmp(a->name ?: "//", b->name ?: "//"))
> >> -               return false;
> >> +               return UNIQUE;
> >> +
> >> +       /* Duplicate PMU name and event name -> hide completely */
> >> +       if (strcmp(a->pmu_name, b->pmu_name) =3D=3D 0)
> >> +               return DUPLICATE;
> >> +
> >> +       /* Any other different display text -> not duplicate */
> >> +       if (strcmp(a->topic ?: "", b->topic ?: "") ||
> >> +           strcmp(a->scale_unit ?: "", b->scale_unit ?: "") ||
> >> +           a->deprecated !=3D b->deprecated ||
> >> +           strcmp(a->desc ?: "", b->desc ?: "") ||
> >> +           strcmp(a->long_desc ?: "", b->long_desc ?: "")) {
> >> +               return UNIQUE;
> >> +       }
> >>
> >> -       /* Don't remove duplicates for different PMUs */
> >> -       return strcmp(a->pmu_name, b->pmu_name) =3D=3D 0;
> >> +       /* Same display text but different PMU -> collapse */
> >> +       return SAME_TEXT;
> >>   }
> >>
> >>   struct events_callback_state {
> >> @@ -501,6 +534,21 @@ static int perf_pmus__print_pmu_events__callback(=
void *vstate,
> >>          return 0;
> >>   }
> >>
> >> +static void concat_pmu_names(char *pmu_names, size_t size, const char=
 *a, const char *b)
> >> +{
> >> +       size_t len =3D strlen(pmu_names);
> >> +       size_t added;
> >> +
> >> +       if (len)
> >> +               added =3D snprintf(pmu_names + len, size - len, ",%s",=
 b);
> >> +       else
> >> +               added =3D snprintf(pmu_names, size, "%s,%s", a, b);
> >> +
> >> +       /* Truncate with ... */
> >> +       if (added > 0 && added + len >=3D size)
> >> +               sprintf(pmu_names + size - 4, "...");
> >> +}
> >> +
> >>   void perf_pmus__print_pmu_events(const struct print_callbacks *print=
_cb, void *print_state)
> >>   {
> >>          struct perf_pmu *pmu;
> >> @@ -510,6 +558,7 @@ void perf_pmus__print_pmu_events(const struct prin=
t_callbacks *print_cb, void *p
> >>          struct events_callback_state state;
> >>          bool skip_duplicate_pmus =3D print_cb->skip_duplicate_pmus(pr=
int_state);
> >>          struct perf_pmu *(*scan_fn)(struct perf_pmu *);
> >> +       char pmu_names[128] =3D {0};
> >>
> >>          if (skip_duplicate_pmus)
> >>                  scan_fn =3D perf_pmus__scan_skip_duplicates;
> >> @@ -539,12 +588,21 @@ void perf_pmus__print_pmu_events(const struct pr=
int_callbacks *print_cb, void *p
> >>          qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
> >>          for (int j =3D 0; j < len; j++) {
> >>                  /* Skip duplicates */
> >> -               if (j < len - 1 && pmu_alias_is_duplicate(&aliases[j],=
 &aliases[j + 1]))
> >> -                       goto free;
> >> +               if (j < len - 1) {
> >> +                       enum dup_type dt =3D pmu_alias_duplicate_type(=
&aliases[j], &aliases[j + 1]);
> >> +
> >> +                       if (dt =3D=3D DUPLICATE) {
> >> +                               goto free;
> >> +                       } else if (print_cb->collapse_events && dt =3D=
=3D SAME_TEXT) {
> >> +                               concat_pmu_names(pmu_names, sizeof(pmu=
_names),
> >> +                                                aliases[j].pmu_name, =
aliases[j+1].pmu_name);
> >> +                               goto free;
> >> +                       }
> >> +               }
> >
> > I think a label called 'free' is a little unfortunate given the
> > function called free.
> > When I did things with sevent I was bringing over previous `perf list`
> > code mainly so that the perf list output before and after the changes
> > was identical. I wonder if this logic would be better placed in the
> > callback like default_print_event which already maintains state
> > (last_topic) to optionally print different things. This may better
> > encapsulate the behavior rather than the logic being in the PMU code.
> >
>
> Yeah I can have a look at putting it in one of the callbacks. But in the
> end builtin-list.c is the only user of perf_pmus__print_pmu_events()
> anyway so makes you wonder if the whole thing can be moved to
> builtin-list and open coded without the callbackyness.

I wanted to hide some of the innards of pmus, so I think that's the
reason it is as it is. The whole `sevent` was pre-existing and
maintained so that the output was the same.

> >>
> >>                  print_cb->print_event(print_state,
> >>                                  aliases[j].topic,
> >> -                               aliases[j].pmu_name,
> >> +                               pmu_names[0] ? pmu_names : aliases[j].=
pmu_name,
> >>                                  aliases[j].name,
> >>                                  aliases[j].alias,
> >>                                  aliases[j].scale_unit,
> >> @@ -553,6 +611,7 @@ void perf_pmus__print_pmu_events(const struct prin=
t_callbacks *print_cb, void *p
> >>                                  aliases[j].desc,
> >>                                  aliases[j].long_desc,
> >>                                  aliases[j].encoding_desc);
> >
> > The encoding_desc will have a PMU with the suffix removed as per
> > skipping duplicates:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n1954
> > So I think something like:
> > ```
> >    br_mis_pred_retired
> >         [Instruction architecturally executed,mispredicted branch. Unit=
:
> >          armv9_cortex_a510,armv9_cortex_a710]
> > ```
> > Would have an encoding of `armv9_cortex_a510/.../` without the a710
> > encoding being present. That said, I'm not sure anyone cares :-)
> >
> > Thanks,
> > Ian
> >
>
> Ah, in that case I'll disable it for --detailed as well as --json. I
> could compare encoding_desc in pmu_alias_duplicate_type() but they'll
> always be different because of the PMU name, so there's no point. And
> displaying multiple encoding_descs would be fiddly too.

So I'd like not to have the encoding_desc removed. It is useful for
debugging.. I meant by people not caring that the format of that
string is under specified, so the PMU name not being 100% accurate
likely doesn't affect people.

Thanks,
Ian


> >> +               pmu_names[0] =3D '\0';
> >>   free:
> >>                  zfree(&aliases[j].name);
> >>                  zfree(&aliases[j].alias);
> >> diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-ev=
ents.h
> >> index 445efa1636c1..e91f9f830a2a 100644
> >> --- a/tools/perf/util/print-events.h
> >> +++ b/tools/perf/util/print-events.h
> >> @@ -27,6 +27,7 @@ struct print_callbacks {
> >>                          const char *threshold,
> >>                          const char *unit);
> >>          bool (*skip_duplicate_pmus)(void *print_state);
> >> +       bool collapse_events;
> >>   };
> >>
> >>   /** Print all events, the default when no options are specified. */
> >>
> >> --
> >> 2.34.1
> >>
>
