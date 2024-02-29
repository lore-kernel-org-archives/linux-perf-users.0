Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724ED7FE
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165770; cv=none; b=GhO9P2+hAuLeYVubjekr4R+69M+TqwOJZjW4tF0Q1Dt9b7uI+Q0nYCtkR6WwkKcqO6vVsN089s8N5qcGnLEdd7FAsHc0QuLOoYPtcpenUIOwQVVgeDvlkTOSZ+EHTfD6X+gA1rUAJrm0Az/PvAdh0A/jqgcPMxXil0tpxuD9aNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165770; c=relaxed/simple;
	bh=rdT/e0Jk04uz/hli1au/7w9zNoOK9Gsygo85Wow1ix4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z3YYF4IswhA/cdh2Uh27vt/PhjCF4Buti6Gmm26c6MyQo21lH9G/6/sFfn/SyTNjVJBW/6q/dhiGxfhsVz+kZCeg3w3wVPOrWBQA+M0e6tx0QchOcTQ8xjJng+YOUXCy0x2ujfo2H6a2XaI+G1bbsmE8zYD8l20feaKzNBDOs1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=evhdKGJQ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evhdKGJQ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60957e0b914so6068637b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165768; x=1709770568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=evhdKGJQU2b/oZ/NAsFgZvxh0AxV5W85oves5f90jukk/PFjqkBIrTxVeG6UJ2XB+g
         nKsO7IVHIa32CZS9+y25N/SXDYIQkJfd/ZWdISUvJnJwu/r9usdwbKgepMG6ocWythzi
         EHwA7W5n30THvvCxxihJMHKDq1Az8aL8yoyscFjl34fzNVVH3122aJijbg6yPDdBnLaq
         YvAaz5EwR2Auh6eNn745Bzxs9J8UQ2aXtajLVnqZlZQvzNV1pmk+88Q+u66u9RUgBOhC
         aHOQ0GiHuiGDzKP/ENaXjhIMZ3n4Rfu3WuIXpfdLCq1AGxZz7Lz+rXxSptSgHqifQBf9
         yHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165768; x=1709770568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHahQF2BiK1eIw2Re/KcTjpVIHmS0xMmp3oAqD999cA=;
        b=LCOk4mTpxg9sl9sw0DJTGPIEBxyf9mUlGWE9c7JnbuMK1nIhuVVh47PuViQQaNhbTv
         vZfG+K+KZqaVWKCde7xzxBmESNKeG1UfEQEMtvLTWz8DSnCUjOOJV+v1La7aqyzw25RQ
         ZTQ/kAdA0jvns05tfqYl0FkzumgpasErRo3aOfQ67Pb9JQ+qXGbtc4YkBI+LUqXvk/DS
         zEAH0vs3AwPWIAxehx0RMbqBG1y/H1RQMwI2wcfxixuUGyZjAGQt+8e066YkuzZqNUiw
         CW9gNphmQ8h9m4lblhUs/p4ZfAYxJYzzYEbHMaihTdCyBVqs9XGnXSbaGgtcnQ15P7+U
         nj1A==
X-Forwarded-Encrypted: i=1; AJvYcCWq0UP+cbwcl/t/3afFEi6bDPopyrnaygXZzqSFFaRJx/syhWJ67NMjPjHg1chrsBzd505rO2eodT/Vn7FJEXVz427Qar1/u31YQBWc/JDNTA==
X-Gm-Message-State: AOJu0YwMukbzRjDnJ12VCzC3WaRvXMYUqOhgpydP9IOD+3OYauVuwu4y
	nSj+a0uJGnyvEI3hc5rSNOXOXIqblXafaVZ3Y0FGbdAYYC0RHY28X1HEYYDSrkDo+XLUudCo6wW
	0ZQZgvA==
X-Google-Smtp-Source: AGHT+IG/3aNxiRC63BWDBZbj1S2tf4ajqBK0IG0ZThGkkU02FYQuy0rwRvvmvubAF9jWfd2f5MVBjOefPdbI
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:c1e:b0:609:4c74:5cab with SMTP id
 cl30-20020a05690c0c1e00b006094c745cabmr139123ywb.2.1709165768568; Wed, 28 Feb
 2024 16:16:08 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:35 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 11/13] perf jevents: Add ILP metrics for AMD
From: Ian Rogers <irogers@google.com>
To: Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	John Garry <john.g.garry@oracle.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the counter mask (cmask) to see how many cycles an instruction
takes to retire. Present as a set of ILP metrics.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 6b182a9bbfe5..91f323c1a149 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,35 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdIlp() -> MetricGroup:
+    tsc = Event("msr/tsc/")
+    c0 = Event("msr/mperf/")
+    low = tsc - c0
+    inst_ret = Event("ex_ret_instr")
+    inst_ret_c = [Event(f"{inst_ret.name}/cmask={x}/") for x in range(1, 6)]
+    ilp = [d_ratio(max(inst_ret_c[x] - inst_ret_c[x + 1], 0), cycles) for x in range(0, 4)]
+    ilp.append(d_ratio(inst_ret_c[4], cycles))
+    ilp0 = 1
+    for x in ilp:
+        ilp0 -= x
+    return MetricGroup("ilp", [
+        Metric("ilp_idle", "Lower power cycles as a percentage of all cycles",
+               d_ratio(low, tsc), "100%"),
+        Metric("ilp_inst_ret_0", "Instructions retired in 0 cycles as a percentage of all cycles",
+               ilp0, "100%"),
+        Metric("ilp_inst_ret_1", "Instructions retired in 1 cycles as a percentage of all cycles",
+               ilp[0], "100%"),
+        Metric("ilp_inst_ret_2", "Instructions retired in 2 cycles as a percentage of all cycles",
+               ilp[1], "100%"),
+        Metric("ilp_inst_ret_3", "Instructions retired in 3 cycles as a percentage of all cycles",
+               ilp[2], "100%"),
+        Metric("ilp_inst_ret_4", "Instructions retired in 4 cycles as a percentage of all cycles",
+               ilp[3], "100%"),
+        Metric("ilp_inst_ret_5", "Instructions retired in 5 or more cycles as a percentage of all cycles",
+               ilp[4], "100%"),
+    ])
+
+
 def AmdDtlb() -> Optional[MetricGroup]:
   if zen_model >= 4:
       return None
@@ -560,6 +589,7 @@ def UncoreL3():
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdIlp(),
     AmdDtlb(),
     AmdItlb(),
     AmdLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

