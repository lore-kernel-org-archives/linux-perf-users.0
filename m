Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A911838F954
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777156941; cv=none; b=OxgK2ZZlUTuU7oH2i/qOFj+7VfNFpREk3NIrnOkqxMQPayUO0zRu+BLIJAMgpAjKViIbcWAK+Jpb2oSNYRP/lNSUgTIrLob1aKalj0J1qS5kQN8NznuuUAjCtn/i1eYUJaN47J5Kpq+vXe2MiNOXqZmv/QanxgV0/7Ad6WRVrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777156941; c=relaxed/simple;
	bh=zDAi6+BP11nSSIhghkCbe/DAtdl7FJlUT7QQCt3+JnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HisrJHZnf3yrUnI0syDRo7ACSzfEMQb16l25uZy8sOCTl5qzoTG/IeUzmrIUuvRBoStptSyhPg9q7HKHW8Qx3ZuQ9SkaheHf0CUwX2+vwK3QNlQ/6Re9Rb1ZIUzWXNrEOo/GSXRZ7LeuUpKsf2dj6Pwd0Q1QZO0pwuObdUCEl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZjgbqMXF; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZjgbqMXF"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b81ff82e3cso5615992eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777156939; x=1777761739; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=ZjgbqMXFS/duEPovwYWOcKpJJFG5rlfUziwieDbAmAkU2vJXvEfwufnfKMmKglqUPS
         ONP3QmXad01Pd2IPlMR44IvUcAJqIsfLkY8p8RoxWLrlKr0rWl47FrADUrD2Tzh3mmyu
         IkpGtGt5C9OmPzMT+unApB2UPhaOk2OGwSXSvEatdgCW3jGfJPa73F2mOCtpau7Sn/aQ
         bHhfV6/HFjzogVCdcTAYuofOiPkQVqpetA7csjpRwcbagVyJB4oIU508Fe1z/PLkaCFm
         I3n/AYHGqYyyju8BPYen1tqDld5NNPP32RsaPE3eoYsLBxM8/LsgGwf0OX6R1NwVd1yy
         OIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777156939; x=1777761739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2j+/G/gLHQ7NZrTXlwU5UyQ2EY4+32u+JcYzqEO/fuc=;
        b=gVMR7DTFtHprh2B9jeS/2YE6LVClkwXjZXT8nq5JwWmmSC6yW4WhmrRl5NPqjNhoJZ
         HZqLIHrQC1DbsKEEH9d5VYJiJ7NHIqF1uqQzlJ4d1Xuro5IZ8z9gFrHlm75ZwROkQcWm
         IXisXqnbmBtxmXHRxNwBgq0Hqv3UGFOjRWcIfAc+ZbnujgiaqcreOQe3p4Ol3BnrSbWH
         8+2FJ2eD+dN6/oOU/AMra7vHul4NgylV0zWLla/Djw/RXw6Oan6NDIkX3laRz6I13UZ1
         qp75u5HI8BS70ME3SKGTJ010cdVz3w/kDZPVEOhmI44D1sHUNrzWS7qYvBxqs3Bv/nEs
         8ZUA==
X-Forwarded-Encrypted: i=1; AFNElJ80xkuAJNSP5i8v0P2nzk1AdN072uYv9Po4U5v6GIwjZ+hiKo+SRSgHUW6bSG7Ezz4Wsd2l191kANQEhL/lhKk3@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjiWq3ATizT96pmsmFkWblm386UAqknd76icmEtHI0xEgxC/a
	Rs3zaVAuPa8H+o7mSjXiKn2KPLJeOiQsAI/LFLRpL6maG3+5TRIPg9792jx/Kw6603LsQopaaV5
	gGrNvSZN6VQ==
X-Received: from dlee7.prod.google.com ([2002:a05:7022:6287:b0:12c:1fa5:ab7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6289:b0:12c:6ec9:3f1
 with SMTP id a92af1059eb24-12c73b4b076mr15847534c88.21.1777156938655; Sat, 25
 Apr 2026 15:42:18 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:40:48 -0700
In-Reply-To: <20260425224125.160890-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224125.160890-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224125.160890-24-irogers@google.com>
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

