Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7262BE0FF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150316; cv=none; b=YTj80vj+spHiKl4ghk2kKvFNYJmE1yLLEgBY/a/HA+9dDRibOSmQcv7EKKuvU/FtuCaW3B06egGvFKisHlctIeOArWiWHqAAvNY8T0PS4qU7EJcBIae3cmuBEcE4izCERdxEmB5/mOaAZLU7fciDSs19gBO0bX7+4t0fRGXxNwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150316; c=relaxed/simple;
	bh=A84edA3FyIA9My98KTSXsVAr+QJrkedCeCLN2zRVHT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/oHFQhzuOKY+7p3a3uh/TaWesQNoBKVM0lM3m4+Fbk1olkEEQUaAZ/S5kzn9Kq41ZqVB8hyDR5VGqJ/AXNTlyvvlrll+H2PTlgVjpvkFn/+NWYjQL/KE3qhl0QwlOBVAVq8Novwhii64GX1+4R7vZllvIPO4cMmr1Aqa3JT0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p2XreUs6; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p2XreUs6"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22e42641d7cso259825ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747150314; x=1747755114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqgtOOyPbYQOhFP3l1zLwJHIC7Jc2EGVSkhfRlJjbIo=;
        b=p2XreUs6lQu3Iary68ITzV2YywXh7kxj6CAOffjW4Nxuu2mOuoeMtZvEZs8BU7NfGY
         7CjaqbBJUZegMtnUxjD5ZBKpEVqVpcmSVjG+qPUqSvd29NIGeTSZsv0JnjEjvM4P6Z7m
         g3vc7VZhchTrqIfQNqt1r1WfqQc/9xss4kBjE23aiym1J8inKlP+mK3qt1UZey/D1VJO
         YkTaqxyqhVQhPaIJ/aJX6ZY5bIyxXsy64Wp601B1EKcS09LMYJ5yrYCSk21NmPb0uYgl
         xTWNMBhJd0yXZ/imU/+GO+4EhW84WH1aOmPmhOV2TiNYlcoFc7NdmtrF3zgizk2E2uYq
         T2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747150314; x=1747755114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqgtOOyPbYQOhFP3l1zLwJHIC7Jc2EGVSkhfRlJjbIo=;
        b=blH89hGn6/aONummW0J/CVg7hmjpg8Uqtkj+M5WJHxZbRgTE/zIAE2BHJ5vp6u7RXw
         Tmd5LMk2UrWgteRMPz3q0J5pO00ehh20rdyGzvaGvyedjSehy/hmyM/ve32sy1sdm1vU
         4SbyI5HGQxhZfSWXEJbKuCImXEDBrL9zhsu481tWqowbHdbqSWtgybDdrFpgkLcTGlis
         QGn7jdcEV/oOd+6B1hSDq+k+W4XCsUZAf/grcbmJam10Ln8sP6lJ0WiHCXTBZhdhh49T
         wNe0ObMucogshbLSZF8o2R0t6ZO0m72mNS4qArbQ+XJAHY+xnxOfCl60K43xruFJuhr0
         sglw==
X-Forwarded-Encrypted: i=1; AJvYcCX5qNgl0JycIscZ973igAPHmkrd4Uy3QdI+GxF+tcDud6dM/7IdsZvXQxXOHRY05aIV+qeh3ZIcDdQpZy7U2K85@vger.kernel.org
X-Gm-Message-State: AOJu0YxWInkWGEdCHyzd4NXazsqTL2NUGmTGv+xc2xWedQONftxCyZ1I
	fgj5SQxBYp0aVd9ogsASXjzfI+L4kY7FO+i0Fvsgvi8zNy6XIiWqFQTSo4ihGl+FBpcGLqJzlQy
	WFacfXrDF54LxBB5C8YnPt6EqkYsxpIgamzGBYo6r
X-Gm-Gg: ASbGncv6Sb91NEjSX4jubW2u06XBTj8VaA74I7VAM2TkGd5Ue2m36bMe/193a1jLfPz
	+cptJGHRKXWfIJsBfEZUNY30gm1wfXWG9pT9ZN5aoMxN6Oq89/jzopxorEcWJs6VnKEFEORYgEJ
	oqFMvplR0az5TFq3YI3deNbf/H5BcdVinIwvgAblfOTjAxcMNy2OaTQoMLfcIcw3dvCuvYRn1a
X-Google-Smtp-Source: AGHT+IExDs8lDezS8XW9XwqZi6K4KXpG0ECOcxV6Ft8RnCFPFmEGMAK/D1EfQA4+KMlgYVBg8Yr/Imiv4HdAwTZXUJc=
X-Received: by 2002:a17:902:f545:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-231803d2ea3mr2541575ad.13.1747150312473; Tue, 13 May 2025
 08:31:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210912.274362-1-thomas.falcon@intel.com>
In-Reply-To: <20250512210912.274362-1-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 08:31:39 -0700
X-Gm-Features: AX0GCFuePG4jOdrgXjdwQj1VehmHo1AFi7bAp_rb7O60VXZlpWPKzo2vHn7rlA8
Message-ID: <CAP-5=fWqMzqtvxaqz21z53U0jDOyTuH-X2op4kgs6KLa7Pr7Jw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Usability enhancement for Auto Counter Reload
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 2:09=E2=80=AFPM Thomas Falcon <thomas.falcon@intel.=
com> wrote:
>
> The Auto Counter Reload (ACR)[1] feature is used to track the
> relative rates of two or more perf events, only sampling
> when a given threshold is exceeded. This helps reduce overhead
> and unnecessary samples. However, enabling this feature
> currently requires setting two parameters:
>
>  -- Event sampling period ("period")
>  -- acr_mask, which determines which events get reloaded
>     when the sample period is reached.
>
> For example, in the following command:
>
> perf record -e "{cpu_atom/branch-misses,period=3D200000,\
> acr_mask=3D0x2/ppu,cpu_atom/branch-instructions,period=3D1000000,\
> acr_mask=3D0x3/u}" -- ./mispredict
>
> The goal is to limit event sampling to cases when the
> branch miss rate exceeds 20%. If the branch instructions
> sample period is exceeded first, both events are reloaded.
> If branch misses exceed their threshold first, only the
> second counter is reloaded, and a sample is taken.
>
> To simplify this, provide a new =E2=80=9Cratio-to-prev=E2=80=9D event ter=
m
> that works alongside the period event option or -c option.
> This would allow users to specify the desired relative rate
> between events as a ratio, making configuration more intuitive.
>
> With this enhancement, the equivalent command would be:
>
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,period=3D1000000,ratio_to_prev=3D5/u}" \
> -- ./mispredict
>
> or
>
> perf record -e "{cpu_atom/branch-misses/ppu,\
> cpu_atom/branch-instructions,ratio-to-prev=3D5/u}" -c 1000000 \
> -- ./mispredict

Thanks Thomas. I'm wondering if ratio-to-prev should be a generic term
such that periods can be set as a ratio of each on non-Intel?

> [1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@linux=
.intel.com/
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
>
> ---
>  tools/perf/Documentation/intel-acr.txt |  45 +++++++++++
>  tools/perf/Documentation/perf-list.txt |   2 +
>  tools/perf/arch/x86/util/evsel.c       | 100 ++++++++++++++++++++++++-
>  tools/perf/util/evsel.c                |   2 +
>  tools/perf/util/evsel_config.h         |   1 +
>  tools/perf/util/parse-events.c         |  10 +++
>  tools/perf/util/parse-events.h         |   3 +-
>  tools/perf/util/parse-events.l         |   1 +
>  tools/perf/util/pmu.c                  |   3 +-
>  9 files changed, 164 insertions(+), 3 deletions(-)
>  create mode 100644 tools/perf/Documentation/intel-acr.txt
>
> diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Document=
ation/intel-acr.txt
> new file mode 100644
> index 000000000000..db835c769e1c
> --- /dev/null
> +++ b/tools/perf/Documentation/intel-acr.txt
> @@ -0,0 +1,45 @@
> +Intel Auto Counter Reload Support
> +---------------------------------
> +Support for Intel Auto Counter Reload in perf tools
> +
> +Auto counter reload provides a means for software to specify to hardware
> +that certain counters, if supported, should be automatically reloaded
> +upon overflow of chosen counters. By taking a sample only if the rate of
> +one event exceeds some threshold relative to the rate of another event,
> +this feature enables software to sample based on the relative rate of
> +two or more events. To enable this, the user must provide a sample perio=
d
> +term and a bitmask ("acr_mask") for each relevant event specifying the
> +counters in an event group to reload if the event's specified sample
> +period is exceeded.
> +
> +For example, if the user desires to measure a scenario when IPC > 2,
> +the event group might look like the one below:
> +
> +       perf record -e {cpu_atom/instructions,period=3D200000,acr_mask=3D=
0x2/, \
> +       cpu_atom/cycles,period=3D100000,acr_mask=3D0x3/} -- true
> +
> +In this case, if the "instructions" counter exceeds the sample period of
> +200000, the second counter, "cycles", will be reset and a sample will be
> +taken. If "cycles" is exceeded first, both counters in the group will be
> +reset. In this way, samples will only be taken for cases where IPC > 2.

Could this definition include the meaning of acr_mask? I can see that
the 2 periods create an IPC of 2, but I can't see why the acr_mask
needs to be 2 and 3.

> +
> +ratio-to-prev Event Term
> +------------------------
> +To simplify this, an event term "ratio-to-prev" is provided which is use=
d
> +alongside the sample period term n or the -c/--count option. This would
> +allow users to specify the desired relative rate between events as a
> +ratio.

Should there be an opposite ratio-to-next?

> +
> +The command above would then become
> +
> +       perf record -e {cpu_atom/instructions/, \
> +       cpu_atom/cycles,period=3D100000,ratio-to-prev=3D0.5/} -- true
> +
> +ratio-to-prev is the ratio of the event using the term relative
> +to the previous event in the group, which will always be 1,
> +for a 1:0.5 or 2:1 ratio.
> +
> +To sample for IPC < 2 for example, the events need to be reordered:
> +
> +       perf record -e {cpu_atom/cycles/, \
> +       cpu_atom/instructions,period=3D200000,ratio-to-prev=3D2.0/} -- tr=
ue

We allow "software" events in groups with hardware events. The current
list of software events is in perf_pmu__is_software and contains a few
surprises like "msr":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n2134
presumably ratio-to-prev should apply to the previous event in the
list that is on the same PMU?

> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Document=
ation/perf-list.txt
> index 8914f12d2b85..ba809fa1e8c6 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -376,6 +376,8 @@ Support raw format:
>  . '--raw-dump [hw|sw|cache|tracepoint|pmu|event_glob]', shows the raw-du=
mp of
>    a certain kind of events.
>
> +include::intel-acr.txt[]
> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-top[1],
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/=
evsel.c
> index 3dd29ba2c23b..b93dbbed2c8e 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include "util/evlist.h"
>  #include "util/evsel.h"
> +#include "util/evsel_config.h"
>  #include "util/env.h"
>  #include "util/pmu.h"
>  #include "util/pmus.h"
> @@ -89,6 +91,97 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf,=
 size_t size)
>                          event_name);
>  }
>
> +static void evsel__apply_ratio_to_prev(struct evsel *evsel,
> +                               struct perf_event_attr *attr,
> +                               const char *buf)
> +{
> +       struct perf_event_attr *prev_attr =3D NULL;
> +       struct evsel *evsel_prev =3D NULL;
> +       struct evsel *leader =3D evsel__leader(evsel);
> +       struct evsel *pos;
> +       const char *name =3D "acr_mask";
> +       int evsel_idx =3D 0;
> +       __u64 ev_mask, pr_ev_mask;
> +       double rtp;
> +
> +       rtp =3D strtod(buf, NULL);
> +       if (rtp <=3D 0) {
> +               pr_err("Invalid ratio-to-prev value %lf\n", rtp);

It would be nice to fail this early during parsing so that we can
identify the part of the parse string that is invalid. I'm guessing it
is this way because the parse_events__term_val_type are either an
integer or a string.

> +               return;
> +       }
> +       if (evsel =3D=3D evsel__leader(evsel)) {
> +               pr_err("Invalid use of ratio-to-prev term without precedi=
ng element in group\n");

I'm wondering how we can prevent this happening due to event
reordering in parse_events__sort_events_and_fix_groups:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2095

> +               return;
> +       }
> +       if (!evsel->pmu->is_core) {
> +               pr_err("Event using ratio-to-prev term must have a core P=
MU\n");

Would a stronger test here be the same PMU?

> +               return;
> +       }
> +       if (!perf_pmu__has_format(evsel->pmu, name)) {
> +               pr_err("'%s' does not have acr_mask format support\n", ev=
sel->pmu->name);
> +               return;
> +       }
> +       if (perf_pmu__format_type(evsel->pmu, name) !=3D
> +                       PERF_PMU_FORMAT_VALUE_CONFIG2) {
> +               pr_err("'%s' does not have acr_mask format support\n", ev=
sel->pmu->name);

I wonder if the acr_mask support could be in an
arch_evsel__apply_ratio_to_prev and the non-acr_mask stuff be generic?
If nothing else this would aid testing.

> +               return;
> +       }
> +       if (attr->freq) {
> +               pr_err("Event period term or count (-c) must be set when =
using ratio-to-prev term.\n");
> +               return;
> +       }
> +
> +       evsel_prev =3D evsel__prev(evsel);
> +       if (!evsel_prev) {
> +               pr_err("Previous event does not exist.\n");
> +               return;
> +       }
> +
> +       prev_attr =3D &evsel_prev->core.attr;
> +
> +       prev_attr->sample_period =3D (__u64)(attr->sample_period / rtp);
> +       prev_attr->freq =3D 0;
> +       evsel__reset_sample_bit(evsel_prev, PERIOD);
> +
> +       for_each_group_evsel(pos, leader) {
> +               if (pos =3D=3D evsel)
> +                       break;
> +               evsel_idx++;
> +       }
> +
> +       /*
> +        * acr_mask (config2) is calculated using the event's index in
> +        * the event group. The first event will use the index of the
> +        * second event as its mask (e.g., 0x2), indicating that the
> +        * second event counter will be reset and a sample taken for
> +        * the first event if its counter overflows. The second event
> +        * will use the mask consisting of the first and second bits
> +        * (e.g., 0x3), meaning both counters will be reset if the
> +        * second event counter overflows.
> +        */
> +
> +       ev_mask =3D 1ull << evsel_idx;
> +       pr_ev_mask =3D 1ull << (evsel_idx - 1);
> +
> +       prev_attr->config2 =3D ev_mask;
> +       attr->config2 =3D ev_mask | pr_ev_mask;
> +}
> +
> +static void intel__post_evsel_config(struct evsel *evsel,
> +                             struct perf_event_attr *attr)
> +{
> +       struct evsel_config_term *term;
> +       struct list_head *config_terms =3D &evsel->config_terms;
> +       const char *rtp_buf =3D NULL;
> +
> +       list_for_each_entry(term, config_terms, list) {
> +               if (term->type =3D=3D EVSEL__CONFIG_TERM_RATIO_TO_PREV) {
> +                       rtp_buf =3D term->val.str;
> +                       evsel__apply_ratio_to_prev(evsel, attr, rtp_buf);
> +               }
> +       }
> +}
> +
>  static void ibs_l3miss_warn(void)
>  {
>         pr_warning(
> @@ -101,7 +194,12 @@ void arch__post_evsel_config(struct evsel *evsel, st=
ruct perf_event_attr *attr)
>         struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
>         static int warned_once;
>
> -       if (warned_once || !x86__is_amd_cpu())
> +       if (!x86__is_amd_cpu()) {
> +               intel__post_evsel_config(evsel, attr);
> +               return;
> +       }
> +
> +       if (warned_once)
>                 return;
>
>         evsel_pmu =3D evsel__find_pmu(evsel);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b60461e16804..5028232afeb7 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1189,6 +1189,8 @@ static void evsel__apply_config_terms(struct evsel =
*evsel,
>                         break;
>                 case EVSEL__CONFIG_TERM_CFG_CHG:
>                         break;
> +               case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +                       break;
>                 default:
>                         break;
>                 }
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_confi=
g.h
> index af52a1516d0b..26c69d9ce788 100644
> --- a/tools/perf/util/evsel_config.h
> +++ b/tools/perf/util/evsel_config.h
> @@ -28,6 +28,7 @@ enum evsel_term_type {
>         EVSEL__CONFIG_TERM_AUX_ACTION,
>         EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
>         EVSEL__CONFIG_TERM_CFG_CHG,
> +       EVSEL__CONFIG_TERM_RATIO_TO_PREV,
>  };
>
>  struct evsel_config_term {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index 7297ca3a4eec..4ea8d4ffabdb 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -806,6 +806,7 @@ const char *parse_events__term_type_str(enum parse_ev=
ents__term_type term_type)
>                 [PARSE_EVENTS__TERM_TYPE_RAW]                   =3D "raw"=
,
>                 [PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          =3D "lega=
cy-cache",
>                 [PARSE_EVENTS__TERM_TYPE_HARDWARE]              =3D "hard=
ware",
> +               [PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         =3D "rati=
o-to-prev",
>         };
>         if ((unsigned int)term_type >=3D __PARSE_EVENTS__TERM_TYPE_NR)
>                 return "unknown term";
> @@ -855,6 +856,7 @@ config_term_avail(enum parse_events__term_type term_t=
ype, struct parse_events_er
>         case PARSE_EVENTS__TERM_TYPE_RAW:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>         default:
>                 if (!err)
>                         return false;
> @@ -982,6 +984,9 @@ do {                                                 =
                          \
>                         return -EINVAL;
>                 }
>                 break;
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> +               CHECK_TYPE_VAL(STR);
> +               break;
>         case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>         case PARSE_EVENTS__TERM_TYPE_USER:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1109,6 +1114,7 @@ static int config_term_tracepoint(struct perf_event=
_attr *attr,
>         case PARSE_EVENTS__TERM_TYPE_RAW:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>         default:
>                 if (err) {
>                         parse_events_error__handle(err, term->err_term,
> @@ -1233,6 +1239,9 @@ do {                                               =
               \
>                         ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_sample_s=
ize,
>                                             term->val.num, term->weak);
>                         break;
> +               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> +                       ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.str,=
 term->weak);
> +                       break;
>                 case PARSE_EVENTS__TERM_TYPE_USER:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG:
>                 case PARSE_EVENTS__TERM_TYPE_CONFIG1:
> @@ -1297,6 +1306,7 @@ static int get_config_chgs(struct perf_pmu *pmu, st=
ruct parse_events_terms *head
>                 case PARSE_EVENTS__TERM_TYPE_RAW:
>                 case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>                 case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>                 default:
>                         break;
>                 }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index e176a34ab088..a9de95dd337a 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -80,7 +80,8 @@ enum parse_events__term_type {
>         PARSE_EVENTS__TERM_TYPE_RAW,
>         PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>         PARSE_EVENTS__TERM_TYPE_HARDWARE,
> -#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_HAR=
DWARE + 1)
> +       PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
> +#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RAT=
IO_TO_PREV + 1)
>  };
>
>  struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 7ed86e3e34e3..49fe1811fe68 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -335,6 +335,7 @@ aux-output          { return term(yyscanner, PARSE_EV=
ENTS__TERM_TYPE_AUX_OUTPUT); }
>  aux-action             { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
AUX_ACTION); }
>  aux-sample-size                { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id              { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
> +ratio-to-prev          { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
RATIO_TO_PREV); }
>  cpu-cycles|cycles                              { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend     { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index d08972aa461c..8b5b5a6adb29 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1470,7 +1470,7 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
>                         return -EINVAL;
> -               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_HARDWARE:
> +               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_RATIO_TO_PREV:
>                         /* Skip non-config terms. */
>                         break;
>                 default:
> @@ -1852,6 +1852,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu,=
 void *state, pmu_format_call
>                 "aux-output",
>                 "aux-action=3D(pause|resume|start-paused)",
>                 "aux-sample-size=3Dnumber",
> +               "ratio-to-prev=3Dstring",
>         };
>         struct perf_pmu_format *format;
>         int ret;

Some places I think testing can be added are:
* The event parsing test:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2143
* The perf record test:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next

I wonder for if acr_mask is present (or ratio-to-prev) then
arch_evsel__must_be_in_group should return true:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/evsel.c?h=3Dperf-tools-next#n63
this is used to force topdown events into groups, so perhaps we can do
similar forcing and make the use of the {} for the group optional (or
fixed by the tool).

Thanks,
Ian

> --
> 2.48.1
>
