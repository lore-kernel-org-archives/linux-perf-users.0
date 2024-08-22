Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234C1CC179
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339428; cv=none; b=TCWiw85EC8rPrU8auwaBP4YtpER9bvKdBcfYP/vVyP9nMM8Tc3I/dLwDhZ/3HV8CimfILP1UOmcaHC3VIiZRJkI1/qGPgnoAA+0zNnbnIn0wLUD88flnXudrwb1xVWi8NGk/hXXU2lNIW+koojQjce4TqMFDStCLcilNOGNLPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339428; c=relaxed/simple;
	bh=2dY0MRnyytyTkqmMKJ6PY8J7A6cZhrz6NF6g3K0gNE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A80tVK5tJwNsdsQCwXhrJdM/Nfzq76CgCgjNIj9Z0hdcsQbRVG44NJ7jilTMD6JAszu4X4K3Jgqix8EO1kZmO7bauBZ1xI9RmUWnLRbQZjoostaW2jbjoKbMNGAMAS4ivK0FwtM6wjlzvYFMAy5REf6SuaqtR8ElxUFsWNIkRgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r5K0E3GP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5K0E3GP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20260346ca1so214755ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Aug 2024 08:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724339426; x=1724944226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGN1auVeefY0I3SVIHldm7HPYncKcBoISmYsv2msR0I=;
        b=r5K0E3GPRQmJYGtRWJu7RtpMHCiD3yleFpLTpPQrIbdwy2oUGs1cp7SiiVfJFI1Lb+
         lYLi52w6pfSF2oHGNGa2XB7NCC/9tsUMP515MsFTQGDz+5CO9Ey+y0jx5wnJRr3PWCjT
         VyEs3ehXdkPm38Ge21E22p3AY4SsLP3BerPOrU44FWi9ELTqWx7pRqytBaOjgylmb4pH
         J65B+u9bNGmNTjY8WWeGYm5nav8TbbsD0hC2VDTiRDSzsrrTA4qpCdRxgTLjoVL0Tf3D
         He5n8H2+D3rFtn4Q1a2pGxb/R53GzAflfe5lD4S2j6RX/Q5kDSG5SDfJ385EgHusrYvV
         lPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724339426; x=1724944226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGN1auVeefY0I3SVIHldm7HPYncKcBoISmYsv2msR0I=;
        b=JHYyH2rP4ymwseMA3a5J1O0XNmfdzNUaT9LrNwJ3f5luTXc8ct0mCecRSL6kuGnQlv
         Lk5yOU+dXqH2VE1+ELkFByZnO+m6FD4956aRQfb8O4r9oIND+0/3UC2bYci4O7xOHfbM
         6n5vaSewXWYn7Dma+9dL4ufoocE0h5bygKLbjY8II9/D63bVPKxHmzCc9Q2hDw97jWxB
         0fVM/NNYaCwXP8b3jmpd1qbr0IN6ivBpGsiXcEWrbXfgYlfiOLcZRDZZ/J3d80ZqZ8p7
         ZZ08ykIDDJvZV7WiglcLeBl9cX4jxrC1miJnqKmo8dXlp/dgxXuLJ0jGQQ7sdSHDVrkX
         8jfw==
X-Forwarded-Encrypted: i=1; AJvYcCXUgSaSUTzUiFciR7dM10weFVi8p37RpJ5ULqhvPI4jiZGSmPzqCF3mSvG5jQwQMK2XfxCnUy0RGV5hAyGczGwY@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwnjLg73cMf4Q8KexjMa9fIfnAAJJ0QIWXQmqqNVbpMSQiBLi
	0YRXwE5iu0omEYluPCNKBf5vBiI9y/8+FbR+7/aRys/PTg13nJBPvZkKYQyHkv3mb0JHmOqLmBU
	k5Qc+1e2MTtQ6IpxUF+tQDGYNUDVOrnD4aPzs
X-Google-Smtp-Source: AGHT+IESwpO1UAeEpXg3EgiwpxEOp/MTMQmKixdIWkP8fJQyl05ZaB8fSjfoilED5sWmiUr6HWO8fqKiXfwo3Btac2Y=
X-Received: by 2002:a17:902:dacf:b0:202:2d5:60dc with SMTP id
 d9443c01a7336-2038558996fmr2889105ad.13.1724339425813; Thu, 22 Aug 2024
 08:10:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822132506.1468090-1-james.clark@linaro.org> <db095820-58a7-4b40-a12a-04b2f82cf903@linux.intel.com>
In-Reply-To: <db095820-58a7-4b40-a12a-04b2f82cf903@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 22 Aug 2024 08:10:13 -0700
Message-ID: <CAP-5=fX632gBrCG6Z+oQGkk=daFcrGM605t_2H1Jo20sVwvtqQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] Event parsing fixes
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Ze Gao <zegao2021@gmail.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 7:32=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-08-22 9:24 a.m., James Clark wrote:
> > I rebased this one and made some other fixes so that I could test it,
> > so I thought I'd repost it here in case it's helpful. I also added a
> > new test.
> >
> > But for the testing it all looks ok.
> >
> > There is one small difference where it now shows "stalled-cycles-..."
> > as <not supported> events, when before it just didn't show them at all =
when
> > they weren't supported:
> >
> >   $ perf stat -- true
> >
> >   Performance counter stats for 'true':
> >
> >               0.66 msec task-clock                       #    0.384 CPU=
s utilized
> >                  0      context-switches                 #    0.000 /se=
c
> >                  0      cpu-migrations                   #    0.000 /se=
c
> >                 52      page-faults                      #   78.999 K/s=
ec
> >      <not counted>      cpu_atom/instructions/                         =
                         (0.00%)
> >            978,399      cpu_core/instructions/           #    1.02  ins=
n per cycle
> >      <not counted>      cpu_atom/cycles/                               =
                         (0.00%)
> >            959,722      cpu_core/cycles/                 #    1.458 GHz
> >    <not supported>      cpu_atom/stalled-cycles-frontend/
> >    <not supported>      cpu_core/stalled-cycles-frontend/
> >
>
> Intel didn't support the events for a very long time. It would impact
> many existing generations and all future generations.
> The current method is to hide the non-exist events. The TopdownL1 is an
> example. If it doesn't exist in the json file, perf stat will not
> display it.
> I don't think it's a good idea to disclose non-exist events in the perf
> stat default.
>
> The <not supported> doesn't help here, since there could be many reasons
> that the perf tool fails to open a counter. It just provides a
> misleading message for an event that never existed.

The list of "default" events, not metrics, similarly has "<not
supported>" in many configurations with "-dd" or "-ddd" on AMD. I'm
not sure the set of default events, at different detail levels, is
necessarily the best. The default events can also be a source of
multiplexing, for example, showing branch miss rate alongside topdown
metrics. Anyway, for the "<not supported>" we should probably be able
to tweak should_skip_zero_counter that is in stat-display.c and tag
these default events as "skippable".

Thanks,
Ian

> Thanks,
> Kan
> > I don't think that's a big deal though and could probably be fixed up
> > later if we really want to.
> >
> > Tested on Raptor Lake, Juno, N1, Ampere (with the DSU cycles PMU) and
> > I also faked an Apple M on Juno.
> >
> > Changes since v3:
> >
> >   * Rebase onto perf-tools-next 6236ebe07
> >   * Fix Intel TPEBS counting mode test
> >   * Fix arm-spe build
> >   * Add support for DT devices in stat test
> >   * Add a new test for hybrid perf stat default arguments
> >
> > Ian Rogers (5):
> >   perf evsel: Add alternate_hw_config and use in evsel__match
> >   perf stat: Uniquify event name improvements
> >   perf stat: Remove evlist__add_default_attrs use strings
> >   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
> >   perf evsel: Remove pmu_name
> >
> > James Clark (2):
> >   perf test: Make stat test work on DT devices
> >   perf test: Add a test for default perf stat command
> >
> >  tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
> >  tools/perf/arch/x86/util/evlist.c             |  74 +----
> >  tools/perf/arch/x86/util/evsel.c              |  35 ++-
> >  tools/perf/builtin-diff.c                     |   6 +-
> >  tools/perf/builtin-stat.c                     | 291 +++++++-----------
> >  tools/perf/tests/parse-events.c               |   2 +-
> >  tools/perf/tests/shell/stat.sh                |  33 +-
> >  .../perf/tests/shell/test_stat_intel_tpebs.sh |  11 +-
> >  tools/perf/util/evlist.c                      |  46 +--
> >  tools/perf/util/evlist.h                      |  12 -
> >  tools/perf/util/evsel.c                       |  28 +-
> >  tools/perf/util/evsel.h                       |  22 +-
> >  tools/perf/util/metricgroup.c                 |   4 +-
> >  tools/perf/util/parse-events.c                |  58 ++--
> >  tools/perf/util/parse-events.h                |   8 +-
> >  tools/perf/util/parse-events.y                |   2 +-
> >  tools/perf/util/pmu.c                         |   6 +-
> >  tools/perf/util/pmu.h                         |   2 +-
> >  tools/perf/util/stat-display.c                | 101 ++++--
> >  tools/perf/util/stat-shadow.c                 |  14 +-
> >  tools/perf/util/stat.c                        |   2 +-
> >  21 files changed, 348 insertions(+), 413 deletions(-)
> >
