Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC37C32937E
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899512; cv=none; b=u7MBSC2/1nWDCHWHmONTbF61E6kJTdgvnNAEH1AsOKUEUF8HPXoFEWkuoT7qtXfsj3Z4tf1UuiijbEifpXOD+caBFPStV1fXp0zun+e6lwWokjFnuVs5qdob/LOFRcvbDQ+NXcRPta5BWSg0aeqR/Hvl8HN660HWHyAW8Kc4fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899512; c=relaxed/simple;
	bh=jGvHnBOIRlpXNzPDylmnrl70NxmK3iS0ZSa2PimW/OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=HvqTBIyJNhN0tv+/s8BpRfjjiGtxXCAXpzcUI7JZkMSdPUq+fpIWNWtUAw5S8wl8vg2VJrUIdztX28rvtD95wYwO2CdOBEXJ4KO2vtiQz+rOKpXgtjcWBE2w2QCV4UDDf7N6SsivN4J8lCJjMtYIPcrw0CDCGWPkAIYp1Zo7qIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5yymHJH; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5yymHJH"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b048fc1656so4084114eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899507; x=1768504307; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bQwBUeqFHmxPyvU6W3Kgyx2XHVX/3kNh3j54lLQrKs=;
        b=H5yymHJHc7HxV0g2ZJuYxx/sCwQDm2ytfyzrxGPmtsdw+ZBDDAB/D28/IVEt849CWy
         UrZVjCnLZGFMt+o2p+RMiSh0H771g9v+VUwHFPtTv9/cJfcUVfictZYWd0e5vUyzspGd
         y5En87YlOuqgm5MYZF5NAJ65BZHpBLBavu58RDtg4XDZmrpeZysU27xrZ8lxCV8SJee2
         pAdwN1vwCxTtEI/mFDL03uA9QCQJ7gZJLKqhfhBU0SPdfJIfLQ0/oGkqczOJLZ0BRhc6
         xU+b2sv1t+HiSJKj4e+7TfSTb75gznwkW1c4DXOjj8O+y/xGqKLcTtrI5HmxFhO1y6XL
         /qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899507; x=1768504307;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bQwBUeqFHmxPyvU6W3Kgyx2XHVX/3kNh3j54lLQrKs=;
        b=J9OAYRDnPHgqSFyLWXy3rBuJp1joB12GTs/954Ic+idJpgmjqPUF9Vd4rVGkoGi68D
         2vvL77iRoZ3ZPwAEuj44/lZ2Vod4o9VT32i+vOEwrLQquuAZESuFMAvqyPc48eclifDg
         bHV+GstEBWtJCRu8aupyUef1pAHnAuQgzquqB494Gb+07rwg+xN0qJ7eDypIA9xZBL/f
         IfZYNEn1tB/rAQF0+RZUYAQi8cY3eqxdXUOyxO10xmNcqroxZ/arOIz+VsTFiHrkhhdr
         y5gOZ8C66QLS/gPGFq8DshQi1ZNyPcPWEKu5/zHo+JrZ37v8PfpF2aWjM8A7cL+e1+WW
         pmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDG+rW9mXOdWxpf3kqAslmrz587wqa+kQy+WRiDJ7kSeXI8AfVWDUOuYHQ3/4BcHx7NyY35zk8JYEqeky3AQg4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd8RfU4fvzxUfFdHpx0YULhFmWVpn8nvaMwHau3g4iwAW7Fra
	5ahln6OYTivGs9tzbdd7O/tXx9RN2u07nRZjM0+ffN3mKcPPoGsTtAmKB/qx8ZOJtq//psZJqB6
	UUDx8LUdxug==
X-Google-Smtp-Source: AGHT+IFjJOwZKFxZq+U+vVCmQ0zJZVODmFqQt9C3sBwElvfkzCtXeH6OONG0DU7+z2ReYxNDQwNpM5U6h80R
X-Received: from dybny40.prod.google.com ([2002:a05:7300:e828:b0:2a2:2846:c513])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:5f0b:b0:2a4:3593:9695
 with SMTP id 5a478bee46e88-2b17d23527emr4508241eec.18.1767899507250; Thu, 08
 Jan 2026 11:11:47 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:41 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-12-irogers@google.com>
Subject: [PATCH v10 11/35] perf jevents: Add context switch metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Benjamin Gray <bgray@linux.ibm.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jing Zhang <renyu.zj@linux.alibaba.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Garry <john.g.garry@oracle.com>, Leo Yan <leo.yan@arm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Perry Taylor <perry.taylor@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Samantha Alt <samantha.alt@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 33 ++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index b3de74babe40..83e77ccc059e 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -122,6 +122,38 @@ def AmdBr():
                        description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
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
+    ev = Event("ls_dispatch.pure_ld", "ls_dispatch.ld_dispatch")
+    metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+    ev = Event("ls_dispatch.pure_st", "ls_dispatch.store_dispatch")
+    metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+
+    ev = Event("ex_ret_brn_tkn")
+    metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
     global _zen_model
     if _zen_model >= 4:
@@ -438,6 +470,7 @@ def main() -> None:
 
     all_metrics = MetricGroup("", [
         AmdBr(),
+        AmdCtxSw(),
         AmdDtlb(),
         AmdItlb(),
         AmdLdSt(),
-- 
2.52.0.457.g6b5491de43-goog

