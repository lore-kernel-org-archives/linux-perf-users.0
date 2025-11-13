Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815323101D8
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Nov 2025 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004102; cv=none; b=EtlDllKepX/OPiKQYJz6frNgBEGe0rydGnBSqFWK8UCtmnJ8tsl0h4vz+cdOzYCYjkRChDPr0C4t0yo7TXZtZJjmJ6yWk2c7bi3cnMFFI94ZodrQboVh0QMYX75Yy2Xv0rXkqQgCrlhHxUb7pe+gGizUBud9sufq+aX1AB2zUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004102; c=relaxed/simple;
	bh=yg0mt3Fzot10P+eNDcOUbH/iz4GunqXxO6YAxrwdE44=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CqyRFCPCxLutlNmzfAjUWml3v8aoeB1GvbidtjS0/XwMjR8Hw3n9NK5tYN6q9sCZ2PhpGnosQhjlOEmLQGs4AM6Xu9MOIiFTNVyzmSUEvxzDYnosUuMLxZCUpEBBQKs5aP7BxlV3OOwKD7u350G0WeQJ+Ggcr9jwzyzp7mVDrcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wTKpKdRm; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wTKpKdRm"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-bc349a8a3easo301457a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Nov 2025 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763004100; x=1763608900; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reofRYC+oJf3mFk6RisvPqv+0Lly+TkhvyT/wiXYQcg=;
        b=wTKpKdRmEf7Q4f/IFvlOOvb59yj8CzCuXZnd244JOF2ngeDxP5J+b1NFSENBOfWtMw
         93/uH/XmMVerwhf3jGvgpC7usQ3ftiVs3xJTksQhY1tSlEjKJMGSHh4UpbNkiQtSkxZH
         ULVSnEFyBrfO/qEWKPMwtL/Ej9Z9uzpx5WVhq2Ack4I06Bu3/LR9ZapDtx3kNMPXOiQf
         b5D9o2ySmemtcdpmuBfHCR6txfJfA0AnzX1S8Y0QpUY4OF/GPCqUFzlCtX9sU4NRFFcH
         SB5ZXljtbAO8ae3frYxN3b4KzPB8Eq0Q71TsiepFH+GBq+v3kQZ5kaUtyGmRM0QDvxlk
         5tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763004100; x=1763608900;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reofRYC+oJf3mFk6RisvPqv+0Lly+TkhvyT/wiXYQcg=;
        b=Al6tX2WLBu/3MyA+kLUdI2+kR70RChDipwWgYAAdljnNWCDanM/3z+KBrNu78qO+vM
         reE8H5v72Ja9o7Ye5f8bDQ/unhKfEqb7jtnb1/iH7VxeFt7gRBqy448zmUaLuCTTERXA
         FFqBk8ah+u18hAkzTUTri/C0+ytssB8ZBqp+hgjRIc29N8WL7JFsCSGVklUW0lz2VyFj
         iSjaPv1QLQEilGT8aGR/yvmupZ1jg8/ZXVEc44SPkj4j1PE/oMpTd61Uol/sM/oZIjd1
         xqY1lvCuaJSGhrkk7Z0hFBVzEp/54UuNpDJefcj9aF7/MW2HSg2Jle67YLXxJ6CZJ8LG
         Nc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgIoPlR9UhYkseC501KiYnlb1hyZ22DAV49PK6HjtLD8r9KnhLevYLpj9r1jAsQhgfEUDMXvaCvZJs/H906kQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YxuuN5LNlPWod/uXCKlCc/xl/w9QWEGjJHhlHinRlb4Id7isYKQ
	tv68mgVQyB6n8EAit+46mF2zLwRwk70oXXLrHKQEezcrdWf/xtktk5f7K9YkgaKY5hGHrJ7cVs0
	JBPiOIbjRGw==
X-Google-Smtp-Source: AGHT+IFFURIhDsoWperE6E0wEJSVGWWpEc1yQCNVIRrUkX8FAAk/DyUqxwrEiSLSauum95UUhWMUe3eG7LIc
X-Received: from dlah19.prod.google.com ([2002:a05:701b:2613:b0:119:49ca:6b93])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e788:b0:295:560a:e499
 with SMTP id d9443c01a7336-2984ed2b60emr69691935ad.5.1763004099859; Wed, 12
 Nov 2025 19:21:39 -0800 (PST)
Date: Wed, 12 Nov 2025 19:20:12 -0800
In-Reply-To: <20251113032040.1994090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251113032040.1994090-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251113032040.1994090-25-irogers@google.com>
Subject: [PATCH v8 24/52] perf jevents: Add load store breakdown metrics ldst
 for AMD
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

Give breakdown of number of instructions. Use the counter mask (cmask)
to show the number of cycles taken to retire the instructions.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 75 ++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index d748b5c1d791..53f7c2198147 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -279,6 +279,80 @@ def AmdItlb():
     ], description="Instruction TLB breakdown")
 
 
+def AmdLdSt() -> MetricGroup:
+    ldst_ld = Event("ls_dispatch.ld_dispatch")
+    ldst_st = Event("ls_dispatch.store_dispatch")
+    ldst_ldc1 = Event(f"{ldst_ld}/cmask=1/")
+    ldst_stc1 = Event(f"{ldst_st}/cmask=1/")
+    ldst_ldc2 = Event(f"{ldst_ld}/cmask=2/")
+    ldst_stc2 = Event(f"{ldst_st}/cmask=2/")
+    ldst_ldc3 = Event(f"{ldst_ld}/cmask=3/")
+    ldst_stc3 = Event(f"{ldst_st}/cmask=3/")
+    ldst_cyc = Event("ls_not_halted_cyc")
+
+    ld_rate = d_ratio(ldst_ld, interval_sec)
+    st_rate = d_ratio(ldst_st, interval_sec)
+
+    ld_v1 = max(ldst_ldc1 - ldst_ldc2, 0)
+    ld_v2 = max(ldst_ldc2 - ldst_ldc3, 0)
+    ld_v3 = ldst_ldc3
+
+    st_v1 = max(ldst_stc1 - ldst_stc2, 0)
+    st_v2 = max(ldst_stc2 - ldst_stc3, 0)
+    st_v3 = ldst_stc3
+
+    return MetricGroup("lpm_ldst", [
+        MetricGroup("lpm_ldst_total", [
+            Metric("lpm_ldst_total_ld", "Number of loads dispatched per second.",
+                   ld_rate, "insns/sec"),
+            Metric("lpm_ldst_total_st", "Number of stores dispatched per second.",
+                   st_rate, "insns/sec"),
+        ]),
+        MetricGroup("lpm_ldst_percent_insn", [
+            Metric("lpm_ldst_percent_insn_ld",
+                   "Load instructions as a percentage of all instructions.",
+                   d_ratio(ldst_ld, ins), "100%"),
+            Metric("lpm_ldst_percent_insn_st",
+                   "Store instructions as a percentage of all instructions.",
+                   d_ratio(ldst_st, ins), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_loads_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_1",
+                "Load instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_2",
+                "Load instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(ld_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_loads_per_cycle_3",
+                "Load instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(ld_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_ret_stores_per_cycle", [
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_1",
+                "Store instructions retiring in 1 cycle as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v1, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_2",
+                "Store instructions retiring in 2 cycles as a percentage of all "
+                "unhalted cycles.", d_ratio(st_v2, ldst_cyc), "100%"),
+            Metric(
+                "lpm_ldst_ret_stores_per_cycle_3",
+                "Store instructions retiring in 3 or more cycles as a percentage"
+                "of all unhalted cycles.", d_ratio(st_v3, ldst_cyc), "100%"),
+        ]),
+        MetricGroup("lpm_ldst_insn_bt", [
+            Metric("lpm_ldst_insn_bt_ld", "Number of instructions between loads.",
+                   d_ratio(ins, ldst_ld), "insns"),
+            Metric("lpm_ldst_insn_bt_st", "Number of instructions between stores.",
+                   d_ratio(ins, ldst_st), "insns"),
+        ])
+    ], description="Breakdown of load/store instructions")
+
+
 def AmdHwpf():
     """Returns a MetricGroup representing AMD hardware prefetch metrics."""
     global _zen_model
@@ -528,6 +602,7 @@ def main() -> None:
         AmdBr(),
         AmdDtlb(),
         AmdItlb(),
+        AmdLdSt(),
         AmdHwpf(),
         AmdSwpf(),
         AmdUpc(),
-- 
2.51.2.1041.gc1ab5b90ca-goog

