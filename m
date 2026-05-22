Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380CC2DAFDF
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779489244; cv=none; b=D9NlYWIYZY9EuJxpAxkCaq09I8XZC27lMe/m24OqQHnabvIpUm2d8yab2JkbYr7ZuF2czJMEFWteUwvg2YnNdOiT5JbP9btgp7q51AfQIPd8/IRMQCTR54ld4wyxvDGQJ6Iq7Zy0B0HPC+YcXLAoSvLSfhFZGZsynZmIpVTxtfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779489244; c=relaxed/simple;
	bh=IgD9lwWYLc40i+mRbpOHn4IIx3d/rFLyldT0e9pQNBg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=fQTvSez5zPGHxerfgnYVE7fBmFSWLuzCAUzWwE0oIRHmjzZ0Tmv9uObyABXHK0WzZ274rs03IvxyYqwEvu3wpvcYzyTwGagCbZlVTJ1jNRwJoV1gbZXby0+/boxNHDWWrRvGVqt4cUGXFQq3LpygEt723kh7P11QC7q4DFYGbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ftbOhos3; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ftbOhos3"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-30457ff05b8so946221eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779489242; x=1780094042; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yCWfMIwYAYqhmbKv9uHgcoQzXaY2DfWC3IcKMJ/nAA0=;
        b=ftbOhos3l78z2ewvZ6QeMp98rt6FEQoMPpW/Wwk0EIgbLiPDKbj0NB7bE72Z3FkOqz
         /7574JL13v/dZtrVSKdAr4rvUxsgPTr+uk6daYyZJ5fY0cVMTkj3Zez0P/xAgRIYdZkA
         zSkbKO0lTn7EgbFVe6kEFt9+uEzuTz+hjYJ7zZTEk+jVwsezwSwsroBLbucWHXnBdkMw
         CrHZLAnw0BeelD5mDCISbndAPCmiTzOwwrbx/30thCU3iHK7G7jyNHhiFFntxzJVpxEa
         gLECVj6QqVcFstX/EqeR468I2KPEtwWbeVzvnibv/4lXI5HPpKIPRuQxDnwb2sRLI2wl
         4lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779489242; x=1780094042;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yCWfMIwYAYqhmbKv9uHgcoQzXaY2DfWC3IcKMJ/nAA0=;
        b=Vy5QrVAEomIgipBCKYLE88AArJWDazp98KUYlzeR/zYL8lmXAhxoBtWMFLM2/OPrOY
         +CMEPz6C3P5VQf6VPQV8pbYi0kNN6RqeCNB3lZ1LMtHtysGbfcaNxZTaAVdzwdLYPIVq
         Z+enM7A7+uXsrJquGnTEr8+TcrkcLYXMf8nJDPgWV5hKEnsuOXtc4eK+LrB9D0r/eIU6
         hI9XkShneunK9iYTlyXVTm1uIE7+aAfV+JwqKsPfikpnKxMbKt23V5etixD4S+p/NFiO
         I2n6rFKkIa2s8MEoFcn8TjMYIvOLqbWkNPFKb0CgaYZIy/afhTcqGN0foFeEtl1gS8lY
         m7Pg==
X-Forwarded-Encrypted: i=1; AFNElJ+teAJB5LJYDFJjOVIFlnqgZgjyExe70n52xpaACGUA00szsSzo8PvYDT9bOjYylP7Fr2HfRDSbnV4UL1SPWuzU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyku6OuuPXQzUt6cX6iSMtlkDVpSy/A6SMXBwA6JS3zkFGtrlqA
	UyYEAvQV1m/8xcqF7uGeK1egomvXgLeQOa8HC+Oy7t9/L4ctxXfPibtmSXefAqyOwmO9zkWQwVu
	hVmKyiuLLVA==
X-Received: from dyrx37.prod.google.com ([2002:a05:7300:3aa5:b0:304:2d1f:6ca6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:ea7:b0:2d9:6373:ad24
 with SMTP id 5a478bee46e88-30449093ee2mr2566744eec.26.1779489242025; Fri, 22
 May 2026 15:34:02 -0700 (PDT)
Date: Fri, 22 May 2026 15:33:28 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522223342.2393553-1-irogers@google.com>
Subject: [RFC PATCH v1 00/14] perf stat: Decouple and modularize
 metrics/events output printing API
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This RFC patch series introduces a complete architectural refactoring to decouple
and modularize the event and metric output printing engine inside 'perf stat'.

======================
Background and Motivation
======================
Historically, 'perf stat' output printing was tightly coupled with data collection,
aggregation math, and metrics calculation. Formatting logic (Standard Console,
CSV, and JSON) was scattered across util/stat-display.c, featuring complex
switch-cases, temporal adjacency assumptions, and duplicated layout logic. Adding new
metrics, uncore PMUs, or topology-aware CPU aggregation modes could result in
accidental layout regressions. A recently reported regression was:
https://lore.kernel.org/linux-perf-users/20260513144906.557896-1-ak@linux.intel.com/

This patch series decouples the data-traversal and shadows-metric calculations from
the visual layout rendering, introducing a modular callback-driven print architecture.

======================
Decoupled Printing Strategy
======================
1. Format-Agnostic Traversal Driver (util/stat-print.c)
   The core display logic is abstracted into a generic traversal driver,
   perf_stat__print_cb(). This driver manages the CPU/thread/topology
   aggregation loops, resolves hybrid wildcard merges, filters default skipped uncore
   metrics, and calculates raw metrics. Once the data points are prepared,
   the driver streams them cleanly to the output formatting callbacks.

2. Type-Safe Callbacks Interface (struct perf_stat_print_callbacks)
   Output formats communicate with the driver using a streaming interface:
   - print_start(): Initializes format-private DOM states or buffers.
   - print_event(): Buffers or prints raw counter event details (val, ena, run).
   - print_metric(): Buffers or prints calculated shadow metric values and thresholds.
   - print_end(): Finalizes rendering, formats padding, and cleans up state structures.

3. Format-Specific Rendering Engines:
   - Standard Console (util/stat-print-std.c):
     Buffers events and nested metrics into standard-private DOM lists. It resolves
     default metric-group skipped headers, prepends formatted interval timestamps,
     aligns continuation rows dynamically using aggr_header_lens, and prints them
     cleanly in print_end().
   - CSV Printing (util/stat-print-csv.c):
     Buffers events and metrics into format-private queues, formatting rows
     separated by config->csv_sep. Corrects metrics continuation padding to print
     exactly 4 separators, ensuring column counts are strictly and visually valid.
   - Streaming JSON Printing (util/stat-print-json.c):
     Implements a highly optimized, 100% streaming, zero-allocation print engine
     that bypasses dynamic queues and metrics buffering completely! JSON objects
     and interval keys are formatted and streamed directly onto the output file
     descriptor, maximizing speed and eliminating heap allocation overhead.

4. Centralized Aggregation Prefix Formatting
   Duplicates in CPU/thread aggregation prefix rendering are completely eliminated
   by introducing shared generic helpers in stat-print.c:
   - perf_stat__get_aggr_key(): Resolves the JSON key name.
   - perf_stat__get_aggr_id_char(): Resolves the unified aggregation ID string
     (e.g. "S0-D0-C0", "comm-pid").
   This mathematically guarantees absolute structural and visual consistency across
   all formats (Standard console pads dynamically, CSV splits by separator, JSON
   injects key-value pairs).

5. Temporal Coupling Sanity Checks
   A strict temporal coupling constraint (that the traversal driver always invokes
   print_metric() callbacks synchronously and consecutively for the same PMU/event
   node immediately after its print_event() callback) is formally protected by
   adding a runtime evsel matching check inside both STD and CSV print engines:
   if (evsel != ps->current_event->evsel) abort_print();

======================
Verification and Testing
======================
All automated shell linters (stat+std_output.sh, stat+csv_output.sh,
stat+json_output.sh) have been extended to run their entire aggregation suites a
second time under the new printer flag (--new), passing with 100% success. The PMU
metrics value Python validation script and stat_metrics_values.sh have also been
extended with --new flag testing, ensuring complete mathematical correctness of
calculated metric values.

All files have been beautifully formatted, passing scripts/checkpatch.pl with
exactly 0 errors on C and header code paths!

======================
Next Steps
======================
We would highly appreciate reviews, comments, and feedback on this
decoupled output printing strategy. After sufficient use, and because
tools are sensitive to output formatting, the "--new" option can be
the default. We can then look to remove stat-display.c and
stat-shadow.c.

***

Ian Rogers (14):
  perf stat: Introduce core generic print traversal engine and header
    stubs
  perf stat: Implement standard console (STD) formatting callbacks
  perf stat: Extend STD output linter to test basic New API checks
  perf stat: Extend STD output linter to test core aggregation checks
  perf stat: Extend STD output linter to test advanced PMU checks
  perf stat: Extend STD output linter to test metric-only checks
  perf stat: Implement CSV formatting callbacks
  perf stat: Extend CSV output linter to test core aggregation checks
  perf stat: Extend CSV output linter to test advanced PMU and
    metric-only checks
  perf stat: Implement streaming JSON formatting callbacks
  perf stat: Extend JSON output linter to test core aggregation checks
  perf stat: Extend JSON output linter to test advanced PMU and
    metric-only checks
  perf stat: Add --new support to PMU metrics Python validator
  perf stat: Extend PMU metrics value linter to validate --new outputs

 tools/perf/builtin-stat.c                     | 261 ++++---
 .../tests/shell/lib/perf_metric_validation.py |  12 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  22 +
 tools/perf/tests/shell/stat+json_output.sh    |  49 +-
 tools/perf/tests/shell/stat+std_output.sh     |  21 +
 tools/perf/tests/shell/stat_metrics_values.sh |  13 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/stat-print-csv.c              | 527 +++++++++++++
 tools/perf/util/stat-print-json.c             | 338 ++++++++
 tools/perf/util/stat-print-std.c              | 739 ++++++++++++++++++
 tools/perf/util/stat-print.c                  | 487 ++++++++++++
 tools/perf/util/stat-print.h                  | 129 +++
 12 files changed, 2456 insertions(+), 146 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

-- 
2.54.0.794.g4f17f83d09-goog

