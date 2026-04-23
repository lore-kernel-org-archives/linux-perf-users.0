Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE53D0929
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776916588; cv=none; b=bj9g17rox3MhPDVE7FdrVJttEhB+mtmTPRRm1vgpDCCxzQVkIx8I5XKSyH70CKsaRr1Ecpjho9w2NxuA6YBuj5RJOvl/T3Ftv1fGR/AKixW5bykcDElfGEdOWUAgrx00vexWRgDuMlBPvy9Ck/4APGqPeW4G6LKL2ov93401Tj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776916588; c=relaxed/simple;
	bh=WFDMhKuu3BFqFsv2w40b0o7hPwy4zzx9X3skPUxJuJE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oxzqpTokZbij3LoyqHpd8XEotKd2IBFpRyX/VYavCFm0bcP8Dsl36RWYghXWDcrLZ+aA8/4JeeKhVCLEoI+h7aO+r6l0fmAbkOKk1K0ELaIvNY8a8dcj7GDwvwlMeFb2gIH20egzTLfz0CItadtlrTzNpWKan4b6T5ZXB0t9NOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t2kgTvnE; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t2kgTvnE"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2c0ba59a830so9746471eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Apr 2026 20:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776916586; x=1777521386; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=t2kgTvnENXaALYbOANaLx3TlMIbPodwGy6G14Syf+wuqO5BotSz3ZA4JIow7EE+0Rf
         FqvxG2EzBA5SOczFhXZFHCfvfjIxjUoqmkMtViUgCFTIf25WX6WFi9ve6SVY7zAMV0uQ
         eUcMWYrvq8eXazaBAkCx9x24vd9R5PZVRuVrX0imW9D5BJxIXnA/KfhzRlpHSQg7jdSw
         Lslsf4hZbs6BzvUyfyYP+3KFXx59ApF+Xxz59xmcqkRiHSBYDgbgyEAfsY02Jy/2nwT2
         kYsRotXhe5jknFxgDCBcVcNF9XaF0frH33hkAZZIf4Kc2MJmT8bbnPQXSWQHQKZDB/lC
         E4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776916586; x=1777521386;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmfkDHgGkhhc8Ci3nU27rOXJ2A7e5StlaPZmf/zqGxg=;
        b=bx2VlC6hrezvYwWAvybdVuJdS5SQvt9NYdtLxpHKYs24eL125y2f+T8cM3PS9ptjQF
         aF7svqm2gK4nmnC720BNJGtZ4ql2sEBFWFqGUcgTq2u4qG9lEBzbFp4AM70o7QSC9Byn
         jToGq3Ry2N6iuBbNM3z7plNY5v4gSqLJz028IzDucuhTScfBc4SA3AxcX/g/NQ+sxCGC
         DfqDWLv375VWJPte/3mgLM6Fx70Rv+fqu6RbwUYak9V5UltzxEGVbOY9XmtUFJagOLsW
         eXf5CmLcYIvrCPqH4ujenuMAuUSvJa2fsQ/xuJlA9rH0Fa/d4/eMGGhP8kTBk0dly6d8
         F8Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ub6ciF6ABQaEZipm+WbeRQhz83VeW/Xs2m5yEnohY2JE2nRySn7hj9NOqbaPfSKdWDFtmeBrfLAUPZFXEwlwr@vger.kernel.org
X-Gm-Message-State: AOJu0YzT4zrd8p6zZCV7phB2hO68Ao8684cKgLmXkgHDPDJ3sZ/gEjox
	/MzbxSViaURitW5OlaoXq+NuhpooN+nF3HhIi8GUYM7vEPvCNRGZuqi2gVRlgl6hTYB+Ssl6H/Z
	nKWaQVIzPaQ==
X-Received: from dybso7.prod.google.com ([2002:a05:7301:6907:b0:2d8:e3a6:d707])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc05:b0:2c0:bfe3:b95c
 with SMTP id 5a478bee46e88-2e466044086mr12419456eec.4.1776916585477; Wed, 22
 Apr 2026 20:56:25 -0700 (PDT)
Date: Wed, 22 Apr 2026 20:54:50 -0700
In-Reply-To: <20260423035526.1537178-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-27-irogers@google.com> <20260423035526.1537178-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423035526.1537178-24-irogers@google.com>
Subject: [PATCH v2 23/58] perf python: Add LiveSession helper
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

