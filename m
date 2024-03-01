Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5B3CF72
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318889; cv=none; b=ctUx5g4rjzBZ9JOVNO4TuZmqnCLUtr/hJn2QntZTXxmSepPtnGtWVXFD7GQO6LZU0MK2XvA3srTumOyBiZizIy2nWfVOwHsUY3ZuQOD1sFtcEjjgajoDlL7p+yzzU+ZZUSQsDxM68eYHDu/BfM1IGBvERVE+nMOIp+b1vScxmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318889; c=relaxed/simple;
	bh=xBfxlNT0aaXEMy2J3656vmd02rMeN9x8F3Ypxz5k1Kk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Aqgw3XUU0S0gvT0FffNO2T9ljOaj1OQ282GzlB7hgsaSrQlOd2iriTOv6A6e9xr9ALkz75dx2Llv3phYGswJKDd7lXDN+ByvOcwKvJeWrxLPKCBlrgW5Bp/Uf4ipMns9dCOl4zT4CH048jL1u3ua9r8Sd2A4sE5pOuSd5xZui9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ahg71M3n; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ahg71M3n"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64b659a9cso4614288276.3
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709318887; x=1709923687; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=Ahg71M3n0naNsQXjrkAS1qZhpfiRGx9o2Y15Pl2hEOyNdnM6frSa6/BXytIQvfbDKM
         2SJ8F+8TMQ5W2HdVnDzyk0b7A4xD36/aEx4NTITmSg1cakySxMxS57NtE4YlgG4ZUmBB
         VBgtlrPQc4NH3/XCT86vvbPJEWEoFDeRr0brz6vSwHXBY+C7ZLsOVK7l6UxN8FfGUiTI
         4QDxqBcpdZaSkRM3eG5MiezkU5hmcJfPLSS+URNfA4ZGbsykjAmJxtTsQTHgzvO5Gxfl
         ovdr4Zk/NfzagBKQIDEkMcRwauO6agfPRUxqtv2ZS6A1p29hFUXs03IMnPlPKZDv4uQj
         Nx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318887; x=1709923687;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnw8j+u3lnjVu4UTXXzRJGFzX9SHr9I3FGbOrJjWHHs=;
        b=l1Y1/jaiQIApqABP3ztGBgjxUOQZ8HYqhgSjNKAdOkwViU2FlRf6xGSQa0ZuKSuNlp
         b/HzKqQhfTRUEz9Qy7RIY6FBZL00NkulepRnR/D4dS29KUPl8fpZan8ROpGMCQ2T/UmX
         9jALb1g8rBXxHIGChbeOmbzGKPcFdS2A2/MVuucY83ftz2pn8robd1q8ZCPr5cBmBPJ5
         cGgFVn2td4sxWtD8/RfFh5DhOrYCoosA3EBEicDENSllvhTiuCBxOOWYHiD9mrtMAAmC
         HHfOwVUS05CoG3twDJo6Ty3s2yi5LdUS5l9lgE+JwRnIDI/BI8BjuDr6TVSzSgWEkWcj
         WKjg==
X-Forwarded-Encrypted: i=1; AJvYcCU5Qc/3O7s9PcYHjyPNVVu2oG6Ch12uuEIeaj0ynbhKJhZh1bb/s8LEMQe64/CjB/Jc4tqS556PfQXAnqFlN2xeBubkrw0GsonfEc3Vz3/HMQ==
X-Gm-Message-State: AOJu0Ywv065n2rlb+ERZ69obN6ZGGcibatgvvNHy3mtSCSzcBQpiUiSd
	smPqQQy1Uibwvbfpa0ckwq68BMRQJyJlI+mfaZNhgCyIht2Uf7jeg87BZ8WiKU5SsI3aT5GtO6H
	k9g/w1w==
X-Google-Smtp-Source: AGHT+IF3gtdTZX8zZ+qhGN79j9W6Px3w2MCjga4xswXwduGdchfGJAS2dE10Pyq4+3LxxdG/Wm87j4Qni4Ss
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a25:c782:0:b0:dcd:88e9:e508 with SMTP id
 w124-20020a25c782000000b00dcd88e9e508mr536559ybe.5.1709318887193; Fri, 01 Mar
 2024 10:48:07 -0800 (PST)
Date: Fri,  1 Mar 2024 10:47:34 -0800
In-Reply-To: <20240301184737.2660108-1-irogers@google.com>
Message-Id: <20240301184737.2660108-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301184737.2660108-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 09/12] perf jevents: Add uncore l3 metric group for AMD
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

