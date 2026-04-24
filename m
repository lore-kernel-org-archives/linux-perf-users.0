Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D533C1BE
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049337; cv=none; b=GFCntgtdJoxo+xiWrq2mOcVSFkMAER8BFTFRhUWVf1Q+gbown9PFr3sBHFFDdfTxFX5uz72qGjgmfUEiaCQ5uSYxoEqhuTo/ch2m2ZYDQCnTe7qx4R52owsBj8Ci0FxgsYHqCI297ia9dgdk6FiIijG1GaHT7YNWqaR9Y/lb3L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049337; c=relaxed/simple;
	bh=KHUq/7wWhLxydGBK+fGtbYhBCHsMbM64n7+X2l5Ym8M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fFB8wwqxr+1Nuwv7RZ7b7a/jaDWzLkfHFF/G6oS7xyuKBewi1cP+D085SO9b7zfppoChxBVjI4GTeWT7dXH1iv5YyDenHyd+QPiq6DFZyUe7KQ/6HjW4GmxzCO1WyaZc3SH3k56ClQMDVecixi7T93KL9TyxRsUib/OUsI0DAfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXN9xDEF; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXN9xDEF"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2dd6fb4c867so12065947eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049335; x=1777654135; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgYnl3XjZw1LM3PPexpVL2rKOKFvUzBtuSscfGN+JSE=;
        b=JXN9xDEFLzusuDN2wG3NvNmieqqPVAXevHAMUmhf9QUkYoQg41e7NpUlx0/TOd96F6
         D8MlIOuWnhZrdNV19Z9YH+AzryyzMcGrg2idQdyv8/BO7Vpf78NhRnkQWaH/JfZzSRle
         Ok9R355CjSfcXrP9aHw3DZTYWmMxW4ZysGlKgsUSTX3ripVB4oQnWm2rHRuEVUdFSI+g
         tFwhrmP1ff0kYGcNSv9GN4k2PexPvCtNKIo9FqT/7lahgBg6oKsi3AuANjZ+hWAtfroY
         n5H4GroeVhnOrxk470etTlBFgvAiA8M204/eNxOkrWTpdGqa7DdC1Hc1fkwjgBzEWOwW
         HnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049335; x=1777654135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cgYnl3XjZw1LM3PPexpVL2rKOKFvUzBtuSscfGN+JSE=;
        b=m4wUk95u3QyN+9Jd8+W2zCpgAsjsk+SoH7uNPc101Un5c0e7LPhZc0EBiCTQjemOe9
         sr4PusCQBkMmt9EIrG6hPEDzA7XmpC9Qy7xnUAQjh2fOYBSqMCV0EOZVmMOxr6+fle+/
         2lv8ed6W7bAA+MSt/qmUeULoPs0jCPzQBKc/CTsqdpaJn87eYSaUGXSx25m/5SkEOtBR
         1D48rliZyyBILXZQ+6G511mEdQ6aRW8zCQ2yJGH9b10iVFg/8MLyhaaUYcXQgWv8p5lL
         uRyVtf+B8u03/3uhtrf6BoaDGrfZoVH+UlgYlqPYUtVVG8HKfUM4pyQakfn6HwfBHjOd
         GjVg==
X-Forwarded-Encrypted: i=1; AFNElJ9JcDJVbbFWc7DyDFmO9CVs7PRKeyLshVbkzwNmBsX2UEjFy4LpcTfF6mFi3XXxO7a9vY18VzvFq6MA9fp1Xa2x@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsgq+tCGs6dCbxDnURV6WYphHila4O9YfvTnpwDsiiBom2OGGm
	R6bhdaoD7csIfy+pSf8Z+IKEEaTEasIRW9e/t7YQEwiSCrnifI4TiGajHkn8ptbfQZ+a7t1D7sE
	2Eup+YobPIA==
X-Received: from dybmx9.prod.google.com ([2002:a05:7300:d409:b0:2d7:d4ce:8994])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6da7:b0:2c7:8e1c:956a
 with SMTP id 5a478bee46e88-2e479d076b0mr18620129eec.19.1777049334876; Fri, 24
 Apr 2026 09:48:54 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:55 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-34-irogers@google.com>
Subject: [PATCH v5 33/58] perf check-perf-trace: Port check-perf-trace to use
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
index 000000000000..4c05540bdc05
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
+    comm = session.process(sample.sample_pid).comm() if session else "[unknown]"
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

