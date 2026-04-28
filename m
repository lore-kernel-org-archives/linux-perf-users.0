Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38123EC2F4
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360828; cv=none; b=VoR++d5GngrkroiageOVwVF6pLliPL+K47F/IH/EBZjoRMwCOW7eX3FbnyMy6DJUvihfK+8WBltTWJBWiMBoaMasIl5YjOyNahAyu65cnve50QdN1kzdQ26/mM/Dx8QggLmY9sJKKhZzj7UnlWGhqUUba0t70O6/LQCfIn6392I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360828; c=relaxed/simple;
	bh=mBMBYkMBlLDWvbY6LNmW//JVcjR4jVeKSUbnOQaL0o8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Tr2LgtM3ZRLAF1VAnEsnbzDHvGQpzUF4agqkf6HFgk/6r5JTsL77nyhx+EW/nBUujhujMymzMvVYQP9h1A5Fc1ngoP6X2A2ZU3b8xCUd7iya9wUrqRAgI/6Mhx+q2X8F/G0N/iGLpJ9v6Bsiy8RSenuHjoVg7iACYlXMX97sXbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ne3h4hEw; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ne3h4hEw"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso14245976eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360826; x=1777965626; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lupTwS5/K/xdMFN4T0R1lWQWxBJkMX0Mah0jUIak+cQ=;
        b=Ne3h4hEw6Buf3ZlHAEtIDdwsWg3ppttRXa7s+bRx+6/nPA041cwolFYB+sVb9QNGLq
         pz9zwNssgS2SiapAiPl2IdJ0H2/SzQ3vP9xz0AfpB0Mj2Kg6U2CgFoVyoACq53H2OOYW
         macwDtKPFPDjVutbbJRr6HJlIXOZgNKcNeIdb3Uo0vHjt6tAoeSpDubze0f4/3UrhRH6
         vb0XN+Naig79sVJ/lXSqSd7LOSLglVsZHmg6afanKvAd1pmHSoV97p5C42iIUR+rYUVa
         SdaCO/OWPY2ncIb8SQ6fRIRlE/wa3WnmKMS82QPctJDpDCZOcioWyNctxGoc08nQLjkc
         YdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360826; x=1777965626;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lupTwS5/K/xdMFN4T0R1lWQWxBJkMX0Mah0jUIak+cQ=;
        b=peYJepYuW5bZ0zHS0VX0dgR2N62NfKvr3SrfyhwUEL3GopLpo/UqIRKxXnDMA5IDa+
         ITTw50iDj0qZbgrTzUYlXEQZYwD3++TDIEGSTmxlncWmE3w3IW193/y5+Jn2ri0B1rPo
         gtcyzsnnUZpKKwbfTtI2aJaG6217e7Cai5DYFXxdTwJX69zciwiPolcMQn4ZC05tG87F
         b9213XQv8beYxNZ8KxXI9Wym59TZUXfZZlR3YjZwa1sJuUB9+yZfLGOop5NbWtQR13qt
         PgnJ9+et0ecEiS98LmAM+v4ifbo+DXP3Mrz16L4YEW7DjkyAwoPHxw2IzJVU5LIG6Hnc
         ug+w==
X-Forwarded-Encrypted: i=1; AFNElJ99s61C6lQPIev/q4Xo8xwjQ/btpdbqU+qYuqu0I1KMatQJPMFQy3ZBYii1vJf69HcL1DBZyHlhL7f+7YV5XYRJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzU7r+mKgerN5mVXA1NLfDnxg9EWImBf/co9fntwjLx3smP3/mF
	lSaor+0+bSwiGKNWkzKq0rdXn9QLt7tufNW5eJ2D3nfJXi70i6CTRIIFWXG2GRUQpu5rF5Njlpn
	/g5krsYKcHw==
X-Received: from dybnj5.prod.google.com ([2002:a05:7300:d085:b0:2dd:4573:2897])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fd0d:b0:2ea:d965:a4b9
 with SMTP id 5a478bee46e88-2ed0a03466amr992245eec.7.1777360825780; Tue, 28
 Apr 2026 00:20:25 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:38 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-34-irogers@google.com>
Subject: [PATCH v8 33/58] perf check-perf-trace: Port check-perf-trace to use
 python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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

v8:
- Wrapped session.find_thread in a try-except block to prevent
  crashing on untracked PIDs.
---
 tools/perf/python/check-perf-trace.py | 120 ++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100755 tools/perf/python/check-perf-trace.py

diff --git a/tools/perf/python/check-perf-trace.py b/tools/perf/python/check-perf-trace.py
new file mode 100755
index 000000000000..bbcd0c520745
--- /dev/null
+++ b/tools/perf/python/check-perf-trace.py
@@ -0,0 +1,120 @@
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
+    comm = "[unknown]"
+    try:
+        if session:
+            thread = session.find_thread(sample.sample_pid)
+            if thread:
+                comm = thread.comm()
+    except (TypeError, AttributeError):
+        pass
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

