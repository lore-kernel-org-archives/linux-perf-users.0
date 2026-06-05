Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94434EA385
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686976; cv=none; b=de8G4Pk49bqijynKRSeCNUfkDwh1ANmCiPBshLxt2PEdQXfsSFTAbvxYHmv1+fuAuuJVF6UfTo3swmJbmnKVVpN2Xt7fbIcS9Dyd8PM4LhjfjnGgtOfhL62h3pjMQo9fduhB3iJxJO8zAGRagAY3iKw/dNZySLj4e1BHQl/53xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686976; c=relaxed/simple;
	bh=IPh+nyUkYSRCWIGS0Fz1sDF9upp1szY+E7vo4qbe9Bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mz7XEYrle1WRJf9DKqpnE0is+cLnopRg51ZyKW0W0d0xiTMM4y13S/8nRjJiLSpTylk6XSvTJi0d6xdc+dKVo3+XPZutt8PMT7Pfd/bDbo7zHsoYr1fqwFoCeQCrkILBAsh5BYYbgjnHBoI2Ju3NgXaAY+ynaKj1xdkGVTQdIdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A5R9LZhC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5R9LZhC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-135916eefa0so5596915c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 12:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780686961; x=1781291761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWY32EDP6sbioAoYarFf13G0pdUMEK6C8OqjOpzfwMs=;
        b=A5R9LZhCfmWAj7XOAKhZwanX00OjwR85Y58yWQ0t6YYtuzXLCkW5CQQJJbenqP3ecB
         Z+c8WazOd3FH+y62Y1DrNYw2NsldAMcPWwyYD88LIjVmZ45ojQ5sM1P1adzKTs/R5PWr
         Do0x2e/hpFahmVTjhZMQ48wssTEVYct8OnXZ0que5umN0NY7te76/Xn6OC2rhiYNDcIw
         D82yZI/gw59PWLBgbSFRChYM1Y2KOWLctSnYuWpz6XtqAPLROscKdP1NJTxh1Voo9eds
         vg4Bou7708SaYhDnJi72wOy9Dvj4eyEp9BDZcqkbbES/RxUFvpIs1D6KfaViz1eKB3fv
         2f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780686961; x=1781291761;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWY32EDP6sbioAoYarFf13G0pdUMEK6C8OqjOpzfwMs=;
        b=gdiPp23wNLEW1/kh2Ky7Nk83qsWq0Ln6+849b6ob+iUSvsa/eaNB8VDfidShoCCSue
         mcs0qfuP7rN7oxgzDtOr0OQih2ZZRue2e+3VwktNVrChZk80s4S6EdvSj52szqtY9/JH
         iX0aMZDMiUptDcDd6MXJCKGzYYmu8EqH6y3de6XaAV/yFIdr8VOtfZE5qPUYCCWCKYmJ
         PrxelNvN/HcXticVK3ojokcUCIm9vTBF/0irB0lo/XFqJOOdR7NDvzQ2ZMTI6mtFcXIN
         F1ljwRZsN2ke8c+d66HsW/R0lA61BpVfovTKTpKqMEz1a5LcTjhDLnseNdPMAAzkVXPG
         tpbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VFiPmpDP7OwCu7fvOkfLAZeRgEqe/WQeyTm1TDzdbHZS80ke5hRxIfkNts7j2njJmG+TO1yIS9RlE4THIh1KS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb3mENJk7hEvb9jW/YjzTorbCdUCBsiUwN8c2tswLwwk2bAcaJ
	LYqJm8QqSC00rzlGpV82wcoCPz3EsQeJ1wAQKx3szjAtuXdBl7RCXaPzYT0MSk3IQEbDmuDqepg
	RqBXsD4cHnQ==
X-Received: from dlbrh9.prod.google.com ([2002:a05:7022:f309:b0:137:ee95:320c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:211:b0:136:602b:80ac
 with SMTP id a92af1059eb24-138067158e2mr2096920c88.27.1780686961113; Fri, 05
 Jun 2026 12:16:01 -0700 (PDT)
Date: Fri,  5 Jun 2026 12:15:00 -0700
In-Reply-To: <20260605191500.2477026-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605074003.1730715-1-irogers@google.com> <20260605191500.2477026-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605191500.2477026-20-irogers@google.com>
Subject: [PATCH v11 19/19] perf python: Add LiveSession helper
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
 tools/perf/python/perf_live.py             | 60 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 12 +++++
 2 files changed, 72 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..10fb974879ca
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,60 @@
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
+                            # CPU might be unmapped or offline
+                            break
+                        except OSError as e:
+                            # Ignore -EAGAIN on empty buffer
+                            if "err=-11" in str(e):
+                                break
+                            # OS/mmap errors are unrecoverable
+                            raise e
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
index a58e5536f2ed..86c523207c09 100644
--- a/tools/perf/tests/shell/lib/setup_python.sh
+++ b/tools/perf/tests/shell/lib/setup_python.sh
@@ -14,3 +14,15 @@ then
   echo Skipping test, python not detected please set environment variable PYTHON.
   exit 2
 fi
+
+# Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-wide perf.so
+if [ "x$PYTHONPATH" = "x" ]; then
+  # If PERF_EXEC_PATH is set (pointing to the build directory), prioritize it
+  if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
+    export PYTHONPATH="$PERF_EXEC_PATH/python"
+  elif [ -d "$(dirname "$0")/../../python" ]; then
+    export PYTHONPATH="$(dirname "$0")/../../python"
+  elif [ -d "$(dirname "$0")/../python" ]; then
+    export PYTHONPATH="$(dirname "$0")/../python"
+  fi
+fi
-- 
2.54.0.1032.g2f8565e1d1-goog

