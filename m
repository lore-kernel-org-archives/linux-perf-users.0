Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089053EA88
	for <linux-perf-users@vger.kernel.org>; Fri,  1 Mar 2024 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709319404; cv=none; b=lAeULr3FEWglxrIoC0pZrxNUhHwqn1IgWtFyPjUwGCFzAlg5lDarnM0R6VKvoq4PZJ78c5GntewX9A2lUaURnhzLfRnPCwOo52GH39BrUAfK2OlLEnm5HnTv7aLQCklgL8RAKBLkH5EGCSALCJuqnKgA0PKbmmu1tep4VQXaXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709319404; c=relaxed/simple;
	bh=g1aUKyrw7DvdgN01eaAjL5EDa8+hBV/p20E6Ldm6SxI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=A4ceDh66dSbku4oNGXhmw7OzMrT1aCs1tCdGglJplk/+6og5Z+r/GqRpu9lKaXgw8PMFXleFDG3Ik2BJSP5Y7V7vwEERM2RrwI9JkZnCajblM5XKN5kzsDIBFioSFm1CUXPYp9jAPXbIKITczYKUgTBTQrhwpFbBjktTvPOZSuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pwl7JyU6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pwl7JyU6"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso4114447276.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 Mar 2024 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709319402; x=1709924202; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z8m41PXVl/EgCm4ozUPka7O+Ter4HT44OkTHNVK9970=;
        b=pwl7JyU6cGI+yxVc+r5x4UlyezDJq+503nQIbufqWvxoyj2cWEFhJSmTGpU5lLWTqz
         rmL9a9GCBLdLBhrX+90X1Vx+O/dNigkM2QmOdSQ9e3+ygqENydZwtRq79oqz9Ustoph7
         gzl9SZYJKvZDaLFzBDjJV4ujoPtV+yqTFAam2yKZGtwvLX4ga9tv+b+hG8UUeeapoyCh
         5JUv4BQcJMjrkigKANFPZb4WlxddY9tlxSZ6n34n8vHceHhUCvk9I20S103bxUu5tjUZ
         dCm5pAyaBGZQJRtsYML7L2MRmTRdml6pbFH2jIrR+ofz9rV5X4eLnuiJyr3lq1x7fl2Z
         lxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709319402; x=1709924202;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8m41PXVl/EgCm4ozUPka7O+Ter4HT44OkTHNVK9970=;
        b=lPZhrLvZt6SuwbwshYwDRPP2BNJcDHCXCLXaQ7751TZBCEXMEWX9/46RpQbIHSWnRP
         aSwHt9cIzMaPbSaerr1JcMRK3ZhDqtUEhdR9jnALwcV38XDsYtbZoIpaLaCnqV2INJJz
         TU99vKzwzjWRFQj3rCWsGsO6qvn9T9Bf5S63VKUEhEAQyI8RQLM9aCwRnNaOgaZU5buN
         JD4/S076+4ryKrtxOwtWKArr1mIEkHiPe9zh/vX06cMBl/vzeIymaxPwhYPYpx0ta8Te
         vsB38YIF60N8uwDymp5asPe5P/vL1YHTqhJ/bKU54tlal8HGb1gXaex7yQ05+Fn1vz8N
         4QeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMWkSFNq8YT2DQc4nOmm4Qm+GFu5R021+ubOAcE8X4Q5U2vpFIexutxAb5+G0v/APryG8XXvdrRbOQImCuGmtlN8L1Ylnbp4rVom6hIFyb8w==
X-Gm-Message-State: AOJu0Yxj8ZPtzynCvx4HRu9QOw0pLUweGMEgnek4Qt5GR3YXZ6yYCjN4
	SK7LoL92SkN5zyfuA7qHmCWgJ+6Llj2OdIUVb8qErpMtDQZIkmAKktAqEWKkTbwyZaQs3ZvPrLE
	5WUAtzQ==
X-Google-Smtp-Source: AGHT+IHszUKUo379JPDZ9uRqjQAesqFxQ4RJ6sQjSKFJqvbovVon6KJGIBP96328fmqpnkcer+Ejzja0pT7W
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:6902:120a:b0:dc6:f877:ea7b with SMTP
 id s10-20020a056902120a00b00dc6f877ea7bmr540903ybu.9.1709319402300; Fri, 01
 Mar 2024 10:56:42 -0800 (PST)
Date: Fri,  1 Mar 2024 10:55:51 -0800
In-Reply-To: <20240301185559.2661241-1-irogers@google.com>
Message-Id: <20240301185559.2661241-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301185559.2661241-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 12/20] perf jevents: Add context switch metrics for Intel
From: Ian Rogers <irogers@google.com>
To: Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Weilin Wang <weilin.wang@intel.com>, 
	Edward Baker <edward.baker@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@arm.com>, John Garry <john.g.garry@oracle.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 55 ++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 6f6d1cdf6649..49e51c33c0f7 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -272,6 +272,60 @@ def IntelBr():
                      description="breakdown of retired branch instructions")
 
 
+def IntelCtxSw() -> MetricGroup:
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
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_LOADS", "MEM_UOPS_RETIRED.ALL_LOADS")
+    metrics.append(Metric("cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("MEM_INST_RETIRED.ALL_STORES", "MEM_UOPS_RETIRED.ALL_STORES")
+    metrics.append(Metric("cs_stores", "Stores per context switch",
+                          d_ratio(ev, cs), "stores/cs"))
+  except:
+    pass
+
+  try:
+    ev = Event("BR_INST_RETIRED.NEAR_TAKEN", "BR_INST_RETIRED.TAKEN_JCC")
+    metrics.append(Metric("cs_br_taken", "Branches taken per context switch",
+                          d_ratio(ev, cs), "br_taken/cs"))
+  except:
+    pass
+
+  try:
+    l2_misses = (Event("L2_RQSTS.DEMAND_DATA_RD_MISS") +
+                 Event("L2_RQSTS.RFO_MISS") +
+                 Event("L2_RQSTS.CODE_RD_MISS"))
+    try:
+      l2_misses += Event("L2_RQSTS.HWPF_MISS", "L2_RQSTS.L2_PF_MISS", "L2_RQSTS.PF_MISS")
+    except:
+      pass
+
+    metrics.append(Metric("cs_l2_misses", "L2 misses per context switch",
+                          d_ratio(l2_misses, cs), "l2_misses/cs"))
+  except:
+    pass
+
+  return MetricGroup("cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def IntelIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -633,6 +687,7 @@ all_metrics = MetricGroup("", [
     Smi(),
     Tsx(),
     IntelBr(),
+    IntelCtxSw(),
     IntelIlp(),
     IntelL2(),
     IntelLdSt(),
-- 
2.44.0.278.ge034bb2e1d-goog

