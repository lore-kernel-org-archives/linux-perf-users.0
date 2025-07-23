Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08B21D7E4A
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753294544; cv=none; b=ljm+pDhxZidM7viC7yjfXs/eGLrI+hNy1whYHzUunKhsNcKBejmz6q7ZvjjU1v3E/LneVE38zcVH6O8mpEistf25y/oFZl+shySLAs/iq+cuFStItBag2crSfhsemYzpWnnbQIvfd8YCMOl4wPRoBZgG/TsXBpOKg7KJZXQRmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753294544; c=relaxed/simple;
	bh=vjCS7XRV9GNLU9BZynOc/Q1ypNtkMuWhatqaXYlbaOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNQJ0VqPI2qNWdOZfSIiMz0VCraen+HgUzHGNyDkNOaZgejz1EkwlCjUdDCsifZV+M9mcBi7k6U9SkLiZyh1auuRt6bKRVluzH8N0WtI2dzmmBhP21yK/ytZQI9qtz+rF6OY0s9Z7cvYrtEchOxYY8NljvMzB+6NWDl1l2BE5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZxHiwm8; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZxHiwm8"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3df371e1d29so14595ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Jul 2025 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753294542; x=1753899342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H36aNSQcBdBkwNrcJ1g0QaYoDvoQx/EdYKDUImcfEe0=;
        b=rZxHiwm8AIIwSh7t1basAC3f10IA+QgUbEWvNqsxTigBgb5mqHHuZBAgRFw+dNknqt
         FxbDJ7zlvh0C9Y06X8QLIK+3JmyEoldCSxLp5ubkR31feZ7CHDrASs0+Pe7bJGMOEqXI
         tsWR0dhmNWJtoFDT/Ufuhtfhq6TcnNiKTCx3jqxpDeEIlNFPNZ4dEkQwWEDWuDxKTaqq
         q8r1Pxk74xg8H/pGDid7Rzy37yt64sBzEsmAdtm6JioxTySL5M6WH5IuF9M5eT47fjEv
         EVnAykbtbXhbbkPrrJzgcd9aYGljxY0Q1dqMrZKKMD5DkhL2izg+oszbTrKGx8KapI68
         MEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753294542; x=1753899342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H36aNSQcBdBkwNrcJ1g0QaYoDvoQx/EdYKDUImcfEe0=;
        b=tG39YoS7cJNDDhjeXabJlv61mwU8ua/dWX+zvVaNiFGx4Z4tTsairikNsRcRu8Io3c
         sjwGCtu65g/unvAAS6STFXQR8GTkxmp3CwTYhccCPf0vtlOOKMoHE9XYobBadLzNdF4q
         soOvJR0qNm5ZSvbpRAGYj8Cb/YSHyZnxcX9pizc9BU1AS5x4lPfPp9tMaFsNUGJVeM7W
         NPn/WOa1meOU+tl4HrK3gjdBcGToIYYWqGQ+PbOx/lPtcJHgjZDDNe59ILWW7ACoVXjN
         S5GMXaUaKn2JboUT4hqvNJGarXqOoNFP+3JbHNXCLhrtbqgH17Sv5l05ZkMxTSI7Q8UJ
         EbPA==
X-Forwarded-Encrypted: i=1; AJvYcCVP7irnvj6VP4jcEgmgWeP2rW1omH8uw65TitRKqn2JvTy4W+zf824ntKwcz73nvomScrb7ejCh5Zc2huZmc3u5@vger.kernel.org
X-Gm-Message-State: AOJu0YxgpF2vHElNIQf8NQnjL9lMPBR167TUSesaBPMiPx1oBZvWVitX
	g4vPtn2pa9f2LXiKUJ1CbgWLhV8s6ctzeuTvTXcTt3p27obn5jnmItiO+kCDazQTUy7vjxdZWKw
	0yxaV/c44Y29SDnMXWzUByTQlRoBxBOgcX2eVBelS
X-Gm-Gg: ASbGncti47gOOMpSDzjzw3eftS6z45/bo78ekfdvhZyUiF58AQkWVxCkS/Flpb8zsnT
	LqDGz7S2ReFXi1A1y4lZhfrNsqsNQoFz7eAJQXDPwbHI2P1iNiO8/xP2Ts71iZ0YG0lUdiNOsbU
	kBgdQQGdrWSUf0jJjoC5qDizeClx2Sj80fWwwWv/bwsWOeY/qY+DFOJzju736YXg0DX4jcNWjif
	O0pRB0YAvDygtTOaJU5Pl22xjiV9+9NBEYF
X-Google-Smtp-Source: AGHT+IE13asCQBfg5BH5l0ZzmcYhpaRmMrBFh6FbaJlmYj/g2YllwYTcBbaHjqK+UWJCEdPp7ZgECDHmJV+eHNC3B/I=
X-Received: by 2002:a05:6e02:1a0d:b0:3e3:a7d5:a47a with SMTP id
 e9e14a558f8ab-3e3b66571b5mr99715ab.7.1753294541306; Wed, 23 Jul 2025 11:15:41
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714164405.111477-1-irogers@google.com> <CAP-5=fW=AG8ztbzS-KXpo9fH_Hp_fkZ3CVDuG9pN7P32Qm0oyg@mail.gmail.com>
 <aIEjMroa3bW-T7d-@google.com>
In-Reply-To: <aIEjMroa3bW-T7d-@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Jul 2025 11:15:29 -0700
X-Gm-Features: Ac12FXw5c8Ku4R1FuTi1BLP5m5hmDNxu_9ZbwpmPfjflCFGU7qqUz7X34M9e4jQ
Message-ID: <CAP-5=fX1j_MdzjqLTYeNGFTWLaQp8Dmbi093QN98b2pNgFcpBA@mail.gmail.com>
Subject: Re: [PATCH v7 00/16] New perf ilist app
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

On Wed, Jul 23, 2025 at 11:00=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Wed, Jul 23, 2025 at 08:32:33AM -0700, Ian Rogers wrote:
> > On Mon, Jul 14, 2025 at 9:44=E2=80=AFAM Ian Rogers <irogers@google.com>=
 wrote:
> > >
> > > This patch series builds up to the addition of a new ilist app writte=
n
> > > in python using textual [1] for the UI. The app presents perf PMUs an=
d
> > > events, displays the event information as in `perf list` while at the
> > > bottom of the console showing recent activity of the event in total
> > > and across all CPUs. It also displays metrics, placed in a tree
> > > through their metric group, again with counts being displayed in the
> > > bottom panel.
> > >
> > > The first ground work patches of fixes, cleanup and refactoring were
> > > separated into their own series here:
> > > https://lore.kernel.org/lkml/20250709214029.1769089-1-irogers@google.=
com/
> > >
> > > The second part of the patches adds event json for the software PMU
> > > and makes the tracepoint PMU support iteration of events and the
> > > like. Without these improvements the tracepoint and software PMUs wil=
l
> > > appear to have no events in the ilist app. As the software PMU moves
> > > parsing to json, the legacy hard coded parsing is removed. This has
> > > proven controversial for hardware events and so that cleanup isn't
> > > done here.
> > >
> > > The final patches expand the perf python APIs and add the ilist
> > > command. To run it you need the updated perf.cpython.so in your
> > > PYTHONPATH and then execute the script. Expanding PMUs and then
> > > selecting events will cause event informatin to be displayed in the
> > > top-right and the counters values to be displayed as sparklines and
> > > counts in the bottom half of the screen.
> > >
> > > [1] https://textual.textualize.io/
> > >
> > > v7: Better handle errors in the python code and ignore errors when
> > >     scanning PMU/events in ilist.py, improving the behavior when not
> > >     root. Add a tp_pmu/python clean up. Minor kernel coding style
> > >     clean up. Fix behavior of ilist if a search result isn't found bu=
t
> > >     then next is chosen.
> > >
> > > v6: For metrics on hybrid systems don't purely match by name, also
> > >     match the CPU and thread so that if the same metric exists for
> > >     different PMUs the appropriate one is selected and counters may b=
e
> > >     read. Likewise use evsel maps and not the evlists.
> > >
> > > v5: Split the series in two. Add metric support. Various clean ups an=
d
> > >     tweaks to the app in particular around the handling of searches.
> > >
> > > v4: No conflict rebase. Picks up perf-tools-next DRM PMU which
> > >     displays as expected.
> > >
> > > v3: Add a search dialog to the ilist app with 'n'ext and 'p'revious
> > >     keys. No changes in the ground work first 14 patches.
> > >
> > > v2: In the jevents event description duplication, some minor changes
> > >     accidentally missed from v1 meaning that in v1 the descriptions
> > >     were still duplicated. Expand the cover letter with some thoughts
> > >     on the series.
> > >
> > > Ian Rogers (16):
> > >   perf python: Add more exceptions on error paths
> > >   perf jevents: Add common software event json
> > >   perf parse-events: Remove non-json software events
> > >   perf tp_pmu: Factor existing tracepoint logic to new file
> > >   perf tp_pmu: Add event APIs
> > >   perf list: Remove tracepoint printing code
> > >   perf list: Skip ABI PMUs when printing pmu values
> > >   perf python: Improve the tracepoint function if no libtraceevent
> > >   perf python: Add basic PMU abstraction and pmus sequence
> > >   perf python: Add function returning dictionary of all events on a P=
MU
> > >   perf ilist: Add new python ilist command
> > >   perf python: Add parse_metrics function
> > >   perf python: Add evlist metrics function
> > >   perf python: Add evlist compute_metric
> > >   perf python: Add metrics function
> > >   perf ilist: Add support for metrics
> >
> > Hi,
> >
> > Is there any more I can do to get this series landed? I appreciate havi=
ng:
> >
> > Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> >
> > I think there is some follow up for "make install" for scripts like
> > these, but I'm keen for the python API to move forward.
>
> I'll review the series today so that we can get some part of it, at
> least.  Basically I think we need a wrapper script like perf-ilist to
> run this easily (maybe with documentation).

Sgtm, I'll hold off on a new version, Arnaldo has caught some useful
nits to clean up in it.

Something related are the scripting engine scripts like gecko and
flamegraph. Something I've discovered is that those scripts work less
well than standalone apps like the ilist.py here. One issue there is
that the scripting engine tends to throw lots of data into a
dictionary in case it is useful, which means there is a higher
overhead than in the standalone app. Another issue is that the
scripting engine wants perf to drive python to drive the script. This
conflicts with python wanting to own the main thread, things like
asyncio, etc. For textual it isn't possible for the app to run on
anything other than the main thread, but it'd be useful to
incrementally load data while displaying it. With the scripting engine
it is only possible to run a textual app at trace_end (i.e. not
incrementally). Something we found in the gecko work was that it was
hard to handle command line arguments in a scripting engine style
script, what options are for record, report and live mode.

What does this mean? I think we want to move the scripting engine into
the python.c and perf python .so and expose it with something like the
session/tool API. I think we should migrate the existing scripts to
use this and then I think we can deprecate the python interpreter
script engine integration. Perhaps we can deprecate perl scripting
engine support at the same time. Then things like ilist.py can be run
with "perf script ilist", similar to how the scripting engine scripts
run today. Your proposal would avoid the need for the script keyword,
but perhaps that'd make it clear why the UI changes. I don't mind
having or not having "script" in the command line :-)

Thanks,
Ian

> Thanks,
> Namhyung
>
> > >
> > >  tools/perf/builtin-list.c                     |  65 ++-
> > >  .../arch/common/common/software.json          |  92 ++++
> > >  tools/perf/pmu-events/empty-pmu-events.c      | 266 +++++----
> > >  tools/perf/pmu-events/jevents.py              |  15 +-
> > >  tools/perf/python/ilist.py                    | 491 ++++++++++++++++=
+
> > >  tools/perf/util/Build                         |   1 +
> > >  tools/perf/util/evsel.c                       |  21 +-
> > >  tools/perf/util/parse-events.c                | 198 ++-----
> > >  tools/perf/util/parse-events.h                |   1 -
> > >  tools/perf/util/parse-events.l                |  38 +-
> > >  tools/perf/util/parse-events.y                |  29 +-
> > >  tools/perf/util/pfm.c                         |   2 +
> > >  tools/perf/util/pmu.c                         |   7 +
> > >  tools/perf/util/pmus.c                        |   2 +
> > >  tools/perf/util/print-events.c                | 100 +---
> > >  tools/perf/util/print-events.h                |   4 +-
> > >  tools/perf/util/python.c                      | 519 ++++++++++++++++=
+-
> > >  tools/perf/util/tp_pmu.c                      | 209 +++++++
> > >  tools/perf/util/tp_pmu.h                      |  19 +
> > >  19 files changed, 1638 insertions(+), 441 deletions(-)
> > >  create mode 100644 tools/perf/pmu-events/arch/common/common/software=
.json
> > >  create mode 100755 tools/perf/python/ilist.py
> > >  create mode 100644 tools/perf/util/tp_pmu.c
> > >  create mode 100644 tools/perf/util/tp_pmu.h
> > >
> > > --
> > > 2.50.0.727.gbf7dc18ff4-goog
> > >
