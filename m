Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794988522;
	b=MwOOJAOyPcM/E+xQSJ0YEX24lPU+usX5n7JZK4u2/B12oTa04lWXnl33yK02ehT1wL7Z
	 CYhXEpipA+PHLkKg0HFaFy+ZQdu65sdfQAjWQ3ox5DZL0c48CrMEqF4kCDNWNfgR+NV0T
	 UYkHGs0J/hJqCIuZKJonnzzoC8MGjoyxWoSrgXuzwFJjELR8kwUH2IF/cKGHyRgXAkLOQ
	 uTHzDD+QLGZLAhOKv3O/adHOhWAkKgJxH71sNDoclxbaEIbcCsh8Vtpb2VH10DxV9XYls
	 weSUvgaGFlHUHRApp4kCRzTxr0JSmJs+VCtILdx06XKINqRJfPQPBEkw1B2lZ27y4XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794988522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=40c9k5cdKIK+GK0ZjNAi0yVhuz28kITKb7hJsJ+5Dng=;
	b=onB3jR7Occ72Tw39Zaey/j+UihWh3oLT4QVeAhu7qXPw+Jm2dwADCQqJSjLvQQ1DBFc5
	 Mn9013RXO+8GpkoeR4okqomRsOgJohR0V+GnmnMzbPaREOOFsMKuV8wf8V36HyokM5xBZ
	 BF7c5XzgKpNkR8dzFJ8yW8phqMRLH6+vUQtw3ZHOvf0xELc98VqHWCX8iylMqQEtesGlZ
	 JghUvoq3+AQbBmhKF4x5LMrlbu5fq0SqN1jt/UJKyu0AHBZ6bn2jF9DA8GRhenrmw1UAh
	 Trpex+Yq9wSGcGHcCmO1mh+cYhzo0w0pspYMQx9Tz5AlrIssk/ro20iHZzZak+ZdJwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=idD9SyEE;
	arc=none smtp.remote-ip=74.125.82.71
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910BD606A32C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 07:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 910BD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=idD9SyEE
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1b29df78132so772217c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 23:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794988521; x=1795593321; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=40c9k5cdKIK+GK0ZjNAi0yVhuz28kITKb7hJsJ+5Dng=;
        b=idD9SyEETmf/ZbMhAwRYgIwuVNpI2YKGQWU0diale3Sjd0guuKtoohVoddizEiSeOp
         4+aDydLJcujHnFzlAf1Ox+Q+zLnjCmHygV/t6AaDhELe5U+a39P/qw58gZb7pEvnMdI0
         zkS8xC5bQXn57AOGk1ahYJy/ZFXVcrX58m+F5ACY4jelT28xkMX38GTTPGx0XQ+qs7uJ
         iBxVMNbDeUiCHIKrrM3L/2xS0E30dm7Ier7uPubrvQjMvC3ebQzFx9puW9/cset3gM7C
         tCqzeDf0HX2/63NOd/Bki7zAU974PwfPSf2Zg1wvQItBoyHtsdI8Vht0YaavcH+T6OCJ
         lyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794988521; x=1795593321;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40c9k5cdKIK+GK0ZjNAi0yVhuz28kITKb7hJsJ+5Dng=;
        b=Fk4km7CBWSnXDyIpJy+zXg14esMBOf9nsgUpiLhKccbdaUGcNhT0e0unKsW0e9xs8/
         NEFnHOnqPASXXgeGxt1d78IimiNK01NkLrsV5zeq8YiZO/paEKxY1AnQ7aFRHnwrI3Fz
         307l9HXm73Mt3UEQs3bP0FFxcHmxDfTO04IqgvAnfCo4/aTeYTGIwTiQtDeeps5PI3Zt
         /quAmId28FPVq7SH6mLGL3gnIbusRNeyiKIkfZTxB24rGR1oyOjCm3KnZMHt6WISmkHj
         jckdSkUphs53+yU7VAobq031PvAahlgJrfS2606Y7do596XnmvOG2vJUHZWKWQmmuzPD
         KlGA==
X-Forwarded-Encrypted: i=1; AL+hErFo9uiYGAZN3fds+syjfUINSaaeU9IFAEB3i+h/qZKaQzVbgpI+ROOCkzX4kzP9ksWhJWufEbuiTUdRxHP0QtJg@vger.kernel.org
X-Gm-Message-State: APuU4Z8IAVvWBpSOMbc2Et6K2JRcmsmPhx3OFp+9wvUsfhiJMOP9pkpB
	xoUOeRgcHeuStU8mH408axIvZsNLdeNOxWzGZbIdavCJna2GezRp3eJeuTpbcxpGOYOOIX6bVm4
	ipIbPIg2wbA==
X-Received: from dlbtu24.prod.google.com ([2002:a05:7022:3c18:b0:1ad:2ffe:151b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2901:b0:15a:4155:3d9a
 with SMTP id a92af1059eb24-1b543d33ddcmr1885016c88.47.1794988520110; Tue, 17
 Nov 2026 23:55:20 -0800 (PST)
Date: Tue, 17 Nov 2026 23:55:11 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118075516.1278903-1-irogers@google.com>
Subject: [PATCH v1 0/4] perf tools: Fix thread cache race, stat per-pkg delta
 bug, and memory leaks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Four standalone bug fixes for pre-existing issues in perf tools uncovered
during Sashiko review:

1. util/threads.c: Fix a race between threads__find() and
   threads__remove() where dropping table->lock between lookup and
   updating table->last_match could resurrect a removed thread in
   last_match (and avoid taking down_write(&table->lock) on last_match
   cache hits).
2. util/stat.c: Fix process_counter_values() passing a static zero
   struct into evsel__compute_deltas() when skipping per-pkg CPUs, which
   underflowed and corrupted the static struct in place and clobbered
   prev_raw_counts when a previously active CPU was later skipped.
3. util/metricgroup.c: Fix realloc() failure memory leaks of pending in
   resolve_metric() and root_metric->metric_refs in __add_metric().
4. util/pmu.c: Free alias on parse_double() and io__getline() error
   returns in perf_pmu__new_alias().

AI Assistance Disclosure (per Documentation/process/coding-assistants.rst
and Documentation/process/generated-content.rst):
- Tools used: Sashiko automated patch review (sashiko.dev) for bug
  detection, and Google Antigravity / Jetski coding assistant for root
  cause verification and patch drafting.
- Summary of prompts and assistance: Verified four pre-existing issues
  flagged by Sashiko during review of the perf generic hashmap series and
  prepared standalone fixes with Fixes tags against perf-tools-next.
- Testing performed: Built on perf-tools-next (b7ff10b9ddec) with GCC,
  Clang (BUILD_NONDISTRO=1), and DEBUG=1 (REFCNT_CHECKING=1); ran perf
  test (Sysfs PMU, PMU JSON event, Symbols, and perf stat suites) and
  scripts/checkpatch.pl.

Ian Rogers (4):
  perf threads: Don't resurrect removed threads in last_match
  perf stat: Don't corrupt zero or prev_raw_counts on skipped per-pkg
    CPUs
  perf metricgroup: Fix realloc() leaks in resolve_metric() and
    __add_metric()
  perf pmu: Free alias on error paths in perf_pmu__new_alias()

 tools/perf/util/metricgroup.c | 19 +++++++++++++------
 tools/perf/util/pmu.c         |  5 ++++-
 tools/perf/util/stat.c        | 10 +++++-----
 tools/perf/util/threads.c     | 16 +++++++++++-----
 4 files changed, 33 insertions(+), 17 deletions(-)

base-commit: b7ff10b9ddec8da75304c40fe4abf1ee4f9f0a43
-- 
2.56.1.703.gf848ed807c-goog

