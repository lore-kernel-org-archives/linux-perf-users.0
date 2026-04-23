Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8363A6412
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960658; cv=none; b=pmiBU/z/oFN+lRe8yptQFW71QHay2/AWX3QFJOy99E/Vn1iamX4pp1TmVH6yKuL5rs0p5YrcoKbswhvBViPi7BdCAhQlSiGVQiVI2yHmXm4IPPxz8q0XIvXbJzIfuiYNv59SfHaWUfuavGxzXv2e3JgKQV3c3roXR0EkXntKg4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960658; c=relaxed/simple;
	bh=WFDMhKuu3BFqFsv2w40b0o7hPwy4zzx9X3skPUxJuJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E43ZVKy6+Rm8v9b3++EL0jLDSt/TxnAKuCuASS7ySYHYbgT/3XiYsA5YMPe2v6I2vuyWylsjO9PYXre0tfEJGsK+Y0era4ElFyRQQiWd5p+KxskLoz5zPohCH2mPwEpm2BB5z8vmq3qPPGZ/hTf02H+hq0n6ljH6B5dC6tBVR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3AV71qn; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3AV71qn"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82fbceb0181so3510140b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776960655; x=1777565455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=r3AV71qnSEMKTmSjqi816DLvBrc3KEehwWw4FQG92fRD0esdsIPypXjhkpoxId6zJE
         1XnvcVdvsH7nhbdY7JccYWek06e0IpGJUOLapULddiYMHSO893EV99J3Qkk5antDwCVZ
         QhGkK/Ej4TqCa7O2L3RPuP3l/3co3epLKycdlqAC45YJVFOdXexHPbJwO6xn1CJKL9yu
         mSgRHOwlMKuY2v5LPfOLdR+C/oqexItrd2ysAnCR1iro1M0UVSZjejP1ZD6kRUH+/lSr
         w8RM4NKd88DEM6odtlIWd4dBxOziW0ChLlg5fkqi4fsRLp0gW9Bh2X9aFfeK1Dhz3sOz
         Pyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776960655; x=1777565455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=mFo1NqxjAmaWthcqSlziwv1j4jml60Yvak/tkCLqsNtZ2INhKi5yXPNYtdHW76c5MV
         ExX63CvNHiE4DMnn3/hZcss1tplSMWs8MBc7bWJ8AWo78fwDOl7hLCPhiYQ9Fgavh/Fa
         pUCwBkXqZI+tmCzXYyM7JvPjANEgOz6G4r4DPnwQZE+D2z9Pv6HWsijiBX2+7cfGzWVo
         Q2ojY2zrVdU6EZeCmmmLCH3SiGHo99pCULwp+DVtRmZhcY/kfVBawVgh2MMMWDdNMC+F
         pNKnQZI9x5KlIZQqeAbuQHOcfIUuzpNBsDNF1J9Dj6XZ9SoWa8qF1OksrjWLY8j1cfaM
         eLoA==
X-Forwarded-Encrypted: i=1; AFNElJ+cSkfOwlalGpJ/RSHYJzVBVebBCPTXXiMahxIJCHlzX1m/ROUKOXcrwP4qg4Bx04X0KFSVkHvUajP3jW8dZZyG@vger.kernel.org
X-Gm-Message-State: AOJu0YyrmDzuj946Xq41rGIXuy7Y9i4jvHV4F5Mi20zYHFmVkmMtHlF6
	AGhLBe/y3Cv5jXcq54YUlXOBRctZ0q5NykE+ko/TwpiVXp66XhCUO4kIbbZV9NLqFuT8Qz1Al1W
	+1ny9jx2BtQ==
X-Received: from pfbmb8.prod.google.com ([2002:a05:6a00:7608:b0:82f:60a5:8a3d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:992:b0:82f:3828:a019
 with SMTP id d2e1a72fcca58-82f8c992508mr30820202b3a.46.1776960654962; Thu, 23
 Apr 2026 09:10:54 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:09:29 -0700
In-Reply-To: <20260423161006.1762700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423035526.1537178-1-irogers@google.com> <20260423161006.1762700-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423161006.1762700-23-irogers@google.com>
Subject: [PATCH v3 22/58] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: 9erthalion6@gmail.com, adityab1@linux.ibm.com, 
	alexandre.chartre@oracle.com, alice.mei.rogers@gmail.com, 
	ankur.a.arora@oracle.com, ashelat@redhat.com, atrajeev@linux.ibm.com, 
	blakejones@google.com, changbin.du@huawei.com, chuck.lever@oracle.com, 
	collin.funk1@gmail.com, coresight@lists.linaro.org, ctshao@google.com, 
	dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, dsterba@suse.com, 
	gautam@linux.ibm.com, howardchu95@gmail.com, john.g.garry@oracle.com, 
	jolsa@kernel.org, jonathan.cameron@huawei.com, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mike.leach@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nichen@iscas.ac.cn, 
	nick.desaulniers+lkml@gmail.com, pan.deng@intel.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, ricky.ringler@proton.me, stephen.s.brennan@oracle.com, 
	sun.jian.kdev@gmail.com, suzuki.poulose@arm.com, swapnil.sapkal@amd.com, 
	tanze@kylinos.cn, terrelln@fb.com, thomas.falcon@intel.com, 
	tianyou.li@intel.com, tycho@kernel.org, wangyang.guo@intel.com, 
	xiaqinxin@huawei.com, yang.lee@linux.alibaba.com, yuzhuo@google.com, 
	zhiguo.zhou@intel.com, zli94@ncsu.edu
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
2.54.0.rc2.533.g4f5dca5207-goog

