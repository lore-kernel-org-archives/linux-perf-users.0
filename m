Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DF2D0C7F
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764698053; cv=none; b=l3zdezvyHfTTkFMwUwnZct2LwL03eqITnRMMyxDeY8JVeUQ45GSQ/26dUd1VsQjE48fZlSA7Lnr/lnpLp9IGHiL2dj8vzhuiDtgL2MSmSmgfB6+IT/PuT6wbc8+da0TPUsaKxP5ETzFPYzosPUaeFi5AN36w1exk1nQJJoDXz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764698053; c=relaxed/simple;
	bh=+ttWDGUeG4bvVIjy1RBoNK6kU7dlt8w+HTxO/xITRH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=DpfT62045EOSm8mExVzonz3JICGwwh6S4dihjUSjX2fW1YEHN6XlqXnFf5dFzVnaIX52U9ruvmYwZlbNHoncH/nOjGfy/klFWw1xqLlvglDFOErlkJ1DvhSAB803wJYEvrZP9EG3ag1vbC0Tn8fZdoNXWbl6CaI2gp7vH4Z0Izs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AEbUJQw1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AEbUJQw1"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-bc2a04abc5aso4766467a12.2
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764698051; x=1765302851; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNtqbd8Q8NjC4dva2JveZ3egkazytlooL/wAa+20rnM=;
        b=AEbUJQw1Lx7+gpMaFT4uij6cn/YCoCSiinW0WCbiaZ1+/PP0UyFQBfUGdxVtT4e/o0
         gePx38VxeBOy8WWvTZwiJQRVh7fdWHgnt1S30pjv8+N2ByAvZn6JEalZPydrF7awqCJL
         DbJKw1Gy318H7i/VpACkR/jGDYtGcOf73qsCiKUJg8rN/6EIV0G++mHWniqlMOiD1oMq
         a+xHAVs9JeSJignUeqkGHSifkqF1MJnQvdzGxzEKHvE75vFwTk9uKskmlKHtv7a5k2ON
         XR2m29IHLBNFFytrL1T2LVgH6gSe90ki7BhmmdQfzpOvsU+Z0EQtubhLAj/cP0qr2FeO
         KWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764698051; x=1765302851;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNtqbd8Q8NjC4dva2JveZ3egkazytlooL/wAa+20rnM=;
        b=r2A8+yzmPurxAcjZ6+W0pVwhOQv5ohnv2PkXzBDWvS4lthGIEJKKXb0mJpF5KeHLfq
         tZ9sK2PnKQnU3xsYY9K/a3I0/+BmrbWufZPdcZSyhJU7xthaC4Ez8eYfwFU7sAfzUGm0
         nOzIOVEJ2fx7HPMwWkczkEy0rcxLXz9p0Jaq4gWlfINoV1jmUo/7lZXH6xstDJyA8LqH
         R/iW8llLUx6u3bpms/DayddSw9sHY4ih5W/pClb4r3dJj82AsaHrgI7bZMkxL3oZ2Wbr
         kFbTFYEfRQeJfnbqHs/3HUUWV8/lidT9YJj492iDhbV9qpTI8qftSegJ+zIrLyBkmdC7
         kUqw==
X-Forwarded-Encrypted: i=1; AJvYcCWTqnU3zPaTzdiLSDT6tDeI1QVFpTBeHqcNXW0zqyl8zXaNW3ELHJjCNOdUpUSFQ0MMoNUelL2yn8F+bxah8b6E@vger.kernel.org
X-Gm-Message-State: AOJu0YxL+m0N0KVFrZeE6//0iXoQbefYVnhpLY6DsuLqvmVrGEq6T74s
	/ofrbzQLwF8c7lJpgJwzi+0JfpCKQUDBHr1RFtRNM26+ThT94PfNa6gYWZ/gUmk0mgxANuFvoYT
	W+gKU2EPpGA==
X-Google-Smtp-Source: AGHT+IEr3cVljQnlIcGWKyPMDcxyIrtyGSbvioKXilxmQF5wxHkWqYT2QKPuIKEZcSckmpsC+i3PsZsATnpZ
X-Received: from dyctx12.prod.google.com ([2002:a05:7301:5f8c:b0:2a4:7052:5652])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:d589:b0:2a4:3593:468a
 with SMTP id 5a478bee46e88-2a9418bc5ccmr12424963eec.38.1764698050504; Tue, 02
 Dec 2025 09:54:10 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:30 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-36-irogers@google.com>
Subject: [PATCH v9 35/48] perf jevents: Add ILP metrics for Intel
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

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
---
 tools/perf/pmu-events/intel_metrics.py | 40 ++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 19a284b4c520..bc3c50285916 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -263,6 +263,45 @@ def IntelBr():
                        description="breakdown of retired branch instructions")
 
 
+def IntelIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("INST_RETIRED.ANY_P")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    core_cycles = Event("CPU_CLK_UNHALTED.THREAD_P_ANY",
+                        "CPU_CLK_UNHALTED.DISTRIBUTED",
+                        "cycles")
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), core_cycles)
+           for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], core_cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("lpm_ilp", [
+        Metric("lpm_ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("lpm_ilp_inst_ret_0",
+               "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("lpm_ilp_inst_ret_1",
+               "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("lpm_ilp_inst_ret_2",
+               "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("lpm_ilp_inst_ret_3",
+               "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("lpm_ilp_inst_ret_4",
+               "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("lpm_ilp_inst_ret_5",
+               "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def IntelL2() -> Optional[MetricGroup]:
     try:
         DC_HIT = Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
@@ -639,6 +678,7 @@ def main() -> None:
         Smi(),
         Tsx(),
         IntelBr(),
+        IntelIlp(),
         IntelL2(),
         IntelLdSt(),
         IntelPorts(),
-- 
2.52.0.158.g65b55ccf14-goog

