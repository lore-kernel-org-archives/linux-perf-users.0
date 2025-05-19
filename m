Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2BA199931
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747671445; cv=none; b=bJeO53AN42aGcuqX2ke0Nuk7y37LWGQpqnkMZZ3m0UlFQtHkqj806vv9K8dBw8pS0GXockrFYRWf/0JStTO91x5RMQNruZLH1z/IWnbkXr6XY+DGJ/rmV1oJj8vs9nMzyShyyX6/gT10gDRuAvmkkjHAFLZl5jDZbtzPOZIH86o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747671445; c=relaxed/simple;
	bh=Grx/nxWS7DPAeTUM7skjp3Lvq/Xtt87P+m9AM4q8rKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KonVdGijkhCmKsrmeNfmyWFIYlppzir5Q/CAiVshWT/otUAgh8dXv0+pkmYVVeDpzo3Xl3+fmWgj18mZ62IuHoXRD9ikVlvjxQ0QrHu4+IBCZeMN1tU5jmQOBUJY0gsFotXzCerWBSvVSLdjK6kSHAs0kOUwKgReZBZm61TPC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YmqO4Oa8; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YmqO4Oa8"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3da76aea6d5so455505ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 09:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747671443; x=1748276243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rins45p9wqlcxhKua7Kw7fUdA0oz0U8sEewToOoywgw=;
        b=YmqO4Oa87w+sXN+BFh9sMQlIE8Qa+yReio7EALeO0c0hXFrojXGNDmwLB6O9gMWcQy
         wSnDWoA7Uo1caPTVvau+9j7Ci8t9vTKxS+4Tu5YvigR6CB8DH7E9Lk/PqzVWTuJxOVmR
         EyIjFPmLKTs17Fd0FFOWjpbID2LcBmThKsgSOv5wCOQht+yPQyOcSSTBvQeXJzxQwi1e
         fTRPjRb3r2dDNS+Dy/86OjKMzCjCgzj1in1EZ1yV2IaXOdMHR0jbmZlnnDltsk/AltKD
         KST5dmlJWZMfJJzzsF6Cm5JJTVGpotgYyJvRO0BjSfzx6uPIJdBaXLf0/JRHIvjFaL8Q
         Rupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747671443; x=1748276243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rins45p9wqlcxhKua7Kw7fUdA0oz0U8sEewToOoywgw=;
        b=Y4tSSnOJH+JyMWTxZ0yhUrSrltZXPj+z8O5UFTNYpEQkDVtdmHvaEwHGOmxXSB7YCa
         17bhZi1zGp8kC7Iql6r39WWmrAW6N8BNKNUtSXSDxJXyaI9KZ39bv3b4de/5aLp8OWS8
         dZVkU7++oEdY4YyHaxgGgteqhjgzmtt5wF2Nie4KCrSLH2zTQt4xxz24VIcjrGuj4aQV
         rr+oJoyDwcxIlzyZ/5T15ZbyVLkXYLsFEExug9dEIsut3a7coappEmF0w2RR7uWkQKZM
         CCYy/+LL83fwkktIEBdveiXXE572I/4d5UucgxRHLGJUvb8THNuz2+OuQ/LG4iWGeTjD
         9+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe3HJLS/kqzx0TjoCWKZrTYWfCZJsrXCC3wZeNOGr7Mr5CIYJV7ZQ4uhsnuuRXZEQl6vRPyIx3GFUiYJSWxMhE@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+cYhRNlFMoZghJqAmVStB6IM3zH0uqDidNhCkk0eZ6rAg/te
	MMRwSDrCMXAhxx5jT3BsM7rGJDbpY7IVdIpulXytl4S4xzyxKMGN9m69SS4ThA45YAKch0K5dDi
	ZoD3tIsL8D4nn9qRpIO3GDUOwtxEPyEfaXgt5Gjot
X-Gm-Gg: ASbGncv7Gjzvx1w23QB/j9o1YbSpbRQtJyxFkC+VEBJlivUJEUWoMf6YBGr1Gk8roko
	wLvCn4nNbSEiVf2LV9jq62jMCui2JGz1vKvBZCmJ999lelVzVliKzELIsQtZ3lqn5Ppy6aZ7h/7
	/kKp5gJFLArzuKco7TVS5QPVLCe+VqsXE1NgFnScsPNxTzxesvITktheBa5bw60A==
X-Google-Smtp-Source: AGHT+IHfgu3bU5wgEqRylIasp6Gn3Vp9m3dEcqPHRlaCl3301MPDu9770XsmdX7g+hSJnKqrbj7c+3DrokG55MPdbBs=
X-Received: by 2002:a05:6e02:180c:b0:3d9:36bd:8c59 with SMTP id
 e9e14a558f8ab-3dc5e6150e2mr5486965ab.9.1747671442120; Mon, 19 May 2025
 09:17:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512210912.274362-1-thomas.falcon@intel.com>
 <CAP-5=fWqMzqtvxaqz21z53U0jDOyTuH-X2op4kgs6KLa7Pr7Jw@mail.gmail.com> <466021998b86b3a139f0003178fd47d98c7f2684.camel@intel.com>
In-Reply-To: <466021998b86b3a139f0003178fd47d98c7f2684.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 May 2025 09:17:10 -0700
X-Gm-Features: AX0GCFsmieOcUL6adh4Ultb0ZpChHOuD5qQZEKoJVq43Xq67yyjNIQyZMMn5WvI
Message-ID: <CAP-5=fVYsXqjbgoA_bxiWN1eX_ZwPEreSVFBLX-_0bwct9GThA@mail.gmail.com>
Subject: Re: [PATCH] perf record: Usability enhancement for Auto Counter Reload
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "acme@kernel.org" <acme@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:05=E2=80=AFAM Falcon, Thomas <thomas.falcon@inte=
l.com> wrote:
>
> On Tue, 2025-05-13 at 08:31 -0700, Ian Rogers wrote:
> > On Mon, May 12, 2025 at 2:09=E2=80=AFPM Thomas Falcon <thomas.falcon@in=
tel.com> wrote:
> > >
> > > The Auto Counter Reload (ACR)[1] feature is used to track the
> > > relative rates of two or more perf events, only sampling
> > > when a given threshold is exceeded. This helps reduce overhead
> > > and unnecessary samples. However, enabling this feature
> > > currently requires setting two parameters:
> > >
> > >  -- Event sampling period ("period")
> > >  -- acr_mask, which determines which events get reloaded
> > >     when the sample period is reached.
> > >
> > > For example, in the following command:
> > >
> > > perf record -e "{cpu_atom/branch-misses,period=3D200000,\
> > > acr_mask=3D0x2/ppu,cpu_atom/branch-instructions,period=3D1000000,\
> > > acr_mask=3D0x3/u}" -- ./mispredict
> > >
> > > The goal is to limit event sampling to cases when the
> > > branch miss rate exceeds 20%. If the branch instructions
> > > sample period is exceeded first, both events are reloaded.
> > > If branch misses exceed their threshold first, only the
> > > second counter is reloaded, and a sample is taken.
> > >
> > > To simplify this, provide a new =E2=80=9Cratio-to-prev=E2=80=9D event=
 term
> > > that works alongside the period event option or -c option.
> > > This would allow users to specify the desired relative rate
> > > between events as a ratio, making configuration more intuitive.
> > >
> > > With this enhancement, the equivalent command would be:
> > >
> > > perf record -e "{cpu_atom/branch-misses/ppu,\
> > > cpu_atom/branch-instructions,period=3D1000000,ratio_to_prev=3D5/u}" \
> > > -- ./mispredict
> > >
> > > or
> > >
> > > perf record -e "{cpu_atom/branch-misses/ppu,\
> > > cpu_atom/branch-instructions,ratio-to-prev=3D5/u}" -c 1000000 \
> > > -- ./mispredict
> >
> > Thanks Thomas. I'm wondering if ratio-to-prev should be a generic term
> > such that periods can be set as a ratio of each on non-Intel?
> >
> > > [1] https://lore.kernel.org/lkml/20250327195217.2683619-1-kan.liang@l=
inux.intel.com/
> > >
> > > Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>
> > >
> > > ---
> > >  tools/perf/Documentation/intel-acr.txt |  45 +++++++++++
> > >  tools/perf/Documentation/perf-list.txt |   2 +
> > >  tools/perf/arch/x86/util/evsel.c       | 100 +++++++++++++++++++++++=
+-
> > >  tools/perf/util/evsel.c                |   2 +
> > >  tools/perf/util/evsel_config.h         |   1 +
> > >  tools/perf/util/parse-events.c         |  10 +++
> > >  tools/perf/util/parse-events.h         |   3 +-
> > >  tools/perf/util/parse-events.l         |   1 +
> > >  tools/perf/util/pmu.c                  |   3 +-
> > >  9 files changed, 164 insertions(+), 3 deletions(-)
> > >  create mode 100644 tools/perf/Documentation/intel-acr.txt
> > >
> > > diff --git a/tools/perf/Documentation/intel-acr.txt b/tools/perf/Docu=
mentation/intel-acr.txt
> > > new file mode 100644
> > > index 000000000000..db835c769e1c
> > > --- /dev/null
> > > +++ b/tools/perf/Documentation/intel-acr.txt
> > > @@ -0,0 +1,45 @@
> > > +Intel Auto Counter Reload Support
> > > +---------------------------------
> > > +Support for Intel Auto Counter Reload in perf tools
> > > +
> > > +Auto counter reload provides a means for software to specify to hard=
ware
> > > +that certain counters, if supported, should be automatically reloade=
d
> > > +upon overflow of chosen counters. By taking a sample only if the rat=
e of
> > > +one event exceeds some threshold relative to the rate of another eve=
nt,
> > > +this feature enables software to sample based on the relative rate o=
f
> > > +two or more events. To enable this, the user must provide a sample p=
eriod
> > > +term and a bitmask ("acr_mask") for each relevant event specifying t=
he
> > > +counters in an event group to reload if the event's specified sample
> > > +period is exceeded.
> > > +
> > > +For example, if the user desires to measure a scenario when IPC > 2,
> > > +the event group might look like the one below:
> > > +
> > > +       perf record -e {cpu_atom/instructions,period=3D200000,acr_mas=
k=3D0x2/, \
> > > +       cpu_atom/cycles,period=3D100000,acr_mask=3D0x3/} -- true
> > > +
> > > +In this case, if the "instructions" counter exceeds the sample perio=
d of
> > > +200000, the second counter, "cycles", will be reset and a sample wil=
l be
> > > +taken. If "cycles" is exceeded first, both counters in the group wil=
l be
> > > +reset. In this way, samples will only be taken for cases where IPC >=
 2.
> >
> > Could this definition include the meaning of acr_mask? I can see that
> > the 2 periods create an IPC of 2, but I can't see why the acr_mask
> > needs to be 2 and 3.
>
> Hi Ian, thanks for reviewing. I will include an explanation for the acr m=
ask in a new version.
>
> >
> > > +
> > > +ratio-to-prev Event Term
> > > +------------------------
> > > +To simplify this, an event term "ratio-to-prev" is provided which is=
 used
> > > +alongside the sample period term n or the -c/--count option. This wo=
uld
> > > +allow users to specify the desired relative rate between events as a
> > > +ratio.
> >
> > Should there be an opposite ratio-to-next?
> >
> > > +
> > > +The command above would then become
> > > +
> > > +       perf record -e {cpu_atom/instructions/, \
> > > +       cpu_atom/cycles,period=3D100000,ratio-to-prev=3D0.5/} -- true
> > > +
> > > +ratio-to-prev is the ratio of the event using the term relative
> > > +to the previous event in the group, which will always be 1,
> > > +for a 1:0.5 or 2:1 ratio.
> > > +
> > > +To sample for IPC < 2 for example, the events need to be reordered:
> > > +
> > > +       perf record -e {cpu_atom/cycles/, \
> > > +       cpu_atom/instructions,period=3D200000,ratio-to-prev=3D2.0/} -=
- true
> >
> > We allow "software" events in groups with hardware events. The current
> > list of software events is in perf_pmu__is_software and contains a few
> > surprises like "msr":
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n2134
> > presumably ratio-to-prev should apply to the previous event in the
> > list that is on the same PMU?
>
> Yes, that's right.
>
> >
> > > diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Docu=
mentation/perf-list.txt
> > > index 8914f12d2b85..ba809fa1e8c6 100644
> > > --- a/tools/perf/Documentation/perf-list.txt
> > > +++ b/tools/perf/Documentation/perf-list.txt
> > > @@ -376,6 +376,8 @@ Support raw format:
> > >  . '--raw-dump [hw|sw|cache|tracepoint|pmu|event_glob]', shows the ra=
w-dump of
> > >    a certain kind of events.
> > >
> > > +include::intel-acr.txt[]
> > > +
> > >  SEE ALSO
> > >  --------
> > >  linkperf:perf-stat[1], linkperf:perf-top[1],
> > > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/u=
til/evsel.c
> > > index 3dd29ba2c23b..b93dbbed2c8e 100644
> > > --- a/tools/perf/arch/x86/util/evsel.c
> > > +++ b/tools/perf/arch/x86/util/evsel.c
> > > @@ -1,7 +1,9 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > > +#include "util/evlist.h"
> > >  #include "util/evsel.h"
> > > +#include "util/evsel_config.h"
> > >  #include "util/env.h"
> > >  #include "util/pmu.h"
> > >  #include "util/pmus.h"
> > > @@ -89,6 +91,97 @@ int arch_evsel__hw_name(struct evsel *evsel, char =
*bf, size_t size)
> > >                          event_name);
> > >  }
> > >
> > > +static void evsel__apply_ratio_to_prev(struct evsel *evsel,
> > > +                               struct perf_event_attr *attr,
> > > +                               const char *buf)
> > > +{
> > > +       struct perf_event_attr *prev_attr =3D NULL;
> > > +       struct evsel *evsel_prev =3D NULL;
> > > +       struct evsel *leader =3D evsel__leader(evsel);
> > > +       struct evsel *pos;
> > > +       const char *name =3D "acr_mask";
> > > +       int evsel_idx =3D 0;
> > > +       __u64 ev_mask, pr_ev_mask;
> > > +       double rtp;
> > > +
> > > +       rtp =3D strtod(buf, NULL);
> > > +       if (rtp <=3D 0) {
> > > +               pr_err("Invalid ratio-to-prev value %lf\n", rtp);
> >
> > It would be nice to fail this early during parsing so that we can
> > identify the part of the parse string that is invalid. I'm guessing it
> > is this way because the parse_events__term_val_type are either an
> > integer or a string.
>
> Thanks, that does sound better. I'll look into that for v2.
>
> >
> > > +               return;
> > > +       }
> > > +       if (evsel =3D=3D evsel__leader(evsel)) {
> > > +               pr_err("Invalid use of ratio-to-prev term without pre=
ceding element in group\n");
> >
> > I'm wondering how we can prevent this happening due to event
> > reordering in parse_events__sort_events_and_fix_groups:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n2095
> >
>
> Is there a way for a user to force a specific event order? Or avoid event=
 reordering?

Sorry for the delay in replying to this, There isn't a way to avoid
event reordering in part as it is a property of how the parsing works.
I can give a bit of a back story on why there is event reordering.
Initially events were reordered for uncore PMUs. On my alderlake I
have uncore_imc_free_running_0 and uncore_imc_free_running_1 and they
have the events data_read and data_write. If I grouped the events
like:
```
$ perf stat -e '{data_read,data_write}' -a sleep 1
```
then at parse time the evlist will be
{uncore_imc_0/data_read/,uncore_imc_1/data_read/,uncore_imc_0/data_write/,u=
ncore_imc_1/data_write/}.
It isn't allowed to have events for different PMUs within the same
group, and we also want to group the uncore_imc_0/data_write/ event
with the uncore_imc_0/data_read/ event (and similarly for
uncore_imc_1). There was previous logic that I rewrote as
parse_events__sort_events_and_fix_groups that fixed issues like
software events, but I also used it to fix the perf metric events. The
perf metric events on performance cores require the slots event to
come first and to be in a group with it. For metrics we pretty much
grab events in the order they are in the metric and then try to
program them in a group. There were proposals to provide an event
order with metrics so they could be programmed properly somehow, but
then what about uncore, etc. What we have is messy, but the messiness
comes about from perf metric events and uncore, it somewhat works well
for metrics as they needn't worry at all about event order and
grouping.

Thanks,
Ian

> > > +               return;
> > > +       }
> > > +       if (!evsel->pmu->is_core) {
> > > +               pr_err("Event using ratio-to-prev term must have a co=
re PMU\n");
> >
> > Would a stronger test here be the same PMU?
>
> The previous check should make sure that the events are in the same group=
, which implies that they
> are either from the same PMU or a SW event. This check then covers the SW=
 event and non-core PMU
> case.
>
> >
> > > +               return;
> > > +       }
> > > +       if (!perf_pmu__has_format(evsel->pmu, name)) {
> > > +               pr_err("'%s' does not have acr_mask format support\n"=
, evsel->pmu->name);
> > > +               return;
> > > +       }
> > > +       if (perf_pmu__format_type(evsel->pmu, name) !=3D
> > > +                       PERF_PMU_FORMAT_VALUE_CONFIG2) {
> > > +               pr_err("'%s' does not have acr_mask format support\n"=
, evsel->pmu->name);
> >
> > I wonder if the acr_mask support could be in an
> > arch_evsel__apply_ratio_to_prev and the non-acr_mask stuff be generic?
> > If nothing else this would aid testing.
> >
> > > +               return;
> > > +       }
> > > +       if (attr->freq) {
> > > +               pr_err("Event period term or count (-c) must be set w=
hen using ratio-to-prev term.\n");
> > > +               return;
> > > +       }
> > > +
> > > +       evsel_prev =3D evsel__prev(evsel);
> > > +       if (!evsel_prev) {
> > > +               pr_err("Previous event does not exist.\n");
> > > +               return;
> > > +       }
> > > +
> > > +       prev_attr =3D &evsel_prev->core.attr;
> > > +
> > > +       prev_attr->sample_period =3D (__u64)(attr->sample_period / rt=
p);
> > > +       prev_attr->freq =3D 0;
> > > +       evsel__reset_sample_bit(evsel_prev, PERIOD);
> > > +
> > > +       for_each_group_evsel(pos, leader) {
> > > +               if (pos =3D=3D evsel)
> > > +                       break;
> > > +               evsel_idx++;
> > > +       }
> > > +
> > > +       /*
> > > +        * acr_mask (config2) is calculated using the event's index i=
n
> > > +        * the event group. The first event will use the index of the
> > > +        * second event as its mask (e.g., 0x2), indicating that the
> > > +        * second event counter will be reset and a sample taken for
> > > +        * the first event if its counter overflows. The second event
> > > +        * will use the mask consisting of the first and second bits
> > > +        * (e.g., 0x3), meaning both counters will be reset if the
> > > +        * second event counter overflows.
> > > +        */
> > > +
> > > +       ev_mask =3D 1ull << evsel_idx;
> > > +       pr_ev_mask =3D 1ull << (evsel_idx - 1);
> > > +
> > > +       prev_attr->config2 =3D ev_mask;
> > > +       attr->config2 =3D ev_mask | pr_ev_mask;
> > > +}
> > > +
> > > +static void intel__post_evsel_config(struct evsel *evsel,
> > > +                             struct perf_event_attr *attr)
> > > +{
> > > +       struct evsel_config_term *term;
> > > +       struct list_head *config_terms =3D &evsel->config_terms;
> > > +       const char *rtp_buf =3D NULL;
> > > +
> > > +       list_for_each_entry(term, config_terms, list) {
> > > +               if (term->type =3D=3D EVSEL__CONFIG_TERM_RATIO_TO_PRE=
V) {
> > > +                       rtp_buf =3D term->val.str;
> > > +                       evsel__apply_ratio_to_prev(evsel, attr, rtp_b=
uf);
> > > +               }
> > > +       }
> > > +}
> > > +
> > >  static void ibs_l3miss_warn(void)
> > >  {
> > >         pr_warning(
> > > @@ -101,7 +194,12 @@ void arch__post_evsel_config(struct evsel *evsel=
, struct perf_event_attr *attr)
> > >         struct perf_pmu *evsel_pmu, *ibs_fetch_pmu, *ibs_op_pmu;
> > >         static int warned_once;
> > >
> > > -       if (warned_once || !x86__is_amd_cpu())
> > > +       if (!x86__is_amd_cpu()) {
> > > +               intel__post_evsel_config(evsel, attr);
> > > +               return;
> > > +       }
> > > +
> > > +       if (warned_once)
> > >                 return;
> > >
> > >         evsel_pmu =3D evsel__find_pmu(evsel);
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index b60461e16804..5028232afeb7 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1189,6 +1189,8 @@ static void evsel__apply_config_terms(struct ev=
sel *evsel,
> > >                         break;
> > >                 case EVSEL__CONFIG_TERM_CFG_CHG:
> > >                         break;
> > > +               case EVSEL__CONFIG_TERM_RATIO_TO_PREV:
> > > +                       break;
> > >                 default:
> > >                         break;
> > >                 }
> > > diff --git a/tools/perf/util/evsel_config.h b/tools/perf/util/evsel_c=
onfig.h
> > > index af52a1516d0b..26c69d9ce788 100644
> > > --- a/tools/perf/util/evsel_config.h
> > > +++ b/tools/perf/util/evsel_config.h
> > > @@ -28,6 +28,7 @@ enum evsel_term_type {
> > >         EVSEL__CONFIG_TERM_AUX_ACTION,
> > >         EVSEL__CONFIG_TERM_AUX_SAMPLE_SIZE,
> > >         EVSEL__CONFIG_TERM_CFG_CHG,
> > > +       EVSEL__CONFIG_TERM_RATIO_TO_PREV,
> > >  };
> > >
> > >  struct evsel_config_term {
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-e=
vents.c
> > > index 7297ca3a4eec..4ea8d4ffabdb 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -806,6 +806,7 @@ const char *parse_events__term_type_str(enum pars=
e_events__term_type term_type)
> > >                 [PARSE_EVENTS__TERM_TYPE_RAW]                   =3D "=
raw",
> > >                 [PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE]          =3D "=
legacy-cache",
> > >                 [PARSE_EVENTS__TERM_TYPE_HARDWARE]              =3D "=
hardware",
> > > +               [PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV]         =3D "=
ratio-to-prev",
> > >         };
> > >         if ((unsigned int)term_type >=3D __PARSE_EVENTS__TERM_TYPE_NR=
)
> > >                 return "unknown term";
> > > @@ -855,6 +856,7 @@ config_term_avail(enum parse_events__term_type te=
rm_type, struct parse_events_er
> > >         case PARSE_EVENTS__TERM_TYPE_RAW:
> > >         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> > >         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > > +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > >         default:
> > >                 if (!err)
> > >                         return false;
> > > @@ -982,6 +984,9 @@ do {                                             =
                              \
> > >                         return -EINVAL;
> > >                 }
> > >                 break;
> > > +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > > +               CHECK_TYPE_VAL(STR);
> > > +               break;
> > >         case PARSE_EVENTS__TERM_TYPE_DRV_CFG:
> > >         case PARSE_EVENTS__TERM_TYPE_USER:
> > >         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> > > @@ -1109,6 +1114,7 @@ static int config_term_tracepoint(struct perf_e=
vent_attr *attr,
> > >         case PARSE_EVENTS__TERM_TYPE_RAW:
> > >         case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> > >         case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > > +       case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > >         default:
> > >                 if (err) {
> > >                         parse_events_error__handle(err, term->err_ter=
m,
> > > @@ -1233,6 +1239,9 @@ do {                                           =
                   \
> > >                         ADD_CONFIG_TERM_VAL(AUX_SAMPLE_SIZE, aux_samp=
le_size,
> > >                                             term->val.num, term->weak=
);
> > >                         break;
> > > +               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > > +                       ADD_CONFIG_TERM_STR(RATIO_TO_PREV, term->val.=
str, term->weak);
> > > +                       break;
> > >                 case PARSE_EVENTS__TERM_TYPE_USER:
> > >                 case PARSE_EVENTS__TERM_TYPE_CONFIG:
> > >                 case PARSE_EVENTS__TERM_TYPE_CONFIG1:
> > > @@ -1297,6 +1306,7 @@ static int get_config_chgs(struct perf_pmu *pmu=
, struct parse_events_terms *head
> > >                 case PARSE_EVENTS__TERM_TYPE_RAW:
> > >                 case PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE:
> > >                 case PARSE_EVENTS__TERM_TYPE_HARDWARE:
> > > +               case PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV:
> > >                 default:
> > >                         break;
> > >                 }
> > > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-e=
vents.h
> > > index e176a34ab088..a9de95dd337a 100644
> > > --- a/tools/perf/util/parse-events.h
> > > +++ b/tools/perf/util/parse-events.h
> > > @@ -80,7 +80,8 @@ enum parse_events__term_type {
> > >         PARSE_EVENTS__TERM_TYPE_RAW,
> > >         PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE,
> > >         PARSE_EVENTS__TERM_TYPE_HARDWARE,
> > > -#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE=
_HARDWARE + 1)
> > > +       PARSE_EVENTS__TERM_TYPE_RATIO_TO_PREV,
> > > +#define        __PARSE_EVENTS__TERM_TYPE_NR (PARSE_EVENTS__TERM_TYPE=
_RATIO_TO_PREV + 1)
> > >  };
> > >
> > >  struct parse_events_term {
> > > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-e=
vents.l
> > > index 7ed86e3e34e3..49fe1811fe68 100644
> > > --- a/tools/perf/util/parse-events.l
> > > +++ b/tools/perf/util/parse-events.l
> > > @@ -335,6 +335,7 @@ aux-output          { return term(yyscanner, PARS=
E_EVENTS__TERM_TYPE_AUX_OUTPUT); }
> > >  aux-action             { return term(yyscanner, PARSE_EVENTS__TERM_T=
YPE_AUX_ACTION); }
> > >  aux-sample-size                { return term(yyscanner, PARSE_EVENTS=
__TERM_TYPE_AUX_SAMPLE_SIZE); }
> > >  metric-id              { return term(yyscanner, PARSE_EVENTS__TERM_T=
YPE_METRIC_ID); }
> > > +ratio-to-prev          { return term(yyscanner, PARSE_EVENTS__TERM_T=
YPE_RATIO_TO_PREV); }
> > >  cpu-cycles|cycles                              { return hw_term(yysc=
anner, PERF_COUNT_HW_CPU_CYCLES); }
> > >  stalled-cycles-frontend|idle-cycles-frontend   { return hw_term(yysc=
anner, PERF_COUNT_HW_STALLED_CYCLES_FRONTEND); }
> > >  stalled-cycles-backend|idle-cycles-backend     { return hw_term(yysc=
anner, PERF_COUNT_HW_STALLED_CYCLES_BACKEND); }
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index d08972aa461c..8b5b5a6adb29 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -1470,7 +1470,7 @@ static int pmu_config_term(const struct perf_pm=
u *pmu,
> > >                         break;
> > >                 case PARSE_EVENTS__TERM_TYPE_USER: /* Not hardcoded. =
*/
> > >                         return -EINVAL;
> > > -               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__T=
ERM_TYPE_HARDWARE:
> > > +               case PARSE_EVENTS__TERM_TYPE_NAME ... PARSE_EVENTS__T=
ERM_TYPE_RATIO_TO_PREV:
> > >                         /* Skip non-config terms. */
> > >                         break;
> > >                 default:
> > > @@ -1852,6 +1852,7 @@ int perf_pmu__for_each_format(struct perf_pmu *=
pmu, void *state, pmu_format_call
> > >                 "aux-output",
> > >                 "aux-action=3D(pause|resume|start-paused)",
> > >                 "aux-sample-size=3Dnumber",
> > > +               "ratio-to-prev=3Dstring",
> > >         };
> > >         struct perf_pmu_format *format;
> > >         int ret;
> >
> > Some places I think testing can be added are:
> > * The event parsing test:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/parse-events.c?h=3Dperf-tools-next#n2143
> > * The perf record test:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/shell/record.sh?h=3Dperf-tools-next
> >
>
> Thanks, I'll look into adding more testing here.
>
> > I wonder for if acr_mask is present (or ratio-to-prev) then
> > arch_evsel__must_be_in_group should return true:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/arch/x86/util/evsel.c?h=3Dperf-tools-next#n63
> > this is used to force topdown events into groups, so perhaps we can do
> > similar forcing and make the use of the {} for the group optional (or
> > fixed by the tool).
>
> Thanks, this might be an answer to my previous question.
>
> Thanks, Tom
> >
> > Thanks,
> > Ian
> >
> > > --
> > > 2.48.1
> > >
>
