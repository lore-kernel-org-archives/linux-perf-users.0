Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC32125B2
	for <linux-perf-users@vger.kernel.org>; Tue, 14 May 2024 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715662134; cv=none; b=Ab7Y/nxhF76u3baddOqhuVykwyEnUZVj3rs+KSX5h/t0UJKcI3cDZJADfa9rEqOJuzvsn+hgWtNg5XwdzRUJ+gQgFKVYLe91ZoesFze76Xt4V+tDDrY+17vXa9MmTFPn6RtwTQePoAiW+SuF2mmLHj9x+cGtQUfVt/PrjeS0jkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715662134; c=relaxed/simple;
	bh=xA6emBQVwVuglSd8BdKXUOzTu+AXBbD0wHHpuBd1VRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=U7ISd0/GdO2OchpfZYrDciR4VEFHFJr2ERFC1AvaILlTZYc2q5VbmK+5LfsCdMfePrrg2z3vw5Foz2K5EYMdzsBbw7lhGBVFDbOA7k+2vcITllSQRSsy8pJG7oYN/50lJKHz5yH1d59ZgNOLXAU0JUG0i+f8GvkDP4W7AOfOWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zu+u4Faw; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zu+u4Faw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-43e14f0bd75so300981cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 13 May 2024 21:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715662132; x=1716266932; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXFf6Eq00urqf0wFdNRBo6rl3kq0as0cRcr6U5+BnfU=;
        b=zu+u4FawyAFkqJeP3EkVra4NL2EvwFt4KNbJ/e2BsDn6fJvgqv6dKcDdeVyYsdV+We
         3+Ndr83vGyHJiBx/ttxIVa+cpOuLtN5L/rBKL3yyjraYMbLja0xNLtf0VTeXyUaoOA7C
         UjxzyvND6AhUfWQyRZlMAutwupsqZ4xo1FBzS7CMSYk5PrH5YWdKVHwcVpX685jdY6O8
         4nVzsr1+09DrHr8jOqbX8HtZJbFIIbFK21JouWopQyuAy8nDzhVBjML1c+jvi4d1by0K
         9Q+5S9F41xeaDvOxljocqCek3vB3xKrPcaYgz7UoggBRBH9GOjyTemMqK2bYHjV6S25j
         MiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715662132; x=1716266932;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXFf6Eq00urqf0wFdNRBo6rl3kq0as0cRcr6U5+BnfU=;
        b=XPuLxYyu+ixL7IFQIBJ1kTxY6A2+YMC2jXjUeGlRZrPSIC25CB3wNj2XLukktoqZmP
         4bCeE3erH3djrqThHAm9QGQAX3idb+KKso4pjKjV4ZdKiEJ6qZMVCaybSW6q2RVch65V
         qTzOuH2Kk+/hhp3TBD9XcSeeSHh5yyxFv3xWsNKM24TzRhUYOYEX6o54y3MdPuNgptKm
         uKcXO51gTyLE+pLIobtxE2GHCM2R/vM0vSGs4NZSClBthQ6RQZWO+4w3i5cW0DUSv5hb
         zY14lub/9MzZ2Pajuxty+UziFvYxRTlNFNJUDvdKshficC5Bvs8w7aoy82aUmvf3NUl0
         hZeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXntL9pd5HSVZRUbuXbZQPJwR17Q47zTATIx6w1A0bgymh3iFlpyWsxTJxpfC/6bhaWcqX5rn3jJz2CgHh8f7w20XLTPH6Quo0TIoC1a9Q0dQ==
X-Gm-Message-State: AOJu0YyLrKQ5sawWxX9q1VgQwyjn22PY9bHfosh2KiDXgXBbZNxFcqE6
	x9wgyZ1inYOgQjM2K2bvsxMrl+arkmweVtm+y5djGehUbE26fGyuR3FpLsaOaZaxmU/uQ7qzZjB
	G+VavyT1sdYzJmBH0vrpftSFy+rQ4jm+HySda
X-Google-Smtp-Source: AGHT+IEaJEKQvY6jBBoB4XoOHxarSpuByI4wdMGrcHyrxgOa4Qt93kUKoinfcp6O09S4vAXY3qaeTBVGvSvGAat8z7Q=
X-Received: by 2002:a05:622a:4886:b0:43d:a002:b with SMTP id
 d75a77b69052e-43e0a1c2014mr6775881cf.9.1715662131679; Mon, 13 May 2024
 21:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510053705.2462258-1-irogers@google.com>
In-Reply-To: <20240510053705.2462258-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 May 2024 21:48:40 -0700
Message-ID: <CAP-5=fW_Ri1yOfq2QS1_NOV0+kNm+n+Vv03v3FjfbRet4Ztn7Q@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Event parsing fixes
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	James Clark <james.clark@arm.com>, Yang Jihong <yangjihong@bytedance.com>, 
	Ze Gao <zegao2021@gmail.com>, Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Kaige Ye <ye@kaige.org>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:38=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> For the default events, parse from strings rather than use pre-cooked
> perf_event_attr. This fixes non-x86 heterogeneous CPUs where legacy
> hardware events wouldn't be opened for all PMUs. v2 was previously
> just patch 3 but it is extended in v3 to incorporate related fixes.
>
> When a sysfs/json event is used in preference to a legacy event, allow
> evsel__match to still function using a saved hardware config
> number. This fixes hard coded metrics in stat-shadow for events like
> "instructions" on Intel that have a sysfs file.
>
> Fix/improve uniquifying event names fixing the test "102: perf stat
> metrics (shadow stat) test:" that was broken by a formatting issue
> when the sysfs instructions event was used.
>
> Having evsel->pmu_name and evsel->pmu->name is confusing, get rid of
> the former. Fix/improve evsel__sys_has_perf_metrics in the process.
>
> Ian Rogers (5):
>   perf evsel: Add alternate_hw_config and use in evsel__match
>   perf stat: Uniquify event name improvements
>   perf stat: Remove evlist__add_default_attrs use strings
>   perf evsel x86: Make evsel__has_perf_metrics work for legacy events
>   perf evsel: Remove pmu_name

Hopefully the first 3 patches here can be a priority given the fixes.

Thanks,
Ian

>  tools/perf/arch/x86/util/evlist.c |  74 +-------
>  tools/perf/arch/x86/util/evsel.c  |  35 +++-
>  tools/perf/builtin-diff.c         |   6 +-
>  tools/perf/builtin-stat.c         | 291 ++++++++++++------------------
>  tools/perf/tests/parse-events.c   |   2 +-
>  tools/perf/util/evlist.c          |  46 +----
>  tools/perf/util/evlist.h          |  12 --
>  tools/perf/util/evsel.c           |  28 ++-
>  tools/perf/util/evsel.h           |  22 +--
>  tools/perf/util/metricgroup.c     |   4 +-
>  tools/perf/util/parse-events.c    |  52 ++++--
>  tools/perf/util/parse-events.h    |   6 +
>  tools/perf/util/pmu.c             |   6 +-
>  tools/perf/util/pmu.h             |   2 +-
>  tools/perf/util/stat-display.c    | 101 ++++++++---
>  tools/perf/util/stat-shadow.c     |  14 +-
>  tools/perf/util/stat.c            |   2 +-
>  17 files changed, 305 insertions(+), 398 deletions(-)
>
> --
> 2.45.0.118.g7fe29c98d7-goog
>
