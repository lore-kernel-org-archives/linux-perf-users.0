Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596028;
	b=lmmXkn0RVKWkTkqKV25GnoBJeGK1q1yIZjhFXmDd06uP33cWbV2cmyVMYsn4EzXm/NLN
	 Hg94m25qAlWfrHI48IeG5JX2GT38lcP49GmYyC3QOzu1Nx7uutmGeVqc3BuPe4W6z7CxN
	 8jRwaSokH/227a/qQbRD6kMm19sGYnu3+NQTd0zR6dm3Zf0JcpgHoGGs8Q9l9ZTL1Ezru
	 fCK/M5KEdV//3cgWtxzESWuidjDk/owIsId48iaPMGTPHYqMXznegY4E3pWk3fpJQ6P37
	 3C11HMcY+LgTW4foYoeElcbD5JqwiEGZd0GVH1gjFdKvRXKmx/VkyuqHhVgchtWikCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596028;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=XTPqPUDxN/CEitojWe4ZINBByJPfhqq95ENijTiWXt0=;
	b=zTBber2xwdhqaR1ZKtu9kchwOo/IKDpAR8XdzQmnnzy9PYadS2FN0hcBHp3MUlZWW4vD
	 IcxAYYfzCC1Ng+lHVWkJyd5CSiha4gkCUHg44pUh4mLVGvuxBhCQdLoi/xz0ty7GZID8p
	 8BJnFWs83++Wf3orvFQkN3Mug0fDZ6vBQJDJOnmieEAFGP9ZvTYTFKFGNq5sZhWqz53Ka
	 WedYvWWii8NPvGAw2coDGroKRHs7AQN+VwCEtGyBev+2kKXnWR2FGDVdlLN6G4eQ+612/
	 nAtSwK6Jcw2d7AD6nNA6qyO4kiqJSq3wcMmnwOk3MDoFJWO4LFcA0QjvfLw5tSbEhEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BgkI+spY;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC939606A323;
	Wed, 25 Nov 2026 08:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC939606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BgkI+spY
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68YAM300015;
	Wed, 25 Nov 2026 08:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XTPqPUDxN/C
	EitojWe4ZINBByJPfhqq95ENijTiWXt0=; b=BgkI+spYpZUMSOn8NyarfHFyFIx
	bFoO21qeie9SFeawHLYztZX3REd9sJlB15RgYotQVQAP56pJHOWWVa/YVUJoAoUM
	CC2hrIbrUbZuW0RwkiMpGNfe4Osy6TFe1sm/yVVM3IjWRuFcNSsW7F0UVt33g/vX
	fHjJmR1285dZvw/IMTk4j3RnE4h5iGhDGmdLMwSCcy5yNTeJE+RGhC284AFavCPf
	THRIoDRs8xwCn79PrsQwMRb1UUF0cI6GnC40PG6zf/+URF9l0HvSc4zMfLnTgTmg
	TbSf2w2HCpprP2aDktPM9BYI8QssNfOh4Rt5NQB9LeWk0wS1zEnZvtsXzkw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5n6rspmw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:56 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8dnKA075228;
	Wed, 25 Nov 2026 08:39:53 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AP8drAM075688
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:53 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id B6385248F8; Wed, 25 Nov 2026 14:09:52 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
        atishp@rivosinc.com, anup.patel@oss.qualcomm.com, will@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        beeman@rivosinc.com
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Subject: [PATCH v6 2/7] riscv: pmu: Add Control transfer records CSR definations.
Date: Wed, 25 Nov 2026 14:09:37 +0530
Message-ID: <20261125083942.3695072-3-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
References: <20261125083942.3695072-1-vikram.singh3@oss.qualcomm.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX4Vq8Fg66zvEo
 fNMobVBeJLaLoL32dxoDjzX4VGv+qH2q7rLxtkfrdsw8OyxQl9ndl6gY7gbjj8+fcmM5nTvNyI+
 c87RKqIBv2r+KplomCOTGVauNPK4DCT2wrT2mWg2AUfHed6IIqcEt4+J0L4ZO0kqG2p292JC8w9
 f3wzh0pjlMpXc6OBp1H0d+XQNMNNJUB/1dt9QhR1hM8qkneI3DWj/J7CyjyDVanQPRyJvXk02vD
 TfrFwoFIPdOqt0DyfrW2GUkk5nPUL/MKdwYjpbWf4tDMx1T/aAXrioJtmJvsRY55Vp/r7oYqS58
 CvRumnf7Tgxl3mXfOxrF/a+6tEDfzLJln0PlI1WQhI9Lz7YM3wZlwSK5faHaxb4Ue4QpJI5KvS6
 /kWauk513npQ4ybsY4SlM5NoX3wubyXzBnKvPkBir7qsH7+SLPNPQDPvvenSVho76sBCPZyj2GC
 lNoah8L4iEAvFYgM4lA==
X-Authority-Analysis: v=2.4 cv=Voa2kO2n c=1 sm=1 tr=0 ts=6b069edd cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=09mEapMM1jRCVFC5K9kA:9
X-Proofpoint-GUID: tzuCuKxyniK6G4xInZnHAFYizsxyVGcB
X-Proofpoint-ORIG-GUID: tzuCuKxyniK6G4xInZnHAFYizsxyVGcB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfXxZbw/upm3rck
 fTWRHH7JCR7YZW9LDVWKPbyeS+6vkJMvKZ3wZsJdKam7wEZCmmPSJtT4M6yjc9h9f1YcHiEj8aS
 g7WM9N1vwmDBWuQg1ggv23G5FHOX0bg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034

Adding CSR defines for RISCV Control Transfer Records extension [0]
along with bit-field macros for each CSR.

[0]: https://github.com/riscv/riscv-control-transfer-records

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
---
 arch/riscv/include/asm/csr.h | 83 ++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 621f84d1898f..ec1a6ad31775 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -350,6 +350,85 @@
 
 #define CSR_SCOUNTOVF		0xda0
 
+/* M-mode Control Transfer Records CSRs */
+#define CSR_MCTRCTL		0x34e
+
+/* S-mode Control Transfer Records CSRs */
+#define CSR_SCTRCTL		0x14e
+#define CSR_SCTRSTATUS		0x14f
+#define CSR_SCTRDEPTH		0x15f
+
+/* VS-mode Control Transfer Records CSRs */
+#define CSR_VSCTRCTL		0x24e
+
+/* xctrtl CSR bits. */
+#define CTRCTL_U_ENABLE		_AC(0x1, UL)
+#define CTRCTL_S_ENABLE		_AC(0x2, UL)
+#define CTRCTL_M_ENABLE		_AC(0x4, UL)
+#define CTRCTL_RASEMU		_AC(0x80, UL)
+#define CTRCTL_STE		_AC(0x100, UL)
+#define CTRCTL_MTE		_AC(0x200, UL)
+#define CTRCTL_BPFRZ		_AC(0x800, UL)
+#define CTRCTL_LCOFIFRZ		_AC(0x1000, UL)
+#define CTRCTL_EXCINH		_AC(0x200000000, UL)
+#define CTRCTL_INTRINH		_AC(0x400000000, UL)
+#define CTRCTL_TRETINH		_AC(0x800000000, UL)
+#define CTRCTL_NTBREN		_AC(0x1000000000, UL)
+#define CTRCTL_TKBRINH		_AC(0x2000000000, UL)
+#define CTRCTL_INDCALL_INH	_AC(0x10000000000, UL)
+#define CTRCTL_DIRCALL_INH	_AC(0x20000000000, UL)
+#define CTRCTL_INDJUMP_INH	_AC(0x40000000000, UL)
+#define CTRCTL_DIRJUMP_INH	_AC(0x80000000000, UL)
+#define CTRCTL_CORSWAP_INH	_AC(0x100000000000, UL)
+#define CTRCTL_RET_INH		_AC(0x200000000000, UL)
+#define CTRCTL_INDOJUMP_INH	_AC(0x400000000000, UL)
+#define CTRCTL_DIROJUMP_INH	_AC(0x800000000000, UL)
+
+/* sctrstatus CSR bits. */
+#define SCTRSTATUS_WRPTR_MASK	0xFF
+#define SCTRSTATUS_FROZEN	_AC(0x80000000, UL)
+
+#ifdef CONFIG_RISCV_M_MODE
+#define CTRCTL_KERNEL_ENABLE	CTRCTL_M_ENABLE
+#else
+#define CTRCTL_KERNEL_ENABLE	CTRCTL_S_ENABLE
+#endif
+
+/* sctrdepth CSR bits. */
+#define SCTRDEPTH_MASK		0x7
+
+#define SCTRDEPTH_MIN		0x0 /* 16 Entries. */
+#define SCTRDEPTH_MAX		0x4 /* 256 Entries. */
+
+/* ctrsource, ctrtarget and ctrdata CSR bits. */
+#define CTRSOURCE_VALID		0x1ULL
+#define CTRTARGET_MISP		0x1ULL
+
+#define CTRDATA_TYPE_MASK	0xF
+#define CTRDATA_CCV		0x8000
+#define CTRDATA_CCM_MASK	0xFFF0000
+#define CTRDATA_CCE_MASK	0xF0000000
+
+#define CTRDATA_TYPE_NONE			0
+#define CTRDATA_TYPE_EXCEPTION			1
+#define CTRDATA_TYPE_INTERRUPT			2
+#define CTRDATA_TYPE_TRAP_RET			3
+#define CTRDATA_TYPE_NONTAKEN_BRANCH		4
+#define CTRDATA_TYPE_TAKEN_BRANCH		5
+#define CTRDATA_TYPE_RESERVED_6			6
+#define CTRDATA_TYPE_RESERVED_7			7
+#define CTRDATA_TYPE_INDIRECT_CALL		8
+#define CTRDATA_TYPE_DIRECT_CALL		9
+#define CTRDATA_TYPE_INDIRECT_JUMP		10
+#define CTRDATA_TYPE_DIRECT_JUMP		11
+#define CTRDATA_TYPE_CO_ROUTINE_SWAP		12
+#define CTRDATA_TYPE_RETURN			13
+#define CTRDATA_TYPE_OTHER_INDIRECT_JUMP	14
+#define CTRDATA_TYPE_OTHER_DIRECT_JUMP		15
+
+#define CTR_ENTRIES_FIRST	0x200
+#define CTR_ENTRIES_LAST	0x2ff
+
 #define CSR_SSTATUS		0x100
 #define CSR_SIE			0x104
 #define CSR_STVEC		0x105
@@ -563,6 +642,8 @@
 # define CSR_TOPEI	CSR_MTOPEI
 # define CSR_TOPI	CSR_MTOPI
 
+# define CSR_CTRCTL	CSR_MCTRCTL
+
 # define SR_IE		SR_MIE
 # define SR_PIE		SR_MPIE
 # define SR_PP		SR_MPP
@@ -593,6 +674,8 @@
 # define CSR_TOPEI	CSR_STOPEI
 # define CSR_TOPI	CSR_STOPI
 
+# define CSR_CTRCTL	CSR_SCTRCTL
+
 # define SR_IE		SR_SIE
 # define SR_PIE		SR_SPIE
 # define SR_PP		SR_SPP
-- 
2.43.0

