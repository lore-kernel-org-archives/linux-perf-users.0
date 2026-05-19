Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F230FC2E
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 05:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166932; cv=none; b=VDg0qBMc5Rxh+aoMZregOG4eoiAcrtF1FSV2LMnR1McJYQ1Ykd+sVlEQ1s+qH9q/0AyXJJAjlGiJ2Plj8ULnGDJR/i+np5G5OcI0KRNhblxEWN3M/lcw8GkLwHQ/cGRXaMBulb08Xaxra+Vyo6tc20jIvf8p5IgHn5yV62lE+2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166932; c=relaxed/simple;
	bh=OcP1NgA2NxIksA2y9tdgsVvq26r3piLHRjjkj3eRQAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AgwxuiPBPXW1eOFSHuSv2tny3o5sfticS4XgrYwPslby+N7Nk9o66pmua6l3k6gAN4sD5z5WUKnekvzX+NEwHW/p7xtoBjWutZuEG/pbP/7imoQwsGPX8faoRxN0MIw+WJ3BzTz2WXBaLeH7NhQHnIfEK+yTpiVdtYlhvCRRXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9mFHz5G; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9mFHz5G"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-132d631edaaso19328723c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779166930; x=1779771730; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbLm2oZLKqhvgpwkQ11BIiKN7n0arf5bkU5LkbUJH8U=;
        b=C9mFHz5G1Nyp/Fl61psX/AnTovh2Puv/0ocoU3gl5A7/4y2/pnHd331ng4U1m5E1SZ
         PYDfuq//ubIA4cq9j6zqR2ep0KOLKcQ9bcsnQOypiFsaO/J2rCy7ql4q/okbnK8IBcZ9
         3+MIT2JwRk12dHu/iy2nEhQBYGuGtHkIppVo22FFCupUU9+uRUMu/6pOGFH3jRITvpdw
         fFeJ6ZXVxudmRHRb9OTRdFGsVc/x3fMrg3kYM0/2atr00C75HMpFTegDvJSScC9v0AgO
         n9QY1IpXLtbZMTU9P1S3pTI+fBUBRMv67dhxsOfiMsuC+HmV2HL3s9FubjkwFfJSiUA7
         TGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166930; x=1779771730;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GbLm2oZLKqhvgpwkQ11BIiKN7n0arf5bkU5LkbUJH8U=;
        b=ryQSFdmFPvpxP4xEt5ge8fd/owYDIOPaT1YBg2e7v1ClKAvtZOxaAOwPWCrQLG9yjR
         cQ3zpAemJngH2vDvreydWWopNXPbJb0RaBr/cSWYWEIC7kwmkuX0d3yoP7nztvWdqlSm
         +lgA8WgX2MKWxzWJuad0Tiy6ZyTvLR077rcZK+o4HAnPW2UUA4wLJz7GvXprZNr8/iIm
         tiomDB+OcJ1zc6GUdkH7rYuCJJld+91+sx6/L1YeVlT1Xyb9YsmDlfjxKbun8ZA86aV5
         U1eTg4nJxYphg+PZw+oFT8Raeo5BN+WebwVCNnpDIMCe/n1SlgVOLWg9rX8yT9C68Oxl
         H4OQ==
X-Forwarded-Encrypted: i=1; AFNElJ+GzSG0M9siSUj3TTKKQuMaP32gbPqrSqpWAd/AQDfPUNsC6occzAj9j7eZUGD+U42FDLSJZJFovKC3HU82Wt61@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpxZrTd0FzxBvEi1latcEBPqBN6iRbdkmdG/+zR17WpOb4Ldg
	fa+3hQElR/dB5ZoB5OUIKIHMvkLPZczGp42tnwgZeyFlvI0qjgEGM+GAruDYiXaXTiduvrDceCH
	vQWKSw7wHuA==
X-Received: from dlbsj9.prod.google.com ([2002:a05:7022:f909:b0:132:8d92:4d65])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:505:b0:12d:c039:6599
 with SMTP id a92af1059eb24-1350483f18dmr7201841c88.22.1779166929643; Mon, 18
 May 2026 22:02:09 -0700 (PDT)
Date: Mon, 18 May 2026 22:01:48 -0700
In-Reply-To: <20260519015108.3094513-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260519015108.3094513-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260519050150.3144907-1-irogers@google.com>
Subject: [PATCH v3 0/2] Fix cgroup metric association with BPF counters
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
leader events to the follower events in `bperf_load_program`.

The second patch adds a new shell test (`stat_metrics_cgrp.sh`) to
permanently cover this scenario (testing both with and without BPF
counters) and prevent regressions.

Reported-by: Svilen Kanev <skanev@google.com>

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

 tools/perf/tests/shell/stat_metrics_cgrp.sh | 174 ++++++++++++++++++++
 tools/perf/util/bpf_counter_cgroup.c        |  15 ++
 2 files changed, 189 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh

-- 
2.54.0.631.ge1b05301d1-goog

