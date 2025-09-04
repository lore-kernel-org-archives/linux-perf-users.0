Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996426CE0E
	for <linux-perf-users@vger.kernel.org>; Thu,  4 Sep 2025 04:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756960878; cv=none; b=GXJoHGcHZe745UId/Dy+lgwWmxz83secS694FVWNu7cA6R8H3TD0f8wpWIJeK42STDDKKOFFzflr06dE8+TEDzOsprGYAjs88Wwegr7v01JntaG4YeM2Xp3PQKfkyyoF+RlnVvjHAducWPDnRAqlMkAks0cGzVcHOVRX9Kj3ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756960878; c=relaxed/simple;
	bh=DGrU1rY5HwKPFf/jKSY3EHnF4vVKF3aEB2+Ri1iicow=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=hOJzIFDX2WBBOHWYWg5KD/vS8gJgFqjV0vXUjD70wqGMX072zych/IAhFDKAuj+G+WwNHA8f0OH6doiP8Xp815CeXqC+BdxGYbZAxV7B6MydTn/qo+RIY93ebUCvlu/NWDMEGdpN5wmdjbl9jPwdOGYferPxQ+UHZUYT35Q6Mk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XB7yMj44; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XB7yMj44"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-248eec89618so8541445ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Sep 2025 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756960876; x=1757565676; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8J/lSfrT/Zse7jOcyUvktlEEeGzgdaoDiuhDp7bGg=;
        b=XB7yMj44cFxs5V+UqD5BMuBhsFExfm5RoVDktmRaCuHYoylZY07f15LPg9apKAU6tw
         kaC4qGmvZgMY73Pdxpcb5U13sAvDp7XJOdbzfFOaNBX81EZFW5omRAWq8Ns5g2M/I4DC
         +f6VtTlsbRjXHbeL6s5YcG7g178K/CDp8sDwap254qzJ7fQBj5Exmxzmg24SURTx4Ghw
         Ys0obb+xrrwQbU1r6caLnZLhiJnmqdzsKZHiTUc1gCYaBLacqxDg3hGQ3XF7cjquWrcq
         PbVucYYExKUsxiQZOLlzpsX3SNUR88sZ1FKKMOj+l2VL8xM3nnKZj8RA8BbP5j2UmTaa
         OlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756960876; x=1757565676;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dc8J/lSfrT/Zse7jOcyUvktlEEeGzgdaoDiuhDp7bGg=;
        b=dIkAmFZUHbfIv656hLgDAqAqjsfhiaFyGUMd0LZN7RFUjyq5rD2FQrgmCFia/2CgNb
         3hwpTHNCeNDKwnHlrVaMk5oFU6UGLCgmh/XxA9L1aerOPBuwjGgCzPyT5qim/JZ9ujkC
         +4PSz91G3vijLUt2Dp2MHzkgx3USFz6aBcg8t1f0xldZX7Km9bJh8MVZCjKB6NzovH7O
         CmsrDMlKNqojxe2h31Kf/tWvxH3hSVKU/5rTnS9qlrsIFIOjY61tJ78L9LEMl5ivs1CO
         QrrzHFC1sDgdxg9Ia/tOceBlDs31oUr7sEbp13iH/u4J5DMGegcievGrqG4m0J7Gd/uT
         llUA==
X-Forwarded-Encrypted: i=1; AJvYcCWoUIsEdFSwZ56/5zOxeGP1F5bIN9Bxc1QgfZEwscToBYZpTgFrXhBmQqEamgpCpaxdKnjsiryPn/2HmIDWh1Ql@vger.kernel.org
X-Gm-Message-State: AOJu0YziASWWW5yMWKWV+nh4PhVCek22JIjM7h6m9ymPsugJHGPOUp1/
	jyz6ViwynAJZ4fISbR0NiRJMt6L8IS7aomiyCbhF3O+5RCoSqwFEpUDRopY4HWh99cNtJIF4MdD
	zI+noj7AzYg==
X-Google-Smtp-Source: AGHT+IHPmc7iwLBJHkLwlvpUXlXB1HQEMNXkq93kwZbAReOSDquHWYNpl9VKjtBZ0JeiLgPQf/c0bawYvYvA
X-Received: from plbli6.prod.google.com ([2002:a17:903:2946:b0:24c:a22d:44d3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:32d2:b0:242:a1ee:6c3f
 with SMTP id d9443c01a7336-24944871fa4mr187409025ad.4.1756960876363; Wed, 03
 Sep 2025 21:41:16 -0700 (PDT)
Date: Wed,  3 Sep 2025 21:40:46 -0700
In-Reply-To: <20250904044047.999031-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250904044047.999031-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904044047.999031-13-irogers@google.com>
Subject: [PATCH v6 12/13] perf jevents: Add context switch metrics for AMD
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
	Benjamin Gray <bgray@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Metrics break down context switches for different kinds of
instruction.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index 6f1259796c8d..a782e41dedca 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,37 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdCtxSw() -> MetricGroup:
+  cs = Event("context\\-switches")
+  metrics = [
+      Metric("lpm_cs_rate", "Context switches per second", d_ratio(cs, interval_sec), "ctxsw/s")
+  ]
+
+  ev = Event("instructions")
+  metrics.append(Metric("lpm_cs_instr", "Instructions per context switch",
+                        d_ratio(ev, cs), "instr/cs"))
+
+  ev = Event("cycles")
+  metrics.append(Metric("lpm_cs_cycles", "Cycles per context switch",
+                        d_ratio(ev, cs), "cycles/cs"))
+
+  ev = Event("ls_dispatch.ld_dispatch")
+  metrics.append(Metric("lpm_cs_loads", "Loads per context switch",
+                          d_ratio(ev, cs), "loads/cs"))
+
+  ev = Event("ls_dispatch.store_dispatch")
+  metrics.append(Metric("lpm_cs_stores", "Stores per context switch",
+                        d_ratio(ev, cs), "stores/cs"))
+
+  ev = Event("ex_ret_brn_tkn")
+  metrics.append(Metric("lpm_cs_br_taken", "Branches taken per context switch",
+                        d_ratio(ev, cs), "br_taken/cs"))
+
+  return MetricGroup("lpm_cs", metrics,
+                     description = ("Number of context switches per second, instructions "
+                                    "retired & core cycles between context switches"))
+
+
 def AmdIlp() -> MetricGroup:
     tsc = Event("msr/tsc/")
     c0 = Event("msr/mperf/")
@@ -619,6 +650,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdCtxSw(),
       AmdIlp(),
       AmdDtlb(),
       AmdItlb(),
-- 
2.51.0.338.gd7d06c2dae-goog

