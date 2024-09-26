Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02A185B6A
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727372500; cv=none; b=hUCg4hjRrYTlSJFTPZHhiMfg0B+NTdaYLgYGU/hirEXSwJcW8MBTpgJeIGzNtsOZr2vwNxIInWVTnxEWgiCOpeFdMxtXP5NAIf6E13JNyLKhUt911kErmtt9gc2NapbVCYqT/w287BxoODc/kdpv/QYa1ZeszSo5KtS6DWzdL3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727372500; c=relaxed/simple;
	bh=HbYzvLuYsseA2874qSaA2XOQKpO6t49BfofOqxj0Fp8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qa/tVWUD45YtoIevECETzS6GaOoY7xXZReFlCxYg1oMSE7DXPOZ17GeVL00aj8t32Mm4E0jjHNxd5CgVxF7wCPBa3zOpXHaKH/TahNaQoUJVpZylvHPlhFdcVa3xbYtZDmwZUQhZFrGXpIXSXYDke3pAJBNHM1wythYJFGL2g7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pYxp/KWt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pYxp/KWt"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0353b731b8so1848201276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727372497; x=1727977297; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vztDkA1b6fMQPPkmuqvV2cGZZRqOfqcurU8xn4X9/5Y=;
        b=pYxp/KWtgUh6K+tDqwQZUSCo+fTzqQ68w6Y8B/LI0fpYr+rYd6EhmsW1g/TpQlSOBk
         uQzIhFcjeOMGwYQVHWLAo5EJth8k44pw3Wxnb7YIAF3AW4t8TRkFQSQ577BKvNOHfg18
         JBwaLvnZPBox36//+ssDX2CdRMnCVVgjh6No6sByxCCGM3cJF+g+t/BOuTS39PHEMu22
         Fd66wZolMMfUIoiDnMj1xTzwPldCRLQhdBh8iNNDnRUYvmUJ6QjhXSejy+lUzUaYORWt
         8Tz8Wg+XbNu9EEA5pzU32sEL3DC0G8PsXn9IUiNsX0XXDMo33HOsrAa8MEqkx1u7FcIm
         JBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727372497; x=1727977297;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vztDkA1b6fMQPPkmuqvV2cGZZRqOfqcurU8xn4X9/5Y=;
        b=vBUJBo94xLqu8E7rXscnk15cze3zIK9APvzdE2tKaFzrBhcu8VTK5NaGN98t59Dc25
         mtfdLX2RSwpwrSXgSYSfuozq889Zaz1pdnoPmiGNU5npLrR0/+1tHCKIBrdVSu1NAyM3
         ZhqKQ5YABiOKFY5TVVIUD4EijTneKe7iDBVTZDbWPNpJKBtrWqAczrxFzMrd7YisbQy9
         /iVkvKMJ9vlGVF9jP6bSF4m0zCykb+xQJ8lFLSTO8qKGqAU0a7ZIIusfybB0423J76VV
         eTylUcj7ENae7QflGJBn8r/cWhyhCg4N6c9Q7Y2aUSu6W8p73tjQx8GD0aPkSBBV5eES
         G3dA==
X-Forwarded-Encrypted: i=1; AJvYcCWXTwf7tD0vp9WU5snDHlIiJkKnQ0oNs5SDMSu2XYBTaOKCVJFWB5ENYQilGaPe2BPQH3thrdpw6+hxV/X/uO5z@vger.kernel.org
X-Gm-Message-State: AOJu0YyLptLI7KFMLvm+D73OKiyPbqN2Pqf7Lm3seSlPD7mMSjmMaBOr
	zIUv3CfiQsfHxO53djh6i9E49fF6a1WbXXFOBipee6v+vsnlqYbYoMoefX2/jIQC+rytcTJB7kJ
	3V0oH0A==
X-Google-Smtp-Source: AGHT+IG2l5Wiyl4xs/zHJlkJNliUa2mF2TeajB656ncgLowFzdt762/OAPpl5ayyTneYKB+7oqzPysmvaGDH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8872:3585:18ed:a056])
 (user=irogers job=sendgmr) by 2002:a5b:b4f:0:b0:e22:5fcb:5e22 with SMTP id
 3f1490d57ef6-e2604b28574mr172276.3.1727372497446; Thu, 26 Sep 2024 10:41:37
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:41:01 -0700
In-Reply-To: <20240926174101.406874-1-irogers@google.com>
Message-Id: <20240926174101.406874-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926174101.406874-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 12/12] perf jevents: Add context switch metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 157fa4fa3d62..422b119553ff 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -613,6 +644,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.46.1.824.gd892dcdcdd-goog

