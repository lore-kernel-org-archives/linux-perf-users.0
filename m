Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED03370EC
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899549; cv=none; b=rr5NO5VXEwi6D39bACSyZKPBfETafuPDgf/vTiVdNBvEb2FtDrjCFRi8uw+92v9LVYSLvl/zaHXZ0OQrJ/7U4oAO1D44DWQ248khkCDitIWYfLJ+zmrayiZOcQPX/1tKGFkneXfQnfckC15KvkR1w1NsTQCPTQ4wzBw+/ndTrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899549; c=relaxed/simple;
	bh=M7A7ApF8aVAKAI09vVYWVhio9Nus+oQ+xkeCbrJDjVc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=MVrOH7PEwOAhe8RDuUkDYfC5Yev4qfTb7SuXHXAyc1F+TTp4igPE6Q1A+ycD3ZFTRGaYB1vGb0AaST44mfMQVd3r7WYfs+Fo+3+4SpTnWzSk6KI7VvS/BbvO8N4mTszx2swrJW4tN6Iw6eD7yTK1VB+3bazxBo3/xXiOw1NFL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWbrh5hA; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWbrh5hA"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-122008d48e5so1427376c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899546; x=1768504346; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O7CG6C6zIj+w7vvLfhwJEssyIpR+8clNxK6M46Vo0NQ=;
        b=mWbrh5hAGA6jUmXgV3B3hnuiGAhHazV6ZdoF2kq2JFIOGACrzoX4wZrWEi6FFUvaqv
         U+7rcdnjL81mDivLVTVZZkBFokpjgf38yOEI6j0vbXS3vE0NtHNP4qhNgvif25mLD+Kw
         g6duz2tVBf+9W7iJmNWxBpYKY7ShYdhSVfypLY0243UnV9aOFSC9EQuhOdkB579g53uJ
         9CqRleh7EsBRDCB1imi3J5eB+oTchRKFWk6nTf98M/+/tSZx7UoL0+JCZaRx9epWuQZq
         zUfOcikt9i2erRqgJ7X3rVQrtBbE/LOBLf5w9+OsC0+X8Kv2ezTZJC99yTmlGGIhtUuy
         Aopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899546; x=1768504346;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7CG6C6zIj+w7vvLfhwJEssyIpR+8clNxK6M46Vo0NQ=;
        b=hmAXetcDaypEZ+7JT8Jhg5BEajySwUmryubfmxfQg6twXRyOhhxcQie1q43ULipi0E
         6JtG2anPh/08IGU8kRleqFhcQY/Hx8u2KZCJYikalUA/07DTB2XJebD2l8D3fF779KEV
         hqRw2Agaq/3Lm8NM+X7PODl/jXUyS245Dt+DbaWihP2turiZkkm+yvYVknYTbE9K68UL
         WxjTfSavXT1FEeLMSjRmosnU/rHRw7VJQDQN1vdvc17qAOPJP/xykbydVBsGMNGlT7qI
         bS38icYSc1aas8IxWeG18eurvmGzUE8o4O5aWSRrd3EcjIIcEKnRHq1iAzD7Vm4JD/GN
         lLUw==
X-Forwarded-Encrypted: i=1; AJvYcCVXdNYdtC02rN0JOiuKv766M7mzhpnb1PrQy0NGLFfkGwZF3VdicO9oD5xlYFMdYMM8QP7wYa4ruhx8SV+xmFwu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0fJ06G5dAEawhCEXVQoTIZNouopEO4skJqUaOn0CoKbFW3dsc
	uKtPX/b4xoS3iP+DDKS4v2CHRIitYFkf6aSAuBZWwplY+zuyevfN/11h1NBzuq4OlNRXrUqZyLu
	lRPkG8SadDA==
X-Google-Smtp-Source: AGHT+IHW8rJELnJiguAxNE3b+MLwN6D7t5G6UVdNkhb1HsY9JfLrnAjjNmW4ZmR6/GozrxXTwEqyHEMiWaw2
X-Received: from dlbbt18.prod.google.com ([2002:a05:7022:992:b0:11a:1004:5049])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6723:b0:121:a01a:85d8
 with SMTP id a92af1059eb24-121f8b9cf5cmr6434656c88.45.1767899546120; Thu, 08
 Jan 2026 11:12:26 -0800 (PST)
Date: Thu,  8 Jan 2026 11:11:02 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-33-irogers@google.com>
Subject: [PATCH v10 32/35] perf jevents: Add upi_bw metric for Intel
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

