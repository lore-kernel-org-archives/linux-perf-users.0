Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD96261B91;
	Wed,  4 Feb 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770196238; cv=none; b=GHAhdIyLN8AIIGZzkEgaGRBgwFgDjko5hdUmkFNrK3cDKacv31z5p/GutDG4gvmzGGfEigmoeD9TKDXVU+iikNCmQReWKpHOfElxvYu49RuZi4PwHfrODU7V0DdGEHV8Yep3KTJcom6m3i/DTAu1NqqU46sto765laKBaA7zdPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770196238; c=relaxed/simple;
	bh=m5P24uh3P60HjC9sCdKoRrJSgUa/ESATqR/OtworwNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZnBfhpnprZFYs7a7bFkwp1JjqXTIJDPL1XPCJs6n5j/3WiJODo9GlNitD61kMHSlmBUQcHsBlgkoY4ldxnvIx3ra8A5ADCaksMRNxG9S5z3ts9G0doX8iIgZ4w/bv2e0LbZKlwPeZ0UEUFQ8Pox1/+kj84a3FW8wCCpLTjLqkkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=E6E0LMNh; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="E6E0LMNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1770196200;
	bh=EgJIHnad+b6A2LOWWhy4BtoavbNU0zZtyzPE8zCjc4w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=E6E0LMNhekirNM3L86GHoYLjSnLPtbUINcLmxzUVR+Ph5DbpPJXAns+yvHxD7gbK9
	 gOlcx79h3IS+/LNqWuLuMFXwYR2Dk3dvUcNmOQ7GgSLg3ZTTpByTp6+d3MNrez8CCy
	 PCGGQsV8Vwc3Dv53qQlE456sXH06mU0ZlG8I6cbo=
X-QQ-mid: zesmtpsz7t1770196198taefc40b6
X-QQ-Originating-IP: mBozWA9Y+PFCCt1kixiwX9rViDm+vgGOQudZyHgPelI=
Received: from SurfaceBook2-B.localdomain ( [101.70.125.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Feb 2026 17:09:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10106732724009350697
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
Subject: [PATCH v3 8/8] perf vendor events riscv:: Add support for spacemit,riscv-iommu HPM aliasing
Date: Wed,  4 Feb 2026 17:09:52 +0800
Message-ID: <5242DDF0A783AF08+e141f1898581018f8dd0723cb5c870c23ec679d6.1770195980.git.lv.zheng@linux.spacemit.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770195980.git.lv.zheng@linux.spacemit.com>
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NVJ0hJNx7N5S7OAqJS8spVOnE/fn5/CyBNG5bfTZdhkiCjkeFEV+k2Qf
	OIEqjv2b8C6I+V/E+Wr5TZ98OYzGpvDMBQDmBIWcTgSL9yX0sUVFiFLaj4efiiN2Gj3KCxT
	j/D4bMzORrXlmrKzTdUVaRX+5U6/tmYU0ux5qfWtLUYCFql5Q3Fx9885JJrH/x0bWAxX6j8
	VMwYgITuseUqiLWOzL9Y75LoV757VwfKBv+tx5pof4ipGd/ua3bqhQjOKG6oDE+kApqfLo0
	xq9JLL4lhRIBUSeD7ac37NtAPg0TKkzNEyfMyM85XRjGjISJNPSIM8Z3VXt1FAblg1q34Z/
	9cyiKbnxmb3XrBJGoVwN3s3E9/wXCcRRB8Wbw4k26+/UOzSWriSJSHb74ghdKkOcRXLgZkw
	dsrR4KaScs9f9VFoQYP0Zv3aqIXIV5fajjpW54zJxfklj061SMOn/hsgMYWdZ2m5srMuTm7
	18ob+OgkIhYYAsF8dMpGh5lf5+RuOhiOqgtKPoof5NDdwujeHjOs3N6qhHgD/oOI21IFwbw
	CDTNh7GwVxPuHvWW7Tsuq1FquAVPA7taMsZZjV1ZLB8pWRTCuvzoE4ZpiG4hJDQRSLYU2C4
	KFFilk6gkcFS/m4oaNMpzgljsYADfxk1eZaJ11U2bJhL+qSw0au1TsHsZzuFYJjn1wat9Ah
	zFFuflHrWnsewgd4EgDow2gXCmlm/2EZskIFTBXmRqaKi0P5riRbvrQR+JFb9wahXKUzp/W
	cBMiqIhdXFGCjBKETfY7GCcKoQif0KPA8bcZ/1iQ/dnMQmE1/awu35jnOWi1iOjCv1S5x+H
	BMRMlnqCWTk2q8MUZ2kBIxrbrjiFQPCdoHAUAhQaoxNSJwVxF74bsF5FDBkrqON50/1ZHGp
	7rNlaoEjcvI4pv0i9l0n7Ne8ZBhlCY6iz5bECDET6hM7h9MOC6j5CHQ8rzaMhl3p/fjn4tH
	6TleVyux1c0qO9OyivhpCweH32+dtZK8s2lc5TTRIwfiM6Cj2iNzz2ICC4HTF2pfz3UtUiv
	ldxwAA5QSBtZSZ9mufeE0f+SvT1WgwAVf5uj22wWM7igIacI7pbMGPCbXSImJe5PHM/svlc
	g==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

