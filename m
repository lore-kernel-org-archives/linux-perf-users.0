Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135F3988F9
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682563; cv=pass; b=GDDsrz0zcK70u2nuoWiMto/KlAUd4MPAQcxWzhG9X62Kcx8TfoSnLivoPD7UJ0hVy1hf9DfnflYL5qN+20GtHvp/ihbbjR1oAJmzmP3cKY8aTYIcRJyExKenD/6GsZQAZ2o/Hc+1HXbm/coKe6YTr5HQjrVxD1e9LgtClTGPtzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682563; c=relaxed/simple;
	bh=3Fh+7y06PFFz5rLB74Sdz/3hB7ECtiIEet17uBStb88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5ckNO+bXBeEnv6PRA14aOIKmRhZcHzocnNAvBS/zrDoOs9NGTaXnggIHMahjV0FXxMVA/fViLLyKJrAn10NYUSREJZ0yh92U3SyW2V1xJ3W1XXXcRHxww8gPqZIep9+3mQx5ocZ8Qzt/MuogNCbz798EePiYeGlmr5AxSWRE68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4v2R9c9; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4v2R9c9"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137f27712fdso3815611c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 11:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780682560; cv=none;
        d=google.com; s=arc-20240605;
        b=Bt+qz16wrwoZQmV0MmDVK6Wof+s5+fwmZsA4k1jImuq73yeG4F23voRFC+NbdzICES
         6wmm1pXX7P8EY5kS4EjHePJk+c/h9gUEo2krnMRYdsOY2PYiSZDOev4ugVku/MV5RW3X
         LgNL3G0eULGz6Pgywv7+NhDbe1UdO3acwHwS2/mOAMDbLJASKNAwn73F34v8YdV2r/Sk
         U/7FAkAgtuu1i4osyQJzdDkCBS3kKEp8tX2+I+gZU//6uQV+mjsiL/QhVJ6lROr7lwzI
         hG36Ud/lptiBHV+3kQJ9uGrAIaXjMEA9fr1soni0lMSWQXYpHG7sszWmtFik2ygPgQko
         PIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M9L80N7evNnbEW53h8WC2HtJbkW1PMKagc9d07MoYMI=;
        fh=B0HGBLZsa31Uc3UpKwhKiw3TkQZKAd//lX8dAuSeZew=;
        b=UGYPthFTbwon4FId6sqM2YVTDp2STtHUh9TbRZQelTg4+zfjHmY3E8Kw3asdmCCWRF
         s+BmhKsi2iq3ZrhQTZDznE+JtUoFhLOCSsDHMKxsQYGIgvrhl36CXvx+4TIznRfvfUnc
         4LlyVcr9mS5EfCMHONwmg203bNyQec1WEOLZuNGUjZkcpCwKdPem6znAW+8MvZk+01Fg
         ZN9WdGb/BB1ygRsT5KfPaeJ7CINjYXIHxCFE5adO8YxfDb3u4+nMhWylNcf7tSk9+Vca
         W3co7JEN8C6uqWQngeSWlodaipiS+w677IXsH7zMeyMKLtv/UstZS6XnkC7M1BWgMNXV
         HO2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780682560; x=1781287360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9L80N7evNnbEW53h8WC2HtJbkW1PMKagc9d07MoYMI=;
        b=m4v2R9c9Wpm0a4tecaE+L5ebkVkjPyNVp+ADb+6UZxmurdVy6OnVTDekJ0Dm9eEqLw
         CHOvs2A582WPfqvIUKQt9N9pbWxOEGOIdWGRHinlAZcI+XPCB+AmI+Pk5NxWA2Xc4gy4
         0JzJ9CoIXAUx37e7FW4T2zYAWIoAbmFSxgMdZrP06ETI9/NWrZDkbOjwtAnq6LNANWyK
         0wmIJIss71zvNv/zsOREbOTs06ZaNuMvQcC+7+Vk3r+H4m3qQZFFSiKUAVVbPWw7wS9S
         ucoFVOEj2vfKRIO3wjggHzDBB5Gd3S3ypjnXsBLugdCEsDq0daLvQgUSWMhGbrnPcmx0
         DTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682560; x=1781287360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9L80N7evNnbEW53h8WC2HtJbkW1PMKagc9d07MoYMI=;
        b=YlUKkezM4NwgK/bjlrol7vHZQpSXhmtBBKwFCjHdJNG4IDAMa875ERJhstc/YcxkCj
         VkcVPiNIuTbScoyg5n8lTvuEClLV4x4z+gSyx1Ltp/ag5GNATyvUL8vA8bWxzZNuJvgi
         vuSWWmY3pu84RFdpSCRKrxGTWSLpVspQM2xg59n3WNPt5+AWo7JOfaenLtIUnQCfjjnl
         DHZzxQc/6kMw5Uui19TPWF1ItQnov5vOSFTlX9a6uDDNZwf6J6ZNNjtM0zXH81/ugcFX
         0+1nX6d9o4wtWzt1HhKw/uIivz2a8NSbFsPya2g2HEeQwF5qZuyuqTt0hNrNvYINFWFF
         dXAA==
X-Forwarded-Encrypted: i=1; AFNElJ/QCputnK+/f8hHYZ7eYipsMHBipm+JDTPIQsdHzYl4S9bhqjzPE5S7aUxhBmMGYpWdGLBzYb7PhZzUDeWLNFKh@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzLEQCnqmFgXtYglFjJ50tJPebHOOhl73wQOjt4KzG5EAEnJn
	0aPnsSk1m3FjbWOerOR0PCZuqVS9mdN1BJRjvlrKhQEz1bIPLB5nQOGFCHy8gTqVz9fxD7DQmuV
	sakuk1BWa9FB+xyUBVLxKSdSrKH+PxBhoF/Z9f2WD
X-Gm-Gg: Acq92OF/sYYMtNqcmkh1jj9zEyrGg4b2Lu0dhdMGRN64A1Ea0pYLqupJB4ooU4PR36X
	F3GdjcvgLXvW6sCq1pJ2aGqtUalxQXE8xAQ7ADq9o9UVPFv3ypDbCFn9pM6Sd+Mvgl7P28Fm+vE
	0Hp9L4v6I87pbVT0RNgF8T5LW9SSM3wh6EVWgJ2Gp0ahCMoqI51LtRZNKAOFvoWLTtMn8w4QW0k
	RsnGB6Ydz951yggy36p6aUBdLA0J4aDkBKyU+hoC9yH5ihHiAa5qT0rj/Esy9tnojb1rLfWrZXA
	lzGJV/io/wZv+EoA
X-Received: by 2002:a05:7022:618f:b0:12b:ec67:3529 with SMTP id
 a92af1059eb24-138066c0641mr2307092c88.14.1780682558807; Fri, 05 Jun 2026
 11:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com> <20260525231900.3527228-1-irogers@google.com>
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Fri, 5 Jun 2026 11:02:27 -0700
X-Gm-Features: AVHnY4I93GQpHSoewWmIaz9LEzu5rCryGt5gHCscKe6fufXxRfmNqf0Q5uVyCs0
Message-ID: <CAJpZYjW8c6fsK0rS3WqGv-p76MWJW34G_3k2PGKPArnO79qkpw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/14] perf stat: Decouple and modularize
 metrics/events output printing API
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, namhyung@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, May 25, 2026 at 4:19=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> This RFC patch series introduces a complete architectural refactoring
> to decouple and modularize the event and metric output printing
> engine inside 'perf stat'.

I really like this change. Historically, fixing printing format issues
in perf stat has been painful due to the tight coupling of printing
logic with aggregation and math in util/stat-display.c. Decoupling
these logics makes the codebase much easier to maintain and simplifies
future changes to the print format.

Acked-by: Chun-Tse Shao <ctshao@google.com>

>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Background and Motivation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Historically, 'perf stat' output printing was tightly coupled with
> data collection, aggregation math, and shadow metrics calculation.
> Formatting logic (Standard Console, CSV, and JSON) was scattered
> across util/stat-display.c, featuring massive, complex switch-cases,
> temporal adjacency assumptions, and duplicated layout logic. Adding
> new metrics, uncore PMUs, or topology-aware CPU aggregation modes
> frequently resulted in accidental layout regressions, broken field
> counts in CSV linters, or parsing crashes.
>
> This patch series decouples the data-traversal and shadows-metric
> calculations from the visual layout rendering, introducing a highly
> optimized, modular, and type-safe callback-driven print
> architecture.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Decoupled Printing Strategy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Format-Agnostic Traversal Driver (util/stat-print.c)
>    The core display logic is abstracted into a generic traversal
>    driver, perf_stat__print_cb(). This driver manages the complex
>    CPU/thread/topology aggregation loops, resolves hybrid wildcard
>    merges, filters default skipped uncore metrics, and calculates
>    raw shadow metrics. Once the data points are prepared, the driver
>    streams them cleanly to formatting callbacks.
>    - Safety: The core `calculate_and_print_metric` traversal is
>      fully protected with early-exit checks if formatting callbacks
>      choose to leave `print_metric` unpopulated.
>
> 2. Type-Safe Callbacks Interface (struct perf_stat_print_callbacks)
>    Output formats communicate with the driver using a clean
>    streaming interface:
>    - print_start(): Initializes format-private DOM states.
>    - print_event(): Buffers or prints raw counter event details.
>    - print_metric(): Buffers or prints calculated shadow metrics.
>    - print_end(): Finalizes rendering and cleans up structures.
>
> 3. Format-Specific Rendering Engines:
>    - Standard Console (util/stat-print-std.c):
>      Buffers events and metrics into standard-private DOM lists.
>      It resolves default metric-group skipped headers, prepends
>      formatted interval timestamps, aligns rows dynamically using
>      aggr_header_lens, and prints them cleanly in print_end().
>      - Refinement: Cleanly resolves `aggr_idx =3D=3D -1` global indices
>        by tracking bounds with a `-2` initialization indicator,
>        protecting all lookups from out-of-bounds array reads.
>        It safely resets the active event pointer if a zero counter
>        is skipped locally, avoiding temporal violation false-positives.
>    - CSV Printing (util/stat-print-csv.c):
>      Buffers events and metrics into format-private queues,
>      formatting rows separated by config->csv_sep. Corrects
>      metrics continuation padding to print exactly 4 separators,
>      ensuring column counts are strictly and visually valid.
>      - Refinement: Decoupled CSV headers now output static
>        structural labels (e.g. "cpu,", "die,") instead of live
>        hardware IDs, and prevent redundant header rows in interval
>        mode by persisting state tracking.
>    - Streaming JSON Printing (util/stat-print-json.c):
>      Implements a highly optimized, 100% streaming, zero-allocation
>      print engine that bypasses dynamic queues and metrics buffering
>      completely! JSON objects and interval keys are formatted and
>      streamed directly onto the output file descriptor, maximizing
>      speed and eliminating heap allocation overhead.
>      - Refinement: Completely zero-allocation fast-path rendering
>        inside `json_metric_only_print_metric` by streaming strings
>        directly without dynamic `asprintf` or `strdup` overheads.
>
> 4. Centralized Aggregation Prefix Formatting
>    Duplicates in CPU/thread aggregation prefix rendering are
>    completely eliminated by exposing arrays globally and introducing
>    shared generic helpers in stat-print.c:
>    - perf_stat__get_aggr_key(): Resolves the JSON key name.
>    - perf_stat__get_aggr_id_char(): Resolves the unified prefix.
>    This mathematically guarantees absolute structural and visual
>    consistency across all formats.
>
> 5. Temporal Coupling Sanity Checks
>    A strict temporal coupling constraint (that the traversal driver
>    always invokes print_metric() callbacks synchronously and
>    consecutively for the same PMU/event node immediately after its
>    print_event() callback) is formally protected by adding a
>    runtime evsel matching check inside both STD and CSV engines:
>    if (evsel !=3D ps->current_event->evsel) abort_print();
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Verification and Testing
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> All automated shell linters (stat+std_output.sh, stat+csv_output.sh,
> stat+json_output.sh) have been extended to run their entire
> aggregation suites a second time under the new printer flag
> (--new), passing with 100% success. The PMU metrics value Python
> validation script and stat_metrics_values.sh have also been
> extended with --new flag testing, ensuring complete mathematical
> correctness of calculated metric values.
> - Test Quality: JSON linter checks define dynamic `api_label`
>   indicators to generate highly distinguishable and descriptive
>   output logs between legacy and `--new` passes.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> - calculate_and_print_metric: added safe print_metric NULL callback check=
.
> - should_skip_zero_counter: added safe aggr_idx bounds check to avoid
>   out-of-bounds mapping array access when aggr_idx is negative.
> - std_print_event: reset ps->current_event pointer on skipped zero counte=
rs
>   to avoid temporal coupling mismatch violations.
> - std_metric_only_print_end: only print metric headers once in
>   interval mode, and print dynamic spacing padding to perfectly
>   align columns.
> - csv_metric_only_print_end: only print CSV headers once in
>   interval mode, print static aggregation labels instead of live
>   hardware IDs, and fix column misalignment under AGGR_GLOBAL by
>   initializing current_aggr to -2 sentinel.
> - json_metric_only_print_metric: completely zero-allocation fast-path
>   rendering by streaming combined keys directly without dynamic heap stri=
ng
>   allocations, and resolve AGGR_GLOBAL indices by initializing
>   last_aggr_idx to -2.
> - stat+json_output.sh: define dynamic api_label to generate highly
>   distinguishable and descriptive output logs between legacy and
>   --new passes.
> - merged duplicate skip_test block structures inside linter shell scripts=
.
> - documented -2 sentinel choices as C comments inside standard, CSV,
>   and JSON print engines.
>
> We would highly appreciate reviews, comments, and feedback on this
> decoupled output printing strategy.
>
> Assisted-by: Antigravity:gemini-3.5-flash
>
> ***
>
> Ian Rogers (14):
>   perf stat: Introduce core generic print traversal engine and header
>     stubs
>   perf stat: Implement standard console (STD) formatting callbacks
>   perf stat: Extend STD output linter to test basic New API checks
>   perf stat: Extend STD output linter to test core aggregation checks
>   perf stat: Extend STD output linter to test advanced PMU checks
>   perf stat: Extend STD output linter to test metric-only checks
>   perf stat: Implement CSV formatting callbacks
>   perf stat: Extend CSV output linter to test core aggregation checks
>   perf stat: Extend CSV output linter to test advanced PMU and
>     metric-only checks
>   perf stat: Implement streaming JSON formatting callbacks
>   perf stat: Extend JSON output linter to test core aggregation checks
>   perf stat: Extend JSON output linter to test advanced PMU and
>     metric-only checks
>   perf stat: Add --new support to PMU metrics Python validator
>   perf stat: Extend PMU metrics value linter to validate --new outputs
>
>  tools/perf/builtin-stat.c                     | 261 +++---
>  .../tests/shell/lib/perf_metric_validation.py |  12 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |  19 +
>  tools/perf/tests/shell/stat+json_output.sh    |  74 +-
>  tools/perf/tests/shell/stat+std_output.sh     |  18 +
>  tools/perf/tests/shell/stat_metrics_values.sh |  13 +-
>  tools/perf/util/Build                         |   4 +
>  tools/perf/util/stat-display.c                |  28 +-
>  tools/perf/util/stat-print-csv.c              | 534 ++++++++++++
>  tools/perf/util/stat-print-json.c             | 330 ++++++++
>  tools/perf/util/stat-print-std.c              | 773 ++++++++++++++++++
>  tools/perf/util/stat-print.c                  | 490 +++++++++++
>  tools/perf/util/stat-print.h                  | 133 +++
>  tools/perf/util/stat.h                        |   2 +
>  14 files changed, 2519 insertions(+), 172 deletions(-)
>  create mode 100644 tools/perf/util/stat-print-csv.c
>  create mode 100644 tools/perf/util/stat-print-json.c
>  create mode 100644 tools/perf/util/stat-print-std.c
>  create mode 100644 tools/perf/util/stat-print.c
>  create mode 100644 tools/perf/util/stat-print.h
>
> --
> 2.54.0.794.g4f17f83d09-goog
>
>
