Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F063932E4
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136695; cv=none; b=bcTzBUQ3/Wwy6Zsj9Uxz5XUp5S6aM1yCmsJiJLqdIWZUt6nS/N8PTR0NgkUTc8bMzfpxzZtGXBP/zk4+S/saoEGJzRDjhS7Jx7tJeIQclUHW3lx5sGuhQhsbC0EwdwvWMXgnI30BeRO+470RL4dmbeUY26brCRIS9qlm6DBfjcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136695; c=relaxed/simple;
	bh=a9mDMH0mxkKl1f+NwLNOUf6axEvkhc0dUAuOliW3NbM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FaeuykvQKxE2FLTMLxGuc7/FNQ3vT/++C+ij9LeQlRnTSOAFuG13w8Kc+aV3doowlFDassnJR1SasNB6Uwico9zvpqymybJ4wTjVJd/ziITvzIp8TmI5WtsxnCmqSTVm47qqTxfRVUz/QQyulogzB9th0Lzy7Hk6d2f+3pu7ZyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S1dXIOw0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S1dXIOw0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda2e60so1389368a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 13:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779136693; x=1779741493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Efwl7tl2VDM4wp4iKEi1BzZx41SkQRckatmi5FgRGHg=;
        b=S1dXIOw0jPmbMx2MNiQSDqu7jHNNlARtytJY++P7KTDE+UFGlH8tW2RDdiKHYfFmol
         PkjV/SnF/yyDnamz7vp7QfLL89g9g/Y1dO7GPrZ2H4pZnXdELLVVqwJE5AG2HiQbMNk2
         I8yIdD6VS6B3u+0upfdEEjumUqQL44X0qtpLejF8+LHscVg4k3UR2v3HNdDr+NBTlcc2
         YJ4jyjNoru/Vb/c909d4iJ3VaxTopsZX7j56u4aJlzdaOu/s918MHpdGc1YN6Lv9AL5y
         oF/FFZhGV3re1b63AhPwoWM/1w7CBAQ5dJoe9Y9PqE0ymZTOdUqKNTl/nK26GtHTUrF7
         N0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136693; x=1779741493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Efwl7tl2VDM4wp4iKEi1BzZx41SkQRckatmi5FgRGHg=;
        b=j9QjUSyk1sX4/lNv9E0jrpy4BDG2GeRdTt3d5t2B/rBN0j3ikT0VQRgMbYr7wFsMoF
         g2DndAgvKOXO/FqQEuCfS/yjrNXw2A6iue7/tMopulZ9HJdG/0xs3rKowLoRIS9IUD0U
         clOTPipbfZ/DloSkcq+Zy7pm13DIy92STLdfjngsjOQtzjrlVUzQ9viRsb/0W9MEOe7M
         /TFANf025fjdQmT2SskxWG9clGtgpoeCbh13rBL6/GX553jC7PNcRGR/YnHs9oIFOQ5b
         eAjNOs2ps6TTsM8MJeQSYENau2IGtmREALZ8ov3JBHYPo10YDdynIwAmUpD8dDT47zSc
         /70g==
X-Forwarded-Encrypted: i=1; AFNElJ+5AgRRUfWriOoRoCPl5rJvpcf8Gn9SIEembuHRnnWqlM8WpjBRiDPEKb84PicNNquujOzAlkzUQJKJvTESyvkz@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYhyoOsOjhpGVR5cxyBDd74Bzir6MBqqxLcF6xvGL3T+j4vw0
	ZT0WqeikrakdQGC8GZW/47ujfzttq60Y21XZG7er0lZNjaDBP+jAjOqriARz/L/tdXiL7/SZsyB
	5SJ5M1D3R8A==
X-Received: from pgbcz6.prod.google.com ([2002:a05:6a02:2306:b0:c79:8756:1a98])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9190:b0:3a2:d838:bfca
 with SMTP id adf61e73a8af0-3b22e803513mr17351410637.3.1779136692649; Mon, 18
 May 2026 13:38:12 -0700 (PDT)
Date: Mon, 18 May 2026 13:38:03 -0700
In-Reply-To: <20260518184939.2901713-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518184939.2901713-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518203805.2955241-1-irogers@google.com>
Subject: [PATCH v7 0/2] perf inject intel-PT LBR/brstack synthesis fixes
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

An intel-pt trace can be turned into LBR events either in perf script
or perf inject with the --itrace=L option. With perf inject the
generated perf.data file failed to be parsed as the sample events were
out of sync with their perf_event_attr. A range of fixes were
required.

This patch was separated from a large perf script refactor that
highlighted the breakage:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

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
 tools/perf/builtin-inject.c        | 160 +++++++++++++++++++++++++----
 tools/perf/tests/dlfilter-test.c   |   8 +-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |  28 ++++-
 tools/perf/util/cs-etm.c           |  28 ++++-
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  35 +++++--
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 256 insertions(+), 51 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

