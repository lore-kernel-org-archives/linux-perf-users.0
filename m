Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103D3D9691
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881800; cv=none; b=IopDdTKxPj+x9VKFYW4jD2ZYFqDEPFI8XVI7GRKkRAdxmWEnjOsUXL4qep1Y08v9oRApATfiTj6xQrme9PnUk1E8ZbwdJKmYv0iQVf2rsA60epd40eI3OWuXMRWGSbMFrKYHDh6UIfYlDlfMgPDaS52iBKbCYHoPLt5S+Z0Lkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881800; c=relaxed/simple;
	bh=rhjcAI4sNt7OTGABpGcKH2OllPj9Wo6orRoDTaiDifA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=siQHU1AKDIA7yLLA4TQUPi/jgv+sSNnmx+Jah6mKA8gASIh5unzgmI9lPkpCtor2GYpEs6ufQ6xM6tEhZweAhhaQd0ckMWIU6BAzGSY/sjC8/be8yEJZL2VqNd2SXzuEFHZHPrX/n7ff14FxWv0GU08uajnPrSJKDBZmvSUxMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQjynUHG; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQjynUHG"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc21bc2923fso1816655a12.2
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881797; x=1790486597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vi/34YV50+6TfU5NCYi8lPB4wKuP/23lh2fEWQQ19Xo=;
        b=dQjynUHG5EVVeDz8I++9IfE74W7p4XhxYu/OTCmkyU/oQB0VjwIT5x58vFSJBQtadk
         wwL/v3EWTvkouEwiY+PoQSwwoOeNeERSyBe7FAtC2sZKjW//nrxSxAXgn953k2nVtuE0
         dypea0FplEBFe41hF/YtSEmAX0euK7Qqt7UmYcReXMpGinm3XZifpc9nlJZm3bc0DBUZ
         3Ee0kBz5oEVpLkktNecuLfzdLh9dzR4iRRjISjWVS8KkntyvbkYh/ePRorwcm/8LB8cy
         CtAHapGvm6EOQIXv0sUkJI7Iq4IA5hnsnMLN1mVQY6CQ3WSgOntXX8YYR15oj2H3hQJ/
         F8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881797; x=1790486597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vi/34YV50+6TfU5NCYi8lPB4wKuP/23lh2fEWQQ19Xo=;
        b=pYKeQ3qey8cR3Lv3AWRvY9kDe1x1ID+aOy9TP2bZGjKWe2Ewf4Rd6ybNefVIkqXMrK
         0hHtsayzKQ2B6DQVZvxNvZCmDd7RTO2d3wq0AuiPYETnQ8x51eEHLDUrMmSdAYeALzX3
         P+CG0iGSDjBijJD1nxngYRAxh2KkiSkLxcvJhEbkJ5U7QZBYhJ0RP4HAHEXaw8la5wuz
         TXaBEcNy9IwfoYXkwK7iN2jkrHOw7Rn7rnZ8inWKPJf6S8KEwy+HCH722+fBdDzmdWCS
         QnKf5MrVRC1dCtT0MqmtQ33K3AH2LEu6RIPUFiilp6SChOUyvI8jMkWMAdPnFyjLSo54
         dAoQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1NzZp+ownwD6oTx64P5PdBH6/vOoRVvjr/5p2cX7Y1N7Jo9anApvJJ88dbRCiq2hVQ3Y5oN3PimaN/Zf6gIe2@vger.kernel.org
X-Gm-Message-State: AFuF++mTzZUjNsNfPDqJMU5iyf8RSL0HhmiOjqFyNPLW6YMQCT6bv/1U
	LZ7mQL9x7q6WS7MqguIsNvxcnL569MzSc42PZpdE+d8xeQ2rnTxWli2TBPdzwDOThAvtBe+u9IQ
	sqbanW6QE8w==
X-Received: from dybdx7.prod.google.com ([2002:a05:7300:b187:b0:33e:48b8:3a2b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:151a:b0:3db:2c66:6638
 with SMTP id adf61e73a8af0-3dd8c40509emr11925844637.10.1789881796752; Sat, 19
 Sep 2026 22:23:16 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:14 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <53614f9275f1b75f3ed26a36d36805bb2053001e.1789880842.git.irogers@google.com>
Subject: [PATCH v1 22/49] perf python: Port syscall-counts to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port tools/perf/scripts/python/syscall-counts.py to a standalone script
in tools/perf/python/ using the perf module. Avoiding the embedded
interpreter and per-event dictionary allocation overhead improves
execution speed by ~4x:

```
$ perf record -e raw_syscalls:sys_enter -a sleep 1
...
$ time perf script tools/perf/scripts/python/syscall-counts.py perf
...
real    0m3.887s
user    0m3.578s
sys     0m0.308s
$ time python3 tools/perf/python/syscall-counts.py perf
...
real    0m0.953s
user    0m0.905s
sys     0m0.048s
```

Additional improvements compared to the legacy script:
- Resolve syscall names using perf.syscall_name(id, session.e_machine)
  instead of host python-audit / Util.py tables, enabling accurate
  cross-architecture perf.data analysis without external dependencies.
- Support both raw_syscalls:sys_enter (sample.id) and individual
  syscalls:sys_enter_* tracepoints (sample.__syscall_nr / sample.nr),
  filtering out invalid/corrupt (> 0xffff or negative) syscall numbers.
- Add argparse CLI options (-i/--input and optional comm filter).

Add a shell test (test_syscall_counts_python.sh) to verify the
standalone script. The legacy script and its bin wrapper are retained
temporarily during the transition to maintain bisectability and are
removed once all scripts are migrated.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/syscall-counts.py           | 79 +++++++++++++++++++
 .../tests/shell/test_syscall_counts_python.sh | 74 +++++++++++++++++
 2 files changed, 153 insertions(+)
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_python.sh

diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/syscall-counts.py
new file mode 100755
index 000000000000..4b0733b1536d
--- /dev/null
+++ b/tools/perf/python/syscall-counts.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Displays system-wide system call totals, broken down by syscall.
+
+If a [comm] arg is specified, only syscalls called by [comm] are displayed.
+"""
+from __future__ import annotations
+
+import argparse
+from collections import defaultdict
+from typing import DefaultDict
+import perf
+
+syscalls: DefaultDict[int, int] = defaultdict(int)
+for_comm = None
+session = None
+
+
+def print_syscall_totals():
+    """Print aggregated statistics."""
+    if for_comm is not None:
+        print(f"\nsyscall events for {for_comm}:\n")
+    else:
+        print("\nsyscall events:\n")
+
+    print(f"{'event':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+
+    for sc_id, val in sorted(syscalls.items(),
+                             key=lambda kv: (kv[1], kv[0]), reverse=True):
+        e_machine = getattr(session, "e_machine", 0) or 0
+        if e_machine:
+            name = perf.syscall_name(sc_id, e_machine) or str(sc_id)
+        else:
+            name = perf.syscall_name(sc_id) or str(sc_id)
+        print(f"{name:<40} {val:>10}")
+
+
+def process_event(sample):
+    """Process a single sample event."""
+    event_name = str(sample.evsel)
+    if event_name.startswith("evsel(raw_syscalls:sys_enter"):
+        sc_id = getattr(sample, "id", -1)
+    elif event_name.startswith("evsel(syscalls:sys_enter"):
+        sc_id = getattr(sample, "__syscall_nr", getattr(sample, "id", None))
+        if sc_id is not None and (sc_id < 0 or sc_id > 0xffff):
+            sc_id = None
+        if sc_id is None:
+            sc_id = getattr(sample, "nr", -1)
+    else:
+        return
+
+    if sc_id < 0 or sc_id > 0xffff:
+        return
+
+    comm = "unknown"
+    try:
+        if session:
+            proc = session.find_thread(sample.sample_tid)
+            if proc:
+                comm = proc.comm() or "unknown"
+    except (TypeError, AttributeError):
+        pass
+
+    if for_comm and comm != for_comm:
+        return
+    syscalls[sc_id] += 1
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("comm", nargs="?", help="Only report syscalls for comm")
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+    for_comm = args.comm
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    print_syscall_totals()
diff --git a/tools/perf/tests/shell/test_syscall_counts_python.sh b/tools/perf/tests/shell/test_syscall_counts_python.sh
new file mode 100755
index 000000000000..e1c6e2820cce
--- /dev/null
+++ b/tools/perf/tests/shell/test_syscall_counts_python.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# syscall-counts python test
+
+set -e
+
+shelldir=$(dirname "$0")
+# shellcheck source=lib/setup_python.sh
+. "${shelldir}"/lib/setup_python.sh
+
+# If we don't have the perf python module, we can't test
+if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
+	echo "Skipping test, perf python module not found"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/syscall-counts.py"
+
+if ! perf check feature -q libtraceevent > /dev/null 2>&1; then
+	echo "Skipping test, libtraceevent is disabled"
+	exit 2
+fi
+
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, syscall-counts.py not found at $script_path"
+	exit 2
+fi
+
+err=0
+temp_data=""
+
+cleanup() {
+	rm -f "${temp_data}"
+}
+
+trap 'cleanup' EXIT TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+
+test_file_mode() {
+	echo "Testing syscall-counts.py..."
+	# Some systems might not have raw_syscalls:sys_enter (e.g. stripped kernels or permissions)
+	if ! perf list | grep -q raw_syscalls:sys_enter; then
+		echo "Skipping test, raw_syscalls:sys_enter not found"
+		exit 2
+	fi
+
+	# Generate some syscall events
+	if ! perf record -e raw_syscalls:sys_enter -o "${temp_data}" -- sleep 0.5 2>/dev/null; then
+		echo "perf record failed (permissions?), skipping file mode test."
+		exit 2
+	fi
+
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+
+	# Test with a comm argument
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" "sleep" >/dev/null; then
+		echo "Comm filter test failed."
+		err=1
+	else
+		echo "Comm filter test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

