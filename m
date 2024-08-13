Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45B19EECF
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 14:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559742; cv=none; b=LfmAoWp9GV2/zjE1sddkDzenjb8z9hGXgehPSZl9JhqLIYpTIjelaa32v93ipjerF1EfcHU9UE3LMCO7+wHpbGPz6U2t11SQt1PzOW5VYtlUpip22OLe2H7bxwuMpsIde/IEDkxFGwSL91/Yox4Ulm/afV6L4PQG9tnFWLio6Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559742; c=relaxed/simple;
	bh=/U0bEOSp/3QdNXRfWrsK41EAsnN5dwry0LytGlDVYsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPDvoRGPST/P2nTt3ZoWE1yWhIt8pbfTNorFlr7MpE+qh+MriNBzVLk4qfA8bblfCtMOhV+ORb76hYmuqEHj1afo9OnzfLBtz0bbxnTE/oCzTtFeDIax9zubuRR374myeoQxSQHD39RC/qX+3WYf/+05h+VTiiRVV3WZekgHmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=38nbkUAF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="38nbkUAF"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fd657c9199so77015ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 07:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723559741; x=1724164541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7pc96sK52WRBwn+cvdiy9TXwY56asjOvTauds/TjSE=;
        b=38nbkUAF6kmDRq53lxkJe//uyeyNuSOE6KW9mpjkiOjH1BZ3RlohGQZKIAnnXgr/cW
         9gGf5+9IBSfPpb+Yr6YeUSJEHxmjsqv65YbynnrNobGU8Li7cyPVOXCmSK2Rh7DQai5N
         C8C1qvseMIcn8aP++1m54pJ+k3KvXYV4ouPEUmggs2Is9GL9iYmA426HK6xR3PGwpbrd
         /HJIBdJUiwxoQOcUuLOlQ/LHV5GrlBCFd+wNIwQCGettDCkkTseoTkJH/GjZzUETHC2m
         p3lpLr6jqVjaf3RAoh7Q1Env18lbX+OtQ2q0QEphGANS25YxATLNUdKIkr4Zf3XYTGiy
         S5ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723559741; x=1724164541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7pc96sK52WRBwn+cvdiy9TXwY56asjOvTauds/TjSE=;
        b=G3/NLV/zCKkfSOdqkHKBAA1QlBae5mndI6bzN9JOGEddxJEWpe4WTDlviEKofBgUgA
         rk0IOAYTdSgQ6Q7P6SP2CjuFh7yMVyDUUZ5ht0GAzX1DuG9x+I3lwMivbMFW7eR2QpD9
         PPBrtMxNOpVzFUHEzqLESpuu9i8J/RKlFVLkLZ6Xh1PpU06bxGkREepYT/3kpFmph95j
         CUEM1WFtQhPGBYoCmHXfAm/OCEcH919ABwmuE1wpYMsNXVvaWuViYhDOIFHbWNxzdjcU
         xKZr2NdvQl8MZYLoVBJmX8/8iBSENlpaTyacX2QG0+8wGULf2OEEortQx4VO+/dErVLX
         BzZQ==
X-Gm-Message-State: AOJu0Yx4r67pvWh2VvNFzN4eu4MHaTq3w4GNs/lfmVT8zHwxMhi7dTGO
	EEPXafTlJKpfmnI3CjWW5MD4gM+GAiqRfvBtdfQTybV+JLoJKBcwBjepNEAsClaRZ1rh5SCyPEB
	9gQEPm6xHgU2VZzbNMJB43lbBeFJ0+a8KY+WX
X-Google-Smtp-Source: AGHT+IE0VoC9VcV6SgZkxmyeAJGUUTFJJ9xLJ8cYKbx41BA9DBvjiYvv/gf36S/dHf7zHn5/HI4NvYNzjlRN3bKejUg=
X-Received: by 2002:a17:903:2302:b0:1fb:2924:5c7e with SMTP id
 d9443c01a7336-201cdc2cfc4mr1273945ad.11.1723559740228; Tue, 13 Aug 2024
 07:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813132323.98728-1-james.clark@linaro.org>
In-Reply-To: <20240813132323.98728-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Aug 2024 07:35:27 -0700
Message-ID: <CAP-5=fUVchraZxYg9LY-CtqYZ5DN05-T3vhJmaUG+24Ka6Bsyg@mail.gmail.com>
Subject: Re: [PATCH 0/7] perf stat: Make default perf stat command work on Arm big.LITTLE
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong1@huawei.com>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 6:24=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The important patches are 3 and 5, the rest are tidyups and tests.
>
> I don't think there is any interaction with the other open issues
> about the uncore DSU cycles event or JSON/legacy hw event priorities
> because only hw events on core PMUs are used for the default
> stat command. And also just sharing the existing x86 code works so
> no big changes are required.
>
> For patch 3 the weak arch specific symbol has to continue to be used
> rather than picking the implementation based on
> perf_pmus__supports_extended_type() like in patch 5. This is because
> that function ends up calling evsel__hw_name() itself which results
> in recursion. But at least one weak arch_* construct has been removed,
> so it's better than nothing.

Let's not do things this way. The use of strings is architecture
neutral, means we don't need to create new arch functions on things
like RISC-V, it encapsulates the complexity of things like topdown
events, Apple ARM M CPUs not supporting legacy events, etc.
Duplicating the existing x86 logic, when that was something trying to
be removed, is not the way to go. That logic was a holdover from the
hybrid tech debt we've been working to remove with a generic approach.

Thanks,
Ian

> James Clark (7):
>   perf stat: Initialize instead of overwriting clock event
>   perf stat: Remove unused default_null_attrs
>   perf evsel: Use the same arch_evsel__hw_name() on arm64 as x86
>   perf evsel: Remove duplicated __evsel__hw_name() code
>   perf evlist: Use hybrid default attrs whenever extended type is
>     supported
>   perf test: Make stat test work on DT devices
>   perf test: Add a test for default perf stat command
>
>  tools/perf/arch/arm64/util/Build   |  1 +
>  tools/perf/arch/arm64/util/evsel.c |  7 ++++
>  tools/perf/arch/x86/util/evlist.c  | 65 ------------------------------
>  tools/perf/arch/x86/util/evsel.c   | 17 +-------
>  tools/perf/builtin-stat.c          | 12 ++----
>  tools/perf/tests/shell/stat.sh     | 33 ++++++++++++---
>  tools/perf/util/evlist.c           | 65 ++++++++++++++++++++++++++----
>  tools/perf/util/evlist.h           |  6 +--
>  tools/perf/util/evsel.c            | 19 +++++++++
>  tools/perf/util/evsel.h            |  2 +-
>  10 files changed, 119 insertions(+), 108 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/evsel.c
>
> --
> 2.34.1
>
