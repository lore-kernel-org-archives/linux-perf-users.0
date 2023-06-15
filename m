Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB320EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 22:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjFOWFP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jun 2023 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjFOWFO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jun 2023 18:05:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD2199
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 15:05:12 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f9b7de94e7so88431cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Jun 2023 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686866712; x=1689458712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MQdt51wzlPU/epwCZqMAyo1fEWwjjdz65gOqta5sgs=;
        b=6KuVsRAAX1cTHUgLQIDTQiMXfdTgBCq7XDgl8UcGReAPo+JrpSeH/L1irmJKkD/nOI
         9TvslKeaij02HStpl2UaoxaOGjuN98H62sqF7g2IPu7gTFjeBzNllGI0Rp9x1qNP/YWC
         coY+xf0j11kJm7SDujs1yTg81iVIM7dBk/6eokl7Y24xG5ia3gkDRNwyuLhUaVBmY7uN
         Gt5x4kUwnFKeCkfMAOcN41VduhUB2sJU/d77fsmczmSRh8ciCDWzsl9VGWAm8klDkfOH
         cFJ+o/K4apvzgG+JKB3GKjG9LO62wtmr7VIedppVPxR54pIghoKsmMnT1s8fkJGTmR7x
         vrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686866712; x=1689458712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MQdt51wzlPU/epwCZqMAyo1fEWwjjdz65gOqta5sgs=;
        b=FWurX7v3r2J3kTkMIbJRNmlzr2K5a04fIFBEx3scNn4PLRHu4qU8HFg9xrg5OPXW3V
         bRWyKIsLIcFrdmRyCOx/XcryMOor7o2/08U8xTrIjkR7SGkY+3KPRKRU3m7YnGtE7uMt
         A8OTtxVxSxzJLHwujqDx2n9duu66LbhghwSk4x8tCRDcWMIN+T4i8h4LKFV7ry6nlYiR
         4cNNdmKu6hoo0xpe027SBak4LjSqKZ3cxOh641txiJiUoNET0Yfnr+FsbCPGxGg1GQM8
         HrG0XUXeinNDLd5Jy8K6C3qv7AWLjIk67ZfAB3znu730cg06eNu54eWWZwWb/IYs9+UF
         pHTg==
X-Gm-Message-State: AC+VfDwIjT4bqEHw/E5hY6mURvGuCaMlJqKfwExsfGmdHRLbER3/ANlz
        V12mEdfhkD3iXavWsB14lgN33Wk/Uz6Fd68HtpFScg==
X-Google-Smtp-Source: ACHHUZ5X+VfIBVKQbDcDVXcaMOSo7nueFY6eJ+T2GDU1wgd9WaKoDTKPyolJkytZ1KpqifCSIeBE9OY6dUsPaQVIw2g=
X-Received: by 2002:a05:622a:110e:b0:3f8:5b2:aef5 with SMTP id
 e14-20020a05622a110e00b003f805b2aef5mr310865qty.29.1686866711891; Thu, 15 Jun
 2023 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230615135315.3662428-1-kan.liang@linux.intel.com> <20230615135315.3662428-5-kan.liang@linux.intel.com>
In-Reply-To: <20230615135315.3662428-5-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 15 Jun 2023 15:05:00 -0700
Message-ID: <CAP-5=fU9qZ8jb=etO0U3tpG3XuvZ_fX5CExVL_gQag55Q8bPfA@mail.gmail.com>
Subject: Re: [PATCH V3 4/8] perf metrics: Sort the Default metricgroup
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 15, 2023 at 6:54=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The new default mode will print the metrics as a metric group. The
> metrics from the same metric group must be adjacent to each other in the
> metric list. But the metric_list_cmp() sorts metrics by the number of
> events.
>
> Add a new sort for the Default metricgroup, which sorts by
> default_metricgroup_name and metric_name.
>
> Add is_default in the struct metric_event to indicate that it's from
> the Default metricgroup.
>
> Store the displayed metricgroup name of the Default metricgroup into
> the metric expr for output.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/metricgroup.c | 37 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/metricgroup.h |  3 +++
>  2 files changed, 40 insertions(+)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 8b19644ade7d..e20adbdd5b56 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -79,6 +79,7 @@ static struct rb_node *metric_event_new(struct rblist *=
rblist __maybe_unused,
>                 return NULL;
>         memcpy(me, entry, sizeof(struct metric_event));
>         me->evsel =3D ((struct metric_event *)entry)->evsel;
> +       me->is_default =3D false;
>         INIT_LIST_HEAD(&me->head);
>         return &me->nd;
>  }
> @@ -1160,6 +1161,25 @@ static int metric_list_cmp(void *priv __maybe_unus=
ed, const struct list_head *l,
>         return right_count - left_count;
>  }
>
> +/**
> + * default_metricgroup_cmp - Implements complex key for the Default metr=
icgroup
> + *                          that first sorts by default_metricgroup_name=
, then
> + *                          metric_name.
> + */
> +static int default_metricgroup_cmp(void *priv __maybe_unused,
> +                                  const struct list_head *l,
> +                                  const struct list_head *r)
> +{
> +       const struct metric *left =3D container_of(l, struct metric, nd);
> +       const struct metric *right =3D container_of(r, struct metric, nd)=
;
> +       int diff =3D strcmp(right->default_metricgroup_name, left->defaul=
t_metricgroup_name);
> +
> +       if (diff)
> +               return diff;
> +
> +       return strcmp(right->metric_name, left->metric_name);
> +}
> +
>  struct metricgroup__add_metric_data {
>         struct list_head *list;
>         const char *pmu;
> @@ -1515,6 +1535,7 @@ static int parse_groups(struct evlist *perf_evlist,
>         LIST_HEAD(metric_list);
>         struct metric *m;
>         bool tool_events[PERF_TOOL_MAX] =3D {false};
> +       bool is_default =3D !strcmp(str, "Default");
>         int ret;
>
>         if (metric_events_list->nr_entries =3D=3D 0)
> @@ -1549,6 +1570,9 @@ static int parse_groups(struct evlist *perf_evlist,
>                         goto out;
>         }
>
> +       if (is_default)
> +               list_sort(NULL, &metric_list, default_metricgroup_cmp);
> +
>         list_for_each_entry(m, &metric_list, nd) {
>                 struct metric_event *me;
>                 struct evsel **metric_events;
> @@ -1637,6 +1661,19 @@ static int parse_groups(struct evlist *perf_evlist=
,
>                 expr->metric_unit =3D m->metric_unit;
>                 expr->metric_events =3D metric_events;
>                 expr->runtime =3D m->pctx->sctx.runtime;
> +               if (m->pmu && strcmp(m->pmu, "cpu")) {

This shouldn't compare with a PMU name like this. What happens for
memory bandwidth which could be logically with a memory controller
PMU?

> +                       char *name;
> +
> +                       if (asprintf(&name, "%s (%s)", m->default_metricg=
roup_name, m->pmu) < 0)
> +                               expr->default_metricgroup_name =3D m->def=
ault_metricgroup_name;

Who owns the string in this case? Can't you end up with
default_metricgroup_name pointing to a freed string? I think this
feels a lot more like output code, so I'm unclear why we're setting it
up in the metric.

> +                       else {
> +                               expr->default_metricgroup_name =3D strdup=
(name);

But name was just allocated, why strdup?

This is still leaking it is just the strdup now leaks and not the asprintf:
```
=3D=3D2495793=3D=3DERROR: LeakSanitizer: detected memory leaks

Direct leak of 6199 byte(s) in 340 object(s) allocated from:
   #0 0x7f175c27077b in __interceptor_strdup
../../../../src/libsanitizer/asan/asan_interceptors.cp
p:439
   #1 0x5596323b2a28 in parse_groups util/metricgroup.c:1670
   #2 0x5596323b2f08 in metricgroup__parse_groups_test util/metricgroup.c:1=
721
   #3 0x5596322992bf in test__parsing_callback tests/pmu-events.c:837
   #4 0x559632658ac6 in pmu_metrics_table_for_each_metric
/tmp/perf/pmu-events/pmu-events.c:61641
   #5 0x5596326590fc in pmu_for_each_core_metric
/tmp/perf/pmu-events/pmu-events.c:61742
   #6 0x559632299b7c in test__parsing tests/pmu-events.c:898
   #7 0x5596322663b0 in run_test tests/builtin-test.c:236
   #8 0x559632266655 in test_and_print tests/builtin-test.c:265
   #9 0x55963226766f in __cmd_test tests/builtin-test.c:436
   #10 0x559632268953 in cmd_test tests/builtin-test.c:559
   #11 0x5596322f5916 in run_builtin
/home/irogers/kernel.org/tools/perf/perf.c:323
   #12 0x5596322f5e87 in handle_internal_command
/home/irogers/kernel.org/tools/perf/perf.c:377
   #13 0x5596322f624f in run_argv /home/irogers/kernel.org/tools/perf/perf.=
c:421
   #14 0x5596322f67b7 in main /home/irogers/kernel.org/tools/perf/perf.c:53=
7
   #15 0x7f175bebf189 in __libc_start_call_main
../sysdeps/nptl/libc_start_call_main.h:58

SUMMARY: AddressSanitizer: 6199 byte(s) leaked in 340 allocation(s).
```

> +                               free(name);
> +                       }
> +               } else
> +                       expr->default_metricgroup_name =3D m->default_met=
ricgroup_name;

Who owns the string in this case? Can't you end up with
default_metricgroup_name pointing to a freed string?

I spent some time trying to rationalize this to add as a patch, but
then the more I look at things like the strcmp with "cpu" my changes
were going to modify behavior in a way that would need you to test and
sign-off, so I'll hold back.

To test with leak/address sanitizer use the tmp.perf-tools-next
branch, I build with:
$ make -C tools/perf O=3D/tmp/perf DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g
-fno-omit-frame-pointer -DREFCNT_CHECKING=3D1 -fsanitize=3Daddress"
NO_LIBTRACEEVENT=3D1
but the only bit you really need is "-fsanitize=3Daddress" which both
clang and gcc support.

Address sanitizer from apt-cache is:
libasan6 - AddressSanitizer -- a fast memory error detector

Fedora and other distro.s have it too.

Thanks,
Ian

> +               if (is_default)
> +                       me->is_default =3D true;
>                 list_add(&expr->nd, &me->head);
>         }
>
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.=
h
> index bf18274c15df..d5325c6ec8e1 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -22,6 +22,7 @@ struct cgroup;
>  struct metric_event {
>         struct rb_node nd;
>         struct evsel *evsel;
> +       bool is_default; /* the metric evsel from the Default metricgroup=
 */
>         struct list_head head; /* list of metric_expr */
>  };
>
> @@ -55,6 +56,8 @@ struct metric_expr {
>          * more human intelligible) and then add "MiB" afterward when dis=
played.
>          */
>         const char *metric_unit;
> +       /** Displayed metricgroup name of the Default metricgroup */
> +       const char *default_metricgroup_name;
>         /** Null terminated array of events used by the metric. */
>         struct evsel **metric_events;
>         /** Null terminated array of referenced metrics. */
> --
> 2.35.1
>
