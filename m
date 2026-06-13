Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D3D7D89
	for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334713; cv=none; b=Tz7re8njo1vloib8l9/0VYMCeEtUsmzuUYbSUZhxi2Xw6r3q0cB5queREEgU5VqiGGGFtqQylgkig3TrEXhzwWieZI6qU2AJMG5/dvWxrYrecelkB64vHQZJD2og4LTpXhBtGJiFpw67yf0KE8yKvNx6rfj6wuZDmuhvwEd+yL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334713; c=relaxed/simple;
	bh=vF7NLaECrxjS2Yht2QwBVcJ+oGiwgEaeXCO/Ja+f+tY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lj+5JsbW7UdYJWU3Byi3oYCvjg00ErHOv2mBUn3rzkc/I/c9pO/DkRR+r8vG83zIxzTZw9cOm/wo/VCiEaFfQB1egkBWU/llZhEVdbakXXOWF/nM8xlGWe1W0Iy/JlhjOCv1OKDbekVBxPViQFLKTwaoDdTyO9eBg6XoD/Fzpqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqgsKhzf; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqgsKhzf"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304f23c55b2so2351247eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 13 Jun 2026 00:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781334704; x=1781939504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NMJlLHuQrPjDG4u+udKznGqwYSNrkRwjUgIYMLwqeOQ=;
        b=NqgsKhzfhRBZMdXQbqtok5A6woUh/tXj0tsu06XOLuEr1FtMfokEfrxUCwWQGwDNcK
         93JdCVIaOmp7RqnwLrupgeOp1xOU6qHCk5yEE7kwK2+H6grhjkWT6nm97Vf2Cz/OX3Fy
         dgw0BLJHbpU9vyv8/ax2sAQ38bGJaikWccOOa+avdpnagvg1GqlAVRhum2C47Dp+tv5N
         sfap6gi15igII6Ocy55MNK5+Q/WZ3bjo0aKfhu0rQVpNwqZkkBDS6li1gkrDr3Sd9Y6F
         I/5ICHaz2HDfkmgkmOEaFING/zjTO14hzs0SGMtPLS/4JBEttbKqA8BrRypv7AxjZk/J
         1Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781334704; x=1781939504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMJlLHuQrPjDG4u+udKznGqwYSNrkRwjUgIYMLwqeOQ=;
        b=UQBHJB9nRYuFZVPSZBfJPaCX4WHLxW5L0f5O15hxUClqTqfO03Y1roOW4be+qs2wxw
         G3Kw6ey4YfmSl0KPFGkEIVfrZtZx7UbCFYZK1LZBZKrdPxsHmjT/GQxWU+pwBjLP9+jt
         zl/+PaFtdo0rZljCK1SAmqFnkN9b7z2jLWaXITdOQQtaIKIa5ft+Ykd5zLXJv0PBzQUk
         MPUQfKA7sAUEMq/npnwBlaIuFkTml0Zi7QuslsxCXn4d6eB5Vm/dux9uolHYT8Se1IXf
         BwRzGgQL4LcwyJCWGAlASd4l0bQODJGqTBDb/bn2s6bZ5DfCZY479fyW9WBcu4UFvhQM
         fX4g==
X-Forwarded-Encrypted: i=1; AFNElJ8krMpFtCN2D5pGU7eOw9r4Gf9wxr8PP63Fs879XX0i5XWqMPhZVN/95ixtl/IueDR73N03AsgDHXc8eCimoUu+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq4clFaYfmQEskGNWrqeOtQG7LpnRwfv2iute4uAnpm/S6ig5j
	BjUl0cVseS0JmBAKa0q40P/leJ4oxVm84hf6HlPd9Pzard3E2o9yFBpgkkmqFtqXU4taDI3Cwas
	WAg2MgHKOEg==
X-Received: from dybod34.prod.google.com ([2002:a05:7301:3fa2:b0:2f1:5dbf:fd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1f18:b0:2de:2f38:a7cb
 with SMTP id 5a478bee46e88-3082004a0bfmr2782323eec.18.1781334703718; Sat, 13
 Jun 2026 00:11:43 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:11:00 -0700
In-Reply-To: <20260613071100.1508192-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613052722.1424093-1-irogers@google.com> <20260613071100.1508192-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613071100.1508192-21-irogers@google.com>
Subject: [PATCH v17 20/20] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
v12:
 - Fixed `setup_python.sh` `PYTHONPATH` prepend logic to cleanly append to existing paths.

v2:

1. Fixed File Descriptor Leak: I moved self.evlist.mmap() inside the
   try block so that if it raises an exception, the finally block will
   still be executed and call self.evlist.close() , preventing file
   descriptor leaks.

2. Handled InterruptedError in poll() : I wrapped the poll() call in a
   try-except block to catch InterruptedError and continue the
   loop. This prevents the live session from crashing on non-fatal
   signals like SIGWINCH .

3. Added evlist.config() : I added a call to self.evlist.config() in
   the constructor after parse_events() . This applies the default
   record options to the events, enabling sampling and setting up
   PERF_SAMPLE_* fields so that the kernel will actually generate
   PERF_RECORD_SAMPLE events.

4. Enable the evlist and be robust to exceptions from reading unsupported
   events like mmap2.

v8:
- Drain all events from a CPU before moving to the next.
---
 tools/perf/python/perf_live.py             | 54 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 ++++++
 2 files changed, 67 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..0052031b18d9
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Live event session helper using perf.evlist.
+
+This module provides a LiveSession class that allows running a callback
+for each event collected live from the system, similar to perf.session
+but without requiring a perf.data file.
+"""
+
+import perf
+
+
+class LiveSession:
+    """Represents a live event collection session."""
+
+    def __init__(self, event_string: str, sample_callback):
+        self.event_string = event_string
+        self.sample_callback = sample_callback
+        # Create a cpu map for all online CPUs
+        self.cpus = perf.cpu_map()
+        # Parse events and set maps
+        self.evlist = perf.parse_events(self.event_string, self.cpus)
+        self.evlist.config()
+
+    def run(self):
+        """Run the live session."""
+        try:
+            self.evlist.open()
+            self.evlist.mmap()
+            self.evlist.enable()
+
+            while True:
+                # Poll for events with 100ms timeout
+                try:
+                    self.evlist.poll(100)
+                except InterruptedError:
+                    continue
+                for cpu in self.cpus:
+                    for _ in range(1000): # Limit to 1000 events per CPU per poll to prevent starvation
+                        try:
+                            event = self.evlist.read_on_cpu(cpu)
+                        except TypeError:
+                            # CPU might be unmapped or offline, wait for mmap event
+                            break
+
+                        if event is None:
+                            break
+
+                        if event.type == perf.RECORD_SAMPLE:
+                            self.sample_callback(event)
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
index a58e5536f2ed..2173215a0517 100644
--- a/tools/perf/tests/shell/lib/setup_python.sh
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -14,3 +14,16 @@ then
   echo Skipping test, python not detected please set environment variable PYTHON.
   exit 2
 fi
+
+# Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-wide perf.so
+if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
+  PYTHONPATH_DIR="$PERF_EXEC_PATH/python"
+elif [ -d "$(dirname "$0")/../../python" ]; then
+  PYTHONPATH_DIR="$(dirname "$0")/../../python"
+elif [ -d "$(dirname "$0")/../python" ]; then
+  PYTHONPATH_DIR="$(dirname "$0")/../python"
+fi
+
+if [ -n "$PYTHONPATH_DIR" ]; then
+  export PYTHONPATH="$PYTHONPATH_DIR${PYTHONPATH:+:$PYTHONPATH}"
+fi
-- 
2.54.0.1136.gdb2ca164c4-goog

