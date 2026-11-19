Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.90.104.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110703;
	b=btpNFGDPn6xgpaPdbgRBT96EViyxwCV0GA4gicfFwA/eJdIG6cYWwqh8l7PhOTEFJ4Ew
	 5OSIl6Pxcdl46WFWBzxOHWbOtIQ7VJLFvxlrBFHykEDDILhubNGmyChD3G3ycKjOri6C2
	 eLDV/wAGMHHqw/ByW+jqQwa+DBHSrllRDwbSOpL66ZMcYCrv6xYk/+z55ewjX3hRjo08e
	 bRBp2JARUVXopRAevKWPGussUbzl6W6MecAKdUNOHmmk0W9RAJONuViUzh1h8HFIgRbTQ
	 91FKVKi6NhsdH6+Yxot+S6cBcWamaG/GQbvl0mFZBLq0xnX2OAkIFM0N1M6pkDs3vAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110703;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=OKPZQyJsCxKmvcu3evgCAn8bCU003kDuUuvj5pSvgRY=;
	b=IUGCsQ/bsXlD98w2v4IQ8GyYdpjKfqLC4lgixKnYWoenVLNq/704zpE5u2iwmOc9mTZ1
	 Kr8Nlk9W4T5Z/zNqAOMkACWLVMk/AEgXkzU6xTWqcXOXQMJ7CD8MrSygNH4z40LdS7MoK
	 Kb0YDXZc4eupmLqvCyiG9Sl0RQqZaWewWkCLTrAFkQDgJWzKvOvu0ISai+/WYJAUOptoc
	 w8zj2eY93H1fbqCvBqLFe1mFSgZyEe4vQc4FKULuiD+MC01QeXp40UmYxx3hBE+M3qyCV
	 y8mQbxUdPp8JAfHkcmGe6k7miITKekk0bZspfV19gfTodgy6UckZcmWU7o1hKtlSAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=23.90.104.144
Received: from esa1.hc555-34.eu.iphmx.com (esa1.hc555-34.eu.iphmx.com [23.90.104.144])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ACE606A324;
	Thu, 19 Nov 2026 17:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92ACE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1795110702; x=1826646702;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4V18Tfg9Ly6MPWUMnLZiqruGXQUpnrBi9GEGXYzKK7I=;
  b=TQi8rvKHeCWk7ottKTZIqJSvWBhS887/V8U3XhzavbuzJ1a4B9gxneal
   06k9t4y2SGdjgmMKuBs0kTrEXQvQqIwW0QC6hXMakiwclP6toz0EJ2j0U
   lGgyeMlD7776V/rgKRlvRF6TfFmcAKB7idVZkcfHE3qHHcBcn/cKJzQ5A
   AuQN6lrlPablmZ2LojVB5QC+hTZQ0q+mkaZQyyiQs+drv0Htc9EgfdZsm
   tb6dvvMBbPFDjXpPXlckv2DFevBwVxs4HiLfLPWD+gLD43f+xemG1XtLp
   kRVQpeRTJyz80tehi46V7utsawhYJhXyKiqdq5u/FpttTOWg947lK1wdL
   A==;
X-CSE-ConnectionGUID: bck4BxQFSmuiqAdu90FOmw==
X-CSE-MsgGUID: NuCP7ZcRRJWiXbhWt+3dyA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 19:51:33 +0200
X-CSE-ConnectionGUID: tengInJhRCa+VsqTvox6mw==
X-CSE-MsgGUID: klkWn2aISdGzaE5U/QgFbw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 19 Nov 2026 19:59:49 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 19 Nov 2026 19:51:32 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Thu, 19 Nov 2026 19:51:28 +0200
Subject: [PATCH v3 2/7] MIPS: CM: add CM3 performance counter GCR
 definitions
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-i6500-cm3-pmu-v3-2-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
In-Reply-To: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mailer: b4 0.16.0

The CM3 implements two programmable 32-bit performance counters and a
32-bit cycle counter, controlled through registers in the GCR global
debug block (GCR_DB_PC_*, offset 0x6100..0x61a8 from GCR_BASE).

Add GCR_DB_ACCESSOR_{RO,RW} helpers for the debug block and define the
control, overflow status, event select, cycle counter, qualifier and
counter registers along with their fields, as described in the I6500
register reference (MD01189).

Each accessor comes in two flavours, as the CPC ones do: db_<reg> for
the local cluster and redir_db_<reg> for the debug block of another
cluster through the redirect block. GCR_Cx_OTHER.BLOCK value 2 selects
the debug block in the GCR, where the existing _BLOCK_USER name only
describes its GIC meaning; add CM_GCR_Cx_OTHER_BLOCK_DEBUG for it.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
 arch/mips/include/asm/mips-cm.h | 51 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 407f253bb4a1..390d06a8f1d1 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -161,6 +161,20 @@ static inline bool mips_cm_has_l2sync(void)
 	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_CLCB_OFS + off, cl_##name)	\
 	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_COCB_OFS + off, co_##name)
 
+/*
+ * Global debug block registers. The redir_db_* accessors reach the debug
+ * block of another cluster through the redirect block, which must have been
+ * pointed at it with mips_cm_lock_other(cluster, 0, 0,
+ * CM_GCR_Cx_OTHER_BLOCK_DEBUG).
+ */
+#define GCR_DB_ACCESSOR_RO(sz, off, name)				\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_GDB_OFS + off, db_##name)	\
+	CPS_ACCESSOR_RO(gcr, sz, MIPS_CM_COCB_OFS + off, redir_db_##name)
+
+#define GCR_DB_ACCESSOR_RW(sz, off, name)				\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_GDB_OFS + off, db_##name)	\
+	CPS_ACCESSOR_RW(gcr, sz, MIPS_CM_COCB_OFS + off, redir_db_##name)
+
 /* GCR_CONFIG - Information about the system */
 GCR_ACCESSOR_RO(64, 0x000, config)
 #define CM_GCR_CONFIG_CLUSTER_COH_CAPABLE	BIT_ULL(43)
@@ -357,7 +371,8 @@ GCR_CX_ACCESSOR_RW(32, 0x018, other)
 #define CM_GCR_Cx_OTHER_BLOCK			GENMASK(25, 24)	/* CM >= 3.5 */
 #define  CM_GCR_Cx_OTHER_BLOCK_LOCAL		0
 #define  CM_GCR_Cx_OTHER_BLOCK_GLOBAL		1
-#define  CM_GCR_Cx_OTHER_BLOCK_USER		2
+#define  CM_GCR_Cx_OTHER_BLOCK_USER		2	/* GIC */
+#define  CM_GCR_Cx_OTHER_BLOCK_DEBUG		2	/* GCR */
 #define  CM_GCR_Cx_OTHER_BLOCK_GLOBAL_HIGH	3
 #define CM_GCR_Cx_OTHER_CLUSTER			GENMASK(21, 16)	/* CM >= 3.5 */
 #define CM3_GCR_Cx_OTHER_CORE			GENMASK(13, 8)	/* CM >= 3 */
@@ -384,6 +399,40 @@ GCR_CX_ACCESSOR_RW(32, 0x030, reset_ext_base)
 #define CM_GCR_Cx_RESET_EXT_BASE_BEVEXCPA	GENMASK(7, 1)
 #define CM_GCR_Cx_RESET_EXT_BASE_PRESENT	BIT(0)
 
+/* GCR_DB_PC_CTL - Control of the CM3 performance counters */
+GCR_DB_ACCESSOR_RW(32, 0x100, pc_ctl)
+#define CM_GCR_DB_PC_CTL_PERF_INT_EN		BIT(30)
+#define CM_GCR_DB_PC_CTL_PERF_OVF_STOP		BIT(29)
+#define CM_GCR_DB_PC_CTL_P1_RESET		BIT(9)
+#define CM_GCR_DB_PC_CTL_P1_COUNTON		BIT(8)
+#define CM_GCR_DB_PC_CTL_P0_RESET		BIT(7)
+#define CM_GCR_DB_PC_CTL_P0_COUNTON		BIT(6)
+#define CM_GCR_DB_PC_CTL_CYCL_CNT_RESET		BIT(5)
+#define CM_GCR_DB_PC_CTL_CYCL_CNT_COUNTON	BIT(4)
+#define CM_GCR_DB_PC_CTL_PERF_NUM_CNT		GENMASK(3, 0)
+
+/* GCR_DB_PC_OV - CM3 performance counter overflow status (write 1 to clear) */
+GCR_DB_ACCESSOR_RW(32, 0x120, pc_ov)
+#define CM_GCR_DB_PC_OV_P1_OF			BIT(2)
+#define CM_GCR_DB_PC_OV_P0_OF			BIT(1)
+#define CM_GCR_DB_PC_OV_CYCL_CNT_OF		BIT(0)
+
+/* GCR_DB_PC_EVENT - CM3 performance counter event selection */
+GCR_DB_ACCESSOR_RW(32, 0x130, pc_event)
+#define CM_GCR_DB_PC_EVENT_P1_EVENT		GENMASK(15, 8)
+#define CM_GCR_DB_PC_EVENT_P0_EVENT		GENMASK(7, 0)
+
+/* GCR_DB_PC_CYCL - CM3 performance cycle counter */
+GCR_DB_ACCESSOR_RW(32, 0x180, pc_cycl)
+
+/* GCR_DB_PC_QUALn - CM3 performance counter n event qualifier */
+GCR_DB_ACCESSOR_RW(64, 0x190, pc_qual0)
+GCR_DB_ACCESSOR_RW(64, 0x1a0, pc_qual1)
+
+/* GCR_DB_PC_CNTn - CM3 performance counter n value */
+GCR_DB_ACCESSOR_RW(32, 0x198, pc_cnt0)
+GCR_DB_ACCESSOR_RW(32, 0x1a8, pc_cnt1)
+
 /**
  * mips_cm_l2sync - perform an L2-only sync operation
  *

-- 
2.43.0

