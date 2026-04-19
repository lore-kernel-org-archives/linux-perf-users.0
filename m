Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785C2C11CB
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643216; cv=none; b=NEr7WSXkN0o9VfhmKIz4lDsukItRSmJ4f+a3lGR9IBzylBgWUQK7EytQnAF2s7DiJqq/tb3OLgXfHzaY+LIaOgVdw4d1g/ZjpOrJzdgxPuLimwfjcVG9jhUSGmaVtk4+/CqVQ49zJvvqa1IiCsCfn9n2OwY4g5k1fnT2Xd9/qGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643216; c=relaxed/simple;
	bh=pkcM/Zg0MRlY8TU5jUjIuP2SZyvWkKPBPlE6m7HOweM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KJmXvTokGt5J60tVXmdu+DhcoA3l/EJXf05xw9pKdeqCse0qHGXOIIp923AOOL5Sw4VvKdJErOkwY7hvjPQ5lfwZXVVjahIe4+bFX8idTHgoGBfosGyFJc676YH1riBK8xqanx/Kpw9WIWks6WEDOIpKNY/eTDzBVU3288ZxuMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LB4y7vkP; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LB4y7vkP"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2da19227bc1so3380519eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643214; x=1777248014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnI/nrsRs4el417LfpDMjy3aAzK56FVytxMqn1Voscc=;
        b=LB4y7vkPivGX42vwGPqarC6iUrCe0FqdNyfGvkHcCZ7usfN551b2mIRIwNTVWKCeNY
         qP5VOYViP8G5rf26j1urDCmfrfHgv9V5RlGNBXF1FQSD5QMdwoQyFreA8bIuSWdyuGg3
         ycwwMYyI86s5xHHLHC46OpCuirWjQW/ehtDBt+MkTgKX+6KR4uz3x6mDJPJvcwIEyL4z
         sU5VPDe2oqa//UwC1+qZw0vnsbSsqkrY7lLSo7xtgxCX+toEes1rH20CoHFTAv2yvK+S
         Bjdy8l0AJD1CXym5M/ryTRxfkiWSHdAadQmg6ml5QWAa7Rmu4GL6Tn3lO4NVBv3nQ2KG
         zYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643214; x=1777248014;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnI/nrsRs4el417LfpDMjy3aAzK56FVytxMqn1Voscc=;
        b=knfdaEByZ8CiJd5x699l1NBWqpJKFjlo0xXSS6xwT+xWcTZ9XOsbnDAVtkOpHs4CEh
         Mq+AS3jqjfXJ4uvqlBFF+W0ZYkUYuLvHIR+OB+rXFO3+5V3fRJE+ligaiQJYo1FQ3Nv0
         CZXDW4E+rteJV8Dc0IrJhFosikWVfDFdXSWNw+kXXSJCL1F3s0os9ypstG2U8o2CpiDp
         HjXTP74rbSZ7FL6I7A1zAfDNdafJoKki0PBSALzub6d5DY0z+2mTjKDiiemozQw3EPYW
         gn39tEfIGKyn24sf32U2H+Tci6r7MR5QGiUPHy+wqnhYxkOmVDuA+QO+RuEnFAyvrWHr
         FjZw==
X-Forwarded-Encrypted: i=1; AFNElJ9GOWf8YIbMHgrpz5XCZeVe9zs7rJ/zjZ+pGZ5SoSxdJwRsOpZdWTWItF/LiG9QY99bGiAf4mRgQBy6n2KT1nOV@vger.kernel.org
X-Gm-Message-State: AOJu0YyL50HdUjXppwsK2+Z7iHiXwMEJdhNocd1iKLL30T3hL/3Hk8BE
	OIreBustgN+iW0VE/Tk578QDjDTlVAq8R+8LrRC577pYKvlakrxkEg/mo6yP7wpiO0SVMht+2/y
	sJ5MiO4afTQ==
X-Received: from dybtv6.prod.google.com ([2002:a05:7300:f486:b0:2d8:5b05:964b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:2d15:b0:2e7:5737:8364
 with SMTP id 5a478bee46e88-2e75746d9c9mr2508476eec.15.1776643213698; Sun, 19
 Apr 2026 17:00:13 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:35 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-24-irogers@google.com>
Subject: [PATCH v1 23/58] perf python: Add LiveSession helper
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add LiveSession class in tools/perf/python/perf_live.py to support
live event collection using perf.evlist and perf.parse_events,
avoiding the need to fork a separate perf record process.

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
---
 tools/perf/python/perf_live.py | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100755 tools/perf/python/perf_live.py

diff --git a/tools/perf/python/perf_live.py b/tools/perf/python/perf_live.py
new file mode 100755
index 000000000000..81d92f720b58
--- /dev/null
+++ b/tools/perf/python/perf_live.py
@@ -0,0 +1,42 @@
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
+
+    def run(self):
+        """Run the live session."""
+        self.evlist.open()
+        self.evlist.mmap()
+
+        try:
+            while True:
+                # Poll for events with 100ms timeout
+                self.evlist.poll(100)
+                for cpu in self.cpus:
+                    event = self.evlist.read_on_cpu(cpu)
+                    while event:
+                        if event.type == perf.RECORD_SAMPLE:
+                            self.sample_callback(event)
+                        event = self.evlist.read_on_cpu(cpu)
+        except KeyboardInterrupt:
+            pass
+        finally:
+            self.evlist.close()
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

