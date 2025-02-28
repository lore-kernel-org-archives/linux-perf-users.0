Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2801E231D
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 22:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740781459; cv=none; b=dVHCSL4z5TsVL/6sbonG3bzDnSfOsqUtTs2aPxfMqJ6+1LZOc14Kn1INi2Yd1Twzp1cwrtxg3qHTn2gFyysJEluiiYhBUbMBPKy8H05j/REwv1OugrPmck5VJWbQpG+s2L1lGYO95g792XtSU9uJqWTbyoq2NMBBH4Vz9fXFtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740781459; c=relaxed/simple;
	bh=rex2as/EnuXYCks18MkDmVUBXz3F9t2JAEg7XMf2fWQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=UgKhbRWSbbIHpNVE7wiBQW3qzUKYqeu7Jt2V4mauJ4XShF/0Ixtjqd+J3e86Ba2ffAgH9JI9pAxa/vK/Utz8HgA00iZw259rnnB3yctpqV6PDiJtXAZceHmVYrML7koVs0+1A4aftx7w0U+GWtAGXMKohnNiCQqCQ5R8bIt7oPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqglsY3B; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqglsY3B"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fb518ad1e4so29037447b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Feb 2025 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740781457; x=1741386257; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0RU/+DqotUTg+8ru2ruiECPIkRiWWFRT5gNEZToh78w=;
        b=yqglsY3B/iEIDP9/RKZL7Wl1NcqXkKwqrvw3FG5XC/UfK5ENGCeY+AFKra79AH841b
         VDJ6Y275ypvLF/teWBKePbnjnndUygloAQ17Jvk3zvHQD+FUfKWyeQTtRCjJEzQjXKKo
         YPrIbI6c6vNsD6z9adDGb1Jg1KtBdbza54MpNncbkZ4kgdumoAquTx/BXcZwAcDfQBFT
         Qf6vWmRUBVX1iL6OEXWQ3y9VTxYZXf0ZPL+y6o9OpQh5BhLHIsxnGntukkYPqBQf6IWi
         KrMHVgjavq2RTC+32vDaDO4aLW659kwz9OqputgxLAEwcVGIU/4iSOscI3kWHKnw3STt
         /0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740781457; x=1741386257;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RU/+DqotUTg+8ru2ruiECPIkRiWWFRT5gNEZToh78w=;
        b=uy5LoEvScVTEjHRrNvtJPcLjd7m7ChHGmwHOlw2xBGGdwje943pPrUZkiJCFe2n7PQ
         RxY1ZY+mLiXqzRNjR4LDc8HWhq2SFOIqxyqFi33Dh7aTHNNTujAz6l1PYgzqyXjt7+Sh
         PJqVWjQoufa+4ZSL6mNbx4+IIQNfzUBOs9KW9o+eJtWPGM3ZMR6ZUZS59KSSWo8SYXfC
         zSqg7ApblGevyEYpkK5sL/vYirMbsWjLiql8hHiysXp9Wg3IeslMrQBykg50BTBuDevq
         xPgROsmaaXAO6PiZaTABDoaCvz/JIGt6LACRBjf12TDOqVBAyaOlsC0kZ31B4FFZjIoB
         ZegQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+VgxE311wSymGSKEIjh0HpgqtSP97JlB8/dGb93KTlAfrjnWZIyal+UsFqkT9gxWV8YdhO3bpJLxYDC7llHgM@vger.kernel.org
X-Gm-Message-State: AOJu0YwcTEoKYoFSib5jA6SSCVfyrE0w9uEJ471GHExhCbH7vZKKW2El
	4Yggskdef+6EsaH/KPkQWWODPsNFmqgKSuLaZQNCpsKOX/UXd9rV6qcxiJvrc6f/PV3Hwie3/Z/
	NHHDdoA==
X-Google-Smtp-Source: AGHT+IHRV+YnNTUs6kh7Q7NpG8hvARodfZBeKR3CohIJAv7l0VaH42fhATH5xGQ/HIF4iWzdguHHMKEDTZpl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:23a3:4d43:890f:dfd7])
 (user=irogers job=sendgmr) by 2002:a05:690c:6303:b0:6fb:afe0:f186 with SMTP
 id 00721157ae682-6fd49fa7cefmr4574187b3.2.1740781456425; Fri, 28 Feb 2025
 14:24:16 -0800 (PST)
Date: Fri, 28 Feb 2025 14:23:08 -0800
In-Reply-To: <20250228222308.626803-1-irogers@google.com>
Message-Id: <20250228222308.626803-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250228222308.626803-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v2 11/11] perf python tracepoint: Switch to using parse_events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than manually configuring an evsel, switch to using
parse_events for greater commonality with the rest of the perf code.

Reviewed-by: Howard Chu <howardchu95@gmail.com>
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
2.48.1.711.g2feabab25a-goog

