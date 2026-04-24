Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5553ACF0F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049317; cv=none; b=VQ7Ky/t3Su2pf4RfZdTw3O5+VXl6mOwXbubkCXz9HuzRK3M/ror5Tw8SzJtPi/lQR1iwHBF+e9e4fMX8p05xsnZ6Ul7uqoq3fiRMe7ZSjg0t7Vhhmg6SCwAdPy5Mab0qUz1/FLCZqPV803MJGlWjApZOrnFNnxp9qwuAxhCrCNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049317; c=relaxed/simple;
	bh=zDAi6+BP11nSSIhghkCbe/DAtdl7FJlUT7QQCt3+JnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GCXmnlFbS/7u4DM9ZFy7Nh0lqyGHHiEew8J48y4ywsHFZpIPQjzn6LnQeFISta+e6QnZHJsKCYOeU1Vfb4VQdPvlVSFrSKO+7AQ22kftZlrsp7Y2bHUTgWg+SsyUQHjzkMXFXsiZhudmS7eUPj38gCrMBf6jIjgFPPzP745xlH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrgC9Cra; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrgC9Cra"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b2ead99f5dso101230735ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 09:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777049315; x=1777654115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=XrgC9CraMQNOxxkhfCnYqnUBOxZUxurJ+v/M1yUTD3Ym+VwdMFGewYFYD2VHBwo7wk
         YF9+TCbB8NFXgu1f03d0An4gKX7jfAFXJIqfZzVk1QpwK1wVwSesKfXSfuhjMq2iICNf
         ziPjQzY1q/kWbx6ExOPoXl9WR3MMLonAn0ggZCkDTsN0OsmGoS8BTeRtmp6/5Ebk18Y3
         Cnkhb+iT14MoohqS6JChFZkwyp7XdpE0/abc2c1PHlwZdjr0k5NMLu6O9FXbcjEIKwt0
         8pRhC9bLkeuQ91AXr7lsDBB8+zY3aCRxYJR0hOO1cYI0U06TtaagBedg0dAoU+2LMiJ5
         /8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777049315; x=1777654115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=Wmz/+QvEsgJL8kOreqRP/z05xErL4nWNOb0DsxF85WeoEoMEb6cd5gcoiJ7eTQo2Kz
         sUb+SSkmXPp0bmpWH1ZmM+qqD3bD2Ouy+VGJ9kfvh1LTQDsWbKSk5PwTo3EMV/5UMzwl
         +b490yMNZcCHj9rGRi8kyTa4p92XpjxlpnE4Sadv5p6SmFrN7CTCq3XsOlQTVab0lGAh
         IrzAf7u+fvR3UsQpweu/yspjeaYzbsBqcfe7MjbVQ0DqSIMekAxAChqUX4B7EqM2Af4S
         hesWSvyh8QoVqoEePm4Qd7PMG3xtZUh4iUvlhGvJOl+Hvu0DmwslUrJbQgXbNO52b4Lg
         XXXg==
X-Forwarded-Encrypted: i=1; AFNElJ+B6KBk3elfabYwUE4l5QIss8E/t99oua2ZRTl3iVbmwl/26ymDiVMm9HylBv+CWhhKV9c5wx+dBXbru9adxhEY@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrtJVVp33aA9XDGVugb19bOI/GJAIJkhVqracxWCjT/u9xLIN
	+TJh53N8kMnncxBQeGco/Gsg8jOBJ2S5SE15qpKlmi6WNnNZkMyWz9JLPeqVa1nJHNDGpN5s+n5
	Fq5QrvHgsjQ==
X-Received: from plsu12.prod.google.com ([2002:a17:902:bf4c:b0:2b0:5ad5:b5af])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:37c4:b0:2b7:abc0:3bd7
 with SMTP id d9443c01a7336-2b7abc0448fmr82802385ad.9.1777049314589; Fri, 24
 Apr 2026 09:48:34 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:46:45 -0700
In-Reply-To: <20260424164721.2229025-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423163406.1779809-1-irogers@google.com> <20260424164721.2229025-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260424164721.2229025-24-irogers@google.com>
Subject: [PATCH v5 23/58] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
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
---
 tools/perf/python/perf_live.py | 48 ++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..d1dcbab1150b
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,48 @@
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
+        self.evlist.open()
+        try:
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
+                    try:
+                        event = self.evlist.read_on_cpu(cpu)
+                        if event and event.type == perf.RECORD_SAMPLE:
+                            self.sample_callback(event)
+                    except Exception:
+                        pass
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
-- 
2.54.0.545.g6539524ca2-goog

