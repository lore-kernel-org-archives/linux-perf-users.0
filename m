Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BF242D6C
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483339; cv=none; b=nLKC89+V3Myc0wOne/wYlwlVBE/qhP9fWYDfpgdpXAPeS7iSyJscoWOLPyXT1Csc7yaS46uIscGHzYlyERzRE8wiN3PTsudFXO0g4cyGPg9PrwxKAPG4u8U98jgbB69G5+ySh1Cbohcs1xscDKbcwIK9leYH+ASauhRQp7X5neI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483339; c=relaxed/simple;
	bh=d+Pwqr+eVfJzMjEMXmRbFLKidGb+T+8L/d4KH2E989c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CK2pBJoHIus4buask0glKB1/AtrVBb9rRn3CV+tWd/BGCQDWafUfN0IMMy4r5GUKKKNs+j0Q/l1LfzsKqkviT7/fHDVKukxtIqHI7SmESg7J447xN5Bg+EOA/I3oNTPj5OfqccZuVL978TP7jD/w8lMhK7sIViz2ZzcdnCxytCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4TuYeCJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4TuYeCJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-308004a2c49so269792eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Jun 2026 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781483337; x=1782088137; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QsaAGO0CANbVgxJ0+G4hb+OdpdaNt1BKjVTktjPq3Ow=;
        b=X4TuYeCJ3CVP7S4xa9V/x5CXovPGkre/d3sa0k7gudJp5RQP07YV9y/IkiIesa/rR2
         hYgQRrMrzqPz2CwZR46omadDhBcQEKEVx3JeHANt6G+s2CBU6Im0GTsGMMhJn7Miaq86
         3oIpUlqacEZqek98Ws4OivBkRDgNHdjM19OOjNTrolMxDFnzeOIC2aQehHcEIDjM4sjE
         mTW5OxBOw0XIkSXfjVhWnmokFZxWU8zPGzss+XaUuvaO2rB1DOPbIMw2Kt7L3G/K2uyV
         zPdzbcC1GvEYhka9pOA+Ygh/7kuOHrvCn7x5Z5RClMa5bVgrYGG8iI1PqiLitKAhet/Q
         pFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781483337; x=1782088137;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsaAGO0CANbVgxJ0+G4hb+OdpdaNt1BKjVTktjPq3Ow=;
        b=L0/VgfnIA41b1n5YVmut21cCRApb3sZXouk/zanw57jcJkAW0J7XPgDYd2TXYhXvSS
         adF66Up09uEgWcBncGPYHxQhpyniGIDyycleRMxl7e8Jyh5QCdoshRV0cNb+LLJxyTRY
         YH1usibbVvl399MjeeHhYo2FUc5eOXO7aqRyoIfwXN1be7+hKljERyLCSJ0S/wgJoiUW
         FSgFK53Z2j6NOcW3RognPS5RQ30XvrQodjN/WT5kvcl2WJbUZvT51JLWZFqG+wni0JQa
         PwMwuNmUzPrKFs/BCRIFXCvcgnJUygZ3/pWrc8fzzDEa6bboCWdCqVby9PICwAuPsCRr
         36aw==
X-Forwarded-Encrypted: i=1; AFNElJ9SkV0FN+tbUscOiSOXn+x19dLVPLaUcPk0H6DUlUjWOFoUc2C9y1YtUJ5H6LZuCTVtqUjQS004Q6KL+QFw/P95@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKN1q5D0xqZYPx8OqcoY/vMMH1Azuyz5IdboEGuYfX+goar/w
	hdgd3FTIUzE35Vp7H8LWmbjBOUp4T5fKt806xUXtuGMdLv6kLcGDwJXk/U3xBW44JBTly+5uJmZ
	2KnkFkxom5w==
X-Received: from dlbti13.prod.google.com ([2002:a05:7022:1b0d:b0:135:9081:542c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:62c1:b0:2df:919f:ce59
 with SMTP id 5a478bee46e88-3082006b7b8mr4237755eec.19.1781483336897; Sun, 14
 Jun 2026 17:28:56 -0700 (PDT)
Date: Sun, 14 Jun 2026 17:28:12 -0700
In-Reply-To: <20260615002812.2234795-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613071100.1508192-1-irogers@google.com> <20260615002812.2234795-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615002812.2234795-21-irogers@google.com>
Subject: [PATCH v18 20/20] perf python: Add LiveSession helper
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
 tools/perf/python/perf_live.py             | 56 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 +++++
 2 files changed, 69 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..544402952f06
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,56 @@
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
+                        except TypeError as e:
+                            if "Unknown CPU" in str(e):
+                                # CPU might be unmapped or offline, wait for mmap event
+                                break
+                            raise
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

