Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CE21B196
	for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747684352; cv=none; b=kECY65jd3/Z7/g3CcStECV4rMJyUbkD7S6TdzBCR1x1ibw0bd42xnB+lnPFujRBeou4O3DzVNrxYhWw1LLFxUHklmS12YG0lJ8dtgWXMlBXn4UaDO60at6gALOw9JTkIzQxVj4D5ScYp4NidECIS2sAXG5HceagXm5l1nS48vYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747684352; c=relaxed/simple;
	bh=eSrz67FjkchHelHVafOEmeAWHUr6NPRPEc/rDzBRpBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDi+6QJkZvc1UhQqEhErjfYbDXjOxgUYynk015dULfh9CwSpL5MxKi6eiFZ0jmfAnlM34mGwwxXPDTxAmbbwbZkWB1d4yaqN1aCjivWaVH+9wrm2A1JFXH+FGzQeO1c0PY8UpTWCYZOHoOztM/rXePYj94d3QN6eN6RIWetlRas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BP/HmT3w; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BP/HmT3w"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-707d49f9c3bso66120327b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 May 2025 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747684349; x=1748289149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tPgXaI8tTFRwCefa6hNl0JPB2ZmpLpvML91z05dCmvc=;
        b=BP/HmT3wqOXkbxBe3cWLT6uQWQCGlIZh4j7Rh1epn3t5yEta1kTjlgwd23r/r7TDJH
         FaYQb0WU3hCLhJi50HcUb+pPOEIT8kCfP15pr2OpONd0tXWhGJi1LU43a0iR7NhwmQOC
         lZ9vkJOin1+kx4MLJpzCfAxGOLGxtvWq/pMecXcVDXdM19i2iOyirSISdD2OOyLcHbGU
         Vwoh2szLwZ4DhSZmkC5gSVv6x1hVdymHqJ0AieQtIMoJeeRDbalSMiwNmmHsc4uK6f2t
         mBrXTsABAJdcAQHCQ59JM3MliQi+3S+x67+qaaHqWn0w9/zBobrxrSQiuXlf04hO2EoX
         wVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747684349; x=1748289149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPgXaI8tTFRwCefa6hNl0JPB2ZmpLpvML91z05dCmvc=;
        b=tjZfwTNSXjYRnM4uJ7KMDd76VnPiOq38HK+26GMJGydtTp7FoK8Rv07EpkI9rWk31r
         xVtfNc1DLGe49RcCJwToerDFI25q2Wqq5/FaXe89AEgqadeyC+WMFEkUi2DPtyO2zdEs
         8SsXCLlMJ8WhGLqvRQVZWeJUeDb2HXKmobPMd8euJ1U4bJrMmHTzcS/qRVHbHrWHl6pN
         6efueSi/a0X6r16AHevQ7pzUeTzCziUgwsMSAlIn+HIyWYyUY1HLh5C6xGcAyY9BXnrN
         WRUu/GqXpQUuAWuov/vj4DR5FJfkOXwguks2A53n6edBIek8ogL0HX/y0+ffECLjdeh5
         422Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnVEMEU6rmDXZ+l/7WGwfRxY+rsCW5054D8/pUQRP8eetWVFj1RDgqzIthSdrL2Jt64frmHqXnoV5Q79mcwZw8@vger.kernel.org
X-Gm-Message-State: AOJu0YxlG4xaaw98Qp8NGe36ycqfeW//qYi/E9k6zEUpAq2avA6emxsT
	bch3tX+L8qwfCkd0COlMU4Fy0+OPITr67UDLCi99HPN960Ww9S2dQaytoQLJYwdg4eNC6JIlKKF
	EoQHKuKOXyw==
X-Google-Smtp-Source: AGHT+IE5I8VoxfmFAqXpjWibQjEDWEqVKRsT3H7Fw6rw3klfVG1MgxDQDM9hd8bGKD0W7XqOKDtbBGECTEBK
X-Received: from ybdm17.prod.google.com ([2002:a05:6902:6b11:b0:e7a:b53d:558])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6902:488e:b0:e7b:9972:5cc
 with SMTP id 3f1490d57ef6-e7b997206c0mr7412820276.24.1747684348890; Mon, 19
 May 2025 12:52:28 -0700 (PDT)
Date: Mon, 19 May 2025 12:51:44 -0700
In-Reply-To: <20250519195148.1708988-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250519195148.1708988-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250519195148.1708988-8-irogers@google.com>
Subject: [PATCH v3 7/7] perf python: Add counting.py as example for counting
 perf events
From: Ian Rogers <irogers@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

From: Gautam Menghani <gautam@linux.ibm.com>

Add counting.py - a python version of counting.c to demonstrate
measuring and reading of counts for given perf events.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
Ian modified from v2 to make the API take a CPU and thread then
compute from these the appropriate indices. This was discussed as the
preferred API with Arnaldo:
https://lore.kernel.org/linux-perf-users/20250512055748.479786-1-gautam@linux.ibm.com/
The use of a thread_map and cpu_map was also removed to make the code
cleaner, instead the cpus and threads of the parsed evsel are
used. Support for command line events is also added. The indent is
reduced from 8 to 4 to match the preferred python PEP8 indent.
---
 tools/perf/python/counting.py | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100755 tools/perf/python/counting.py

diff --git a/tools/perf/python/counting.py b/tools/perf/python/counting.py
new file mode 100755
index 000000000000..02121d2bb11d
--- /dev/null
+++ b/tools/perf/python/counting.py
@@ -0,0 +1,36 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# -*- python -*-
+# -*- coding: utf-8 -*-
+
+import argparse
+import perf
+
+def main(event: str):
+    evlist = perf.parse_events(event)
+
+    for evsel in evlist:
+        evsel.read_format = perf.FORMAT_TOTAL_TIME_ENABLED | perf.FORMAT_TOTAL_TIME_RUNNING
+
+    evlist.open()
+    evlist.enable()
+
+    count = 100000
+    while count > 0:
+        count -= 1
+
+    evlist.disable()
+
+    for evsel in evlist:
+        for cpu in evsel.cpus():
+            for thread in evsel.threads():
+                counts = evsel.read(cpu, thread)
+                print(f"For {evsel} val: {counts.val} enable: {counts.ena} run: {counts.run}")
+
+    evlist.close()
+
+if __name__ == '__main__':
+    ap = argparse.ArgumentParser()
+    ap.add_argument('-e', '--event', help="Events to open", default="cpu-clock,task-clock")
+    args = ap.parse_args()
+    main(args.event)
-- 
2.49.0.1101.gccaa498523-goog

