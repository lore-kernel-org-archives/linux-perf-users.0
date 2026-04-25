Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143B54774
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139390; cv=none; b=F6TtOwfz7oSapq6K6NMiC6VOuOkz1oeEnqdGitWOPkT7A1h91fl28YnrklhE0g/o2hobgZvYt3ACCGuXKCDzs0E8T3zQWcZspJb/DnjyCJlJrgNxkDi1dlRsGsn9EeQyezTOW7xuUThg62n34uwsw3tZZ/RjCaNcghDWwPkblAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139390; c=relaxed/simple;
	bh=zDAi6+BP11nSSIhghkCbe/DAtdl7FJlUT7QQCt3+JnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MmtDC8PLo/6ivzzVGSnjouqd9H1Q94UfIgdM7ZBD2NNaux0jgGE/NdldNh2me12BvcsjVkGaY5OxF3+OJH32zQh7DS5+kr4ch0ktTo8dA45NhDQ1IbhoF2R+6W+b0xzC8GRnLRNEWA6gn3zoJE44uy5TQAHqZKNpp05/rzBe+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUrScJun; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUrScJun"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2d93379001eso19589136eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 10:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777139387; x=1777744187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=hUrScJungJfmPvps3p6V+LPZAT/4u0N79uuZwzRkjvTZ4Lo/hHV0z2OUmamU79gAQ6
         o00/Lxl0LKIZerocjW13IT4qXwwl4hSAFEYM6fXlNcDHYvKkLVa9jMrsgPsntliR3b2p
         yWDkfTHsAWOFbm3R2t/9HMTe+/lEO/Rg0D1MvVLJ88YIe/O4mSg7u47PDX/+HH3gxjYB
         TMdwfT+V346jP8rNvgTG288orRh7FZ8JDkcFXphBGgcBNAmKO0fYP42gOvb9Mg0qCe2Y
         nT6Dhx0B4K3t6UJk1A4Qt31JM4TIFM3G6HT/u0HfwiLt/AH/WXiSmb7NtcJkvInLyoP6
         LHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777139387; x=1777744187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=Iv3QWRGt1qVuuiJd+OVhZhcwvV/JddRBEmbTD30byyUstcv5b4T0qi4uNNkfExjVgj
         g3gTn1Likwe8/C9rHAWy76eLK4U5liPhUVW2sIhKnb8u5J5HL78kliiFnb6Ju0fuwTjz
         fTN5gFRG2d84GquZE1jY8OGhgbi4yICzXcgxwZTMtmcS/ihQDrHLRriB45pO1rCMowbo
         +S6MtHQDD9zhuFrcQBJH0xA+V7c/nLcJq+sjQoEUul4/TTVrV2pYF6Ulpes57ZK2EBVR
         FWCk5Ow8rKjPHNj4gmzg/MfZfXTRG4R3NXhIiA7U4uc/QWlLRjL1oNXvxzxv56Sd/QF1
         DetA==
X-Forwarded-Encrypted: i=1; AFNElJ+eswWQoi+5FlN1lGO0fof1ZolVFkmJq6wNMCRzEJVgn4jFxRuq18xuQio1FlTq3nC2I4XVS6R3+L75wmiG73Rw@vger.kernel.org
X-Gm-Message-State: AOJu0YwtaYE0yASGRzfAg/4xg0e5PL5MKlc+4Q8I3jOvVER74lbdOj9t
	O9Ue5/d0fjZFyrDhAEWEfBHIPQ4i2//MNk+mATlsXxWozysykBTaPZR7KsAq+NOfYpHncJ7FX6c
	QiD2uGkyeog==
X-Received: from dybb21.prod.google.com ([2002:a05:693c:6095:b0:2d9:61d4:4d0e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fd16:b0:2e7:af57:3b72
 with SMTP id 5a478bee46e88-2e7af57404cmr11412940eec.29.1777139386471; Sat, 25
 Apr 2026 10:49:46 -0700 (PDT)
Date: Sat, 25 Apr 2026 10:48:21 -0700
In-Reply-To: <20260425174858.3922152-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260424164721.2229025-1-irogers@google.com> <20260425174858.3922152-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425174858.3922152-24-irogers@google.com>
Subject: [PATCH v6 23/59] perf python: Add LiveSession helper
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

