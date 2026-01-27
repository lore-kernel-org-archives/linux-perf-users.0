Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F545363C64
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539545; cv=none; b=P/TDam1GUqN/3fTbRzDyllACxUwdatekFQB3ze2LjcWoWvQg7fxDW7B6XTxbwKCLBFy0eSXmld6LYiVkf2ySU8F4qZI/IfLH67VgCrPcaFCyR+26rAufjPVTKxpbkDeXVJA8KuqvpErKsJeX7yTt/ZenwYQAPIq9HDp6Ce5uu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539545; c=relaxed/simple;
	bh=ARE/Q2G89TxiCVGgVTApgtKtNEltPTE3mlntYnL0UpU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=dDo5EY92kgUqlhOUf4vdc+YcekHLRGfakxtWv1NVa1UEm3jzq1B0dbsuLvR0AI9zsPd6rC84CYBFd8l56xYuRFFMXkCOGDxga7S5v0DfXEdaMCL1A28dMEflUcxwvuhjAVD2gNg6rjGevPaTB0wQ/Dq5ADx52kAvhnrnbbI+CGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MyVTYlL/; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MyVTYlL/"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124743cf760so5119639c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539544; x=1770144344; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rblm5KSHXE6JkXlIc70Vz9oUvY6uCMkftvfXFaxGDFo=;
        b=MyVTYlL/+Fqcf0w00vM5y6BZElb4ZLzxGYPtjg5KCi96fzVtChKrKkeb9LQiBNaZkT
         zVi/9FO5xm2d4Ao1sdxu1UU0iTG4cOmfWXlR1iR4nVCL6VrhUmVE9XDtcOyLgjK1mGqp
         Rm9UiMjA6T7GKaWpTRnvpjPO/BbtYBGBUQ8Ovw/+eca1Jn2BHzBYVn+HIhWLsJqnruNO
         hczLa/P9j8XOk+TUDkVdloVDMEm8hN8xMpZPri+euaVSYjcr1nQnB650dhgC/eEGpXl8
         xe7NkNIaqYTQAAmQuiIlqysUdMRkF6kU4R8amdr5v5DWk1dVWorAXqVp+WgdREd+OMWG
         0lSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539544; x=1770144344;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rblm5KSHXE6JkXlIc70Vz9oUvY6uCMkftvfXFaxGDFo=;
        b=jCywcGzceBECF7GyQGo2GDGgofNmlE/W1UVL+yzzTKSQ5Pk+liXEzoazFQccVhX7RJ
         p9K8F31tgUdmSHsMwFADx9Q/6+8y97rjyN8Sl1biU3+v31ons8mCDqkpFS7nbndVEWoE
         59A4/P95bFG1LZRqmqGCwRz6XXZr/ygqcA0LhThW21OrQJyFqVt1RckIoipUx3HgMopG
         bv1op2gAdQjilnrxVcu72P0kauwnyh+jQsJM2GCU/ycInpx16Lv+cHZjvgpzVpNDaP7k
         gzPhiViNePH6e5uSEP7w7DqWw3ytTrXFWxjf6R84ynLhN4ArJBClZSVhXVYzu7f7F0KN
         DaqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR9HyZWCwIVkCMrNXqwmmyhwl9RHnS51CSWLlZAS7KNQzYWocyzP0zQX0mEakVuhRGYKKnnCjIned7pwI99aOy@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+bL095joy2Re3Yw0can4MysPCtk7wxIia4ItQALQABklweAM
	MkZS/d2mmclbf0D6d1h+QoQVJ7ERhW+B+eUXfu3HvBCWagPLb/mN91EUGG4q/R6rvM1pS8kQ9Xj
	UyeUMbt+mDQ==
X-Received: from dlg25.prod.google.com ([2002:a05:7022:799:b0:124:9b94:b216])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6082:b0:119:e56b:c762
 with SMTP id a92af1059eb24-124a00df67fmr1555629c88.39.1769539543549; Tue, 27
 Jan 2026 10:45:43 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:40 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-10-irogers@google.com>
Subject: [PATCH v11 09/35] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index a4ff88de08b5..d71997177239 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -317,6 +317,24 @@ def Rapl() -> MetricGroup:
                        description="Processor socket power consumption estimates")
 
 
+def UncoreL3():
+    acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+                "l3_lookup_state.all_l3_req_typs")
+    miss = Event("l3_lookup_state.l3_miss",
+                 "l3_comb_clstr_state.request_miss")
+    acc = max(acc, miss)
+    hits = acc - miss
+
+    return MetricGroup("lpm_l3", [
+        Metric("lpm_l3_accesses", "L3 victim cache accesses",
+               d_ratio(acc, interval_sec), "accesses/sec"),
+        Metric("lpm_l3_hits", "L3 victim cache hit rate",
+               d_ratio(hits, acc), "100%"),
+        Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+               "100%"),
+    ], description="L3 cache breakdown per CCX")
+
+
 def main() -> None:
     global _args
     global _zen_model
@@ -351,6 +369,7 @@ def main() -> None:
         AmdUpc(),
         Idle(),
         Rapl(),
+        UncoreL3(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

