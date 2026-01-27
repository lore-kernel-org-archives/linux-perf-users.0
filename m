Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79C36923B
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539574; cv=none; b=IbkNx27Ic+is4vfsk42Yp0OrJZDgvLSGhil91T96ItdAy5MTnMY+0Aclpkmhcxbk3ll3nzYT4qP7jzZzFrfNDpfh+zUBXaQm/onSaJGwF50NQj/fLBMaP/nya2H7lNV/iWbNEZyjmMoo3KrOLePuMPiwN3B9UOHGbdj052IBxxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539574; c=relaxed/simple;
	bh=uBZQbaf2jw+Z+6X/HPLRd2UQ4QNWgpzfDckkTan8FMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mS8mzvmaZHLFRIZ2fwoLOjDaQbz2ulZXnnEBy5Gyav9/Fyb641Hmm76t7jYu8tRu/eKgPPPxEkcUpvzdVFtOGcIDRrjKHzTUt/kTXUjy7MN2aAypIF4zJH4temRcOWOjD0RKD1m9GCB1bLvfwtHGqXZDWjEatkmS2FPovzgtwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fKDqSTPb; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fKDqSTPb"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-123840bf029so45655398c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539573; x=1770144373; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTe2zkqt3kO+WTK/oM0HIoGu3LJeTRzWv45QieO9b4w=;
        b=fKDqSTPbkGBOXuGHcD/tds1Y1n8NxEpsGroxtvo+rb6e/1VnYe5jmZV+yuFSYVGlRZ
         O4tYFU9g4W9keVsC8gr19c8B0peacyZcXH2zap04p4DSujYnyD2TdGlT6ZYN2b+4mILL
         wk3Az2F++ZhfKbnfhmwTejiunkxyHNokj6/QTIrAu2lpHLHU3XuH1kzSa7ZgpOPK5GfP
         32hDYVWyvUf68lfg/T7XwGj1HLT2FVrRaCM48aBHiD/GhG/280QNCcqW7UNSnwxpD0lH
         suL8j42UxlpucwteAzUZTKa9e18BjyO+LogWEoX9A3Lernuabi2gj458Jy9Ifx9LDCND
         76lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539573; x=1770144373;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTe2zkqt3kO+WTK/oM0HIoGu3LJeTRzWv45QieO9b4w=;
        b=BH6wu8fWhPjQ9oCx+295TQKQ3r6ma3IzTTac6dWOdl+AD+uKGQggR21maiFPYKUDc4
         juaYLXxJMM9gL3tu/yf2If79ZFAFh9WSZqY50NGmULQebi3gfWTXOZ3yRc+c0IgwfUDt
         y75hf84S2POhbMnHFBL1BL0Ck5RLnZmnn7CIFJIWACBvoN2cmlCvuTZ9psbqO/sJo7vK
         95laJJop4u3vS5cy0TdqcHjb0vmRbjsL5OT4x/211ZDFA+AyiW+B4ry8uZmoVAP9LDj2
         7SUZdHZMJEazaTsZmkAMwuz09BfE7GwjBPaVKMMn1heaOHgxD3T7Q7/2s8eEcxdThZs/
         sdnw==
X-Forwarded-Encrypted: i=1; AJvYcCV4iNr/zjudLka8CVjW58ox6C3nkr5ZifG2YjqcVCkXuGfWUCWAkzhqqUAIgnyBEMtmZAiYX3y7cd0e7iL546tI@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7jKVYbVEu6U0xdPtHjkYhoYFoHLLPPz+ciyLearNGlFelDJw
	xHOQeBOALasWkn2hI4tRbqTeWklcNJDkrfSorzHpMpwmW5c0dGnx3o657eN4cNMxcoEqu7j91fN
	urc1R1KIDlg==
X-Received: from dlbpj8.prod.google.com ([2002:a05:7022:3808:b0:123:2e41:8b40])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701a:c94e:b0:119:e569:fba9
 with SMTP id a92af1059eb24-124a00b888dmr2012255c88.24.1769539572681; Tue, 27
 Jan 2026 10:46:12 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:55 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-25-irogers@google.com>
Subject: [PATCH v11 24/35] perf jevents: Add context switch metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bc3c50285916..9cf4bd8ac769 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,63 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+        metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                              d_ratio(ev, cs), "loads/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_STORES",
+                   "MEM_UOPS_RETIRED.ALL_STORES")
+        metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                              d_ratio(ev, cs), "stores/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+        metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                              d_ratio(ev, cs), "br_taken/cs"))
+    except:
+        pass
+
+    try:
+        l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                     Event("L2_RQSTS.RFO_MISS") +
+                     Event("L2_RQSTS.CODE_RD_MISS"))
+        try:
+            l2_misses += Event("L2_RQSTS.HWPF_MISS",
+                               "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+        except:
+            pass
+
+        metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
+                              d_ratio(l2_misses, cs), "l2_misses/cs"))
+    except:
+        pass
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -678,6 +735,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelCtxSw(),
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
-- 
2.52.0.457.g6b5491de43-goog

