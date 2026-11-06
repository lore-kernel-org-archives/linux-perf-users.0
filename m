Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986898;
	b=STPPB2ngaTQ6B+Eq0OUMDzFH7h2dtZ2BRAfCsFNDKXZFmIDKVrpSoBOCb99SNmHx1u3w
	 GoyAwSgmz6pSkBTHMu9urvso344KcExJqJcHsNLGuffmNXrW/3mWbNYbSQKRzMvl7mWx4
	 TbnHYXH00agGeRAzzhMIthCTPSCtaJve5+L2I+MPVnAhwoGUMrAvfj4z0+J3ZKz+zYlbu
	 amxsj034juNSKz5g9TldkCH+UdIANAUYJ9OZMOmbHZiMAFBT4zqIAOB7l6jk9B8T7kQah
	 te4sPh8PlVksqkBlTLvxw8sxCr2u8ZbJiWzDPKSAQ397rJAMl5G3ZNtLan7mmB4tFrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986898;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Yibm3BXkE2MYQUbwmQkrzleeGap3eGKeokSbxpIlEu0=;
	b=yTtmM4E+cyLbKRThjDRGJd2OgTJ4RQ9/FFkmPKsRtUBwTfVpDPAMlo0FkTPRfdr1Y8mR
	 Ed4/VWOR4p6MbK4lTbgmV4R0/0PyFJXyhG5pAizjtiNN5aOCDyfC0k7AlPtZ0J2U0blY8
	 whZsZDFNd6A0gWyvEfafbEUFvws2ncJr8hCJeaqf0/6nsmKkKToDOXFz+Np/QD3Tj44RK
	 U5IBwmrcSBD/nK+nuBP15eqr1/diYQ+0LuA1Exo7XQVs1ivh4qJZ7N+AGFnrBt1r8Qnkv
	 YPu/bnQhdSr2Jcwy37TBzVbZie2SP/aB2qh1s6DjDH4+DvyUJkcaqhWLnpRXVoFHVWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LM5a14cD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2346E606A334;
	Fri,  6 Nov 2026 17:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2346E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LM5a14cD
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F0jFh710224;
	Fri, 6 Nov 2026 17:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Yibm3BXkE2M
	YQUbwmQkrzleeGap3eGKeokSbxpIlEu0=; b=LM5a14cDvD65OYrJvDt5bzUJ5tT
	1op0IT716BYXHmCefiRCoahOYDvNKkkHBlryFLc22a040cVaXCG1RTUJVUYUYBlJ
	w95Gtj24kKnNUpdnV/R9Y4uaKakZchbTAIYnVYClxLA197cl/e7rtAIBxI48bGMk
	aYfU5fwCG/5RoZtspnY55e4DAS0Ka4gJb6uBlMpz8hL2lfLPrAXwbILy8QMh9HIZ
	riwGerhcxPsOD/0LL9NilyJyP0AMyKuWnA+yRmsjN4Wvn9ZTqqyvWmPen0KH1GX1
	h81EIoiRBVaP8Vyl5I9YgGhbH6gZeY4A7lm8TPAuee8KBvJnn/j/VeXr8Hw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pauxrk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:41:04 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Hf1931892210;
	Fri, 6 Nov 2026 17:41:01 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6A6Hf1GS1892197
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:41:01 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 50531248A1; Fri,  6 Nov 2026 23:11:00 +0530 (+0530)
From: Vikram Singh <vikram.singh3@oss.qualcomm.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Anup Patel <anup.patel@oss.qualcomm.com>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Beeman Strong <beeman@rivosinc.com>
Cc: Vikram Singh <vikram.singh3@oss.qualcomm.com>,
        Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 7/7] dt-bindings: riscv: add Sxctr ISA extension description
Date: Fri,  6 Nov 2026 23:09:42 +0530
Message-ID: <20261106173942.3175069-8-vikram.singh3@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
References: <20261106173942.3175069-1-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfX05NdftYzmmID
 vXWCdaw3bEB4WNbKu+RG6mUaPKQCBKjqKYB+UI/vzCW47spfJTmLli+9cVDu6T/JFzIe+tUE3Ce
 Wuo4/G0sm59l0B27mj4mRhVCvUPru3uz0Ru2XQCKxhCKah/d39QFOdo4QYVmiyyL/Vw/iRtYUTH
 rNVuPNjCT8Qew15T7JI/rKIZSmWeGK2OsjehBXv/8fH2pJ6yQWDt27PF4FhPE4yc2NlHjIeKMKV
 unnlAJUDRqRFA12U7+cXnHcRq3f4Jq+FwWM1RDD0Oo2EvvfltRL4775SW7ziSasDpvbaPmSeMsf
 7M2QR0Ge4F1UdUtdY8kf1kUC5ZZU/AzuRWnZIgrrFMgkyv3/bQZSJGFgjKcSGJo9je1OEpPUJA9
 4FCFHsR4L8EIrirU4zm59p+Zg0vwItmUGS2KIzbiL5I884ZEkls64inckFZf23uUp2GHSFxklJJ
 f2MFsExiI1ZT8xn2+Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3MCBTYWx0ZWRfXymllxuIfBKkp
 h6ntVUa9rNlF4Cq9X92d31Zyg5b9LvstMGErWDIcOqvMYO3k2Bpurj+ZYF51qaCNStLdf2X0AUd
 nsk7OCv3F8Zzqqb62hbOwatCS3oFnik=
X-Proofpoint-GUID: Cg6mbRcGMXfr4b01lZdOaVB_7MzFbyvl
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aee1130 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=Exv8Xlj7FnKSZPJZB1kA:9
X-Proofpoint-ORIG-GUID: Cg6mbRcGMXfr4b01lZdOaVB_7MzFbyvl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060070

Add the S[m|s]ctr ISA extension description.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
---
 .../devicetree/bindings/riscv/extensions.yaml | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index c9dc5d80c0ea..c0dae4f536b9 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -181,6 +181,13 @@ properties:
             changes to interrupts as frozen at commit ccbddab ("Merge pull
             request #42 from riscv/jhauser-2023-RC4") of riscv-aia.
 
+        - const: smctr
+          description: |
+            The standard Smctr supervisor-level extension for the machine mode
+            to enable recording limited branch history in a register-accessible
+            internal core storage as ratified at commit 9c87013 ("Merge pull
+            request #44 from riscv/issue-42-fix") of riscv-control-transfer-records.
+
         - const: smmpm
           description: |
             The standard Smmpm extension for M-mode pointer masking as
@@ -226,6 +233,13 @@ properties:
             Profiles Version 1.0, with commit b1d806605f87 ("Updated to
             ratified state.")
 
+        - const: ssctr
+          description: |
+            The standard Ssctr supervisor-level extension for recording limited
+            branch history in a register-accessible internal core storage as
+            ratified at commit 9c87013 ("Merge pull request #44 from
+            riscv/issue-42-fix") of riscv-control-transfer-records.
+
         - const: ssnpm
           description: |
             The standard Ssnpm extension for next-mode pointer masking as
@@ -1120,6 +1134,21 @@ properties:
               - const: zilsd
               - const: zca
 
+      # Smctr depends on Sscsrind
+      - if:
+          contains:
+            const: smctr
+        then:
+          contains:
+            const: sscsrind
+      # Ssctr depends on Sscsrind
+      - if:
+          contains:
+            const: ssctr
+        then:
+          contains:
+            const: sscsrind
+
 allOf:
   # Zcf extension does not exist on rv64
   - if:
-- 
2.43.0

