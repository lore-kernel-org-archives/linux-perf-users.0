Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919539DBDD
	for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 22:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487535; cv=none; b=kZq19zs+ti6vblZXByY4frlLVobsMIdjDOVMonket0JoafjQjiwUnuJIIDRTWg5Qvlglmxm7JU3xzUwGud27I5M5braqapJvdmy5qK9a5rwl1WIi8GooZ3vwZ+AxHZTC8bfYEnTf9IvDANNJu/74weBvEkedAuZFeqe57P/H+aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487535; c=relaxed/simple;
	bh=GvT1eHGJnoFxKyjkoZM6IMo3RDaILeI8qNW/+RifZpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VO5kad9As6Ee7s0wF6ZACzJbRoymvtZT4DVH1CwzHElbGJ+2WAp7wgmwpvHF/sDmksjn5OCdm1AJ8499nIwZ8ffgFrh08nG6haVX54o8pSWch5EqyJASf+mrmGMDq15tbUdIWsyLozAusYDCQv/96xA+j8vvCsYXY1EcIhpuZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eLQcvS0T; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eLQcvS0T"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ee34588671so8871877eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 22 May 2026 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779487532; x=1780092332; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WoYL3oraokua0mUStpvckCOjCdPI3hrcUVdVldzeRF0=;
        b=eLQcvS0TuLSCmqtk1UDL1g6jx6xD+BEbqy88161NEBmaZq/aJrpAdsu5dkV/baVozn
         1qVHDUyTo61uYt8irVTwtyPORCjLz5xwQDp7ekiw3Ig845b+ifDXgZ6SQkuw1FbrJFW2
         jOSET/c5/hDXGUGbLn63HjIrjkyXw3tO8fpIYHfGJvkghEM0LCeMee1ePDl682QIArdp
         9zNztLFrkrCCRbbO+h+AEoVBnfyYLO3/hxZV85YNYvHccjnivXVroJEFxTNrl1xiSdiO
         cjqv95o4QbysJYZkRgozHser/CY+cStECDIZZmZi5RXKUfo6REho9yGDG+1tuhP1/SgK
         VoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487532; x=1780092332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WoYL3oraokua0mUStpvckCOjCdPI3hrcUVdVldzeRF0=;
        b=i2IHBvBLb4XhO30lv3FlxlpzOsqtCXo5zp6ZhcWam+gC/c6QRDY0RtfJe3ksprdsAm
         FIskmzq45AkaZHhIodWEUfL1VDpHy9mOmWDSeXzk0F+Ojl6+/Z1ljFZrkPH0gfPVOaFh
         /28hfdb/Q/Pj204D+B7Py0ePK6GPGg5mv3/ihItZ+5DZ7rYobFJTi4Jusrbf+piC2wJM
         b4thNCoWjH9T9ngzV6kJ9ZbLsn9nhsCo/NUoQ0XGoKMYY3Lx4GXG0zfvqee/5NJwDcN3
         kGGD83QnAtnA110FrnTKfKm9S03F9IrzKLNxSEdozCrw4hpUc2LuJ/7bHEzr4x2WBZva
         1h2A==
X-Forwarded-Encrypted: i=1; AFNElJ+yL+58aGbOxecoXpJPGLYPkb1UGwUVDrWcJ3dvlBud6ee68q7WEetcMBZr2B28ysZA53iBQ9zKWb7FEC5Vbd2/@vger.kernel.org
X-Gm-Message-State: AOJu0YxZhJtyLr/oz+y/1KOH883dHNYdHPK3KGRyeoDHfluKElpu0+ae
	Ad+sc4WsW537lij4D4q9NcIO7PMuNJXSM3fPb0p9TC+6qQzMUgggrRmlpbK2mdosnYQ1sK/pHwp
	bzIM+N88OXA==
X-Received: from dyji10.prod.google.com ([2002:a05:7300:7a0a:b0:2ed:b77f:b02a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6743:b0:2da:a813:a60c
 with SMTP id 5a478bee46e88-30449103945mr2955830eec.20.1779487531932; Fri, 22
 May 2026 15:05:31 -0700 (PDT)
Date: Fri, 22 May 2026 15:04:34 -0700
In-Reply-To: <20260522220435.2378363-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428071903.1886173-1-irogers@google.com> <20260522220435.2378363-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522220435.2378363-24-irogers@google.com>
Subject: [PATCH v9 23/23] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
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
 tools/perf/python/perf_live.py | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..2e5347349760
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,53 @@
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
+                            break
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
-- 
2.54.0.794.g4f17f83d09-goog

