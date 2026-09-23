Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE7440A0D
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187310; cv=none; b=lDnQ8pJB+7A3fg76baIfGM/e7Gu7uP3f4a0riXPIqDmy9FUX5AxwpexsZdMfM7IN0tIg8LyH3nq95WgO6o2vVH5Pec7cCA3oFlu8HeMLq96aD/c8lRlfK2PYuZaM6QxYwpQhn9G5E8xvU2mi8iOcRKLbDITAY+1ReA6d4QtSPFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187310; c=relaxed/simple;
	bh=pUVknrzV1Zt6LM5wd0/6spCjNo2+nFF5fiUa+2u4a7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M3FAHDWChyCAVVnIdRjVhzGH5IhBGhcEUJWh4xHzdZ1JU1RuKCQqWBCDWEESHrpg+0pmv21B6LDmJICD/jJK85+HKNhSeEPxowlbUJ1n2VEIMiHm4c5HVvbW8mcKPk/ZZfwCCn8/uXFzH4q6KupqJy/73s3yZru+1u7o8y1GHnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8kKdNh9; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8kKdNh9"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-143580417b3so4353969c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187296; x=1790792096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ryNNbnywJo/i1hmDLVze7m71s6BrKikjpEExddeRm90=;
        b=b8kKdNh9cdCFf5nBHH8Dk0xpDBZBX5LATpaIBC2quwaEHo7UP7KaS3Nd++DB9Vwiyj
         KIFINc7covv3wIWIvDCen9KXHWWQ3VL5lKmX+acLrEAznmqyqnAJ+fy8fRY5sFOIlJ9O
         aM3PE7OpfGduh23GbMndwHz82G5Cl4D6l++EXrOCGbK3aoG1zPlwdywfe9ZqNWnlBXER
         lxnOqfHMCLRiwDW42E770cXiZY1VbAOsr6E6BQFokRVlyCAhDdfyRJTGiOq6WhW6O3FH
         l1lFsntaA0d4y5rKI/6WZP+tMKrDcNL5dzw9bFQCqKOkYecvVmFLpMTTdF+s3gdmF8Wb
         Gsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187296; x=1790792096;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryNNbnywJo/i1hmDLVze7m71s6BrKikjpEExddeRm90=;
        b=BT8BI+WDdGlOJW7bywSExUd/slRS6Cs8I1w+Hz7wRShCIv3tuZvZB3HmNQ3GuytjtS
         t2LynTnVNMvpwwEZ39DJwvUYGIpST/KASgQ1WaZHFSpiFlt9uoNZzlhu0+uQZk5LR0Mn
         ZzAgJ0s4qknxW+MnlTJuHj2aL0aSbZ1dzySAagsooCKm9xTEYSNZHtuiZx43oTkh4foR
         xTfbiDAabMv4xnQL+Qyeaucz3mzoSkSvCJ3H4PyNv3FaIq7OOZe++smZj5cFaRU5qO4g
         omEv/2S4razvojvQuQP+/5Kdrauu8MJDHb5EL7rT5WVbFWjn/cua0i3kUVMEE9lohDWd
         rGZA==
X-Forwarded-Encrypted: i=1; AKwUvBzGLsvFwWg1dhuwNhjr/zR9aFIUOjO08FmToCzgy+8nI2oZRbBcPKyrSumHkj+9Qi32Xug6ff+giqrqmW56hoFr@vger.kernel.org
X-Gm-Message-State: AFuF++mquOIiypTvGG6NtTjveuZ1i2c6c4wbv/WrM3I3NZTjtvC8w5DQ
	NLL/tjH/2Ryle+ZreegiWyknW9/auTqx+NSVEP5zIwKss2183Osg8qyqymJz5xq0tl/M7vbx2id
	bSIDgvBYKew==
X-Received: from dlec11-n1.prod.google.com ([2002:a05:701b:428b:10b0:144:e316:2636])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4192:10b0:144:ed18:47ab
 with SMTP id a92af1059eb24-144f918635amr3819573c88.13.1790187295524; Wed, 23
 Sep 2026 11:14:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:12:00 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-38-irogers@google.com>
Subject: [PATCH v3 37/49] perf python: Port check-perf-trace to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
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
 tools/perf/python/check-perf-trace.py         | 223 ++++++++++++++++++
 .../shell/test_check_perf_trace_python.sh     |  85 +++++++
 2 files changed, 308 insertions(+)
 create mode 100755 tools/perf/python/check-perf-trace.py
 create mode 100755 tools/perf/tests/shell/test_check_perf_trace_python.sh

diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/check-perf-trace.py
new file mode 100755
index 000000000000..a7679a897cc7
--- /dev/null
+++ b/tools/perf/python/check-perf-trace.py
@@ -0,0 +1,223 @@
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
+    print("in trace_begin")
+
+def trace_end() -> None:
+    """Called at the end of trace processing."""
+    print_unhandled()
+    print("in trace_end")
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
+            thread = session.find_thread(sample.sample_pid, sample.sample_tid)
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
+    if event_name.startswith("evsel(") and event_name.endswith(")"):
+        event_name = event_name[6:-1]
+    if event_name.startswith("irq:softirq_entry"):
+        irq__softirq_entry(sample)
+    elif event_name.startswith("kmem:kmalloc"):
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
+    try:
+        session = perf.session(perf.data(args.input), sample=process_event)
+        try:
+            session.process_events()
+        except KeyboardInterrupt:
+            pass
+        trace_end()
+    finally:
+        # Break the reference cycle between the global session and the
+        # process_event callback so the C perf.session object is freed.
+        session = None
diff --git a/tools/perf/tests/shell/test_check_perf_trace_python.sh b/tools/perf/tests/shell/test_check_perf_trace_python.sh
new file mode 100755
index 000000000000..a346e45eb18c
--- /dev/null
+++ b/tools/perf/tests/shell/test_check_perf_trace_python.sh
@@ -0,0 +1,85 @@
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
+temp_out=""
+
+cleanup() {
+	rm -f "${temp_data}" "${temp_out}"
+}
+
+trap 'cleanup' EXIT
+trap 'cleanup; exit 1' TERM INT
+
+temp_data=$(mktemp /tmp/perf.data.XXXXXX)
+temp_out=$(mktemp /tmp/perf.out.XXXXXX)
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
+	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
+		echo "File mode test failed."
+		err=1
+	elif ! grep -q "in trace_begin" "${temp_out}" || \
+	     ! grep -q "in trace_end" "${temp_out}"; then
+		echo "File mode test missing trace_begin/trace_end markers."
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
2.56.0.rc1.310.g51773c2048-goog

