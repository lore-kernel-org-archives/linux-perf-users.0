Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494771D63DD
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119863; cv=none; b=ASo0E90N2Sao16vvQIeEdk3gbIlV2Bl5cuUS5pMvlzD1XqVPMhxfy0qYvZeJ2Cw8lMLCTBKwpYb/XFGtrwWtRJdH9V8AdqGcz168IK/xg/3bwsMQ8/5V+6x1g+75D5hIW7dioAdVlrZhk89kQRAn4ZslTFa3Swezktw/nkbEW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119863; c=relaxed/simple;
	bh=gMH6XWwqPJ0KzuGVPJGnJLnVUyLkQtBSTcgdZ47J/ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwVCObXzdeLpsIVg2g7sPQyFMQJpbYKphLx9QnKg1Vun9Q7rw6UvdxEAORyOhydSLXy/UYe2ZHXlwj05yl6Lq4EwaAz6gbUFHccXmbgZwoWc/hCB4Qw0DvLswo/lRxqm7gRk37gML9Vs955IJXwa+Wwr2lgQAOYzAXzT7W74FI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2nRDaue; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2nRDaue"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so23375ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Jul 2025 10:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753119861; x=1753724661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE+GRkINH0q4J2wZRJaye5qXuEiNH8J9d8HS1b8aa/0=;
        b=q2nRDaueapAE9RsJIiVuwpV3/7RpUa1KVuj1isWGsJQnGupYzaTVPbpkE8VWMtyN3W
         T9YtLSe+NNESSQShslcM+UHdTjaEFvC4qsphz6Pll/UTK+LOUnwtHEBc/rJTLXQ34ms6
         CCcOHWNBFYpsp5ocu7HtUdue/b/sEOzlup8PDkaGf/6JX46KmWUiJGJNiN89k4TnOlUO
         oLtabyHzjHjo2xq9oFabfJ3jyTaWZ5olTuQWulqQiOUI6MrdfPW4cnjjJtnnQfDL07xD
         Y8CXysJSHoV3yBdmcY+2jIhyC0g+KMz0985kVc4ktHCHLqkbS4HEWYZCnEqMYmL1K3bj
         mBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753119861; x=1753724661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YE+GRkINH0q4J2wZRJaye5qXuEiNH8J9d8HS1b8aa/0=;
        b=H9xV9brq8Lq7GQ26GA1WqabcagMcxjju4vyfYgrNZU5ZoM2t7vvXgskSazFtiIcxe8
         ve/ehDh2omqaALXtCrUUhimS/3nLZ8Jdz4Q8g2TXGn9x86OOVl6c+3q7jlue5PgdgAY/
         XSfdDw7yH0EN8QkVbVJT3skl3npUB4KE7VIGpWdKoAvE4akz/xYExeH+0xAzdRSHtHUI
         bbHM74UFj4DTkOorkIC6NKA/UD3rl67GcPv84Xl+dRzkMRrKCpipUllVCdx6U9xuuvtt
         IJ9SxVejN42QdY6PYBfY33AN6iyMyzYdI/e6B1Y2aYovgXKnsuyBGGywSTcccmrnXSn4
         COMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ16QsPfpeCZL3Z7Zej2q7o8e6emXD4oZHgPOzSkdpzWWP3ZTCOwtYZ/isUSTfleSOfzPbph1R0osW0XS0DJmO@vger.kernel.org
X-Gm-Message-State: AOJu0YzMsOBhEXBj/Tt1IAUrapjud00XeGGu0e4tCgF5xuzQ1E4ceI0g
	aqjVJ8+H0D/2+4+bA9eyFeRi+YxSMAGUYa4VZmdy1WfMP1qF/cRydM1WAy4FFuHVxuYC+LSaPIs
	aE2ZIfelVyBS06nRmawCMYuW75zuMTvDxT8CbcvGb
X-Gm-Gg: ASbGnctZ0PazevOybLfWCIEPg2BvdhIL9zvxK5ENfsyCtI3FsFCr33saJIo7YTP8xSV
	kkqtfDesKXfm49B30RtqosWpdY/djzFqM90uxCYr8WjfZ4LUyPEkueYFYwUoMTh6+UVX6osYreH
	2tvGDMqtrnJbOBuzhbIhs4zRMecXyvQw5O7s5BgVgFY4OcEPzFrm0ET+O/jWiVqQ4W56gn/XvJp
	9TwbzoLonrcu2E9WJuYkR3dQzwTcSeEviLcqmaIPT6j4rU=
X-Google-Smtp-Source: AGHT+IE/4lxd9uJmJPv3nO7QV8baVIIzg/+rljpFRzhFU7B8j4jxoE37cl3owIVq9o4mocY9dMBk9h4rCz0IpR6VZhA=
X-Received: by 2002:a05:6e02:3e01:b0:3ce:7852:1e9 with SMTP id
 e9e14a558f8ab-3e2be737d19mr579535ab.17.1753119860921; Mon, 21 Jul 2025
 10:44:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627192417.1157736-1-irogers@google.com> <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
In-Reply-To: <2b51b856-a1c6-4ff1-b336-ae612e5d1cf5@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Jul 2025 10:44:09 -0700
X-Gm-Features: Ac12FXxaaDJDO0VKiKSgcp4ANMZy6A7aiK0cEXQ5buqzS7Dfb2CtcNPbs8e4DcM
Message-ID: <CAP-5=fXmzETmP3Ra3z_nM-Go2X6SRZ3im+bA0CLvdXS=VtJWOw@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] CPU mask improvements/fixes particularly for hybrid
To: James Clark <james.clark@linaro.org>
Cc: Thomas Falcon <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Ben Gainey <ben.gainey@arm.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zhongqiu Han <quic_zhonhan@quicinc.com>, 
	Blake Jones <blakejones@google.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Anubhav Shelat <ashelat@redhat.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Song Liu <song@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 9:13=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 27/06/2025 8:24 pm, Ian Rogers wrote:
> > On hybrid systems some PMUs apply to all core types, particularly for
> > metrics the msr PMU and the tsc event. The metrics often only want the
> > values of the counter for their specific core type. These patches
> > allow the cpu term in an event to give a PMU name to take the cpumask
> > from. For example:
> >
> >    $ perf stat -e msr/tsc,cpu=3Dcpu_atom/ ...
> >
> > will aggregate the msr/tsc/ value but only for atom cores. In doing
> > this problems were identified in how cpumasks are handled by parsing
> > and event setup when cpumasks are specified along with a task to
> > profile. The event parsing, cpumask evlist propagation code and perf
> > stat code are updated accordingly.
> >
> > The final result of the patch series is to be able to run:
> > ```
> > $ perf stat --no-scale -e 'msr/tsc/,msr/tsc,cpu=3Dcpu_core/,msr/tsc,cpu=
=3Dcpu_atom/' perf test -F 10
> >   10.1: Basic parsing test                                            :=
 Ok
> >   10.2: Parsing without PMU name                                      :=
 Ok
> >   10.3: Parsing with PMU name                                         :=
 Ok
> >
> >   Performance counter stats for 'perf test -F 10':
> >
> >          63,704,975      msr/tsc/
> >          47,060,704      msr/tsc,cpu=3Dcpu_core/                       =
 (4.62%)
> >          16,640,591      msr/tsc,cpu=3Dcpu_atom/                       =
 (2.18%)
> > ```
> >
> > This has (further) identified a kernel bug for task events around the
> > enabled time being too large leading to invalid scaling (hence the
> >   --no-scale in the command line above).
> >
> > Ian Rogers (12):
> >    perf parse-events: Warn if a cpu term is unsupported by a CPU
> >    perf stat: Avoid buffer overflow to the aggregation map
> >    perf stat: Don't size aggregation ids from user_requested_cpus
> >    perf parse-events: Allow the cpu term to be a PMU
> >    perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
> >    libperf evsel: Rename own_cpus to pmu_cpus
> >    libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
> >    perf evsel: Use libperf perf_evsel__exit
> >    perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
> >    perf parse-events: Minor __add_event refactoring
> >    perf evsel: Add evsel__open_per_cpu_and_thread
> >    perf parse-events: Support user CPUs mixed with threads/processes
> >
> >   tools/lib/perf/evlist.c                 | 118 ++++++++++++++++-------=
-
> >   tools/lib/perf/evsel.c                  |   9 +-
> >   tools/lib/perf/include/internal/evsel.h |   3 +-
> >   tools/perf/builtin-stat.c               |   9 +-
> >   tools/perf/tests/event_update.c         |   4 +-
> >   tools/perf/util/evlist.c                |  15 +--
> >   tools/perf/util/evsel.c                 |  55 +++++++++--
> >   tools/perf/util/evsel.h                 |   5 +
> >   tools/perf/util/expr.c                  |   2 +-
> >   tools/perf/util/header.c                |   4 +-
> >   tools/perf/util/parse-events.c          | 102 ++++++++++++++------
> >   tools/perf/util/pmus.c                  |  29 +++---
> >   tools/perf/util/pmus.h                  |   2 +
> >   tools/perf/util/stat.c                  |   6 +-
> >   tools/perf/util/synthetic-events.c      |   4 +-
> >   tools/perf/util/tool_pmu.c              |  56 +++++++++--
> >   tools/perf/util/tool_pmu.h              |   2 +-
> >   17 files changed, 297 insertions(+), 128 deletions(-)
> >
>
> Tested-by: James Clark <james.clark@linaro.org>

Much appreciated, thanks James!

There's a v2 patch set but the Tested-by will be good for the majority
of patches that are unchanged in that:
https://lore.kernel.org/lkml/20250717210233.1143622-1-irogers@google.com/
I'm of course interested in getting RFC feedback on:
https://lore.kernel.org/lkml/20250716223924.825772-1-irogers@google.com/
which introduces an extra state to avoid gathering enabled time on
CPUs an event can't run on.

Thanks,
Ian
