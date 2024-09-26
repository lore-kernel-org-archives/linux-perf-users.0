Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E59188911
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373098; cv=none; b=ex9olx8DbCY6pwHnYuXmVE+jv1+YjkpmuhQVDwHz3PmNPHdp7AuDxs/KTJMQ86v1SXs9ysgNDELZrqVNcwdHKoUZiYhsQmlrny3TfupAsmUVnq49KjhkDpnYEAAimrgcvWCWijePb5BDnPuQP8+c+GRU9rEUr05nNOIaT5LZ+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373098; c=relaxed/simple;
	bh=Ls3BV45TZcAZatf7hz/8jKq+TlX9gDn82lEPiNxKmIk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=svkQUqZJeljXEUrcOE1pHNGeKkXOFjFHMzkEk4zE3pRVCV5xo9WW4sQvmLcSye225Ii87m9LQN4AA4AjPnnv2KlM9No7P7K/iArLkk+RY3cktyzjgfqniCYpt9hI5kgZAQpWseapOI56QZZKX3GdpP30xHYYtH8g68ogX0DThj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcbnQ+/A; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcbnQ+/A"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d7124938d1so26123697b3.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373096; x=1727977896; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ib2PVE8H+9AGyufbgRCqenlI2T4GVXk8qqbLWLe6R1s=;
        b=CcbnQ+/AcB5/sH8fqbBOf/oyqClAD+EL0eqLt+7ikuo8TVIXS0wqi/68MFQHTKL+Uy
         /jw/dVz+dbj5lQPsHUhOCC8X8QmB0UrC4xYdJqlc8X/8UKsyaOGTUyhUsogxb+DJ+D31
         JsDyIJmH448UJLvBwGnajOfosnVuyEeSpA+7+i2WMzdHbyMkesR3ZAWU4q4uKPcCaUJG
         u3afojYP6nor3JNQzjLRnkKBrFUHVrR5WvzAHrE3MBzbhZLuSHD7qLwLNwmDJiWYmY8E
         BQyEqHt4H+J48S3ZOJ3QO79eWuNlybtUgVRHJSGBrVAOjyB1D3RjtaqcLOJ9paBdmeiJ
         Vn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373096; x=1727977896;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib2PVE8H+9AGyufbgRCqenlI2T4GVXk8qqbLWLe6R1s=;
        b=oiMJpFUVN/mTpiW2MdV3KmukJ7zmcVf7ipMCEIfLYGrz/xsrdZ70Ifs6/DS5O0vGeh
         ormV1U8prCH8K21JpYOofj3yByl9JNJHF4+15Qq9QuA5IfE6FGoJ0zfuS0eSTQrf0jpa
         kvhN7AKdmXZI6FAOBl7473z8kjcC44mBYHfPoMOa0TrDVxwyH2ZIs5mfxjC62bK5uVpy
         hYn7Y8HZuIjq8OjqWahRg8eDGaVTZ+BzprRUfGqcpVP5jTRL2lUi2aNpSomERgjtI7jS
         50mRjkVqHShClfHVmTpPzTtHGzdcNMtlzojJr4e0+0sHFB1XteZYCc6hJi7C71c3trZn
         cwkA==
X-Forwarded-Encrypted: i=1; AJvYcCWmBY/pY7/RmFLn/8D/s2JtV5tCQI+7sOY330rF0ysmOlO6ozzGGeoV2ghLlw2za6O+pXX/YIcJfQ1wA8J2S4bX@vger.kernel.org
X-Gm-Message-State: AOJu0YzYQQ0VDLvNKO1TDzKarTj8evrYVgBIvaX65f6AH9OGMvfFx2VV
	iKDUhtUe6ArXz0k2WVpILWfmFlr9AxARRWX/lzkrLZ26OLuSjOaMilpCeoP9yzRNoBV+7/qqPIV
	tXMEw1Q==
X-Google-Smtp-Source: AGHT+IGIGYU2itVrBwRCZqwxpU9Mv+8tKNEFB2tNcgZikidnBmP88FvNQPNNK50LYkpYnFHCKzZoom7Wj486
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a05:b0:648:fc8a:cd23 with SMTP
 id 00721157ae682-6e2474e176fmr53217b3.2.1727373095880; Thu, 26 Sep 2024
 10:51:35 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:35 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-23-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 22/22] perf jevents: Add mesh bandwidth saturation metric
 for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Memory bandwidth saturation from CBOX/CHA events present in
broadwellde, broadwellx, cascadelakex, haswellx, icelakex, skylakex
and snowridgex.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index 8e1c0bc17b8a..a3a317d13841 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -990,6 +990,22 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreMemSat() -> Optional[Metric]:
+  try:
+    clocks = Event("UNC_CHA_CLOCKTICKS", "UNC_C_CLOCKTICKS")
+    sat = Event("UNC_CHA_DISTRESS_ASSERTED.VERT", "UNC_CHA_FAST_ASSERTED.VERT",
+                "UNC_C_FAST_ASSERTED")
+  except:
+    return None
+
+  desc = ("Mesh Bandwidth saturation (% CBOX cycles with FAST signal asserted, "
+          "include QPI bandwidth saturation), lower is better")
+  if "UNC_CHA_" in sat.name:
+    desc = ("Mesh Bandwidth saturation (% CHA cycles with FAST signal asserted, "
+            "include UPI bandwidth saturation), lower is better")
+  return Metric("mem_sat", desc, d_ratio(sat, clocks), "100%")
+
+
 def UncoreUpiBw() -> Optional[MetricGroup]:
   try:
     upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
@@ -1052,6 +1068,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreMemSat(),
       UncoreUpiBw(),
   ])
 
-- 
2.46.1.824.gd892dcdcdd-goog

