Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8926325F79C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750281325; cv=none; b=qGdGxHWP0UVaCIKN/XU4KFovtoQJRHfoTZq+rynxk6nBrrtl3P494TGEwGaeXYoCOi7TTxFCyR7/qoAbV6YF4Rl/oMU3SnVA1DSzCjHgpXh62ggDZfmw2x7kAuQpWr3m50Jdvus53i/nkHyCko8o3w5/va+U65uE4qEIYdJF8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750281325; c=relaxed/simple;
	bh=ExWOP/OkSf0lKmRzIhhYs7Typ5dWMqCzHI2WPebhL0I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=ZY54TUxZRu7j2tbGwEJJdhIRon5hfqRTRdOP/IH5cn2zxjJ5m9r7pMfVagsAPQSxpHvpDnUkFpqyzQeRo5CfYY+JumWeW7zBCgmmhZui9UVz+wDD7EkwW5akySUFWXgoLVO4PlA9qtdrOb5mNvYFznVFJKmmACghpnA54bjiLMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t4YdNKw3; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4YdNKw3"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748865aa38fso100284b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 14:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750281323; x=1750886123; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oP7eGb859HKbPWx5tSNn2WyGCfeFJ17Uo6an/D8Mllc=;
        b=t4YdNKw3Z6FO1cCfpo/7Oftzf9pKISb0USriIs73JVf0b9JlDCEJFRhB17ZmMaYTNg
         p6L0SeMpZjpoIDfOrJi9FpVmiNW/tYCRPgorFWli6EZ5u/IcDNtnedTTeu62+Kw5Dz6C
         luYxsTpIm6fKQvEyWu5ZWKxkeU81INcdMXRs3D62K+4YALEKcDM3oj2tp5Bo61WlqDzc
         GKOksKUL0ZmD86kHhfsHi1od5Wl+W0ytyT8qG5AODlgSqIMw31qJACA6Khg0NdjWzhwi
         RVMp1GfonmTJn+58YKmUn8iUnnMclXICOWSMKjoK0S94/2um1tct6T7995Np+oALK62Z
         ATMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750281323; x=1750886123;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP7eGb859HKbPWx5tSNn2WyGCfeFJ17Uo6an/D8Mllc=;
        b=BJHi4OAXXZmWxDjiqm/4jJrf+LP6HrshxUMbKRA+cKq7qivlwq2MbXJ5UthRhNw3Oy
         lqZB/3B7+afmpJc2+yA0nAiA7m8dkIysZOb6nAIAV/AHiNOSO69v4Yuda3UM2NfqI2Nf
         IJIWXR8QFpxMbY3GgCrek/Od3QMMn1c3KrW6ai29p0K5DF61C5lesOdBMD/d1CR7FvGw
         BZRVxdrn/DzbvXLBidLB/Ug24jlZ6f1FslgdP5n0W4qLAITBcSui4Z5HKLiyAatWQoSL
         z6cXPUWz+0WmIWCOZFstkogirT0VaA+ARZFJVMCrdHNVkMwZTskunmCLeJcgmXLEa8w2
         2vag==
X-Forwarded-Encrypted: i=1; AJvYcCVL2ef28M8QMbWDoKGpu+qFjE4zx8qh+ylMv6vrV3c43HlXPsKtgQ9Z+qj+sZJtnfAqSz2cJVtLv5RUkDGyHopU@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEdTMiOgFafj8bq6ANbZlywgpROcLZ8uOEmCz8uepMgpIDbxr
	TJgH7yDl4R8DAAxKpiyf1ypOorh2LOCPpumLDrdYv0IWeMiLjeNN2rBMYW9zLdoxrFDrJ3M0UYG
	v0ZHaf7B5yg==
X-Google-Smtp-Source: AGHT+IFoO01mJ2VDWg8qVIkIX66bAA7kynDzS7RjllwqsYD6uzi9jl0Qa6sjsPVMfaGFMsTfrwfaoy67M+9J
X-Received: from pgbfe24.prod.google.com ([2002:a05:6a02:2898:b0:b2f:556f:74a2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e687:b0:1f5:9330:29fe
 with SMTP id adf61e73a8af0-21fbd4c7e08mr23859898637.17.1750281322878; Wed, 18
 Jun 2025 14:15:22 -0700 (PDT)
Date: Wed, 18 Jun 2025 14:15:14 -0700
In-Reply-To: <20250618211514.3084483-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250618211514.3084483-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250618211514.3084483-2-irogers@google.com>
Subject: [PATCH v1 2/2] perf test: Add sched latency and script shell tests
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add shell tests covering the `perf sched latency` and `perf sched
script` commands. The test creates 2 noploop processes on the same
forced CPU, it then checks that the process appears in the `perf
sched` output.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/sched.sh | 86 +++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100755 tools/perf/tests/shell/sched.sh

diff --git a/tools/perf/tests/shell/sched.sh b/tools/perf/tests/shell/sched.sh
new file mode 100755
index 000000000000..ed6cab34b6f9
--- /dev/null
+++ b/tools/perf/tests/shell/sched.sh
@@ -0,0 +1,86 @@
+#!/bin/bash
+# perf sched tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+perfdata=$(mktemp /tmp/__perf_test_sched.perf.data.XXXXX)
+PID1=0
+PID2=0
+
+cleanup() {
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+
+  trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
+  cleanup
+  exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+start_noploops() {
+  # Start two noploop workloads on CPU0 to trigger scheduling.
+  taskset -c 0 perf test -w noploop 10 &
+  PID1=$!
+  taskset -c 0 perf test -w noploop 10 &
+  PID2=$!
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID1/status"
+  then
+    echo "Sched [Error taskset did not work for the 1st noploop ($PID1)]"
+    grep Cpus_allowed /proc/$PID1/status
+    err=1
+  fi
+
+  if ! grep -q 'Cpus_allowed_list:\s*0$' "/proc/$PID2/status"
+  then
+    echo "Sched [Error taskset did not work for the 2nd noploop ($PID2)]"
+    grep Cpus_allowed /proc/$PID2/status
+    err=1
+  fi
+}
+
+cleanup_noploops() {
+  kill "$PID1" "$PID2"
+}
+
+test_sched_latency() {
+  echo "Sched latency"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched latency -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched latency [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_script() {
+  echo "Sched script"
+
+  start_noploops
+
+  perf sched record --no-inherit -o "${perfdata}" sleep 1
+  if ! perf sched script -i "${perfdata}" | grep -q perf-noploop
+  then
+    echo "Sched script [Failed missing output]"
+    err=1
+  fi
+
+  cleanup_noploops
+}
+
+test_sched_latency
+test_sched_script
+
+cleanup
+exit $err
-- 
2.50.0.rc2.701.gf1e915cc24-goog

