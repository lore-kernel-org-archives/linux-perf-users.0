Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D356E38F92F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157463; cv=none; b=omnfCJ8efHSR+m5pb5m1cSfqEHOz83wzkqLHYGbfP51eLXfq5/M2408Dcn6kdnaxN6F4PyEUjZ8yCr9+kUgDfLyhw6PGf9SJNrxpdVe7nW285DB8OlMD3sDc9TOBHT9DilJQl7ljjb4YQASs4IOBF6ojzyLMfN8o1V6DyESogw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157463; c=relaxed/simple;
	bh=zDAi6+BP11nSSIhghkCbe/DAtdl7FJlUT7QQCt3+JnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erNgFp9C0C8C0siVHw4GTubMbMdprpEz+2YN6kzcsOASjQff8e8c7CmRFQzfQLd1OATWDBVgZjkY62pZSRklBD6kjMGQAy2EIibvH90ChSXkgai640/OFSzlCN4sikq30QKa8bKsLtOeFfYDaOpGvvOfyKThvzSCHWzgm8wYxmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=km+srlJ2; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="km+srlJ2"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ba9a744f7dso11750347eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157461; x=1777762261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=km+srlJ2cu6I2Yj1/8/10M2ceZH/B2h24yvA64rSIniyumuaXITFiyTBy2O2Br34PY
         PoUNJOo7UJr3yMya4axU++YZ5wfDgKGIro8RJpjf3UKa+z9ZNQXv+Jat0I6ZbS49737R
         kRbnDv68MElkOS0xJcil6HpJ+esxMHP8+Q52jPejjCi2DEeJSLt6IFgl3Gvs1O/aeOS5
         7B0BFMKSUxT0diw5OvJXfFRICyZWJYETggSzofFVY50gwXKcLSF7s0W1bW5qZjJZmjjw
         emfuLdtKCgqKm6xz6FN6eGDbHjn0eTVqdRAhdT+8z4iqcKtEGmYosnp51DTGOrQuRKr4
         P7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157461; x=1777762261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=LS9eJj9oNV9iQHI4BrgEsSJ1Kdx7v0D8MXEtaTjjBdloyl1+qunnSyDD9Z6Xrt/GKT
         rKgEm9PpeFbJxVz9KsZ4IQ8xFaWSGloiY9896LnP92bgW7Ra/9kPwlYBBEmT2ZLUrpjm
         oca8BZ6HUM7m0q98qMjDm0OWknZVXI4zmEepGB23oiyPaFSWk0arW5fZxH4YW1h59Xch
         ZaDoZpT4hQ0BBGos/+Ai91EMMZlZOo4mi5SdLy8T27zKw/hcpKhplkMHd8wPSgTCLQ2s
         G7BzCE4Uqe3j3EPVIjXqwLp7DKcs+GHD4T1O9BpxTW4mtoZNWjk3u07iKYqmghHJxSso
         AmZA==
X-Forwarded-Encrypted: i=1; AFNElJ/UgxWX+0lreULF7PTEZCUL8w/DWJ4EaHwG5mIZ55ZVQYwcIgtdtxBX5Gu3bLMkvnyEdk34F3kjwArsCDVhiOkj@vger.kernel.org
X-Gm-Message-State: AOJu0YyW+yUepFqDZibKAWdaqjKQu78f3m+doqbM1aRxNG4vRGQGF5T9
	NGwH+as4b4uvIiIsn8/ILh0jL9tGEMYSHQVw/cKiGHohu2PfVHqbiso4IqTvpZtMogje3mfQZN1
	9XPnlu5q4OQ==
X-Received: from dybnj5.prod.google.com ([2002:a05:7300:d085:b0:2dd:4573:2897])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:1f01:b0:2c7:5a7b:e8c0
 with SMTP id 5a478bee46e88-2e4657714d1mr19141205eec.12.1777157460756; Sat, 25
 Apr 2026 15:51:00 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:15 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-24-irogers@google.com>
Subject: [PATCH v7 23/59] perf python: Add LiveSession helper
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

