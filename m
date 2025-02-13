Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB914200112
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739436671; cv=none; b=fZn3XoQhDGKGuf6ZhlDO19pF+BqbeQ5w0JMHIaBDNKxW3EPfXhjd9NyEUdUXVffgvCmM08gxeH2y6VMfDcPcDp84FxQswWiw8vA7sGTx6D4/k30+GcjDZpKUtP+/z+6IAfHDxAlZQcrnMWQvhIuxkXlM3fPbAHQtcThyRRZcswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739436671; c=relaxed/simple;
	bh=UcvF4sBVk0HG0g4bnNFQQiWcgR0wcXqOPwEKfCEjei4=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=OPxpdbWnXDn7+7jV8VvChI/HT7P5BJaHAC+w2up6wH/dovPX97GvIAKL7CCRmRyPck7ClcPnO76vB9Jxk9K265ycNCTSOH9kRTb7T5o5KR7vMbYZZ6kJaibPP7Zr2Yhyt75CfRxSJFoiIJMegqGTFEb0Cte55gKMg7fXX/GgLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=DWjLhqCv; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="DWjLhqCv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1739436653; bh=KhaBNpb95Gi1j4dcCqAqa7XYiZGUbfkjJsMy2avvVao=;
	h=From:To:Cc:Subject:Date;
	b=DWjLhqCvbHKswy/Ubp2jnlGdL9ZdLRFNIkUPl0mcYUKf6alkSr8sC6sxMIrQyjytm
	 s5OAqnmx2BNAyU4YPAMPsLxZH6wMSrpgCqPg7hluwcLA9rdnouhmm1t7GzsGgpPwpY
	 BTT1xVEA0OBb1lF0d3BpR89W8omAg47eR+8eS0Dk=
Received: from cyy-pc.lan ([240e:379:2251:3600:f57b:26f9:9718:486c])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id B2330E54; Thu, 13 Feb 2025 16:44:35 +0800
X-QQ-mid: xmsmtpt1739436275tf62qoxf2
Message-ID: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5TKvs7kfZibyvxHrdbil8FBd+bY5ZT7gc3Jj7B62kZYye07kdBtv
	 pkuNbbtuagFWAmjnpSOjxuKK0o1iYgXUiJjXtLZOOaCnJBPYTlxepxpofP2WkhWjt4vhlIt/G0mC
	 xY5SlOCqxPl4E15O7QMr56o83XRpGTXACrbJzhaVw/Xf4qhwsFWtwYQ9mTJdkzc2RDI/sy8Wav9L
	 f2lDSmD/5qDeP74cE1IxH43i30aYQxS5u5zkZQ0W0HVfggr5MNE9a/0LtMr/1YXcFFg0siA3Z8dL
	 d5JjUkKemrm43RVWMmcQs3zw2dUC1XYFfYuJkecVyUnbRK4Mu5afolhmtpeMXA6v6sWYcGDWD5Hc
	 79mzX9dGqozQmWwxbBGr3qJBCgARzGMQIJT488XmyVdS3toP1v9Al8Ab/cJc03sRLGBoyAD8sp0M
	 ArH9veK8hEkcQXbQj8k7DTrT6jCye5YUs//rVGqi8EaLdm96nuCZLVcC+T/PUfL3xTYIZsj7GKxh
	 4rzR8iUHtVFgFiPuPHcqy8dOKXOafineMmg+x9j8Sm3FbbQZrOcyHI1RDPWVPF2p01+IFyNMwKKK
	 gd3ueMHNCFEbvLAag+ZbnO/FkpUhLzSrWEKN8NcpJnLrzF54F62mUe6PqShNTud5ph9NARB5yG0z
	 HoL+2D24wD22QKSaoq9VgPiHJaN5KLSfukOgWjqbjcZBDjdA2/DbYMYhWKn2sw50csMJr66WU1b3
	 bLLpTavxqwmyHbhux+RSG5Qe031tcHi1zegAsBGU1/RyBezTC5ZLBmbn0Z7TgNH/vo7ka9KV/fE4
	 mw/ChjO2jX6QZijG27yuvldo0MPClGdFyi/AjMIGM/51lhweYHSFTWqoUI/C9el8XMJwKQh/IgCM
	 MyyJHFKKbw9dB5+AZ0bpDXgC8qaaAu8rHPoMfroD0g4PoVtN89Oa/YD1SAaApLEPUqR64FoN0h9Q
	 UAqqPMCoXeAJTTsfaMo8Y1qhRKLIywbRg7onUXhJyFcIip5Ex4OQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-perf-users@vger.kernel.org,
	james.clark@linaro.org,
	irogers@google.com,
	namhyung@kernel.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	fj3333bs@aa.jp.fujitsu.com,
	fj5100bi@fujitsu.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	kan.liang@linux.intel.com,
	leo.yan@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	mike.leach@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH] perf vendor events arm64: Fix incorrect CPU_CYCLE in metrics expr
Date: Thu, 13 Feb 2025 16:44:09 +0800
X-OQ-MSGID: <20250213084409.109774-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some existing metrics for Neoverse N3 and V3 expressions use CPU_CYCLE
to represent the number of cycles, but this is incorrect. The correct
event to use is CPU_CYCLES.

I encountered this issue while working on a patch to add pmu events for
Cortex A720 and A520 by reusing the existing patch for Neoverse N3 and
V3 by James Clark [1] and my check script [2] reported this issue.

[1] https://lore.kernel.org/lkml/20250122163504.2061472-1-james.clark@linaro.org/
[2] https://github.com/cyyself/arm-pmu-check

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---
 .../perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json | 6 +++---
 .../perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
index 1f7c9536cb88..eb3a35f244e7 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
@@ -169,7 +169,7 @@
     },
     {
         "MetricName": "fp_ops_per_cycle",
-        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
+        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
@@ -383,7 +383,7 @@
     },
     {
         "MetricName": "nonsve_fp_ops_per_cycle",
-        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
+        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
@@ -421,7 +421,7 @@
     },
     {
         "MetricName": "sve_fp_ops_per_cycle",
-        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
+        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
index d022ae25c864..4a671f55eaf3 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
@@ -169,7 +169,7 @@
     },
     {
         "MetricName": "fp_ops_per_cycle",
-        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
+        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
@@ -383,7 +383,7 @@
     },
     {
         "MetricName": "nonsve_fp_ops_per_cycle",
-        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
+        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
@@ -421,7 +421,7 @@
     },
     {
         "MetricName": "sve_fp_ops_per_cycle",
-        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
+        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
         "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
         "MetricGroup": "FP_Arithmetic_Intensity",
         "ScaleUnit": "1operations per cycle"
-- 
2.47.2

