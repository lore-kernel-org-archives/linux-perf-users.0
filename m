Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AFF18784E
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373081; cv=none; b=Lp9Ym1ZlFv6jitgM6SQTfQgd0UgTqU+1z1LOBZEgqJMglRIDi+4IYGn1abP9QS4jQPFL2OiSNbeXzhDqhOyKiiATNOeMiPk2itB4gfHmyB1B8eFcPQ5l/hv0ULtLz2Q1DlDeDmXkMhWliLit8ZdX0MqIj2+pfLDYp4HWUZDSFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373081; c=relaxed/simple;
	bh=hcyDyu2AAx2yOQxhwKjW3g3fWb2hZiCnyWRjsR0yqAg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gkg23MwYN3wVkml9LGtM43ZeimtCt9awO9RgGpPyN0Kop+58n+6ZpnQUgOWUIrLDfvP8ZRgYGq+1qRyhNmshV754CYrgChcxpv156BmJrSqBu5ZG0HkxgJ0UW/9i+L8ixtI2gimcNMKJ53fzZxJzVjkbKmFNteE6wnLo82NKTk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vo3jluPn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vo3jluPn"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e163641feb9so2853888276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373079; x=1727977879; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d3mEBXTFAkXOt/0jXmoHq8A5MThtzMol5vV0vNxrEOU=;
        b=Vo3jluPnG13vDWHxdPJOL+MqcX2tHa/Z3ozOAbrVzIbBtggeHqTUaQ7UP6OSzsX/8j
         nRsNR+d4yqCozoHsI6ykj0fUAcLxLHUQfRlx4MZnPz7OydqO10vsG7saHtIO6bBZ9l9V
         zMdW0lXgRi6flOtUvnIIVwcSPF1D0RQPKcQy8YG5LgK4Z+6Q6kh+0yIBzjxMVHLBjy/x
         BZtxWgYU8IAq3KBGrBcV2DGhcE4OH1XANo+GZF+42+G4WGpQFFT5yqnIoU8mt+HMafbq
         XPZfgE/8G85UWRRuloJFVO9aT05YGF8FauBpTb+E/bK/oTaKs1H4QzlcobtgqcfyBFZQ
         7+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373079; x=1727977879;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3mEBXTFAkXOt/0jXmoHq8A5MThtzMol5vV0vNxrEOU=;
        b=PJEr/jOkSH8tmYlLAxDAyDxktmfpMqLM+ocH2wt/j6XRWjd0kpdU7kpVpQwtbm4cY7
         Yv81ITjbGqYH7SWwlrlCWpfphm99mYcc69TX/RY1lB4narB3abka0EPvYNJFub3AR6dG
         92seejqSXxR4Rd5NyTprpTk0hc6MlRuskIQwtmX2OFKW2Z9KY5PbveE77PFDyN5qPYbd
         dufqvMytxRvWy1cFNSmfTa6fwaHRCsc2F+YPoCPaXkO1avn/cPudy4jDT/JnI4HB4yPh
         l/2POnxEVX5i5hKofg4EBK641Qg5yNlkPZwrgmlwSN+83ydb0g5IJYmom9Z65cpyxb4Y
         jSKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8kL38ykzVuxGTIhpTTwSn2548EFteikntDdm5mDOQBPjBBoMa0ms6A39B5yG4rlcUynappHVGMfaKcbPsVloA@vger.kernel.org
X-Gm-Message-State: AOJu0YzoonvRGvi69+8I9J6pPkmUgc6R7qbsLLu2K8c3cFqX9fmDQGhP
	Yzt0lhICQqeRpEoxk9c2HzytsLn884ERBhfnyxpAduvfG21+NaSvsLJE5Or75ySXbtpdW6jU4fs
	MvrIsPw==
X-Google-Smtp-Source: AGHT+IH1wggxrnaaQaP0ElwjeL2ieDZbEYnGxVFD3HNYP7DsBQRho+VQpaefMyIMeaodQTQJsttOfHgW47UU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a25:a409:0:b0:e20:2da6:ed77 with SMTP id
 3f1490d57ef6-e25e6295007mr5584276.5.1727373079014; Thu, 26 Sep 2024 10:51:19
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:28 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-16-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 15/22] perf jevents: Add Miss Level Parallelism (MLP)
 metric for Intel
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

Number of outstanding load misses per cycle.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index dc14fff7abc3..8c6be9e1883f 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -593,6 +593,20 @@ def IntelL2() -> Optional[MetricGroup]:
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
+  return Metric("mlp",
+                "Miss level parallelism - number of outstanding load misses per cycle (higher is better)",
+                ml, "load_miss_pending/cycle")
+
+
 def IntelPorts() -> Optional[MetricGroup]:
   pipeline_events = json.load(open(f"{_args.events_path}/x86/{_args.model}/pipeline.json"))
 
@@ -800,6 +814,7 @@ def main() -> None:
       IntelIlp(),
       IntelL2(),
       IntelLdSt(),
+      IntelMlp(),
       IntelPorts(),
       IntelSwpf(),
   ])
-- 
2.46.1.824.gd892dcdcdd-goog

