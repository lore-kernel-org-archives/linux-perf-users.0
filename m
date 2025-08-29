Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5B1A5B8B
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Aug 2025 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756438320; cv=none; b=h3iBDsShFvzrI2YUyhIRp8J2E9lL5AT+I1/ZcMmMnspZzoHHxRZCyIVzmoeNVqxv/XQ/H1MxDcZXbyB0D1Q5I5x9g/Y1R6ULQeHJfDyhTQrgRNigtVd3GJeHBN/YsHF+0Z2UFFTi7J8TjmBb168Mb/wsmgTwYe/ufqj3193aVRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756438320; c=relaxed/simple;
	bh=X4btRLWlBKMCbDq20TaBkhH8QJ88/PgYuJR20fzITLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=VEmn6uKibNN1+2GCQ/BsxArDJIh6hWVXr2XEKrwpLy1PoVxiVUz4RChFiXaUa4Y7BM00cEt7bKTWVeNClf3TSHcb4OsEKi2FnvoDaWOsrcz1DbOQAvnyb0QYwhFH3e62J9Lb6+45+EgT/DP3NZgsyx++MA+WqkH4ei/8QhcvT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O38CrkZ1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O38CrkZ1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-771ff6f1020so3094285b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Aug 2025 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756438318; x=1757043118; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/OVMbJgRW/eDVvO/RVDtjvYaZaemVWZQ+ygQFZUFfU=;
        b=O38CrkZ1+Uo1DfcF0zlq8SQdRRSH/jh0T2lwjpfrySo45cGUQPO4Bgt0tTBGDnriTp
         8WLcQQhSpte9eJ4vyShh1YQvWKmIojKxEPLvYtlww3+zsduIlA5PYzBxwF8AGMBpMTLF
         Kfcl1PKgrU+4VbvI85MVxkSVDZwLBHNdD1R0jIQwSag+t+XMSPWAGOaxhNH4dRyBjzr6
         RmAEfQV7c9RtI6LYFeloS/dyOK7uqN02yl4S+B7vzI5Y2r9IJTmgB3aSAdDCktF+vqJv
         QlxYqyFkQERXmQydzFa16HhJPsxE2WpWZQ8cqJ57+WeBi7y39/imOjR5Z8NmqdBRTRrV
         fznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756438318; x=1757043118;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/OVMbJgRW/eDVvO/RVDtjvYaZaemVWZQ+ygQFZUFfU=;
        b=XMxa/aWENwAb/2/PDgzs5cJfahGKk57fQ7zr+lNGEpJyPQGE1+hbu4DDWXfpJdnGUU
         uV6Pps0yF2G+S71DUxFMEXwexRqk3ytZpGV3mL8RXdxbDpXrBVq8e9zlgP+6Hdn/YVVm
         7xPYD+2yqxpkrQzpz87LpQ2Ije8FyPMsIADURWzmp5/Imme2g+sO9wtqDVbvI+lRUHY6
         k/vne4EieCkLnusqvagqi/Ic6G9nRjZ+V9736fg9ePT5LMnLM8wrBkThYrtn7zH8xUB5
         fbE3UDuVmgbV4EDKG7cVJc25Z/U+SHL3U/fcFcaIDYLUBXYMwLRxWk/aqtjUPFWDEFWp
         9Scw==
X-Forwarded-Encrypted: i=1; AJvYcCVBLtFyA/AvOyYwCv4fqVwFiLPhkvv8hGqHWCZXDoy/3cGrWFk6fNVJaH9WEDrOwBx/0wYZN9tRuUwFikMipQRp@vger.kernel.org
X-Gm-Message-State: AOJu0YzlSY3k0LfuIvy3wgBFx4g6ccYQfYmmO7xzqCaeTcJ4KO2YMgXL
	YdvPa8QPdqVPv+yxHltE6nwu4ct5wyX0EvJ6DdYD9xv225VyJUXh6EcbZ8XmOUF9UoQmYmVfzxf
	qj58w3KyGGg==
X-Google-Smtp-Source: AGHT+IGhi52JYXfipG1wyhGfPBLIRE9xiOewfEUPtc/4XnPiRu/83zMdprb9oJxsmjZ5FWUY2C0Sizv1hqcE
X-Received: from pfbeq3.prod.google.com ([2002:a05:6a00:37c3:b0:770:9dee:4113])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:13a6:b0:771:e4c6:10cc
 with SMTP id d2e1a72fcca58-771e4c6143bmr25352444b3a.6.1756438317943; Thu, 28
 Aug 2025 20:31:57 -0700 (PDT)
Date: Thu, 28 Aug 2025 20:31:31 -0700
In-Reply-To: <20250829033138.4166591-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250829033138.4166591-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250829033138.4166591-7-irogers@google.com>
Subject: [PATCH v5 06/13] perf jevents: Add hardware prefetch (hwpf) metric
 group for AMD
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

Add metrics that give the utility of hardware prefetches on zen2, zen3
and zen4.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/amd_metrics.py | 62 ++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events/amd_metrics.py
index cc5dea81e5bc..98dfd5e9bd2f 100755
--- a/tools/perf/pmu-events/amd_metrics.py
+++ b/tools/perf/pmu-events/amd_metrics.py
@@ -120,6 +120,67 @@ def AmdBr():
                      description="breakdown of retired branch instructions")
 
 
+def AmdHwpf():
+  """Returns a MetricGroup representing AMD hardware prefetch metrics."""
+  global _zen_model
+  if _zen_model <= 1:
+      return None
+
+  hwp_ld = Event("ls_dispatch.ld_dispatch")
+  hwp_l2 = Event("ls_hw_pf_dc_fills.local_l2",
+                 "ls_hw_pf_dc_fills.lcl_l2",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2")
+  hwp_lc = Event("ls_hw_pf_dc_fills.local_ccx",
+                 "ls_hw_pf_dc_fills.int_cache",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache")
+  hwp_lm = Event("ls_hw_pf_dc_fills.dram_io_near",
+                 "ls_hw_pf_dc_fills.mem_io_local",
+                 "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram")
+  hwp_rc = Event("ls_hw_pf_dc_fills.far_cache",
+                 "ls_hw_pf_dc_fills.ext_cache_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache")
+  hwp_rm = Event("ls_hw_pf_dc_fills.dram_io_far",
+                 "ls_hw_pf_dc_fills.mem_io_remote",
+                 "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram")
+
+  loc_pf = hwp_l2 + hwp_lc + hwp_lm
+  rem_pf = hwp_rc + hwp_rm
+  all_pf = loc_pf + rem_pf
+
+  r1 = d_ratio(ins, all_pf)
+  r2 = d_ratio(hwp_ld, all_pf)
+  r3 = d_ratio(all_pf, interval_sec)
+
+  overview = MetricGroup("lpm_hwpf_overview", [
+      Metric("lpm_hwpf_ov_insn_bt_hwpf", "Insn between HWPF", r1, "insns"),
+      Metric("lpm_hwpf_ov_loads_bt_hwpf", "Loads between HWPF", r2, "loads"),
+      Metric("lpm_hwpf_ov_rate", "HWPF per second", r3, "hwpf/s"),
+  ])
+  r1 = d_ratio(hwp_l2, all_pf)
+  r2 = d_ratio(hwp_lc, all_pf)
+  r3 = d_ratio(hwp_lm, all_pf)
+  data_src_local = MetricGroup("lpm_hwpf_data_src_local", [
+      Metric("lpm_hwpf_data_src_local_l2", "Data source local l2", r1, "100%"),
+      Metric("lpm_hwpf_data_src_local_ccx_l3_loc_ccx",
+             "Data source local ccx l3 loc ccx", r2, "100%"),
+      Metric("lpm_hwpf_data_src_local_memory_or_io",
+             "Data source local memory or IO", r3, "100%"),
+  ])
+
+  r1 = d_ratio(hwp_rc, all_pf)
+  r2 = d_ratio(hwp_rm, all_pf)
+  data_src_remote = MetricGroup("lpm_hwpf_data_src_remote", [
+      Metric("lpm_hwpf_data_src_remote_cache", "Data source remote cache", r1,
+             "100%"),
+      Metric("lpm_hwpf_data_src_remote_memory_or_io",
+             "Data source remote memory or IO", r2, "100%"),
+  ])
+
+  data_src = MetricGroup("lpm_hwpf_data_src", [data_src_local, data_src_remote])
+  return MetricGroup("lpm_hwpf", [overview, data_src],
+                     description="Hardware prefetch breakdown (CCX L3 = L3 of current thread, Loc CCX = CCX cache on some socket)")
+
+
 def AmdSwpf() -> Optional[MetricGroup]:
   """Returns a MetricGroup representing AMD software prefetch metrics."""
   global _zen_model
@@ -278,6 +339,7 @@ def main() -> None:
 
   all_metrics = MetricGroup("", [
       AmdBr(),
+      AmdHwpf(),
       AmdSwpf(),
       AmdUpc(),
       Idle(),
-- 
2.51.0.318.gd7df087d1a-goog

