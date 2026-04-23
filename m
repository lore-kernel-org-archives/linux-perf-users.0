Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9223AB287
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962109; cv=none; b=JYq4wWbP87WuCubp5h4dk8VBvXq9pxgVfZz9/YBB3+hhMfaaYvYeSNiH8sF59H+6BFuhDGXJHkYTSGH5fW9Q5OifCPzQhJCgBAssDbvwtQ+vP/4AVbQuAfic1d1LFmVvId82JNdnhpRsoWjcSHPME7eJptHaTGCR0dVMnnWRqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962109; c=relaxed/simple;
	bh=WFDMhKuu3BFqFsv2w40b0o7hPwy4zzx9X3skPUxJuJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gX3RC+59Ou2A/iTAT2YyDKZZ6hoJtWjZkLW24jDrB/umjV4/GG5RQj9FD/X2xipOJ+GGzdBn7fcBMy+o0Pw3kA9nfQcNobNYdKW1oxSf4ixtV2Uny+pl0bFH6Ze6tKQxVIGaIeKeUW4Za1urJIb7LPRNLwaahhF3bJZKE0dh04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iL6SGx4Q; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iL6SGx4Q"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2da19227bc1so12602740eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776962107; x=1777566907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=iL6SGx4QoWhMLtlyu/P4Y77mjeZQeLXN1ClcNFtn06A5q+7/ilUsaLwxdX5TPf7YLE
         Obi7+6lzoYbUYPuIOJWM3Yn4Pix+X3oXDmursMXJ+Yh+GSn7aVI0p4aLVDhzzQ1YWemN
         +JqhAQTURdtcOVGn0w8mNzbCl2ewFwl86gJNAjvcGMeDrSW2sWdMy98UrCqg6rfhdgd7
         H+AhZW507uLKWcVXzfvJpeHUuXq2VCNEjDbr6grZ6ZQajZ5UWfT7rzQAHo5iEjMD16Nq
         59CJFQJo0F6Wn4nu/c6Ajmhvcxa8UnUErNrKhTeYUGRmy8y4MzWH3ayCERYWdeSyQMKL
         NSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962107; x=1777566907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=qwG+yuRNx9cCIRnRWNd3W+pps4Dp/E4td72HIg0tFHipV0upbprY7IYHs2WHcLxjvR
         rLF9KHaPR1WXPhyexBtTVSp7u23AuRsP//CZv04also/7WU5sfcF7vLWzqNmRCpSun7e
         v70StyZdlgNrYnPQmvqbf00IznVidJxDVQaP+Xri7gJifqMVvUVc/+4SLnuzyxbRyYu7
         aQXevZO9YUaUfB5M+0RGrf/buBn0SLA2t4sxJlQUtfMojRo99i7DgbYX1cHYgYXDuXTT
         4LGs/NbgPvizoF84zNIIJOeNNXu51pskjqE8LEK8fgyzGyBv1hjlotofFtgvjUVF2FSi
         xieg==
X-Forwarded-Encrypted: i=1; AFNElJ9Hol/L1VPZwm8kAL+12UR2jVrtjuPKS2SEzkBK4YoxaQAL1HpMzqPkdbSsueqiW8Ct6X4UPSfPqAbS3TvhCT7E@vger.kernel.org
X-Gm-Message-State: AOJu0YypovD+c34490Q67EHYx4deOE+fPnJinD8FlMpjKg/zalolQbeg
	KlwA9BIyVrWhH/D8X8Hnx1oPbheb+E3aZ/69zUnL3QsxHmd04Gc8+G5oKmlD5gyF0oiX/oGTYUg
	2qfySlv+0/w==
X-Received: from dyjh29.prod.google.com ([2002:a05:7300:561d:b0:2e0:f299:f616])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:fb91:b0:2cb:de38:c77d
 with SMTP id 5a478bee46e88-2e4648c57a5mr13594444eec.3.1776962106571; Thu, 23
 Apr 2026 09:35:06 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:33:31 -0700
In-Reply-To: <20260423163406.1779809-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260423161006.1762700-1-irogers@google.com> <20260423163406.1779809-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260423163406.1779809-24-irogers@google.com>
Subject: [PATCH v4 23/58] perf python: Add LiveSession helper
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

