Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9B437267B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139410; cv=none; b=Vl9iyHbCCF0q/qHj386RSO3UGCNiE4nPn1JGzwUZmQKYJD51SRrmvNOML/8wr49hIheLrcSkJZNE04v/AiN8M/Zf+wekTuquja4LQYVhcRWu/qSHUB2M263LXzqwmQcsyfbvzNGsd5aSkYvPwsbzBsfXZmmt/J5nhzPmnRKq+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139410; c=relaxed/simple;
	bh=hDYhFYuDoPCefdlf2OIwEe6ysT4MEKgdLebygFtbti8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qjZs4RxObclLpIM65L9pCYOBMzZ2S/C+J4Ft+2pL7qmWeYbQwWY5uDDPmbm5uxIF48tVTBJZ9HXwDsADTl5JpWUDgwNSd4PKgqGCWT5ogYbGBKNykGZcTSvMjeDnJSRVaTg1WXRk/ZhpGlWnWiuEWNGkzQCmG3lyVP9jZ5Hh8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BN3Y0B7Q; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BN3Y0B7Q"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2de07c12745so24740618eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139408; x=1777744208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRU3KdUiox4uEsWs/CeTXwwWIrylXGw9vYnzrPC1Tw=;
        b=BN3Y0B7Q01kSTREY0OizvhBhEQ+biOHJz9v3bqFVak8RCtMHuCnCGZONmD4UBmXksR
         UTeM9C+QApyc98Bj5hZ5x5rtxPJ2xkLas2alFcqZ0+cbGWug5bMka6OALptoWiW5Ee0J
         GqTAvXT1IglIWos8V+Y+qtk5jUjtqaUuiJqtd2ghGp6ZG6Aogf1wt73OjaTmcpj28Jgt
         g1zY1Ub1iHlxhwpmeF0iedRkQCp0gcLziF5YVubupFifgwcpoo6irT3HlNHErG03hYAT
         ydoRTEic3sRx6b+OBOA6H2j9M1Kvi4+w7aINvWqbwe7W3thF85AQurtROjMMx77jLvRT
         pwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139408; x=1777744208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERRU3KdUiox4uEsWs/CeTXwwWIrylXGw9vYnzrPC1Tw=;
        b=bBapqoRgAOmYm+BJl4+BtZBYpiik+rHvlT7cwn96YjeowKKTr3a0Ja8PyMsKibx6BZ
         J27fhdqHa0ZWb+GNQDzMMDi2T8pnVTedHMS/qvE1jUoG9sGLVgoKTN/vyY2NsAsKv09i
         1KjiW3koaNPYRfbAVxLFdlBUldSETQsGlzzSnuQCEIPuCRmsz0AF4sRJblXbKGIIOtGs
         6RswPw5gzkItdHjVtkG0WeOBxi1M7OBG0Mcs9gloqZxDzmQRSHn4ZdgWAXH61v5GCknf
         w9jUtgCe2S5ywhXwpv1qMbW/Wgjq8mu3+7q4jHoixoVYwekRCOVxRDz+2aWNOPmlBg7h
         KuOw==
X-Forwarded-Encrypted: i=1; AFNElJ+RMA4Ea58he/Vx6eVHVvzO5LSwwDEv6aK1B4wg1JkAtt5xaGZks/UOYVnRclTk1GClG0IRrCX8gU2vvQ8tyR+b@vger.kernel.org
X-Gm-Message-State: AOJu0YyLxQZUICzkwqxu7zuMzZ5AvbjFSaPvXpBGmVwIU0niULiBcQGN
	bKK7mzJ8dhOMSUq97dUHV2SWDtcx0F3DmlqxfKozxVBjBTzfNWEJr4Jl5yaYn3f/CepLsdacWPl
	GvE7dlDy7lA==
X-Received: from dybor13.prod.google.com ([2002:a05:7301:1f0d:b0:2d8:4599:1d20])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:324b:b0:2ea:ed3d:94f3
 with SMTP id 5a478bee46e88-2eaed3d9892mr1908241eec.1.1777139407386; Sat, 25
 Apr 2026 10:50:07 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:31 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-34-irogers@google.com>
Subject: [PATCH v6 33/59] perf check-perf-trace: Port check-perf-trace to use
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

