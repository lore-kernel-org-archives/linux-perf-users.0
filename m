Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCF36F90A
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 07:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185394; cv=none; b=q0SUQuq+0Y8RDRnoY8VrWud0ZLrW4/F0vVnVGMTRaeLzZf/cE7dKKlRurBb+G35Ez8Abbo1tTwbAnepCgasZYKre56Prwd2i9fsXdPb/95KZJQoWs4zheJYIDCSXBDvIvvjtFx6Hb6fyHZQsGP/qirDFkgwiuyJp7aC5F+TM1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185394; c=relaxed/simple;
	bh=c2OABlHCPvMQD/HEQfrClCFfnkR2NAvt/Hmg6G13q7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qA9vy/Gjh/qWcadqt2zATCW+fYvdaHWIbu/wWow750rN+LlAnZOeRw1lgmau+IAPqoZg9SWXA5967HnU9JDBKZth4beNPVEdg+98FBu06qL/yFgbpQF7dASUBSSF4DVvUnHUnjlJn0XMiOb+x2mTa1NfJTc9Q7DKIhPXV7EKo8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtK1iL3V; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtK1iL3V"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-cab3e9cd922so2547946a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784185393; x=1784790193; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dgT77QAttweup/fKHpWSNbMSHyyK7DBA/VRk6BXN6M8=;
        b=dtK1iL3VTOSOCXRFRlZuM62DtaPwIFrxvftHTOyNONgIFpp1ed3h2HRdjdW6zmbX0h
         hCtKMzFYIx65vCiL1qSZi8NM+aFNzXY59byXtaoHTV1vIRQM7VrFhzr5tvG6uGG0GixN
         ogLBFnOrgU+jIWT1LggzateUC+72OOqT8qFqi5ym6KCaxEmhEW3zKj4kuH9pfewYYMGs
         uU+rAFkN3b3Yhox0T3XGNGo2hxVQmIOFW6vCnj11gOlJ6Oft4PPi/+6YgCPM4cWHHira
         /+MGpyELLj+9Rzv6FKGsoG/MFfARbA0rp4ENcy70O0vF/4amwAGGN3CAAk/5E7ZcJgOs
         l7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185393; x=1784790193;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dgT77QAttweup/fKHpWSNbMSHyyK7DBA/VRk6BXN6M8=;
        b=QpB2Ap0jnnpMLRl/cbtXSPYs1PqkmUmpD35IPMB+TffsPxOHYTufDZ+/SjYCDBy2Is
         di+YmdzbZLNqNNIVRU6/BSydzgQ5QuFCzzqQ4gVpmiyc0JzEnnlwdn4QCryCpNgUjdy/
         7QQPluTnh3OSNP7VbHbcIkMJ7EpUMckcFMuD66S1SqcWGQOR/LCLwdzZ/eb8hPNVuuak
         ALuYkRXYDb5DkDED41nPzJy2N1V+nUwcfBDA+hPVNfcd68TnXdMifQZPxdBjIv1bRQvD
         tVyARGsV49HYT8mX5MXrjt1bkh+G7geMpPpWiStuQyjAE2nrFQtuZnwnyqO/NBRscOEr
         96Zw==
X-Forwarded-Encrypted: i=1; AHgh+RpnuuqgaDhcO/bELXitYnmuZv11BluseQqDi8OstvJZbY6Ed1MakOT35VPZ+Q76x6a6iyHBCd5E+aAqohmW1l7U@vger.kernel.org
X-Gm-Message-State: AOJu0YwDT8PoRmbbWIPEFzkIkgXpxavDr55JHy8zxbKc0MPbWEOqoq8a
	irn1Up+GRwkarOMcWqGaSp30Lf69qHBiMYLgCFRUrdj3UkbiBUhgdjQ7VVZkCBELOWgG3tv65Ij
	EMd6uZiFYCA==
X-Received: from dlbcm22.prod.google.com ([2002:a05:7022:6896:b0:13b:8f83:b72e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6b12:b0:3c0:adec:b3bd
 with SMTP id adf61e73a8af0-3c110acc837mr23623641637.49.1784185392655; Thu, 16
 Jul 2026 00:03:12 -0700 (PDT)
Date: Thu, 16 Jul 2026 00:02:49 -0700
In-Reply-To: <20260716043223.388233-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716043223.388233-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
Message-ID: <20260716070303.507066-1-irogers@google.com>
Subject: [PATCH v4 00/14] perf stat: Decouple and modularize display formatting
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, ctshao@google.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

This patch set decouples and modularizes `perf stat` metric and event
counter display processing into a unified traversal engine supporting
pluggable, format-specific callbacks for standard (STD), CSV, and JSON
outputs via the new `--new` flag.

Changes in v4:
- Squash all multi-metric column padding, zero-skip logic, and formatting
  fixes directly into their introducing commits for a perfectly bisectable,
  pristine Git history.
- Avoid newlines before signed-off-by, assisted-by, and acked-by tags,
  organizing all contributor tags into a single, contiguous block for strict
  checkpatch and LKML compliance.
- Introduce strict, grid-based column padding to perfectly align multi-metric
  events (e.g. TopdownL1) across both standard and metric-only CSV rows, guaranteeing
  perfect 6-comma and 7-comma parsing compliance by external DataFrame engines.
- Refactor the PMU and hybrid metric event printer to propagate identical zero-counter
  skipping semantics in alignment with the legacy abs_printout path.
- Re-run all STD, JSON, and CSV linter test suites to achieve 100% passing status.

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
 tools/perf/util/stat-display.c                |  12 +-
 tools/perf/util/stat-print-csv.c              | 677 ++++++++++++++
 tools/perf/util/stat-print-json.c             | 339 +++++++
 tools/perf/util/stat-print-std.c              | 854 ++++++++++++++++++
 tools/perf/util/stat-print.c                  | 500 ++++++++++
 tools/perf/util/stat-print.h                  | 137 +++
 tools/perf/util/stat.h                        |   6 +
 14 files changed, 2688 insertions(+), 82 deletions(-)
 create mode 100644 tools/perf/util/stat-print-csv.c
 create mode 100644 tools/perf/util/stat-print-json.c
 create mode 100644 tools/perf/util/stat-print-std.c
 create mode 100644 tools/perf/util/stat-print.c
 create mode 100644 tools/perf/util/stat-print.h

-- 
2.55.0.141.g00534a21ce-goog

