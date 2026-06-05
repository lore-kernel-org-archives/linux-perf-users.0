Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B8148C404
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 07:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780645271; cv=none; b=UEmGkuHBS1Buc/5ioEV0AdESr8WL/UwPiNektXjoxPVYQ5dFZtGm+apSd743ilWn63yIl/g98TU8UF1mLc8kWwj1FO20oT9qFERmvIMxZDXotlguLzgHn8uxMKQQVwy/v3XWGdjDejTEJuJzQyvXKm6zKCD175DnYYqYVYVD2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780645271; c=relaxed/simple;
	bh=ez9coRnxY870iqBsZiKuZ23jkMvfckMLO0sQp3TEoT8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkvaPiDqFXaIgLq9k4czJiKIUwIcSCdWcbyMzjLA9J4FwgylRb3TF2py9t4m6NolL8tfIhhvVxdvZOURcRWWtX2CROYUmLr4Gx2RcSB6ye5Snd+U55Oes/4kxBUbwFLBJ1Vh81k7Hdq3Zy2iGSOPhXTKBZ09FUSFZuyNrCee4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FgyN0xSn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FgyN0xSn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-842308adb3bso2217691b3a.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Jun 2026 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780645270; x=1781250070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hTcZTiRvAdIJcgd4F1gs/En6XfpFYlgHkwQjbZmxKFo=;
        b=FgyN0xSn+zgjyCEyj6nabfeoWEBsbKuFRg0MhcgGu38rqUZPVEt9Rn0chCcFwvToY0
         tLoP8Xpg4fIuK2LV7c6cxcXCSj16t/XhLSsTF/f3Z9M/HgwKHrjyoE7tEKGFGMapaQyC
         zt3tJGMZgPcSEv7Zz9QI6MlvIBYgHaabMUlLqcAYhxuApMMTyAof1Og/KxpdTgSuCob8
         cSFQqcbXLwQlyNULZBwUe4QUgpiNOGWrkRwtSxBIGsz49WbUlvv9Sn3jCNnI7m7YKKjd
         zQx5U6idqC4eYTXmCjLwq57cTp/rMmiAuprPjE523Bh2g8ZqrOmk02yKbTxKYDHpUub2
         hSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780645270; x=1781250070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTcZTiRvAdIJcgd4F1gs/En6XfpFYlgHkwQjbZmxKFo=;
        b=H9iO62MgVIrIzlNWfucgqeUyUVD8M5uYBgD9aSo1SDfI1fbxqC2rM2ki2t1LCGy4u7
         yrBqDlsDGIbEU01I0vPdugaMZ2GB5TC4xqGzFWVgfNu9HvHsGiPqcg1m0Yg9KR+Piwv0
         llNwDN60uxspH5/wq3Cua/Ywu2/h/eLRwiN1SrHLYJt1YYY9PC2sIGW/8TB7KAylCNxn
         Dt9vGo+6MECs7adwaH3ug29ukgi/NKU0AOoW3lMKLXCpC0qjkci/pIHDzjDGUSz0HXQT
         w6nDqkGNZdOlCUCWDu9PGz/ngC7QSQDjvI6rRMWm+G0deqVdUgIs/kS00ZHsWzFWp0e4
         T0Gg==
X-Forwarded-Encrypted: i=1; AFNElJ8Vxbpxtra8ufjuE1zPz0A3C30J0TO786CHXD00ZYwAFzbFOjFABAowV9cwj3Er+dcbZoGFbUBQxTrazrjX3kIU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+Ms1wIoZbfO0eOyk1B0rlWNSVBL1Qm3SsLbQY4Xtz9HAAqyl
	22iIaCWGeh99Z/Stu59TVKyF7LkOyL6epUBfb+lgtTeviJvupNBEngY64BvCtfVWGMn4cMnGDEs
	VsxAD8EXLPA==
X-Received: from pfbki31.prod.google.com ([2002:a05:6a00:949f:b0:82f:7163:35c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:408d:b0:842:4612:55f6
 with SMTP id d2e1a72fcca58-842b0e96dbemr2283733b3a.21.1780645269408; Fri, 05
 Jun 2026 00:41:09 -0700 (PDT)
Date: Fri,  5 Jun 2026 00:40:03 -0700
In-Reply-To: <20260605074003.1730715-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522220435.2378363-1-irogers@google.com> <20260605074003.1730715-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605074003.1730715-20-irogers@google.com>
Subject: [PATCH v10 19/19] perf python: Add LiveSession helper
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
 tools/perf/python/perf_live.py             | 56 ++++++++++++++++++++++
 tools/perf/tests/shell/lib/setup_python.sh | 12 +++++
 2 files changed, 68 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..46522964cb79
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
+                            if event is None:
+                                break
+                            if event.type == perf.RECORD_SAMPLE:
+                                self.sample_callback(event)
+                        except OSError as e:
+                            # OS/mmap errors are unrecoverable and will cause busy-looping if ignored
+                            raise e
+                        except Exception as e:
+                            # Parsing or type errors are recoverable as the event was consumed
+                            import sys
+                            print(f"Error parsing event on CPU {cpu}: {e}", file=sys.stderr)
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

