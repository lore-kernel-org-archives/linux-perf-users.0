Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D42233D88
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 22:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753310064; cv=none; b=IkzvLM58fWMpqigwSDyVAKdaVr1g8PsmWH/9gQqcSgPoE7QioAoSbSQ5BrIqmMPtdEzku9sv1vGG4FpbYY64BTB655bTYc44m0efA+tb3WqTnKprOV16a8Q1yKvrmvSMufGxKGcJ8KZa0rBRme/OoEIG0qLPzDeZkkILTkrg/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753310064; c=relaxed/simple;
	bh=r6PifVZz7UD9+nY64md2LKe75cGwjrnn8bNB+2S/p3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3J0jZTyHTkhyqS4utR8HuJulnOzpMDNMrSABho8kfs3/vUBnQ1jXQjX/Dfk5nweCnXuh3dZ0uSQEbBai5qS8tvpl0RtO9pfVHh+8/l09b0JxEfHUMSW3qNj76UYScCgeLqL9MA1RfCxgo0L08sTe22y876db0YXPA+KvfKWXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQdCLOof; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQdCLOof"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so62995ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 15:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753310059; x=1753914859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfEhOGE8b6PpNPxsvxX1Z/uAzYyyvjTgXK+5W8pOiyU=;
        b=KQdCLOofVPc/HEWwLy0obragpV7yVT2ru+j0nvx6Zfupmn7sPRubZjA1NxtU9Ein/i
         RGmDmGPmZuo7Y92dCouAs6llnkauZCTKj2w87w3PDpgQElQbZoFYjF3yafT/xdwYrFXW
         oct3XzIDwckejMZzib3eOrc+tvq6SbVwRLIBMaG69iRbiB4wqSxGD/eKrUrK66rxQefr
         CLqZUdlMy/Gy35f2TjP0WD6spyWSkvA+Afrn+44mczjjg+9M9CPhNz2gI7m2UP31RPUY
         9YCFRk5rNblFeNd0G24yQWL4acErxt7uuRUs78a+w3IT24XL+oHUDoq03VpRTZ2Ds/Fg
         gOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753310059; x=1753914859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfEhOGE8b6PpNPxsvxX1Z/uAzYyyvjTgXK+5W8pOiyU=;
        b=r5Qx/k3FkHVGBvSq61aip16ZzpxIyMh49T7A8e7CQsOwfstmi7JVBto7wF92lNOxNH
         kBKIj+2VYMaRUfA6PZ58rA9O9zvaM+sRQ4/arFTfS3ttjGp7T2HTJcJ8UYa+RH80DXaQ
         sp1Nr4h7b1Z6C3MyoqzK1qSP2SxRLu7j45PXjZOO3vnwww95qDITnfZVcWZHDoPb37Y1
         Z0j6ykVip/38KYhmS5QXWm8E4+VJXlXsyWqNS1ja5I3OyEZHuNfrjwk7YRHKRso8s9nq
         UO0j5OcOCsMqOb2KPBs/966NB15zEa1H2DxVCjxXTQndudqJFoLEpCqkHidWyGJ/rUTc
         gbLg==
X-Forwarded-Encrypted: i=1; AJvYcCWULYqBjiepTRxFytTiUua/KHCXVOsdVTWfrfp6ZAbixLP/x+d5VMOzdAg+NgtC63LApbCAXc96hBj/bvricw0B@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSKLgeF4fNaYg2RGcVs1h1k30MT8n4r8oBZ2ozn5thlj1ZwBq
	y0bL5PBoTGx3gPXudsMPcdn9954iWIz06kgzAmNfxquQsRmwAI3zg8j1ur3PWEgPbIPjksskf6d
	nHQPr+400WMDqc7LLH+i6yK3FD+UaDZPSPHlnRIlp
X-Gm-Gg: ASbGnctSihcUkv+zUUVhLCSh2LHEXbcl/dMI0aggwAUFCWgi2tRojblWhK/R9h1hg7w
	wvN2B6QAryA5aEkCUSbdtenuF+hjeUGZZRVWLomYkkAwLZpq6bMUijh4QZne9vyMX8alFlcon3I
	AS9EhKPGWb2CubdCAzgps3VSt6/pYyRaHhlzx99Ua+mcqWXUjlVKKE2mqdTiJmT3ambWvu+PFPx
	pS6RpAh0gNtzqc7Al84Tw+PdgJy26hHXG4=
X-Google-Smtp-Source: AGHT+IHkgTNgb1y4pt7rIgVzjM9oHjQ6Zu0mP2ThGeuN7f5S6W3f4KeiYTHfUbPdWSFSMJNZ8VSMIAVVsfXi2wpZ034=
X-Received: by 2002:a05:6e02:18c5:b0:3da:7c33:509c with SMTP id
 e9e14a558f8ab-3e3b739a4e2mr621045ab.11.1753310058749; Wed, 23 Jul 2025
 15:34:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-3-irogers@google.com>
 <aIEo5QLf3YkYJCB_@google.com>
In-Reply-To: <aIEo5QLf3YkYJCB_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 15:34:07 -0700
X-Gm-Features: Ac12FXwHO6F0TvgYqnqJ5DePJ0phtvM0yejHYLv1xgus5AjPc57R8CpGA_ZJzP4
Message-ID: <CAP-5=fXMs=_s5zJWy1nNNX6oy8nHxNtt13ex5sppK-VPN3zoqQ@mail.gmail.com>
Subject: Re: [PATCH v7 02/16] perf jevents: Add common software event json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Gautam Menghani <gautam@linux.ibm.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:24=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Jul 14, 2025 at 09:43:50AM -0700, Ian Rogers wrote:
> > Add json for software events so that in perf list the events can have
> > a description.  Common json exists for the tool PMU but it has no
> > sysfs equivalent. Modify the map_for_pmu code to return the common map
> > (rather than an architecture specific one) when a PMU with a common
> > name is being looked for, this allows the events to be found.
>
> Can you please share new output of `perf list sw`?  I'm glad we have
> description for software events.  But I'm also curious what's the side
> effect of having them in JSON - maybe case insensitivity?

The old software event names were matched in the lex code and were
case sensitive. The events in the json are case insensitive and the
case insensitive lex ones are removed in the next patch.

The perf list output looks like:

Before:
```
List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
```

After:
```
List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
  alignment-faults                                   [Software event]
  bpf-output                                         [Software event]
  cgroup-switches                                    [Software event]
  context-switches OR cs                             [Software event]
  cpu-clock                                          [Software event]
  cpu-migrations OR migrations                       [Software event]
  dummy                                              [Software event]
  emulation-faults                                   [Software event]
  major-faults                                       [Software event]
  minor-faults                                       [Software event]
  page-faults OR faults                              [Software event]
  task-clock                                         [Software event]
...
software:
  alignment-faults
       [Number of kernel handled memory alignment faults. Unit: software]
  bpf-output
       [An event used by BPF programs to write to the perf ring
buffer. Unit: software]
  cgroup-switches
       [Number of context switches to a task in a different cgroup.
Unit: software]
  context-switches
       [Number of context switches [This event is an alias of cs].
Unit: software]
  cpu-clock
       [Per-CPU high-resolution timer based event. Unit: software]
  cpu-migrations
       [Number of times a process has migrated to a new CPU [This
event is an alias of migrations]. Unit: software]
  cs
       [Number of context switches [This event is an alias of
context-switches]. Unit: software]
  dummy
       [A placeholder event that doesn't count anything. Unit: software]
  emulation-faults
       [Number of kernel handled unimplemented instruction faults
handled through emulation. Unit: software]
  faults
       [Number of page faults [This event is an alias of page-faults].
Unit: software]
  major-faults
       [Number of major page faults. Major faults require I/O to
handle. Unit: software]
  migrations
       [Number of times a process has migrated to a new CPU [This
event is an alias of cpu-migrations]. Unit: software]
  minor-faults
       [Number of minor page faults. Minor faults don't require I/O to
handle. Unit: software]
  page-faults
       [Number of page faults [This event is an alias of faults].
Unit: software]
  task-clock
       [Task based high-resolution timer based event. Unit: software]
...
```
The next patch will make this just:
```
List of pre-defined events (to be used in -e or -M):

  branch-instructions OR branches                    [Hardware event]
  branch-misses                                      [Hardware event]
  bus-cycles                                         [Hardware event]
  cache-misses                                       [Hardware event]
  cache-references                                   [Hardware event]
  cpu-cycles OR cycles                               [Hardware event]
  instructions                                       [Hardware event]
  ref-cycles                                         [Hardware event]
...
software:
  alignment-faults
       [Number of kernel handled memory alignment faults. Unit: software]
  bpf-output
       [An event used by BPF programs to write to the perf ring
buffer. Unit: software]
  cgroup-switches
       [Number of context switches to a task in a different cgroup.
Unit: software]
  context-switches
       [Number of context switches [This event is an alias of cs].
Unit: software]
  cpu-clock
       [Per-CPU high-resolution timer based event. Unit: software]
  cpu-migrations
       [Number of times a process has migrated to a new CPU [This
event is an alias of migrations]. Unit: software]
  cs
       [Number of context switches [This event is an alias of
context-switches]. Unit: software]
  dummy
       [A placeholder event that doesn't count anything. Unit: software]
  emulation-faults
       [Number of kernel handled unimplemented instruction faults
handled through emulation. Unit: software]
  faults
       [Number of page faults [This event is an alias of page-faults].
Unit: software]
  major-faults
       [Number of major page faults. Major faults require I/O to
handle. Unit: software]
  migrations
       [Number of times a process has migrated to a new CPU [This
event is an alias of cpu-migrations]. Unit: software]
  minor-faults
       [Number of minor page faults. Minor faults don't require I/O to
handle. Unit: software]
  page-faults
       [Number of page faults [This event is an alias of faults].
Unit: software]
  task-clock
       [Task based high-resolution timer based event. Unit: software]
...
```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/common/common/software.json          |  92 ++++++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++++++++-------
> >  tools/perf/pmu-events/jevents.py              |  15 +-
> >  3 files changed, 264 insertions(+), 109 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/software.j=
son
> >
> > diff --git a/tools/perf/pmu-events/arch/common/common/software.json b/t=
ools/perf/pmu-events/arch/common/common/software.json
> > new file mode 100644
> > index 000000000000..3af2f565a601
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/common/common/software.json
> > @@ -0,0 +1,92 @@
> > +[
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "cpu-clock",
> > +    "BriefDescription": "Per-CPU high-resolution timer based event",
> > +    "ConfigCode": "0"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "task-clock",
> > +    "BriefDescription": "Task based high-resolution timer based event"=
,
>
> s/Task based/Per-task/ ?

Will fix it in the next version.

>
> > +    "ConfigCode": "1"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "faults",
> > +    "BriefDescription": "Number of page faults [This event is an alias=
 of page-faults]",
> > +    "ConfigCode": "2"
>
> It'd be nice if it can handle aliases without adding a new entry.  But I
> guess it requires non-trivial changes.

It is a limitation of the perf json format. There's no reason not to
add some notion of aliases, I believe it was done this way inheriting
from how Intel did it.

Thanks,
Ian

> Thanks,
> Namhyung
>
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "page-faults",
> > +    "BriefDescription": "Number of page faults [This event is an alias=
 of faults]",
> > +    "ConfigCode": "2"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "context-switches",
> > +    "BriefDescription": "Number of context switches [This event is an =
alias of cs]",
> > +    "ConfigCode": "3"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "cs",
> > +    "BriefDescription": "Number of context switches [This event is an =
alias of context-switches]",
> > +    "ConfigCode": "3"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "cpu-migrations",
> > +    "BriefDescription": "Number of times a process has migrated to a n=
ew CPU [This event is an alias of migrations]",
> > +    "ConfigCode": "4"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "migrations",
> > +    "BriefDescription": "Number of times a process has migrated to a n=
ew CPU [This event is an alias of cpu-migrations]",
> > +    "ConfigCode": "4"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "minor-faults",
> > +    "BriefDescription": "Number of minor page faults. Minor faults don=
't require I/O to handle",
> > +    "ConfigCode": "5"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "major-faults",
> > +    "BriefDescription": "Number of major page faults. Major faults req=
uire I/O to handle",
> > +    "ConfigCode": "6"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "alignment-faults",
> > +    "BriefDescription": "Number of kernel handled memory alignment fau=
lts",
> > +    "ConfigCode": "7"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "emulation-faults",
> > +    "BriefDescription": "Number of kernel handled unimplemented instru=
ction faults handled through emulation",
> > +    "ConfigCode": "8"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "dummy",
> > +    "BriefDescription": "A placeholder event that doesn't count anythi=
ng",
> > +    "ConfigCode": "9"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "bpf-output",
> > +    "BriefDescription": "An event used by BPF programs to write to the=
 perf ring buffer",
> > +    "ConfigCode": "10"
> > +  },
> > +  {
> > +    "Unit": "software",
> > +    "EventName": "cgroup-switches",
> > +    "BriefDescription": "Number of context switches to a task in a dif=
ferent cgroup",
> > +    "ConfigCode": "11"
> > +  }
> > +]
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-=
events/empty-pmu-events.c
> > index a4569a74db07..7d179d703ab1 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -19,109 +19,147 @@ struct pmu_table_entry {
> >  };
> >
> >  static const char *const big_c_string =3D
> > -/* offset=3D0 */ "tool\000"
> > -/* offset=3D5 */ "duration_time\000tool\000Wall clock interval time in=
 nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> > -/* offset=3D81 */ "user_time\000tool\000User (non-kernel) time in nano=
seconds\000config=3D2\000\00000\000\000\000\000\000"
> > -/* offset=3D151 */ "system_time\000tool\000System/kernel time in nanos=
econds\000config=3D3\000\00000\000\000\000\000\000"
> > -/* offset=3D219 */ "has_pmem\000tool\0001 if persistent memory install=
ed otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> > -/* offset=3D295 */ "num_cores\000tool\000Number of cores. A core consi=
sts of 1 or more thread, with each thread being associated with a logical L=
inux CPU\000config=3D5\000\00000\000\000\000\000\000"
> > -/* offset=3D440 */ "num_cpus\000tool\000Number of logical Linux CPUs. =
There may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\0=
00\000\000"
> > -/* offset=3D543 */ "num_cpus_online\000tool\000Number of online logica=
l Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\0=
0000\000\000\000\000\000"
> > -/* offset=3D660 */ "num_dies\000tool\000Number of dies. Each die has 1=
 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> > -/* offset=3D736 */ "num_packages\000tool\000Number of packages. Each p=
ackage has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> > -/* offset=3D822 */ "slots\000tool\000Number of functional units that i=
n parallel can execute parts of an instruction\000config=3D0xa\000\00000\00=
0\000\000\000\000"
> > -/* offset=3D932 */ "smt_on\000tool\0001 if simultaneous multithreading=
 (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\0=
00\000\000\000"
> > -/* offset=3D1039 */ "system_tsc_freq\000tool\000The amount a Time Stam=
p Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\=
000\000"
> > -/* offset=3D1138 */ "default_core\000"
> > -/* offset=3D1151 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\=
000event=3D0x8a\000\00000\000\000\000\000\000"
> > -/* offset=3D1213 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\=
000event=3D0x8b\000\00000\000\000\000\000\000"
> > -/* offset=3D1275 */ "l3_cache_rd\000cache\000L3 cache access, read\000=
event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, re=
ad\000"
> > -/* offset=3D1373 */ "segment_reg_loads.any\000other\000Number of segme=
nt register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\0=
00\000\000\000"
> > -/* offset=3D1475 */ "dispatch_blocked.any\000other\000Memory cluster s=
ignals to block micro-op dispatch for any reason\000event=3D9,period=3D2000=
00,umask=3D0x20\000\00000\000\000\000\000\000"
> > -/* offset=3D1608 */ "eist_trans\000other\000Number of Enhanced Intel S=
peedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\0=
00\00000\000\000\000\000\000"
> > -/* offset=3D1726 */ "hisi_sccl,ddrc\000"
> > -/* offset=3D1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC writ=
e commands\000event=3D2\000\00000\000\000\000\000\000"
> > -/* offset=3D1811 */ "uncore_cbox\000"
> > -/* offset=3D1823 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000=
A cross-core snoop resulted from L3 Eviction which misses in some processor=
 core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> > -/* offset=3D1977 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
> > -/* offset=3D2031 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000e=
vent=3D0xc0\000\00000\000\000\000\000\000"
> > -/* offset=3D2089 */ "hisi_sccl,l3c\000"
> > -/* offset=3D2103 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total r=
ead hits\000event=3D7\000\00000\000\000\000\000\000"
> > -/* offset=3D2171 */ "uncore_imc_free_running\000"
> > -/* offset=3D2195 */ "uncore_imc_free_running.cache_miss\000uncore\000T=
otal cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> > -/* offset=3D2275 */ "uncore_imc\000"
> > -/* offset=3D2286 */ "uncore_imc.cache_hits\000uncore\000Total cache hi=
ts\000event=3D0x34\000\00000\000\000\000\000\000"
> > -/* offset=3D2351 */ "uncore_sys_ddr_pmu\000"
> > -/* offset=3D2370 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-c=
ycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> > -/* offset=3D2446 */ "uncore_sys_ccn_pmu\000"
> > -/* offset=3D2465 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cyc=
les event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> > -/* offset=3D2542 */ "uncore_sys_cmn_pmu\000"
> > -/* offset=3D2561 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts to=
tal cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> > -/* offset=3D2704 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
000"
> > -/* offset=3D2726 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\00000"
> > -/* offset=3D2789 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> > -/* offset=3D2955 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3019 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3086 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3157 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
"
> > -/* offset=3D3251 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3385 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3449 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3517 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > -/* offset=3D3587 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
000"
> > -/* offset=3D3609 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
000"
> > -/* offset=3D3631 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
0"
> > -/* offset=3D3651 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\00000"
> > +/* offset=3D0 */ "software\000"
> > +/* offset=3D9 */ "cpu-clock\000software\000Per-CPU high-resolution tim=
er based event\000config=3D0\000\00000\000\000\000\000\000"
> > +/* offset=3D87 */ "task-clock\000software\000Task based high-resolutio=
n timer based event\000config=3D1\000\00000\000\000\000\000\000"
> > +/* offset=3D169 */ "faults\000software\000Number of page faults [This =
event is an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\0=
00"
> > +/* offset=3D264 */ "page-faults\000software\000Number of page faults [=
This event is an alias of faults]\000config=3D2\000\00000\000\000\000\000\0=
00"
> > +/* offset=3D359 */ "context-switches\000software\000Number of context =
switches [This event is an alias of cs]\000config=3D3\000\00000\000\000\000=
\000\000"
> > +/* offset=3D460 */ "cs\000software\000Number of context switches [This=
 event is an alias of context-switches]\000config=3D3\000\00000\000\000\000=
\000\000"
> > +/* offset=3D561 */ "cpu-migrations\000software\000Number of times a pr=
ocess has migrated to a new CPU [This event is an alias of migrations]\000c=
onfig=3D4\000\00000\000\000\000\000\000"
> > +/* offset=3D693 */ "migrations\000software\000Number of times a proces=
s has migrated to a new CPU [This event is an alias of cpu-migrations]\000c=
onfig=3D4\000\00000\000\000\000\000\000"
> > +/* offset=3D825 */ "minor-faults\000software\000Number of minor page f=
aults. Minor faults don't require I/O to handle\000config=3D5\000\00000\000=
\000\000\000\000"
> > +/* offset=3D934 */ "major-faults\000software\000Number of major page f=
aults. Major faults require I/O to handle\000config=3D6\000\00000\000\000\0=
00\000\000"
> > +/* offset=3D1037 */ "alignment-faults\000software\000Number of kernel =
handled memory alignment faults\000config=3D7\000\00000\000\000\000\000\000=
"
> > +/* offset=3D1129 */ "emulation-faults\000software\000Number of kernel =
handled unimplemented instruction faults handled through emulation\000confi=
g=3D8\000\00000\000\000\000\000\000"
> > +/* offset=3D1256 */ "dummy\000software\000A placeholder event that doe=
sn't count anything\000config=3D9\000\00000\000\000\000\000\000"
> > +/* offset=3D1336 */ "bpf-output\000software\000An event used by BPF pr=
ograms to write to the perf ring buffer\000config=3D0xa\000\00000\000\000\0=
00\000\000"
> > +/* offset=3D1438 */ "cgroup-switches\000software\000Number of context =
switches to a task in a different cgroup\000config=3D0xb\000\00000\000\000\=
000\000\000"
> > +/* offset=3D1541 */ "tool\000"
> > +/* offset=3D1546 */ "duration_time\000tool\000Wall clock interval time=
 in nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> > +/* offset=3D1622 */ "user_time\000tool\000User (non-kernel) time in na=
noseconds\000config=3D2\000\00000\000\000\000\000\000"
> > +/* offset=3D1692 */ "system_time\000tool\000System/kernel time in nano=
seconds\000config=3D3\000\00000\000\000\000\000\000"
> > +/* offset=3D1760 */ "has_pmem\000tool\0001 if persistent memory instal=
led otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> > +/* offset=3D1836 */ "num_cores\000tool\000Number of cores. A core cons=
ists of 1 or more thread, with each thread being associated with a logical =
Linux CPU\000config=3D5\000\00000\000\000\000\000\000"
> > +/* offset=3D1981 */ "num_cpus\000tool\000Number of logical Linux CPUs.=
 There may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\=
000\000\000"
> > +/* offset=3D2084 */ "num_cpus_online\000tool\000Number of online logic=
al Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\=
00000\000\000\000\000\000"
> > +/* offset=3D2201 */ "num_dies\000tool\000Number of dies. Each die has =
1 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> > +/* offset=3D2277 */ "num_packages\000tool\000Number of packages. Each =
package has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> > +/* offset=3D2363 */ "slots\000tool\000Number of functional units that =
in parallel can execute parts of an instruction\000config=3D0xa\000\00000\0=
00\000\000\000\000"
> > +/* offset=3D2473 */ "smt_on\000tool\0001 if simultaneous multithreadin=
g (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\=
000\000\000\000"
> > +/* offset=3D2580 */ "system_tsc_freq\000tool\000The amount a Time Stam=
p Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\=
000\000"
> > +/* offset=3D2679 */ "default_core\000"
> > +/* offset=3D2692 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\=
000event=3D0x8a\000\00000\000\000\000\000\000"
> > +/* offset=3D2754 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\=
000event=3D0x8b\000\00000\000\000\000\000\000"
> > +/* offset=3D2816 */ "l3_cache_rd\000cache\000L3 cache access, read\000=
event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, re=
ad\000"
> > +/* offset=3D2914 */ "segment_reg_loads.any\000other\000Number of segme=
nt register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\0=
00\000\000\000"
> > +/* offset=3D3016 */ "dispatch_blocked.any\000other\000Memory cluster s=
ignals to block micro-op dispatch for any reason\000event=3D9,period=3D2000=
00,umask=3D0x20\000\00000\000\000\000\000\000"
> > +/* offset=3D3149 */ "eist_trans\000other\000Number of Enhanced Intel S=
peedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\0=
00\00000\000\000\000\000\000"
> > +/* offset=3D3267 */ "hisi_sccl,ddrc\000"
> > +/* offset=3D3282 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC writ=
e commands\000event=3D2\000\00000\000\000\000\000\000"
> > +/* offset=3D3352 */ "uncore_cbox\000"
> > +/* offset=3D3364 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000=
A cross-core snoop resulted from L3 Eviction which misses in some processor=
 core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> > +/* offset=3D3518 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
> > +/* offset=3D3572 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000e=
vent=3D0xc0\000\00000\000\000\000\000\000"
> > +/* offset=3D3630 */ "hisi_sccl,l3c\000"
> > +/* offset=3D3644 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total r=
ead hits\000event=3D7\000\00000\000\000\000\000\000"
> > +/* offset=3D3712 */ "uncore_imc_free_running\000"
> > +/* offset=3D3736 */ "uncore_imc_free_running.cache_miss\000uncore\000T=
otal cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> > +/* offset=3D3816 */ "uncore_imc\000"
> > +/* offset=3D3827 */ "uncore_imc.cache_hits\000uncore\000Total cache hi=
ts\000event=3D0x34\000\00000\000\000\000\000\000"
> > +/* offset=3D3892 */ "uncore_sys_ddr_pmu\000"
> > +/* offset=3D3911 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-c=
ycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> > +/* offset=3D3987 */ "uncore_sys_ccn_pmu\000"
> > +/* offset=3D4006 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cyc=
les event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> > +/* offset=3D4083 */ "uncore_sys_cmn_pmu\000"
> > +/* offset=3D4102 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts to=
tal cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> > +/* offset=3D4245 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D4267 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4330 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4496 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4560 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4627 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4698 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
"
> > +/* offset=3D4792 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4926 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D4990 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D5058 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D5128 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D5150 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D5172 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
0"
> > +/* offset=3D5192 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\00000"
> >  ;
> >
> > +static const struct compact_pmu_event pmu_events__common_software[] =
=3D {
> > +{ 1037 }, /* alignment-faults\000software\000Number of kernel handled =
memory alignment faults\000config=3D7\000\00000\000\000\000\000\000 */
> > +{ 1336 }, /* bpf-output\000software\000An event used by BPF programs t=
o write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000\000\0=
00 */
> > +{ 1438 }, /* cgroup-switches\000software\000Number of context switches=
 to a task in a different cgroup\000config=3D0xb\000\00000\000\000\000\000\=
000 */
> > +{ 359 }, /* context-switches\000software\000Number of context switches=
 [This event is an alias of cs]\000config=3D3\000\00000\000\000\000\000\000=
 */
> > +{ 9 }, /* cpu-clock\000software\000Per-CPU high-resolution timer based=
 event\000config=3D0\000\00000\000\000\000\000\000 */
> > +{ 561 }, /* cpu-migrations\000software\000Number of times a process ha=
s migrated to a new CPU [This event is an alias of migrations]\000config=3D=
4\000\00000\000\000\000\000\000 */
> > +{ 460 }, /* cs\000software\000Number of context switches [This event i=
s an alias of context-switches]\000config=3D3\000\00000\000\000\000\000\000=
 */
> > +{ 1256 }, /* dummy\000software\000A placeholder event that doesn't cou=
nt anything\000config=3D9\000\00000\000\000\000\000\000 */
> > +{ 1129 }, /* emulation-faults\000software\000Number of kernel handled =
unimplemented instruction faults handled through emulation\000config=3D8\00=
0\00000\000\000\000\000\000 */
> > +{ 169 }, /* faults\000software\000Number of page faults [This event is=
 an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\000 */
> > +{ 934 }, /* major-faults\000software\000Number of major page faults. M=
ajor faults require I/O to handle\000config=3D6\000\00000\000\000\000\000\0=
00 */
> > +{ 693 }, /* migrations\000software\000Number of times a process has mi=
grated to a new CPU [This event is an alias of cpu-migrations]\000config=3D=
4\000\00000\000\000\000\000\000 */
> > +{ 825 }, /* minor-faults\000software\000Number of minor page faults. M=
inor faults don't require I/O to handle\000config=3D5\000\00000\000\000\000=
\000\000 */
> > +{ 264 }, /* page-faults\000software\000Number of page faults [This eve=
nt is an alias of faults]\000config=3D2\000\00000\000\000\000\000\000 */
> > +{ 87 }, /* task-clock\000software\000Task based high-resolution timer =
based event\000config=3D1\000\00000\000\000\000\000\000 */
> > +};
> >  static const struct compact_pmu_event pmu_events__common_tool[] =3D {
> > -{ 5 }, /* duration_time\000tool\000Wall clock interval time in nanosec=
onds\000config=3D1\000\00000\000\000\000\000\000 */
> > -{ 219 }, /* has_pmem\000tool\0001 if persistent memory installed other=
wise 0\000config=3D4\000\00000\000\000\000\000\000 */
> > -{ 295 }, /* num_cores\000tool\000Number of cores. A core consists of 1=
 or more thread, with each thread being associated with a logical Linux CPU=
\000config=3D5\000\00000\000\000\000\000\000 */
> > -{ 440 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There ma=
y be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\0=
00 */
> > -{ 543 }, /* num_cpus_online\000tool\000Number of online logical Linux =
CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\000=
\000\000\000\000 */
> > -{ 660 }, /* num_dies\000tool\000Number of dies. Each die has 1 or more=
 cores\000config=3D8\000\00000\000\000\000\000\000 */
> > -{ 736 }, /* num_packages\000tool\000Number of packages. Each package h=
as 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> > -{ 822 }, /* slots\000tool\000Number of functional units that in parall=
el can execute parts of an instruction\000config=3D0xa\000\00000\000\000\00=
0\000\000 */
> > -{ 932 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka hy=
perthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\0=
00\000 */
> > -{ 151 }, /* system_time\000tool\000System/kernel time in nanoseconds\0=
00config=3D3\000\00000\000\000\000\000\000 */
> > -{ 1039 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counte=
r (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 =
*/
> > -{ 81 }, /* user_time\000tool\000User (non-kernel) time in nanoseconds\=
000config=3D2\000\00000\000\000\000\000\000 */
> > +{ 1546 }, /* duration_time\000tool\000Wall clock interval time in nano=
seconds\000config=3D1\000\00000\000\000\000\000\000 */
> > +{ 1760 }, /* has_pmem\000tool\0001 if persistent memory installed othe=
rwise 0\000config=3D4\000\00000\000\000\000\000\000 */
> > +{ 1836 }, /* num_cores\000tool\000Number of cores. A core consists of =
1 or more thread, with each thread being associated with a logical Linux CP=
U\000config=3D5\000\00000\000\000\000\000\000 */
> > +{ 1981 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There m=
ay be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\=
000 */
> > +{ 2084 }, /* num_cpus_online\000tool\000Number of online logical Linux=
 CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\00=
0\000\000\000\000 */
> > +{ 2201 }, /* num_dies\000tool\000Number of dies. Each die has 1 or mor=
e cores\000config=3D8\000\00000\000\000\000\000\000 */
> > +{ 2277 }, /* num_packages\000tool\000Number of packages. Each package =
has 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> > +{ 2363 }, /* slots\000tool\000Number of functional units that in paral=
lel can execute parts of an instruction\000config=3D0xa\000\00000\000\000\0=
00\000\000 */
> > +{ 2473 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka h=
yperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\=
000\000 */
> > +{ 1692 }, /* system_time\000tool\000System/kernel time in nanoseconds\=
000config=3D3\000\00000\000\000\000\000\000 */
> > +{ 2580 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counte=
r (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 =
*/
> > +{ 1622 }, /* user_time\000tool\000User (non-kernel) time in nanosecond=
s\000config=3D2\000\00000\000\000\000\000\000 */
> >
> >  };
> >
> >  const struct pmu_table_entry pmu_events__common[] =3D {
> > +{
> > +     .entries =3D pmu_events__common_software,
> > +     .num_entries =3D ARRAY_SIZE(pmu_events__common_software),
> > +     .pmu_name =3D { 0 /* software\000 */ },
> > +},
> >  {
> >       .entries =3D pmu_events__common_tool,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
> > -     .pmu_name =3D { 0 /* tool\000 */ },
> > +     .pmu_name =3D { 1541 /* tool\000 */ },
> >  },
> >  };
> >
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_default=
_core[] =3D {
> > -{ 1151 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
> > -{ 1213 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
> > -{ 1475 }, /* dispatch_blocked.any\000other\000Memory cluster signals t=
o block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
> > -{ 1608 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep=
(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000=
\000\000\000\000\000 */
> > -{ 1275 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D=
0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 *=
/
> > -{ 1373 }, /* segment_reg_loads.any\000other\000Number of segment regis=
ter loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\0=
00\000 */
> > +{ 2692 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
> > +{ 2754 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
> > +{ 3016 }, /* dispatch_blocked.any\000other\000Memory cluster signals t=
o block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
> > +{ 3149 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep=
(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000=
\000\000\000\000\000 */
> > +{ 2816 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D=
0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 *=
/
> > +{ 2914 }, /* segment_reg_loads.any\000other\000Number of segment regis=
ter loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\0=
00\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sc=
cl_ddrc[] =3D {
> > -{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write comman=
ds\000event=3D2\000\00000\000\000\000\000\000 */
> > +{ 3282 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write comman=
ds\000event=3D2\000\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sc=
cl_l3c[] =3D {
> > -{ 2103 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits=
\000event=3D7\000\00000\000\000\000\000\000 */
> > +{ 3644 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits=
\000event=3D7\000\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
cbox[] =3D {
> > -{ 1977 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\=
000\00000\000\000\000\000\000 */
> > -{ 2031 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0=
xc0\000\00000\000\000\000\000\000 */
> > -{ 1823 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-=
core snoop resulted from L3 Eviction which misses in some processor core\00=
0event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
> > +{ 3518 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\=
000\00000\000\000\000\000\000 */
> > +{ 3572 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0=
xc0\000\00000\000\000\000\000\000 */
> > +{ 3364 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-=
core snoop resulted from L3 Eviction which misses in some processor core\00=
0event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
imc[] =3D {
> > -{ 2286 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000ev=
ent=3D0x34\000\00000\000\000\000\000\000 */
> > +{ 3827 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000ev=
ent=3D0x34\000\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_=
imc_free_running[] =3D {
> > -{ 2195 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cac=
he misses\000event=3D0x12\000\00000\000\000\000\000\000 */
> > +{ 3736 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cac=
he misses\000event=3D0x12\000\00000\000\000\000\000\000 */
> >
> >  };
> >
> > @@ -129,51 +167,51 @@ const struct pmu_table_entry pmu_events__test_soc=
_cpu[] =3D {
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_default_core,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_core=
),
> > -     .pmu_name =3D { 1138 /* default_core\000 */ },
> > +     .pmu_name =3D { 2679 /* default_core\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_dd=
rc),
> > -     .pmu_name =3D { 1726 /* hisi_sccl,ddrc\000 */ },
> > +     .pmu_name =3D { 3267 /* hisi_sccl,ddrc\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3=
c),
> > -     .pmu_name =3D { 2089 /* hisi_sccl,l3c\000 */ },
> > +     .pmu_name =3D { 3630 /* hisi_sccl,l3c\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox)=
,
> > -     .pmu_name =3D { 1811 /* uncore_cbox\000 */ },
> > +     .pmu_name =3D { 3352 /* uncore_cbox\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_uncore_imc,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
> > -     .pmu_name =3D { 2275 /* uncore_imc\000 */ },
> > +     .pmu_name =3D { 3816 /* uncore_imc\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_f=
ree_running),
> > -     .pmu_name =3D { 2171 /* uncore_imc_free_running\000 */ },
> > +     .pmu_name =3D { 3712 /* uncore_imc_free_running\000 */ },
> >  },
> >  };
> >
> >  static const struct compact_pmu_event pmu_metrics__test_soc_cpu_defaul=
t_core[] =3D {
> > -{ 2704 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> > -{ 3385 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\00000 */
> > -{ 3157 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > -{ 3251 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\00000 */
> > -{ 3449 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
> > -{ 3517 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> > -{ 2789 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > -{ 2726 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\00000 */
> > -{ 3651 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\00000 */
> > -{ 3587 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> > -{ 3609 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> > -{ 3631 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > -{ 3086 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> > -{ 2955 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> > -{ 3019 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
> > +{ 4245 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> > +{ 4926 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\00000 */
> > +{ 4698 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > +{ 4792 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\00000 */
> > +{ 4990 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 5058 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 4330 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > +{ 4267 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\00000 */
> > +{ 5192 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\00000 */
> > +{ 5128 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> > +{ 5150 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> > +{ 5172 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > +{ 4627 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> > +{ 4496 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> > +{ 4560 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
> >
> >  };
> >
> > @@ -181,18 +219,18 @@ const struct pmu_table_entry pmu_metrics__test_so=
c_cpu[] =3D {
> >  {
> >       .entries =3D pmu_metrics__test_soc_cpu_default_core,
> >       .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default_cor=
e),
> > -     .pmu_name =3D { 1138 /* default_core\000 */ },
> > +     .pmu_name =3D { 2679 /* default_core\000 */ },
> >  },
> >  };
> >
> >  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_ccn_pmu[] =3D {
> > -{ 2465 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles even=
t\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
> > +{ 4006 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles even=
t\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_cmn_pmu[] =3D {
> > -{ 2561 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cach=
e misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000=
(434|436|43c|43a).*\00000\000\000\000\000\000 */
> > +{ 4102 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cach=
e misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000=
(434|436|43c|43a).*\00000\000\000\000\000\000 */
> >  };
> >  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_=
sys_ddr_pmu[] =3D {
> > -{ 2370 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles ev=
ent\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
> > +{ 3911 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles ev=
ent\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
> >
> >  };
> >
> > @@ -200,17 +238,17 @@ const struct pmu_table_entry pmu_events__test_soc=
_sys[] =3D {
> >  {
> >       .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_c=
cn_pmu),
> > -     .pmu_name =3D { 2446 /* uncore_sys_ccn_pmu\000 */ },
> > +     .pmu_name =3D { 3987 /* uncore_sys_ccn_pmu\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_c=
mn_pmu),
> > -     .pmu_name =3D { 2542 /* uncore_sys_cmn_pmu\000 */ },
> > +     .pmu_name =3D { 4083 /* uncore_sys_cmn_pmu\000 */ },
> >  },
> >  {
> >       .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
> >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_d=
dr_pmu),
> > -     .pmu_name =3D { 2351 /* uncore_sys_ddr_pmu\000 */ },
> > +     .pmu_name =3D { 3892 /* uncore_sys_ddr_pmu\000 */ },
> >  },
> >  };
> >
> > @@ -632,8 +670,20 @@ static const struct pmu_events_map *map_for_pmu(st=
ruct perf_pmu *pmu)
> >  {
> >          struct perf_cpu cpu =3D {-1};
> >
> > -        if (pmu)
> > +        if (pmu) {
> > +                for (size_t i=3D0; i < ARRAY_SIZE(pmu_events__common);=
 i++) {
> > +                        const char *pmu_name =3D &big_c_string[pmu_eve=
nts__common[i].pmu_name.offset];
> > +
> > +                        if (!strcmp(pmu_name, pmu->name)) {
> > +                                const struct pmu_events_map *map =3D &=
pmu_events_map[0];
> > +
> > +                                while (strcmp("common", map->arch))
> > +                                        map++;
> > +                                return map;
> > +                        }
> > +                }
> >                  cpu =3D perf_cpu_map__min(pmu->cpus);
> > +        }
> >          return map_for_cpu(cpu);
> >  }
> >
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index e821155151ec..76c1e7b0bc22 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -295,6 +295,7 @@ class JsonEvent:
> >            'cpu_atom': 'cpu_atom',
> >            'ali_drw': 'ali_drw',
> >            'arm_cmn': 'arm_cmn',
> > +          'software': 'software',
> >            'tool': 'tool',
> >        }
> >        return table[unit] if unit in table else f'uncore_{unit.lower()}=
'
> > @@ -1158,8 +1159,20 @@ static const struct pmu_events_map *map_for_pmu(=
struct perf_pmu *pmu)
> >  {
> >          struct perf_cpu cpu =3D {-1};
> >
> > -        if (pmu)
> > +        if (pmu) {
> > +                for (size_t i=3D0; i < ARRAY_SIZE(pmu_events__common);=
 i++) {
> > +                        const char *pmu_name =3D &big_c_string[pmu_eve=
nts__common[i].pmu_name.offset];
> > +
> > +                        if (!strcmp(pmu_name, pmu->name)) {
> > +                                const struct pmu_events_map *map =3D &=
pmu_events_map[0];
> > +
> > +                                while (strcmp("common", map->arch))
> > +                                        map++;
> > +                                return map;
> > +                        }
> > +                }
> >                  cpu =3D perf_cpu_map__min(pmu->cpus);
> > +        }
> >          return map_for_cpu(cpu);
> >  }
> >
> > --
> > 2.50.0.727.gbf7dc18ff4-goog
> >
