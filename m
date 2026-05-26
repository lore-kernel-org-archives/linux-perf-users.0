Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4822083
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 00:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779754188; cv=pass; b=kxHem9OjPfLlHfdkMr267XH2V0rfyhz4rhX2PV2hmH20VAjz9pUXLoKwb+XFUPR8J+5rTmP1FwgGP7CCMUFMXsoDN+bHcQ5UP0H6u2PPmCaYQfqjs80IEAB4tctM/BgNRwiK5Nx8UIjOwPw7lJ2YDZlXrkxegRQUa1s6inY5XgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779754188; c=relaxed/simple;
	bh=ncEBp9ccFa6s1OFsa8cxHsFAWkDRDdOpjUY8nxFatBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxDnxP4FzkVXrgg84mH9Z8NFGprHjkBPfpmoSbxzNhMPfivrKt/hOpp8KbzUJ7zI4FcwChE3wzpHLFk61vca5gTMe6e/NC6A2g1XV0InHIlgywg1QGCa3cjCMjtMXoaBvTwKZnyt3pVusA90R+qHjN2fI/ajYQoObFGCpT58+8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DHBLOzVS; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DHBLOzVS"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so545ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 17:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779754184; cv=none;
        d=google.com; s=arc-20240605;
        b=ISJ+JtbRLP7QF4hqxnGOQJepV1L5XJ235/xXNYytbaM/Xmgc6GFzwO+Za+dxNFqcia
         2gfuy54A9221AGAGROKa0e9hr4rxK7PNZG3Kn/y9VjayKE4V2BS/YIbvSghYi8EltXFX
         q0Gibv2UNVxfXyZQ1vuQk5R4e63Oj7mtKTmyWhQQjgq8LEYiRCzU9BuhrQwtSUMnb305
         azVl/BEKuGDYDzgQ4QgZuGILJLtzeP+iJT+sBWbGG+cZqxwS6SKYQJOL7oqmpCSOxouI
         1Wkru8B/slJhgHiHMjkRH6Bl+Kt8pcpMirIfBpEiHlCzNmfKoA4ftrEElD2tJ3L6KNGC
         +nKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d4Vp1bOpbLv8/PYdP/bZH+RpTLaU4iminAHU8+Bzbhg=;
        fh=Fp1p/KIUCCUkxshT6ucUAkq3Kbaio4WxZTHj6OdyR4k=;
        b=JzRvrHJ8jcpXEcK4KYp/CGujBIwtF2dtjM6+04hytd8E2LpnPAGLaqk7eALRkvhjK0
         D+hfDiWZUmDXjG9NZpHH4RlvqFwb9dn+HBRscFvFm5DbdpqVPxc+WvBiVos70yG30A3E
         3dy5leFVQUWpNldAhnm9LWf3poNdekp3uBx2HsCPyTEonkFJklTKyFp932XUnOZ1ZyMe
         Qj3roY9gC82vUEu4oReaeSCDhsw59ORGN9HdEPRk46KiL6ssVWca4yEDWvkpdGdHA2Tm
         9p0ZoivPqok6bkg9druqhR6VdPUMY0Y8oHH/C4PG3PuUaHwV7Hbx0TljWiPEstPpDJdh
         q5Xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779754184; x=1780358984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4Vp1bOpbLv8/PYdP/bZH+RpTLaU4iminAHU8+Bzbhg=;
        b=DHBLOzVSr7ZD/87UjtXB1sIlJEnUG4p3Ax03Rpt3VzQVhfA1SRyNS0OHYvTl1tNQ6F
         eR0S3JdJlPa7zVXuppGspFECVSDXc62CgknNwXIQGzaGadt+15ihSbuPwVKDIJ7FLLiw
         MqFgPL8xmv1Omnvxbtf7l229ABWgnDvz5Nc+6b5+m8W5VgzTTDMs3UN26nf1dHtD/xij
         Ul7CVWduga2TrR7A5/uUNhJsP1gVWuw6wQWvX0kZ1DGSkivYy0oYqW3iMm9w5HNNpnyf
         MjMpEe1m7r1I+/SQHaKbNHyHjP8ZbR4cck6J7FWKBAJxLtJnGtJ7Hln6NI9RoEOWyWQn
         tBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779754184; x=1780358984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4Vp1bOpbLv8/PYdP/bZH+RpTLaU4iminAHU8+Bzbhg=;
        b=R/cvwQ0tT5VkBGmC02r9viP1YRUYOJP20XriFdBOKTdZ1YG87AkqVQCBWOgcf52zy9
         6ujGACCB453wbHQ8wNAYUGCQxgxJn7KWRKhZszV7A7Sl/uPnderubfdOSmzKzjG8wuwe
         rF0krn5otSstRxofTKemqu1OXTeFmM83DCeKVLEw1Tx1vE7wMCHe09Ii5f3A6choL/wb
         xM9vjbrBpf/uuHdMRKNPRC1AeBVJFj367emSUzYm6vUORWeknazCv3T0nzSdrBq8jnEO
         gygwrzs3pd+rg2h6nmWVxrOC+9yJDXLb+qrN9y3QU/1MmYP925E3CI63EwjfyNh0daVy
         YaxQ==
X-Gm-Message-State: AOJu0YwgNRVyvrhskG3V7usUqLFihNLjsWnr6//LNMEDyRozpiepcViY
	+zGlvgQQZNALTS/WcAt4mfxs3lIcTIcTKC1rrfpGtuaeSvfFbK/khZEwrhL4Ur/LlvQcB55eV3o
	iNpyJH9x97Xzw6Q0zVc7itaCx43k84fdeLDY90GLo
X-Gm-Gg: Acq92OE6JhSGbNJk98dCqcS44RqbHQIY5DZ86OCuY7IbVuJF/qz+YtubUSBfi+AswCc
	F0LmVAFVQmkZoktH8CSq5rzVDUacxqmXAgHQQ/8K0CAatRrzbhX4+YBzhNz0YDqY+/wgU5V9KHw
	5hpmH+xk9tS0g5kmzVQNpmxLWHnPQUrPMbv+1zdXmpoDvyd5zy/ySL0bq+UMTDRLmaWpuU24vlw
	D2Z76S6gf5ojLTWDyjqSVfaFzNtW2eVPXdRdGHuDwFt/IqqrZAt3WI84Zc51Q0FevTrcbF2yl7X
	p14X0RgDg2PtTfSZsVI=
X-Received: by 2002:a17:903:228b:b0:2b0:be7d:a25e with SMTP id
 d9443c01a7336-2bebf446cfemr4379045ad.18.1779754183113; Mon, 25 May 2026
 17:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
 <20260525231900.3527228-3-irogers@google.com> <ahTf8j6iub-OmVSi@x1>
In-Reply-To: <ahTf8j6iub-OmVSi@x1>
From: Ian Rogers <irogers@google.com>
Date: Mon, 25 May 2026 17:09:31 -0700
X-Gm-Features: AVHnY4Ln-BSf75kPE3WK5X8-PXam4aufX6vEfZx0PmG-u0Pqmq7JeDONNdqcafw
Message-ID: <CAP-5=fUQ=zU7H+wJw+10S22S6FkpnY2hsO-iizT47O7n95YmRA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/14] perf stat: Implement standard console (STD)
 formatting callbacks
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 4:49=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, May 25, 2026 at 04:18:48PM -0700, Ian Rogers wrote:
> > This patch implements standard console formatting callbacks inside
> > util/stat-print-std.c, replacing the empty stubs introduced in Commit 1=
.
> >
> > Introduces the format-private `struct queued_event` and `struct queued_=
metric`
> > DOM nodes to buffer traversal streams, and fully encapsulates DOM state
> > initialization and queue cleanups inside std_print_start() and std_prin=
t_end().
> >
> > Utilizes the newly centralized unified aggregation helpers to resolve C=
PU and
> > thread prefixes cleanly, and incorporates full interval-mode timestamp
> > printing support across all rows.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > Assisted-by: Antigravity:gemini-3.5-flash
> > ---
> >  tools/perf/util/stat-print-std.c | 776 ++++++++++++++++++++++++++++++-
> >  1 file changed, 768 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-print-std.c b/tools/perf/util/stat-pr=
int-std.c
> > index 83987e97c889..aa4a083bb85a 100644
> > --- a/tools/perf/util/stat-print-std.c
> > +++ b/tools/perf/util/stat-print-std.c
> > @@ -1,13 +1,773 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -#include "stat-print.h"
> > +// SPDX-License-Identifier: GPL-2.0
>
> What is the value of switching from /* bla */ to // bla when both are
> acceptable? Ends up being just noise.
>
> Moving the first include after the SPDX because standardizing into some
> sort of ordering enforced by tooling and is considered considered better
> for some reason at least has some motivation, so, whatever, no problem.

Agreed. Will fix. I suspect the original SPDX was brought over from
something like stat.h and then checkpatch.pl warned about preferring
//. But given this is a new file there's no reason to modify it.

> > +#include <errno.h>
> > +#include <math.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +
> >  #include <linux/compiler.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +
> > +#include "color.h"
> > +#include "cpumap.h"
> > +#include "debug.h"
> > +#include "evlist.h"
> > +#include "evsel.h"
> > +#include "metricgroup.h"
> > +#include "stat-print.h"
> > +#include "stat.h"
> > +#include "target.h"
> > +#include "thread_map.h"
> > +#include "tool_pmu.h"
> > +
> > +#define COUNTS_LEN 18
> > +#define EVNAME_LEN 32
> > +#define COMM_LEN 16
> > +#define PID_LEN 7
> > +#define MGROUP_LEN 50
> > +#define METRIC_LEN 38
> > +
> > +
> > +
> > +/**
> > + * struct queued_metric - In-memory record of a buffered metric.
>
> Shouldn't we have an space after the struct header and its members?
>
> > + * @list: Linked list node for queueing.
>
> If this is a node, shouldn't we name it node instead of list, list makes
> it look like we have a list here, not that this entry is part of a list.
>
> > + * @name: The display name of the metric.
> > + * @unit: The metric's unit (e.g., "%", "GHz", or NULL).
>
> Can this be just:
>
> + * @unit: "%", "GHz", or NULL
>
> As its implied that being a metric it should be its unit?
>
> > + * @val: The calculated ratio/metric value.
> > + * @thresh: Threshold classification for color coding.
>
>
> @thresh: classification for color coding.
>
> > + * @aggr_idx: Aggregation index in evsel stats.
> > + */
> > +struct queued_metric {
> > +     struct list_head list;
> > +     char *name;
> > +     char *unit;
> > +     double val;
> > +     enum metric_threshold_classify thresh;
> > +     int aggr_idx;
> > +};
>
> Documenting has value, now its a matter of making sure it stays in sync
>
> Ditto for all the lines in the next structs

I'll clean up the structs.

> > +/**
> > + * struct queued_event - In-memory record of a buffered counter event.
> > + * @list: Linked list node for queueing.
> > + * @evsel: The associated performance event selector.
> > + * @name: The uniquely formatted/resolved event name.
> > + * @val: Raw aggregated counter value.
> > + * @ena: Enabled time for multiplexing percentage.
> > + * @run: Running time for multiplexing percentage.
> > + * @stdev_pct: Standard deviation percentage across repeated runs.
> > + * @aggr_idx: Aggregation index.
> > + * @is_metricgroup: Whether this represents a unified metricgroup head=
er.
> > + * @metrics_list: Linked list head containing nested queued_metric str=
uctures.
> > + */
> > +struct queued_event {
> > +     struct list_head list;
> > +     struct evsel *evsel;
> > +     char *name;
> > +     u64 val, ena, run;
> > +     double stdev_pct;
> > +     int aggr_idx;
> > +     bool is_metricgroup;
> > +     struct list_head metrics_list;
> > +};
> > +
> > +/**
> > + * struct std_print_state - Print state context for Standard console o=
utput.
> > + * @fp: File descriptor to output to.
> > + * @timestamp: Formatted interval timestamp (optional).
> > + * @events_list: Linked list head containing queued_event nodes.
> > + * @current_event: Pointer to the currently active event being printed=
.
> > + *                 Serves as a temporary bridge to associate streaming=
 metrics back to
> > + *                 their parent event node during list buffering. This=
 relies on a
> > + *                 strict temporal coupling in the traversal driver: t=
he driver always
> > + *                 invokes print_metric() callbacks for a counter sync=
hronously and
> > + *                 immediately after its print_event() callback, prior=
 to advancing
> > + *                 to the next event or aggregation node. This pointer=
 is completely
> > + *                 private to standard printing, keeping the traversal=
 driver decoupled
> > + *                 and preserving strict encapsulation.
> > + * @target: target query parameters for header printout.
> > + * @argc: Command argument count.
> > + * @argv: Command argument values.
> > + */
> > +struct std_print_state {
> > +     FILE *fp;
> > +     char timestamp[64];
> > +     struct list_head events_list;
> > +     struct queued_event *current_event;
> > +     const struct target *target;
> > +     int argc;
> > +     const char **argv;
> > +};
> > +
> > +/**
> > + * struct std_metric_only_print_state - Metric-only print state contex=
t for Standard console output.
> > + * @fp: File descriptor to output to.
> > + * @queued_metrics: Linked list head containing queued_metric nodes.
> > + * @timestamp: Formatted interval timestamp (optional).
> > + * @target: target query parameters.
> > + * @argc: Command argument count.
> > + * @argv: Command argument values.
> > + */
> > +struct std_metric_only_print_state {
> > +     FILE *fp;
> > +     struct list_head queued_metrics;
> > +     char timestamp[64];
> > +     const struct target *target;
> > +     int argc;
> > +     const char **argv;
> > +     struct evlist *evlist;
> > +};
> > +
> > +/**
> > + * print_aggr_id_std - Print the aggregation prefix for STD format.
> > + *
> > + * Uses the unified perf_stat__get_aggr_id_char helper to format the b=
ase
> > + * aggregation string, and pads it dynamically using aggr_header_lens.
> > + */
> > +static void print_aggr_id_std(const struct perf_stat_config *config, F=
ILE *output,
> > +                           struct evsel *evsel, struct aggr_cpu_id id,=
 int aggr_nr)
> > +{
> > +     char buf[128];
> > +
> > +     if (perf_stat__get_aggr_id_char(config, evsel, id, buf, sizeof(bu=
f)) < 0)
> > +             return;
>
>
> So the contract here is clear: if there is some problem with doing what
> is expected, it should print nothing? I would expect that if this is
> called, being a "print" fuction, something would be printed? Is the
> above failure (< 0) a problem the user should be warned about?

I'll follow up.

> > +
> > +     if (config->aggr_mode =3D=3D AGGR_NONE) {
> > +             if (evsel->percore && !config->percore_show_thread) {
> > +                     fprintf(output, "%-*s ", aggr_header_lens[AGGR_CO=
RE], buf);
> > +             } else if (id.cpu.cpu > -1) {
> > +                     /* For CPU none mode, prepend "CPU" during consol=
e print */
> > +                     char cpu_buf[160];
> > +                     snprintf(cpu_buf, sizeof(cpu_buf), "CPU%s", buf);
> > +                     fprintf(output, "%-*s ", aggr_header_lens[AGGR_NO=
NE], cpu_buf);
> > +             }
> > +             return;
> > +     }
> > +
> > +     if (config->aggr_mode =3D=3D AGGR_THREAD) {
> > +             fprintf(output, "%-*s ", aggr_header_lens[AGGR_THREAD], b=
uf);
> > +             return;
> > +     }
> > +
> > +     /* Socket/Die/Node/Cache/Cluster modes print base ID and aggr cou=
nt */
> > +     fprintf(output, "%-s %*d ", buf, 4, aggr_nr);
>
>
> So, only in the first case (< 0) this function doesn't print something.
>
> > +}
> > +
> > +/**
> > + * should_skip_zero_counter - Check if a zero-valued counter should be=
 skipped.
> > + *
> > + * Implemented locally for standard console formatting.
> > + */
> > +static bool should_skip_zero_counter(const struct perf_stat_config *co=
nfig, struct evsel *counter,
> > +                                  int aggr_idx)
> > +{
> > +     struct perf_cpu cpu;
> > +     unsigned int idx;
> > +     struct aggr_cpu_id id;
> > +
> > +     if (verbose =3D=3D 0 && counter->skippable && !counter->supported=
)
> > +             return true;
>
> IS this really && && or should it be  || ||?

This function is brought over from stat-display.c to try to make the
output as similar as possible. The && is deliberate, the code should
read: if we're not being verbose AND the counter can be skipped (i.e.,
it is a default created one) AND the counter isn't supported (open
failed) then skip outputting the counter if its value is zero.

This function has a long history of issues, so decoupling it here from
CSV and JSON output is an improvement. I think we can do better, but
my initial hope is that the new output code can be compatible with
existing tools that use perf output. Using the same code should be a
pretty strong guarantee of this.

I'm going to buffer up feedback before working on v3. Given Namhyung
and CT have both worked on this code, I think their feedback regarding
the clean up and direction would be very valuable.

Thanks,
Ian

> > +
> > +     if (config->metric_only)
> > +             return false;
> > +
> > +     if (config->aggr_mode =3D=3D AGGR_THREAD && config->system_wide)
> > +             return true;
> > +
> > +     if (aggr_idx < 0 || !config->aggr_map || !config->aggr_get_id)
> > +             return false;
> > +
> > +     id =3D config->aggr_map->map[aggr_idx];
> > +
> > +     if (evsel__is_tool(counter)) {
> > +             struct aggr_cpu_id own_id =3D config->aggr_get_id((struct=
 perf_stat_config *)config,
> > +                                                             (struct p=
erf_cpu){ .cpu =3D 0 });
> > +
> > +             return !aggr_cpu_id__equal(&id, &own_id);
> > +     }
> > +
> > +     perf_cpu_map__for_each_cpu(cpu, idx, counter->core.cpus) {
> > +             struct aggr_cpu_id own_id =3D
> > +                     config->aggr_get_id((struct perf_stat_config *)co=
nfig, cpu);
> > +
> > +             if (aggr_cpu_id__equal(&id, &own_id))
> > +                     return false;
> > +     }
> > +     return true;
> > +}
> > +
> > +/*
> > + * Standard (STD) Output Callbacks - Normal Mode
> > + */
> > +
> > +static int std_print_start(void *ctx, const struct perf_stat_config *c=
onfig __maybe_unused)
> > +{
> > +     struct std_print_state *ps =3D ctx;
> >
> > -int perf_stat__print_std(struct evlist *evlist __maybe_unused,
> > -                      const struct perf_stat_config *config __maybe_un=
used,
> > -                      const struct target *target __maybe_unused,
> > -                      const struct timespec *ts __maybe_unused,
> > -                      int argc __maybe_unused,
> > -                      const char **argv __maybe_unused)
> > +     INIT_LIST_HEAD(&ps->events_list);
> > +     ps->current_event =3D NULL;
> > +     return 0;
> > +}
> > +
> > +static int std_print_event(void *ctx, const struct perf_stat_config *c=
onfig, struct evsel *evsel,
> > +                        int aggr_idx, u64 val, u64 ena, u64 run, doubl=
e stdev_pct)
> >  {
> > +     struct std_print_state *ps =3D ctx;
> > +     struct queued_event *ev;
> > +
> > +     /* Skip zero counters locally in STD callbacks if they qualify */
> > +     if (val =3D=3D 0 && should_skip_zero_counter(config, evsel, aggr_=
idx)) {
> > +             ps->current_event =3D NULL;
> > +             return 0;
> > +     }
> > +
> > +     ev =3D malloc(sizeof(*ev));
> > +     if (!ev)
> > +             return -ENOMEM;
> > +
> > +     ev->name =3D strdup(evsel__name(evsel));
> > +     if (!ev->name) {
> > +             free(ev);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     ev->evsel =3D evsel;
> > +     ev->val =3D val;
> > +     ev->ena =3D ena;
> > +     ev->run =3D run;
> > +     ev->stdev_pct =3D stdev_pct;
> > +     ev->aggr_idx =3D aggr_idx;
> > +     INIT_LIST_HEAD(&ev->metrics_list);
> > +
> > +     list_add_tail(&ev->list, &ps->events_list);
> > +     ps->current_event =3D ev;
> > +
> >       return 0;
> >  }
> > +
> > +static int std_print_metric(void *ctx, const struct perf_stat_config *=
config __maybe_unused,
> > +                         struct evsel *evsel __maybe_unused, int aggr_=
idx __maybe_unused,
> > +                         const char *name, const char *unit, double va=
l,
> > +                         enum metric_threshold_classify thresh)
> > +{
> > +     struct std_print_state *ps =3D ctx;
> > +     struct queued_metric *b;
> > +
> > +     if (!ps->current_event)
> > +             return 0;
> > +
> > +     if (evsel !=3D ps->current_event->evsel) {
> > +             pr_err("decoupled print engine: temporal coupling violati=
on: evsel mismatch!\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     b =3D malloc(sizeof(*b));
> > +     if (!b)
> > +             return -ENOMEM;
> > +
> > +     b->name =3D strdup(name);
> > +     if (!b->name) {
> > +             free(b);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     if (unit && unit[0]) {
> > +             b->unit =3D strdup(unit);
> > +             if (!b->unit) {
> > +                     free(b->name);
> > +                     free(b);
> > +                     return -ENOMEM;
> > +             }
> > +     } else {
> > +             b->unit =3D NULL;
> > +     }
> > +
> > +     b->val =3D val;
> > +     b->thresh =3D thresh;
> > +     list_add_tail(&b->list, &ps->current_event->metrics_list);
> > +
> > +     return 0;
> > +}
> > +
> > +#define USEC_PER_SEC 1000000ULL
> > +#define NSEC_PER_SEC 1000000000ULL
> > +
> > +static double timeval2double(struct timeval *t)
> > +{
> > +     return t->tv_sec + (double)t->tv_usec / USEC_PER_SEC;
> > +}
> > +
> > +static void print_footer_std(const struct perf_stat_config *config)
> > +{
> > +     double avg =3D avg_stats(config->walltime_nsecs_stats) / NSEC_PER=
_SEC;
> > +     FILE *output =3D config->output;
> > +
> > +     if (config->interval)
> > +             return;
> > +
> > +     if (!config->null_run)
> > +             fprintf(output, "\n");
> > +
> > +     if (config->run_count =3D=3D 1) {
> > +             fprintf(output, " %17.9f seconds time elapsed", avg);
> > +
> > +             if (config->ru_display) {
> > +                     double ru_utime =3D
> > +                             timeval2double((struct timeval *)&config-=
>ru_data.ru_utime);
> > +                     double ru_stime =3D
> > +                             timeval2double((struct timeval *)&config-=
>ru_data.ru_stime);
> > +
> > +                     fprintf(output, "\n\n");
> > +                     fprintf(output, " %17.9f seconds user\n", ru_utim=
e);
> > +                     fprintf(output, " %17.9f seconds sys\n", ru_stime=
);
> > +             }
> > +     } else {
> > +             double sd =3D stddev_stats(config->walltime_nsecs_stats) =
/ NSEC_PER_SEC;
> > +             fprintf(output, " %17.9f +- %-17.9f seconds time elapsed"=
, avg, sd);
> > +     }
> > +     fprintf(output, "\n");
> > +}
> > +
> > +/**
> > + * print_header_std - Print the header prefix matching old API.
> > + *
> > + * Copied and adapted from stat-display.c.
> > + */
> > +static void print_header_std(const struct perf_stat_config *config, co=
nst struct target *target,
> > +                          int argc, const char **argv)
> > +{
> > +     FILE *output =3D config->output;
> > +     int i;
> > +
> > +     fprintf(output, "\n");
> > +     fprintf(output, " Performance counter stats for ");
> > +     if (target->bpf_str)
> > +             fprintf(output, "\'BPF program(s) %s", target->bpf_str);
> > +     else if (target->system_wide)
> > +             fprintf(output, "\'system wide");
> > +     else if (target->cpu_list)
> > +             fprintf(output, "\'CPU(s) %s", target->cpu_list);
> > +     else if (!target__has_task(target)) {
> > +             fprintf(output, "\'%s", argv ? argv[0] : "pipe");
> > +             for (i =3D 1; argv && (i < argc); i++)
> > +                     fprintf(output, " %s", argv[i]);
> > +     } else if (target->pid)
> > +             fprintf(output, "process id \'%s", target->pid);
> > +     else
> > +             fprintf(output, "thread id \'%s", target->tid);
> > +
> > +     fprintf(output, "\'");
> > +     if (config->run_count > 1)
> > +             fprintf(output, " (%d runs)", config->run_count);
> > +     fprintf(output, ":\n\n");
> > +}
> > +
> > +static int std_print_end(void *ctx, const struct perf_stat_config *con=
fig)
> > +{
> > +     struct std_print_state *ps =3D ctx;
> > +     struct queued_event *ev, *tmp_ev;
> > +     struct queued_metric *met, *tmp_met;
> > +     FILE *out =3D ps->fp;
> > +     bool first;
> > +     const char *last_mg_name =3D NULL;
> > +     const struct perf_pmu *last_pmu =3D NULL;
> > +     int last_aggr_idx =3D -1;
> > +
> > +     /* Print the formatted header prefix (only in non-interval mode) =
*/
> > +     if (!config->interval)
> > +             print_header_std(config, ps->target, ps->argc, ps->argv);
> > +
> > +     list_for_each_entry_safe(ev, tmp_ev, &ps->events_list, list) {
> > +             struct evsel *evsel =3D ev->evsel;
> > +             double sc =3D evsel->scale;
> > +             const char *fmt;
> > +             const char *bad_count =3D evsel->supported ? CNTR_NOT_COU=
NTED : CNTR_NOT_SUPPORTED;
> > +             struct metric_event *me =3D
> > +                     metricgroup__lookup(&evsel->evlist->metric_events=
, evsel, false);
> > +             bool is_metricgroup =3D false;
> > +             bool skip_header =3D false;
> > +             char full_name[128] =3D "";
> > +
> > +             if (me && me->is_default && !evsel->default_show_events) =
{
> > +                     struct metric_expr *mexp =3D
> > +                             list_first_entry(&me->head, struct metric=
_expr, nd);
> > +                     const char *mg_name =3D mexp->default_metricgroup=
_name;
> > +                     bool need_full_name =3D perf_pmus__num_core_pmus(=
) > 1;
> > +
> > +                     if (need_full_name && evsel->pmu)
> > +                             scnprintf(full_name, sizeof(full_name), "=
%s (%s)", mg_name,
> > +                                       evsel->pmu->name);
> > +                     else
> > +                             scnprintf(full_name, sizeof(full_name), "=
%s", mg_name);
> > +                     is_metricgroup =3D true;
> > +
> > +                     if (last_mg_name && !strcmp(last_mg_name, mg_name=
) &&
> > +                         last_pmu =3D=3D evsel->pmu && last_aggr_idx =
=3D=3D ev->aggr_idx) {
> > +                             skip_header =3D true;
> > +                     }
> > +                     last_mg_name =3D mg_name;
> > +                     last_pmu =3D evsel->pmu;
> > +                     last_aggr_idx =3D ev->aggr_idx;
> > +             }
> > +
> > +             /* Print interval timestamp if configured */
> > +             if (config->interval && ps->timestamp[0] && !skip_header)
> > +                     fprintf(out, "%s", ps->timestamp);
> > +
> > +             /* 1. Print aggregation prefix first (if we don't skip he=
ader) */
> > +             if (!skip_header && config->aggr_map && ev->aggr_idx >=3D=
 0) {
> > +                     struct aggr_cpu_id id =3D config->aggr_map->map[e=
v->aggr_idx];
> > +                     int aggr_nr =3D 0;
> > +                     if (evsel->stats && evsel->stats->aggr) {
> > +                             aggr_nr =3D evsel->stats->aggr[ev->aggr_i=
dx].nr;
> > +                     }
> > +                     print_aggr_id_std(config, out, evsel, id, aggr_nr=
);
> > +             }
> > +
> > +             /* 2. Print event value (scaled) or spaces if metricgroup=
 */
> > +             if (is_metricgroup) {
> > +                     if (!skip_header) {
> > +                             int n =3D fprintf(out, " %*s", EVNAME_LEN=
, full_name);
> > +                             fprintf(out, "%*s", MGROUP_LEN + config->=
unit_width + 2 - n, "");
> > +                     }
> > +             } else {
> > +                     if (config->big_num)
> > +                             fmt =3D floor(sc) !=3D sc ? "%'*.2f " : "=
%'*.0f ";
> > +                     else
> > +                             fmt =3D floor(sc) !=3D sc ? "%*.2f " : "%=
*.0f ";
> > +
> > +                     if (ev->run =3D=3D 0 || ev->ena =3D=3D 0) {
> > +                             fprintf(out, "%*s ", COUNTS_LEN, bad_coun=
t);
> > +                     } else {
> > +                             double scaled =3D (double)ev->val;
> > +                             double avg;
> > +                             if (ev->ena < ev->run) {
> > +                                     scaled =3D (double)ev->val * ev->=
run / ev->ena;
> > +                             }
> > +                             avg =3D scaled * sc;
> > +                             fprintf(out, fmt, COUNTS_LEN, avg);
> > +                     }
> > +
> > +                     /* 3. Print unit */
> > +                     if (evsel->unit) {
> > +                             fprintf(out, "%-*s ", config->unit_width,=
 evsel->unit);
> > +                     } else {
> > +                             if (config->unit_width > 0)
> > +                                     fprintf(out, "%-*s ", config->uni=
t_width, "");
> > +                     }
> > +
> > +                     /* 4. Print event name */
> > +                     fprintf(out, "%-*s", EVNAME_LEN, evsel__name(evse=
l));
> > +
> > +                     /* If there are no metrics, print noise and multi=
plexing percentage */
> > +                     if (list_empty(&ev->metrics_list)) {
> > +                             if (ev->stdev_pct)
> > +                                     fprintf(out, "  ( +-%6.2f%% )", e=
v->stdev_pct);
> > +                             if (ev->run !=3D ev->ena)
> > +                                     fprintf(out, "  (%.2f%%)", 100.0 =
* ev->run / ev->ena);
> > +                     }
> > +             }
> > +
> > +             first =3D true;
> > +             list_for_each_entry_safe(met, tmp_met, &ev->metrics_list,=
 list) {
> > +                     const char *color =3D metric_threshold_classify__=
color(met->thresh);
> > +                     char unit_name[128];
> > +                     const char *m_fmt =3D (met->unit && met->unit[0])=
 ? "%8.1f" : "%8.2f";
> > +
> > +                     if (met->unit && met->unit[0]) {
> > +                             snprintf(unit_name, sizeof(unit_name), "%=
s  %s", met->unit,
> > +                                      met->name);
> > +                     } else {
> > +                             snprintf(unit_name, sizeof(unit_name), "%=
s", met->name);
> > +                     }
> > +
> > +                     if (first) {
> > +                             if (skip_header) {
> > +                                     if (config->interval && ps->times=
tamp[0])
> > +                                             fprintf(out, "%s", ps->ti=
mestamp);
> > +                                     if (config->aggr_map && ev->aggr_=
idx >=3D 0) {
> > +                                             struct aggr_cpu_id id =3D
> > +                                                     config->aggr_map-=
>map[ev->aggr_idx];
> > +                                             int aggr_nr =3D 0;
> > +                                             if (evsel->stats && evsel=
->stats->aggr) {
> > +                                                     aggr_nr =3D
> > +                                                             evsel->st=
ats->aggr[ev->aggr_idx].nr;
> > +                                             }
> > +                                             print_aggr_id_std(config,=
 out, evsel, id, aggr_nr);
> > +                                     }
> > +                                     fprintf(out, "%*s# ",
> > +                                             COUNTS_LEN + EVNAME_LEN +=
 config->unit_width + 3,
> > +                                             "");
> > +                             } else {
> > +                                     fprintf(out, " # ");
> > +                             }
> > +                             first =3D false;
> > +                     } else {
> > +                             /* Align subsequent metric lines */
> > +                             fprintf(out, "\n");
> > +                             if (config->interval && ps->timestamp[0])
> > +                                     fprintf(out, "%s", ps->timestamp)=
;
> > +                             if (config->aggr_map && ev->aggr_idx >=3D=
 0) {
> > +                                     struct aggr_cpu_id id =3D config-=
>aggr_map->map[ev->aggr_idx];
> > +                                     int aggr_nr =3D 0;
> > +                                     if (evsel->stats && evsel->stats-=
>aggr) {
> > +                                             aggr_nr =3D evsel->stats-=
>aggr[ev->aggr_idx].nr;
> > +                                     }
> > +                                     print_aggr_id_std(config, out, ev=
sel, id, aggr_nr);
> > +                             }
> > +                             fprintf(out, "%*s# ",
> > +                                     COUNTS_LEN + EVNAME_LEN + config-=
>unit_width + 3, "");
> > +                     }
> > +
> > +                     if (color && color[0]) {
> > +                             color_fprintf(out, color, m_fmt, met->val=
);
> > +                     } else {
> > +                             fprintf(out, m_fmt, met->val);
> > +                     }
> > +                     /* Print the metric unit and name left-aligned pa=
dded to METRIC_LEN - n - 1 =3D 26 */
> > +                     fprintf(out, " %-26s", unit_name);
> > +
> > +                     /* If this is the last metric in the list, print =
noise and multiplexing percentage */
> > +                     if (list_is_last(&met->list, &ev->metrics_list)) =
{
> > +                             if (ev->stdev_pct)
> > +                                     fprintf(out, "  ( +-%6.2f%% )", e=
v->stdev_pct);
> > +                             if (ev->run !=3D ev->ena)
> > +                                     fprintf(out, "  (%.2f%%)", 100.0 =
* ev->run / ev->ena);
> > +                     }
> > +
> > +                     list_del(&met->list);
> > +                     free(met->name);
> > +                     free(met->unit);
> > +                     free(met);
> > +             }
> > +             fprintf(out, "\n");
> > +
> > +             list_del(&ev->list);
> > +             free(ev->name);
> > +             free(ev);
> > +     }
> > +     print_footer_std(config);
> > +     return 0;
> > +}
> > +
> > +static const struct perf_stat_print_callbacks std_print_callbacks =3D =
{
> > +     .print_start =3D std_print_start,
> > +     .print_end =3D std_print_end,
> > +     .print_event =3D std_print_event,
> > +     .print_metric =3D std_print_metric,
> > +};
> > +
> > +/*
> > + * Standard (STD) Output Callbacks - Metric-Only Mode
> > + */
> > +
> > +static int std_metric_only_print_start(void *ctx,
> > +                                    const struct perf_stat_config *con=
fig __maybe_unused)
> > +{
> > +     struct std_metric_only_print_state *ps =3D ctx;
> > +     INIT_LIST_HEAD(&ps->queued_metrics);
> > +     return 0;
> > +}
> > +
> > +static int std_metric_only_print_metric(void *ctx,
> > +                                     const struct perf_stat_config *co=
nfig __maybe_unused,
> > +                                     struct evsel *evsel __maybe_unuse=
d, int aggr_idx,
> > +                                     const char *name, const char *uni=
t, double val,
> > +                                     enum metric_threshold_classify th=
resh)
> > +{
> > +     struct std_metric_only_print_state *ps =3D ctx;
> > +     struct queued_metric *b =3D malloc(sizeof(*b));
> > +
> > +     if (!b)
> > +             return -ENOMEM;
> > +
> > +     b->name =3D strdup(name);
> > +     if (!b->name) {
> > +             free(b);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     if (unit && unit[0]) {
> > +             b->unit =3D strdup(unit);
> > +             if (!b->unit) {
> > +                     free(b->name);
> > +                     free(b);
> > +                     return -ENOMEM;
> > +             }
> > +     } else {
> > +             b->unit =3D NULL;
> > +     }
> > +
> > +     b->val =3D val;
> > +     b->thresh =3D thresh;
> > +     b->aggr_idx =3D aggr_idx;
> > +     list_add_tail(&b->list, &ps->queued_metrics);
> > +
> > +     return 0;
> > +}
> > +
> > +static int std_metric_only_print_end(void *ctx, const struct perf_stat=
_config *config)
> > +{
> > +     struct std_metric_only_print_state *ps =3D ctx;
> > +     struct queued_metric *b, *tmp;
> > +     FILE *out =3D ps->fp;
> > +     int first_aggr =3D -1;
> > +     /* Initialize to -2 to distinguish from -1 (a valid index in AGGR=
_GLOBAL mode) */
> > +     int current_aggr =3D -2;
> > +     const char *color;
> > +     char *str;
> > +     int mlen;
> > +     int ret =3D 0;
> > +     int err;
> > +
> > +     if (list_empty(&ps->queued_metrics))
> > +             return 0;
> > +
> > +     first_aggr =3D list_first_entry(&ps->queued_metrics, struct queue=
d_metric, list)->aggr_idx;
> > +
> > +     if (!config->metric_only_headers_printed) {
> > +             /* Print the formatted header prefix */
> > +             if (!config->interval)
> > +                     print_header_std(config, ps->target, ps->argc, ps=
->argv);
> > +
> > +             if (config->aggr_map && first_aggr >=3D 0) {
> > +                     int len =3D aggr_header_lens[config->aggr_mode];
> > +
> > +                     fprintf(out, "%*s", len + 1, "");
> > +             }
> > +
> > +             /* Print headers */
> > +             list_for_each_entry(b, &ps->queued_metrics, list) {
> > +                     if (b->aggr_idx =3D=3D first_aggr) {
> > +                             char *header_name;
> > +
> > +                             if (b->unit && b->unit[0]) {
> > +                                     err =3D asprintf(&header_name, "%=
s  %s", b->unit, b->name);
> > +                             } else {
> > +                                     header_name =3D strdup(b->name);
> > +                                     err =3D header_name ? 0 : -1;
> > +                             }
> > +                             if (err < 0) {
> > +                                     ret =3D -ENOMEM;
> > +                                     goto cleanup;
> > +                             }
> > +                             fprintf(out, "%*s ", config->metric_only_=
len, header_name);
> > +                             free(header_name);
> > +                     }
> > +             }
> > +             fprintf(out, "\n\n");
> > +             ((struct perf_stat_config *)config)->metric_only_headers_=
printed =3D true;
> > +     }
> > +
> > +     /* Print values */
> > +     list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> > +             if (b->aggr_idx !=3D current_aggr) {
> > +                     if (current_aggr !=3D -2)
> > +                             fprintf(out, "\n");
> > +                     current_aggr =3D b->aggr_idx;
> > +                     if (config->interval && ps->timestamp[0])
> > +                             fprintf(out, "%s", ps->timestamp);
> > +                     if (config->aggr_map && current_aggr >=3D 0) {
> > +                             struct aggr_cpu_id id =3D config->aggr_ma=
p->map[current_aggr];
> > +                             struct evsel *mock_evsel =3D list_first_e=
ntry(&ps->evlist->core.entries, struct evsel, core.node);
> > +                             int aggr_nr =3D 0;
> > +
> > +                             if (mock_evsel->stats && mock_evsel->stat=
s->aggr)
> > +                                     aggr_nr =3D mock_evsel->stats->ag=
gr[current_aggr].nr;
> > +
> > +                             print_aggr_id_std(config, out, mock_evsel=
, id, aggr_nr);
> > +                     }
> > +             }
> > +             color =3D metric_threshold_classify__color(b->thresh);
> > +             mlen =3D config->metric_only_len;
> > +
> > +             if (color && color[0]) {
> > +                     err =3D asprintf(&str, "%s%.1f%s", color, b->val,=
 PERF_COLOR_RESET);
> > +                     mlen +=3D strlen(color) + sizeof(PERF_COLOR_RESET=
) - 1;
> > +             } else {
> > +                     err =3D asprintf(&str, "%.1f", b->val);
> > +             }
> > +             if (err < 0) {
> > +                     ret =3D -ENOMEM;
> > +                     goto cleanup;
> > +             }
> > +             fprintf(out, "%*s ", mlen, str);
> > +             free(str);
> > +
> > +             list_del(&b->list);
> > +             free(b->name);
> > +             free(b->unit);
> > +             free(b);
> > +     }
> > +     print_footer_std(config);
> > +     return 0;
> > +
> > +cleanup:
> > +     list_for_each_entry_safe(b, tmp, &ps->queued_metrics, list) {
> > +             list_del(&b->list);
> > +             free(b->name);
> > +             free(b->unit);
> > +             free(b);
> > +     }
> > +     return ret;
> > +}
> > +
> > +static const struct perf_stat_print_callbacks std_metric_only_print_ca=
llbacks =3D {
> > +     .print_start =3D std_metric_only_print_start,
> > +     .print_end =3D std_metric_only_print_end,
> > +     .print_event =3D NULL,
> > +     .print_metric =3D std_metric_only_print_metric,
> > +};
> > +
> > +int perf_stat__print_std(struct evlist *evlist, const struct perf_stat=
_config *config,
> > +                      const struct target *target, const struct timesp=
ec *ts, int argc,
> > +                      const char **argv)
> > +{
> > +     struct std_print_state ps =3D {
> > +             .fp =3D config->output,
> > +             .target =3D target,
> > +             .argc =3D argc,
> > +             .argv =3D argv,
> > +     };
> > +
> > +     if (config->metric_only) {
> > +             struct std_metric_only_print_state mops =3D {
> > +                     .fp =3D config->output,
> > +                     .target =3D target,
> > +                     .argc =3D argc,
> > +                     .argv =3D argv,
> > +                     .evlist =3D evlist,
> > +             };
> > +             if (config->interval && ts) {
> > +                     scnprintf(mops.timestamp, sizeof(mops.timestamp),=
 "%6lu.%09lu ",
> > +                               (unsigned long)ts->tv_sec, ts->tv_nsec)=
;
> > +             } else {
> > +                     mops.timestamp[0] =3D '\0';
> > +             }
> > +             return perf_stat__print_cb(evlist, config, target, ts, ar=
gc, argv,
> > +                                        &std_metric_only_print_callbac=
ks, &mops);
> > +     } else {
> > +             if (config->interval && !config->headers_printed) {
> > +                     FILE *output =3D config->output;
> > +
> > +                     if (config->aggr_mode =3D=3D AGGR_GLOBAL) {
> > +                             fprintf(output, "#%*s %*s %*s events\n", =
15 - 2, "time", 18, "counts", config->unit_width, "unit");
> > +                     } else {
> > +                             fprintf(output, "#%*s %-*s ctrs %*s %*s e=
vents\n",
> > +                                     15 - 2, "time",
> > +                                     aggr_header_lens[config->aggr_mod=
e], aggr_header_std[config->aggr_mode],
> > +                                     18, "counts", config->unit_width,=
 "unit");
> > +                     }
> > +                     ((struct perf_stat_config *)config)->headers_prin=
ted =3D true;
> > +             }
> > +             if (config->interval && ts) {
> > +                     scnprintf(ps.timestamp, sizeof(ps.timestamp), "%6=
lu.%09lu ",
> > +                               (unsigned long)ts->tv_sec, ts->tv_nsec)=
;
> > +             } else {
> > +                     ps.timestamp[0] =3D '\0';
> > +             }
> > +             return perf_stat__print_cb(evlist, config, target, ts, ar=
gc, argv,
> > +                                        &std_print_callbacks, &ps);
> > +     }
> > +}
> > --
> > 2.54.0.794.g4f17f83d09-goog
> >
