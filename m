Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A541A3029
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 04:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784176378; cv=none; b=PpbS/WQgSXuHhNt4ivvDNfn1ocYBKLUTNqbCbdtibEKydFHfrcnoFc9ex92yQPW2CFzxLxgnP3tsOrDhgFdKapPQ5g+j9FaWldL2VaNsNFbXLIhCA8St4dD9HoNE9zvisOOiIDEP4EzXw7eNkTDxjVeqjJBwta0hKHDTVaMDCYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784176378; c=relaxed/simple;
	bh=b35rXffZYFEDkTobyqbBJXoM4GZDXWeK0joExTqvg+g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gvt++47qn/5BMTzF2y4TKhbUSOpfw1cs/btTQMPKRCf9yzohhuaRz3XJaLgDvhnrFnBkZ/boS2LhnnFWdzRyt0CluKwgNcPV77ohtWKhA0IPCpSvyAXJvTQZWJwNziJm6HjPCa48yHJ5uMHVNCrypWFLSSgq5SP5TY4EY+olScE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pPnBocWm; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPnBocWm"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so4487823a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 21:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784176377; x=1784781177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DhzoqwN5HbrEvT9zJU8a2Bw0ptYhAl2ZYOUB0LRqaUU=;
        b=pPnBocWmNcvOK0yHCdWaXutFMwpuCFnNi04Ho8jYDEfKqVsuCvh3O68Mv+jzuHBnGx
         tVTPeVKvvD4B6Rfi8dee40fMlu+lip5g76e3xMwnhwZKWEKngEQyl3QWCmGGaTd5jHGL
         Je7Vt8xcIsc3sqQrSFjKQ6N0pNTrv2PJCw2ysqFSaLb+676Yl1uS2ZQSMewjqhGUN/qJ
         PqGucJ4BUxJJshDvScZ8uxmHDx+Lz6qRyZUj2n/71x5fc8c0Oe5V9SsX+wJ1kyBwZJf/
         3HedIXLzgeWET8FUjLaJMwAHDG/Lg15heiWW5eWn2t6hGQqQTBddk5momPoC+fyMyNOk
         iAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784176377; x=1784781177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DhzoqwN5HbrEvT9zJU8a2Bw0ptYhAl2ZYOUB0LRqaUU=;
        b=Lns5PdHtVHl0wLfPYKsqLi1chGFsfCgQJ3LTDEaexfnWzXr2MuoLghnkgyLg7wDk9C
         hV9KfQzSJ/iAo6MWKCPdWjuXQ64+itbxcdjv+QjbU+EDZR91nd6ndvsz9VqbMoamMqbn
         D8aDhnXwi1LcNDsacIFcCo9PY2gC/wNiLhFzJvXguhBXjBFSyig5x6w0hCs85ebt+kJf
         9uBxIlpIqUj+nrYV5pFN2BG72hCtc+4pz9GfO2GHeBvnuoI6aaYG7r+i2ZD1RpRs1vOQ
         bAV6b5PsdLnqZ4Z4ioQ60VUy8W9VFc0au57Cu4yjVU23M0lQvN0+62hZliNKpDtAJKni
         9Iqg==
X-Forwarded-Encrypted: i=1; AHgh+Rp9nc6YXuFZzJYKVYGBy9tVEllpUB21kFCDcOGdky+O35KmjJxoLIkkkLMQfCvQBLq2oFDsQ94yaxXHzmrmLq/L@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpvgk+Mhgq/UM2Ikh4Gb9yKTN9kt08qY1HbmJ/XIINxLIJfKV
	usV+Qdp71j6h5ULh7HGdKsQ02a+CLaGuPRwrXGGld5BvKQxwCj+Sb0R9J1DNGl/ixdJBGHzYA/l
	TU+5u6Bl/5A==
X-Received: from dlad14.prod.google.com ([2002:a05:701b:220e:b0:139:c8ec:c97d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a3:b0:3bf:8de9:c647
 with SMTP id adf61e73a8af0-3c36bd75a44mr5853273637.0.1784176376642; Wed, 15
 Jul 2026 21:32:56 -0700 (PDT)
Date: Wed, 15 Jul 2026 21:32:09 -0700
In-Reply-To: <20260525231900.3527228-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260525231900.3527228-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716043223.388233-1-irogers@google.com>
Subject: [PATCH v3 00/14] perf stat: Decouple printing API and introduce
 streaming zero-allocation printers
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	ctshao@google.com
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This is V3 of the patch series implementing the decoupled perf stat printing
architecture. This series fully separates the format-specific display engines
(STD, CSV, JSON) into distinct isolated files, and guarantees 100% streaming,
zero-allocation output for interval metric-only JSON data to avoid debug
artifact overwrites and large allocations on extended system-wide runs.

Changes since v2:
 - Fixed trailing newline count and padding logic for wide metric names
   in standard console (STD) metric-only interval modes, resolving reports
   from Sashiko AI.
 - Resolved aggr header label misalignments for Socket/Die/Node/Cache modes.
 - Addressed debug artifact overwrite bugs in the `stat_metrics_values.sh`
   rules validation engine by correctly scoping execution passes and preserving
   artifacts upon failure.
 - Reverted all reflow diff noise in `builtin-stat.c` and legacy metric print
   functions in `util/stat-display.c` per feedback from Arnaldo.
 - Converted all format callback file creations to use standard `//` SPDX header
   formatting directly in the patch series to prevent downstream diff noise.
 - Resolved all internal brace styles, variable declaration spacing, and unwrapped
   commit description warnings reported by checkpatch.pl.
 - Added all requested Acked-by tags from reviewers.

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

 tools/perf/builtin-stat.c                     |  96 +-
 .../tests/shell/lib/perf_metric_validation.py |  12 +-
 tools/perf/tests/shell/stat+csv_output.sh     |  19 +
 tools/perf/tests/shell/stat+json_output.sh    |  74 +-
 tools/perf/tests/shell/stat+std_output.sh     |  18 +
 tools/perf/tests/shell/stat_metrics_values.sh |  22 +-
 tools/perf/util/Build                         |   4 +
 tools/perf/util/stat-display.c                |   6 +-
 tools/perf/util/stat-print-csv.c              | 534 +++++++++++
 tools/perf/util/stat-print-json.c             | 330 +++++++
 tools/perf/util/stat-print-std.c              | 828 ++++++++++++++++++
 tools/perf/util/stat-print.c                  | 489 +++++++++++
 tools/perf/util/stat-print.h                  | 133 +++
 tools/perf/util/stat.h                        |   2 +
 14 files changed, 2488 insertions(+), 79 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

-- 
2.55.0.141.g00534a21ce-goog

