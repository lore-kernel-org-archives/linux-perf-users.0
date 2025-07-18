Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BA72E88A5
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857076; cv=none; b=IgYNv4iKOo4pVHjP0AQ1/TRK4XdppgZqLxDc8NesPR8kk5tNITKNJjQC4xYhx0VS1evyVR7tNb9XqQGLMXBIpc0wobvyV51T+Y30yB/cGxOcUhPEoJ9CZch86dFuwR4k7LuVV46AAncUEi71vRq/BcB1ZK2nbDZKni+U6DGZvI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857076; c=relaxed/simple;
	bh=Un3IQkJeiDPQ8PMY2tswK7nzX/vyv8dM0hZwI3y0HeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QQOfE4tb+cw+/R2/Io1NsTNV4q9N38Pmxd0aRwqrFzjPz4NAEPkIvcG/cPmpavMx1uW390ENIsCfMxtoUpcCNyjE4T329OsmEYAhNy0dtj1mBy3xMsKXFo/zfmGKuDIjmzlj4ibNkICY7x0INYofoh9v0T/NlojfoKth0L5dOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qz1wePJ0; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qz1wePJ0"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e283b2d065so2215ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jul 2025 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857072; x=1753461872; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXsly21medzqYLVpsBH94XVSBZjt3gkSNqCZltc1opc=;
        b=qz1wePJ0TB7uADKLQO4AhARKlKUbnK02Sv+CeEYgegSgoyNXIafCAN22dPWlGYCGas
         bD59vjziN84N6Fcwumha9AvdNgxiy4kayW0WOo5Nv07l2fItaUQWUgjmXIIAaFK6bU7n
         CZiL9lf4cXDpmAm2mHpgm4jJDEnaMfppJHlW851Nn/aTl3jZ4yZhs6q7/+5kdZxacH5A
         o2/mweaTNvphQPXPPF+p9wWEFplZ7JPkll2DGS567DLTaFE0f+27vKjtIrqHrGcPNHXF
         jyC6pUrJfteGrHaTNoJXDV6TCg7JX77Q+1yQtr4prmURpD0klXC8d6spJZ4ktgyB5qNy
         Zpow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857072; x=1753461872;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXsly21medzqYLVpsBH94XVSBZjt3gkSNqCZltc1opc=;
        b=hB15ko5ZOhUCdmDzq+2MSH/5LP6CGHh2Juq//HkxhWjketIahg16Jo4m2qneWpUqj3
         aDQCbX/XfbsyqhvkKtFHgu1qNduLSOl5lR9L4d+FMd47p1r0RTlWpSp9wfManfsg9X9w
         gZjkMQgtOVzRZIGgcV9jG+ZCoL4T68HbG/20fMGGTJHDp8+HxeTHQdDcuYurUmHFcHeF
         4ab+lgT2UMCe2rsfuc8bkDr0TrSc56yXdIRcEMbZngb3Zpq895wh0ur5DkHlmxfXiyFO
         erQlj+hTSeYx8HU7AqwGafzJQXylDiY3ASjkiUsCUcHscPYIQQBaDVHTfBivXE5bMZI4
         I7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaNkgTXLnfYC3AUwE8h9KxWqIwtut//FqOpWPSxoX2gutctDTMiMlAzyuaFwz288jKeWRF+LWQ2S8S2uFZaLNE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5cX/UQvdD/Pu9QP2FmGipJXlKGBhOzEH/RubQia3pfoODkTw2
	qYWB3eYiTGqcizI0eMrrNMo9q+W2PS/KeoTyABJ6+bfKdkhgwJMXdUlGqrFbo1m12gnRD8rOmeo
	5w8Xv77C5aw9YB/q5muJPuYDBx6XOXtdycTg0FL4/
X-Gm-Gg: ASbGncv9/yZKaSI1sChpBWPbtUNP3/yCLkKH8oMbSvwKmBZCW1aTFj0yE7n4MEqzFw6
	Xr5tTGfbLPVaQoZu0S61KQujGfcdR7jGYMkSNphlljoM4RyesSrsXhjuG7oDOn/GXV5y2FzQtm7
	Cmf+24xFJRGLJtr5QWjwzPbvUe3lDmnVBhFYjM+yaAYcVePkgMEskmA3sffjphlGUBJi33sfhwh
	9eCNlzHiiy4xZFtz8rPOGaG+8Yh4BHRyLL9
X-Google-Smtp-Source: AGHT+IGJxr6fGaafNOZIrnXiRHmOD7WB8/q+O0yZKI8L+1WYmuRfdnQZbZ/yz5eVNsJzOIZDhyMIjk0WAjKgLk9bKYw=
X-Received: by 2002:a05:6e02:480f:b0:3dc:7cc4:3cb0 with SMTP id
 e9e14a558f8ab-3e295ef84bdmr6588725ab.18.1752857071772; Fri, 18 Jul 2025
 09:44:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718132750.1546457-1-irogers@google.com> <20250718132750.1546457-2-irogers@google.com>
In-Reply-To: <20250718132750.1546457-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 18 Jul 2025 09:44:19 -0700
X-Gm-Features: Ac12FXxEdMbu_nJFTda17NUCY6udzMFe8rVkR5cGAGM6JI8hJHEvEjZGGK3L6Os
Message-ID: <CAP-5=fUwWONnjrgo49cX1fsv4Xn4nT+z_Hz6eXQR23cfXznBdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf parse-events: Fix missing slots for Intel
 topdown metric events
To: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@linaro.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:27=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> Topdown metric events require grouping with a slots event. In perf
> metrics this is currently achieved by metrics adding an unnecessary
> "0 * tma_info_thread_slots". New TMA metrics trigger optimizations of
> the metric expression that removes the event and breaks the metric due
> to the missing but required event. Add a pass immediately before
> sorting and fixing parsed events, that insert a slots event if one is
> missing. Update test expectations to match this.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/x86/util/evlist.c  | 24 ++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.c | 27 +++++++++++++++++++++++++++
>  tools/perf/arch/x86/util/topdown.h |  2 ++
>  tools/perf/tests/parse-events.c    | 24 ++++++++++++------------
>  tools/perf/util/evlist.h           |  1 +
>  tools/perf/util/parse-events.c     | 10 ++++++++++
>  6 files changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util=
/evlist.c
> index 1969758cc8c1..75e9d00a1494 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -81,3 +81,27 @@ int arch_evlist__cmp(const struct evsel *lhs, const st=
ruct evsel *rhs)
>         /* Default ordering by insertion index. */
>         return lhs->core.idx - rhs->core.idx;
>  }
> +
> +int arch_evlist__add_required_events(struct list_head *list)
> +{
> +       struct evsel *pos, *metric_event =3D NULL;
> +       int idx =3D 0;
> +
> +       if (!topdown_sys_has_perf_metrics())
> +               return 0;
> +
> +       list_for_each_entry(pos, list, core.node) {
> +               if (arch_is_topdown_slots(pos)) {
> +                       /* Slots event already present, nothing to do. */
> +                       return 0;
> +               }
> +               if (metric_event =3D=3D NULL && arch_is_topdown_metrics(p=
os))
> +                       metric_event =3D pos;
> +               idx++;
> +       }
> +       if (metric_event =3D=3D NULL) {
> +               /* No topdown metric events, nothing to do. */
> +               return 0;
> +       }
> +       return topdown_insert_slots_event(list, idx + 1, metric_event);
> +}
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/uti=
l/topdown.c
> index 66b231fbf52e..5d53e3d59c0c 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -77,3 +77,30 @@ bool arch_topdown_sample_read(struct evsel *leader)
>
>         return false;
>  }
> +
> +/*
> + * Make a copy of the topdown metric event metric_event with the given i=
ndex but
> + * change its configuration to be a topdown slots event. Copying from
> + * metric_event ensures modifiers are the same.
> + */
> +int topdown_insert_slots_event(struct list_head *list, int idx, struct e=
vsel *metric_event)
> +{
> +       struct evsel *evsel =3D evsel__new_idx(&metric_event->core.attr, =
idx);
> +
> +       if (!evsel)
> +               return -ENOMEM;
> +
> +       evsel->core.attr.config =3D TOPDOWN_SLOTS;
> +       evsel->core.cpus =3D perf_cpu_map__get(metric_event->core.cpus);
> +       evsel->core.own_cpus =3D perf_cpu_map__get(metric_event->core.own=
_cpus);

Note, this change conflicts with:
https://lore.kernel.org/lkml/20250717210233.1143622-1-irogers@google.com/
(reviewed but not merged) due to own_cpus being renamed to pmu_cpus. The fi=
x is:
```
--- a/tools/perf/arch/x86/util/topdown.c
+++ b/tools/perf/arch/x86/util/topdown.c
@@ -92,7 +92,7 @@ int topdown_insert_slots_event(struct list_head
*list, int idx, struct evsel *me

       evsel->core.attr.config =3D TOPDOWN_SLOTS;
       evsel->core.cpus =3D perf_cpu_map__get(metric_event->core.cpus);
-       evsel->core.own_cpus =3D perf_cpu_map__get(metric_event->core.own_c=
pus);
+       evsel->core.pmu_cpus =3D perf_cpu_map__get(metric_event->core.pmu_c=
pus);
       evsel->core.is_pmu_core =3D true;
       evsel->pmu =3D metric_event->pmu;
       evsel->name =3D strdup("slots");
```
and I can send this fix when:
https://lore.kernel.org/lkml/20250717210233.1143622-1-irogers@google.com/
lands.

Thanks,
Ian

> +       evsel->core.is_pmu_core =3D true;
> +       evsel->pmu =3D metric_event->pmu;
> +       evsel->name =3D strdup("slots");
> +       evsel->precise_max =3D metric_event->precise_max;
> +       evsel->sample_read =3D metric_event->sample_read;
> +       evsel->weak_group =3D metric_event->weak_group;
> +       evsel->bpf_counter =3D metric_event->bpf_counter;
> +       evsel->retire_lat =3D metric_event->retire_lat;
> +       list_add_tail(&evsel->core.node, list);
> +       return 0;
> +}
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/uti=
l/topdown.h
> index 2349536cf882..69035565e649 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -5,9 +5,11 @@
>  #include <stdbool.h>
>
>  struct evsel;
> +struct list_head;
>
>  bool topdown_sys_has_perf_metrics(void);
>  bool arch_is_topdown_slots(const struct evsel *evsel);
>  bool arch_is_topdown_metrics(const struct evsel *evsel);
> +int topdown_insert_slots_event(struct list_head *list, int idx, struct e=
vsel *metric_event);
>
>  #endif
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-eve=
nts.c
> index 5ec2e5607987..bb8004397650 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -719,20 +719,20 @@ static int test__checkevent_pmu_partial_time_callgr=
aph(struct evlist *evlist)
>
>  static int test__checkevent_pmu_events(struct evlist *evlist)
>  {
> -       struct evsel *evsel =3D evlist__first(evlist);
> +       struct evsel *evsel;
>
> -       TEST_ASSERT_VAL("wrong number of entries", 1 =3D=3D evlist->core.=
nr_entries);
> -       TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel->core.at=
tr.type ||
> -                                     strcmp(evsel->pmu->name, "cpu"));
> -       TEST_ASSERT_VAL("wrong exclude_user",
> -                       !evsel->core.attr.exclude_user);
> -       TEST_ASSERT_VAL("wrong exclude_kernel",
> -                       evsel->core.attr.exclude_kernel);
> -       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip)=
;
> -       TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned);
> -       TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.exclusive);
> +       TEST_ASSERT_VAL("wrong number of entries", 1 <=3D evlist->core.nr=
_entries);
>
> +       evlist__for_each_entry(evlist, evsel) {
> +               TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW =3D=3D evsel-=
>core.attr.type ||
> +                                             strcmp(evsel->pmu->name, "c=
pu"));
> +               TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.e=
xclude_user);
> +               TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.=
exclude_kernel);
> +               TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.excl=
ude_hv);
> +               TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.pre=
cise_ip);
> +               TEST_ASSERT_VAL("wrong pinned", !evsel->core.attr.pinned)=
;
> +               TEST_ASSERT_VAL("wrong exclusive", !evsel->core.attr.excl=
usive);
> +       }
>         return TEST_OK;
>  }
>
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index fac1a01ba13f..1472d2179be1 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -111,6 +111,7 @@ void evlist__add(struct evlist *evlist, struct evsel =
*entry);
>  void evlist__remove(struct evlist *evlist, struct evsel *evsel);
>
>  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs);
> +int arch_evlist__add_required_events(struct list_head *list);
>
>  int evlist__add_dummy(struct evlist *evlist);
>  struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_w=
ide);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index a59ae5ca0f89..01dab5dd3540 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2132,6 +2132,11 @@ static int evlist__cmp(void *_fg_idx, const struct=
 list_head *l, const struct li
>         return arch_evlist__cmp(lhs, rhs);
>  }
>
> +int __weak arch_evlist__add_required_events(struct list_head *list __alw=
ays_unused)
> +{
> +       return 0;
> +}
> +
>  static int parse_events__sort_events_and_fix_groups(struct list_head *li=
st)
>  {
>         int idx =3D 0, force_grouped_idx =3D -1;
> @@ -2143,6 +2148,11 @@ static int parse_events__sort_events_and_fix_group=
s(struct list_head *list)
>         struct evsel *force_grouped_leader =3D NULL;
>         bool last_event_was_forced_leader =3D false;
>
> +       /* On x86 topdown metrics events require a slots event. */
> +       ret =3D arch_evlist__add_required_events(list);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * Compute index to insert ungrouped events at. Place them where =
the
>          * first ungrouped event appears.
> --
> 2.50.0.727.gbf7dc18ff4-goog
>
