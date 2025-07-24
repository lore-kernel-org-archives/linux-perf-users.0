Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330086331
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Jul 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321675; cv=none; b=aS9zMC7choqW7bKemSoLydXC9hn8T66hZAtr5EVYtvhRlqZ0b+uX4jg9qIvDH8kHcyFoI++i4Wj72wfLYe+i8bN8jHOeL6tAvKRSjKORagOupsoZYWj6/8rLj+TA6E1nbqsVCqe7u0r4tqbup2dbvwOSQ/L9ag1r5X6mqksdXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321675; c=relaxed/simple;
	bh=WdfeBH0CyRsv2qKSl0FDb/8Rbqp7caWhJlYp9MgTtfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkXLnATLpFdGIMsATRLgmG/9Sqey7nAjMMaR/7v/2VMUfA3XiqER3k2sF13DXuWin8+oMlrHFKCLbvDCmx4u4dlJSInX9uYPgRylOmiPbHJTAVQWukAxvRQpWZI4Vx+UURFwUqnTQJkdNqDlqUNfPemV+Yv71ToBmpIeucU/XH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDou2Jvo; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDou2Jvo"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so86795ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753321671; x=1753926471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHuYNsLR77IwFD97S04fS1I0HRWbU4cWxCUZ3qoKMuw=;
        b=vDou2JvomiTknZ2iVmV2aHW181wJbqZmncTZ4cgLM3fSswNflpeoeL0ZO45tRo5FbM
         8+jBsl+kJviqhqCaPYm74b5iZf4cTk4ePyIhWi0H6TpvVIkPt1hLai3PnobFVKIDziZe
         zpBikj9YRTQcCG8a2Yt1vLUxMkunN+w4LY6liWFi+GCVCFmdMks+6HSTP+P2zUFnJHDc
         R0mrx2KG7RNwwT+4NLobBFIMCY8vtAmscvjQ0mWy87sOnzGiEHTq71kCG2zxD9dzd0d3
         tD0yZwOXaRGtuLSJKD0YeEhDru+fq+UcksdnAuvLFhuw+tgdc059mCMTc9PbGvGx2qNo
         3P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753321671; x=1753926471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHuYNsLR77IwFD97S04fS1I0HRWbU4cWxCUZ3qoKMuw=;
        b=hU5EcBI6R5mtAmJq8ab790V3Si95J9nu6nb/fv6RHLcC7CrFQgBqmZyUtCxa11nIWz
         A8pkvgvXQjay7JkcQEt7NtQN0iJLi9F6xQ9HNqwvZZzDokKGhVsOBAStyDqjp8m//pqV
         k4/tsnxcvg6f+gMir5EnqPmzZxDesjYizCow5DycLjBCLzRzHtdWY+GQPvluAmUL7t6Z
         vhhj+BGnNGUw1pPPIhK43VbEYJDEZdxMxFpX66//WS+VuZJmUM2DHQ3scif63dt7nMS9
         qZ2S5rIpwxYgQVGIoRj1KsMF1numtzsZg/0qEkVr6HZGtz9NblYha+fUm4rfa+dLRJMR
         NDDA==
X-Forwarded-Encrypted: i=1; AJvYcCUsmUjsL2em7IdkHIwJ5wpeYySlywE60GcBpvOryd9ro27ZzPfQsYkKTwF5XLLPSnBdOuH2ZfSX1+J0q3EqawCG@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJ7I0VgPtm4GHFk2xzkXSOZjIUmUZHNNdmn5R71tOc3sKQLjF
	0mHzfC2uGfDeD7TJgkL4wHW5kVgVt+GjJBoXa08ozDBwCniq+2VTJLGySOcp3uPECg0zDGfoGnX
	VuIncYcoSqovy42f+r2kiHxR3wg0cC6o8XjrIIo1P
X-Gm-Gg: ASbGncu7kjgqpGKFJvQ26jBSgCT9uO8Gn1/f2XNh1NXSoiPBvlhZ2iJBUw56Bm/VtY0
	DH1CdXsggY29t45/e7XZRpnw0Wej1khZ4SFQXyW3R0uef+ZFziqtD1Mz6EtI+wO7QgbfNcmH+Us
	6lMksJKLBZszTY6k4/5AGMBMloHtPjychRG1D8yKKCP3P4NZ1POwTyaWjYk/sIAnNG82mxyp5b7
	JqVlRn1
X-Google-Smtp-Source: AGHT+IHEBbqKQgfOBqHtIt8Hu/V9T3SOVaD7o/64RYpGocU8WRP+65I1toipeLOGix88QnMVSdRbwfrnfHpo0vsUrg8=
X-Received: by 2002:a05:6e02:1a6b:b0:3dd:be3e:7b0 with SMTP id
 e9e14a558f8ab-3e3b739d62cmr1286285ab.13.1753321670392; Wed, 23 Jul 2025
 18:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <20250714164405.111477-3-irogers@google.com>
 <aIEo5QLf3YkYJCB_@google.com> <CAP-5=fXMs=_s5zJWy1nNNX6oy8nHxNtt13ex5sppK-VPN3zoqQ@mail.gmail.com>
 <aIF55VVlwNegU095@google.com>
In-Reply-To: <aIF55VVlwNegU095@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 18:47:38 -0700
X-Gm-Features: Ac12FXy234DGEEgVBuvXDEfq0OjiNW9V2iKMo3H_2M7ZQEHGmaJzLhK_4bsLigQ
Message-ID: <CAP-5=fW=7JZ3EQiHZb0tWBqzbO9-Taf7FenGGNjHegfuy1ocNg@mail.gmail.com>
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

On Wed, Jul 23, 2025 at 5:10=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jul 23, 2025 at 03:34:07PM -0700, Ian Rogers wrote:
> > On Wed, Jul 23, 2025 at 11:24=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Mon, Jul 14, 2025 at 09:43:50AM -0700, Ian Rogers wrote:
> > > > Add json for software events so that in perf list the events can ha=
ve
> > > > a description.  Common json exists for the tool PMU but it has no
> > > > sysfs equivalent. Modify the map_for_pmu code to return the common =
map
> > > > (rather than an architecture specific one) when a PMU with a common
> > > > name is being looked for, this allows the events to be found.
> > >
> > > Can you please share new output of `perf list sw`?  I'm glad we have
> > > description for software events.  But I'm also curious what's the sid=
e
> > > effect of having them in JSON - maybe case insensitivity?
> >
> > The old software event names were matched in the lex code and were
> > case sensitive. The events in the json are case insensitive and the
> > case insensitive lex ones are removed in the next patch.
>
> And then it'd also use wildcard match, right?

Yes. So for example, the old behavior would allow:

  $ perf stat -e faults -a sleep 1

this can now be:

  $ perf stat -e software/faults/ -a sleep 1
  $ perf stat -e Faults -a sleep 1
..

and if a PMU has an event named 'faults' then with the wildcarding
both the software PMU faults event and the other PMU's faults event
would be opened and read, sampled, etc. If the event can't be sampled
then this could make `perf record` fail in just the same way as is
fixed in (unmerged):
https://lore.kernel.org/lkml/20250416045117.876775-1-irogers@google.com/
which was particularly problematic on ARM CPUs.

> >
> > The perf list output looks like:
> >
> > Before:
> > ```
> > List of pre-defined events (to be used in -e or -M):
> >
> >   branch-instructions OR branches                    [Hardware event]
> >   branch-misses                                      [Hardware event]
> >   bus-cycles                                         [Hardware event]
> >   cache-misses                                       [Hardware event]
> >   cache-references                                   [Hardware event]
> >   cpu-cycles OR cycles                               [Hardware event]
> >   instructions                                       [Hardware event]
> >   ref-cycles                                         [Hardware event]
> >   alignment-faults                                   [Software event]
> >   bpf-output                                         [Software event]
> >   cgroup-switches                                    [Software event]
> >   context-switches OR cs                             [Software event]
> >   cpu-clock                                          [Software event]
> >   cpu-migrations OR migrations                       [Software event]
> >   dummy                                              [Software event]
> >   emulation-faults                                   [Software event]
> >   major-faults                                       [Software event]
> >   minor-faults                                       [Software event]
> >   page-faults OR faults                              [Software event]
> >   task-clock                                         [Software event]
> > ```
> >
> > After:
> > ```
> > List of pre-defined events (to be used in -e or -M):
> >
> >   branch-instructions OR branches                    [Hardware event]
> >   branch-misses                                      [Hardware event]
> >   bus-cycles                                         [Hardware event]
> >   cache-misses                                       [Hardware event]
> >   cache-references                                   [Hardware event]
> >   cpu-cycles OR cycles                               [Hardware event]
> >   instructions                                       [Hardware event]
> >   ref-cycles                                         [Hardware event]
> >   alignment-faults                                   [Software event]
> >   bpf-output                                         [Software event]
> >   cgroup-switches                                    [Software event]
> >   context-switches OR cs                             [Software event]
> >   cpu-clock                                          [Software event]
> >   cpu-migrations OR migrations                       [Software event]
> >   dummy                                              [Software event]
> >   emulation-faults                                   [Software event]
> >   major-faults                                       [Software event]
> >   minor-faults                                       [Software event]
> >   page-faults OR faults                              [Software event]
> >   task-clock                                         [Software event]
> > ...
> > software:
> >   alignment-faults
> >        [Number of kernel handled memory alignment faults. Unit: softwar=
e]
> >   bpf-output
> >        [An event used by BPF programs to write to the perf ring
> > buffer. Unit: software]
> >   cgroup-switches
> >        [Number of context switches to a task in a different cgroup.
> > Unit: software]
> >   context-switches
> >        [Number of context switches [This event is an alias of cs].
> > Unit: software]
> >   cpu-clock
> >        [Per-CPU high-resolution timer based event. Unit: software]
> >   cpu-migrations
> >        [Number of times a process has migrated to a new CPU [This
> > event is an alias of migrations]. Unit: software]
> >   cs
> >        [Number of context switches [This event is an alias of
> > context-switches]. Unit: software]
> >   dummy
> >        [A placeholder event that doesn't count anything. Unit: software=
]
> >   emulation-faults
> >        [Number of kernel handled unimplemented instruction faults
> > handled through emulation. Unit: software]
> >   faults
> >        [Number of page faults [This event is an alias of page-faults].
> > Unit: software]
> >   major-faults
> >        [Number of major page faults. Major faults require I/O to
> > handle. Unit: software]
> >   migrations
> >        [Number of times a process has migrated to a new CPU [This
> > event is an alias of cpu-migrations]. Unit: software]
> >   minor-faults
> >        [Number of minor page faults. Minor faults don't require I/O to
> > handle. Unit: software]
> >   page-faults
> >        [Number of page faults [This event is an alias of faults].
> > Unit: software]
> >   task-clock
> >        [Task based high-resolution timer based event. Unit: software]
> > ...
> > ```
> > The next patch will make this just:
> > ```
> > List of pre-defined events (to be used in -e or -M):
> >
> >   branch-instructions OR branches                    [Hardware event]
> >   branch-misses                                      [Hardware event]
> >   bus-cycles                                         [Hardware event]
> >   cache-misses                                       [Hardware event]
> >   cache-references                                   [Hardware event]
> >   cpu-cycles OR cycles                               [Hardware event]
> >   instructions                                       [Hardware event]
> >   ref-cycles                                         [Hardware event]
> > ...
> > software:
> >   alignment-faults
> >        [Number of kernel handled memory alignment faults. Unit: softwar=
e]
> >   bpf-output
> >        [An event used by BPF programs to write to the perf ring
> > buffer. Unit: software]
> >   cgroup-switches
> >        [Number of context switches to a task in a different cgroup.
> > Unit: software]
> >   context-switches
> >        [Number of context switches [This event is an alias of cs].
>
> Hmm.. can we just use parentheses for the alias?

We could, I was looking for consistency with what is already done by Intel:
```
$ perf list
...
  l2_request.all
      [All accesses to L2 cache [This event is alias to
L2_RQSTS.REFERENCES]. Unit: cpu_core]
  l2_request.miss
      [Read requests with true-miss in L2 cache. [This event is alias
to L2_RQSTS.MISS]. Unit:
       cpu_core]
...
```
I wouldn't want to modify Intel's convention, we could have 2 conventions. =
Wdyt?


>
> > Unit: software]
> >   cpu-clock
> >        [Per-CPU high-resolution timer based event. Unit: software]
> >   cpu-migrations
> >        [Number of times a process has migrated to a new CPU [This
> > event is an alias of migrations]. Unit: software]
> >   cs
> >        [Number of context switches [This event is an alias of
> > context-switches]. Unit: software]
> >   dummy
> >        [A placeholder event that doesn't count anything. Unit: software=
]
> >   emulation-faults
> >        [Number of kernel handled unimplemented instruction faults
> > handled through emulation. Unit: software]
> >   faults
> >        [Number of page faults [This event is an alias of page-faults].
> > Unit: software]
> >   major-faults
> >        [Number of major page faults. Major faults require I/O to
> > handle. Unit: software]
> >   migrations
> >        [Number of times a process has migrated to a new CPU [This
> > event is an alias of cpu-migrations]. Unit: software]
> >   minor-faults
> >        [Number of minor page faults. Minor faults don't require I/O to
> > handle. Unit: software]
> >   page-faults
> >        [Number of page faults [This event is an alias of faults].
> > Unit: software]
> >   task-clock
> >        [Task based high-resolution timer based event. Unit: software]
> > ...
> > ```
>
> Will `perf list sw` include these output?  And please add this to the
> commit message.

This is in the next patch, basically the PMU name matching glob is
used so that for the "sw" perf list option only the "software" and
"tool" PMUs are displayed.
I can add the output to the next patch (then I don't need to worry
about the half-way state that exists after this patch).

Thanks,
Ian

> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  .../arch/common/common/software.json          |  92 ++++++
> > > >  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++++++++---=
----
> > > >  tools/perf/pmu-events/jevents.py              |  15 +-
> > > >  3 files changed, 264 insertions(+), 109 deletions(-)
> > > >  create mode 100644 tools/perf/pmu-events/arch/common/common/softwa=
re.json
> > > >
> > > > diff --git a/tools/perf/pmu-events/arch/common/common/software.json=
 b/tools/perf/pmu-events/arch/common/common/software.json
> > > > new file mode 100644
> > > > index 000000000000..3af2f565a601
> > > > --- /dev/null
> > > > +++ b/tools/perf/pmu-events/arch/common/common/software.json
> > > > @@ -0,0 +1,92 @@
> > > > +[
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "cpu-clock",
> > > > +    "BriefDescription": "Per-CPU high-resolution timer based event=
",
> > > > +    "ConfigCode": "0"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "task-clock",
> > > > +    "BriefDescription": "Task based high-resolution timer based ev=
ent",
> > >
> > > s/Task based/Per-task/ ?
> >
> > Will fix it in the next version.
> >
> > >
> > > > +    "ConfigCode": "1"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "faults",
> > > > +    "BriefDescription": "Number of page faults [This event is an a=
lias of page-faults]",
> > > > +    "ConfigCode": "2"
> > >
> > > It'd be nice if it can handle aliases without adding a new entry.  Bu=
t I
> > > guess it requires non-trivial changes.
> >
> > It is a limitation of the perf json format. There's no reason not to
> > add some notion of aliases, I believe it was done this way inheriting
> > from how Intel did it.
>
> Ok, I think it's fine for now.
>
> Thanks,
> Namhyung
>
> > >
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "page-faults",
> > > > +    "BriefDescription": "Number of page faults [This event is an a=
lias of faults]",
> > > > +    "ConfigCode": "2"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "context-switches",
> > > > +    "BriefDescription": "Number of context switches [This event is=
 an alias of cs]",
> > > > +    "ConfigCode": "3"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "cs",
> > > > +    "BriefDescription": "Number of context switches [This event is=
 an alias of context-switches]",
> > > > +    "ConfigCode": "3"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "cpu-migrations",
> > > > +    "BriefDescription": "Number of times a process has migrated to=
 a new CPU [This event is an alias of migrations]",
> > > > +    "ConfigCode": "4"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "migrations",
> > > > +    "BriefDescription": "Number of times a process has migrated to=
 a new CPU [This event is an alias of cpu-migrations]",
> > > > +    "ConfigCode": "4"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "minor-faults",
> > > > +    "BriefDescription": "Number of minor page faults. Minor faults=
 don't require I/O to handle",
> > > > +    "ConfigCode": "5"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "major-faults",
> > > > +    "BriefDescription": "Number of major page faults. Major faults=
 require I/O to handle",
> > > > +    "ConfigCode": "6"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "alignment-faults",
> > > > +    "BriefDescription": "Number of kernel handled memory alignment=
 faults",
> > > > +    "ConfigCode": "7"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "emulation-faults",
> > > > +    "BriefDescription": "Number of kernel handled unimplemented in=
struction faults handled through emulation",
> > > > +    "ConfigCode": "8"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "dummy",
> > > > +    "BriefDescription": "A placeholder event that doesn't count an=
ything",
> > > > +    "ConfigCode": "9"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "bpf-output",
> > > > +    "BriefDescription": "An event used by BPF programs to write to=
 the perf ring buffer",
> > > > +    "ConfigCode": "10"
> > > > +  },
> > > > +  {
> > > > +    "Unit": "software",
> > > > +    "EventName": "cgroup-switches",
> > > > +    "BriefDescription": "Number of context switches to a task in a=
 different cgroup",
> > > > +    "ConfigCode": "11"
> > > > +  }
> > > > +]
> > > > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/=
pmu-events/empty-pmu-events.c
> > > > index a4569a74db07..7d179d703ab1 100644
> > > > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > > > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > > > @@ -19,109 +19,147 @@ struct pmu_table_entry {
> > > >  };
> > > >
> > > >  static const char *const big_c_string =3D
> > > > -/* offset=3D0 */ "tool\000"
> > > > -/* offset=3D5 */ "duration_time\000tool\000Wall clock interval tim=
e in nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> > > > -/* offset=3D81 */ "user_time\000tool\000User (non-kernel) time in =
nanoseconds\000config=3D2\000\00000\000\000\000\000\000"
> > > > -/* offset=3D151 */ "system_time\000tool\000System/kernel time in n=
anoseconds\000config=3D3\000\00000\000\000\000\000\000"
> > > > -/* offset=3D219 */ "has_pmem\000tool\0001 if persistent memory ins=
talled otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> > > > -/* offset=3D295 */ "num_cores\000tool\000Number of cores. A core c=
onsists of 1 or more thread, with each thread being associated with a logic=
al Linux CPU\000config=3D5\000\00000\000\000\000\000\000"
> > > > -/* offset=3D440 */ "num_cpus\000tool\000Number of logical Linux CP=
Us. There may be multiple such CPUs on a core\000config=3D6\000\00000\000\0=
00\000\000\000"
> > > > -/* offset=3D543 */ "num_cpus_online\000tool\000Number of online lo=
gical Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\0=
00\00000\000\000\000\000\000"
> > > > -/* offset=3D660 */ "num_dies\000tool\000Number of dies. Each die h=
as 1 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> > > > -/* offset=3D736 */ "num_packages\000tool\000Number of packages. Ea=
ch package has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> > > > -/* offset=3D822 */ "slots\000tool\000Number of functional units th=
at in parallel can execute parts of an instruction\000config=3D0xa\000\0000=
0\000\000\000\000\000"
> > > > -/* offset=3D932 */ "smt_on\000tool\0001 if simultaneous multithrea=
ding (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\0=
00\000\000\000\000"
> > > > -/* offset=3D1039 */ "system_tsc_freq\000tool\000The amount a Time =
Stamp Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\=
000\000\000"
> > > > -/* offset=3D1138 */ "default_core\000"
> > > > -/* offset=3D1151 */ "bp_l1_btb_correct\000branch\000L1 BTB Correct=
ion\000event=3D0x8a\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1213 */ "bp_l2_btb_correct\000branch\000L2 BTB Correct=
ion\000event=3D0x8b\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1275 */ "l3_cache_rd\000cache\000L3 cache access, read=
\000event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access=
, read\000"
> > > > -/* offset=3D1373 */ "segment_reg_loads.any\000other\000Number of s=
egment register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\0=
00\000\000\000\000"
> > > > -/* offset=3D1475 */ "dispatch_blocked.any\000other\000Memory clust=
er signals to block micro-op dispatch for any reason\000event=3D9,period=3D=
200000,umask=3D0x20\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1608 */ "eist_trans\000other\000Number of Enhanced Int=
el SpeedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D2000=
00\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1726 */ "hisi_sccl,ddrc\000"
> > > > -/* offset=3D1741 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC =
write commands\000event=3D2\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1811 */ "uncore_cbox\000"
> > > > -/* offset=3D1823 */ "unc_cbo_xsnp_response.miss_eviction\000uncore=
\000A cross-core snoop resulted from L3 Eviction which misses in some proce=
ssor core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> > > > -/* offset=3D1977 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000e=
vent=3D0xe0\000\00000\000\000\000\000\000"
> > > > -/* offset=3D2031 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\=
000event=3D0xc0\000\00000\000\000\000\000\000"
> > > > -/* offset=3D2089 */ "hisi_sccl,l3c\000"
> > > > -/* offset=3D2103 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Tot=
al read hits\000event=3D7\000\00000\000\000\000\000\000"
> > > > -/* offset=3D2171 */ "uncore_imc_free_running\000"
> > > > -/* offset=3D2195 */ "uncore_imc_free_running.cache_miss\000uncore\=
000Total cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> > > > -/* offset=3D2275 */ "uncore_imc\000"
> > > > -/* offset=3D2286 */ "uncore_imc.cache_hits\000uncore\000Total cach=
e hits\000event=3D0x34\000\00000\000\000\000\000\000"
> > > > -/* offset=3D2351 */ "uncore_sys_ddr_pmu\000"
> > > > -/* offset=3D2370 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr wri=
te-cycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> > > > -/* offset=3D2446 */ "uncore_sys_ccn_pmu\000"
> > > > -/* offset=3D2465 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read=
-cycles event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> > > > -/* offset=3D2542 */ "uncore_sys_cmn_pmu\000"
> > > > -/* offset=3D2561 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Count=
s total cache misses in first lookup result (high priority)\000eventid=3D1,=
type=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> > > > -/* offset=3D2704 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\00=
0\00000"
> > > > -/* offset=3D2726 */ "IPC\000group1\000inst_retired.any / cpu_clk_u=
nhalted.thread\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D2789 */ "Frontend_Bound_SMT\000\000idq_uops_not_delive=
red.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_th=
read_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\0000=
0"
> > > > -/* offset=3D2955 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses /=
 inst_retired.any\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3019 */ "icache_miss_cycles\000\000l1i\\-loads\\-misse=
s / inst_retired.any\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3086 */ "cache_miss_cycles\000group1\000dcache_miss_cp=
i + icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3157 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_dat=
a_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\0=
0000"
> > > > -/* offset=3D3251 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_de=
mand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqst=
s.rfo_miss\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3385 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCa=
che_L2_All_Miss\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3449 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_H=
its, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3517 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All=
_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > > > -/* offset=3D3587 */ "M1\000\000ipc + M2\000\000\000\000\000\000\00=
0\00000"
> > > > -/* offset=3D3609 */ "M2\000\000ipc + M1\000\000\000\000\000\000\00=
0\00000"
> > > > -/* offset=3D3631 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\=
00000"
> > > > -/* offset=3D3651 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement=
 / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D0 */ "software\000"
> > > > +/* offset=3D9 */ "cpu-clock\000software\000Per-CPU high-resolution=
 timer based event\000config=3D0\000\00000\000\000\000\000\000"
> > > > +/* offset=3D87 */ "task-clock\000software\000Task based high-resol=
ution timer based event\000config=3D1\000\00000\000\000\000\000\000"
> > > > +/* offset=3D169 */ "faults\000software\000Number of page faults [T=
his event is an alias of page-faults]\000config=3D2\000\00000\000\000\000\0=
00\000"
> > > > +/* offset=3D264 */ "page-faults\000software\000Number of page faul=
ts [This event is an alias of faults]\000config=3D2\000\00000\000\000\000\0=
00\000"
> > > > +/* offset=3D359 */ "context-switches\000software\000Number of cont=
ext switches [This event is an alias of cs]\000config=3D3\000\00000\000\000=
\000\000\000"
> > > > +/* offset=3D460 */ "cs\000software\000Number of context switches [=
This event is an alias of context-switches]\000config=3D3\000\00000\000\000=
\000\000\000"
> > > > +/* offset=3D561 */ "cpu-migrations\000software\000Number of times =
a process has migrated to a new CPU [This event is an alias of migrations]\=
000config=3D4\000\00000\000\000\000\000\000"
> > > > +/* offset=3D693 */ "migrations\000software\000Number of times a pr=
ocess has migrated to a new CPU [This event is an alias of cpu-migrations]\=
000config=3D4\000\00000\000\000\000\000\000"
> > > > +/* offset=3D825 */ "minor-faults\000software\000Number of minor pa=
ge faults. Minor faults don't require I/O to handle\000config=3D5\000\00000=
\000\000\000\000\000"
> > > > +/* offset=3D934 */ "major-faults\000software\000Number of major pa=
ge faults. Major faults require I/O to handle\000config=3D6\000\00000\000\0=
00\000\000\000"
> > > > +/* offset=3D1037 */ "alignment-faults\000software\000Number of ker=
nel handled memory alignment faults\000config=3D7\000\00000\000\000\000\000=
\000"
> > > > +/* offset=3D1129 */ "emulation-faults\000software\000Number of ker=
nel handled unimplemented instruction faults handled through emulation\000c=
onfig=3D8\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1256 */ "dummy\000software\000A placeholder event that=
 doesn't count anything\000config=3D9\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1336 */ "bpf-output\000software\000An event used by BP=
F programs to write to the perf ring buffer\000config=3D0xa\000\00000\000\0=
00\000\000\000"
> > > > +/* offset=3D1438 */ "cgroup-switches\000software\000Number of cont=
ext switches to a task in a different cgroup\000config=3D0xb\000\00000\000\=
000\000\000\000"
> > > > +/* offset=3D1541 */ "tool\000"
> > > > +/* offset=3D1546 */ "duration_time\000tool\000Wall clock interval =
time in nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1622 */ "user_time\000tool\000User (non-kernel) time i=
n nanoseconds\000config=3D2\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1692 */ "system_time\000tool\000System/kernel time in =
nanoseconds\000config=3D3\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1760 */ "has_pmem\000tool\0001 if persistent memory in=
stalled otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1836 */ "num_cores\000tool\000Number of cores. A core =
consists of 1 or more thread, with each thread being associated with a logi=
cal Linux CPU\000config=3D5\000\00000\000\000\000\000\000"
> > > > +/* offset=3D1981 */ "num_cpus\000tool\000Number of logical Linux C=
PUs. There may be multiple such CPUs on a core\000config=3D6\000\00000\000\=
000\000\000\000"
> > > > +/* offset=3D2084 */ "num_cpus_online\000tool\000Number of online l=
ogical Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\=
000\00000\000\000\000\000\000"
> > > > +/* offset=3D2201 */ "num_dies\000tool\000Number of dies. Each die =
has 1 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> > > > +/* offset=3D2277 */ "num_packages\000tool\000Number of packages. E=
ach package has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> > > > +/* offset=3D2363 */ "slots\000tool\000Number of functional units t=
hat in parallel can execute parts of an instruction\000config=3D0xa\000\000=
00\000\000\000\000\000"
> > > > +/* offset=3D2473 */ "smt_on\000tool\0001 if simultaneous multithre=
ading (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\=
000\000\000\000\000"
> > > > +/* offset=3D2580 */ "system_tsc_freq\000tool\000The amount a Time =
Stamp Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\=
000\000\000"
> > > > +/* offset=3D2679 */ "default_core\000"
> > > > +/* offset=3D2692 */ "bp_l1_btb_correct\000branch\000L1 BTB Correct=
ion\000event=3D0x8a\000\00000\000\000\000\000\000"
> > > > +/* offset=3D2754 */ "bp_l2_btb_correct\000branch\000L2 BTB Correct=
ion\000event=3D0x8b\000\00000\000\000\000\000\000"
> > > > +/* offset=3D2816 */ "l3_cache_rd\000cache\000L3 cache access, read=
\000event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access=
, read\000"
> > > > +/* offset=3D2914 */ "segment_reg_loads.any\000other\000Number of s=
egment register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\0=
00\000\000\000\000"
> > > > +/* offset=3D3016 */ "dispatch_blocked.any\000other\000Memory clust=
er signals to block micro-op dispatch for any reason\000event=3D9,period=3D=
200000,umask=3D0x20\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3149 */ "eist_trans\000other\000Number of Enhanced Int=
el SpeedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D2000=
00\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3267 */ "hisi_sccl,ddrc\000"
> > > > +/* offset=3D3282 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC =
write commands\000event=3D2\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3352 */ "uncore_cbox\000"
> > > > +/* offset=3D3364 */ "unc_cbo_xsnp_response.miss_eviction\000uncore=
\000A cross-core snoop resulted from L3 Eviction which misses in some proce=
ssor core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3518 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000e=
vent=3D0xe0\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3572 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\=
000event=3D0xc0\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3630 */ "hisi_sccl,l3c\000"
> > > > +/* offset=3D3644 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Tot=
al read hits\000event=3D7\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3712 */ "uncore_imc_free_running\000"
> > > > +/* offset=3D3736 */ "uncore_imc_free_running.cache_miss\000uncore\=
000Total cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3816 */ "uncore_imc\000"
> > > > +/* offset=3D3827 */ "uncore_imc.cache_hits\000uncore\000Total cach=
e hits\000event=3D0x34\000\00000\000\000\000\000\000"
> > > > +/* offset=3D3892 */ "uncore_sys_ddr_pmu\000"
> > > > +/* offset=3D3911 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr wri=
te-cycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> > > > +/* offset=3D3987 */ "uncore_sys_ccn_pmu\000"
> > > > +/* offset=3D4006 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read=
-cycles event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> > > > +/* offset=3D4083 */ "uncore_sys_cmn_pmu\000"
> > > > +/* offset=3D4102 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Count=
s total cache misses in first lookup result (high priority)\000eventid=3D1,=
type=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> > > > +/* offset=3D4245 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\00=
0\00000"
> > > > +/* offset=3D4267 */ "IPC\000group1\000inst_retired.any / cpu_clk_u=
nhalted.thread\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4330 */ "Frontend_Bound_SMT\000\000idq_uops_not_delive=
red.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_th=
read_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\0000=
0"
> > > > +/* offset=3D4496 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses /=
 inst_retired.any\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4560 */ "icache_miss_cycles\000\000l1i\\-loads\\-misse=
s / inst_retired.any\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4627 */ "cache_miss_cycles\000group1\000dcache_miss_cp=
i + icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4698 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_dat=
a_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\0=
0000"
> > > > +/* offset=3D4792 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_de=
mand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqst=
s.rfo_miss\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4926 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCa=
che_L2_All_Miss\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D4990 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_H=
its, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D5058 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All=
_Miss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > > > +/* offset=3D5128 */ "M1\000\000ipc + M2\000\000\000\000\000\000\00=
0\00000"
> > > > +/* offset=3D5150 */ "M2\000\000ipc + M1\000\000\000\000\000\000\00=
0\00000"
> > > > +/* offset=3D5172 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\=
00000"
> > > > +/* offset=3D5192 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement=
 / 1e9 / duration_time\000\000\000\000\000\000\000\00000"
> > > >  ;
> > > >
> > > > +static const struct compact_pmu_event pmu_events__common_software[=
] =3D {
> > > > +{ 1037 }, /* alignment-faults\000software\000Number of kernel hand=
led memory alignment faults\000config=3D7\000\00000\000\000\000\000\000 */
> > > > +{ 1336 }, /* bpf-output\000software\000An event used by BPF progra=
ms to write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000\0=
00\000 */
> > > > +{ 1438 }, /* cgroup-switches\000software\000Number of context swit=
ches to a task in a different cgroup\000config=3D0xb\000\00000\000\000\000\=
000\000 */
> > > > +{ 359 }, /* context-switches\000software\000Number of context swit=
ches [This event is an alias of cs]\000config=3D3\000\00000\000\000\000\000=
\000 */
> > > > +{ 9 }, /* cpu-clock\000software\000Per-CPU high-resolution timer b=
ased event\000config=3D0\000\00000\000\000\000\000\000 */
> > > > +{ 561 }, /* cpu-migrations\000software\000Number of times a proces=
s has migrated to a new CPU [This event is an alias of migrations]\000confi=
g=3D4\000\00000\000\000\000\000\000 */
> > > > +{ 460 }, /* cs\000software\000Number of context switches [This eve=
nt is an alias of context-switches]\000config=3D3\000\00000\000\000\000\000=
\000 */
> > > > +{ 1256 }, /* dummy\000software\000A placeholder event that doesn't=
 count anything\000config=3D9\000\00000\000\000\000\000\000 */
> > > > +{ 1129 }, /* emulation-faults\000software\000Number of kernel hand=
led unimplemented instruction faults handled through emulation\000config=3D=
8\000\00000\000\000\000\000\000 */
> > > > +{ 169 }, /* faults\000software\000Number of page faults [This even=
t is an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\000 *=
/
> > > > +{ 934 }, /* major-faults\000software\000Number of major page fault=
s. Major faults require I/O to handle\000config=3D6\000\00000\000\000\000\0=
00\000 */
> > > > +{ 693 }, /* migrations\000software\000Number of times a process ha=
s migrated to a new CPU [This event is an alias of cpu-migrations]\000confi=
g=3D4\000\00000\000\000\000\000\000 */
> > > > +{ 825 }, /* minor-faults\000software\000Number of minor page fault=
s. Minor faults don't require I/O to handle\000config=3D5\000\00000\000\000=
\000\000\000 */
> > > > +{ 264 }, /* page-faults\000software\000Number of page faults [This=
 event is an alias of faults]\000config=3D2\000\00000\000\000\000\000\000 *=
/
> > > > +{ 87 }, /* task-clock\000software\000Task based high-resolution ti=
mer based event\000config=3D1\000\00000\000\000\000\000\000 */
> > > > +};
> > > >  static const struct compact_pmu_event pmu_events__common_tool[] =
=3D {
> > > > -{ 5 }, /* duration_time\000tool\000Wall clock interval time in nan=
oseconds\000config=3D1\000\00000\000\000\000\000\000 */
> > > > -{ 219 }, /* has_pmem\000tool\0001 if persistent memory installed o=
therwise 0\000config=3D4\000\00000\000\000\000\000\000 */
> > > > -{ 295 }, /* num_cores\000tool\000Number of cores. A core consists =
of 1 or more thread, with each thread being associated with a logical Linux=
 CPU\000config=3D5\000\00000\000\000\000\000\000 */
> > > > -{ 440 }, /* num_cpus\000tool\000Number of logical Linux CPUs. Ther=
e may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\0=
00\000 */
> > > > -{ 543 }, /* num_cpus_online\000tool\000Number of online logical Li=
nux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000=
\000\000\000\000\000 */
> > > > -{ 660 }, /* num_dies\000tool\000Number of dies. Each die has 1 or =
more cores\000config=3D8\000\00000\000\000\000\000\000 */
> > > > -{ 736 }, /* num_packages\000tool\000Number of packages. Each packa=
ge has 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> > > > -{ 822 }, /* slots\000tool\000Number of functional units that in pa=
rallel can execute parts of an instruction\000config=3D0xa\000\00000\000\00=
0\000\000\000 */
> > > > -{ 932 }, /* smt_on\000tool\0001 if simultaneous multithreading (ak=
a hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\0=
00\000\000 */
> > > > -{ 151 }, /* system_time\000tool\000System/kernel time in nanosecon=
ds\000config=3D3\000\00000\000\000\000\000\000 */
> > > > -{ 1039 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Co=
unter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\=
000 */
> > > > -{ 81 }, /* user_time\000tool\000User (non-kernel) time in nanoseco=
nds\000config=3D2\000\00000\000\000\000\000\000 */
> > > > +{ 1546 }, /* duration_time\000tool\000Wall clock interval time in =
nanoseconds\000config=3D1\000\00000\000\000\000\000\000 */
> > > > +{ 1760 }, /* has_pmem\000tool\0001 if persistent memory installed =
otherwise 0\000config=3D4\000\00000\000\000\000\000\000 */
> > > > +{ 1836 }, /* num_cores\000tool\000Number of cores. A core consists=
 of 1 or more thread, with each thread being associated with a logical Linu=
x CPU\000config=3D5\000\00000\000\000\000\000\000 */
> > > > +{ 1981 }, /* num_cpus\000tool\000Number of logical Linux CPUs. The=
re may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\=
000\000 */
> > > > +{ 2084 }, /* num_cpus_online\000tool\000Number of online logical L=
inux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\0000=
0\000\000\000\000\000 */
> > > > +{ 2201 }, /* num_dies\000tool\000Number of dies. Each die has 1 or=
 more cores\000config=3D8\000\00000\000\000\000\000\000 */
> > > > +{ 2277 }, /* num_packages\000tool\000Number of packages. Each pack=
age has 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> > > > +{ 2363 }, /* slots\000tool\000Number of functional units that in p=
arallel can execute parts of an instruction\000config=3D0xa\000\00000\000\0=
00\000\000\000 */
> > > > +{ 2473 }, /* smt_on\000tool\0001 if simultaneous multithreading (a=
ka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\=
000\000\000 */
> > > > +{ 1692 }, /* system_time\000tool\000System/kernel time in nanoseco=
nds\000config=3D3\000\00000\000\000\000\000\000 */
> > > > +{ 2580 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Co=
unter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\=
000 */
> > > > +{ 1622 }, /* user_time\000tool\000User (non-kernel) time in nanose=
conds\000config=3D2\000\00000\000\000\000\000\000 */
> > > >
> > > >  };
> > > >
> > > >  const struct pmu_table_entry pmu_events__common[] =3D {
> > > > +{
> > > > +     .entries =3D pmu_events__common_software,
> > > > +     .num_entries =3D ARRAY_SIZE(pmu_events__common_software),
> > > > +     .pmu_name =3D { 0 /* software\000 */ },
> > > > +},
> > > >  {
> > > >       .entries =3D pmu_events__common_tool,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
> > > > -     .pmu_name =3D { 0 /* tool\000 */ },
> > > > +     .pmu_name =3D { 1541 /* tool\000 */ },
> > > >  },
> > > >  };
> > > >
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_def=
ault_core[] =3D {
> > > > -{ 1151 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000e=
vent=3D0x8a\000\00000\000\000\000\000\000 */
> > > > -{ 1213 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000e=
vent=3D0x8b\000\00000\000\000\000\000\000 */
> > > > -{ 1475 }, /* dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000\000\000\000 */
> > > > -{ 1608 }, /* eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000\000\000\000 */
> > > > -{ 1275 }, /* l3_cache_rd\000cache\000L3 cache access, read\000even=
t=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\0=
00 */
> > > > -{ 1373 }, /* segment_reg_loads.any\000other\000Number of segment r=
egister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\0=
00\000\000 */
> > > > +{ 2692 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000e=
vent=3D0x8a\000\00000\000\000\000\000\000 */
> > > > +{ 2754 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000e=
vent=3D0x8b\000\00000\000\000\000\000\000 */
> > > > +{ 3016 }, /* dispatch_blocked.any\000other\000Memory cluster signa=
ls to block micro-op dispatch for any reason\000event=3D9,period=3D200000,u=
mask=3D0x20\000\00000\000\000\000\000\000 */
> > > > +{ 3149 }, /* eist_trans\000other\000Number of Enhanced Intel Speed=
Step(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\0=
0000\000\000\000\000\000 */
> > > > +{ 2816 }, /* l3_cache_rd\000cache\000L3 cache access, read\000even=
t=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\0=
00 */
> > > > +{ 2914 }, /* segment_reg_loads.any\000other\000Number of segment r=
egister loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\0=
00\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_his=
i_sccl_ddrc[] =3D {
> > > > -{ 1741 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000\000\000\000\000 */
> > > > +{ 3282 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write co=
mmands\000event=3D2\000\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_his=
i_sccl_l3c[] =3D {
> > > > -{ 2103 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000\000\000\000\000 */
> > > > +{ 3644 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read =
hits\000event=3D7\000\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_unc=
ore_cbox[] =3D {
> > > > -{ 1977 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000\000\000\000\000 */
> > > > -{ 2031 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000\000\000\000\000 */
> > > > -{ 1823 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
> > > > +{ 3518 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0=
xe0\000\00000\000\000\000\000\000 */
> > > > +{ 3572 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=
=3D0xc0\000\00000\000\000\000\000\000 */
> > > > +{ 3364 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cr=
oss-core snoop resulted from L3 Eviction which misses in some processor cor=
e\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_unc=
ore_imc[] =3D {
> > > > -{ 2286 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000\000\000\000\000 */
> > > > +{ 3827 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\0=
00event=3D0x34\000\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_cpu_unc=
ore_imc_free_running[] =3D {
> > > > -{ 2195 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000\000\000\000\000 */
> > > > +{ 3736 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total=
 cache misses\000event=3D0x12\000\00000\000\000\000\000\000 */
> > > >
> > > >  };
> > > >
> > > > @@ -129,51 +167,51 @@ const struct pmu_table_entry pmu_events__test=
_soc_cpu[] =3D {
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_default_core,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_default_=
core),
> > > > -     .pmu_name =3D { 1138 /* default_core\000 */ },
> > > > +     .pmu_name =3D { 2679 /* default_core\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_scc=
l_ddrc),
> > > > -     .pmu_name =3D { 1726 /* hisi_sccl,ddrc\000 */ },
> > > > +     .pmu_name =3D { 3267 /* hisi_sccl,ddrc\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_scc=
l_l3c),
> > > > -     .pmu_name =3D { 2089 /* hisi_sccl,l3c\000 */ },
> > > > +     .pmu_name =3D { 3630 /* hisi_sccl,l3c\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_c=
box),
> > > > -     .pmu_name =3D { 1811 /* uncore_cbox\000 */ },
> > > > +     .pmu_name =3D { 3352 /* uncore_cbox\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_uncore_imc,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_i=
mc),
> > > > -     .pmu_name =3D { 2275 /* uncore_imc\000 */ },
> > > > +     .pmu_name =3D { 3816 /* uncore_imc\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running=
,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_i=
mc_free_running),
> > > > -     .pmu_name =3D { 2171 /* uncore_imc_free_running\000 */ },
> > > > +     .pmu_name =3D { 3712 /* uncore_imc_free_running\000 */ },
> > > >  },
> > > >  };
> > > >
> > > >  static const struct compact_pmu_event pmu_metrics__test_soc_cpu_de=
fault_core[] =3D {
> > > > -{ 2704 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 =
*/
> > > > -{ 3385 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000 */
> > > > -{ 3157 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > > > -{ 3251 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000 */
> > > > -{ 3449 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000 */
> > > > -{ 3517 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000 */
> > > > -{ 2789 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > > > -{ 2726 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000 */
> > > > -{ 3651 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000 */
> > > > -{ 3587 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 =
*/
> > > > -{ 3609 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 =
*/
> > > > -{ 3631 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > > > -{ 3086 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000 */
> > > > -{ 2955 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000 */
> > > > -{ 3019 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000 */
> > > > +{ 4245 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 =
*/
> > > > +{ 4926 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_A=
ll_Miss\000\000\000\000\000\000\000\00000 */
> > > > +{ 4698 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit=
 + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > > > +{ 4792 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_dat=
a_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_mi=
ss\000\000\000\000\000\000\000\00000 */
> > > > +{ 4990 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000 */
> > > > +{ 5058 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, D=
Cache_L2_All)\000\000\000\000\000\000\000\00000 */
> > > > +{ 4330 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core=
 / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_act=
ive / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > > > +{ 4267 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.=
thread\000\000\000\000\000\000\000\00000 */
> > > > +{ 5192 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 /=
 duration_time\000\000\000\000\000\000\000\00000 */
> > > > +{ 5128 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 =
*/
> > > > +{ 5150 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 =
*/
> > > > +{ 5172 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > > > +{ 4627 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icac=
he_miss_cycles\000\000\000\000\000\000\000\00000 */
> > > > +{ 4496 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_re=
tired.any\000\000\000\000\000\000\000\00000 */
> > > > +{ 4560 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst=
_retired.any\000\000\000\000\000\000\000\00000 */
> > > >
> > > >  };
> > > >
> > > > @@ -181,18 +219,18 @@ const struct pmu_table_entry pmu_metrics__tes=
t_soc_cpu[] =3D {
> > > >  {
> > > >       .entries =3D pmu_metrics__test_soc_cpu_default_core,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_metrics__test_soc_cpu_default=
_core),
> > > > -     .pmu_name =3D { 1138 /* default_core\000 */ },
> > > > +     .pmu_name =3D { 2679 /* default_core\000 */ },
> > > >  },
> > > >  };
> > > >
> > > >  static const struct compact_pmu_event pmu_events__test_soc_sys_unc=
ore_sys_ccn_pmu[] =3D {
> > > > -{ 2465 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
> > > > +{ 4006 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles =
event\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_sys_unc=
ore_sys_cmn_pmu[] =3D {
> > > > -{ 2561 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
> > > > +{ 4102 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total =
cache misses in first lookup result (high priority)\000eventid=3D1,type=3D5=
\000(434|436|43c|43a).*\00000\000\000\000\000\000 */
> > > >  };
> > > >  static const struct compact_pmu_event pmu_events__test_soc_sys_unc=
ore_sys_ddr_pmu[] =3D {
> > > > -{ 2370 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
> > > > +{ 3911 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycle=
s event\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
> > > >
> > > >  };
> > > >
> > > > @@ -200,17 +238,17 @@ const struct pmu_table_entry pmu_events__test=
_soc_sys[] =3D {
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_s=
ys_ccn_pmu),
> > > > -     .pmu_name =3D { 2446 /* uncore_sys_ccn_pmu\000 */ },
> > > > +     .pmu_name =3D { 3987 /* uncore_sys_ccn_pmu\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_s=
ys_cmn_pmu),
> > > > -     .pmu_name =3D { 2542 /* uncore_sys_cmn_pmu\000 */ },
> > > > +     .pmu_name =3D { 4083 /* uncore_sys_cmn_pmu\000 */ },
> > > >  },
> > > >  {
> > > >       .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
> > > >       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_s=
ys_ddr_pmu),
> > > > -     .pmu_name =3D { 2351 /* uncore_sys_ddr_pmu\000 */ },
> > > > +     .pmu_name =3D { 3892 /* uncore_sys_ddr_pmu\000 */ },
> > > >  },
> > > >  };
> > > >
> > > > @@ -632,8 +670,20 @@ static const struct pmu_events_map *map_for_pm=
u(struct perf_pmu *pmu)
> > > >  {
> > > >          struct perf_cpu cpu =3D {-1};
> > > >
> > > > -        if (pmu)
> > > > +        if (pmu) {
> > > > +                for (size_t i=3D0; i < ARRAY_SIZE(pmu_events__comm=
on); i++) {
> > > > +                        const char *pmu_name =3D &big_c_string[pmu=
_events__common[i].pmu_name.offset];
> > > > +
> > > > +                        if (!strcmp(pmu_name, pmu->name)) {
> > > > +                                const struct pmu_events_map *map =
=3D &pmu_events_map[0];
> > > > +
> > > > +                                while (strcmp("common", map->arch)=
)
> > > > +                                        map++;
> > > > +                                return map;
> > > > +                        }
> > > > +                }
> > > >                  cpu =3D perf_cpu_map__min(pmu->cpus);
> > > > +        }
> > > >          return map_for_cpu(cpu);
> > > >  }
> > > >
> > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-even=
ts/jevents.py
> > > > index e821155151ec..76c1e7b0bc22 100755
> > > > --- a/tools/perf/pmu-events/jevents.py
> > > > +++ b/tools/perf/pmu-events/jevents.py
> > > > @@ -295,6 +295,7 @@ class JsonEvent:
> > > >            'cpu_atom': 'cpu_atom',
> > > >            'ali_drw': 'ali_drw',
> > > >            'arm_cmn': 'arm_cmn',
> > > > +          'software': 'software',
> > > >            'tool': 'tool',
> > > >        }
> > > >        return table[unit] if unit in table else f'uncore_{unit.lowe=
r()}'
> > > > @@ -1158,8 +1159,20 @@ static const struct pmu_events_map *map_for_=
pmu(struct perf_pmu *pmu)
> > > >  {
> > > >          struct perf_cpu cpu =3D {-1};
> > > >
> > > > -        if (pmu)
> > > > +        if (pmu) {
> > > > +                for (size_t i=3D0; i < ARRAY_SIZE(pmu_events__comm=
on); i++) {
> > > > +                        const char *pmu_name =3D &big_c_string[pmu=
_events__common[i].pmu_name.offset];
> > > > +
> > > > +                        if (!strcmp(pmu_name, pmu->name)) {
> > > > +                                const struct pmu_events_map *map =
=3D &pmu_events_map[0];
> > > > +
> > > > +                                while (strcmp("common", map->arch)=
)
> > > > +                                        map++;
> > > > +                                return map;
> > > > +                        }
> > > > +                }
> > > >                  cpu =3D perf_cpu_map__min(pmu->cpus);
> > > > +        }
> > > >          return map_for_cpu(cpu);
> > > >  }
> > > >
> > > > --
> > > > 2.50.0.727.gbf7dc18ff4-goog
> > > >
