Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C132252D
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Jan 2026 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899523; cv=none; b=cPrshs5+p+mN6hbp9gQ8gRLyDjElwizSeOV7nL+xoPow7at+dM/dCBoV2r85+g51U5TyF6ae7Hn8QRoik6FFiahTdsCE+LUSucb0dORmWPKjNMtDGq7b4Coq1mXXvSd72sgXIY36aT7vumAnTrCfoAebT2sAQeGW8OBJLhFqS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899523; c=relaxed/simple;
	bh=SqSW1HSI4Y1aSQ8k/4kIp/osnr+X4b4UKAj2lYUJFSY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=RmWCFd6RFtEnlnFJG/8FhcyeOvx9iiIpN+/Zg2eX5uoYHoP3BUWLVHlbIDyAy33IVpUrrYBDKbljNSbLrW7R20HAHT5IfyhlFO8UkqLi5kZbtLOmJGj0d0zyaqOWsie9hKFw6UW0hBbhpwkdjuHO9GjeIyaeQaXQRoBBV9f6JRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAuI/e6m; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAuI/e6m"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-119e80a89b1so10527062c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Jan 2026 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767899521; x=1768504321; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOdr8IbPINiK2ARzYXL2NZXJz57sKNu7nLLXlg9pgVg=;
        b=FAuI/e6m5iKsc88kBgMEGxmUq8fNHFnHD1rG1KO+LOPyg/LdcKJmwNmdgsjot8TrRD
         8G4n32wf61NnkrwG8B/bRtNTzQCc/uDgtTBKE7+4VVZNc9Qqc2pHahA0ibBsoW3KZXT4
         8LAHBEJS56v76WKAqjMtBfCympHe62M8XytwBUnUWC26UL86+o0T4mJ4VtJ2HN5Ogq2N
         RzfqZsy2/WI6Gj9zW9XOaHfOb67Gw4TdV6fV2y4BR2t2uKDHvU8o8jnpODLOmTcuzDOl
         n4QGXy/dQOubICQqvrKQGHEgDNkOWY0UJ3tAszd8jcQvIGNBjZgBg4GCcJYIjhCswM//
         RH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899521; x=1768504321;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOdr8IbPINiK2ARzYXL2NZXJz57sKNu7nLLXlg9pgVg=;
        b=mR57356H4XsrYJfbc8JAotlUY2HxWJicSPzxfylY/u4tqjCQU3Q2dMZCDF46Bzgg18
         SuJtTT1wSTacyx8iyQtn4FpwmJkUQyikmhJbCkyvuouPqYo3lR4GSRsDYg0AoYlBBcwY
         bA+rqh+W0jyZ9MsIpVhyRFNc6K7SvBSdPlwKKEOy0fiz/9z7/H5vBp6U8DgkwI42MxHV
         mY6ovaQtcqVOqVjhZpljXzAbGiUjllQLnliUXnpm0x/k1SEUnqqyjD8CgS8bqqrs4+OD
         f706D5pLlunUd20xCg9MRuKauTryTxUsPElRbTVUDeU4RndE0TRGigS/zY1i2LxGLEje
         NY+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDBfFDYSRqOQ/5aqbWdbXh+E3H0geVxnC6Psz3lfj6UtsDIt+5x4NqIxkFEevpU0gLJkCdUSWsz0XIKhDa/CsC@vger.kernel.org
X-Gm-Message-State: AOJu0YyhUj3EVwxKxeiuPWu+lVPGVkaG7dSr7M6MrSQh1Juyzim/UfqZ
	H5wb5BdnL01ugx+av1o9qcCSIXEy03ishY/tgZEOHxcoHKUd7Wt1vhlCSISfhQZLS+zuO+f6zwP
	rOp6/xFmeyw==
X-Google-Smtp-Source: AGHT+IFcOWE2quG2Fo1o19pSXXZ4n2dWrBi8Ysraf6hMlSO44GNOg37dSaIL9lVbr0QQMpPmqfKjex5YebID
X-Received: from dlbdt12.prod.google.com ([2002:a05:7022:258c:b0:11b:2984:3606])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:31e:b0:11d:fc72:e17f
 with SMTP id a92af1059eb24-121f8ae75f4mr6734306c88.18.1767899520602; Thu, 08
 Jan 2026 11:12:00 -0800 (PST)
Date: Thu,  8 Jan 2026 11:10:48 -0800
In-Reply-To: <20260108191105.695131-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108191105.695131-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108191105.695131-19-irogers@google.com>
Subject: [PATCH v10 18/35] perf jevents: Add br metric group for branch
 statistics on Intel
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

The br metric group for branches itself comprises metric groups for
total, taken, conditional, fused and far metric groups using json
events. Conditional taken and not taken metrics are specific to
Icelake and later generations, so the presence of the event is used to
determine whether the metric should exist.

Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 05f3d94ec5d5..e1944d821248 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -124,6 +124,143 @@ def Tsx() -> Optional[MetricGroup]:
     ], description="Breakdown of transactional memory statistics")
 
 
+def IntelBr():
+    ins = Event("instructions")
+
+    def Total() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_all = Event("BR_MISP_RETIRED.ALL_BRANCHES",
+                         "BR_INST_RETIRED.MISPRED",
+                         "BR_MISP_EXEC.ANY")
+        br_clr = None
+        try:
+            br_clr = Event("BACLEARS.ANY", "BACLEARS.ALL")
+        except:
+            pass
+
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_all, br_all)
+        clr_r = d_ratio(br_clr, interval_sec) if br_clr else None
+
+        return MetricGroup("lpm_br_total", [
+            Metric("lpm_br_total_retired",
+                   "The number of branch instructions retired per second.", br_r,
+                   "insn/s"),
+            Metric(
+                "lpm_br_total_mispred",
+                "The number of branch instructions retired, of any type, that were "
+                "not correctly predicted as a percentage of all branch instrucions.",
+                misp_r, "100%"),
+            Metric("lpm_br_total_insn_between_branches",
+                   "The number of instructions divided by the number of branches.",
+                   ins_r, "insn"),
+            Metric("lpm_br_total_insn_fe_resteers",
+                   "The number of resync branches per second.", clr_r, "req/s"
+                   ) if clr_r else None
+        ])
+
+    def Taken() -> MetricGroup:
+        br_all = Event("BR_INST_RETIRED.ALL_BRANCHES", "BR_INST_RETIRED.ANY")
+        br_m_tk = None
+        try:
+            br_m_tk = Event("BR_MISP_RETIRED.NEAR_TAKEN",
+                            "BR_MISP_RETIRED.TAKEN_JCC",
+                            "BR_INST_RETIRED.MISPRED_TAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_all, interval_sec)
+        ins_r = d_ratio(ins, br_all)
+        misp_r = d_ratio(br_m_tk, br_all) if br_m_tk else None
+        return MetricGroup("lpm_br_taken", [
+            Metric("lpm_br_taken_retired",
+                   "The number of taken branches that were retired per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_taken_mispred",
+                "The number of retired taken branch instructions that were "
+                "mispredicted as a percentage of all taken branches.", misp_r,
+                "100%") if misp_r else None,
+            Metric(
+                "lpm_br_taken_insn_between_branches",
+                "The number of instructions divided by the number of taken branches.",
+                ins_r, "insn"),
+        ])
+
+    def Conditional() -> Optional[MetricGroup]:
+        try:
+            br_cond = Event("BR_INST_RETIRED.COND",
+                            "BR_INST_RETIRED.CONDITIONAL",
+                            "BR_INST_RETIRED.TAKEN_JCC")
+            br_m_cond = Event("BR_MISP_RETIRED.COND",
+                              "BR_MISP_RETIRED.CONDITIONAL",
+                              "BR_MISP_RETIRED.TAKEN_JCC")
+        except:
+            return None
+
+        br_cond_nt = None
+        br_m_cond_nt = None
+        try:
+            br_cond_nt = Event("BR_INST_RETIRED.COND_NTAKEN")
+            br_m_cond_nt = Event("BR_MISP_RETIRED.COND_NTAKEN")
+        except:
+            pass
+        br_r = d_ratio(br_cond, interval_sec)
+        ins_r = d_ratio(ins, br_cond)
+        misp_r = d_ratio(br_m_cond, br_cond)
+        taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired conditional branch instructions mispredicted as a "
+                   "percentage of all conditional branches.", misp_r, "100%"),
+        ]
+        if not br_m_cond_nt:
+            return MetricGroup("lpm_br_cond", taken_metrics)
+
+        br_r = d_ratio(br_cond_nt, interval_sec)
+        ins_r = d_ratio(ins, br_cond_nt)
+        misp_r = d_ratio(br_m_cond_nt, br_cond_nt)
+
+        not_taken_metrics = [
+            Metric("lpm_br_cond_retired", "Retired conditional not taken branch instructions.",
+                   br_r, "insn/s"),
+            Metric("lpm_br_cond_insn_between_branches",
+                   "The number of instructions divided by the number of not taken conditional "
+                   "branches.", ins_r, "insn"),
+            Metric("lpm_br_cond_mispred",
+                   "Retired not taken conditional branch instructions mispredicted as a "
+                   "percentage of all not taken conditional branches.", misp_r, "100%"),
+        ]
+        return MetricGroup("lpm_br_cond", [
+            MetricGroup("lpm_br_cond_nt", not_taken_metrics),
+            MetricGroup("lpm_br_cond_tkn", taken_metrics),
+        ])
+
+    def Far() -> Optional[MetricGroup]:
+        try:
+            br_far = Event("BR_INST_RETIRED.FAR_BRANCH")
+        except:
+            return None
+
+        br_r = d_ratio(br_far, interval_sec)
+        ins_r = d_ratio(ins, br_far)
+        return MetricGroup("lpm_br_far", [
+            Metric("lpm_br_far_retired", "Retired far control transfers per second.",
+                   br_r, "insn/s"),
+            Metric(
+                "lpm_br_far_insn_between_branches",
+                "The number of instructions divided by the number of far branches.",
+                ins_r, "insn"),
+        ])
+
+    return MetricGroup("lpm_br", [Total(), Taken(), Conditional(), Far()],
+                       description="breakdown of retired branch instructions")
+
+
 def main() -> None:
     global _args
 
@@ -153,6 +290,7 @@ def main() -> None:
         Rapl(),
         Smi(),
         Tsx(),
+        IntelBr(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.457.g6b5491de43-goog

