Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A331BF3C
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Mar 2024 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395953; cv=none; b=HRL2yuW4MJcvEWQtAh9tyzgITdGwg1jNNzJdAuRjl+XYIwD2ZC6VvSCtqe2ap+e1jryuzpo3OmfjtA7NAc2h5O6TXFePESftN1UC8kRhlJEQIX6U/8sAxcT6/fhz08L2XKM9uGmQCM9nQMily4ulXI79QvRTVAR3OAowJ/z/qlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395953; c=relaxed/simple;
	bh=Mk3XQlHLZxdVodcrzm+PODwSYBMgkZqVt9gXIE7aW2I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pCm3SDYQ6Kfokq9Hs0on4N2MikIs4Bb0GZ+8KBnyOPZ11bSGuZzFy+HuRE9S6jgcq07AC6kN62mYpKxgLSLZ/SXxw/WbkyYjOkZC1REJqj2r4251Hd8U20gjVqsV/VxirJmkL/VHVDUsrKMtbxMtccyLBhwANV9ATiHk+rcUVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3Me8htA; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3Me8htA"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cbba6fa0bso14088607b3.3
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Mar 2024 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710395951; x=1711000751; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSBh0lB+a23+39fFaPjg8zQM/Im9uFNXguVDinAnXbc=;
        b=Q3Me8htAcgDEJEuqazatt0G3Rlq7GsKxRDIeFW0dTzEQfeqVVWA72NvbSLXFhqSXXj
         O2o+rPXJKuOaBpK9pwDk5/7k7/mc7l6YM9fL+4Ih+5KDYgwBCwQF1BB51REA2TYOkIN1
         bGYLLKYjvQO9N5CZ61AwyULuiZCKG1n8d7C9II3FrL9JN3Ub0spAXefYGrtDvIYuTYeD
         UY4mIgSzwyGO7lBP0oVnNMek3l7+M49LrhB+7BRws094d7Kx3xHKsU9Gj7gz/1BDBScE
         kYpDAeKO3oCAU1bwTtv9BPOENT5lfFJUyN7EMvl/E/jk4MXV36Nty8XiUs5D23b3lg8t
         CPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710395951; x=1711000751;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSBh0lB+a23+39fFaPjg8zQM/Im9uFNXguVDinAnXbc=;
        b=GCQLDaXFzAnw7UB4GOjglqh1Lr/rwCJBqadeV6BY50DhoXecnt4VfTPq6JzuJqM1Mu
         dTaqw71FhRhKSfLPb238Za5s2JY6SXv5XW475vyGa6jLYqEEQ6qnhROKiC3JnLaR+K8+
         4SIC58sUkU6Ta0cj7uiR7S2e9PxIBqPReBfRwDmYUzLB3PtUh7IwW5t1Y+P5kULAmuRv
         /+/wUiGrza7FqEGJ+sMo8E9/UO0/q4oH1KG9OXJitDkFgbccBekdVrjrLUQf3I6qubV4
         nKzU48UcaDdRGaiFByLROnd1ZGWJhr8vgBaJxl36hwt1fGugWBLCDdmzGiay6rkpKsJq
         cExw==
X-Forwarded-Encrypted: i=1; AJvYcCU2KSMJR77EZfKF++qlovAYlXQcbB/wAwkVNOKHcLADI5x9k+krlLg/EVA8ow2VnftxZEH2mvlAwW/TN9rYGXOf/H18tz1l9EZRvnSfP3WuEw==
X-Gm-Message-State: AOJu0Yz8Pul4Fm6fltCGaCNbBhN7FpFUo7B4ezlrTfb/uGgTfMyKMgKZ
	ZzfoVx5gC6MJLcV2SBKd0TGdjgBUiTUiOe3QgWe5BI4gk6WEU7xcMpw5tF6fEpwyzykMcKiUBWZ
	mqkvd7Q==
X-Google-Smtp-Source: AGHT+IGz/WcD1pwUVpDjsHmi87+odVdNlep/ZH4vaPqLNRuRB0bMnFJncve4GNCavNVSJJbYCIMFntlCkmwb
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449f:3bde:a4cd:806a])
 (user=irogers job=sendgmr) by 2002:a25:9285:0:b0:dc6:dfc6:4207 with SMTP id
 y5-20020a259285000000b00dc6dfc64207mr211031ybl.10.1710395950986; Wed, 13 Mar
 2024 22:59:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 22:58:39 -0700
In-Reply-To: <20240314055839.1975063-1-irogers@google.com>
Message-Id: <20240314055839.1975063-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314055839.1975063-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v3 12/12] perf jevents: Add context switch metrics for AMD
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
index bf5c4ffa53e9..bc70743c2f11 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
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
@@ -613,6 +644,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.44.0.278.ge034bb2e1d-goog

