Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E613A3ED
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144210; cv=none; b=AVpkNZUKhchFiHs3IWalYBx8GSP4UGYuCVJp+8T4LukLH/EyyuR+AgLeFHiwndeLduYWpzOQ9iQRsYgoldPwtqPdDkDsRiDHHzz85JRtGHzgS2mNfFrbDRxqkMbKNa5V8bWGgn7jTBa/M9vh2Q567BAnHDjPkIyfD/mL6j2SFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144210; c=relaxed/simple;
	bh=aHE+LoJpbuOCnIE6BRQ5uSn8/p172vgWMMLdyz2yLiQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eArbFigl+D2IYP8eaUyKQNGg4Fyn03cAh9XQCrjNomw7tD4EKidKMzcC5CI5HZgzqB2VP11PYcGXZOpvKBxbdJq9COTufoUBJ/wzAqaL0b2mbJZrRnWYUK86h/dNu5n+HhaT4/cr0m8ZVwuXz0/GEQGkc9CvFOJUwfJAaeISGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G8xpdK2W; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G8xpdK2W"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so4012495eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779144208; x=1779749008; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PuaLmO6AKm2ezA05IShu0PNAE6K6WpCw3h1us7qslE=;
        b=G8xpdK2WbKJ97YfFN52LCGxW+0PSeOchxkPZ/IE6bNjJKcs0b8hbbd3Dr0ztb9PvGv
         LWeVzm4mBzDm0Gq4USAcI9j88eIvBvnjK2BDK8xP43BmFyf4NVloq83wzEAembaJv8yn
         muy9Xq1PRoVMksHmAYrYGtRiM+aU6NYrkWXi/q6tbDBkdzbD3PVFjIuZe6JeZ13q8khb
         49bqDz2n8TGNNa3IJ1tXXj2DC3wGmRJ7Be340wvvhT6e0xZ/ybS54RuN6k5YyVeCQ+LX
         B/vOnsgcBQlxTwLU90kH0H/F+8BNB26oNSuWS9IcO9J4dTq+q1U3oqgi1GPDCu9mu+Bm
         26Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144208; x=1779749008;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PuaLmO6AKm2ezA05IShu0PNAE6K6WpCw3h1us7qslE=;
        b=FM7yI+/vP0FyXNEi7UZFMjezS8TWTmkfeW7xMGUHPOaIOtFGCasBwdFLmBCCXUPrWt
         I48wGbEqxo8kcfRsVer17DdBtqj3xpL45V8H2JLebVPpMJ93z2Ho7WCPcwSqn7K8hZdK
         zQ3LpPsCQiJ808GMH7Ic97ktRnqH9usSeZEqPhZmRaGWzXQSg6QK/8SUKVrbddlFoHMg
         alhV+sm/r4olSw1j7nWISgMqJ0eAUm57GjKr8mXFAqYcuqO931hGM154NWUwn6tXcR3Z
         rUPJIYwZ8Vy675StVmxGxovANnD8awIOt3AqcKAVcqKB/A8ncSs27iyJeIRfKD0am/Th
         wlkg==
X-Forwarded-Encrypted: i=1; AFNElJ9lSPyByOMkWcgRQdERxEIY+4RogCcFqsRVAGiPMbY6XcjpVLAXd1ZLpdZ8eLmTBw5/VwIi2Udlzl2Ny/Ihgc0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr8dXQSu9OJbjepiFAnzo5zgSRO/9qeoGIwbfIkeBPNShINapD
	pRZgwQ05yQSsReacOP9FKWC1QQ6evsk8wynZ4uBmLujLXVfJO+95pmRtDmWyj8Zu44rc5dAX3Qr
	WBakMXOuAHg==
X-Received: from dycaj11.prod.google.com ([2002:a05:7300:fb8b:b0:2e6:f22b:f849])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb15:b0:2da:44ac:6d17
 with SMTP id 5a478bee46e88-30398655327mr8858419eec.17.1779144208290; Mon, 18
 May 2026 15:43:28 -0700 (PDT)
Date: Mon, 18 May 2026 15:43:23 -0700
In-Reply-To: <20260518203805.2955241-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518203805.2955241-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518224325.3037838-1-irogers@google.com>
Subject: [PATCH v8 0/2] perf inject intel-PT LBR/brstack synthesis fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

An intel-pt trace can be turned into LBR events either in perf script
or perf inject with the --itrace=L option. With perf inject the
generated perf.data file failed to be parsed as the sample events were
out of sync with their perf_event_attr. A range of fixes were
required.

This patch was separated from a large perf script refactor that
highlighted the breakage:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

v8:
 - Avoid potential NULL pointer dereference of evsel in Commit 2:
   * If machines__deliver_event() processes a malformed PERF_RECORD_READ
     event with an unknown or missing sample ID, the evsel is passed
     as NULL.
   * Added an early evsel == NULL check in perf_event__repipe_sample()
     to safely fallback and repipe the raw event unmodified, preventing
     any segmentation faults.

v7:
 - Fixed a critical NULL pointer dereference crash in Commit 2:
   * In tools/perf/util/intel-pt.c, when branch stack injection is
     requested (add_last_branch is true) but last_branch is false (such
     as in perf inject --itrace=L), ptq->last_branch was not allocated.
   * When PEBS branch stack synthesis is forced via
     evsel->synth_sample_type, the code dereferenced ptq->last_branch
     inside do_synth_pebs_sample (either in intel_pt_add_lbrs or by
     setting nr = 0), causing a SEGSEGV.
   * Fixed by ensuring ptq->last_branch is successfully allocated in
     intel_pt_alloc_queue() when add_last_branch is requested.

v6:
 - Address critical security and correctness feedback in Commit 2:
   * Fixed potential out-of-bounds read in perf_event__repipe_attr() by
     moving the header.size validation check before accessing
     event->attr.attr.size or copying.
   * Prevented 32-bit integer wrapping overflow on header.size validation
     by using subtraction instead of addition.
 - Restored PEBS LBR synthesis fixes in tools/perf/util/intel-pt.c.

v5:
 - Restored the missing PEBS branch stack synthesis fixes in intel-pt.c
   which were accidentally dropped in a previous rebase/conflict
   resolution.
 - Addressed the pipe mode size mismatch and ID array out-of-bounds read:
   * Safely copy the incoming attribute payload using min_t and
     memset zero, preventing trailing ID corruption.
   * Explicitly set the synthesized event's attr.size to match the tool's
     physical sizeof(struct perf_event_attr), guaranteeing perfect offset
     alignment and removing any risk of hallucinated/garbage IDs or
     underflow out-of-bounds reads.
 - Refactored both commit descriptions to strictly focus on code changes,
   deferring meta-commentary and implementation details exclusively to
   the cover letter.

v4:
 - Avoid temporary regressions in Commit 1:
   * Used local masked sample_type in convert_sample_callchain instead of
     unmasked evsel attribute, preventing heap overflows.
   * Promoted hardware tracer signature changes and dynamic retrieval of
     branch_sample_type to Commit 1, removing hardcoded 0 bugs.
   * Checked sample->evsel first before performing evlist__id2evsel lookup
     to optimize evsel retrieval when already populated.
 - Address critical security and correctness feedback in Commit 2:
   * Added check in perf_event__repipe_attr to prevent n_ids underflow.
   * Fixed early return error path in perf_event__repipe_sample to
     prevent state corruption and dangling pointers on dummy_bs.
   * Ensured perf_inject__cut_auxtrace_sample cuts the 8-byte size field
     even when aux_sample.size is 0 to prevent parser misalignment.
   * Expanded older attributes to PERF_ATTR_SIZE_VER2 in file mode
     within __cmd_inject to prevent silent truncation of
     branch_sample_type.
   * Added bounds checks against PERF_SAMPLE_MAX_SIZE to all hardware
     tracing synthetic helpers to prevent heap buffer overflows.
   * Fixed checkpatch.pl warnings/errors for line-wrapping.

v3:
 - Add missing Fixes: tags on both commits.
 - Refactor perf_event__repipe_attr to avoid in-place modifications on
   read-only mmap buffers, preventing SIGSEGV in file mode and premature
   evsel updates in pipe mode.
 - Use perf_event__synthesize_attr to correctly construct and repipe
   attributes in pipe mode.
 - Replace manual arithmetic in convert_sample_callchain with
   perf_event__sample_event_size to prevent uninitialized memory leaks.
 - Retrieve evsel branch_sample_type dynamically in util/arm-spe.c and
   util/cs-etm.c instead of hardcoding 0, resolving missing hw_idx field
   on synthesized branch stacks.

v2: Response to sashiko fixes for patch 2, Namhyung's acked-by for patch 1.

v1: https://lore.kernel.org/lkml/20260428070328.1880314-1-irogers@google.com/

Ian Rogers (2):
  perf event: Fix size of synthesized sample with branch stacks
  perf inject: Fix itrace branch stack synthesis

 tools/perf/bench/inject-buildid.c  |   9 +-
 tools/perf/builtin-inject.c        | 165 +++++++++++++++++++++++++----
 tools/perf/tests/dlfilter-test.c   |   8 +-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |  28 ++++-
 tools/perf/util/cs-etm.c           |  28 ++++-
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  35 ++++--
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 260 insertions(+), 52 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

