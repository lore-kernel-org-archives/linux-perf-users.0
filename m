Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC71215F44
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409104; cv=none; b=GeNCAXTNF5B44pAw38021MLu/5mHVrMniA2azgCs7hTIzRTySOOY2ixvXxifMam63wRnOCLJeOC/yIDAsfJzLrisWpiIgAsCi9f9Y86g2BVnQKd7VeHTiWuBKrCJY47MzqLvo2+VpsH6fXHujqQW4+nzDTbx60C9gO7FwV1ameg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409104; c=relaxed/simple;
	bh=LcuM1TfmrACoRI2O+KPtHudrA17c/H/ANDgc2PirYpI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=se2j1Z/37V3QF3amevquKOehu1YkpIKrmPRW6D1fc079PqJ9Wq1z2bZxGSJdad1GHRuAOzotbnpzcRrkXU3GkhPS7Z2IJGy8bg2mLl6JC9eK3aeID1LwA4SQjxfXGWBz7Eca0O8Ya2CfMCLb++E7UFSTj3tmOMEIkLixJKUb3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxYSYn8t; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxYSYn8t"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so4252394276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736409102; x=1737013902; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xj93vfuj55xARzsWpay/iUAHdI9qiQp37TLmSVo9jEs=;
        b=MxYSYn8tmyi+jww6/FQY1HAW1kH0JSThpvmlxc4yNSVhQaNlPZPw059cobsn59G0Tf
         fjelbxCeLQsIu3+aE4BWVMEtpLHzDYF+ddqdyZdvH2xe/sOjBv6zzV/RqR0iZSjxapXl
         SpXKntIcQNrVAc44u9iOt4LAfYIgBOE0fDkhoYKwtqDjJMKbChqnDa7Fnqvt8Ty6TOaQ
         j1T21MQPal2G2zaz8M73GqeqX29Fg6xHjclrmYZ9H79jnjAkiDa9TVFLM4drlfxp8v0K
         nReAVvbpCaTrqqW4SmCq0hZbXVs7gO1AZIuXwTNyYYuZfWtNatUxGXnQjtjkOJw6qqtC
         RGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409102; x=1737013902;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xj93vfuj55xARzsWpay/iUAHdI9qiQp37TLmSVo9jEs=;
        b=efS9AQotbayZNw8FDyiiD7k/OcUjIKIdCUNbgFK0qWx1dLlT95B9OLr5yW4kxJUnUd
         Ay1TQNPNEb4oDb4571/pcE1d40X/Cas4Ki1Kczf1eSIGsjhsuVyXFNZAA9UQRZbfUj9g
         vfIo0lIh7oCw/cjI5gIGI7ylEiPs419USa0dCVXeIfSh9FU153il5gMvenBOHjrkZUg2
         OlOFhO0GOlEwET8XQiI4NGUb+xgf8knl4luFMTPm6BgA56RHI1jJv+LIM6EyOyB9wTHt
         CFMdk8J+LCAJge26JS87uOW7i81KuXKtyeXkvxyZ+SFfGW8up9GRvgewRq8tEww5TZMV
         ttLg==
X-Forwarded-Encrypted: i=1; AJvYcCVbLAmijmXzJ/wHBn9VYQQo5i55COcXST/ciaSp3GYgNDVFWMQLIQBQesKmZZnZqdhKFa6gFJP1C/8gRg8bGP7J@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAPsVLuqmodCaMK3oj2TsYxf+dtoOek9Zz8wByrR/eiCP5bnO
	9N5oi+tlrwr67NsLCJ7RIMBMvjrHtK0n/hMm9lmoLDEmK4E7tSr7z5ZYNEWknGb8LhmyrFdaMTw
	i7hXnwQ==
X-Google-Smtp-Source: AGHT+IFjYOBojDm05vXb6n8MqNDkJC7xm5062sZE/csmmFZ6aKOedVisiYs7brlL51+UYZb/a9LeQuTf5wiS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:f801:f788:c7e5:c181])
 (user=irogers job=sendgmr) by 2002:a25:aac6:0:b0:e38:225a:c3be with SMTP id
 3f1490d57ef6-e55018e90b1mr7040276.5.1736409101643; Wed, 08 Jan 2025 23:51:41
 -0800 (PST)
Date: Wed,  8 Jan 2025 23:51:08 -0800
In-Reply-To: <20250109075108.7651-1-irogers@google.com>
Message-Id: <20250109075108.7651-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v1 11/11] perf python tracepoint: Switch to using parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rather than manually configuring an evsel, switch to using
parse_events for greater commonality with the rest of the perf code.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/tracepoint.py | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index bba68a6d4515..38b2b6d11f64 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -5,24 +5,23 @@
 
 import perf
 
-class tracepoint(perf.evsel):
-    def __init__(self, sys, name):
-        config = perf.tracepoint(sys, name)
-        perf.evsel.__init__(self,
-                            type   = perf.TYPE_TRACEPOINT,
-                            config = config,
-                            freq = 0, sample_period = 1, wakeup_events = 1,
-                            sample_type = perf.SAMPLE_PERIOD | perf.SAMPLE_TID | perf.SAMPLE_CPU | perf.SAMPLE_RAW | perf.SAMPLE_TIME)
-
 def main():
-    tp      = tracepoint("sched", "sched_switch")
     cpus    = perf.cpu_map()
     threads = perf.thread_map(-1)
+    evlist = perf.parse_events("sched:sched_switch", cpus, threads)
+    # Disable tracking of mmaps and similar that are unnecessary.
+    for ev in evlist:
+        ev.tracking = False
+    # Configure evsels with default record options.
+    evlist.config()
+    # Simplify the sample_type and read_format of evsels
+    for ev in evlist:
+        ev.sample_type = ev.sample_type & ~perf.SAMPLE_IP
+        ev.read_format = 0
 
-    evlist = perf.evlist(cpus, threads)
-    evlist.add(tp)
     evlist.open()
     evlist.mmap()
+    evlist.enable();
 
     while True:
         evlist.poll(timeout = -1)
-- 
2.47.1.613.gc27f4b7a9f-goog

