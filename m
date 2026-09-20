Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8A33E49E4
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881827; cv=none; b=NAtntYurlC+/PJFRLgiLmUy/bsQw4fbMJuwURL9fECUGy/GNmwfllT7TBotZ/8r01Zwf3Mdm1yP+GMnYJZl6TBkrC/aDSZQZHeSUgDU4JICr2UJ7enhlFxJ6OcTZp1WR2H59K7bQNF/z1t4VXO4t5j+b/DSuIaz6XBWzLd9GDaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881827; c=relaxed/simple;
	bh=R+dD7pyfh3p+FetoL7Fc01OSU4Msr7VU1kLKQYIC8SY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Az8Uc5kd68AS/kP4GFpOQPkwru1aTIRSJukqg7syTr15eF8wVe7Tk39CbImYmoRwfoJXDEMqWPJc8W0liDo2cDa9qrn1WBnxppxAog2oORv0N4rhK+6c8moAN8oJabbeYpFyrIQ6gpSUHv1MQjeZWpoECU6o+8XaE76vxua5LMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqFrIw+F; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqFrIw+F"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so2983139a12.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881825; x=1790486625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PwzLOhQPRY8w1voukNWqr8cJFks9/0WsDaTACiT/oPI=;
        b=kqFrIw+FJEIbBOaljB3jc6WnOCf6laJa2jHoadWd3+v8X6n1qqWToJ1aThxm8QwTCi
         0eGrjCh9+1XWYuzVcG86jNfNhHNDxFdnbHZWVu65QaFYScF0HogAC5gxdQ09tImDI5VM
         wtbKgDwC3elvMifKzPj2wGKUGdYFRMtilDpFeEFbdl9fq8qcKvwmdXIqs46gKHAbpkyj
         ZrQVhhy3jLPFSvpVmQYZ12/UpyafmNShNBxOH3qeabrQBT+dXJwBGTnPFY7aekFV2kxv
         WocT/T3OwK7qQX+GHSlIJou94T6XqyO8m2M6dAUfTww6LqPHun+adchGU3f9p7auBhZL
         pv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881825; x=1790486625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PwzLOhQPRY8w1voukNWqr8cJFks9/0WsDaTACiT/oPI=;
        b=IoIeoRBQrni+3BTQqaWZ8/4F5hsTBAgsTCGmrPFQtFEeYoHhHUWj8rfhLL96NSIyYb
         xQrtGKlCxrtMqPFlnEoadqmEtY6dERQe0rWD1Xzx8gSrGV1jN5IvTATODhSxzvfX1bE5
         xTvAgOQvFFzovuM2IfZY0gM4HVRYCcEdnSeXXlR29E3hB0r/titvfwxPMqIWp6SP6TO6
         JLYeLLXkKazlLca7CQEPJrWHXjBeSeuOSdKzsomDpIUuKvcxobzrJBJ4TQmfhvYYBoO8
         SHQBHAkgaQAvnwpchwEwvMGLcsERLRme8ODY8MHjG6RsSGadtlQ2wcU6OEHnYu3a6p3t
         jaXA==
X-Forwarded-Encrypted: i=1; AKwUvBxGqV4IlPHdEfex3AZeajlZj4HMUpQLKXLgoWxcysXGw09Vra7sgCjWzVn+BtDbshfSsVUsc/9y1QOGrh/GK508@vger.kernel.org
X-Gm-Message-State: AFuF++lQQg4+fW3qADTugsB5C1KT3fOReHZ4qxQ1Egi7Oazwvz5XOMt4
	/6XDRpluoyq/ObYwYhFhR7p1QBib90ZvWSseOjsaxICqrRC62jAXOWd1dJFZzLoXXSbmZXgPhCf
	HSHeXdAvt6w==
X-Received: from dly2-n2.prod.google.com ([2002:a05:701b:2042:20b0:144:db95:4a56])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9d:b0:3dd:85a8:4c56
 with SMTP id adf61e73a8af0-3dd8c53b1demr11061364637.29.1789881824924; Sat, 19
 Sep 2026 22:23:44 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:29 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <d9c044b5bbee092583b5bec727b06df44e618d49.1789880842.git.irogers@google.com>
Subject: [PATCH v1 37/49] perf python: Port check-perf-trace to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port check-perf-trace.py to a standalone script in tools/perf/python/
using the perf module directly.

Improvements compared to the legacy script:
- Access tracepoint fields directly as attributes on perf.sample_event
  instead of per-event dictionaries and legacy Perf-Trace-Util helpers.
- Decode symbolic flag and enum masks for irq:softirq_entry and
  kmem:kmalloc directly in Python and add -i/--input CLI support via
  argparse.
- Add full type annotations and clean up Python 2 idioms.

Add a shell test (test_check_perf_trace_python.sh) to verify the
standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/check-perf-trace.py         | 213 ++++++++++++++++++
 .../shell/test_check_perf_trace_python.sh     |  79 +++++++
 2 files changed, 292 insertions(+)
 create mode 100755 tools/perf/python/check-perf-trace.py
 create mode 100755 tools/perf/tests/shell/test_check_perf_trace_python.sh

diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/check-perf-trace.py
new file mode 100755
index 000000000000..19a91c7934b7
--- /dev/null
+++ b/tools/perf/python/check-perf-trace.py
@@ -0,0 +1,213 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Basic test of Python scripting support for perf.
+Ported from tools/perf/scripts/python/check-perf-trace.py
+"""
+from __future__ import annotations
+
+import argparse
+import collections
+import perf
+
+unhandled: collections.defaultdict[str, int] = collections.defaultdict(int)
+session = None
+
+softirq_vecs = {
+    0: "HI_SOFTIRQ",
+    1: "TIMER_SOFTIRQ",
+    2: "NET_TX_SOFTIRQ",
+    3: "NET_RX_SOFTIRQ",
+    4: "BLOCK_SOFTIRQ",
+    5: "IRQ_POLL_SOFTIRQ",
+    6: "TASKLET_SOFTIRQ",
+    7: "SCHED_SOFTIRQ",
+    8: "HRTIMER_SOFTIRQ",
+    9: "RCU_SOFTIRQ",
+}
+
+_GFP_DMA = 1 << 0
+_GFP_HIGHMEM = 1 << 1
+_GFP_DMA32 = 1 << 2
+_GFP_MOVABLE = 1 << 3
+_GFP_RECLAIMABLE = 1 << 4
+_GFP_HIGH = 1 << 5
+_GFP_IO = 1 << 6
+_GFP_FS = 1 << 7
+_GFP_ZERO = 1 << 8
+_GFP_DIRECT_RECLAIM = 1 << 10
+_GFP_KSWAPD_RECLAIM = 1 << 11
+_GFP_WRITE = 1 << 12
+_GFP_NOWARN = 1 << 13
+_GFP_RETRY_MAYFAIL = 1 << 14
+_GFP_NOFAIL = 1 << 15
+_GFP_NORETRY = 1 << 16
+_GFP_MEMALLOC = 1 << 17
+_GFP_COMP = 1 << 18
+_GFP_NOMEMALLOC = 1 << 19
+_GFP_HARDWALL = 1 << 20
+_GFP_THISNODE = 1 << 21
+_GFP_ACCOUNT = 1 << 22
+_GFP_ZEROTAGS = 1 << 23
+
+_GFP_RECLAIM = _GFP_DIRECT_RECLAIM | _GFP_KSWAPD_RECLAIM
+_GFP_KERNEL = _GFP_RECLAIM | _GFP_IO | _GFP_FS
+_GFP_USER = _GFP_KERNEL | _GFP_HARDWALL
+_GFP_HIGHUSER = _GFP_USER | _GFP_HIGHMEM
+_GFP_HIGHUSER_MOVABLE = _GFP_HIGHUSER | _GFP_MOVABLE
+_GFP_TRANSHUGE_LIGHT = (
+    _GFP_HIGHUSER_MOVABLE | _GFP_COMP | _GFP_NOMEMALLOC | _GFP_NOWARN
+) & ~_GFP_RECLAIM
+_GFP_TRANSHUGE = _GFP_TRANSHUGE_LIGHT | _GFP_DIRECT_RECLAIM
+
+GFP_FLAG_NAMES = [
+    (_GFP_TRANSHUGE, "GFP_TRANSHUGE"),
+    (_GFP_TRANSHUGE_LIGHT, "GFP_TRANSHUGE_LIGHT"),
+    (_GFP_HIGHUSER_MOVABLE, "GFP_HIGHUSER_MOVABLE"),
+    (_GFP_HIGHUSER, "GFP_HIGHUSER"),
+    (_GFP_USER, "GFP_USER"),
+    (_GFP_KERNEL | _GFP_ACCOUNT, "GFP_KERNEL_ACCOUNT"),
+    (_GFP_KERNEL, "GFP_KERNEL"),
+    (_GFP_RECLAIM | _GFP_IO, "GFP_NOFS"),
+    (_GFP_HIGH | _GFP_KSWAPD_RECLAIM, "GFP_ATOMIC"),
+    (_GFP_RECLAIM, "GFP_NOIO"),
+    (_GFP_KSWAPD_RECLAIM | _GFP_NOWARN, "GFP_NOWAIT"),
+    (_GFP_DMA, "GFP_DMA"),
+    (_GFP_DMA32, "GFP_DMA32"),
+    (_GFP_RECLAIM, "__GFP_RECLAIM"),
+    (_GFP_DMA, "__GFP_DMA"),
+    (_GFP_HIGHMEM, "__GFP_HIGHMEM"),
+    (_GFP_DMA32, "__GFP_DMA32"),
+    (_GFP_MOVABLE, "__GFP_MOVABLE"),
+    (_GFP_RECLAIMABLE, "__GFP_RECLAIMABLE"),
+    (_GFP_HIGH, "__GFP_HIGH"),
+    (_GFP_IO, "__GFP_IO"),
+    (_GFP_FS, "__GFP_FS"),
+    (_GFP_ZERO, "__GFP_ZERO"),
+    (_GFP_DIRECT_RECLAIM, "__GFP_DIRECT_RECLAIM"),
+    (_GFP_KSWAPD_RECLAIM, "__GFP_KSWAPD_RECLAIM"),
+    (_GFP_WRITE, "__GFP_WRITE"),
+    (_GFP_NOWARN, "__GFP_NOWARN"),
+    (_GFP_RETRY_MAYFAIL, "__GFP_RETRY_MAYFAIL"),
+    (_GFP_NOFAIL, "__GFP_NOFAIL"),
+    (_GFP_NORETRY, "__GFP_NORETRY"),
+    (_GFP_MEMALLOC, "__GFP_MEMALLOC"),
+    (_GFP_COMP, "__GFP_COMP"),
+    (_GFP_NOMEMALLOC, "__GFP_NOMEMALLOC"),
+    (_GFP_HARDWALL, "__GFP_HARDWALL"),
+    (_GFP_THISNODE, "__GFP_THISNODE"),
+    (_GFP_ACCOUNT, "__GFP_ACCOUNT"),
+    (_GFP_ZEROTAGS, "__GFP_ZEROTAGS"),
+]
+
+
+def trace_begin() -> None:
+    """Called at the start of trace processing."""
+    print("trace_begin")
+
+def trace_end() -> None:
+    """Called at the end of trace processing."""
+    print_unhandled()
+    print("trace_end")
+
+def symbol_str(event_name: str, field_name: str, value: int) -> str:
+    """Resolves symbol values to strings."""
+    # Note: The standalone Python API currently lacks dynamic libtraceevent
+    # formatting (equivalent to _perf_trace_context.symbol_str())
+    if event_name == "irq__softirq_entry" and field_name == "vec":
+        return softirq_vecs.get(value, str(value))
+    return str(value)
+
+def flag_str(event_name: str, field_name: str, value: int) -> str:
+    """Resolves flag values to strings."""
+    # Note: The standalone Python API currently lacks dynamic libtraceevent
+    # formatting (equivalent to _perf_trace_context.flag_str())
+    if event_name == "kmem__kmalloc" and field_name == "gfp_flags":
+        if value == 0:
+            return "none"
+        names = []
+        rem = value
+        for mask, name in GFP_FLAG_NAMES:
+            if (rem & mask) == mask:
+                names.append(name)
+                rem &= ~mask
+        if rem:
+            names.append(f"0x{rem:x}")
+        return "|".join(names)
+    return str(value)
+
+def print_header(event_name: str, sample: perf.sample_event) -> None:
+    """Prints common header for events."""
+    secs = sample.sample_time // 1000000000
+    nsecs = sample.sample_time % 1000000000
+    comm = "[unknown]"
+    try:
+        if session:
+            thread = session.find_thread(sample.sample_tid)
+            if thread:
+                comm = thread.comm() or "[unknown]"
+    except (TypeError, AttributeError):
+        pass
+    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
+          f"{sample.sample_tid:8} {comm:<20} ", end=' ')
+
+def print_uncommon(sample: perf.sample_event) -> None:
+    """Prints uncommon fields for tracepoints."""
+    # Fallback to 0 if field not found (e.g. on older kernels or if not tracepoint)
+    pc = getattr(sample, 'common_preempt_count', 0)
+    flags = getattr(sample, 'common_flags', 0)
+    lock_depth = getattr(sample, 'common_lock_depth', 0)
+
+    print(f"common_preempt_count={pc}, common_flags={flags}, "
+          f"common_lock_depth={lock_depth}, ", end='')
+
+def irq__softirq_entry(sample: perf.sample_event) -> None:
+    """Handles irq:softirq_entry events."""
+    print_header("irq__softirq_entry", sample)
+    print_uncommon(sample)
+    print(f"vec={symbol_str('irq__softirq_entry', 'vec', getattr(sample, 'vec', 0))}")
+
+def kmem__kmalloc(sample: perf.sample_event) -> None:
+    """Handles kmem:kmalloc events."""
+    print_header("kmem__kmalloc", sample)
+    print_uncommon(sample)
+
+    print(f"call_site={getattr(sample, 'call_site', 0):#x}, "
+          f"ptr={getattr(sample, 'ptr', 0):#x}, "
+          f"bytes_req={getattr(sample, 'bytes_req', 0):d}, "
+          f"bytes_alloc={getattr(sample, 'bytes_alloc', 0):d}, "
+          f"gfp_flags={flag_str('kmem__kmalloc', 'gfp_flags', getattr(sample, 'gfp_flags', 0))}")
+
+def trace_unhandled(event_name: str) -> None:
+    """Tracks unhandled events."""
+    unhandled[event_name] += 1
+
+def print_unhandled() -> None:
+    """Prints summary of unhandled events."""
+    if not unhandled:
+        return
+    print("\nunhandled events:\n")
+    print(f"{'event':<40} {'count':>10}")
+    print("---------------------------------------- -----------")
+    for event_name, count in unhandled.items():
+        print(f"{event_name:<40} {count:10}")
+
+def process_event(sample: perf.sample_event) -> None:
+    """Callback for processing events."""
+    event_name = str(sample.evsel)
+    if event_name.startswith("evsel(irq:softirq_entry)"):
+        irq__softirq_entry(sample)
+    elif "evsel(kmem:kmalloc)" in event_name:
+        kmem__kmalloc(sample)
+    else:
+        trace_unhandled(event_name)
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    args = ap.parse_args()
+
+    trace_begin()
+    session = perf.session(perf.data(args.input), sample=process_event)
+    session.process_events()
+    trace_end()
diff --git a/tools/perf/tests/shell/test_check_perf_trace_python.sh b/tools/perf/tests/shell/test_check_perf_trace_python.sh
new file mode 100755
index 000000000000..2c5295134f53
--- /dev/null
+++ b/tools/perf/tests/shell/test_check_perf_trace_python.sh
@@ -0,0 +1,79 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# check-perf-trace python test
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
+if ! perf check feature -q libtraceevent; then
+	echo "Skipping test, perf built without libtraceevent"
+	exit 2
+fi
+
+script_dir="$(dirname "$0")/../../python"
+script_path="${script_dir}/check-perf-trace.py"
+
+if [ ! -f "$script_path" ]; then
+	echo "Skipping test, check-perf-trace.py not found at $script_path"
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
+trap 'cleanup' EXIT
+trap 'cleanup; exit 1' TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+
+test_file_mode() {
+	echo "Testing check-perf-trace.py..."
+
+	events=""
+	if perf list | grep -q "irq:softirq_entry"; then
+		events="irq:softirq_entry"
+	fi
+	if perf list | grep -q "kmem:kmalloc"; then
+		if [ -n "$events" ]; then
+			events="$events,kmem:kmalloc,kmem:kfree"
+		else
+			events="kmem:kmalloc,kmem:kfree"
+		fi
+	fi
+
+	if [ -z "$events" ]; then
+		echo "Skipping test, no required tracepoints found"
+		exit 2
+	fi
+
+	# Generate events
+	if ! perf record -e "$events" -a -o "${temp_data}" -- sleep 0.5 >/dev/null 2>&1; then
+		echo "Skipping test, perf record failed"
+		exit 2
+	fi
+
+	# Run the script
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" >/dev/null; then
+		echo "File mode test failed."
+		err=1
+	else
+		echo "File mode test passed."
+	fi
+}
+
+test_file_mode
+
+exit $err
-- 
2.55.0.1082.g2b9226bbc0-goog

