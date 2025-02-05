Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F28518A6BA
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773461; cv=none; b=b//P/88Ee8UhiU4SL3U/d1hLl+OWbwktO8ugaQkJk03blGuqJKcAVOfn0vy+GbNFtaqNTNuhyohfP5hUIpUC658uabXt06TRZQMhho/REIJqNVBehjYjuR+vUFKbdRONroMHazAZW+7DDCDqlYk+IjT8BySDdh/3GaL8yeIBToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773461; c=relaxed/simple;
	bh=bNOKKT3WRUFpo997Z7H68M12mHyAmILfILAUEsy9ij0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJpOuo+Z54dytRnFPJlW5GejYwvQ6ZIQcsJ6MlLaK3EeAGTZMmGcJfteI0knt25JDpPxR57KwsIREsgD6kADwbirW2N0IYTX1kj29LcYKf4lqrKbUJX6KmEsCWBI3t+bfp2jGvYIy+J8r41fZpEp2hzt14f9fkqlLAE40Mzerro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POE/gZ16; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POE/gZ16"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-307d9a13782so950341fa.2
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738773457; x=1739378257; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EbY010afVshRghMlHcUYQ8NTia1RObj5hv00paiAnnQ=;
        b=POE/gZ16Dl7nULE+3keNUFIK4gqGLrcUsCndy30Q7R1u0UYD9YMY22Wn47LHamillI
         u81g4zCCh3QfVF5KjYtK9sWn3NlZlzUINAsFknkNFmRvvyyC8ARFWGI/DgQgbKmDLKIm
         YV1q+/VT5ivgalmQRRuln+HySfGxEb1k+byXJTzXtGnZN9Tc/9wKc4zplw1Xmd4xUOvA
         I9hbcalurvENK+KCWwXClyUfp5ERdX+30Ga8sk/I0Em6Ezm17FJjsQhS1V9x09/xb/nY
         No/i2a2ub4ue0W3Mcva9pvSC7UJ8OcCuq2zA2yZqjNwJu19sBU1bBcd9BW8HiIC/b4uE
         RX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773457; x=1739378257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbY010afVshRghMlHcUYQ8NTia1RObj5hv00paiAnnQ=;
        b=GZLQ4RsoQ82/VfKXb5bRsDOcBnLkfMhPITrc1M/2X9Ce1vrYOaUzOvEKvVGlwzM/xA
         aH01tTixFTZ80LUvVdaCDbcNptCTlrDGnO1skKYcRQgn+ps4zOVnZOCPezDL9dZd051Y
         zlyqmkZgO8N7a3JGTE0BMO0Wn9coywKbQ1Q+FJDQ1ez+rJQVz0oq4dQBG/QlQKr9gZyU
         uApBvwBTXVy6fVHDGuKrqdWMm1ooAdzzj+Ivzkp68BNwoK6Y/cOpH31DI+1ziGG/ZxT6
         hku1NnV/NuAAJF+tlj7Zo4CmX9CtZ6UgCW3mxdL6jtKAwpwRpJJ3CeRhhR+08OD8mDTe
         dAQg==
X-Forwarded-Encrypted: i=1; AJvYcCWigx/wAsmJMIZUIAhshaRqXClmq5dkA90WzZlWmaTfRSqewJXG1OjsVvtnFaTaLo7yyEOirKdK8YsJHN0yG8qu@vger.kernel.org
X-Gm-Message-State: AOJu0YxGBDYeX/gG7RlxmF3oCR/MGximh+Dk3XfgriYvVinKWc4aGW+f
	9EM5V4Lascyxsm0LK/APm+h3ZomvnA69N3ZtuJz9kkEWgOsI6Jl0vVzrYKgfg8Jh6dI/jbnwEcQ
	qsN4C34fFhPBn0F4muG1KaHFGVQDKNtX5sowO+UT2m0TlptrCuw==
X-Gm-Gg: ASbGncvvjbh3dI9Xe2znuW1C20OiBz64jJb3qEOn7RSqpGh4kHWy6xrPlt9D5Ry77uw
	udod/+qZi0t6LjVnv0ou+pS52I2jOWWZz5Fh+udDWAaFJg+Mnd60Ba03zIblNkR+Nrbf1sa7JWl
	sg4t8JpyjAuBwVLeo/AZtywlz0NQXCpA==
X-Google-Smtp-Source: AGHT+IEwhssSLHhx+8xA0LWdJKTUGZXB7UQVaXIcA/NB1uo9ZKR8cqCyoVOEZrxsyEMXURqGJvb3Nr64tVloU1V03Ck=
X-Received: by 2002:a05:651c:1509:b0:300:de99:fcc7 with SMTP id
 38308e7fff4ca-307cf38f82bmr11465811fa.36.1738773457268; Wed, 05 Feb 2025
 08:37:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738592865.git.dvyukov@google.com> <Z6GVqh6detN8rbKV@google.com>
In-Reply-To: <Z6GVqh6detN8rbKV@google.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 5 Feb 2025 17:37:25 +0100
X-Gm-Features: AWEUYZnYgNhKxAA5Zc3OF0HwBu6xcsaCXjrS52JZa-WiWVLFliw9F5rJQ5RIjA4
Message-ID: <CACT4Y+b9B6=ijtGfrtwQFq44ceiRTmv53pC9iqgNsbeg=cFr4Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] perf report: Add latency and parallelism profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 05:21, Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Mon, Feb 03, 2025 at 03:30:35PM +0100, Dmitry Vyukov wrote:
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
> >
> > Currently perf only allows to profile CPU time. Perf (and all other
> > existing profilers to the be best of my knowledge) does not allow to
> > profile wall-clock time.
> >
> > Optimizing CPU overhead is useful to improve 'throughput', while
> > optimizing wall-clock overhead is useful to improve 'latency'.
> > These profiles are complementary and are not interchangeable.
> > Examples of where latency profile is needed:
> >  - optimzing build latency
> >  - optimizing server request latency
> >  - optimizing ML training/inference latency
> >  - optimizing running time of any command line program
> >
> > CPU profile is useless for these use cases at best (if a user understands
> > the difference), or misleading at worst (if a user tries to use a wrong
> > profile for a job).
> >
> > This series add latency and parallelization profiling.
> > See the added documentation and flags descriptions for details.
> >
> > Brief outline of the implementation:
> >  - add context switch collection during record
> >  - calculate number of threads running on CPUs (parallelism level)
> >    during report
> >  - divide each sample weight by the parallelism level
> > This effectively models that we were taking 1 sample per unit of
> > wall-clock time.
> >
> > We still default to the CPU profile, so it's up to users to learn
> > about the second profiling mode and use it when appropriate.
> >
> > Changes in v4:
> >  - added "Shrink struct hist_entry size" commit
> >  - rebased to perf-tools-next HEAD
> >
> > Changes in v3:
> >  - rebase and split into patches
> >  - rename 'wallclock' to 'latency' everywhere
> >  - don't enable latency profiling by default,
> >    instead add record/report --latency flag
> >
> > Dmitry Vyukov (8):
> >   perf report: Add machine parallelism
> >   perf report: Add parallelism sort key
> >   perf report: Switch filtered from u8 to u16
> >   perf report: Add parallelism filter
> >   perf report: Add latency output field
> >   perf report: Add --latency flag
> >   perf report: Add latency and parallelism profiling documentation
> >   perf hist: Shrink struct hist_entry size
>
> I found that stdio output is broken that latency is too high.  TUI is fine.
>
>   $ ./perf report --latency -s dso --stdio
>   ...
>   #
>   #  Latency  Overhead  Shared Object
>   # ........  ........  ....................
>   #
>      57669.15%    57.67%  [kernel.kallsyms]
>      42330.85%    42.33%  ld-linux-x86-64.so.2

Fixed in v5.

> Thanks,
> Namhyung
>
> >
> >  .../callchain-overhead-calculation.txt        |  5 +-
> >  .../cpu-and-latency-overheads.txt             | 85 ++++++++++++++++++
> >  tools/perf/Documentation/perf-report.txt      | 49 ++++++----
> >  tools/perf/Documentation/tips.txt             |  3 +
> >  tools/perf/builtin-record.c                   | 20 +++++
> >  tools/perf/builtin-report.c                   | 39 ++++++++
> >  tools/perf/ui/browsers/hists.c                | 27 +++---
> >  tools/perf/ui/hist.c                          | 64 +++++++++----
> >  tools/perf/util/addr_location.c               |  1 +
> >  tools/perf/util/addr_location.h               |  7 +-
> >  tools/perf/util/event.c                       | 11 +++
> >  tools/perf/util/events_stats.h                |  2 +
> >  tools/perf/util/hist.c                        | 90 +++++++++++++++----
> >  tools/perf/util/hist.h                        | 32 +++++--
> >  tools/perf/util/machine.c                     |  7 ++
> >  tools/perf/util/machine.h                     |  6 ++
> >  tools/perf/util/sample.h                      |  2 +-
> >  tools/perf/util/session.c                     | 12 +++
> >  tools/perf/util/session.h                     |  1 +
> >  tools/perf/util/sort.c                        | 69 ++++++++++++--
> >  tools/perf/util/sort.h                        |  3 +-
> >  tools/perf/util/symbol.c                      | 34 +++++++
> >  tools/perf/util/symbol_conf.h                 |  8 +-
> >  23 files changed, 502 insertions(+), 75 deletions(-)
> >  create mode 100644 tools/perf/Documentation/cpu-and-latency-overheads.txt
> >
> >
> > base-commit: 8ce0d2da14d3fb62844dd0e95982c194326b1a5f
> > --
> > 2.48.1.362.g079036d154-goog
> >
