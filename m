Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CD92D9EC2
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 17:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697971; cv=none; b=Iv83XXJgZDhpyBJ7sVkFhneJ/7p/xlR6Q6IRpyehQ16Zws/k2QISASkcsABUWcUU7vZ6PSyG8aiw0g9LwVtBLxX66fY4VNHiSd+aLwWRmDhqT13ukh/yumi6DC+BKl5TwBvELsKdWBzeKXngDxcMb30viPzwBXEztLZfRv9NXeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697971; c=relaxed/simple;
	bh=+pOn+zu3ZMd+JYcU1w4+L4lKvgGjOMjt9xp2MKZedUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Na0L7XeI5PGGKH3kJsQIfWG/mjFbAxazy5Zri8Q1cwXX61A5UrqwW/CURr/Gz1N9xGj0NNXJdNcrRSP2wZUaOxOCRL7kaqcoQgxshRbLtKoCxXiSr1vvncv22syk6DDsn72trrpHlJLWnrJ3tcSD2LnKb8EuuJjsxQdRUaDfBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3gBZlsdH; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3gBZlsdH"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99f6516262so13928054a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 09:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764697969; x=1765302769; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymsXPDRF6YZ1D0Jlzoanxx7gKwtKybhdHB3aACDzbKk=;
        b=3gBZlsdH9hT5lEIzgOkoeUIJ0/84ID1k52WrQKjc/ezbEbQpcIdRroCVjK+1j2zHqp
         ErGT/DvH4uOEGIoDBwg5/dXCBChD3vW6znQNOJpeinJ+zdQp06hvo38DWTD1Fbc+BX3E
         P1dkvjVU0u1e4wJiEB8EhBkEx99qPfeboNDPbUqiK+7zsCISZlixHvDbXn/Euy79G5Gj
         MV2oOwG0kEc+lBTKwOVEVWIj31Arn43Cw7C429PgD5Ri0xe6pggSMnHn4GP3wH/NFgZ+
         vk/qQjmAnWgKK1gDOrU90KqR8sLXMJ7c/w32Ez7SSyGb9LUSN7rCtQyzIztclWCnhbmb
         +x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764697969; x=1765302769;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymsXPDRF6YZ1D0Jlzoanxx7gKwtKybhdHB3aACDzbKk=;
        b=ww8WkrybTGa5H1P+13U50vD8UDdNn2vLHFzACqj+Aoq0OsU7War8mdOqM0Dg30x8Od
         S/A6t1Z8IcfsmWGTebOaWl5WBb19/P4LM8STpaMiBqvgmJGYIzcKoKMQ+MZufs00bRBC
         0xGv8blHtj15UUByk9+HjB1hYax90jgLpxvjkTg7Qm+UXIgFQG1+5gLKVE+3mjhhBiQz
         Aw7ee8He8Rxoh2ZZv25mkMsXNeTzVVkLae0hdQJiB/PB4AN1WwXLCveoEFwgNvh5axOA
         rAzK/OmryPfgeHTn7Vu5uuATKLGTHJSSOibdie9180w//i0RBrmb1Wsq+xtZyCnsA4wA
         53NA==
X-Forwarded-Encrypted: i=1; AJvYcCUkRAaUdqTr5dRv460AdD4AC7pMyE2t3HYNiOMHFFRrngds7FFevVzj+VWY5xQpEsi6gc/t5PR8yAGejS6yc5bt@vger.kernel.org
X-Gm-Message-State: AOJu0YxP24X4nJ2WGXP5dCYHpcwk20b/piV6wMpIGBnvNH6WqQBoHb03
	zanSN5fuayUEKeYPGAvMdPPKL2smiVSjx8PPZoRZ8ye9oiyEznCKJUkuf+tTPIboM+kqTcnp43J
	zzGoiXsE7LQ==
X-Google-Smtp-Source: AGHT+IEHfjaTZRZfDMJYPck6kXnX1JBWaLcqkkhslMQleRPP0Pkq3lI5GI5FsmPDNJcncd51cq2pjG5tjEd5
X-Received: from dybpz21.prod.google.com ([2002:a05:7301:6895:b0:2a4:7f69:5b62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8007:b0:2a4:3592:cf76
 with SMTP id 5a478bee46e88-2a941894aebmr14804539eec.26.1764697969412; Tue, 02
 Dec 2025 09:52:49 -0800 (PST)
Date: Tue,  2 Dec 2025 09:50:16 -0800
In-Reply-To: <20251202175043.623597-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202175043.623597-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202175043.623597-22-irogers@google.com>
Subject: [PATCH v9 21/48] perf jevents: Add uncore l3 metric group for AMD
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

Metrics use the amd_l3 PMU for access/miss/hit information.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/amd_metrics.py | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 2d1d25cb40b2..6542c334a82b 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -316,6 +316,24 @@ def Rapl() -> MetricGroup:
                        description="Processor socket power consumption estimates")
 
 
+def UncoreL3():
+    acc = Event("l3_lookup_state.all_coherent_accesses_to_l3",
+                "l3_lookup_state.all_l3_req_typs")
+    miss = Event("l3_lookup_state.l3_miss",
+                 "l3_comb_clstr_state.request_miss")
+    acc = max(acc, miss)
+    hits = acc - miss
+
+    return MetricGroup("lpm_l3", [
+        Metric("lpm_l3_accesses", "L3 victim cache accesses",
+               d_ratio(acc, interval_sec), "accesses/sec"),
+        Metric("lpm_l3_hits", "L3 victim cache hit rate",
+               d_ratio(hits, acc), "100%"),
+        Metric("lpm_l3_miss", "L3 victim cache miss rate", d_ratio(miss, acc),
+               "100%"),
+    ], description="L3 cache breakdown per CCX")
+
+
 def main() -> None:
     global _args
     global _zen_model
@@ -350,6 +368,7 @@ def main() -> None:
         AmdUpc(),
         Idle(),
         Rapl(),
+        UncoreL3(),
     ])
 
     if _args.metricgroups:
-- 
2.52.0.158.g65b55ccf14-goog

