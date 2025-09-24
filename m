Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7076F26B971
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749680; cv=none; b=cwqPlk4LSvTWBppGyAM8RHUXBUZyTIz3Ku2A//TdRVevvkVccGoQ1YXTYHvmFDRj/Us8PEH1NTW9d6dO1R7/b1cV9OCLjbTByitloy1neIihTs7hyl3qeJ6bL+2qMZK1K2FA4Xg6dGl6B/IENwQmyf4fUxXkZkEZIJ1RQsSTE98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749680; c=relaxed/simple;
	bh=qL/qqboFruerUqMQH8wZQwrqfOQPFdYzkJDkOd52qMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVSe9INdL+gv3Z2L/iyXH+vvY0/M1KOFNBxnYzEdValh7Cpl1PXjq8UMscIuO7WQI89pd8vS0Yfj5RqlGkFdXrkx39afKacDe9+4Chz+7E4SVmQYvZaxngkxlDqRR/XnVWmAXxbIb6DJk8k4n8uf4M9KebRqxrl+2O/7sB8w3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AAfp3Zp; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AAfp3Zp"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2731ff54949so250155ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758749678; x=1759354478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPKSgJ+JnuWhZmWvU4SdwVrx8NK/S6tQIDBDLdOb+DU=;
        b=3AAfp3ZpdeKrjXXw4cfLDbJXTSuN7rr0OOhvfL/eRsO6S5gN/oqZ8dZHKXL2z2lbLS
         a6AROIuO9l8KQXGj4sXfMk08ogt1aR/bf+mTdn5meTi6U07I/JAWxtIvP2l2RtGNaeak
         sjBuuCcLdfUqf5LMp+BoEMBA3sIQcOPpmKlGcafphReAJlF2kMLp8slOU8S0kUFfI7pu
         bdug3fJL10Befw0pqYvFELKNbC+fMbTZoK5MJUOBZbQPFAeUi/+rfo63MFxjKC8K7ujv
         0cfd804XrfD81FBPLHfBdIk9J0k6XhEsz03S4uXqRowMulOipdyufxPN4gfpcr0qzFXJ
         v7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749678; x=1759354478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPKSgJ+JnuWhZmWvU4SdwVrx8NK/S6tQIDBDLdOb+DU=;
        b=DOUMmkDXPlHG4p26C4WjjeOEBJyXjOSSIPb6VdFXveuuSN8xN7TXiDHHb3zblWjqyz
         1PiSCzRJT0rVCQOLi6QGFZAOgH3k6UyckcvkKzh+VjNMX+uViSgiTG6o7iH+8yuLYwhM
         XeLOf9AdKZE/79Pat8hPkYCbx+2JkmZCDAg7lspQyH4BR71pb2tQqWEGig7lbWQiH2Fu
         cU+ArIE1DlmAaxM6JZ+ZBcc9d29laR/UQ9XTa/PTh2d7BRo9ngiyDldfrZBKGz1Oi03J
         Wri3a2BWg419RqflaIunsQfxJdW9Xrb766TlXbcaQYzzr0TCVc6rjo4BR82ilaWKKXbX
         fUIg==
X-Forwarded-Encrypted: i=1; AJvYcCVPepHnrMMZgMMBdeW+sbv24SmO/HYSbBrUo270CUcdkssnS5SwmLzjnh95X9TYVTCtRbKpVjuHKiY57ssNmMVU@vger.kernel.org
X-Gm-Message-State: AOJu0YzSE2NMHrL0niaiJ95oeboa3PrHebJmzLW7hhVLCD98GGeuZR1U
	o3EFxnawkRfhf5KOLWuSze/TNe+mFV7BuQ4vgOqku8bktvnl27/kdTZQzViV3TFZEBupKnA5GVs
	XI0+FzeVeJZJSztIyA6Lf5U74kZYkE3oDQAnHdRVN
X-Gm-Gg: ASbGnctYcpPHdmVSs/ZUNoTJbUjzmLRIuQDsRbzR61V9bLPmVyBRu8unIDq1sSvfbJ5
	HlLMx615rdiokBIH4Kc8cZgrQjEgSXRMxRIuGxrV3D2xk8fXfH3QpW3GdXDcHmEQaecU78evWny
	CBm/y+hoApVuphO2G9eciE/PX22kE3nlIbx/adBOG2WixS2Go2clCJL7dK1d+vihqmKCxNMSVsx
	evjcVauAZYlYOVXn/5YtO++m1CIZOFvpFwNf2WBiJYl
X-Google-Smtp-Source: AGHT+IEu70Mu1ZDyXwU1Dtw8/ffbqsWWrL/Hqq+SEMEDOyD5B5ZvFYX2fM3ni56scJNwlP7Gxl35AGidO4X8GRL8A5s=
X-Received: by 2002:a17:902:e745:b0:267:912b:2b4d with SMTP id
 d9443c01a7336-27ed3fdcf89mr2396165ad.7.1758749677120; Wed, 24 Sep 2025
 14:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902164047.64261-1-thomas.falcon@intel.com> <20250902164047.64261-2-thomas.falcon@intel.com>
In-Reply-To: <20250902164047.64261-2-thomas.falcon@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 24 Sep 2025 14:34:26 -0700
X-Gm-Features: AS18NWA3mro55yisLg4M9ifNw8wPOnS-NRj-YIx5vNmqipRTez2CzPwz95LoALI
Message-ID: <CAP-5=fXe43BE3hWoQ1gjxXuQ9OYBTNvMjexrxiyC+SHgP9rTYQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2 1/2] perf record: Add ratio-to-prev term
To: Thomas Falcon <thomas.falcon@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:41=E2=80=AFAM Thomas Falcon <thomas.falcon@intel.c=
om> wrote:
>
> Provide ratio-to-prev term which allows the user to
> set the event sample period of two events corresponding
> to a desired ratio. If using on an Intel x86 platform with
> Auto Counter Reload support, also set corresponding event's
> config2 attribute with a bitmask which counters to reset and
> which counters to sample if the desired ratio is met or exceeded.
> On other platforms, only the sample period is affected by the
> ratio-to-prev term.
>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> ---
>  tools/perf/Documentation/intel-acr.txt | 53 ++++++++++++++++++
>  tools/perf/Documentation/perf-list.txt |  2 +
>  tools/perf/arch/x86/util/evsel.c       | 53 ++++++++++++++++++
>  tools/perf/util/evsel.c                | 76 ++++++++++++++++++++++++++
>  tools/perf/util/evsel.h                |  1 +
>  tools/perf/util/evsel_config.h         |  1 +
>  tools/perf/util/parse-events.c         | 22 ++++++++
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/parse-events.l         |  1 +
>  tools/perf/util/pmu.c                  |  3 +-
>  10 files changed, 213 insertions(+), 2 deletions(-)
>  create mode 100644 tools/perf/Documentation/intel-acr.txt
>
> diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Document=
ation/intel-acr.txt
> new file mode 100644
> index 000000000000..72654fdd9a52
> --- /dev/null
> +++ b/tools/perf/Documentation/intel-acr.txt
> @@ -0,0 +1,53 @@
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
> +
> +The acr_mask term is a hexadecimal value representing a bitmask of the
> +events in the group to be reset when the period is exceeded. In the
> +example above, "instructions" is assigned an acr_mask of 0x2, meaning
> +only the second event in the group is reloaded and a sample is taken
> +for the first event. "cycles" is assigned an acr_mask of 0x3, meaning
> +that both event counters will be reset if the sample period is exceeded
> +first.

This is great! Thank you for adding it.

> +
> +ratio-to-prev Event Term
> +------------------------
> +To simplify this, an event term "ratio-to-prev" is provided which is use=
d
> +alongside the sample period term n or the -c/--count option. This would
> +allow users to specify the desired relative rate between events as a
> +ratio. Note: Both events compared must belong to the same PMU.
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
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Document=
ation/perf-list.txt
> index 28215306a78a..10bc66d39202 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -392,6 +392,8 @@ Support raw format:
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
> index 9bc80fff3aa0..84858e4c397d 100644
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
> @@ -67,6 +69,57 @@ int arch_evsel__hw_name(struct evsel *evsel, char *bf,=
 size_t size)
>                          event_name);
>  }
>
> +void arch_evsel__apply_ratio_to_prev(struct evsel *evsel,
> +                               struct perf_event_attr *attr)
> +{
> +       struct perf_event_attr *prev_attr =3D NULL;
> +       struct evsel *evsel_prev =3D NULL;
> +       const char *name =3D "acr_mask";
> +       int evsel_idx =3D 0;
> +       __u64 ev_mask, pr_ev_mask;
> +
> +       if (!perf_pmu__has_format(evsel->pmu, name)) {
> +               pr_err("'%s' does not have acr_mask format support\n", ev=
sel->pmu->name);
> +               return;
> +       }
> +       if (perf_pmu__format_type(evsel->pmu, name) !=3D
> +                       PERF_PMU_FORMAT_VALUE_CONFIG2) {
> +               pr_err("'%s' does not have config2 format support\n", evs=
el->pmu->name);
> +               return;
> +       }
> +
> +       evsel_prev =3D evsel__prev(evsel);
> +       if (!evsel_prev) {
> +               pr_err("Previous event does not exist.\n");
> +               return;
> +       }

Nit: you should probably check that the leader of both events is the
same, this means the events are in the same group.

> +
> +       prev_attr =3D &evsel_prev->core.attr;
> +
> +       if (prev_attr->config2) {
> +               pr_err("'%s' has set config2 (acr_mask?) already, configu=
ration not supported\n", evsel_prev->name);
> +               return;
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
> +       evsel_idx =3D evsel__group_idx(evsel);
> +       ev_mask =3D 1ull << evsel_idx;
> +       pr_ev_mask =3D 1ull << (evsel_idx - 1);
> +
> +       prev_attr->config2 =3D ev_mask;
> +       attr->config2 =3D ev_mask | pr_ev_mask;
> +}
> +
>  static void ibs_l3miss_warn(void)
>  {
>         pr_warning(
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d264c143b592..f6f93920c0aa 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1091,6 +1091,71 @@ static void evsel__reset_callgraph(struct evsel *e=
vsel, struct callchain_param *
>         }
>  }
>
> +static void evsel__apply_ratio_to_prev(struct evsel *evsel,
> +                                      struct perf_event_attr *attr,
> +                                      struct record_opts *opts,
> +                                      const char *buf)
> +{
> +       struct perf_event_attr *prev_attr =3D NULL;
> +       struct evsel *evsel_prev =3D NULL;
> +       u64 type =3D evsel->core.attr.sample_type;
> +       u64 prev_type =3D 0;
> +       double rtp;
> +
> +       rtp =3D strtod(buf, NULL);
> +       if (rtp <=3D 0) {
> +               pr_err("Invalid ratio-to-prev value %lf\n", rtp);
> +               return;
> +       }
> +       if (evsel =3D=3D evsel__leader(evsel)) {
> +               pr_err("Invalid use of ratio-to-prev term without precedi=
ng element in group\n");
> +               return;
> +       }

Ah, it is done here.

> +       if (!evsel->pmu->is_core) {
> +               pr_err("Event using ratio-to-prev term must have a core P=
MU\n");
> +               return;
> +       }
> +
> +       evsel_prev =3D evsel__prev(evsel);
> +       if (!evsel_prev) {
> +               pr_err("Previous event does not exist.\n");
> +               return;
> +       }
> +
> +       if (evsel_prev->pmu->type !=3D evsel->pmu->type) {
> +               pr_err("Compared events (\"%s\", \"%s\") must have same P=
MU\n",
> +                       evsel->name, evsel_prev->name);
> +               return;
> +       }
> +
> +       prev_attr =3D &evsel_prev->core.attr;
> +       prev_type =3D evsel_prev->core.attr.sample_type;
> +
> +       if (!(prev_type & PERF_SAMPLE_PERIOD)) {
> +               attr->sample_period =3D prev_attr->sample_period * rtp;
> +               attr->freq =3D 0;
> +               evsel__reset_sample_bit(evsel, PERIOD);
> +       } else if (!(type & PERF_SAMPLE_PERIOD)) {
> +               prev_attr->sample_period =3D attr->sample_period / rtp;
> +               prev_attr->freq =3D 0;
> +               evsel__reset_sample_bit(evsel_prev, PERIOD);
> +       } else {
> +               if (opts->user_interval !=3D ULLONG_MAX) {
> +                       prev_attr->sample_period =3D opts->user_interval;
> +                       attr->sample_period =3D prev_attr->sample_period =
* rtp;
> +                       prev_attr->freq =3D 0;
> +                       attr->freq =3D 0;
> +                       evsel__reset_sample_bit(evsel_prev, PERIOD);
> +                       evsel__reset_sample_bit(evsel, PERIOD);
> +               } else {
> +                       pr_err("Event period term or count (-c) must be s=
et when using ratio-to-prev term.\n");
> +                       return;
> +               }
> +       }
> +
> +       arch_evsel__apply_ratio_to_prev(evsel, attr);
> +}
> +
>  static void evsel__apply_config_terms(struct evsel *evsel,
>                                       struct record_opts *opts, bool trac=
k)
>  {
> @@ -1104,6 +1169,7 @@ static void evsel__apply_config_terms(struct evsel =
*evsel,
>         u32 dump_size =3D 0;
>         int max_stack =3D 0;
>         const char *callgraph_buf =3D NULL;
> +       const char *rtp_buf =3D NULL;
>
>         list_for_each_entry(term, config_terms, list) {
>                 switch (term->type) {
> @@ -1174,6 +1240,9 @@ static void evsel__apply_config_terms(struct evsel =
*evsel,
>                         break;
>                 case EVSEL__CONFIG_TERM_CFG_CHG:
>                         break;
> +               case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> +                       rtp_buf =3D term->val.str;
> +                       break;
>                 default:
>                         break;
>                 }
> @@ -1225,6 +1294,8 @@ static void evsel__apply_config_terms(struct evsel =
*evsel,
>                         evsel__config_callchain(evsel, opts, &param);
>                 }
>         }
> +       if (rtp_buf)
> +               evsel__apply_ratio_to_prev(evsel, attr, opts, rtp_buf);
>  }
>
>  struct evsel_config_term *__evsel__get_config_term(struct evsel *evsel, =
enum evsel_term_type type)
> @@ -1249,6 +1320,11 @@ void __weak arch__post_evsel_config(struct evsel *=
evsel __maybe_unused,
>  {
>  }
>
> +void __weak arch_evsel__apply_ratio_to_prev(struct evsel *evsel __maybe_=
unused,
> +                                           struct perf_event_attr *attr =
__maybe_unused)
> +{
> +}
> +

I'm not a fan of weak functions as they introduce subtle bugs, but I
can see why you have this organization.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


>  static void evsel__set_default_freq_period(struct record_opts *opts,
>                                            struct perf_event_attr *attr)
>  {
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 5797a02e5d6a..5002c795e818 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -342,6 +342,7 @@ void evsel__set_sample_id(struct evsel *evsel, bool u=
se_sample_identifier);
>  void arch_evsel__set_sample_weight(struct evsel *evsel);
>  void arch__post_evsel_config(struct evsel *evsel, struct perf_event_attr=
 *attr);
>  int arch_evsel__open_strerror(struct evsel *evsel, char *msg, size_t siz=
e);
> +void arch_evsel__apply_ratio_to_prev(struct evsel *evsel, struct perf_ev=
ent_attr *attr);
>
>  int evsel__set_filter(struct evsel *evsel, const char *filter);
>  int evsel__append_tp_filter(struct evsel *evsel, const char *filter);
> diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_confi=
g.h
> index 94a1e9cf73d6..bcd3a978f0c4 100644
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
> index 8282ddf68b98..850de3a51f47 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -834,6 +834,7 @@ const char *parse_events__term_type_str(enum parse_ev=
ents__term_type term_type)
>                 [PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          =3D "lega=
cy-cache",
>                 [PARSE_EVENTS__TERM_TYPE_HARDWARE]              =3D "hard=
ware",
>                 [PARSE_EVENTS__TERM_TYPE_CPU]                   =3D "cpu"=
,
> +               [PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         =3D "rati=
o-to-prev",
>         };
>         if ((unsigned int)term_type >=3D __PARSE_EVENTS__TERM_TYPE_NR)
>                 return "unknown term";
> @@ -884,6 +885,7 @@ config_term_avail(enum parse_events__term_type term_t=
ype, struct parse_events_er
>         case PARSE_EVENTS__TERM_TYPE_RAW:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>         default:
>                 if (!err)
>                         return false;
> @@ -1037,6 +1039,21 @@ do {                                              =
                          \
>                 perf_cpu_map__put(map);
>                 break;
>         }
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> +               CHECK_TYPE_VAL(STR);
> +               if (strtod(term->val.str, NULL) <=3D 0) {
> +                       parse_events_error__handle(err, term->err_val,
> +                                                  strdup("zero or negati=
ve"),
> +                                                  NULL);
> +                       return -EINVAL;
> +               }
> +               if (errno =3D=3D ERANGE) {
> +                       parse_events_error__handle(err, term->err_val,
> +                                                  strdup("too big"),
> +                                                  NULL);
> +                       return -EINVAL;
> +               }
> +               break;
>         case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
>         case PARSE_EVENTS__TERM_TYPE_USER:
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> @@ -1165,6 +1182,7 @@ static int config_term_tracepoint(struct perf_event=
_attr *attr,
>         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
>         case PARSE_EVENTS__TERM_TYPE_CPU:
> +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>         default:
>                 if (err) {
>                         parse_events_error__handle(err, term->err_term,
> @@ -1289,6 +1307,9 @@ do {                                               =
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
> @@ -1355,6 +1376,7 @@ static int get_config_chgs(struct perf_pmu *pmu, st=
ruct parse_events_terms *head
>                 case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
>                 case PARSE_EVENTS__TERM_TYPE_HARDWARE:
>                 case PARSE_EVENTS__TERM_TYPE_CPU:
> +               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
>                 default:
>                         break;
>                 }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-event=
s.h
> index 62dc7202e3ba..b2dcc52e3814 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -83,7 +83,8 @@ enum parse_events__term_type {
>         PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
>         PARSE_EVENTS__TERM_TYPE_HARDWARE,
>         PARSE_EVENTS__TERM_TYPE_CPU,
> -#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_CPU=
 + 1)
> +       PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
> +#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE_RAT=
IO_TO_PREV + 1)
>  };
>
>  struct parse_events_term {
> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-event=
s.l
> index 2034590eb789..25206de68007 100644
> --- a/tools/perf/util/parse-events.l
> +++ b/tools/perf/util/parse-events.l
> @@ -336,6 +336,7 @@ aux-action          { return term(yyscanner, PARSE_EV=
ENTS__TERM_TYPE_AUX_ACTION); }
>  aux-sample-size                { return term(yyscanner, PARSE_EVENTS__TE=
RM_TYPE_AUX_SAMPLE_SIZE); }
>  metric-id              { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
METRIC_ID); }
>  cpu                    { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
CPU); }
> +ratio-to-prev          { return term(yyscanner, PARSE_EVENTS__TERM_TYPE_=
RATIO_TO_PREV); }
>  cpu-cycles|cycles                              { return hw_term(yyscanne=
r, PERF_COUNT_HW_CPU_CYCLES); }
>  stalled-cycles-frontend|idle-cycles-frontend   { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
>  stalled-cycles-backend|idle-cycles-backend     { return hw_term(yyscanne=
r, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 5a291f1380ed..3d1f975e8db9 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1541,7 +1541,7 @@ static int pmu_config_term(const struct perf_pmu *p=
mu,
>                         break;
>                 case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. */
>                         return -EINVAL;
> -               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_CPU:
> +               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__TERM_=
TYPE_RATIO_TO_PREV:
>                         /* Skip non-config terms. */
>                         break;
>                 default:
> @@ -1930,6 +1930,7 @@ int perf_pmu__for_each_format(struct perf_pmu *pmu,=
 void *state, pmu_format_call
>                 "aux-action=3D(pause|resume|start-paused)",
>                 "aux-sample-size=3Dnumber",
>                 "cpu=3Dnumber",
> +               "ratio-to-prev=3Dstring",
>         };
>         struct perf_pmu_format *format;
>         int ret;
> --
> 2.50.1
>
