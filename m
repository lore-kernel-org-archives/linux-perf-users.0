Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA122D77E6
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698068; cv=none; b=IwdipA+5SvsQYaxmXvJs4qdWUbApmqv3hyhXDYkY4eTBEEpChpM8P5xoCK/wKN6TR8/j77gQTaobw9ZdpiwDYGgINM090MMrVjt4I5rzyoaZnfWZrJbYjYQt6jhBabpGqPOeU0oTei+FxiqireKRXZXzK7NlqTQDC89WMDcqobI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698068; c=relaxed/simple;
	bh=CS2ZMaRbJhWfF7bNLWZEjxgq3mmQlSIBBEuf2yQ52wI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=my1wll+EpnmwqpJreY1jLH35dHR5mxx/4cOmboLd/zzltCnBMgKNCt76uQAIkeYmQHYKi1ZEOrnIR+lZHBolRCeBdT9lSVtJuGPqfzumij/X3Yjz4kZnTSDf8Ai7ueQ+C8ZZ/CRtKS++/2bR5e5nFnQOpthEnq/NdMnYETl72hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37kWGtrl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37kWGtrl"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b98e6ff908aso12796949a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698066; x=1765302866; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGt9xsDl5YoRAIdMUv0n8Pvx0khhF6N+ocxIu2eFpvY=;
        b=37kWGtrlFn88F1Qm4YmoTtpYR3yJce0AYRvzEvsNkYRwr0Idlzv6m0j2bh/kwQ+LSn
         ptIe7au7Nkyf3Jelwwaa1/LJJ5U15Dm95BcYKoU+6VOORlvuczqFhEH4LcM4dLOdnmOe
         PlHNuYH3Rbwyzki5oJeP0lHSnFUz4877Qemg/A5QAGQGyFzRn3sy2RcGYW4zPPDP2fdD
         eGxXg1grTWQ6U82V4FJANPNo2ZLJQeHKN4fKKpYsquWlgG4gYmemISo+DJd2SRk0T7Nb
         2eSEzEH5R8hU8J8/varmn71is0JjshBrlfenWzRlmzL6cIqsILWADrbZkSTGECNCGSF0
         ivDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698066; x=1765302866;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rGt9xsDl5YoRAIdMUv0n8Pvx0khhF6N+ocxIu2eFpvY=;
        b=uj3awyDigZ5ryvuhMC7REo0IX3Gl0AorrpOmRpsd9oSKdTYyORdrYQRRSoN1MXQ1PV
         BSOKYdOe/6gKOUdEg2Db6fsS2uhOMctv8DdRjXzpaI7/FpuGGKXL5LKTtmIsBd70b5se
         ggbKNlZqj+Vj4C3JboO6sew5repIP6pXCpMyvWrbRj8S6F9LdXOL5Jo7eY73BN3UQrI+
         JooUBRAyAA4ooFzX4lba3H3Innb/4j96YzFqLd1RbU4t9eKjfErNQIe0VI8hx9CzU4xq
         U9NJ83eLhCwYd/msc8GBr+yRcqVcEwPxg8LntKWy5sBQx/09rLGQ0SX2R+l1VzN5/m79
         i9og==
X-Forwarded-Encrypted: i=1; AJvYcCVIALKHfHqFgFUndC1jYXJOczPN4hjQdG6OB/theTQ4vx5zbZxQM8D7iCwb5e2S0myPh0Qw6Zmt22lJC7bBfJ1f@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuXLlex0J5Io/Unzdtp2MpuBVb2Z8LKvVDro0eELFlEEY45/1
	0WUpdFH0yx8DlL5oX9dkD/EeU/Hy92DACHD7h2xRZdP39NVQnZR5X6tc39IVVbLoaUW7bJiWiPI
	j4l3npEAywQ==
X-Google-Smtp-Source: AGHT+IGeYN+Qc8HA3vZjOx2MGc4XcApr9Hzd3h8nFVE0Uq3TdJp6PhDT6R18rr5i+3iYRrwYMGg+65AWO6po
X-Received: from dycqv12.prod.google.com ([2002:a05:7300:df4c:b0:2a4:6bb4:f498])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:3255:b0:2a4:3592:cf69
 with SMTP id 5a478bee46e88-2a9415ad281mr20729614eec.13.1764698066287; Tue, 02
 Dec 2025 09:54:26 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:36 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-42-irogers@google.com>
Subject: [PATCH v9 41/48] perf jevents: Add dir breakdown metrics for Intel
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

Breakdown directory hit, misses and requests. The implementation uses
the M2M and CHA PMUs present in server models broadwellde, broadwellx
cascadelakex, emeraldrapids, icelakex, sapphirerapids and skylakex.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
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
2.52.0.158.g65b55ccf14-goog

