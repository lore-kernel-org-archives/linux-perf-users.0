Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCABB43D4F1;
	Sat, 28 Feb 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772290034; cv=none; b=t6ijC2WMQebMBt4Q5zMtBRhK2l654VYXN3i5NaESl8Y5KoBixNzh2IYMbRx7G1q2Z//s4oPQNhhZiFmsAsVgU8c36ewEpXT0J4I/8MTAvBgC8qZ9GdzzimLoAUGgywWYkV4ZwBlrQjkLI4+DQGCi+7zmEnJbe8sbFh4laNqWRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772290034; c=relaxed/simple;
	bh=BjN/cx+kqElxA6omTzsyPmotz9uuclCSEdzjCPYSUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWvAfuSM3njzj/dGJQBSfkJ2HpQIG2BVz+UGTa0pHqOxrTcbSEVXXVVukc2M5UuPwsL52g6XwF1D7E+JdSl/i1z5CLHq+MjMJBXiEixLvoqjwPAXIdMR/ZgPmbNmuvCHsbLNhy7vOmn1/6oC6IvCgScREVKE7AIwXDSkGZa8GvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=fKjI4ptb; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="fKjI4ptb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1772289940;
	bh=XGJl3Ebpwjc8XqP0Erp8n5QI4s+vHuY4PwAQnqw3qYc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fKjI4ptbqtzYkOyJk63gqDvBMOKrlerjFF/WAvDfGrBv/O5bepM/9mSLaDG66DP3x
	 gLHzrKhkBSbvc6AEHOz80IyQow9DCEz3LK/oy+BQEZb3Z0pKgwkQyNij4ZMGWohhxG
	 cI/rvTscCI2ti4HxuCfnpRVsreipcQ7vBDkHrJKE=
X-QQ-mid: esmtpgz10t1772289938t9eeb1592
X-QQ-Originating-IP: BFePjrheh1QVANmHt8QhCMjcQXaVFA659BV4XTzO8KE=
Received: from SurfaceBook2-B.localdomain ( [183.193.112.19])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 28 Feb 2026 22:45:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5797566648988719530
EX-QQ-RecipientCnt: 33
From: Lv Zheng <lv.zheng@linux.spacemit.com>
To: Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Yixun Lan <dlan@kernel.org>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zong Li <zong.li@sifive.com>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 8/8] perf vendor events riscv: Add SpacemiT T100 HPM event aliases
Date: Sat, 28 Feb 2026 22:45:32 +0800
Message-ID: <893875E9335710EF+ccc7125fae0d5d494464c3635004aede679bc4ef.1772289741.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
References: <cover.1772289741.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MUcSNKJIkQ7c5RrhWlfKmtjak3ryOn//OxV2SIED/Nb7n4pj37mp7tWH
	oBaFwrFA1w3zjUl5vzF2Bt9tp49lL9QXDqz8xMIvpJyXSyxQcfyn6UO1gGeB3KjQsnQ5EEr
	bibVar10Msg+bhaf4bSXAk3OHemTRNf/lHUICdUM6ChiURqfsHBqFvS8v2P62EimwvG5Qxn
	RqeK+KbjBiUGfDT/tNPsH7VxWgTLsq+AW859K3j7dQfNP06ehbQjV/m0wZ2ZB5ex8lYrzJB
	YJmLoRWpYsIph9YSYyYJgrpcYPXEmJ/JTJ6cL3mzdjPZhyPVouXVt2N7tf//0QZ5MBamC4Z
	2u6Uk+sXHXZLFDmDc7zvS9XjMVr+rQyOv2Vuc234V0fKdxr+2sxLggUBB69xvIVOYzrwNvV
	lCjJ/LbboeoXpxxeIj8hUaC1/n47/1S76dYjPW7KMDkGKxh2eBPBlYTElR3tlKy1Ze7chYh
	krBqojzZk2Wi6McSxGOMnb0UJbizk9eIcDhJ0yQKhcdLgOixtJvzor+uiodZsXWmGOpLHNU
	dMpeQBaIZqwincqOsfGwNzvGMI/8em8W/IC8c6Ga5jEu+vvWf+462U00TilgI2BvExul7kv
	ONkfRNnued84jZGI0XQ3u9KMkffRf6mr2D6Tl0vVG81ptgn5+n0xVTlUkno/eg0qNRHCNlK
	1jNrihpzHaCZnnmWzydwjIWyqSn4ytjPwilyQiunq3QIQQlD0jE+UEqdtajyQPbGLaWZtvd
	8owlEpKjYvEy1us+kCpzrU25Vdiou9GQNvXqPr0MkrRvti4ZAVzMq/BgAZIlmlSkOEuaIun
	lNtILH/qEkW9CZI1bIKQTtmvBRKv6CqV+SC1GGnvO6UgXDE5FJQ9ocrUtEwFsUBLrNCg3lb
	AEtebUcOQo3c2Rn+GnQanC0aCq4/xgBC8tolBwN7Krt1ZER8lF+YE07QgsO2r1u82HqGA2L
	YTLEZHPJ4evobncDvo69dFxSHD0m5NNkYR11PiPm4s4CRf/eFkYk3eVUwJfHWjCPLQwIj8T
	NZoJfE2ljYmKQEGWSFxT0sSYt1T+BS6+vxjWRUUCuvWRqKl8V2wT7QNaAZLUQJ/uFXvwf0q
	vogsOhkMXZmm4J+2u/Srak=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add JSON HPM event aliases for SpacemiT distributed IOMMU (T100) which is
general and compatible for all SpacemiT RISC-V SoCs.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 MAINTAINERS                                   |   5 +
 .../arch/riscv/spacemit/iommu/sys/ioatc.json  |  30 ++++
 .../arch/riscv/spacemit/iommu/sys/ioats.json  | 163 ++++++++++++++++++
 3 files changed, 198 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c50701b6001..8b6458c1f63a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22459,12 +22459,17 @@ K:	riscv
 
 RISC-V IOMMU
 M:	Tomasz Jeznach <tjeznach@rivosinc.com>
+M:	Lv Zheng <lv.zheng@linux.spacemit.com>
+M:	Jingyu Li <joey.li@spacemit.com>
 L:	iommu@lists.linux.dev
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
+F:	drivers/perf/riscv_iommu_hpm.c
+F:	include/linux/riscv_iommu.h
+F:	tools/perf/pmu-events/arch/riscv/spacemit/iommu/
 
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
diff --git a/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
new file mode 100644
index 000000000000..eb2e6fe24c62
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
@@ -0,0 +1,30 @@
+[
+  {
+    "EventName": "mtlb_lkp",
+    "EventCode": "0x38",
+    "BriefDescription": "IOATC main TLB (MTLB) lookups",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "mtlb_mis",
+    "EventCode": "0x39",
+    "BriefDescription": "IOATC main TLB (MTLB) misses",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "utlb_lkp",
+    "EventCode": "0x3A",
+    "BriefDescription": "IOATC micro TLB (uTLB) lookups",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "utlb_mis",
+    "EventCode": "0x3B",
+    "BriefDescription": "IOATC micro TLB (uTLB) misses",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,t100"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
new file mode 100644
index 000000000000..709c0a9d2a8e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
@@ -0,0 +1,163 @@
+[
+  {
+    "EventName": "pri_rq",
+    "EventCode": "0x10",
+    "BriefDescription": "IOATS PCIe page request interface (PRI) requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "ptwc_rq",
+    "EventCode": "0x11",
+    "BriefDescription": "IOATS page table walk (PTW) cache requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "dtwc_rq",
+    "EventCode": "0x12",
+    "BriefDescription": "IOATS directory table walk (DTW) cache requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "dtwc_mis",
+    "EventCode": "0x13",
+    "BriefDescription": "IOATS directory table walk (DTW) cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "ptwc_mis",
+    "EventCode": "0x14",
+    "BriefDescription": "IOATS page table walk (PTW) cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "all_trans_rq",
+    "EventCode": "0x15",
+    "BriefDescription": "IOATS all translation requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "dtwc_lkp",
+    "EventCode": "0x20",
+    "BriefDescription": "IOATS directory table walk (DTW) cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s0_ptwc_lkp",
+    "EventCode": "0x28",
+    "BriefDescription": "IOATS s-stage level-0 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s0_ptwc_mis",
+    "EventCode": "0x29",
+    "BriefDescription": "IOATS s-stage level-0 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s1_ptwc_lkp",
+    "EventCode": "0x2A",
+    "BriefDescription": "IOATS s-stage level-1 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s1_ptwc_mis",
+    "EventCode": "0x2B",
+    "BriefDescription": "IOATS s-stage level-1 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s2_ptwc_lkp",
+    "EventCode": "0x2C",
+    "BriefDescription": "IOATS s-stage level-2 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s2_ptwc_mis",
+    "EventCode": "0x2D",
+    "BriefDescription": "IOATS s-stage level-2 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s3_ptwc_lkp",
+    "EventCode": "0x2E",
+    "BriefDescription": "IOATS s-stage level-3 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "s3_ptwc_mis",
+    "EventCode": "0x2F",
+    "BriefDescription": "IOATS s-stage level-3 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g0_ptwc_lkp",
+    "EventCode": "0x30",
+    "BriefDescription": "IOATS g-stage level-0 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g0_ptwc_mis",
+    "EventCode": "0x31",
+    "BriefDescription": "IOATS g-stage level-0 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g1_ptwc_lkp",
+    "EventCode": "0x32",
+    "BriefDescription": "IOATS g-stage level-1 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g1_ptwc_mis",
+    "EventCode": "0x33",
+    "BriefDescription": "IOATS g-stage level-1 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g2_ptwc_lkp",
+    "EventCode": "0x34",
+    "BriefDescription": "IOATS g-stage level-2 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g2_ptwc_mis",
+    "EventCode": "0x35",
+    "BriefDescription": "IOATS g-stage level-2 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g3_ptwc_lkp",
+    "EventCode": "0x36",
+    "BriefDescription": "IOATS g-stage level-3 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  },
+  {
+    "EventName": "g3_ptwc_mis",
+    "EventCode": "0x37",
+    "BriefDescription": "IOATS g-stage level-3 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,t100"
+  }
+]
-- 
2.43.0

