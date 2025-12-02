Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C15E2E6CA7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698076; cv=none; b=k6rCSmdsXiZ0+LyDk2YkpPebUn7T11RTbvAto2LhOKx5eN4T7x+K+9C/eHjAuyn3w5hrZudmV7bpUZkWBTDx9qBNM6ZicfZfjZXJv11jRooY756E/BZIr8XuyQl7HPlWetqNUNqsQwQAISnMEpuB+89NMpIfhghr1431cIg2/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698076; c=relaxed/simple;
	bh=EDGM2z+qBp1q2w0GbJXx4pSB8/TSL6GFcFldbQY99tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=mYMkw8X3U/+JpEcdR9eLLHHU7oHbbz2OM2X+hZGfhvIt4w5p7aJVN08kgv8cXYS+ZDszRO5hAU6HvqAG6UQJs0rBSemZCSyTE+aaSu+4hrmNSrBrGfOWugTymNhHCVYL7Z/idS7IdQUuhsXBWWlQ2PmlKuDOM0uSCDHD+9YhYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZ5iuxHL; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZ5iuxHL"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so6469246a12.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698073; x=1765302873; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KswLRccZpd26vUqLWsUS0ORAcRxMs+DDS5zPMjce1gc=;
        b=aZ5iuxHLY/cDYbOdVw1VOskoJ7JwyETMLM25oJuMYH7idNX2j9rnIA9x0s+W5G69xH
         IrilQeY+OxYUMx63l4A01sXWhouiGP8YtF/KY16qotIIxBNI+DStg4PlMXuYgghg3q+R
         HbXlYsUSFNpj+IQNUJ8uSXePRGRzEav/irSxOh8gFOVJbU9OZRLJ/z0nlAVTyC83qlth
         Io1HH02o55rCv67gUcZdoLZErhYkqLpjB/OTLxOvEKmOaxTNK7ac4l5q47VqlMjTRMSg
         yiTd3mlzB/cKCPVX4tscVQd5vqBpujdJ4ZG9RSKYrZ1035/BsJtS29/cWIYVKzN3SkOE
         7L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698073; x=1765302873;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KswLRccZpd26vUqLWsUS0ORAcRxMs+DDS5zPMjce1gc=;
        b=af923CnPyVc2TeodwlSkHFmdypMKsnuJjg7doGZbP51OcuJpFz/WNgrIebajGIrPwK
         YWSN9S0lj0SEgN5Byy+iTc5r84pUniM1Ea7Jbp0LSA2/ocXV4AQleeKq0WmZY5RzS8XJ
         HWiMs+rSLZuAQ67erElx8CW+i2PjtwS+UhzUY/na6d6RAbiGKSFzn98NgkLpPtLYoCK7
         MRqE0KU3WkCxKsP7SDuUqa/3YU3jIrBmQkmWsx1xf1UKWrrb80w1vUDN9Jzqne74wD1Z
         jwywW2puWg5m2a4RhggUUgzo9hHi/uESxHM6vGWc+pqo8QQwUmJWU+W/tFpeITLBv9Vo
         Xfug==
X-Forwarded-Encrypted: i=1; AJvYcCX6ohcz78E7ed3HXe4aTeBnWfMYQIbTRWkNi2AythccF++wDJ0F4Ky10wAIUyOO5lv7yYgaUNF2SV3h3pKBYnZe@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77YySZ974o8W9qOG5RoIrSVhnsppyu5Kj7wsJ20yxIWqg4gYE
	JpSLebDhE6ghWV7kEGhx3GJisvEraaROFPGdLbLdu8D0r8uJnDyA481yNQrjwM4I4yR2tRK0XPE
	sJKfqgcxYSw==
X-Google-Smtp-Source: AGHT+IFRjr6V567u4OtyeXwh6GCPTBOxPtGAe/umVk3ADQxbt/OF11hhZNc77wUsCuHmpDrxki1hBqeack/0
X-Received: from dlqq34.prod.google.com ([2002:a05:7022:63a2:b0:119:49ca:6b8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f00b:b0:11b:ceee:a49f
 with SMTP id a92af1059eb24-11defc9e629mr200899c88.8.1764698073448; Tue, 02
 Dec 2025 09:54:33 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:39 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-45-irogers@google.com>
Subject: [PATCH v9 44/48] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 037f9b2ea1b6..f6bb691dc5bb 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -1033,6 +1033,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
     ], description="Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+    try:
+        upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+        upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+    except:
+        return None
+
+    upi_total = upi_rds + upi_wrs
+
+    # From "Uncore Performance Monitoring": When measuring the amount of
+    # bandwidth consumed by transmission of the data (i.e. NOT including
+    # the header), it should be .ALL_DATA / 9 * 64B.
+    scale = (64 / 9) / 1_000_000
+    return MetricGroup("lpm_upi_bw", [
+        Metric("lpm_upi_bw_read", "UPI read bandwidth",
+               d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+        Metric("lpm_upi_bw_write", "DDR memory write bandwidth",
+               d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+    ], description="UPI Bandwidth")
+
+
 def main() -> None:
     global _args
 
@@ -1076,6 +1097,7 @@ def main() -> None:
         UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
+        UncoreUpiBw(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

