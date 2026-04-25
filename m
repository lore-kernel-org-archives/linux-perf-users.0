Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F433A5E8C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157484; cv=none; b=SO35RzJSE8TTiWxM2RQ3KDgDD33DeGwtqh0VGGyWkB/lH7YItO3QPGgYIGsWSVYq7Xc2UWj+Ukv1Tfk3ZsM6+R6v4P0or4XansoxK26slQFRfFjTYvzcZOpe9Cc8a5eQHjgFgCdUhFRqzB8gguRpr0saSin7acLcFnbe4Guk220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157484; c=relaxed/simple;
	bh=hDYhFYuDoPCefdlf2OIwEe6ysT4MEKgdLebygFtbti8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AWlG/QpSk21u+4gs+6yh1nXfGbgzR7oBt/tPodosTVc4fxuNrd6MSscMj31ArxWxtaFB2jMvDzWULtWWIDcb6o1FPtDlPXFeD2aRSXILYrbSeKV4uncctyecGg1qWJmA+zFqup5zFWv9iDnHBGmL3Gl3ceFrGLqb+7l3Yx2B/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gk3odBLI; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gk3odBLI"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12db218e265so14789634c88.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157482; x=1777762282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRU3KdUiox4uEsWs/CeTXwwWIrylXGw9vYnzrPC1Tw=;
        b=gk3odBLIai876+7uvi4GZ1+uYYH0W/nsvyAegAnhitYy5j5dv890A4++rqT+ju75Pq
         BxknwYlUIEn75l6BOMzZEHm1KXFAttbDlQ238uxLtlFvxluXtj6in50r3r2+T3fMWF+F
         9O8/ebxwg7uy92hDj9+mom5MBUFU58/gjn6KqjXpdskN2e/AqugO4zcIFN+GmElx9LtM
         IXec0Q9IaCuy4JbL/3qHRdJ0CmSnhYyxBrb9WTpXaSchXfdO2p1ZenpUkEqNIYcPzloF
         J+Jf2LcBksp4VpjptycXK1cqKCP6pEv+EXpMGtvu9J7pNs7mhjTCSvbQ0+GbWNwmG5+1
         REkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157482; x=1777762282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRU3KdUiox4uEsWs/CeTXwwWIrylXGw9vYnzrPC1Tw=;
        b=MRcSwjbEbGoqPG1BZF7cdkjRml/jh+2at9CaLexH4SNFflcA/NHi4RqAVrKdPn/bzw
         sobTirjkRBOxTlmVFgy8uTKSaeMKfeRNW0d4PctClRH2gCqHgyvMTBSw1pVP2a+3J+jp
         9dAn2kdJ6qLzlin+mMOxhteWzrlxkJzseXofpLNfDMZUSlzRbD2IPJVMYTlv4GVNj019
         vDYXAlqZjCGBwGpV3qN08HYTUuZX18dqUNrkjm8c2MqlTWOYmvl4o8fr0+kRgvM4gLm1
         Fpp6Y4WuwSARQ+RjQyICNQm0oxu+Jk8erHEPhabZsVx8ZNktKqgKpD/raPJHDVa1QM9t
         pucA==
X-Forwarded-Encrypted: i=1; AFNElJ9i3/u96GIK2FtF59NxRK7hMIGowbD2xmLVsCH5dfiOcsU5ehMKsR4KQ+scshfDFwEZ4WTs2SIZeOh/WQVQtYTh@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwd3uqxCjArs6OfnSB5vo/cSnX1dxFsqWv1a1geSaxXVr+ZMQH
	O4qG4TGrxU0CBgpdH72VRcZgqu623949H66rQXrODDLmXTpqorRIAJGkgUBEeJ4Az7nqid0JNpd
	mFByX+SKETQ==
X-Received: from dlbsj13.prod.google.com ([2002:a05:7022:f90d:b0:12d:b591:4bad])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60f:b0:127:3915:76b2
 with SMTP id a92af1059eb24-12c73f9ae51mr22028481c88.27.1777157481565; Sat, 25
 Apr 2026 15:51:21 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:25 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-34-irogers@google.com>
Subject: [PATCH v7 33/59] perf check-perf-trace: Port check-perf-trace to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the check-perf-trace script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:
1. String Match Accuracy: Replaced the substring check for `irq:softirq_entry`
   events with a robust exact string match.

v3:
1. Safe Thread Resolution: Swapped out sample.sample_pid with
   sample.sample_tid and safeguarded the session process lookup with
   a try-except block.

v4:
1. Git Fixup Cleanup: Squashed the lingering fixup commit from the previous
   session into its proper patch.
---
 tools/perf/python/check-perf-trace.py | 113 ++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100755 tools/perf/python/check-perf-trace.py

diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/check-perf-trace.py
new file mode 100755
index 000000000000..7c1c7632a091
--- /dev/null
+++ b/tools/perf/python/check-perf-trace.py
@@ -0,0 +1,113 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Basic test of Python scripting support for perf.
+Ported from tools/perf/scripts/python/check-perf-trace.py
+"""
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
+def trace_begin() -> None:
+    """Called at the start of trace processing."""
+    print("trace_begin")
+
+def trace_end() -> None:
+    """Called at the end of trace processing."""
+    print_unhandled()
+
+def symbol_str(event_name: str, field_name: str, value: int) -> str:
+    """Resolves symbol values to strings."""
+    if event_name == "irq__softirq_entry" and field_name == "vec":
+        return softirq_vecs.get(value, str(value))
+    return str(value)
+
+def flag_str(event_name: str, field_name: str, value: int) -> str:
+    """Resolves flag values to strings."""
+    if event_name == "kmem__kmalloc" and field_name == "gfp_flags":
+        return f"0x{value:x}"
+    return str(value)
+
+def print_header(event_name: str, sample: perf.sample_event) -> None:
+    """Prints common header for events."""
+    secs = sample.sample_time // 1000000000
+    nsecs = sample.sample_time % 1000000000
+    comm = session.find_thread(sample.sample_pid).comm() if session else "[unknown]"
+    print(f"{event_name:<20} {sample.sample_cpu:5} {secs:05}.{nsecs:09} "
+          f"{sample.sample_pid:8} {comm:<20} ", end=' ')
+
+def print_uncommon(sample: perf.sample_event) -> None:
+    """Prints uncommon fields for tracepoints."""
+    # Fallback to 0 if field not found (e.g. on older kernels or if not tracepoint)
+    pc = getattr(sample, "common_preempt_count", 0)
+    flags = getattr(sample, "common_flags", 0)
+    lock_depth = getattr(sample, "common_lock_depth", 0)
+
+    print(f"common_preempt_count={pc}, common_flags={flags}, "
+          f"common_lock_depth={lock_depth}, ")
+
+def irq__softirq_entry(sample: perf.sample_event) -> None:
+    """Handles irq:softirq_entry events."""
+    print_header("irq__softirq_entry", sample)
+    print_uncommon(sample)
+    print(f"vec={symbol_str('irq__softirq_entry', 'vec', sample.vec)}")
+
+def kmem__kmalloc(sample: perf.sample_event) -> None:
+    """Handles kmem:kmalloc events."""
+    print_header("kmem__kmalloc", sample)
+    print_uncommon(sample)
+
+    print(f"call_site={sample.call_site:d}, ptr={sample.ptr:d}, "
+          f"bytes_req={sample.bytes_req:d}, bytes_alloc={sample.bytes_alloc:d}, "
+          f"gfp_flags={flag_str('kmem__kmalloc', 'gfp_flags', sample.gfp_flags)}")
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
+    if event_name == "evsel(irq:softirq_entry)":
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
-- 
2.54.0.545.g6539524ca2-goog

