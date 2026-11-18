Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995522;
	b=3MAtLcryHig8PwIrWB3eYJnaErPkKY1XgMwDbnLE71nMeVs3+5nCa0dVswBaJLXBbHpM
	 v7MGULnVmPrNjwMiZEt3HyXGE9kehfVYYRQ7pDprH99Zi/bRgXRFgigm5pavz4QlEqiwc
	 xZ0w0Fvqu9JTelv+z/ufiQ7qDlFTsqPAkJHcIbzRHpl9EL71K9lauAM/g/kJfJgcEk9v3
	 cmHyajsL9zqAiGbjF4GpY3agFoU7YaI0lT7OgVRRrW6GNW8uq2iogI5c4zPwQz4aaItLB
	 65m5UcKT121XnNM299UAGmi+KjDNF2+Ejl0K6Bl0IYmhyTuusvKuBuvK4Un0E0fHPEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995522;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Ui7XMRu1eCK/S/p5ooPjZ5tVl6e4CsIVwRS7ksMmBH4=;
	b=VpqGn/rD9m4b0OK4o4gTBIiRIHmdmqSb9/0pbwTSk2OBOUvwQHJjLWUmnR3/tksv3lhy
	 BUG6RMcuMTUThuZmnMRQDkoEcdouzGXyJRrWrOL1VO07Trc8ebTwakhDCCC2yXBBzAKas
	 FZWCV8iWTbIJOVaIHOGldU3tS28zpWHfrFjz0NgG7VNwjQqPwi4Gga9UL0uZDjwkdOHsn
	 pN+yPraykmuTZXZJKsIoeFVIwKEr17xwj3EdnjMhPJCcvKoW7swCdU9QqmlOHXvscg3sg
	 7QgvP2kOvrNHIWufaZCC5bmT7sKgEbMqc5HLfPx16oAo5iatfI8A4nZciHrF1hcx6gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laVN3zJs;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9089606A32C;
	Wed, 18 Nov 2026 09:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9089606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=laVN3zJs
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9k5xQ3578089;
	Wed, 18 Nov 2026 09:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ui7XMRu1eCK
	/S/p5ooPjZ5tVl6e4CsIVwRS7ksMmBH4=; b=laVN3zJskZLszkuKyiDbKPql+yY
	vyu0NRTWKWhhyzv7G0XyTm1wQ9tMmcDSJF3UoEW6p8p1Tq+9OowMK1DeZhREAymO
	n91tiVXDg5l5XZ5vH/cgpvjBN7wMjWX5TIFL9WEtDeRFg3YVBzIbn760RR/jFP+7
	XEek5itD5w6LDpQa0vzyZOm65SmxV8QS3haGmdPSBqJb48otgknSA36cbey3kg2j
	8Ug29u2oA+An7Z3pE7xj7FQnlGOo1eTIHxrGO1nQE1ZGlvW8BrP14Eo2LtlCBWA3
	RrymG3vezqm/+lWtMrw9/j9Zz/s+yOYhXvt0A3Zyy4o93no+GldnKeWozDQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv72fc8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:17 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9pE00375990;
	Wed, 18 Nov 2026 09:51:14 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6AI9pEMM375980
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:14 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id E9D5C24881; Wed, 18 Nov 2026 15:21:13 +0530 (+0530)
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
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v5 3/7] riscv: Add Control Transfer Records extension parsing
Date: Wed, 18 Nov 2026 15:20:49 +0530
Message-ID: <20261118095053.3871267-4-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
References: <20261118095053.3871267-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-GUID: L9bidKamvHgPUBbJBmzyqHE8pf1tSJEv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX9ad3WICbwmLb
 rxe4MEp6TfcWBAaDMRqHyRJHlmjLU5K8s3u2x/yo8v0T6p68uW/LOq8f8iQz7bs/E3n1B40jaKY
 0hp6mYBTd7ufOSVfqkeFNANvYZdIqyvQVq8sx3nF4irKs7yVhs5ZTN5kZUVx3UzQuAqi+ATsMqX
 VNeqcXS7TE2c7WyK9ewuToqlc+aydNayRcojKoH8O8wQx0bvg8fK3AwOY6OONGbslni7U0NibQw
 2ttgUqzwFBl27bdgwyDZw5PjU9GanXogAvIYVxBsGhtxV/yabwTNTpWAISGqum5Ktw4/dX5m8wO
 lld4PFlBHQKeTIG1U2+mdjWbufd2XrALqegqNRCfB4aEGSLG0Mnk9l3lQQCZCKiwh1V6valnn94
 MW/rK1d5WqOTClcfZXt5r3t/U2t7HnipW9Z9tAQBBx1wK/V96oxELPgRkLzUC9aBqiXBA/h1At5
 dsJpJ2N5Im59MXsc9Rg==
X-Proofpoint-ORIG-GUID: L9bidKamvHgPUBbJBmzyqHE8pf1tSJEv
X-Authority-Analysis: v=2.4 cv=H8xOUOYi c=1 sm=1 tr=0 ts=6afd7515 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-_n0kkjAAAA:8 a=tUtPt1BIteo8AfM-IXUA:9 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX36oC45Vhgxq/
 NACFVaO13C6vc7YewqPAtJEXEvHS0KuvHlfrE2rqPHaRAfGxpyqPvYBW+lcsB55y2NLYdqyGh+o
 X3xMdC2e2SdEXOY/0sw5rSqT+vGDDeQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180039

Adding CTR extension in ISA extension map to lookup for extension
availability.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20261106173942.3175069-4-vikram.singh3@oss.qualcomm.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/hwcap.h | 6 ++++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b5952db9259f..ee200d8cfccb 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -126,6 +126,10 @@
 #define RISCV_ISA_EXT_ZIC64B		116
 #define RISCV_ISA_EXT_SV48		117
 #define RISCV_ISA_EXT_SV57		118
+#define RISCV_ISA_EXT_SSPESA		119
+#define RISCV_ISA_EXT_SSPLCOFI		120
+#define RISCV_ISA_EXT_SMCTR		121
+#define RISCV_ISA_EXT_SSCTR		122
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -136,10 +140,12 @@
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
index 72bce616491f..b3e3c30f4c8b 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -652,6 +652,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
+	__RISCV_ISA_EXT_DATA(smctr, RISCV_ISA_EXT_SMCTR),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA_VALIDATE(ssccfg, RISCV_ISA_EXT_SSCCFG, riscv_ext_ssccfg_validate),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
@@ -659,6 +660,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
+	__RISCV_ISA_EXT_DATA(ssctr, RISCV_ISA_EXT_SSCTR),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
 	__RISCV_ISA_EXT_DATA_VALIDATE(svadu, RISCV_ISA_EXT_SVADU, riscv_ext_svadu_validate),
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
-- 
2.43.0

