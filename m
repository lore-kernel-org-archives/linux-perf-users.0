Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34FC3CF029
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916610; cv=none; b=SM65eWa6Hs1Us5l2wP9bdVztC6c7SgGA4vtNT/aIVu6/J41o5FF6XjG4/IyEhwB1jvURuukqW6npyuc7Rd34jKjMDSOewFjoWvdp6czklf1HhbjoVewLxalfGU60EpR6YmQUIsNu6IUMPaGYCkBAJm04RUkz6vCudab/HA1LAfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916610; c=relaxed/simple;
	bh=ipPmGs9q0ZJQLxP3JPVNjA66jyepwX9PLyqTCBneOFo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=deHTZpxi140qC7HBpRa8FdpXpaV25IkIqQvxWhigXMQ/RtNBZztIsbibV9i7LxlSpuKDLt1TJTtFl3WuBNZE7N98IKbhe8hwdGKnxEzXl16rR7QmwJULxJk3SMG0ectMaDQHfFOPJecaImghhw9eAtoN+8SospXkWJCEyAvt5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tK444Omc; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tK444Omc"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c726f4055so5031067c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916608; x=1777521408; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LvWdC9MMJrfI+oO6zM6PGe+LkXtTTTPrADECnPOWFa4=;
        b=tK444OmcbgL+GFN6N86XRW90pc76R+Tm1mku//u0TnjX62jsLLNDV/NTuGKqAdxgHH
         AttvR640OEB0oemWVMw/Z4gGSQUEJt1h3rK4Cn1ui+AOByfEfWRq/jg8cDMvqkezJA4F
         hR5A+0LNJMDMAngjpvQy64gCh1ePH2tlfuSeXbZkdfEF17yLQkmrZabmNvPPWi/qacGi
         VBRYnER/Mupt6xPYVmn/BbM5iJRWYhH+e4V1Wfxc8bsH5IiKbj2rTJQm1TQlRy0UzI3r
         QrN1bOIwqNs3RSPqZ0UbHBzV8gJFtgcJQKvb+CzAW77ag4glbe3JV+heZsuB1uOCWnb2
         ZcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916608; x=1777521408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvWdC9MMJrfI+oO6zM6PGe+LkXtTTTPrADECnPOWFa4=;
        b=Fic47VGMGELprRgSiVD38RODn24ruJFsMX1RJkgEUIk5ySgw4WuAfZuWrBUkVr6Dc/
         gJueT9kY3/sUjgU9ZzJCn6B6NE7AXeIhQiIngKELfDF8TpgLH1Po3CBwfLVQ3INIY5Sk
         OfKoq43e4SwljoBAlrxRftVBQ9sgHgWZlaPnNPDiKGdhw6kbc94GvMbmUOwkl5hEH2DR
         b3WsLbPHji3X2XKCVclXvIR1v6scg+IQwbc2X1LXUl3+A3jJd2YAlHgnID2qiMC5kncI
         uz0RqfQy1fA+WTAYYLLRVtXKjQj/kF7GivT0k96GCuWNHkgl15xMayDPmKeWtqdLb+Lu
         nowg==
X-Forwarded-Encrypted: i=1; AFNElJ+HzRbKlTnR4AW8emZnE8JhLmVscOXiJ9VwM+V5LWQD/Go2jjwUoGFJVn2/rwRhWMEApmLJsWC1kALa5q7FmRf5@vger.kernel.org
X-Gm-Message-State: AOJu0YxIs6ShTIJCquHEMPthtHFb8RksRUgpapGkf1ecNgfYwnr85VbP
	S1V7KqhjuOPFLKboU4qdQjGdRjhDfJWJkP3NhJrkIsXDJ4aHmOuTxSIAnvZaQHy/i8mQLKpDR8O
	2KBhAsU99Zw==
X-Received: from dlam10.prod.google.com ([2002:a05:701b:208a:b0:12c:912f:7d3f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:383:b0:12b:ec15:69d2
 with SMTP id a92af1059eb24-12c73fa9460mr13299508c88.33.1776916607642; Wed, 22
 Apr 2026 20:56:47 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:55:00 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-34-irogers@google.com>
Subject: [PATCH v2 33/58] perf check-perf-trace: Port check-perf-trace to use
 python module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
Content-Type: text/plain; charset="UTF-8"

Add a port of the check-perf-trace script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.54.0.rc2.533.g4f5dca5207-goog

