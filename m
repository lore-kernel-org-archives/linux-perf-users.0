Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144039;
	b=xuRdp7SBK4FK2sOpAcacXU64IGQEyLUrIegRU1XOMxf1jW1qKiIYktUeZCsE8kCC3Jrf
	 9OjIxAfGXZ7dWx1LzKwuqId/zj5euiNEqUuFtvD87NAV7yBqBUQX9ZKr4uGg7enF84WPL
	 CGHxfZuETDMZtIVjn+jCeq81mTfzxSpsaPpZ4k8fpMph2aJMKnG8/FQdL3MCnZU9L6kDB
	 nWn+KPJOFtjvH+Kw2BRrk9s0uZVvlOFlOVdK59F49mMSEKa/AMKWDcF+b6VliOx41EDpa
	 n6Z1mZT3ucSiz2CpNvQxorZmudnbNCnRh6ksf751kAXz++ClWErtLmgWsKQBvVbCaSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144039;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=OKPZQyJsCxKmvcu3evgCAn8bCU003kDuUuvj5pSvgRY=;
	b=lN2Zcm4PyaXIENzte1stuaf2+88/qwwuX7gWcMTM4DJM3ZIqf4V3MZjzmh1bqDAX2JE5
	 lBh+1ZLcGgtMElZP4SAT4+8FDbro8DmjzQKGIdC9ODBrkyvyIMkKfU/xEUPUZFS2IeuJ6
	 dRWXlKknXnbBJ3Jii85Mjn2dEoYWSbAzWGMpuhhd3s8VH9GNvOnEi6tSRQ+BbjRnAusVM
	 NAVlHVrSej3KlsK48lkIu8IVI9ezAvXAjHpUEpOnS9VznMGIqN/5WHGyWgGtQzy4wnsef
	 sd20eINxcOqVqrsB0LWVaHtP1Ogqpl0SV2poCDFsXIfUubBhVWyQldLZk87DJBCxykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7843E606A322;
	Sun,  8 Nov 2026 13:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7843E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794144036; x=1825680036;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4V18Tfg9Ly6MPWUMnLZiqruGXQUpnrBi9GEGXYzKK7I=;
  b=LXnRa253nwtXLJEfoBeJdsESjcGhUp/wkCEQUOcJ6nZx9KAEUUb1U18x
   VnkntnfdNP/Pt90d/Af2orGJ6EhuNK2dIvC1YTmpmrfsb9pDrqzKLfr2u
   M++/kICF/i8WAhirLjhgKGlkdmcKGnbKSSmKqSl/zj4OgH5ID/pC0Jham
   1BRvBzYLk0H48W4+DisbpsVAn6qjqk8VvT84wHy5VgqwneP032nCHSxTL
   EuSKzcgwAxEO+WT0nEBWRjv/hqLegsNM3nMYvQ54q8gI9w8UgtLyVs9V6
   nVvIB5QhnUIcMXz9l6fEOzohk/FQ7th+PcCL04I/hy7lwUvilI6Ra4Vwa
   A==;
X-CSE-ConnectionGUID: MHGRpWrvQ26WAoe2XmE0rQ==
X-CSE-MsgGUID: 629/kvOFSk65L7PzPOE8lQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 15:20:27 +0200
X-CSE-ConnectionGUID: f/8VzZ2vQ+GxPA0q6sIThQ==
X-CSE-MsgGUID: LXSvwY2eSq6y8FZ7rEvvEw==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 08 Nov 2026 15:28:27 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Sun, 08 Nov 2026 15:20:25 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Date: Sun, 08 Nov 2026 15:20:10 +0200
Subject: [PATCH 1/5] MIPS: CM: add CM3 performance counter GCR definitions
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
Message-Id: <20261108-i6500-cm3-pmu-v1-1-bd119584891a@mobileye.com>
References: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
In-Reply-To: <20261108-i6500-cm3-pmu-v1-0-bd119584891a@mobileye.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Fu Chao-Ying <chao-ying.fu@globalfoundries.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
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

