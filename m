Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED0369239
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539580; cv=none; b=PnvgmHDQ5xQVfqwlsTHQ52z/PGhlrXtGeoFeipeHJLQuji7QuHJmvVxcTor5RlH3YMWqgpmpVPsb5mI9RIR0Xhxq2PGIlFaFdx8ZG+dY+WLecucuvf0spHcLwaD8kc27Z+a0TYnXMeCtm6oPgua+u37O4DzenrQ2Ni9TaDxCW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539580; c=relaxed/simple;
	bh=2jmqKph2zPBaDCiirJx0Zuul8V+Id9CgYa/L0xXNrec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=O1q/XmJw6cB8lEV3yAqYPTMHazJkt5Mp+cy44kryp0HMdTJI2tYRC1Zv6Y9rRXhVxwPB9r4ahCThKIJvHSCaxYSVhs0Oci3IRYO6fSSptDSoxUFvQZ5IUwXQduD5LR8mzZe9o1jldlAzlSM4zaR8gILK7C6XpjyM9pn628n0FKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxpI3PI6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxpI3PI6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso11402585eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539578; x=1770144378; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJoyN8MzitpnRKNksQbC+dtWJQHWKeGHeklIvOG/ru4=;
        b=XxpI3PI6CSWhaskHPnx3oXUTHjY9gIyU0JGeOihV+xKlOMhtNkQMrz5HMEExaA9ml0
         JkaLL3DQGRfO/x7E8EFgCJe7rN0NsPF5EyyrPtIOFa+iOoe2VeatLHFNhwJOo3ik1uq1
         u3RHKfob7QZvaq0wJwjvkkw6/R44f5lGIK7osOEqkxz0ubzPcI11RCdy4zelO5T8kBns
         b71x2b+rtA+pz1PC5LPpmyANksb4/ENF/3BITru3azqnqzyWwPhX9Sol8ijysclxW9Z+
         Ot+Suh3dfhvVDcXLhUaSR7qWh60VR5vlIBK/03KxqEcaRzKb3CSVjwtpFuNbspLDa8I5
         vkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539578; x=1770144378;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJoyN8MzitpnRKNksQbC+dtWJQHWKeGHeklIvOG/ru4=;
        b=s/yflzBvMHQ4aiiVb2SaAyK02WJmpg/w2eHN9DNXHu3/7wuBGCBd2bx1rHRr22o8Uk
         oe7Ul0JvuDKx6ZUn58g7UBi9/HHXyrblAeaXU8Xy506+aZPDy0SV+LTgOzEPUR5XKi9s
         6Uy8FAJn+XtgJUsgL2NJIQefdfqKk+1u3i7mc9iJoLraz8qpVpXZkuc3f++ssqsHCD6A
         ucIKyJRUF2WnV3yPysU1Qao9Z6BPOfaUC/STXLDkdweQAYTWb9tB7rQZwlEYYUsLyEY6
         gWstnocxpbrKQSs8bvxQ63tDDReXLHmOXuiwRZnkhOY8MhyrS+FY5IZctx61YqvVujTq
         Mn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqfWmlDxY7wTFJCtyRZ6Z0y+aV85xz0KqDFEirp/yZIgrGPI0qRFVMLS/6B2CeksMkR6Qzw3FWDBMQWhNNXpfY@vger.kernel.org
X-Gm-Message-State: AOJu0YwewZQlyOHjSv2jcvcUAmkDbzgEih391auDb0859ECfDZgzjD7N
	WgcBShP/XFFFpkjgpXblkPqMzCuy9gsicMvfrxAs3ZBf7ZYiHXAd+l4ML3PmSAG550ZXe85j0Pw
	fkBnAJy4HFw==
X-Received: from dyw2.prod.google.com ([2002:a05:7300:8802:b0:2a2:4eb1:3771])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:7018:b0:2b7:2a17:af34
 with SMTP id 5a478bee46e88-2b78d9f1bdemr1836844eec.23.1769539578354; Tue, 27
 Jan 2026 10:46:18 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:58 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-28-irogers@google.com>
Subject: [PATCH v11 27/35] perf jevents: Add mem_bw metric for Intel
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

Break down memory bandwidth using uncore counters. For many models
this matches the memory_bandwidth_* metrics, but these metrics aren't
made available on all models. Add support for free running counters.
Query the event json when determining which what events/counters are
available.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dddeae35e4b4..f671d6e4fd67 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,67 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreMemBw() -> Optional[MetricGroup]:
+    mem_events = []
+    try:
+        mem_events = json.load(open(f"{os.path.dirname(os.path.realpath(__file__))}"
+                                    f"/arch/x86/{args.model}/uncore-memory.json"))
+    except:
+        pass
+
+    ddr_rds = 0
+    ddr_wrs = 0
+    ddr_total = 0
+    for x in mem_events:
+        if "EventName" in x:
+            name = x["EventName"]
+            if re.search("^UNC_MC[0-9]+_RDCAS_COUNT_FREERUN", name):
+                ddr_rds += Event(name)
+            elif re.search("^UNC_MC[0-9]+_WRCAS_COUNT_FREERUN", name):
+                ddr_wrs += Event(name)
+            # elif re.search("^UNC_MC[0-9]+_TOTAL_REQCOUNT_FREERUN", name):
+            #  ddr_total += Event(name)
+
+    if ddr_rds == 0:
+        try:
+            ddr_rds = Event("UNC_M_CAS_COUNT.RD")
+            ddr_wrs = Event("UNC_M_CAS_COUNT.WR")
+        except:
+            return None
+
+    ddr_total = ddr_rds + ddr_wrs
+
+    pmm_rds = 0
+    pmm_wrs = 0
+    try:
+        pmm_rds = Event("UNC_M_PMM_RPQ_INSERTS")
+        pmm_wrs = Event("UNC_M_PMM_WPQ_INSERTS")
+    except:
+        pass
+
+    pmm_total = pmm_rds + pmm_wrs
+
+    scale = 64 / 1_000_000
+    return MetricGroup("lpm_mem_bw", [
+        MetricGroup("lpm_mem_bw_ddr", [
+            Metric("lpm_mem_bw_ddr_read", "DDR memory read bandwidth",
+                   d_ratio(ddr_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_write", "DDR memory write bandwidth",
+                   d_ratio(ddr_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_ddr_total", "DDR memory write bandwidth",
+                   d_ratio(ddr_total, interval_sec), f"{scale}MB/s"),
+        ], description="DDR Memory Bandwidth"),
+        MetricGroup("lpm_mem_bw_pmm", [
+            Metric("lpm_mem_bw_pmm_read", "PMM memory read bandwidth",
+                   d_ratio(pmm_rds, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_write", "PMM memory write bandwidth",
+                   d_ratio(pmm_wrs, interval_sec), f"{scale}MB/s"),
+            Metric("lpm_mem_bw_pmm_total", "PMM memory write bandwidth",
+                   d_ratio(pmm_total, interval_sec), f"{scale}MB/s"),
+        ], description="PMM Memory Bandwidth") if pmm_rds != 0 else None,
+    ], description="Memory Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -853,6 +914,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreMemBw(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

