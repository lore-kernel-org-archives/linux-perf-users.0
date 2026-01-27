Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0036B045
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769539584; cv=none; b=CMN5XbPy3m6KCqpPItLnu+0FUjhqJXwufjtqK7hBgOwpc1Ko/bmStCJmhkVA7Xcojs8oIZROEBxD4zsy531K3M01LJPUlNWItdzt8FUddFK31sKKqOofwT3GqnWUbPOunRdFJvshZ3NKDRilEAJ9TaUV4onnMqvW45/M+GbxVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769539584; c=relaxed/simple;
	bh=Sr+0utK0tNOs2nzfxd6UaoFEVfN9d6C1I9sdXtbKpqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=il8raAKCQ9iZ12RRrg45Vk5a2YmNSAF6spBU0LhWY90kWV1+eH/YqR6LUzfKoelRkXKyfqA/Uth4DzOBIEP8r0omfBxndmrIR2l2V6wl7fqrWdAduIxl9enryapEJYRrPzgxJsOB8oJJcCgLNfwQHEygkpMeTMTpT8dV5zVUkEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p1orKiuM; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p1orKiuM"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1248da4d2d6so4567575c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 10:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769539582; x=1770144382; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAo1MILhGnqZNbLlgKzWKgNCypTb5sxkZ5UVUsguhwU=;
        b=p1orKiuMg5IvS5tFwcqxkK7NDMuV45sYyxxczAQZUHy58nE3cS6RswXrObYTAsO62x
         A8YQ0fCHuOyU84dsuXTIMZlYZyQqkVWoLkuENjOrH3Ans8pj45wd3BsqW31ciEqMuxX/
         +cAXAy0zmwNRY3PLQc7RHHVu8OhSOx4SCmlZET35zl8Fw5vkzJMagH6TH7/JR1b4NgR9
         OMBd5OItFVUoA73uPARJ+OdLkKFIPledCVzx8vyIcl1isbANBwtMARD7SnVYFQqVjNRG
         oikayJug/2cgtoEd6oPdQ3Wr1uFLxXy5yWjkcNW/zWqyW7uFbV1rx5QVLArg5TLnEPYD
         dAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769539582; x=1770144382;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAo1MILhGnqZNbLlgKzWKgNCypTb5sxkZ5UVUsguhwU=;
        b=oLc4WXhK3D52cc7eyqCKFYAuuQnDIkNTJ3wz3WB1hrQHLLqWV6xynIYkpVTLzw90/A
         ieonOcCoLpmyV1T0S2G6gTE+fBAMgbgK6/bWB0mE8HHMsyMs01KRoN9KwXEeF1GAnJur
         lBVDT//pHyK+VIwE9njGi/IollbiHinUU3qxPHjQWr26QXEJHRK60dlWYBeHXykIaHRk
         obfx0+K8AUI5hoX9bHJo7a+i8Uwx5JUQGuMG4Zk9zfPas/bRJxJna3ZuIp1GOpg7G2Zw
         Lz75Jesjziuh0+/QrQrkWEobxxYaP3d0Zir+4l8m5or23O4xlztoNDE0yWcWyZE2/QXW
         jb8A==
X-Forwarded-Encrypted: i=1; AJvYcCVkUogIfkcslnD8p75Ey0yf2YRE151K9s71GMyxuH0yWoqxMEQjxyta2h5D4xd3sI/JsY7D65ref1MA3C0tv2bc@vger.kernel.org
X-Gm-Message-State: AOJu0YyXyZvvM+9g901K6MJ0UBS5O+jr00wjrrTJpltyhW5ziRB9LPg1
	2ocUAiwPvbT8QRUVaESRbz9f5dnmUc5QEb4L+OQLlKHzmptXNiyzib3ROfbd2jVSnjtfl3Ae7h3
	U0o8bRQ/T6g==
X-Received: from dlbcf3.prod.google.com ([2002:a05:7022:4583:b0:123:12b9:c4e5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128c:b0:123:361e:e87c
 with SMTP id a92af1059eb24-124a0098f90mr1789109c88.11.1769539581994; Tue, 27
 Jan 2026 10:46:21 -0800 (PST)
Date: Tue, 27 Jan 2026 10:45:00 -0800
In-Reply-To: <20260127184506.3059493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260127184506.3059493-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260127184506.3059493-30-irogers@google.com>
Subject: [PATCH v11 29/35] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 36 ++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 983e5021f3d3..24ceb7f8719b 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -815,6 +815,41 @@ def IntelLdSt() -> Optional[MetricGroup]:
     ], description="Breakdown of load/store instructions")
 
 
+def UncoreDir() -> Optional[MetricGroup]:
+    try:
+        m2m_upd = Event("UNC_M2M_DIRECTORY_UPDATE.ANY")
+        m2m_hits = Event("UNC_M2M_DIRECTORY_HIT.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_hits.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_HIT.ANY/"
+        m2m_miss = Event("UNC_M2M_DIRECTORY_MISS.DIRTY_I")
+        # Turn the umask into a ANY rather than DIRTY_I filter.
+        m2m_miss.name += "/umask=0xFF,name=UNC_M2M_DIRECTORY_MISS.ANY/"
+        cha_upd = Event("UNC_CHA_DIR_UPDATE.HA")
+        # Turn the umask into a ANY rather than HA filter.
+        cha_upd.name += "/umask=3,name=UNC_CHA_DIR_UPDATE.ANY/"
+    except:
+        return None
+
+    m2m_total = m2m_hits + m2m_miss
+    upd = m2m_upd + cha_upd  # in cache lines
+    upd_r = upd / interval_sec
+    look_r = m2m_total / interval_sec
+
+    scale = 64 / 1_000_000  # Cache lines to MB
+    return MetricGroup("lpm_dir", [
+        Metric("lpm_dir_lookup_rate", "",
+               d_ratio(m2m_total, interval_sec), "requests/s"),
+        Metric("lpm_dir_lookup_hits", "",
+               d_ratio(m2m_hits, m2m_total), "100%"),
+        Metric("lpm_dir_lookup_misses", "",
+               d_ratio(m2m_miss, m2m_total), "100%"),
+        Metric("lpm_dir_update_requests", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), "requests/s"),
+        Metric("lpm_dir_update_bw", "",
+               d_ratio(m2m_upd + cha_upd, interval_sec), f"{scale}MB/s"),
+    ])
+
+
 def UncoreMem() -> Optional[MetricGroup]:
     try:
         loc_rds = Event("UNC_CHA_REQUESTS.READS_LOCAL",
@@ -944,6 +979,7 @@ def main() -> None:
         IntelMlp(),
         IntelPorts(),
         IntelSwpf(),
+        UncoreDir(),
         UncoreMem(),
         UncoreMemBw(),
     ])
-- 
2.52.0.457.g6b5491de43-goog

