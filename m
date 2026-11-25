Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596032;
	b=NR+EzWa/eFvtB00R+A17R244Rg/WF1uBRvnAzD+hWaNwwi1wM+5Zf58cHjO7zsMvOrwJ
	 kSS8J55ausPQwI9cflGQJj2GI6+N0YKLxjyh8K6Ns+QyKHPnkhPRI4ZxhfWRst8zTcUeI
	 oVkwlx7PERdqrOUqEDjhbny2hBGxbF/PTe8ax7ydrHJB/NXt76EUqx1CqUv0MW8JfyVfg
	 n2uJb5XV4BVzdeUsKjLtkvjxv8BSbhMqCyOftOsGzPJu/khgQ8HvDkkmwHRpS2BIw9TJE
	 MUxGPL9tBC917YOK3SOYXY2pZzfQnYDJYDndKPWIeYaAm9NrPmIJGu3vBpDdlDBLtZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596032;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=AvnVbT6KZ8F6ADsLJ1+gAAYjJZ9yDvF84AvqfiU/jqc=;
	b=P1DpvMmufkC0t9UkqRsYCgqbalVye3qY0hNEtqJ0SLJaSsGPs5OLRJJiLWk48bH4jWn+
	 hvNQQ2fRX48q8wS5leMkrCxj6+OkHv2LRloG1ZGRxvn/FJkUGt2HFd9UjYv7oBWTUEeJQ
	 9nwiU0BgPLKKkY+9UJs3yQekxWWW9fQ8kRv/ATYYUlH5+gyalRCczgnisYgaNpic0Whij
	 /tfLPytWHq0DyJNxOQkPmXwwqENMQSz3AzHoJL+b/uxT8NbrTxvaEiZ1QBA8WFxmSIYS7
	 e3bfq6afhppuq4robFDn2U0BoAKx0sVO8SmiISM+EdQ4ZUqKK16qCxF/vcjowqfQ77w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D0gmBk2B;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5B606A330;
	Wed, 25 Nov 2026 08:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BE5B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=D0gmBk2B
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68Tmo2629342;
	Wed, 25 Nov 2026 08:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=AvnVbT6KZ8F
	6ADsLJ1+gAAYjJZ9yDvF84AvqfiU/jqc=; b=D0gmBk2Bc4aOwQo1DO0mldgiYVN
	ufC7F0fYeTEOhsW5mOAUxiBXqx0XE93Z81qelnPovtguEWwTyDPWwd+62PBDjl8W
	1EkhOaSUDF9WoYW3jEUMYTxIm3PS8PvLN1SCsgGD8LOsphq+YEq5JPECB8dzX3Fh
	jx32SGGG8LcbZP2e6/QHn1cCtsAs6XQRCj5lNQnMzHTLxxzPRE83JygWxfRFqCT7
	rXnXOGF1AnpefocvcfkTBzgZ/I60ym/Ov3sxoNpWE9RWZ71q3v5GyErij+F/xhE5
	dwxyxFZZgBx3SJdQXVWzAyD4VgvX1Ea1heJWPnq+eR1Bx7loEVqDinqNm5Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydb5uj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:58 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8dsSs075720;
	Wed, 25 Nov 2026 08:39:54 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AP8dsV7075705
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:54 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id BDB62248A5; Wed, 25 Nov 2026 14:09:53 +0530 (+0530)
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
Subject: [PATCH v6 3/7] riscv: Add Control Transfer Records extension parsing
Date: Wed, 25 Nov 2026 14:09:38 +0530
Message-ID: <20261125083942.3695072-4-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfXx6KWE/XgCjmb
 qrg+rnNQr/qsQ5fZ9+fYOUy8IvpSbLTR1qTWjOIK/fnvQT0u3Dj16s0KA3IfFOdKoim/ur/Lx/s
 xqWOVbP2IDBEyFFLjI/bUDWBlFfYaAk=
X-Proofpoint-ORIG-GUID: lyLvHJ5nm2ndB6EoyMGfZIR58KwRaFV6
X-Proofpoint-GUID: lyLvHJ5nm2ndB6EoyMGfZIR58KwRaFV6
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b069ede cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=qp1dJYA1fx1RrFDB00wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX+opwgQ3lpzCy
 Stywxn4/GA8YTUFPjJqUN5RbxGBSO3SJALKFvSVVN2Bs0Pk0FxNh1TYwULIKRia3QFFjDIpm+8V
 tWOiOJYbXiahaQIaJWXeny5u1EYsup+yQexYvEXO2l53liJm3fsoza3wlunh79esNGwJOUGWqpN
 HR7oHZ1N9JmbhE78MlYDTquY5XRa/cZDsaJEDCFzAA4U84HZzQ7CW/BT7arBbvCtR4HmRyAPOCB
 p9XZtXgBNjVhosfV6ARC/sy9HD6CBbkafy2t9+vrEd/twf/i2i413a57SKjz+L+klrf1xcE/Dv1
 iUhct0jta7AJiopF2xgEOyvBW3bMtR+cJhrFsrW5HCCbYSMbqtpl+9GzddH5i/I+mTQYxLOLsky
 kjvSVFz9w3opBQDSJa/v3dsbXiQp+rR0/DbfCFsWmjOM7+AvxOqifS69GuIRFAH9+eOB40zvgNR
 JW/pvBQSKzdTL85jNYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034

Adding CTR extension in ISA extension map to lookup for extension
availability.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
---
 arch/riscv/include/asm/hwcap.h | 4 ++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b5952db9259f..bf52750b29ca 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -126,6 +126,8 @@
 #define RISCV_ISA_EXT_ZIC64B		116
 #define RISCV_ISA_EXT_SV48		117
 #define RISCV_ISA_EXT_SV57		118
+#define RISCV_ISA_EXT_SMCTR		119
+#define RISCV_ISA_EXT_SSCTR		120
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -136,10 +138,12 @@
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SMCTR
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
 #define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
+#define RISCV_ISA_EXT_SxCTR		RISCV_ISA_EXT_SSCTR
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 72bce616491f..46598eba9b4f 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -649,6 +649,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 				      riscv_ext_smcdeleg_validate),
 	__RISCV_ISA_EXT_DATA(smcntrpmf, RISCV_ISA_EXT_SMCNTRPMF),
 	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
+	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
@@ -656,6 +657,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv_ext_ssccfg_validate),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
+	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
-- 
2.43.0

