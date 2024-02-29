Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FB57318
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165773; cv=none; b=MHOLN5HsRH/ilbhLPEh++8fQWFPBJmWQWzWEsKlJQ0rnAAyIc8UeffBu8HvtX6uhH+a/lnKgqOGAjC0xiYn/8ahyJ4RZubMMIge2eKHlCydd3M9yI5Up3GIh2LUQPJtr7BN/2GK8D5/epdqGr4D6KabSK9Aa/apXLPAh9eRSWlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165773; c=relaxed/simple;
	bh=UwkjYK+U+f8LwVeVeyTQSJU60/nxqzY/uXtXOkioAuY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k3h9OYmYGTaORV9cxg9PINf3tSRPzzozgS5WN9f1JmFFhoa1cHWx5pxwqs/NxJ2F/STO2NACpsE/A9RWqK586J4h3UP2Wza0KMFdYi8QYe7U5u0Ez8yTYLUbMvEBqg9nVWupfP5WGtHvOj+tRAc2Q4f2sC2/YUfd+5j4M2Rcqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SgHzwcdz; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgHzwcdz"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608ad239f8fso6033977b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165771; x=1709770571; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDmb+1G4FeL2VOjrPNtrbYg/sNUzgE2lO0wYF9ntEME=;
        b=SgHzwcdzxtbE3LV6tT49xoXoF0G1I3qHqCSHLstVUpKDA+rPt4ij6Co35vmgEqJ3Es
         pWuAv0zcTZza77OUKteWVcOhmzba/T2EquJ5uwWJZYVt+oZWmPBGWYQW8YnNAqMfS55M
         a5+xtLy1f5yT5wBXbPFcqbL7/N5o4KfyOpfQ7fcpvDoG207nZvptqPD8ByhfMcGtcdX5
         nizVyuRg8Bo+lhNRTo8s1H7AeWjDEomblTGatvnhM8yJoQqh2hgBtZJTgLXeflXkN3ch
         GsUX2JoBM/7CupIf/ua8sTt4tenamFTHQwHKPlEhxYPsqhaNGyFUofIeBF/JJGFdqWnf
         wcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165771; x=1709770571;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDmb+1G4FeL2VOjrPNtrbYg/sNUzgE2lO0wYF9ntEME=;
        b=TDRX78ACJsJCwF+E+Bg1D8ttOwCO0OicH3X3Bn1i2GTTngub9lbv78xnCZxPt4UvcG
         d+K5u2MOtyBPnLWhHjMRm0lMDGDTqrHPOXKlaAtn5rz1jx7Nvn58Uup+FYH5eCEFrGBM
         MNiM7ghqGnioP1aoYxURRRAVEHzl7idudJ7V/m3V2tbstBLYUOsJ7D4jIJtjDy+wLmeD
         Sm60SrTUhV6TMiJSfGTiwq5xgcE4iRVp9V6nqsCQwcZTaeQjMRF14Hy7Zpj0QAaXoIWl
         sy1mZ+XiSVU9opkQCwBRHLPLIiVVqXt3evh5pZ5DJuFmg9qBQVYH2XdHvCcO4z2Qodjf
         flEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlEt0XHr/Y8ZPp0fMjt83Yz582Sdb1q0BD8McqhcqSiE7T6pOR0ls41G4SKZjuW7XILbETjIQfpdFTAqdpPxC+S4FEsZXfsNuivAd3vrKVKw==
X-Gm-Message-State: AOJu0YwRSD7YA1/36k6r944BXdNBfAvblQwW462e6iWnKRFYIYigrNWD
	N+TP7e1u6xIUQISKbTvWZQZb/Sp8xOw8SBdDXeN44UnXWftj2F773YzVoH8YFJWcRdwseSE8PD5
	3BpSDgg==
X-Google-Smtp-Source: AGHT+IGHWKOWL4OTjiWorXSVdTqwsIiYn6BygBXX3AaiqhhWij1L0lxN0gttlZUyocCiEKABbwM6vqaaXu0A
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:1c9:b0:dc6:cafd:dce5 with SMTP id
 u9-20020a05690201c900b00dc6cafddce5mr209364ybh.12.1709165770873; Wed, 28 Feb
 2024 16:16:10 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:36 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 12/13] perf jevents: Add context switch metrics for AMD
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

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 91f323c1a149..377ce413d051 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -125,6 +125,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\-switches")
+  metrics = [
+      Metric("cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -589,6 +620,7 @@ def UncoreL3():
 
 all_metrics = MetricGroup("", [
     AmdBr(),
+    AmdCtxSw(),
     AmdIlp(),
     AmdDtlb(),
     AmdItlb(),
-- 
2.44.0.278.ge034bb2e1d-goog

