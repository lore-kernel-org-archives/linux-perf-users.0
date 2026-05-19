Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B7540800E
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 15:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204449; cv=none; b=rh6KchhrFeaUYIlPZFarZJKZ7UZSwu0Gu/JuYyoApIA/oSSYWbssiGlHrX0JOF+G7r0nKkcgiO7WZ39HSJpr7LNPWSE0OVWxY9oiXYx13c2Mr3CVWUZrQJBbQPDxyovSCaHF27JV0TWQjxH5onFCjXl7+gRCWu7NbBphYWAnDkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204449; c=relaxed/simple;
	bh=eOJZKMoZV0diARtpy17ABGZN99JnuKCo3hyeGW71hwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NFM6rcRGob1XXK+lmG1/il45Ou+JbBRhMOwGGApGAoRNDt/4aCFR7lzoaXzuIYVbV9kERuw5YtZQEFFNqNKiEUM9A9412wPcxg/FwHs2E7r6jOXZYjnSdZ0CPB41W2u09yTdVBZlnPj0JIxxhhbRwIb7xh3z7Iww8KhpB0YemhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEsHpqIx; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEsHpqIx"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so4394137eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779204447; x=1779809247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JRAScA5pMmjGLEHsleG9AraBMhKB6YlYyZMFoHwynoY=;
        b=HEsHpqIxXD8FmPLugzI6AxdlwW33+yALyrtHB++nuUn5pckduGN+9YfzzFmfrZTSt/
         HcMtV6u79bvE5AbOpa5TG6kd0Ohs4IFfw+g9ttevDfmc500V0Zw0DvGY+A3tyQAZlR0K
         U310ifVRuEiXJXG64I9hkVOpzqzAapHu4/Hky+su9e9ZCbuyk8MbjjgAU5jWPx3HMy6a
         rtchws4eHTMtf7F+wW0oENMMyRvk9fWFh0wmo4jbGFsmDFOuvXPf2xDqf4blGsm3tmj8
         GVeIud+Rh0yCdER4pODVz3rjLzRJ9qMhAkdAltkLoDi9OvTiA6zI9McEidjoxPEU6WSK
         doJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779204447; x=1779809247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRAScA5pMmjGLEHsleG9AraBMhKB6YlYyZMFoHwynoY=;
        b=kCcdN8KQWjS9Z61+dx35qto5D6a2UewCY0sKCmoDxnoQ/qHJseyuF57G1Wr4/FuytY
         wsbdLLmklw40c7XqIsLnFYklsS2Mkhrp5MiPhx2aCYP/Zv4g7n0PCfEZoG5AlOut4Qzw
         SGNG5qTgeM2b1fzzsJCi9WZwPO2LX2y1Yr7P03hKcTNLxdyEdCLJfBm8DNuYa17c7Sph
         V919lfh9CpomeDA52eOwxZpIIPy+2CmQgZ6ux2yyCbSheBp8OksA6GraYCSAHgjLmwE3
         Zr/6+dswbxCaPAh1jIYSfJpDP2vONy4YoORHIzZOS79KZ3h8rDKPs+5DOygP/IayZ6hq
         T2ag==
X-Forwarded-Encrypted: i=1; AFNElJ/fYYoh+enB87OejO9zIDSQPlSUaHjexlo5JG+Y5y7KGUyThmfFpoF1RWOmJTaa0l4Q7yUCWshz8/N7y7I3sqEy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1D2dIkPF3Ox+3MsPIM8hZ5KrN1jGIQr0tfzE4lahTfcEMbPv
	NieWu2zZdOC29Z8VbhKWooUDPu0HW2MtXFgh4AJuSOskS9S7VMVoYOSE74rnJcyyw+iUf8Na5xq
	hO4suGRLmjg==
X-Received: from dycpc14.prod.google.com ([2002:a05:7301:9c8e:b0:2f9:af7:5046])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e125:b0:2f5:6d9c:7156
 with SMTP id 5a478bee46e88-303986814f8mr9849857eec.17.1779204446580; Tue, 19
 May 2026 08:27:26 -0700 (PDT)
Date: Tue, 19 May 2026 08:27:14 -0700
In-Reply-To: <20260519050150.3144907-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519050150.3144907-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519152716.3464144-1-irogers@google.com>
Subject: [PATCH v4 0/2] Fix cgroup metric association with BPF counters
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, skanev@google.com
Content-Type: text/plain; charset="UTF-8"

This series fixes an issue where cgroup metrics were not being correctly
associated and reported (showing `nan %`) when using BPF counters
(i.e., with `--bpf-counters`).

The root cause is that cgroup BPF counters only open the "leader" events
(for the first cgroup) and leave "follower" events unopened. Unopened
events have their `supported` flag set to `false` by default. During
metric calculation, `prepare_metric` checks `evsel->supported` and
discards the value (setting it to `NAN`) if it is `false`, leading to
`nan %` in the output.

The first patch fixes this by propagating the `supported` flag from the
leader events to the follower events in `bperf_load_program`. It also
adds a validation check to prevent potential division-by-zero (SIGFPE)
crashes.

The second patch adds a new shell test (`stat_metrics_cgrp.sh`) to
permanently cover this scenario (testing both with and without BPF
counters) and prevent regressions.

Reported-by: Svilen Kanev <skanev@google.com>

Changes since v3:
- Add validation check in `bperf_load_program` to prevent
  potential division-by-zero (SIGFPE) when `num_events` is 0 (e.g.,
  due to a trailing comma in cgroups list).
- In the test script, dynamically pair instructions and cycles
  events using the PMU name. This ensures that we correctly verify
  if the associated cycles event was counted before performing the
  metric check, regardless of which event (cycles or instructions)
  is the metric leader.
- Collect Namhyung's Acked-by for patch 1.

Changes since v2:
- Use `--metrics=insn_per_cycle` for the system-wide capability
  check in `check_system_wide` to ensure both cycles and instructions
  are supported.
- Use exact cgroup field matching with surrounding commas
  (`,${cgrp},`) in the `grep` check to prevent false positives when
  matching the root cgroup (`/`).
- Only enforce metric validation if both `cycles` and `instructions`
  counts are numeric and non-zero, preventing false failures on
  idle cgroups.
- Wrap long lines and fix trailing whitespace in the test script to
  comply with style guidelines.

Changes since v1:
- Fix commit message for patch 2 to remove the mention of
  insn_per_cycle check (which was simplified out).
- Quote variables in shell script to prevent word splitting.
- Use grep -F in shell script for literal matching of cgroup
  names containing dots.

Ian Rogers (2):
  perf stat: Propagate supported flag to follower cgroup BPF events
  perf test: Add stat metrics --for-each-cgroup test

 tools/perf/tests/shell/stat_metrics_cgrp.sh | 200 ++++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c        |  20 ++
 2 files changed, 220 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

-- 
2.54.0.631.ge1b05301d1-goog

