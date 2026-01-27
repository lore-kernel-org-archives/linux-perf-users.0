Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF236C0A3
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539589; cv=none; b=JKfASekU0anXGPDNfvjg/CVw0FQh0vcVVxHx7MwH/1FcdNHqGWjfoWr63HCEn92HQEQC6NZkRDfTCcHXEps4prkpzDNqT5/jXEtHiiDp6oBKMpJMc8g9Uqut5+x3h7hfcPqISq1ooKYDD0IskyxSMPhc0fjeX/NL1gykGImFhbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539589; c=relaxed/simple;
	bh=M7A7ApF8aVAKAI09vVYWVhio9Nus+oQ+xkeCbrJDjVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eFfRMJnVJ/sLrCsce8j54V5MVWR2Ti+nIK8SIlqbvnK1WU7aosZGrz1fVkRLr60Faijekt4YWGArsBOc+w9kEG32QCj2ciw1C16TS4PwajU0FU9qvxpXq3FLfLsoVxE8kVRYQSNqXcXcKrAhGx1DyXNQ7bwkWcMQnrvSsm/paQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZs/nFlB; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZs/nFlB"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b70d8095daso5754547eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539587; x=1770144387; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7CG6C6zIj+w7vvLfhwJEssyIpR+8clNxK6M46Vo0NQ=;
        b=rZs/nFlBQ+EPI/3hSOaSXzbLUPWKq43z/0IwXH9yDH57kTQjwegzem0ufJswdCgVCB
         zukZG6PDMOvdc5P0gA/5TmcrrVXdAZ1QcliVBuBL8tnJoogHR466h54uFPhKRjsdTvhM
         7wxZPlVQKhcPAO3VzgOlPLUDI6JxkFvzIsrhHZOzNRlmUbsxyjGJs2YlFOsVQ1SJOYAG
         YAYYMJKrZfx7Q7DvtBpCwWl7aAO+M84j5t2AH0SjbPi4SbYZD5tkPwIeav78AMqHRQAY
         CARKhd3moTLcqhHfbP88onBk7IxWfgqQM/N7PbSWVrSpmx1WmFmILZtvfS5XgjmOshBy
         lfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539587; x=1770144387;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7CG6C6zIj+w7vvLfhwJEssyIpR+8clNxK6M46Vo0NQ=;
        b=BFR3sgYlkYJj1iInv7aUc5Vx3+qpxRK4m1dB+ri4CghvfxKRr+DgwwvXruSCPK9mw9
         1cJONXyrsDmEQ8TuhMKqThoIY2hjBogRfTuhd6tYQdkuZNGN454vT0iqYNsIWD2qZnTl
         ZT93WWX1ZN53YgwxrXm+B+cPCga6lg/AJBkMsgURJOhgPXJL8WzMR262+H4n4FLcAY/p
         j8uk+iX2t8RTM7REy5cQkS/jii6TBt4UXBhzxNAK0uOMH2oCSlI4rCqowIz5Q+9PGyn9
         +rt7OcJJZ9VFJCjze2zGfj2+1Odnd/xeCDvhvrbQYHYGgcJCwSS6nXiMOKq+m2embeHp
         sDTw==
X-Forwarded-Encrypted: i=1; AJvYcCUt3FKFNpFjnOSTqifQPX/wE8S4EFEfqgQ7FZFvFrwsFbrd0pwcjyspnZhAuxrDHhLaopJEBvKBfU4xkkL4oTNG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vU0XsTwlmVwdKfYLKMHvr+/6ssxTpR+NqIq9wDycFMF0ktCB
	dTpVNpfqonNbdsZKRSyQuXFT3zieI2Nz5LXUCvemduiGJhla3XNige4dMM2SY5zOl2DEIcJtVa8
	JAv4QcwAANQ==
X-Received: from dybcn12.prod.google.com ([2002:a05:7300:a90c:b0:2b7:4088:aeb5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:1486:b0:2b7:4129:fe9e
 with SMTP id 5a478bee46e88-2b78da4a100mr1719612eec.34.1769539587197; Tue, 27
 Jan 2026 10:46:27 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:03 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-33-irogers@google.com>
Subject: [PATCH v11 32/35] perf jevents: Add upi_bw metric for Intel
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

Break down UPI read and write bandwidth using uncore_upi counters.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
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
2.52.0.457.g6b5491de43-goog

