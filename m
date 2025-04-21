Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850841E0E13
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745259243; cv=none; b=tK9OxOrAXgpTuwmkvGx1hZQ/IxHK+4gcCf6PBGMUP0FdX3GfdlT0iPGnph308YqTjYnHJCg31OaP339EvPSjGiJNXdIDfThRtOgyO1LW90CQRp9egzvmPyTMIr841n0dnCL8Pd8x4Wvo7k2FuqBuPyeAZaJKj/A9aoNJbW8+f04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745259243; c=relaxed/simple;
	bh=Dx3ZHUL9E1ojXKrvbylKm8F/ZaQ8GYvgvr96INe2BY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGWx6nMVFUogF2DGZ1mykc9Fu8tXsyxsfYGdnJom6tyEM1dNAh7fCt+rrw0Cm4S9IloMezcsc8npvKe2VL87keLT6GAqYpJlIbJZi4EnYJLqEcDDuvYeTAOWu48nV+AIRIn9M2e6VmqbmocPfE3WQmkXr9Wdtb8B3XP4HDJusFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uUAZaxaI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uUAZaxaI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2264c9d0295so663305ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745259241; x=1745864041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6OAHSiFq2Kxf/za9DNOM0li2sYlcsimAoaxoA4SzGQ=;
        b=uUAZaxaIQsDj6EsMVC5jr2XqIAgtB/+tTPmJU+VTNAzFI6uIoks4UAVYrAR7ORN8zh
         bp5q5s8409O7PogR9MTrCXUvMZrT9a4bndYlL+y7DMVrDfjKuQeMaNTcLIGTrzM1YQoZ
         N3zQSWSFJVsidf4pNDAnmA90b9Bu/0WWPQHK+Hog7yzyCfe3TRvrm/Z7IV54AcpCRZUh
         RauWnoALnQgTUnkpcako5O7uX6A4cXjET8C0PiK448CQGbsNSFtY28JHM20wzbhZvC/A
         5cVPzz81XuYmRuk2DUBJwQjP0D07G+62ozcf9RuuT/puIFmhpeAw4ioDH+4unD3H3OIC
         pFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745259241; x=1745864041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6OAHSiFq2Kxf/za9DNOM0li2sYlcsimAoaxoA4SzGQ=;
        b=aO+FJWAKv442i39dMcVDEJuD7J0sk8KVbZrXALrO/cOqd3dzE5C0LuYy5l23OE7Is0
         VeFnswOnIacwsDU0DOjfXf0t3G2YKQa+CmCLoMg9YeoZEIkCnnbLx/21xqN8yl+3TQBu
         SyI2gZ2/YNI0z3ioJRHo5Y8vj8/k8bnViws0ui5VW9yacJeRrfTygSp/t/11scRp+MDT
         bZbfkKoQYGZFaQ37zP5ShjuX9q2Md4l10OT32nr9kCQqKi5+XUakI6K/bRSRLdYXocQX
         arorTe2LB1yOWtHqdt+kDjG2rhLTYl5ZPNjjibhuVhczDsFH/mehAZ3ukVv3PQBZEoLM
         yuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV2sEOfDXsU7n3Bevw/eiLjt3PEhO187xwo16OZUtPn3cawFLwTCsLO8L93twIqjqUN0bhDaDpriMXN8Nk1nqY@vger.kernel.org
X-Gm-Message-State: AOJu0YyXaF5DQpNBMggjoxt8Ir6YsTRY8uhtQ4oMtvQy2aVuCnYI6nOl
	taRoVo+Nngred+YPXJiBRVSL6kZ7j6ffKWd9LzHtZ+OuzNSbr0mfRlti5hB/iM5VNgXHg9lk/5b
	F4xZf5wpckS5R8SA77LjQwCoeMCOaUQStRgnS
X-Gm-Gg: ASbGncvfhDM2VMwoq7eL8fEaivc2ZlrHI+aBr6cgCjABczEX7bc1gImnqs+66R6CT2r
	8P8xQoQhodCp44dmw8fcNTZWShPft1I9p9usZUQ8AM5qvzVHMLrWq1HN7ExjmPgLiQYXqEcz+5s
	rCorgCFNLF0DXf2c+ZqTOx/HZy59wr34C3pgiDKhnhFKFT7jXfBl4=
X-Google-Smtp-Source: AGHT+IEJG2ib+qYhTWGr2wagSAM+B5LRJYSOCHKG/BJb6F2RNoSKOge95A/PvmsJNLlsc+qlPgcgtIeBhRy63dcnT1Q=
X-Received: by 2002:a17:903:174d:b0:216:7aaa:4c5f with SMTP id
 d9443c01a7336-22c543b9165mr5205385ad.3.1745259240585; Mon, 21 Apr 2025
 11:14:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414174134.3095492-1-irogers@google.com> <cfa0aa31-3fe7-4174-8cce-89e8aadbcd07@linux.intel.com>
In-Reply-To: <cfa0aa31-3fe7-4174-8cce-89e8aadbcd07@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Apr 2025 11:13:49 -0700
X-Gm-Features: ATxdqUEQQPrlTikQhjR1QjQGiUz09XHTEa6qZIV59SbU7YdFZemi7Rlz4Af13zk
Message-ID: <CAP-5=fVo_yGgEwndavWaNAQRg=1MR121PQ-KwOW0HsUWGBLLnA@mail.gmail.com>
Subject: Re: [PATCH v5 00/16] Intel TPEBS min/max/mean/last support
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 12:08=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2025-04-14 1:41 p.m., Ian Rogers wrote:
> > The patches add support to computing the min, max, mean or last
> > retirement latency and then using that value as the basis for metrics.
> > When values aren't available, support is added to use the retirement
> > latency as recorded for an event in the perf json.
> >
> > Support is added for reading the retirement latency from the forked
> > perf command more than once. To avoid killing the process commands are
> > sent through the control fd. Some name handling is changed to make it
> > more robust.
> >
> > Rather than retirement latency events having issues with perf record,
> > make it so that the retirement latency modifier enables sample
> > weights.
> >
> > Note: the retirement latency JSON updates are part of:
> > https://lore.kernel.org/lkml/20250328175006.43110-1-irogers@google.com/
> >
> > v5: Add Namhyung and Weilin's tags. Fix missing error path mutex
> >     unlock spotted by Namhyung.
> >
> > v4: Don't use json min/max in retirement latency stats as they will
> >     never update afterwards. Warn once if json data is used when TPEBS
> >     recording was requested.
> >
> > v3: Two fixes from Kan Liang. Ensure min/max statistics don't vary
> >     when real samples are encountered.
> >
> > v2: Addition of header cleanup patch originally posted:
> >     https://lore.kernel.org/lkml/20241210191823.612631-1-irogers@google=
.com/
> >     as there are no arch specific reasons not to build this code.
> >     Fix bug in "perf pmu-events: Add retirement latency to JSON events
> >     inside of perf" where "t->stats.n !=3D 0" should have been
> >     "t->stats.n =3D=3D 0".
> >     Add patch so that perf record of a retirement latency event
> >     doesn't crash but instead enables sample weights for the event.
> >
> > Ian Rogers (16):
> >   perf intel-tpebs: Cleanup header
> >   perf intel-tpebs: Simplify tpebs_cmd
> >   perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
> >   perf intel-tpebs: Separate evsel__tpebs_prepare out of
> >     evsel__tpebs_open
> >   perf intel-tpebs: Move cpumap_buf out of evsel__tpebs_open
> >   perf intel-tpebs: Reduce scope of tpebs_events_size
> >   perf intel-tpebs: Inline get_perf_record_args
> >   perf intel-tpebs: Ensure events are opened, factor out finding
> >   perf intel-tpebs: Refactor tpebs_results list
> >   perf intel-tpebs: Add support for updating counts in evsel__tpebs_rea=
d
> >   perf intel-tpebs: Add mutex for tpebs_results
> >   perf intel-tpebs: Don't close record on read
> >   perf intel-tpebs: Use stats for retirement latency statistics
> >   perf stat: Add mean, min, max and last --tpebs-mode options
> >   perf pmu-events: Add retirement latency to JSON events inside of perf
> >   perf record: Retirement latency cleanup in evsel__config
> >
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Ping.

It would be great if we could land:
https://lore.kernel.org/lkml/CAP-5=3DfWxuKHLZJjd2NVWjA7ktCX6X3yQBsH2kh+eTTa=
NcSqbTg@mail.gmail.com/T/#m1bba00c3a699397b54e1a77da9b9ff392b435e4d
and then land this series.

Thanks,
Ian

> Thanks,
> Kan
>
>
> >  tools/perf/Documentation/perf-stat.txt   |   7 +
> >  tools/perf/builtin-stat.c                |  29 +-
> >  tools/perf/pmu-events/empty-pmu-events.c | 216 +++----
> >  tools/perf/pmu-events/jevents.py         |   6 +
> >  tools/perf/pmu-events/pmu-events.h       |   3 +
> >  tools/perf/util/Build                    |   2 +-
> >  tools/perf/util/evlist.c                 |   1 -
> >  tools/perf/util/evsel.c                  |  22 +-
> >  tools/perf/util/evsel.h                  |   6 +
> >  tools/perf/util/intel-tpebs.c            | 682 ++++++++++++++---------
> >  tools/perf/util/intel-tpebs.h            |  40 +-
> >  tools/perf/util/parse-events.c           |   4 +
> >  tools/perf/util/pmu.c                    |  52 +-
> >  tools/perf/util/pmu.h                    |   3 +
> >  14 files changed, 666 insertions(+), 407 deletions(-)
> >
>
