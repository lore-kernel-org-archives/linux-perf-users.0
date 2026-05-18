Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42FB382F05
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779124369; cv=none; b=VXRBL6c9qANzSrryPMWozYg4TmePdZLts3wr2s1AC8eaPpQOYM2XG9p7TlITb1gpgnoyL8aJ82q7AaD6yhal/JGqTiz3zhS8bEF4+tgEUW4ipYCTzXw2qDwGXPJE68CXi0E8xsjO0hLm3cU8kA9Bee9vNk30XaDhAsCXvrhNzXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779124369; c=relaxed/simple;
	bh=mpN4xSvYZ8TFvVCjeuelcA1lAMlV30bEgAdbr6hm3Ng=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9cR7PDAc+pyERVg5Q3jjjzX2fFNfVaPna1eR73f0iBNmfkC6v5K0GxglH9FZIBsg7RCj6Pb9pAzZF1eseXZRDSMNTG2HhOYFyJjxPbX/OZRNBZodcuo8OzQ//zhDFs1ppI+7v9KVvO3FaRJgUSS4Ohd/scO1xo+3xsbdYDhZbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U5vlEkC3; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U5vlEkC3"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135405e4035so11201509c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779124367; x=1779729167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLEn7gDLBBatTNeFdsjLw6eVpe+9BqWLfHAldex4tko=;
        b=U5vlEkC3Qi4scWdJp5a2eeRnBzlIhk7SSx2Ts7oLRdimMvyYrgtQeFGgCyGkQ4+1mi
         DOy2NA+TomRSR8xxIzS7rNuVyKDq02eKkYMgUyAJF4Kmvq7+OgvPDr/7cDbEvnrh3QNv
         QKxklWWnUQD0/pmGBZI/p37o+3TnTHfXMU3eoO7MAJstUXvgCnbEMmD9rR08CGqX0jP+
         BU3pkXpDkRezlrxI3IJ0wRn/pLsxocumKpddMsA3LhfnZzzuAzv/UgDGikIwiOGkCn6m
         dDQA2Q4NOxW5XlGIKzezh69P3JlKL1oz5APsCveYEq97hUBLfcOvvcZZZdhWnajrYsHE
         XLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779124367; x=1779729167;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gLEn7gDLBBatTNeFdsjLw6eVpe+9BqWLfHAldex4tko=;
        b=F6uWv5aAn3Sf1qo/Dx5pUFsA/dHJnj+VjuDJiwq5OROVWOp12es8vKxPx7UrFIahNR
         29NtjEg1/f2rnrZx1UKuCXavO0QU+ZoGV+e7BBN4gUP1HnNtvrF/1kqJgejN5ODQ7bYC
         gUUk3IWv8qDuIiZ2DndOr8EiH7KCozQS1Obowa/JQ0SOt/IVsyoLlICuPjmf7bg5gdai
         Tym4JVNqDUREb2vYJChTMzI/okOYR5AG8U1jmuP25CSOE0eZvuOk/QLKG6Io0SY2AyrX
         95SJDXSI9BwNTw+/HeW0H9Z8oG09Gum59iOx//CdIa9PSam579x2DHLzAjgsqh+Ej00I
         3vRw==
X-Forwarded-Encrypted: i=1; AFNElJ+lfOckoOX2Nd4S+1z+0FYwTpv8bFueIcx4ZE03DmaI1HXCpfhie+nCRCfmpG5YJei9kcAEJLcBKV52OobxzrJ8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3parkgkcPDhx9Nbs/rdELqaXR/II8nlYZujNN2STXyBAaDY7X
	rRsRRfFk4C+4T4y2NWHCdSDP0QAOn1SvjHHx03VB902lPMlUdWT19Uq1v8RzPMWnZJw6sXRkB97
	A5Dx7UQQKqg==
X-Received: from dlbvg7.prod.google.com ([2002:a05:7022:7f07:b0:135:6c74:1840])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:911:b0:12c:5e48:4c01
 with SMTP id a92af1059eb24-1350441939fmr6889217c88.1.1779124366629; Mon, 18
 May 2026 10:12:46 -0700 (PDT)
Date: Mon, 18 May 2026 10:12:29 -0700
In-Reply-To: <20260518153754.2795820-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518153754.2795820-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518171231.2834947-1-irogers@google.com>
Subject: [PATCH v5 0/2] perf inject intel-PT LBR/brstack synthesis fixes
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
 tools/perf/builtin-inject.c        | 153 +++++++++++++++++++++++++----
 tools/perf/tests/dlfilter-test.c   |   8 +-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |  28 +++++-
 tools/perf/util/cs-etm.c           |  28 +++++-
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  32 ++++--
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 247 insertions(+), 50 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

