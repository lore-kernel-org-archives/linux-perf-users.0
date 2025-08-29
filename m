Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001C922FE18
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 04:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756440719; cv=none; b=swH1imke8uiBRndwSk06TVN2AcuLtIz2rIfBP/7AnV6NL7DW6/FWAF+IZtrnxhyf82fCHQpEdnhqDE7ASmLAEItbKtFNI6IqKFOEpmWhO1PVCLS/RlTh0P899iWHsXmWbHO3fILlQKz0S2Mn2v399+wvjCwkFx9261HewV5/Dlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756440719; c=relaxed/simple;
	bh=RAqBTlsz7iTfkuh3j5uys67bv7j8iaCJTuIX6mNvt/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Mimdein/TFJnSPhj6N8MD4mToutFk4W7Qrxt8hvJd+rO01Z+m+qVHsNVzV+JV6cv5qmS0LRcqP4xZYEAo205qOrNwe9n8dRTXmcW4zA+kcM8dZdtCX244TWkrzARPaOYNz3Yd2Obvc+RYX6Wgq+vRSUuXjqB2GIwOPZ6cgWqYAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3golQaZf; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3golQaZf"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-327ceb05e9dso909108a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 21:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756440717; x=1757045517; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M37/BCr0G7wFUjtgs9TA1CPDOATBHqDUNx+A2nDCLDk=;
        b=3golQaZfn9ZLUWwFQj37b/zzBBQ53wbnAi1ENsoiTFAVaGd5x2cJ2TsINelaNsRpXw
         PPkjUyeTlKPQvG1vQxra4cuupWh4eBmBsw4BlxgmSHMuc2FJfYlNQqBaGGESRGfwycFB
         5whEPhsp23VIhVCyQUF2Nho+XHKUfXet3VIHZvCQwSfs66pWYIkSLcNyZMzL5xsXpPkU
         zslmgnJ4o9ZomnFD3u1ndgmmkfUlCLM6E3PToqyGZDmZntm7OjZZYc/hTS9ZLTyMT0UZ
         siGvoNvJwMxNRkAj+5MDiF4rMjGmHhsnPA44lnaFblA0jQtST/m14X0o0Ty6DHNjrivU
         QdWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756440717; x=1757045517;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M37/BCr0G7wFUjtgs9TA1CPDOATBHqDUNx+A2nDCLDk=;
        b=cH09LGjAhpPvAyFBmYWNs0Vx2lbovvZGN1kICVnoGC+xiyZyKzMyp6hnFzLCedqG5l
         rI5klgEneJY4+a29myiCfv1JxKclTv0oN/OwXXUkSj2fb+x5thEVLoMjZOvwQg6Xu4kB
         mBUvUT3Jl1FcY4F3NT9vmSowoEQ5RfJhky5WLtthZwlRLQF3WAMoD0bEWmZ+0m4xwjuT
         PMtM6vcMUgYe2SUew7f5Mgg0pTZWGgPVDAvr2PNvU10yOYecD4Z/BNXHwwh55RKulDJp
         n+/xAOpL61hfit9OsugzjlZBiG/QYLdpaiqyLcLr/1OWisBzKT4Px7egBYqGGjH3oEtI
         1Zaw==
X-Forwarded-Encrypted: i=1; AJvYcCVBoxQxASShv4bOw6U4QH6el3cWCkp2UZDnem0xvP26ozZQytBXMfPNzoHaeaZAvuTqDWhaDMplljyUB/H8gzQX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2NNaFqxxbN28r7mN8M68SDBFqIQvxsQnJp/jy93uA/e3SYhRY
	yiIBVg6PaelZJL1hXCF8v38zi5j90cmnYmnN04wHHTx4LO8kKqpT9dOwOZAiP77lUO58g0ErrRN
	+CasH0kf6SQ==
X-Google-Smtp-Source: AGHT+IFaF8U3qHBbGql+g0XBidJWc2JoLHuvwPhanDRiVWnkGTBDVCZ99T8uFipFHHukDL9yt7SvOBC9ZHNg
X-Received: from pjbnc12.prod.google.com ([2002:a17:90b:37cc:b0:31f:2a78:943])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ece:b0:327:c0b6:305b
 with SMTP id 98e67ed59e1d1-327c0b632b3mr4490721a91.36.1756440717275; Thu, 28
 Aug 2025 21:11:57 -0700 (PDT)
Date: Thu, 28 Aug 2025 21:10:56 -0700
In-Reply-To: <20250829041104.4186320-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829041104.4186320-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829041104.4186320-16-irogers@google.com>
Subject: [PATCH v5 15/22] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Sandipan Das <sandipan.das@amd.com>, 
	Benjamin Gray <bgray@linux.ibm.com>, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index f4d0676cdb77..262bfd539262 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -612,6 +612,20 @@ def IntelL2() -> Optional[MetricGroup]:
   ], description = "L2 data cache analysis")
 
 
+def IntelMlp() -> Optional[Metric]:
+  try:
+    l1d = Event("L1D_PEND_MISS.PENDING")
+    l1dc = Event("L1D_PEND_MISS.PENDING_CYCLES")
+  except:
+    return None
+
+  l1dc = Select(l1dc / 2, Literal("#smt_on"), l1dc)
+  ml = d_ratio(l1d, l1dc)
+  return Metric("lpm_mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -819,6 +833,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.51.0.318.gd7df087d1a-goog

