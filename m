Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A7E38DC3
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 23:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CptAGb2x"
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC7F420F
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Nov 2023 15:28:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da07b5e6f75so2113449276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Nov 2023 15:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699572497; x=1700177297; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=va9PeSVkHZ3/T3gfCQBJuJqD+iAYQCCoTm/PqSXEj/U=;
        b=CptAGb2xtYIbOhsnfnTT99k6LHTV8rf402VjZrN4Uzgmc7LgWrA02oPpVsb6JJWaIP
         zAwxTTNbMHtkiIYx07gsLHjdH90iw2p5N2B8GvbuvXkp0EprJaLSuIWpnStUtXUr1VaZ
         P2yQhOTxfO/mUFzD2q2K08IzP3UJx+UBwNrACpx/XAsLvFb9JGebZOYibmHu+fbPn9uU
         BnoQHDzBsBYgHovllDsmkQZVTL9IZNV/qvcFgy5hpKtVYVzLAJoejESZarggcZ97vA6V
         fRBfAGRwscJuOw7b23A1EaeEXg9OvOTVxWkt+HP5yTu1X5qZQFb4w2I3lPyNJ8Wjcevs
         i/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572497; x=1700177297;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=va9PeSVkHZ3/T3gfCQBJuJqD+iAYQCCoTm/PqSXEj/U=;
        b=kJq/cd4vd4WxO6HcnKyQ+obKlT5LWFvz1XQMZRlrcFQbycXJYL6W4RLh+Ndd29N1oP
         MqrzUbmPZhIMiPb/5gVwHf6m2ZXoeoUtgz2Ysf7dzFH+X+g0+LFxz1rFhsnOdpNBTmH5
         9kPrqS1LlyTKtx92EyolHE8zaTHtcTJ/gILnmhqgex8PJBIowVAySOcsQjTZ0Ipls0Ds
         NXMDTnG2OUPQtVOew2NkR1iCRL+BBj+nSiNpa3p6SggAD2ruzxccXZSBbg6vmA4p51Ql
         oO8Fwq+8hrOcQTKSMKyCcIuimHhEJjFA6dRf/+bvoHnRh50EAJfFu2fxEO2WuaEj5aSq
         IseA==
X-Gm-Message-State: AOJu0YwSpjiNuWG+MTwKUJGKd5R4iOwpnkuJRNINLakNXc+tYOXK9KgQ
	seOM3y+szRI8qW9xamH0PgCoNH8sooWH
X-Google-Smtp-Source: AGHT+IGORyolPaDLwqvSKUqqw4W+HuVgJGBZQPOahnyRc3XRyRcCC27fSMmjbKSo4VVs17rwX2+VObQP5F1J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5f4b:1253:36b6:f990])
 (user=irogers job=sendgmr) by 2002:a25:80d4:0:b0:daf:1554:b89a with SMTP id
 c20-20020a2580d4000000b00daf1554b89amr23353ybm.2.1699572497553; Thu, 09 Nov
 2023 15:28:17 -0800 (PST)
Date: Thu,  9 Nov 2023 15:27:32 -0800
Message-Id: <20231109232732.2973015-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Subject: [PATCH v1] perf vendor events: Add skx, clx, icx and spr upi
 bandwidth metric
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add upi_data_receive_bw metric for skylakex, cascadelakex, icelakex
and sapphirerapids. The metric was added to perfmon metrics in:
https://github.com/intel/perfmon/pull/119

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 6 ++++++
 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json    | 6 ++++++
 .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json     | 6 ++++++
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json    | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
index 84c132af3dfa..8bc6c0707856 100644
--- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
@@ -1862,6 +1862,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
index e98602c66707..71d78a7841ea 100644
--- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -1846,6 +1846,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
index 06c6d67cb76b..e31a4aac9f20 100644
--- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
@@ -1964,6 +1964,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index 4a8f8eeb7525..ec3aa5ef00a3 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -1806,6 +1806,12 @@
         "MetricName": "uncore_frequency",
         "ScaleUnit": "1GHz"
     },
+    {
+        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data receive bandwidth (MB/sec)",
+        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
+        "MetricName": "upi_data_receive_bw",
+        "ScaleUnit": "1MB/s"
+    },
     {
         "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data transmit bandwidth (MB/sec)",
         "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / 1e6 / duration_time",
-- 
2.43.0.rc0.421.g78406f8d94-goog

