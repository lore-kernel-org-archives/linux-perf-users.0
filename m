Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3037B415;
	Thu,  5 Feb 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282745; cv=none; b=leIxT71jxfkByGuVs7HP+iqU3t7GXseIqgWp9kc2TEqMJOANSqOztg5EuVrTIlYcukyyGYcNClgrrTQyy/ts4u1Y6SahmtzFwqOuJtA6piNfWCGzLSLyDFVYoCCbzTkxIDdhl/EmbvOcbDr1lxbN85Wy0X9j3BojIDzfEzGvUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282745; c=relaxed/simple;
	bh=m5P24uh3P60HjC9sCdKoRrJSgUa/ESATqR/OtworwNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq4rWZgfKSGwgr2cAzZYJzRgy3XQx8yq8VxyKs2Hd/CpleitbGs5ye6PsE88lPAjbG+gWN0wU3mWzhuwpBso8RrKJFPvBLB+B5KdxKVBxLW9iZ4wQJsvcTjKevzULiKzqkCfRxAizp48KiVTr0KAkKtnevCp3oE4UYdzsSOTmCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=lt+kaZBz; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="lt+kaZBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770282691;
	bh=EgJIHnad+b6A2LOWWhy4BtoavbNU0zZtyzPE8zCjc4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lt+kaZBzxAJ6VeyQdi2BanMI3CPXrcpPQzT48fdUrQGDRM/b71DHOnrGut4SqBRLC
	 Boc8qFimjUo9jd7GLIkxO+FFmJv/lI06tyJFYO8hlmcI56CY7WVuob6/x0H9H9/Rkj
	 0tCVc+8AnEZfJak9MN6ha447Bodbrn5HTQGsB/FQ=
X-QQ-mid: esmtpgz15t1770282689t4f2e1d4f
X-QQ-Originating-IP: gjSembEr54IOZFG1eB0aBlTfNba+EJQW0AsSm/ltcp4=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 05 Feb 2026 17:11:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2782802990881728978
EX-QQ-RecipientCnt: 19
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
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Jingyu Li <joey.li@spacemit.com>,
	Lv Zheng <lv.zheng@linux.spacemit.com>,
	Zhijian Chen <zhijian@spacemit.com>,
	iommu@lists.linux.dev,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH v4 7/7] perf vendor events riscv:: Add support for spacemit,riscv-iommu HPM aliasing
Date: Thu,  5 Feb 2026 17:11:22 +0800
Message-ID: <762890DF43A3CF05+a58564f568dbbf8ccac8224e33f5e7513e48309e.1770281596.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770281596.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770281596.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NcrqiFVQ6ItSSEUpcdL8nNI2KH+LcYeJaB1LQDOpa+IHeW+o3nSrKqkG
	xfYeKUONs5GMpwEpoiSW7NKwQ3GUnCQl37bqLxOWJ1/1D87qL6JvvqD53XNAjXQWW6G5Ua6
	H5321K+YTVLBay/Z0aGimN+r9G2mdFGXWTbHvOlMLAZFoD28uVvpTxrFohghS3uoceXKUYk
	D9svtbesTLXDimaYT80B6A8sb9boXwA4RrFIbHJ+UoPVt9kvmqmdlPWmuFQQk6soPWK0YtN
	sZu5qpe6TWy+EMuR4jZKdnYFJq0kGrn+nYVmslIzx1Tv356Ip7kFHh3pE4DSz92+68QMSoH
	qNBAhMY4rAjrDmx6IrPYoQwf4T57jfdolUB760xkE3dFOmDMDzKNQRXzEnRtWdIRSfenuau
	JaeKLREaIxP5eTTpOWG2Vz57Wb9GC4okHw+8ni9kCHJeVgEXA7yS3Y0jdUShlNJdSUM3AqY
	bokElju9fCPeL7iCzMT/dGxJT+65Ca1ZutlK2IAgGX4h5V/CbNITuB1Aj5tNxycuG538xub
	Yj8IxHA0z/nOEsmkJZx4s+NbZfTv6Y5oWA2DKD27h+S/n6hgIfUW6GmX0EtkUf2x1zTtRPd
	sahnj936EMTdUGKFTZPFeY/nmEvnIWhokMNy9dFKQ9Frkit+6WOidF2sFsju6C+pbF6CzJR
	8O1ovu1TUp+0i6SUAesKJPcsoI+KJtTZtkB65CnqHabab8OLP8n3LCioMhNNlHo0Uzf3Eyd
	NKCLVmFWaKKrAYJTgZ1RJmSZ3/osP8EXGWc6P4Xx2v4CRWBhv9peUodrB5aluE3E7MOXJXS
	nWpKEX+ZH+6Qq9DA0D7oV3tdsZXilFX3giCt8pomB3/LhT79iJLkEV46Om15EbDCdo+F+5J
	CFj/ipA5j4B1s3SgnQJMjOtpYPjdaoyDXPwlEb87y1K5fL65Eck8EtHRCqdb3M/6Yvj3+rR
	PVpwtTNMeqeyIlgCo/jcqfE63LBa5q7iULJPjuQodwIjw33XCD3Kogp2sRPv2AJQ9N9gxCm
	sG051con/l+WidtpnPAD26Lm/tKXxfVdWNb+Mm5BY8pFgMpJ/FUSH9aQ9aV4ZwQ84Cu4sjY
	V+wAtKyL8tOh84QrRtqH+nlKJ8sbPaQ42lzsf+lWkfzKOMYmiOn68ybhxX8SZ92uxSfHM3d
	6TPcaE0wODkr8Hs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Add JSON HPM event aliases for SpacemiT distributed IOMMU (T100) which is
general and compatible for all SpacemiT RISC-V SoCs.

Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
Signed-off-by: Jingyu Li <joey.li@spacemit.com>
---
 MAINTAINERS                                   |   3 +
 .../arch/riscv/spacemit/iommu/sys/ioatc.json  |  30 ++++
 .../arch/riscv/spacemit/iommu/sys/ioats.json  | 163 ++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 7c50701b6001..4d91f99aa742 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22459,12 +22459,15 @@ K:	riscv
 
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
+F:	tools/perf/pmu-events/arch/riscv/spacemit/iommu/
 
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
diff --git a/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
new file mode 100644
index 000000000000..a16610ba2274
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioatc.json
@@ -0,0 +1,30 @@
+[
+  {
+    "EventName": "mtlb_lkp",
+    "EventCode": "0x38",
+    "BriefDescription": "IOATC main TLB (MTLB) lookups",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "mtlb_mis",
+    "EventCode": "0x39",
+    "BriefDescription": "IOATC main TLB (MTLB) misses",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "utlb_lkp",
+    "EventCode": "0x3A",
+    "BriefDescription": "IOATC micro TLB (uTLB) lookups",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "utlb_mis",
+    "EventCode": "0x3B",
+    "BriefDescription": "IOATC micro TLB (uTLB) misses",
+    "Unit": "spacemit_ioatc_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
new file mode 100644
index 000000000000..e1fea4e8125c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/spacemit/iommu/sys/ioats.json
@@ -0,0 +1,163 @@
+[
+  {
+    "EventName": "pri_rq",
+    "EventCode": "0x10",
+    "BriefDescription": "IOATS PCIe page request interface (PRI) requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "ptwc_rq",
+    "EventCode": "0x11",
+    "BriefDescription": "IOATS page table walk (PTW) cache requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "dtwc_rq",
+    "EventCode": "0x12",
+    "BriefDescription": "IOATS directory table walk (DTW) cache requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "dtwc_mis",
+    "EventCode": "0x13",
+    "BriefDescription": "IOATS directory table walk (DTW) cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "ptwc_mis",
+    "EventCode": "0x14",
+    "BriefDescription": "IOATS page table walk (PTW) cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "all_trans_rq",
+    "EventCode": "0x15",
+    "BriefDescription": "IOATS all translation requests",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "dtwc_lkp",
+    "EventCode": "0x20",
+    "BriefDescription": "IOATS directory table walk (DTW) cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s0_ptwc_lkp",
+    "EventCode": "0x28",
+    "BriefDescription": "IOATS s-stage level-0 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s0_ptwc_mis",
+    "EventCode": "0x29",
+    "BriefDescription": "IOATS s-stage level-0 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s1_ptwc_lkp",
+    "EventCode": "0x2A",
+    "BriefDescription": "IOATS s-stage level-1 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s1_ptwc_mis",
+    "EventCode": "0x2B",
+    "BriefDescription": "IOATS s-stage level-1 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s2_ptwc_lkp",
+    "EventCode": "0x2C",
+    "BriefDescription": "IOATS s-stage level-2 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s2_ptwc_mis",
+    "EventCode": "0x2D",
+    "BriefDescription": "IOATS s-stage level-2 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s3_ptwc_lkp",
+    "EventCode": "0x2E",
+    "BriefDescription": "IOATS s-stage level-3 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "s3_ptwc_mis",
+    "EventCode": "0x2F",
+    "BriefDescription": "IOATS s-stage level-3 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g0_ptwc_lkp",
+    "EventCode": "0x30",
+    "BriefDescription": "IOATS g-stage level-0 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g0_ptwc_mis",
+    "EventCode": "0x31",
+    "BriefDescription": "IOATS g-stage level-0 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g1_ptwc_lkp",
+    "EventCode": "0x32",
+    "BriefDescription": "IOATS g-stage level-1 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g1_ptwc_mis",
+    "EventCode": "0x33",
+    "BriefDescription": "IOATS g-stage level-1 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g2_ptwc_lkp",
+    "EventCode": "0x34",
+    "BriefDescription": "IOATS g-stage level-2 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g2_ptwc_mis",
+    "EventCode": "0x35",
+    "BriefDescription": "IOATS g-stage level-2 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g3_ptwc_lkp",
+    "EventCode": "0x36",
+    "BriefDescription": "IOATS g-stage level-3 PTW cache lookups",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  },
+  {
+    "EventName": "g3_ptwc_mis",
+    "EventCode": "0x37",
+    "BriefDescription": "IOATS g-stage level-3 PTW cache misses",
+    "Unit": "spacemit_ioats_hpm",
+    "Compat": "spacemit,riscv-iommu"
+  }
+]
-- 
2.43.0

