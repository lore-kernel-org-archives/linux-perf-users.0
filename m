Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944F3DBD51
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360806; cv=none; b=KILWHn6E9Z2mV11bmUJ6gfTdJOTsVongJh8Xe7SybEoGEqk29+7nHkoD6lTBjLCOWIio67Dq6c5Tp1yb2yiR4VljneTV44ML4dSiE4PYQnivA6xJCoZkowF4geWQngCG4aY7ZDKLRv8YeHGJRGqAbP9XvcgoYDQhzX2EWy6vMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360806; c=relaxed/simple;
	bh=CBY6OpNHusTWgOchJ7fbiGCYkujHueyL3gHDA9o8PSM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kSAf+GMAjhl68k3+WjafKxtiE6/I4a9rb3k6lmrR+8P+/zQLGlqTZtvTJKvLl369rQTbiGKRKvoGffoFtCwzrOpFhWb4fnyZHYR97JkzFaw4MRifw5HVPCIcTKSHEXQ2o9UTc4Qr16d3tFavDJmhW2O0pknXUaquHkcIk+kuvQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PH/WtpVx; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PH/WtpVx"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c66fdd4aeso16632947c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777360804; x=1777965604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M8WtGEmeyg2yDzdn++CmlJWRHF3Nic6slUsof+bTFao=;
        b=PH/WtpVxnFceD7/eVnOZCP4w1GeCp6g2/BwjMinXNRqojWQZI/J78JwRHyiqe3+umx
         3Af6eHIhTbPOb7hhBYmmHnnyvPlF9f4pavgP/QQ6M5PI07HpowSOOGcEKoBjgsLO1QTB
         qj5cgR/4kgQx5JO4OP5XT2RF1Q9g7RiBcW2Gy01i5uXPMhapVXumjzdyHACvR63h/y3A
         zLihUe0L+xECmRkRLC392/MiGGKLatulIp1Sc6H92lthkiBo+H0pkoJoC6xChj95b7Qc
         XCz+qV5cYIlTicDHkjYpYaiTKHg7XVxlEoCWBZH3leuHYNQUpZK4lEPY7J7xaDisymM+
         bGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360804; x=1777965604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M8WtGEmeyg2yDzdn++CmlJWRHF3Nic6slUsof+bTFao=;
        b=XB+GnIr9RS16iYDhtaQOwzyKicQNOLxxrW8ixM3cZKGPZtu2sGDKzgtJo7BPN+M8Ds
         qQqr58vbikaVjrLQu5VjjyV31xmYKNW3aWOMwJPNUN0UNifa2idL1hdCjDaH9UeYntd+
         GfmYLq1Cs2X+yqQ8uPel0h9cFClO4VW1p30g67OuqtpWK0QIJ+nbWHiEY2Ia6jdfQDJE
         IU28dBghRRZiK/GwmoAKHor/mJLvj2ElDL83QIZFI01sDJ1PKAnSn4er1TBUIaOwVDK4
         YaTX7kEb7UYyxX1RStrbw9Rd38831I2jomTRf9uVRa+oodNpvJEU/CdWQzoljiPT4h/2
         qojw==
X-Forwarded-Encrypted: i=1; AFNElJ+Q7ht/Mco6ymKzwSlrqLLysb/LOA/9vLaMZL1AfN5UXbW1Ncimg7fkjAsTkQf/sO6TXb737n36AoLuhfaLdp2d@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlnm+rUwseOac+pNK/1P4rlslKe9o004hRtnyn/MGQ/ZZFCz8
	3m4S/nJ4fn50QQ0TKoRHVw6pSMNgpiGdZNiIXc9VaJy3fpUfVYfzqDNDD/gtWonu6Xof4mJZ5M1
	aDMRQJuhA1A==
X-Received: from dybfe3.prod.google.com ([2002:a05:7300:bf83:b0:2e6:1dc6:691e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6725:b0:128:bae0:e043
 with SMTP id a92af1059eb24-12ddd9ee91dmr807802c88.31.1777360803997; Tue, 28
 Apr 2026 00:20:03 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:18:28 -0700
In-Reply-To: <20260428071903.1886173-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425224951.174663-1-irogers@google.com> <20260428071903.1886173-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428071903.1886173-24-irogers@google.com>
Subject: [PATCH v8 23/58] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
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
 tools/perf/python/perf_live.py | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..d7f4269299a7
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,52 @@
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
+                    while True:
+                        try:
+                            event = self.evlist.read_on_cpu(cpu)
+                            if event is None:
+                                break
+                            if event.type == perf.RECORD_SAMPLE:
+                                self.sample_callback(event)
+                        except Exception as e:
+                            import sys
+                            print(f"Error processing event on CPU {cpu}: {e}", file=sys.stderr)
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
-- 
2.54.0.545.g6539524ca2-goog

