Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9065426EB3
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542257; cv=none; b=hGptS/VRC68KcBKmqG1OcuWTVRHH/fbYgJaqHBovx0+t3VrZxpGeg08t1yfelrXDlqUGVqgfc/RyIC0rtkK80vuaTt3wkSn6lm8+XMpajm3Q00jaYG2G3+RY+ad+XfBPx4SF+7ZQx3ZflLl7prLLhT5iI3bYG4/N7y1ZT31OHpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542257; c=relaxed/simple;
	bh=USHa9Za9v3JvVyp8hT1Fn6p/kwcudz73UgjkmHHqV3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZGZtMsQtRHRbqd5hpDu2jNDZb6r8XLQ/2HWSrbeRES5dV/hhJZnS1tbroYL+uoe60EON2yAKwTf7RatLiX7DVEtLlHBMTrymrdBDbJRE5nWbPUfb6hLhmNoJxXURuA+HI1evCcbbraEHUNypT/yPsP4JVKEM1V2lm4Xcx2lBkbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a2fCEoHJ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a2fCEoHJ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-3075fa5a407so6419764eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542255; x=1782147055; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vyyNdhBg09PfHKWAasLSBP18KQPTWQY9AF1LP/3RnBE=;
        b=a2fCEoHJftjGkLtYmrB/ekRZ5vhqcpFYe7tqZfejrkhdk+6WZn4Ciom6r9JqzLBgWv
         81jufvdl6xl6xc+/IkQOslzBmyMoFb126nKPouWVLy6iG46BaWZMsDC76AZK3A+Z8qit
         k8xKzFKsHusucIoxcbRywqcGxBkz0uuQjeHbvx8C1B7kP1tgecRbsmeyxev0tkG8TOdW
         jjyLacLZmGgR0ehSzn8yJjITc9rjtQ63FTRDJzo5IdRkOH6bI9/iJeDUTS/SlkNyIGTo
         jUWSWngY75eebyNxABldh4A0C1pzRgC80rzBos+yY6q8Qt/mc0f5Lv5JMp7/qdCZvLyr
         zUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542255; x=1782147055;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyyNdhBg09PfHKWAasLSBP18KQPTWQY9AF1LP/3RnBE=;
        b=Jpm47nB6cVIKhBLIuxDnVR/BvAVYJWZoZvoTbGlTbHU6MKbpIpwBVx8SJstWHphwbb
         OB7mbP8tH+kTiHsBuiC+2S7pNqyj4DAPHRJAYFxsmU1QDjis8VEX0FePtGllStkFcTFo
         eMlGSIoaEvCM3SnzM9/XQR4kDsl9nyQEzWUBOoaR2G/xJBjyTC0cBgZc7l8BpFgYbAj6
         kfzynfc3R/56j6tqCorO2G947melPiAsTvIkX8ItywL36EnHuefFsEQ9892U3q8+Jzxi
         iHfVA+BsyheCPH6apNqoC3gJUmq7rtYIeXTebmPNOUWuS3rPuroGQtvjHWH2JTyG4Iz/
         Fl9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+UTMXikHXapwkor895k1MGTlt100cD0VPsXT6hA/cBwjQ3rcVFvufRa0NA0BlhfNhSkEzGXv9PvzvUiPIEqR6s@vger.kernel.org
X-Gm-Message-State: AOJu0YwAeBucOldto43hNGKGA/LJStnVhDlp/3is/b9armwnncC0TWAo
	vbN2TpE9VlvHRerVpTSoIiIOxtptJCd6lPfBOLLCsnQk6Tm3KcUEoQwYRSQy+koouTJIo3oNtid
	P22Z8qPu3cA==
X-Received: from dyem12.prod.google.com ([2002:a05:7300:818c:b0:2ed:d9c:cdae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:220b:b0:304:8364:e95f
 with SMTP id 5a478bee46e88-309402621b9mr6985883eec.27.1781542254331; Mon, 15
 Jun 2026 09:50:54 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:50:10 -0700
In-Reply-To: <20260615165010.2724690-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260615061631.2382079-1-irogers@google.com> <20260615165010.2724690-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260615165010.2724690-21-irogers@google.com>
Subject: [PATCH v19 20/20] perf python: Add LiveSession helper
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
 tools/perf/python/perf_live.py             | 59 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 13 +++++
 2 files changed, 72 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..616b5f657463
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,59 @@
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
+                            if "Unexpected header type" in str(e):
+                                # Ignore valid but unsupported event types
+                                continue
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

