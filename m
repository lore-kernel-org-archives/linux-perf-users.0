Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456F366053
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539553; cv=none; b=C+LKmU1zPyEw78pxwyXKcgWFTQYmr8oDJ7PNC8iCEWBABMUk7kTzXIW8Mt+xdXErHCPfrbXo89mKtfLXj8EdOsNl3Yjst5fz8k5l1aVxt9qjQrhFbJEs0VKGuaweC+yuAKIETIP5gHfo0qKuSmupUWt5rCn3Kfy9+ly2tPgdV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539553; c=relaxed/simple;
	bh=4pM2tdD652IcZD8wzPhrvfuqgRtHqz0V8U/ipI7rM2A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Cp1Rv+UTI3e3Z5ggTG5XNfjp5hAouS0W0Do2vjLAGiHxXJ4BMk2csp7kemjUirJkJvMtu59waii+Mg+7vgvdm2TrcRh2axpP3Fk+/Y32Dc8VNAEPjsg41zLTT6Yw7y/nEHUwkmZrHO40Hgy9+jxI0TAWMZzi16P4v+BNfdy38zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xx9+0cpc; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xx9+0cpc"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12339eea50bso4655053c88.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539551; x=1770144351; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4BlKuWwvBoHJMjQiget3mJt2hAfQGaEdqNx0fF+IWg=;
        b=xx9+0cpcybFvuLWoQT8RRfDhgaNlnOkwxZQjO50hEE6pDmLeqlT2hkHpJ3PDAQ4GXK
         EdSCFRp+CzQdcypJ3CPdQ9+SVHGbkiJlrIv6pchsbgiT/dCchGFPhKgRp/uXwPfA/o/A
         byiX9xc077ZWjDZG2KBwyeVpECV8arW/tNEJ7Zs+K5k3X3QKLSXijzybu8wtPzFNAeMY
         SuZ9j9JSwM7P57ZZ8eYZ9wS/Smiy9nVA5ZwhbQRUXotPZXNCJYtOTPochASkQnmfEQ5Q
         95ZV6GSZun4q684XZjbrUBCPwXuVmn46O+uJ4dZaSSl20nymbIUgPrUTeKQDvPseoc5M
         glQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539551; x=1770144351;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4BlKuWwvBoHJMjQiget3mJt2hAfQGaEdqNx0fF+IWg=;
        b=SOrfcX/M+q7Rlhi+PUbEKmat1UATItS3RJepJn5WV8hrvm6pBavgUfq8R2s29ZUVcf
         sIvydcN7WZEt7X0or0efQrIeVGNsRNEZG+LK+vyuYfTX1voJf/6h1Fuy2DsJBrI0Q5x8
         N/UfPxFRMfn8c44aJm8/ocdBTBpFvTQ/FZUx9kJcXUOx0BLnLRvIjU4ZHbRVOf3qkXrC
         4dWYH3rofFLVTQ9JUGkeFpJzPOMBptyYqxP+gMg2i9qZUslaEmZx64KarqalcfcJla+8
         n8HHovv6vbyyi+AhnpERogyf7yPhspTKWAtL8BkQzB8sN3TUOI5GZES484WGtDW6thAP
         XCTw==
X-Forwarded-Encrypted: i=1; AJvYcCXGlNwZITcFrVt08c85f6WLbWBzc2GT3+z2Baf5modfajSd5+30OBYrXoOndeDAxH3NbNVZJR/v6QdCMroCKEtq@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnSoHnDgi7A4wB958NGTFdlM5VUMWgUbfMypVBIq6ackys6qN
	o2WxmvgURDz4++j716F2d6HpKDCxpM04JyWvPmyQExMQaohqdqpM/5p6XFkhZ+zMeHF30nlnz5N
	hzBhukmtQqA==
X-Received: from dlbro6.prod.google.com ([2002:a05:7022:1586:b0:120:56a0:1dd9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:7a4:b0:11b:ceee:b78a
 with SMTP id a92af1059eb24-124a00aaff5mr1435298c88.19.1769539551401; Tue, 27
 Jan 2026 10:45:51 -0800 (PST)
Date: Tue, 27 Jan 2026 10:44:44 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-14-irogers@google.com>
Subject: [PATCH v11 13/35] perf jevents: Add idle metric for Intel models
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

Compute using the msr PMU the percentage of wallclock cycles where the
CPUs are in a low power state.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 61778deedfff..0cb7a38ad238 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -3,14 +3,25 @@
 import argparse
 import math
 import os
-from metric import (d_ratio, has_event, Event, JsonEncodeMetric, JsonEncodeMetricGroupDescriptions,
-                    LoadEvents, Metric, MetricGroup, Select)
+from metric import (d_ratio, has_event, max, Event, JsonEncodeMetric,
+                    JsonEncodeMetricGroupDescriptions, LoadEvents, Metric,
+                    MetricGroup, Select)
 
 # Global command line arguments.
 _args = None
 interval_sec = Event("duration_time")
 
 
+def Idle() -> Metric:
+    cyc = Event("msr/mperf/")
+    tsc = Event("msr/tsc/")
+    low = max(tsc - cyc, 0)
+    return Metric(
+        "lpm_idle",
+        "Percentage of total wallclock cycles where CPUs are in low power state (C1 or deeper sleep state)",
+        d_ratio(low, tsc), "100%")
+
+
 def Rapl() -> MetricGroup:
     """Processor power consumption estimate.
 
@@ -70,6 +81,7 @@ def main() -> None:
     LoadEvents(directory)
 
     all_metrics = MetricGroup("", [
+        Idle(),
         Rapl(),
     ])
 
-- 
2.52.0.457.g6b5491de43-goog

