Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39CC3FCB3D
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118691; cv=none; b=dTv6Ry+yUs/Rso8rC6ToGfwph+WcsT7yFNKFocq8Z7Cuz4QPELYoCSAN2ayAqcIW4IIzDEDQYneycXy7y3t62st7UJFYwA+ZwCrFX0owKyIpzd5BeU0qYrjJ79SbaqBqQQHQMosXKd3YljYuK5LD88FSy8Vbs1HcEs7SkNbTnTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118691; c=relaxed/simple;
	bh=YGhQSGS4qxiv9nFFG5N2ewyaUU8XzATnmmsH3heM/PY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tN2DKk3ohA7aCI/tn3raJKmJeAODE2n3HwxppzYKzYFT0wv+Gcsn6O/fSuO0UFElLK/xxXVzHN6UrBoo2wfpOymcNi5tKpOVlMNDTQwKreN3ZXgRNnkv812kCQHTOkD5XwX/Y1ZNS1yc+1cF1ZAjk+oQ67TYsWyNlrNn3VSK6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JEEFg0q7; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JEEFg0q7"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-303b38ec2f6so3258544eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779118687; x=1779723487; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1dO/83GaoHrubLcGUnDpZk6h2AKEvgXTw4eWslLnvE=;
        b=JEEFg0q7lDSKtG6+j5FeVe5EyhkQ3GizDJC/CB+8itZfVVsCqP0g/ZFvLmgmFXRthZ
         TRdydfOXIrcdL0mvprk2pMNhV/2BYlJrZZgy455qS/J2p8QmC86vErZkKkc0bpWNFNTx
         sMEdvefI5D3OEEugh2TSSE1b5onYM04vBsyReYC2+JCwFVWdyWaZulaRugi6abrByBaA
         SmtHMiS9dZLUR4eFzCkJp15AZ+Nr6MjRUStLx1XhvwRpI6yItU8ijpOVMlUjSQftDLzF
         M87nMSH8/k/h7yyGwH7G0p7+2NjPlBDnF4uUnluYfWbrRSV9yVfmWDx7VxhzMX+cUIhG
         Fyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118687; x=1779723487;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1dO/83GaoHrubLcGUnDpZk6h2AKEvgXTw4eWslLnvE=;
        b=MtehJFvw055eyrgLZFlaYotDVpq38EwoNkYL+R8oJaWcy0FC6jD3CWfqopP4nEAlyQ
         DvDd1HZ362bNi6ZpRBzxNejFvAe0+dxf2r6W6LKXoLSRd/0Gm9D5rnr2iDqjq56gC13u
         PjkC4QePMA3PIhn53y7V4ogns6UUsqgQS1s0a2mkTchAUdrzMPpP45l0SbNMmS0YqGG+
         pj9Iw/fsR+Z20hM02ldxPifeeS3vtXkkwuaVxKYulW6zQrqgf9FcB8OSvYphUmgw4qUi
         dXpfGEgKOvZ/pue4AS0+a/4InaIhP9tYfa3DS32MJFefreNaOg84MRhBUcYxCjMQPW+K
         OvNA==
X-Forwarded-Encrypted: i=1; AFNElJ+MQLsPQCinyoH0MujXTwWAiKHIwspjirQBygDtJCS+0/PITcLbf3nGBOOTHAsCkYR61mNV5PsDx1dwXj/3I3Uz@vger.kernel.org
X-Gm-Message-State: AOJu0YwUAh3R9VI57iA7BFX21XeGFSIXF+FKSyZ5npxEO5+mg8TNCnYB
	I0T5igj1YryDie40u2BAl7HCm2yeLlfopOeiayTY8lgRY8QGOXE1f3jG69nGRYmIGVvkb3ImFkH
	vyTV1qqkV9g==
X-Received: from dlbro10.prod.google.com ([2002:a05:7022:158a:b0:135:7778:474e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6294:b0:12b:ee92:a60e
 with SMTP id a92af1059eb24-13504c54a3fmr6771884c88.8.1779118687009; Mon, 18
 May 2026 08:38:07 -0700 (PDT)
Date: Mon, 18 May 2026 08:37:52 -0700
In-Reply-To: <20260518061228.2582860-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518061228.2582860-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518153754.2795820-1-irogers@google.com>
Subject: [PATCH v4 0/2] perf inject intel-PT LBR/brstack synthesis fixes
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
 tools/perf/builtin-inject.c        | 151 +++++++++++++++++++++++++----
 tools/perf/tests/dlfilter-test.c   |   8 +-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |  28 +++++-
 tools/perf/util/cs-etm.c           |  28 +++++-
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  27 +++++-
 tools/perf/util/synthetic-events.c |  25 +++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 242 insertions(+), 48 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog

