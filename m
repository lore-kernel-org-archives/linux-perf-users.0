Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFD431A576
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004136; cv=none; b=rKa4QJOzoOvJMmbLW6PI85wiQ+qf+5YYgVmealMp1AIwRKwiuLGMaJWP2u9SsrNhXWBKZOP1QX8yE0+9nl/NvNUdW+Wk+rPEhILjAx2hn2ssdqqhw8gp50/iVTGy8H+O6FrGOCaHBLw8Qxahx+vFqF2/OIvrJhwwdSaBMC6vUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004136; c=relaxed/simple;
	bh=aof78n+qXDg0c8e2xLQ6nv2btzFyt+M0yFV/x/avhsI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=M5GEITZlcCmdv4kiEJWmnLw+u/8hKLwdPgdJQZ6DIrgf+7fZFUNj+K0h+F+7YJ+8sN4PTeHHNdnia3GugpOxxAacH4TUNXGRLR+59ZmN04+5zpaWT80i+Ecat1I/kV2XiuCcLyxQ2XcHVteTlpjv2+zJP5A0ZsILA9asU+Bb2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3kp4QsgX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3kp4QsgX"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2958a134514so4595945ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004134; x=1763608934; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rc3vNPxf2jUSlVFOyC9V3KttOj9emUQIRVikRtApQE=;
        b=3kp4QsgXV7mEsH7lDBZ/7gcrjbG9w7gFU2F5KOw8z8ivkm3n+O7ANmNE3hrTiUD/FC
         Hh36SP2MGP8QuKWCaw0vcwuexj+/BqsR556Pb+oEuN/2h+/SaRoUrjhsIW0lIXPXpaC4
         L/ApiFct/1z+1JZIEIwVHXf1x/M1kV6CBKyheiljGKYzLMf6UPSvHxacGR0zDl074JGG
         j+zrwRcLuEJrgrm+Y3UANxfPklCQE1cbWz6CMjuExI5w7Eh2amwfjyDl4JXvKOLLL9f4
         WFpRUVJNQhmWxucIY40ivDip3EgOK1N9jSzVweB+x420Dvnbx6Bk7lRyl3QG6gLWfkxH
         YeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004134; x=1763608934;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rc3vNPxf2jUSlVFOyC9V3KttOj9emUQIRVikRtApQE=;
        b=w02kzLAagr5QC7QfIBVf8De03GiNxW8Qievh4v/EWSLA+nDWP48BcCW4jPTwHGEZ9C
         QYSLCWWGKO0kTJxyFd9pIaaV+2lmaMyfn2plupHuANftnCrK22+m4z/j9JCDnNVsq60x
         btme6QuQCojL1vx4F881+05uVDeiKEbpZ8cbU0kuOwJJVBfaYn2Yjs1tT9I6ZA3Hn9bh
         Cdq4FJ/hQiL/O0S9cSf2VDWJlCpE3Ytu3zIS492Ev/0DdMDVSA6YoHBBdypwqR45RJ5a
         u6cVE5KFtMcu3qCBBt/7ZOzAE6H3Z++5sac9FJrzcKfhOW6Sh8+2MkOENOo9Ak7BxCIf
         cfKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD6CjxZTDLUPNiAn87uYWBN2cwQ0KxG/ZDBSBjovZmdPGt+40C8i/oGOojz7hzdLvIp+j2um54mJjugSUm+yF/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrl1UujvpKD3lT8HJlJcjrJl1vdewQjRLAUuHmSZpUY8IJvJ09
	lsw5W23FPqdYBWH+yiIL+90gE0Tu4llqNh//DHBxlnlN96/dlOkJvD2nriKDPixkk23ZwWnZ/RV
	HVRzAEGOQfw==
X-Google-Smtp-Source: AGHT+IG451KaGljKW2LZv3uhYjbm+8KjnbK7p3zGZIkXlmpEzkSU86j96z3iWIVFLyDJsjPJwDfCrT09VOAG
X-Received: from dybqf8.prod.google.com ([2002:a05:7301:6488:b0:2a4:8a9d:ddc9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:19d0:b0:298:1013:9d11
 with SMTP id d9443c01a7336-2984ee0354emr68940195ad.43.1763004134472; Wed, 12
 Nov 2025 19:22:14 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:30 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-43-irogers@google.com>
Subject: [PATCH v8 42/52] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 77b8e10194db..dddeae35e4b4 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -624,6 +624,20 @@ def IntelL2() -> Optional[MetricGroup]:
     ], description="L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+    try:
+        l1d = Event("L1D_PEND_MISS.PENDING")
+        l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+    except:
+        return None
+
+    l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+    ml = d_ratio(l1d, l1dc)
+    return Metric("lpm_mlp",
+                  "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                  ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
     pipeline_events = json.load(
         open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
@@ -836,6 +850,7 @@ def main() -> None:
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
+        IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
     ])
-- 
2.51.2.1041.gc1ab5b90ca-goog

