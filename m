Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E07C74A44
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCLCEf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLCEe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:04:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E0642BDA
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:04:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l1so8331304wry.12
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678586670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/CejgmZHTsVZv9QvT0Arr0+JFH+g4A1lKD4Au9URvY=;
        b=aDyPNuDSQ2zCNEYOn8/D/oRw/6lADae/Bv3I3K5vp2Rp9qqZ2A80ei1YHKxat19lVj
         rotbWOjURq7Nd3G6ApcSAiXfRoEJJBy7caEYKnu/w1fm0YQBlbUSxRecfx0E5Zdtp1HV
         0/QNXlU6E8OR4EvOaYfAWuxKI87wmRRB8FyGfFwahFglgTLuFj5T7y/+Zk/ekC/gAXsp
         C1rtv1m5KS8Z+OEmRcpWOx+HXz2yI/6OYvLvCL+vJthyckB8P4y3rai+VtfHNi/pCsgE
         U/UjWbLGDJE6Wsi2BPA8N4UQRNuONpnlK0lMsx6xp0Qng7tQrc2SLbilsgMHpZsZX/79
         GjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678586670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/CejgmZHTsVZv9QvT0Arr0+JFH+g4A1lKD4Au9URvY=;
        b=u1APVjjTfeogPBCPdWLRTHRwBFUbAV/GWxDu7zmc4tTdEOuWgXbG+cDGimmj0VHcSm
         5J4dweOipYgo12fLMNPWq2Jlp5dR7TYlJLTbQ3uPq3ce0NUIt383Zj5yC0JC3p2iiDbC
         2OR64y0bYpKMTi/g8aMLhwNAFSiPO424EKLKK+cuZLnlRJ6G9CVbZYWCiT+23y+LvBTv
         /SUE2klpmBia7qxx7F7DR1O3MpAln0CYroSuDagfjC+G8w81LIMP2rK/0DqYycD9yqQI
         c6xuF6DsuJ5TT1uGMhfrGkgI14Ou1iP7JYOQMPjmb03451z6elCJvgZ53Tc1ne/FVpnZ
         3MZw==
X-Gm-Message-State: AO0yUKXMsjCqiFFtXyeJKapOwqTfHY4yxuqJX8/93MYwmk/o+BtI1f6B
        1AQn4GiVx0BfmdE7XeQ8VPZ8mIA0WzoxPiZSSA3Pag==
X-Google-Smtp-Source: AK7set8yEPEvhHpqQNUlqbtvXbO6+2yL4bPJmFRek0zg0q5EQyJ1kPDvOV+38aS+nnk4gT7nmZgrFMa50JfItyK+4QY=
X-Received: by 2002:adf:dd4f:0:b0:2c5:5297:1f9a with SMTP id
 u15-20020adfdd4f000000b002c552971f9amr6486702wrm.14.1678586670302; Sat, 11
 Mar 2023 18:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com> <20230308225912.1960990-12-irogers@google.com>
 <fd1f74e0-718c-5745-c224-5f4cee2ac2b2@intel.com>
In-Reply-To: <fd1f74e0-718c-5745-c224-5f4cee2ac2b2@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 11 Mar 2023 18:04:18 -0800
Message-ID: <CAP-5=fU-EO+wPeVZT2V29-fB79OUVyazzaK_Cqa_piXe3QB+Qg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] perf parse-events: Warn when events are regrouped
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Mar 9, 2023 at 11:29=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 9/03/23 00:59, Ian Rogers wrote:
> > Use if an event is reordered or the number of groups increases to
> > signal that regrouping has happened and warn about it. Disable the
> > warning in the case wild card PMU names are used and for metrics.
>
> The new warning seems to happen no matter what the order
> in some cases e.g.
>
> $ perf record -e branch-misses//u -e cycles:u  -- uname
> WARNING: events were regrouped to match PMUs
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.004 MB perf.data (11 samples) ]
>
> $ perf record -e cycles:u -e branch-misses//u -- uname
> WARNING: events were regrouped to match PMUs
> Linux
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.005 MB perf.data (16 samples) ]

Thanks Adrian! It is caused by lists of evsels being merged because of
the multiple -e options. There was an assumption idx values would be
sequential and when we merge them this is no longer the case. I added
a fix for v5.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/parse-events.c |  2 +-
> >  tools/perf/tests/pmu-events.c   |  2 +-
> >  tools/perf/util/metricgroup.c   |  3 ++-
> >  tools/perf/util/parse-events.c  | 28 ++++++++++++++++++++--------
> >  tools/perf/util/parse-events.h  |  7 ++++---
> >  tools/perf/util/parse-events.y  |  1 +
> >  6 files changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-e=
vents.c
> > index ffa6f0a90741..b1c2f0a20306 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -2103,7 +2103,7 @@ static int test_event_fake_pmu(const char *str)
> >
> >       parse_events_error__init(&err);
> >       perf_pmu__test_parse_init();
> > -     ret =3D __parse_events(evlist, str, &err, &perf_pmu__fake);
> > +     ret =3D __parse_events(evlist, str, &err, &perf_pmu__fake, /*warn=
_if_reordered=3D*/true);
> >       if (ret) {
> >               pr_debug("failed to parse event '%s', err %d, str '%s'\n"=
,
> >                        str, ret, err.str);
> > diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-event=
s.c
> > index 6ccd413b5983..7f8e86452527 100644
> > --- a/tools/perf/tests/pmu-events.c
> > +++ b/tools/perf/tests/pmu-events.c
> > @@ -785,7 +785,7 @@ static int check_parse_id(const char *id, struct pa=
rse_events_error *error,
> >                */
> >               perf_pmu__test_parse_init();
> >       }
> > -     ret =3D __parse_events(evlist, dup, error, fake_pmu);
> > +     ret =3D __parse_events(evlist, dup, error, fake_pmu, /*warn_if_re=
ordered=3D*/true);
> >       free(dup);
> >
> >       evlist__delete(evlist);
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index de6dd527a2ba..5783f4c2d1ef 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1441,7 +1441,8 @@ static int parse_ids(bool metric_no_merge, struct=
 perf_pmu *fake_pmu,
> >       }
> >       pr_debug("Parsing metric events '%s'\n", events.buf);
> >       parse_events_error__init(&parse_error);
> > -     ret =3D __parse_events(parsed_evlist, events.buf, &parse_error, f=
ake_pmu);
> > +     ret =3D __parse_events(parsed_evlist, events.buf, &parse_error, f=
ake_pmu,
> > +                          /*warn_if_reordered=3D*/false);
> >       if (ret) {
> >               parse_events_error__print(&parse_error, events.buf);
> >               goto err_out;
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 9ec3c1dc81e0..4bb28c32b511 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2157,11 +2157,13 @@ static int evlist__cmp(void *state, const struc=
t list_head *l, const struct list
> >       return arch_evlist__cmp(lhs, rhs);
> >  }
> >
> > -static void parse_events__sort_events_and_fix_groups(struct list_head =
*list)
> > +static bool parse_events__sort_events_and_fix_groups(struct list_head =
*list)
> >  {
> >       int idx =3D -1;
> >       struct evsel *pos, *cur_leader =3D NULL;
> >       struct perf_evsel *cur_leaders_grp =3D NULL;
> > +     bool idx_changed =3D false;
> > +     int orig_num_leaders =3D 0, num_leaders =3D 0;
> >
> >       /*
> >        * Compute index to insert ungrouped events at. Place them where =
the
> > @@ -2170,11 +2172,11 @@ static void parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >       list_for_each_entry(pos, list, core.node) {
> >               const struct evsel *pos_leader =3D evsel__leader(pos);
> >
> > -             if (pos !=3D pos_leader || pos->core.nr_members > 1)
> > -                     continue;
> > +             if (pos =3D=3D pos_leader)
> > +                     orig_num_leaders++;
> >
> > -             idx =3D pos->core.idx;
> > -             break;
> > +             if (idx =3D=3D -1 && pos =3D=3D pos_leader && pos->core.n=
r_members < 2)
> > +                     idx =3D pos->core.idx;
> >       }
> >
> >       /* Sort events. */
> > @@ -2192,6 +2194,8 @@ static void parse_events__sort_events_and_fix_gro=
ups(struct list_head *list)
> >               bool force_grouped =3D arch_evsel__must_be_in_group(pos);
> >
> >               /* Reset index and nr_members. */
> > +             if (pos->core.idx !=3D idx)
> > +                     idx_changed =3D true;
> >               pos->core.idx =3D idx++;
> >               pos->core.nr_members =3D 0;
> >
> > @@ -2225,12 +2229,18 @@ static void parse_events__sort_events_and_fix_g=
roups(struct list_head *list)
> >               }
> >       }
> >       list_for_each_entry(pos, list, core.node) {
> > -             pos->core.leader->nr_members++;
> > +             struct evsel *pos_leader =3D evsel__leader(pos);
> > +
> > +             if (pos =3D=3D pos_leader)
> > +                     num_leaders++;
> > +             pos_leader->core.nr_members++;
> >       }
> > +     return idx_changed || num_leaders !=3D orig_num_leaders;
> >  }
> >
> >  int __parse_events(struct evlist *evlist, const char *str,
> > -                struct parse_events_error *err, struct perf_pmu *fake_=
pmu)
> > +                struct parse_events_error *err, struct perf_pmu *fake_=
pmu,
> > +                bool warn_if_reordered)
> >  {
> >       struct parse_events_state parse_state =3D {
> >               .list     =3D LIST_HEAD_INIT(parse_state.list),
> > @@ -2250,7 +2260,9 @@ int __parse_events(struct evlist *evlist, const c=
har *str,
> >               return -1;
> >       }
> >
> > -     parse_events__sort_events_and_fix_groups(&parse_state.list);
> > +     if (parse_events__sort_events_and_fix_groups(&parse_state.list) &=
&
> > +         warn_if_reordered && !parse_state.wild_card_pmus)
> > +             pr_warning("WARNING: events were regrouped to match PMUs\=
n");
> >
> >       /*
> >        * Add list to the evlist even with errors to allow callers to cl=
ean up.
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-eve=
nts.h
> > index 767ad1729228..46204c1a7916 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -26,13 +26,13 @@ int parse_events_option(const struct option *opt, c=
onst char *str, int unset);
> >  int parse_events_option_new_evlist(const struct option *opt, const cha=
r *str, int unset);
> >  __attribute__((nonnull(1, 2, 3)))
> >  int __parse_events(struct evlist *evlist, const char *str, struct pars=
e_events_error *error,
> > -                struct perf_pmu *fake_pmu);
> > +                struct perf_pmu *fake_pmu, bool warn_if_reordered);
> >
> > -__attribute__((nonnull))
> > +__attribute__((nonnull(1, 2, 3)))
> >  static inline int parse_events(struct evlist *evlist, const char *str,
> >                              struct parse_events_error *err)
> >  {
> > -     return __parse_events(evlist, str, err, NULL);
> > +     return __parse_events(evlist, str, err, /*fake_pmu=3D*/NULL, /*wa=
rn_if_reordered=3D*/true);
> >  }
> >
> >  int parse_event(struct evlist *evlist, const char *str);
> > @@ -128,6 +128,7 @@ struct parse_events_state {
> >       int                        stoken;
> >       struct perf_pmu           *fake_pmu;
> >       char                      *hybrid_pmu_name;
> > +     bool                       wild_card_pmus;
> >  };
> >
> >  void parse_events__shrink_config_terms(void);
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-eve=
nts.y
> > index 3a04602d2982..4488443e506e 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -323,6 +323,7 @@ event_pmu_name opt_pmu_config
> >                               if (!parse_events_add_pmu(_parse_state, l=
ist, pmu->name, terms,
> >                                                         /*auto_merge_st=
ats=3D*/true)) {
> >                                       ok++;
> > +                                     parse_state->wild_card_pmus =3D t=
rue;
> >                               }
> >                               parse_events_terms__delete(terms);
> >                       }
>
