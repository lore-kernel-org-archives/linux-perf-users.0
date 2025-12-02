Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FED22DF3E7
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698056; cv=none; b=X5s8shrmU+c5YHjvHSPzFLxHkbHs4NHn549O5uqYj20MScbRpdix6JzlArW/YMxEfSCbfSEYMv72KOSrbaZVm9/zUC5KoAsAq5WznBgEHFHQOx4FZsDQdTVsAvd5MQrusGFqKQ8iCVb93zPH6g7eCbYdyzBxPzpGdEQYy1O+kDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698056; c=relaxed/simple;
	bh=/GIlef2EyZC6a9RRSOQMmBeM8UDXPXroHzFTd4A7XFs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sElUbXZTxPCJm1yAOO7J0Nznz2r3im8j/d9mO31STXYj5qviCnsOhsqk88CyoUvo+21MfCqpyydsR/P3UhyaVRMyXMfHLdqvuIPPIhDKsrnyYid8tw8k/Y7QGtmr1IO9koJ5v3fA8gb/KPvkdM16rh8Z2pi0IiuaRezXBFwP7ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f9EF33ct; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9EF33ct"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ba265ee0e34so5407300a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698054; x=1765302854; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkVu8b5ZXOgCEiRhWzvnOPQSP9ZYLvl9DnUVKbBmwB4=;
        b=f9EF33ctOsxkj0ezYa6ZAWZAwclYI7RsFkfA6p+6UxxojzRwd4Lxq+dsuDJzCFLJxf
         znr76h8VBQUzpt1t9M61phOY1ndmeoHpc/IDcV5dlxtGt5vVD/Yj9nqNwXMkag7/uEf7
         XkfvdSF8+ENg8sWODZpPwlUXBZjZngybfNUIpIvypF2NT2nIHzD3kR57KPRl9oK3AEQt
         6IBf9VJL+t69lMyfauIO7SRKBh/7suTyyRbEObs4pkW0qoUtnh8iVwavXEQjIgQmpNiX
         RxxpYoKikQ2kL8wW97JfipNQUwHdv49kTwU3TmmgrEko4jKrWkxAVUStfmHqnbetUMuN
         y9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698054; x=1765302854;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkVu8b5ZXOgCEiRhWzvnOPQSP9ZYLvl9DnUVKbBmwB4=;
        b=LhDvqGJJ+oRcNxjl1gjwWKRQQolqb6UwWKCQa5VJf4zmgiC+HrX9SIv9UusPpc/qwN
         kEpLs/TcwDwgBMlPi3F/h5B9mgs8Q0dhiTc0Qc3bYPHEu9Ead+YJa9BmP10O7Q6H9mSe
         bJYtyixiuyJeU8lhluwWXMDnn1eQhUOMmJBYJxOeljz6P/WCm212B2VwsLjbKuMjL4tI
         0Hq99yQY6xJoEovEQ/s5sOLvC7TJw+X0OxitpjOWXrbJy79OIWABQa63SUPVjv2doIG0
         pzaCFreExJMSqBwOpWxdOnhI34cAL4vkk5vFJ7vYe8gkBhAkMOi+7RpjakArWZz5+78q
         v40Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOyYQgFX6QhTKnGTRkTo4emdYupSmPRdbMsOS5cG6slZGNRsHFXXVZIU+m0YXUmVtB3wR6TN9SrvDynAuBeeYY@vger.kernel.org
X-Gm-Message-State: AOJu0Yymq9Lzj9TptSJszIzkSYzUK7j8xK+uv1u3ZmFXPm0WGAt6ckW7
	Fbo2G3/SGH9+KRp10IJi5iLWdUAA0WwfE1uQZaJo4FWFY7wkshZn2dx+JBP0szH7XcVzC3dtVHC
	u8RmYlsC4Mg==
X-Google-Smtp-Source: AGHT+IE7G8f60FPONJ4cPEd8HPOCKPs8xgZYBVFFtcM6V/uJHUGNXzVcUizLGRwuJ1iYTXhmXmglEjM6z093
X-Received: from dycam21.prod.google.com ([2002:a05:7300:fc15:b0:2a4:6ed0:3c4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8607:b0:2a9:96f1:d2e7
 with SMTP id 5a478bee46e88-2a996f1f7cfmr5115241eec.18.1764698053628; Tue, 02
 Dec 2025 09:54:13 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:31 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-37-irogers@google.com>
Subject: [PATCH v9 36/48] perf jevents: Add context switch metrics for Intel
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index bc3c50285916..9cf4bd8ac769 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,63 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
+    cs = Event("context\\-switches")
+    metrics = [
+        Metric("lpm_cs_rate", "Context switches per second",
+               d_ratio(cs, interval_sec), "ctxsw/s")
+    ]
+
+    ev = Event("instructions")
+    metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                          d_ratio(ev, cs), "instr/cs"))
+
+    ev = Event("cycles")
+    metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                          d_ratio(ev, cs), "cycles/cs"))
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+        metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                              d_ratio(ev, cs), "loads/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("MEM_INST_RETIRED.ALL_STORES",
+                   "MEM_UOPS_RETIRED.ALL_STORES")
+        metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                              d_ratio(ev, cs), "stores/cs"))
+    except:
+        pass
+
+    try:
+        ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+        metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                              d_ratio(ev, cs), "br_taken/cs"))
+    except:
+        pass
+
+    try:
+        l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                     Event("L2_RQSTS.RFO_MISS") +
+                     Event("L2_RQSTS.CODE_RD_MISS"))
+        try:
+            l2_misses += Event("L2_RQSTS.HWPF_MISS",
+                               "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+        except:
+            pass
+
+        metrics.append(Metric("lpm_cs_l2_misses", "L2 misses per context switch",
+                              d_ratio(l2_misses, cs), "l2_misses/cs"))
+    except:
+        pass
+
+    return MetricGroup("lpm_cs", metrics,
+                       description=("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -678,6 +735,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelCtxSw(),
         IntelIlp(),
         IntelL2(),
         IntelLdSt(),
-- 
2.52.0.158.g65b55ccf14-goog

