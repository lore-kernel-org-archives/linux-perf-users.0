Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662CC24BC11
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 14:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183629; cv=none; b=U34nC0bFPvFmIe3BbDv9p18mHG+Y041EWButl5c2YLApyEG+bwS5SQL2bAJHT5nT63XhYReD2Xo9bk9R1G+UC4uqBZ2Wfx6q/D9HXPWX8CysVgyWy37HsZaQaOAyyNWHH1GzKrE4wS6B9riX1JS4m/LZ0ShuhVnFg6DS4Rzte7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183629; c=relaxed/simple;
	bh=FjaeIhTNdKMmPpFK6XfmpXumPWRdtaSKMyBsnUumCQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHyOGFKroaExl+MAc9Y5OJVw7oG1xoWSLsn5ZrlEIr7d2Py/7xDgtkJj4odWYvTqmYKyg7WW6jSXLMWIL9ZhQqwDouwUEincN93YVeh3xON7QZgL29p+EuO8gswNPiUQlcuRgmmrVyFFTnExEeHeWkeQQ0wfSXBnXHSB9Wt9LZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/cxe7Ab; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/cxe7Ab"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22342c56242so166695ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 06:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741183626; x=1741788426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/6W12xTgoKBwdDU6FZ6FI7BGZR4+Y6EvyzLeszV9vQ=;
        b=M/cxe7Abfvuxa5WmLdQBJfnTvOeORUUVcZ2C4sd2C2yOaGXcKY0SDUtidBk+cS9Csv
         9wgCusQSM50SNSR8VMrj4MSA4zSNezuA0LHtCmckXfiSG8BLAIkpdyInMnMPxlf/RJf4
         Q2anBZqEtmMHmZSHWPM9oK9hakmKy9EcMut/GBNihlOswyckO0EsV8KqwY/VPN1SOLp6
         SfhKNvxZ5zFVQBox5DPa0ht6JT5LOCIV5pKpzvSiw4Gycp3priOiw41W2HMcSW50+6fl
         ChO0Vb0DICWT29FMdFUi2ppDNsLcp+84ehWgPufGFqIJWDNgc8uCeBh4/F7D0gcOjh7p
         9o2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741183626; x=1741788426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4/6W12xTgoKBwdDU6FZ6FI7BGZR4+Y6EvyzLeszV9vQ=;
        b=ZblB9tumD6KjsdHvyiqpOi5KfCqaRybr7gTuHKb6HBBsw1JASEXd3PfENXkn1JGH+K
         EH2lyBiRORMBe/BFgz3FQaQxd+KljXKpsAy4qDiF35z+2YvRbLkNVGZDlKlFTIkeaCQW
         6R/xW0yFeHjgaSHKQoHR0qZrxgZQqjik18dP1pJhPvGJcy/XdhVkjPaE/5d8EoW4fo8e
         326sHmInTDr0VtCMRdT+Inefk9u0pe5I1MAsMqA12LTJ6jn36KOI3SI9+HrJLP3wFXuj
         fauGAvpJNAP1PYc9F6GdCxrkcV1dWZ4sQpyP8I3Rd9ZfPRRXobvUZ2E4cbHXBRjJMee4
         fagQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFF1597HFNeMPHtLN9XcA3YvzFqW+pf+Wc3+kj9KXHXmO/wGTY0UxzgSukYbn/R8Zsv929x2yV5EY7ggBoInie@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ8NMUmXEFwvYiMRKXQirl9URfKtszraCrUjDQKVlSrtE6tSfT
	teWDi8sCKMinyae7rI/qWzquTqg5d4vnTd5No1yCyd8/3sLsldYF/rLNVVTuBX1qQV/vHpDhSgm
	THHx09hQBHXOMu2qZSc4AxCaLK//wQXwcTwGAXDqordudo4yK6tBx
X-Gm-Gg: ASbGncsjNPfriWNlJj9Ul3ZVfwt+qcu5iL5oEJVOEsXj/57KwshApv3Xyt8vg9mbV1a
	PuXS3tiCFomP4XxhOLb1ronn59rC7WHT2Wamymjn+njiha7HlZ23NR7RlL/9dV2Cbvtg2Lhcmtm
	zJawbicaJpPtpRwyCCPtZR/6CK1dQ=
X-Google-Smtp-Source: AGHT+IEKSHHYr8188K9ntmJciY47CcWvf6ZohiVQ/T+y3MDsXI32//5qi0ZmXcjGDzT7A1Fuf5ToO2bW8eZG8xGReGI=
X-Received: by 2002:a17:902:f809:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-223f2700461mr2875315ad.26.1741183625420; Wed, 05 Mar 2025
 06:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305083735.393333-1-irogers@google.com> <20250305083735.393333-2-irogers@google.com>
 <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
In-Reply-To: <e2ea3776-12d2-41c2-9b7b-836c7c249c45@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 06:06:54 -0800
X-Gm-Features: AQ5f1JoxD1jbTg08KjqHao7OjOP92CCi6YqUvtq1vHnaNmgjvf06g2yd9I0-Rfg
Message-ID: <CAP-5=fW0LESRaZkGv-UCZGU_ttYi6kdF=dxJZP8KmVTiTwBM+Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf parse-events: Corrections to topdown sorting
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Andi Kleen <ak@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 5:44=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 05/03/2025 8:37 am, Ian Rogers wrote:
> > In the case of '{instructions,slots},faults,topdown-retiring' the
> > first event that must be grouped, slots, is ignored causing the
> > topdown-retiring event not to be adjacent to the group it needs to be
> > inserted into. Don't ignore the group members when computing the
> > force_grouped_index.
> >
> > Make the force_grouped_index be for the leader of the group it is
> > within and always use it first rather than a group leader index so
> > that topdown events may be sorted from one group into another.
> >
> > Reported-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > Closes: https://lore.kernel.org/lkml/20250224083306.71813-2-dapeng1.mi@=
linux.intel.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Testing on Arm seems ok, but presumably this doesn't change anything
> there because arch_evsel__must_be_in_group() is always false.
>
> On x86 I ran into the topdown metrics not opening on cpu_core at all, so
> I'm not sure if I'm able to test that the original issue is fixed on my
> machine. From looking at the link the issue is that the ungrouped
> topdown event is "<not supported>", but I always see that regardless of
> grouping despite perf list saying it exists:
>
>   $ perf list --unit cpu_core | grep -i topdown
>    topdown-bad-spec OR cpu_core/topdown-bad-spec/     [Kernel PMU event]
>    topdown-be-bound OR cpu_core/topdown-be-bound/     [Kernel PMU event]
>    topdown-br-mispredict OR cpu_core/topdown-br-mispredict/[Kernel PMU
> event]
>    topdown-fe-bound OR cpu_core/topdown-fe-bound/     [Kernel PMU event]
>    topdown-fetch-lat OR cpu_core/topdown-fetch-lat/   [Kernel PMU event]
>    topdown-heavy-ops OR cpu_core/topdown-heavy-ops/   [Kernel PMU event]
>    topdown-mem-bound OR cpu_core/topdown-mem-bound/   [Kernel PMU event]
>    topdown-retiring OR cpu_core/topdown-retiring/     [Kernel PMU event]
>    topdown.backend_bound_slots
>    topdown.bad_spec_slots
>    topdown.br_mispredict_slots
>    topdown.memory_bound_slots
>         [TOPDOWN.MEMORY_BOUND_SLOTS. Unit: cpu_core]
>
>
>   $ sudo perf stat -e topdown-retiring -- true
>   Performance counter stats for 'true':
>       <not counted>   cpu_atom/topdown-retiring/           (0.00%)
>     <not supported>   cpu_core/topdown-retiring/
>
>
>   $ sudo perf stat -e topdown-retiring -vvv -- true
> Control descriptor is not initialized
> Opening: topdown-retiring
> ------------------------------------------------------------
> perf_event_attr:
>    type                             10 (cpu_atom)
>    size                             136
>    config                           0xc2 (topdown-retiring)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8 =3D 3
> Opening: topdown-retiring
> ------------------------------------------------------------
> perf_event_attr:
>    type                             4 (cpu_core)
>    size                             136
>    config                           0x8000 (topdown-retiring)
>    sample_type                      IDENTIFIER
>    read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
>    disabled                         1
>    inherit                          1
>    enable_on_exec                   1
> ------------------------------------------------------------
> sys_perf_event_open: pid 151404  cpu -1  group_fd -1  flags 0x8
> sys_perf_event_open failed, error -22
> switching off exclude_guest for PMU cpu_core
> Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit,
> falling back to no-inherit.
> Warning:
> topdown-retiring event is not supported by the kernel.

Yep, unfortunately there is a requirement that a topdown event like
topdown-retiring is always programmed with slots on performance cores.
The slots event must be the group leader. You can see in metrics the
slots event as "+ 0 * slots":
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=3Dperf-t=
ools-next#n754
```
        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0
* slots",
```
and making it the group leader is done by the sorting:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/x86/util/evlist.c?h=3Dperf-tools-next#n67

We could probably add something to
parse_events__sort_events_and_fix_groups to inject the slots event,
but this hasn't been done yet.

My main concern with this change is there is some sensitivity to the
event ordering when parsing them in scripts. There's some context in:
https://lore.kernel.org/all/20230719001836.198363-1-irogers@google.com/
This change makes the topdown events appear first in the group always,
but as you say you only see that if you use those events, otherwise
things are unchanged.

Thanks for testing!
Ian
