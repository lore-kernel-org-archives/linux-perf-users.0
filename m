Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98354261B70
	for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779751153; cv=none; b=dLl5silC4PGwYGQ+fEuwK5NqQFkMN7Dj7w1eHSICbqA+QAk9UC0kACXNnE7OecuSLu8W/y0QxVZ6h6qVOF4KjFevy7oeNxOn2fdZwzTQD3MTZbJIJi0bk6p07VXhs6fFl1UkNHZP0PPMvXH+cQ5+lqW+NDN0s/M2vAyxNBGsxtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779751153; c=relaxed/simple;
	bh=+n/IwjwJ8AmRS3mMi61ETnRGwojre1H/cd22R2TtMUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LkcO4CLTsyt6ccuYHal2cc8vpRwmi1DgsZykJevFjdOJcPzg3660Y1IlGgZTIYCEHCEenM8YWy8dxORc3/6E6ydICexwXf/q1+XzHqoGaYrbUSiTUmYInKsT4ueBW9MGCjTH60jnvdguviLlxe/nAGvCejVvyxMarH5L3krQBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VuXAzGfZ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VuXAzGfZ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f5943ca81aso880063eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 25 May 2026 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779751151; x=1780355951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5ZdotmQ0R9PQo5mh9GEfaqI2cP+jxq1Z2iep8+kNOE=;
        b=VuXAzGfZrLhhO0dmPbCCN6iksDbm+/C/Lu82cJV8doK6vTV7vbL/NObULEQKljCx3d
         4TYgEkfhR093tosApqE4OzYonHzsQPR1CAMAYeK4++jt8ktY5bduBr28u8MT//Ad32FJ
         ltbR7BU+Pa/afcHpGKaFcWq7gH3pDagny7llDfnoRJ/nIyOlRHKU5uskCFYiu7d0wBEs
         uV9tq7YI5uEd0bXYZoxMNE6r8fs3bVPYn9UIaPA3DMTQV+HGDHA0kkbMaDE1tr4HKzTp
         kTMeWMw1dAwx41GPTiqf65QnS81LNpY84ZW3vO4R2S9CyAQQCvcAfnx9aQGNPMjfziHd
         eFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779751151; x=1780355951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5ZdotmQ0R9PQo5mh9GEfaqI2cP+jxq1Z2iep8+kNOE=;
        b=eeYJWWzBswLhMN7UXfj99qzdu/EYDWiQwHXm6IYVOe8gD+vsjszbxfRA0AmqIsMLmi
         JSfb5U1yS+5/5/vIm4tbghd4FtBKV9FwbmdKQCYtqZKAg8pVoIpdwKME5BTECuaHWWMe
         j0OOHQuC72JObxsrl8DkRkYfEXXn8gzhVD3M5NaoGyu6kOqQv/cEtQ9Jh4gEZPV/BINE
         oyw+PSukYJiH8Sh0it8sSwkJAtxjOuQhrN2ON02QfPl39wCdqn/QoxClu2ms+/lkR8Dh
         FwqTt9HtVwnW320wRBgQwpze+mve/UrNTsgQe5qn1icrtvfi+GaawGax8l7iwIPpxm2B
         ALbw==
X-Forwarded-Encrypted: i=1; AFNElJ+bZS8sz49rc4jvWlpfyNOtdsH1cRDGxWu0EOJ6tsKZ3slI1A7RPLVh2V/qxrle3BOLe3ChBdAswFf4VAXPiMuT@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNSMYB34PviNO9io6VVvfdKfl6eqY7lNES7u84aD5+VTh/o4j
	fLkh5jVyIXLGMyQeRLbENpv6dC2FarMKdQ+AjYP3POqcVIYuMbNbTzTczBL6a8f9VpF1uArO9u6
	mCUaNU/Ml/g==
X-Received: from dycnd20.prod.google.com ([2002:a05:7301:c14:b0:2fd:bdd1:8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2b06:b0:2d9:6373:ad10
 with SMTP id 5a478bee46e88-304490383d1mr7649865eec.7.1779751150437; Mon, 25
 May 2026 16:19:10 -0700 (PDT)
Date: Mon, 25 May 2026 16:18:46 -0700
In-Reply-To: <20260522223342.2393553-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522223342.2393553-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260525231900.3527228-1-irogers@google.com>
Subject: [RFC PATCH v2 00/14] perf stat: Decouple and modularize
 metrics/events output printing API
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This RFC patch series introduces a complete architectural refactoring
to decouple and modularize the event and metric output printing
engine inside 'perf stat'.

======================
Background and Motivation
======================
Historically, 'perf stat' output printing was tightly coupled with
data collection, aggregation math, and shadow metrics calculation.
Formatting logic (Standard Console, CSV, and JSON) was scattered
across util/stat-display.c, featuring massive, complex switch-cases,
temporal adjacency assumptions, and duplicated layout logic. Adding
new metrics, uncore PMUs, or topology-aware CPU aggregation modes
frequently resulted in accidental layout regressions, broken field
counts in CSV linters, or parsing crashes.

This patch series decouples the data-traversal and shadows-metric
calculations from the visual layout rendering, introducing a highly
optimized, modular, and type-safe callback-driven print
architecture.

======================
Decoupled Printing Strategy
======================
1. Format-Agnostic Traversal Driver (util/stat-print.c)
   The core display logic is abstracted into a generic traversal
   driver, perf_stat__print_cb(). This driver manages the complex
   CPU/thread/topology aggregation loops, resolves hybrid wildcard
   merges, filters default skipped uncore metrics, and calculates
   raw shadow metrics. Once the data points are prepared, the driver
   streams them cleanly to formatting callbacks.
   - Safety: The core `calculate_and_print_metric` traversal is
     fully protected with early-exit checks if formatting callbacks
     choose to leave `print_metric` unpopulated.

2. Type-Safe Callbacks Interface (struct perf_stat_print_callbacks)
   Output formats communicate with the driver using a clean
   streaming interface:
   - print_start(): Initializes format-private DOM states.
   - print_event(): Buffers or prints raw counter event details.
   - print_metric(): Buffers or prints calculated shadow metrics.
   - print_end(): Finalizes rendering and cleans up structures.

3. Format-Specific Rendering Engines:
   - Standard Console (util/stat-print-std.c):
     Buffers events and metrics into standard-private DOM lists.
     It resolves default metric-group skipped headers, prepends
     formatted interval timestamps, aligns rows dynamically using
     aggr_header_lens, and prints them cleanly in print_end().
     - Refinement: Cleanly resolves `aggr_idx == -1` global indices
       by tracking bounds with a `-2` initialization indicator,
       protecting all lookups from out-of-bounds array reads.
       It safely resets the active event pointer if a zero counter
       is skipped locally, avoiding temporal violation false-positives.
   - CSV Printing (util/stat-print-csv.c):
     Buffers events and metrics into format-private queues,
     formatting rows separated by config->csv_sep. Corrects
     metrics continuation padding to print exactly 4 separators,
     ensuring column counts are strictly and visually valid.
     - Refinement: Decoupled CSV headers now output static
       structural labels (e.g. "cpu,", "die,") instead of live
       hardware IDs, and prevent redundant header rows in interval
       mode by persisting state tracking.
   - Streaming JSON Printing (util/stat-print-json.c):
     Implements a highly optimized, 100% streaming, zero-allocation
     print engine that bypasses dynamic queues and metrics buffering
     completely! JSON objects and interval keys are formatted and
     streamed directly onto the output file descriptor, maximizing
     speed and eliminating heap allocation overhead.
     - Refinement: Completely zero-allocation fast-path rendering
       inside `json_metric_only_print_metric` by streaming strings
       directly without dynamic `asprintf` or `strdup` overheads.

4. Centralized Aggregation Prefix Formatting
   Duplicates in CPU/thread aggregation prefix rendering are
   completely eliminated by exposing arrays globally and introducing
   shared generic helpers in stat-print.c:
   - perf_stat__get_aggr_key(): Resolves the JSON key name.
   - perf_stat__get_aggr_id_char(): Resolves the unified prefix.
   This mathematically guarantees absolute structural and visual
   consistency across all formats.

5. Temporal Coupling Sanity Checks
   A strict temporal coupling constraint (that the traversal driver
   always invokes print_metric() callbacks synchronously and
   consecutively for the same PMU/event node immediately after its
   print_event() callback) is formally protected by adding a
   runtime evsel matching check inside both STD and CSV engines:
   if (evsel != ps->current_event->evsel) abort_print();

======================
Verification and Testing
======================
All automated shell linters (stat+std_output.sh, stat+csv_output.sh,
stat+json_output.sh) have been extended to run their entire
aggregation suites a second time under the new printer flag
(--new), passing with 100% success. The PMU metrics value Python
validation script and stat_metrics_values.sh have also been
extended with --new flag testing, ensuring complete mathematical
correctness of calculated metric values.
- Test Quality: JSON linter checks define dynamic `api_label`
  indicators to generate highly distinguishable and descriptive
  output logs between legacy and `--new` passes.

======================
Changes since v1:
======================
- calculate_and_print_metric: added safe print_metric NULL callback check.
- should_skip_zero_counter: added safe aggr_idx bounds check to avoid
  out-of-bounds mapping array access when aggr_idx is negative.
- std_print_event: reset ps->current_event pointer on skipped zero counters
  to avoid temporal coupling mismatch violations.
- std_metric_only_print_end: only print metric headers once in
  interval mode, and print dynamic spacing padding to perfectly
  align columns.
- csv_metric_only_print_end: only print CSV headers once in
  interval mode, print static aggregation labels instead of live
  hardware IDs, and fix column misalignment under AGGR_GLOBAL by
  initializing current_aggr to -2 sentinel.
- json_metric_only_print_metric: completely zero-allocation fast-path
  rendering by streaming combined keys directly without dynamic heap string
  allocations, and resolve AGGR_GLOBAL indices by initializing
  last_aggr_idx to -2.
- stat+json_output.sh: define dynamic api_label to generate highly
  distinguishable and descriptive output logs between legacy and
  --new passes.
- merged duplicate skip_test block structures inside linter shell scripts.
- documented -2 sentinel choices as C comments inside standard, CSV,
  and JSON print engines.

We would highly appreciate reviews, comments, and feedback on this
decoupled output printing strategy.

Assisted-by: Antigravity:gemini-3.5-flash

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

 tools/perf/builtin-stat.c                     | 261 +++---
 .../tests/shell/lib/perf_metric_validation.py |  12 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  19 +
 tools/perf/tests/shell/stat+json_output.sh    |  74 +-
 tools/perf/tests/shell/stat+std_output.sh     |  18 +
 tools/perf/tests/shell/stat_metrics_values.sh |  13 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/stat-display.c                |  28 +-
 tools/perf/util/stat-print-csv.c              | 534 ++++++++++++
 tools/perf/util/stat-print-json.c             | 330 ++++++++
 tools/perf/util/stat-print-std.c              | 773 ++++++++++++++++++
 tools/perf/util/stat-print.c                  | 490 +++++++++++
 tools/perf/util/stat-print.h                  | 133 +++
 tools/perf/util/stat.h                        |   2 +
 14 files changed, 2519 insertions(+), 172 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

-- 
2.54.0.794.g4f17f83d09-goog

