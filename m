Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102B21FF31
	for <linux-perf-users@vger.kernel.org>; Wed,  9 Jul 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081239; cv=none; b=IO3yI0HH2sOJHgI9VbJU1+msPjFHjVt8J0u9nj2NTP14GUrWPkILQiL3/FNzCFwqb6FIe9E+qWKEe7qenHCgniJafJHeKM+a6mtGM7B/kU8ZbHmUdLOOK6DkZrBdIVAvJPFVZGgKCvSOcnEyFGN3RScll8+5XbNHTjDgGT+JE1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081239; c=relaxed/simple;
	bh=cT8+FgW6ZfYFqv8uJcUWXHg3VHiYw8NAM4z0R9Iify8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfeGx5i5wSxGLkXl442ojTBJNYMpvUyjusXnX6rZQYQ5aCFcYzuMLs49r15J2MUujT61gnn3qiHwA/tLNYxEqO82KW9jVnXM5FKPv6SRLyM0wHSv1b7pfctYbb7tibvi68caBRYkDdMSRWtynO43t2vydwa4ft+dopOnW262Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qE4XlDl7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qE4XlDl7"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3df2fa612c4so8405ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jul 2025 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752081237; x=1752686037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4qqGL9BSDdSYChXoVa4eOs0E836UaY7CUQoXn4JW+g=;
        b=qE4XlDl7bKo8Pj/W06+KnSdNI58P8v3+adusw+Db2USEAxiGgjr601W6+NB2PaCB9Z
         +7wsDDHHEHsu7rY8p1/30zkrnMefBweggF9NoV68fO00QJFdEXO5ctj3Z/gdF4rNM1fa
         HleyJkTl59/o9twaK6NTzL16XfXqQb8pMKBrEc6GB/grhbp0zzDa8J7+89KkedPTEons
         YS+PbjAWHoCRzhqys/drbRgeWKKrd7bkWhsxFAbBDC9jqNWmBA6+dAtnPCvGN/mkyFAk
         yAfeMOdbiEyqPh5EGOp90Xk5qIErGezFjqSklxiY7LJZJ82LxDsBtFDWle9bsId7LSGd
         t3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081237; x=1752686037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4qqGL9BSDdSYChXoVa4eOs0E836UaY7CUQoXn4JW+g=;
        b=U92AuKCWHA8WiLq+Kcm/56TJHyEp/MNfnUhCIAVfp147nkWStqvfI2ocf6r3CJXxGi
         IrgnUgqGAYgj4J8xwhgO0MffkScFdcsBjJ9Iiptu8QeWUUf4HXrbLqPmpKvhyQqgHI9V
         DkTGXfbWrq4bsJfrZHohXy2zjsJr7R7JAP8tX4plzJlQrPeZetoKm5SS+Gd06dxv0+/U
         5NiPLTJBk8minZBS+1iF9jmEND44YoVk7EVoxU+JJTkKGYnte/WrpJUz4NcUWp0nWfPQ
         DbqZ6zL5n1CdciW4bmhMD9Z2UD98RXZC2KaZ1KI5auS02WxEn7jzqu+q4ra9NXdlijf6
         +a5w==
X-Forwarded-Encrypted: i=1; AJvYcCUq6VyXVvEeKShbOGACS3UNM1vFPypbPe6OjBW/PTJYHLg8CX0vDi6p9OBg96luqp9kLLHoYOVIbteNG7o+mNie@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+odfI2rohlctR1fWcClJ4cs9q3wCsuuL6qcayU6NCv/nW0sb
	cDoIkQ1p7I3XGWO/sff7Itq/vGMtdFa8wazzgMj74UJTY5fHIY0BKX+bFUr8Klh5jCF3MHcoeov
	D5UWFvUI/kqiSvbM/8BpYP8nKWWiNbm2bzz90dU0b
X-Gm-Gg: ASbGncsoWvgX8qyUzSm8uQlwWHiG6iqALk6izwES4DLI6iLxUevvZmJMWEm2pRnawzh
	E9EZwEhfkBW+hlywTHKDiPrzafoUrUCL2D3nhP7pWhJgveTnHBBrIM1w/TWgj+acIJk8WHuo9sC
	NHkbeeiiHGVNT6bt9hYvXv2P8amQG/9MLK8e2u0gmXikXfcciGAs8d3xiXyUk+HVLDTPObm3/U
X-Google-Smtp-Source: AGHT+IEy1cLtKVuAX9KJtyOOOK/BbSrWBMSEJwSphhcyL/XDz04YiBfmg7x3q1HtBxOn0eTmHkLK5jbEKLPjj2MetD0=
X-Received: by 2002:a05:6e02:2593:b0:3dc:7c30:c6de with SMTP id
 e9e14a558f8ab-3e166276c8amr4612125ab.28.1752081236625; Wed, 09 Jul 2025
 10:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628000929.230406-1-irogers@google.com> <aG6aSX0Ws1cioo5T@google.com>
In-Reply-To: <aG6aSX0Ws1cioo5T@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 9 Jul 2025 10:13:45 -0700
X-Gm-Features: Ac12FXx3Z1YwO31lxDgkQqNdHK5K-85e1dCmAGHoYPEa7KIWIc5yasWW6lutK9I
Message-ID: <CAP-5=fXJdSyCqBVuo6ampD57LoOvBBDoEHiEaDDXuTL6ve7hiw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] New perf ilist app
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	John Garry <john.g.garry@oracle.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Gautam Menghani <gautam@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 9:35=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hi Ian,
>
> Sorry for the delay.
>
> On Fri, Jun 27, 2025 at 05:09:14PM -0700, Ian Rogers wrote:
> > This patch series builds up to the addition of a new ilist app written
> > in python using textual [1] for the UI. The app presents perf PMUs and
> > events, displays the event information as in `perf list` while at the
> > bottom of the console showing recent activity of the event in total
> > and across all CPUs.
> >
> > The first part of the patches are a few perf and perf python C API
> > fixes, most importantly the counter reading in python supports tool
> > PMUs.
>
> The first part looks ok.  It'd be nice if you can send it separately.

Thanks Namhyung!

I'm working on a longer series to add metrics to the display. Breaking
up this series I have:

Fixes/cleanup:
  perf hwmon_pmu: Avoid shortening hwmon PMU name
  perf parse-events: Minor tidy up of event_type helper
  perf python: In str(evsel) use the evsel__pmu_name helper
  perf python: Fix thread check in pyrf_evsel__read
  perf python: Correct pyrf_evsel__read for tool PMUs

New python PMU/PMUs abstractions:
  perf python: Add basic PMU abstraction and pmus sequence
  perf python: Add function returning dictionary of all events on a PMU

jevents changes and a proper "software" PMU:
  perf jevents: If the long_desc and desc are identical then drop the
    long_desc
  perf jevents: Add common software event json
  perf pmu: Tolerate failure to read the type for wellknown PMUs
  perf parse-events: Remove non-json software events

tracepoint PMU:
  perf tp_pmu: Factor existing tracepoint logic to new file
  perf tp_pmu: Add event APIs
  perf list: Remove tracepoint printing code

ilist app:
  perf ilist: Add new python ilist command

I'll resend the fixes/cleanup to start with.

> >
> > The second part of the patches adds event json for the software PMU
> > and makes the tracepoint PMU support iteration of events and the
> > like. Without these improvements the tracepoint and software PMUs will
> > appear to have no events in the ilist app. As the software PMU moves
> > parsing to json, the legacy hard coded parsing is removed. This has
> > proven controversial for hardware events and so that cleanup isn't
> > done here.
>
> I think it's ok to move hardware events to JSON as well.  Then we can
> probably remove the hard coded parsing code.

A complication here is that in the json we have a "Unit" entry that
maps to a named PMU. For "software" the
`/sys/bus/event_source/devices/software` exists, similarly for
tracepoint, but for legacy hardware and hardware cache we may need to
keep the legacy type and not use the PMU type, the naming of the PMU
isn't consistent, etc.

> The tricky part is the hybrid machines.  Would it be possible to define
> common hardware with standard (legacy) encoding and to mark it "weak" or
> overridable by arch-specific events with the same name?

My thought is that eventually things could work like unionfs. The code
looks for a PMU/events in one place, then if that misses look in the
next, etc. This way we could allow users to have a directory where
they define things like events and metrics, expanding perf's
capabilities. We could also compress the event/metric data which may
be able to half the perf binary size (beyond the pretty simple
reuse/offset optimizations jevents.py tries today). With the unionfs
approach there would be a default prioritization of where to look
probably matching:
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
(maybe we need to treat cycles as a special case given ARM). We can
then have a config setting to make the order different. There are two
issues though, the event encoding/description/.. legacy vs
sysfs/json/user encoding and the behavior of
wildcarding/case-sensitivity/.. the non-legacy stuff inherently
supports wildcarding and case insensitivity, but this may surprise
people.

> > The final patch adds the ilist command. To run it you need the updated
> > perf.cpython.so in your PYTHONPATH and then execute the
> > script. Expanding PMUs and then selecting events will cause event
> > informatin to be displayed in the top-right and the counters values to
> > be displayed as sparklines and counts in the bottom half of the
> > screen.
> >
> > Some thoughts on the series:
> >
> >  - The PMU changes will conflict with the addition of the DRM PMU:
> >    https://lore.kernel.org/lkml/20250403202439.57791-1-irogers@google.c=
om/
> >    when these two are merged together ilist will show yet more
> >    counters. It'd be nice if the DRM stuff could land and then I can
> >    rebase these patches.
>
> Yep, it's merged now.  Please rebase the series.

Ack. Thanks!

> >
> >  - The parse-events clean up of the software and tracepoint PMU. The
> >    software PMU hard coding to be legacy first has similar issues and
> >    will conflict with the clean up in:
> >    https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.=
com/
> >    Moving the software work to json means we don't need special parse
> >    events terms for software events, etc. We can just treat things
> >    like regular PMUs with json, etc. I'd much rather we had less
> >    special case logic so that series is best rebased on top of this
> >    work and it should drop the changes for software terms, etc. which
> >    this series removes. Maybe one day the whole event parsing can be
> >    much more regular in how PMUs are treated but there's always
> >    "cycles".
>
> As I said, moving the hardware events would be a solution as long as it
> can handle complexities in hybrid.
>
> >
> >  - Should python libraries have feature tests? How does this get
> >    packaged outside the kernel tree? I think these are open
> >    questions. Clearly textual is kind of a big dependency and we've
> >    largely been moving in the direction of fewer dependencies
> >    recently. Hopefully the app makes it clear why I think this one is
> >    worth carrying. We carry libslang as a dependency and I think
> >    textual clearly far surpasses it.
>
> Hmm.. I think it can be checked at runtime.  And maybe it can ask users
> to install the required packages.

Yeah, rather than:
```
import textual
```
we can do something like:
```
import importlib
try:
  textual =3D importlib.import_module('textual')
except ModuleNotFoundError:
  print("The textual library isn't found. Please install with pip, uv
or your distributions package manager")
  exit(1)
```
I'll add it to the patch with the app in it.

> >  - How to launch? Currently I run tools/perf/python/ilist.py but it
> >    would be much nicer if we could do `perf ilist` much as we do for
> >    perf-archive.sh. There are probably other scripts that should be
> >    perf commands like flamegraph and gecko. It'd be nice to follow up
> >    the series with something to make using these commands easy.
>
> Sounds good.

Thanks,
Ian

> Thanks,
> Namhyung
>
> >
> >  - Additional thoughts were captured on the mailing list:
> >    https://lore.kernel.org/lkml/CAP-5=3DfWC+doaVd5rEMWJXSQi_db_Wu2tyAe5=
Lm6jnQjcwXkF+w@mail.gmail.com/
> >
> > [1] https://textual.textualize.io/
> >
> > v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
> >     displays as expected.
> >
> > v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
> >     keys. No changes in the ground work first 14 patches.
> >
> > v2: In the jevents event description duplication, some minor changes
> >     accidentally missed from v1 meaning that in v1 the descriptions
> >     were still duplicated. Expand the cover letter with some thoughts
> >     on the series.
> >
> > Ian Rogers (15):
> >   perf hwmon_pmu: Avoid shortening hwmon PMU name
> >   perf parse-events: Minor tidy up of event_type helper
> >   perf python: In str(evsel) use the evsel__pmu_name helper
> >   perf python: Fix thread check in pyrf_evsel__read
> >   perf python: Correct pyrf_evsel__read for tool PMUs
> >   perf python: Add basic PMU abstraction and pmus sequence
> >   perf python: Add function returning dictionary of all events on a PMU
> >   perf jevents: If the long_desc and desc are identical then drop the
> >     long_desc
> >   perf jevents: Add common software event json
> >   perf pmu: Tolerate failure to read the type for wellknown PMUs
> >   perf parse-events: Remove non-json software events
> >   perf tp_pmu: Factor existing tracepoint logic to new file
> >   perf tp_pmu: Add event APIs
> >   perf list: Remove tracepoint printing code
> >   perf ilist: Add new python ilist command
> >
> >  tools/perf/builtin-list.c                     |  47 ++-
> >  .../arch/common/common/software.json          |  92 +++++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 266 ++++++++-----
> >  tools/perf/pmu-events/jevents.py              |  18 +-
> >  tools/perf/python/ilist.py                    | 376 ++++++++++++++++++
> >  tools/perf/util/Build                         |   1 +
> >  tools/perf/util/evsel.c                       |  21 +-
> >  tools/perf/util/hwmon_pmu.c                   |   2 +-
> >  tools/perf/util/parse-events.c                | 225 ++++-------
> >  tools/perf/util/parse-events.h                |   3 +-
> >  tools/perf/util/parse-events.l                |  38 +-
> >  tools/perf/util/parse-events.y                |  29 +-
> >  tools/perf/util/pmu.c                         |  44 +-
> >  tools/perf/util/print-events.c                |  95 -----
> >  tools/perf/util/print-events.h                |   1 -
> >  tools/perf/util/python.c                      | 248 +++++++++++-
> >  tools/perf/util/tp_pmu.c                      | 209 ++++++++++
> >  tools/perf/util/tp_pmu.h                      |  19 +
> >  18 files changed, 1282 insertions(+), 452 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/software.j=
son
> >  create mode 100755 tools/perf/python/ilist.py
> >  create mode 100644 tools/perf/util/tp_pmu.c
> >  create mode 100644 tools/perf/util/tp_pmu.h
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
