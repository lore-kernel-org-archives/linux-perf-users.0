Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D5721254B
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 18:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130187; cv=none; b=e/oYhV2C1LcegFi6KX1DAMODUTvRloYOJuMyg2thbTmx6OUDeYYA5Ouz246Wwq59Ntsq1kfoFMnkS1N3BupOtB71yDpv89bNg4S0j7Le50UaR27na+myw/yQg3p5l4aT5Yfoo3USzQBjeQwL9lQSvusUA506KgvOY9PbuplZWcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130187; c=relaxed/simple;
	bh=O3wUoMzE2teTpleASM9lk1xvu3EaYPm/xhVmgNA3ags=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T3HtEjZqNrU+hqc+Lk92bOFzdoKZk/KMCyEVYiJRNLt+H979lLl95WYtXJ79JgNhkUcEIKwRtQ/C5OArUV4aw1067rkst2ZxXqv6RPeI13E/IKh9HQjSxeG53AhJFOqQNSeaW7x/296twGxjvTFOVjFyL6qgcUn4pCaMKiOttpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bM/nfIlm; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bM/nfIlm"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c16233ee11so3725868eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 11:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130185; x=1779734985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A7vmO7FINPBDK9d8Ttg2dvQ/IyVs1fPDgXyP+rZ5aRI=;
        b=bM/nfIlmsCcT1H2j8jYq0BUt19ZulFw4kyzp2ZgQlxuF7Nxb03WucRVeUFsnPmkFRB
         Y0zVjNUTwc6bcIjT4waVV+AbYPqPt6pksy2NKKb6S2WfhL+jqXZl8p/gNzbUn+fKtVad
         S4tzHI0eJVC1YWgM/wvkQlsCsqCa6a2L0AIs+N1JZKCgujKVsM5Q2u4xqmyge7ad3mNq
         uqqZcgBXN8kOcqduK7QRNFLvTaB1VxeQkaFx1bAwJoc1GObqUfDil/JaZKh3vFjxSrhm
         /dQYC2x9bdkN0FmqgU3krUfNGeEzvkNObqRrrsxfRfri38TqjfNzncm/Jm2JVAyKg5AK
         vrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130185; x=1779734985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7vmO7FINPBDK9d8Ttg2dvQ/IyVs1fPDgXyP+rZ5aRI=;
        b=RvRLgwTN788H/cB+4DKqi20ZZzn16bupRWoe8upl2kEmHIe3GeMZkKppWAdyNoV8R0
         Jv/tZ6xmti3L/Vj2bT5sClsnfrB4DJk5aaKtvUXeq5PWGmZBSe6duLfIDyTNtYdkwlgt
         poe4x8EIlAjCuCo70urF0CvD33DP+Zp7k70HKH/Ht38psiXHmA/laD3MJqsna+nDBV5z
         5/E/DevoCQvb4roDytk+nlWJOAbca9aBkzngKvlWPhsUmfPYkzF6AbvbL3RyD5AT1RhE
         Dp3s9EiZhDes9Vb/pfZJ8ZpOjiwFYsAyN01mOxKinmQF5hGKyqNLoQJm2J3Ez8HmESkE
         jb1A==
X-Forwarded-Encrypted: i=1; AFNElJ8GltFbA37TxSxibWEhWxaVOjSm/MB8WvSxjgGqJ8a2QOVTRpm/Y8R+Ma0pCi1M+o/TnpyOWtqaBrnnwI96DRQd@vger.kernel.org
X-Gm-Message-State: AOJu0YxvtlMEbTZvUC+0pqpeOsV/waTy6xBinX+ZtxS1F2ZMz26lzHit
	9aO93hEWO0eXwraEJUQh//buiNvorIGvKKaIPELmBOBKCnAeoqeIhXJ41EuPR4H1tQA7Li0knlX
	KTfzIWKgSvw==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:12d:bc1d:8783])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:661e:b0:12d:b2ca:a9ef
 with SMTP id a92af1059eb24-13504c617aamr6595201c88.17.1779130184755; Mon, 18
 May 2026 11:49:44 -0700 (PDT)
Date: Mon, 18 May 2026 11:49:37 -0700
In-Reply-To: <20260518171231.2834947-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518171231.2834947-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518184939.2901713-1-irogers@google.com>
Subject: [PATCH v6 0/2] perf inject intel-PT LBR/brstack synthesis fixes
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
 tools/perf/util/intel-pt.c         |  32 ++++--
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 254 insertions(+), 50 deletions(-)

-- 
2.54.0.631.ge1b05301d1-goog

