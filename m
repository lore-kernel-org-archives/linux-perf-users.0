Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB05336D
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Feb 2024 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709165765; cv=none; b=WmLRXg+07pfM7Ki11SOWTZGKDdMJGhjHfRyrhA66jq2I0KPHJRMQSEilfrcZ3ySshKouNIgrzfEmCi9g45TONuRr8NR47SNizhk4tHSJn083SgUP7VIMZgUr03f5a7vt0Nqnl6zP5ZFPt/L9OQ8lo1ozuWTPCHs8mYPHPc8DIvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709165765; c=relaxed/simple;
	bh=xBfxlNT0aaXEMy2J3656vmd02rMeN9x8F3Ypxz5k1Kk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ejPcMAvwuP5TooUyyKdz9pQnZ+Uvoc+b4bZIge9hOFJJGH/F7prz6giiDzdFyKPMjRmvMO9/xpxBEd45dObxMEPxwhKGf49hBAZO2BYubC5T1nJXMchCUcRf4xb7K6yy6aBCWWkz+3PZ2aGzH1rW9yJCPTmvp6U/QV5/IaPKK3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDZEwEQ+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDZEwEQ+"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so737362276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Feb 2024 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709165763; x=1709770563; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=CDZEwEQ+/8KUHGuAg4i2NUa4TgorEzTxb0mPPbXV+zfjmXufeEkMvzhS4mwTg8D8M2
         0qsveyes9xpOdxR/q+pbMJKl7xfCNFb4YSo12OnwKLl+1/+2FuDkxvz483rAMUPbp83q
         j3EgSUEKL5SaItl5mJCvoaJpxiCz9Eu47N7a2S/4FrPWiTlR9MlfWSyzcqUDC8NNPWqV
         5Zh3DZ/+Mc6wGSq/TrOGzm20I+NpDMjqNLigQBXKGrdIcpRM1AZ30on/VajmTOmbK2xU
         fVfdi1Hx3qu1N5L8m6mJ8uOya6faknyEQNsHaw9cX8AcdjLQF2ESN3q/gl0fP+3JkYer
         b3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709165763; x=1709770563;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=C3nUJCwVwhDEN5XK0oNIjqgHwRSVloZYLA0KihSs030wpU5BDcNE/+Y1IXCG2HLBCJ
         JTHBIYHt++vicXMxxurD22RmwnU/zUeve5js874z1FvXMKu//eQn4UuxsSfRnLwH2m4U
         ci7Fbb6cvgR6U9EDftrdXwBM3lKgm/UQEUK+BPSZC9GTg2w4mmMvO9aUXWPBodIlRHZS
         I3TWTs5oPRH8eFCzjy74vR9EsxhwZ24Ep/h0RbxR3mWEWj/gpQLlQW4eSoSGs2fIU1TA
         gKQCtljFjfRbA2p8X9L85+hM7d9PpzItaU2d+SOnXIha1KSzo+xmoskgXA/dftLOtLwY
         y1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ0ElvDaFvknFJh16UEmutOM0z40lPRkEbiaAWnDULN7XKVMp4/KO3jB00vv4nGzDYLgB16lTyvvjCM6vBcU0GQudZofhUr/hIkvCqMt+cKA==
X-Gm-Message-State: AOJu0Ywodle2oNedGLjl2NiJ7mHKkK3kyTPSPovlMlvxnXVfwPJFn9B1
	7kORkvP/9c14ovQhxkklSApvGlhIbh6a2d9SHEpeXRxS3MqfOjBFid8MN9zefJbbBlrFfWVfr3P
	m7vlSSA==
X-Google-Smtp-Source: AGHT+IH75MxXvR6htgXwyzSB9PeDpIXEOy1VdLxB56cSbT41a2ERr+DRq7K59qj6V+DXn3La6IsbR+DD29dG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:77dc:144c:334e:e2dd])
 (user=irogers job=sendgmr) by 2002:a05:6902:18c3:b0:dcd:875:4c40 with SMTP id
 ck3-20020a05690218c300b00dcd08754c40mr209662ybb.10.1709165763612; Wed, 28 Feb
 2024 16:16:03 -0800 (PST)
Date: Wed, 28 Feb 2024 16:15:33 -0800
In-Reply-To: <20240229001537.4158049-1-irogers@google.com>
Message-Id: <20240229001537.4158049-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240229001537.4158049-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 09/13] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index be10acb40762..f4a4ece551ef 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -467,6 +467,23 @@ def Rapl() -> MetricGroup:
   return MetricGroup("cpu_power", metrics,
                      description="Processor socket power consumption estimates")
 
+def UncoreL3():
+  acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+              "l3_lookup_state.all_l3_req_typs")
+  miss = Event("l3_lookup_state.l3_miss",
+               "l3_comb_clstr_state.request_miss")
+  acc = max(acc, miss)
+  hits = acc - miss
+
+  return MetricGroup("l3", [
+      Metric("l3_accesses", "L3 victim cache accesses",
+             d_ratio(acc, interval_sec), "accesses/sec"),
+      Metric("l3_hits", "L3 victim cache hit rate", d_ratio(hits, acc), "100%"),
+      Metric("l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+             "100%"),
+  ], description="L3 cache breakdown per CCX")
+
+
 all_metrics = MetricGroup("", [
     AmdBr(),
     AmdDtlb(),
@@ -476,6 +493,7 @@ all_metrics = MetricGroup("", [
     AmdUpc(),
     Idle(),
     Rapl(),
+    UncoreL3(),
 ])
 
 if args.metricgroups:
-- 
2.44.0.278.ge034bb2e1d-goog

