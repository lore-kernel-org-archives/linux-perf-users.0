Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBE3659E8
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539549; cv=none; b=H1MsEbQQPXCsCkNG5yF3UPJyIKc4jbCWaHYG1LYiNok8Up4l0IdjlxfJ8EiHN5wRvoue7N/mCVt1hIDjV8HboL/hoDf5hlRZ6Kr9AKCc++IG0VbkMIqgT0YK3pelik5c+A0MlKpdv11Me3oIwM9LhwuMXpNasBsynj8GGCfmShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539549; c=relaxed/simple;
	bh=jGvHnBOIRlpXNzPDylmnrl70NxmK3iS0ZSa2PimW/OY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=aQyfD1Du0R41hWRMHysZRKHS6z0+B/aCUla8n+voeRTf9ne0d8UYM21CFtJpiVYf01Xv8hJjjTXM1kmRcYwejKAx3PilzeOgFW07lhf2tjHSzyw/ZVjuZ5VKb4T/ybFZ+pWLBZJlbweDTzmQFIKqRGSIIFpv4D5OtkdQ/Y5E7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jnv4Werr; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jnv4Werr"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b7155ca88cso5835203eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539548; x=1770144348; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bQwBUeqFHmxPyvU6W3Kgyx2XHVX/3kNh3j54lLQrKs=;
        b=Jnv4WerrqrEB+YsRRRIJD7QS5NPatx5Rb+QBuP2d3EVlFHVjqVm6k/iQ8Fn5Kutw07
         EuzHMlXG7WfjV+cWT4MvjYr1nQWKZqCrEJuwh1/2Y2EW7DwdWOm5+05hZQJgVF4FmzQ9
         XaymvYzYFhURhy3Xim1ZihlCslpvYXphMQxPHEf1V9GVEP+X2xPCoCkPye8CbvlGJP87
         aTBuEeitDpGklT3u1J/rWriUwmuBmqduPvmkWuaEqv0FWs3PlXdWKBjJPNQCeyg1EGoS
         92rU4RV/Fz19/7vG/v4IWBUwYEvpVLs0lEqCXcl/uwBCk1XUjKdEvepBhUDMuxx9zvfU
         aXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539548; x=1770144348;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bQwBUeqFHmxPyvU6W3Kgyx2XHVX/3kNh3j54lLQrKs=;
        b=Rjbu1eghqHhfkxqdhAaRA8V/VP9kBfhWIhz7yrZtxZ83y2C5iE9o2UQ5SS9tiXyxLt
         orFy6+s9P+coezYpuvlIKQCa+yCwqbyED0QFg85n6AdkA8vdE5XuT7/9MXeK6qoagteN
         LsMNxv/4QqISiUMYN+UnVt3HO8AfgUai0N08+ckkRHh86rcTJugzM1LdJ6KWVT+JOsps
         1K9rATasijo4dKIpaGr4+wPsqflw75A3L79KmBatjtH8sfO6z1mPtzR9WwNDoz6wcLHa
         M6mfSP77KmtbzDmtZOEZiAX1ok0iMPlNQeDF3PoY1HUnSg9DCu372eF1tkyCXQ+anb+W
         5E3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIdpJEUinG0dbYCUnZI7rVvgN/xOhia1Vm/7lP5wElnS3EivqOb6sH2v+YJ7DzVzFVaLf+6yK947gtiaH0xfvl@vger.kernel.org
X-Gm-Message-State: AOJu0YxsuitTNQ48Girn9FB1aBsm0vlxJhmzJS5B/pos0fZUTkdfFSvM
	2pvVug8VrZWeOXz4VrvbOTGKzYvmq4hXeOgaWvuibinfNmuABUSaeI0nadmKOznztHFHMu7O8RY
	MR+lt6hRNBw==
X-Received: from dyt2.prod.google.com ([2002:a05:693c:8082:b0:2b7:499d:745f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:e80c:b0:2b6:b23b:d488
 with SMTP id 5a478bee46e88-2b78d98df7dmr2125109eec.25.1769539547575; Tue, 27
 Jan 2026 10:45:47 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:42 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-12-irogers@google.com>
Subject: [PATCH v11 11/35] perf jevents: Add context switch metrics for AMD
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

