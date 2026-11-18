Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995517;
	b=gAwRkDZogDuG94UfxPOxq7Vx/GeaonJFW63DpM5BHTzCkujIlUYiG0jbaYFGXjTzEeJf
	 92KfVCoQKg4sGZEm7YnDeSxj1UnfJYL5iuCTaSIa2Ahe7wASwSCFEW2tSQV+Flkryvn09
	 nE7pweLyTb1CvpnH58G2StfTSVjioV70xdZRZF1EefF1JkNT4tXaPGor9fMNB6hGFA43y
	 2mWN3xoEw4lmupO3x0gnc8/YulaPFom1UfhYwbpMqHHKGnAcEPMTbGw86eEsjvj4WVsZy
	 tLr9CTovpAn98+ahX4OD6rBT7jUyZYi4bKBsA/QxrK4QtGfv4ZxmvSyU8cMPdAfnwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995517;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=raernBkx1z2N52KV1fejKrkCeqXuCwcvRnQstyAvLRE=;
	b=sTU5fApKoEppO7xKtmuQjeiA6cqcAZs7mIrk+f0IB3KBLBa2xota7+qE/GCqoUEfk8VI
	 IBPCwMe+cg8QJrN01AqNbJ6dA93dcx6OEX/NOHNrmN+kpQoKaaOvBZlam+wpBo5f9att8
	 dCDq9VMenbj6e/hjN/UtN8q91yrgP0hK8hTiNGom7eahMNWvL9rtZ55K8OXWnjeu6LKJR
	 rn099k8GT2lWhQfsIOzigFW8QxlzrpgvF5U49srmZRXnRcL2a2uHtr0e4/RDtAtj4w56o
	 6Jiu1Ld8ZNgSqu408NW5MpHPu3CQjDR9h83x3ierOO8lfGgmP23MLe7M22cRMA4rZfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mIeDbVIB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9D7606A325;
	Wed, 18 Nov 2026 09:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E9D7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mIeDbVIB
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9kRX82930707;
	Wed, 18 Nov 2026 09:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=raernBkx1z2
	N52KV1fejKrkCeqXuCwcvRnQstyAvLRE=; b=mIeDbVIBOz8Ph+rRLu2JBND3UP+
	L3b3xfwldgxP6ONYN8WrynIbYdAZXVyddoLRe8T1QvHEULC6GckryZ+4WfVoUKh9
	LBFCCcPmQbyurCi/6tEhLGtQlbAp+I20Vo4lMm5ELrbmlGShG1JI/iufueKqweJw
	pLWvzXiH5K1h8DwJyQ/grKSw0nWrzwND1Rute/V7pUljhSrnqEiJzWBlZ4TGhwtr
	06kbtgPJb70SSJHpaHsYd5rwx6Q/97r/ZDpWEH/dUKhtz7JWvtf9fM1SzGWf3B4a
	DYk+2XI0Sg3VMQn/zKxE6wVK0RLeTKqZoC8eYMMfCU7BNpVgOu18fBUHVmw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9jcqf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:23 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI9kSlu2448973;
	Wed, 18 Nov 2026 09:51:19 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AI9pIKj2457027
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 09:51:19 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 2356124881; Wed, 18 Nov 2026 15:21:18 +0530 (+0530)
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
Subject: [PATCH v5 7/7] dt-bindings: riscv: add Sxctr ISA extension description
Date: Wed, 18 Nov 2026 15:20:53 +0530
Message-ID: <20261118095053.3871267-8-vikram.singh3@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=QenzLcbv c=1 sm=1 tr=0 ts=6afd751b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=W-_n0kkjAAAA:8 a=fXxXU15QYnOlaBXbNuAA:9 a=qeNa2pbTr82C0GpJEZFS:22
X-Proofpoint-ORIG-GUID: p5xudSjaHSzBFcN8zq3hAOVjUVl35_ih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX0Bwt+ddUxWEy
 TpC0OtER0JVNifRvxLGTVzK4BE0M8P+baVH9foZB699j/bA+hF10N7yT/LxnnCUdqDUKhlbFU7c
 eT+6/Xjdhkr0Td+ODuELsGk0Fc8KYBH7mHMZ3HlWYNSs5JSGsX110YeIB7gq19hozV2dCIBLlA3
 flgXHCe8OWBPNipusClt66f2PvAuryH3Et3FxYf2XPMF37IbPHAKV7l32Nu/UotJqghYFd64Q8e
 qvyh17sWDsD92PsrIdwzg9XG9xItJY/iathsDmTyXG5OwukL5ARBqm2YuB70wtZoLMjJ2wWVI+z
 xC2MpG8xAswmRoe5cEBF0SXPIeHTKxKZVqUtuYMeeSEDxWyLjQFagSEqeTRoO4q75mJ6mba6wvL
 9mbXjWtK8PW5Nj1AEYvk0UIZQquyooPkszhIDCArSYtTstdzH/0WCI2H3njtjKSNkzxW1PynL2W
 W/p4q2AjJ9KlqHyOFGw==
X-Proofpoint-GUID: p5xudSjaHSzBFcN8zq3hAOVjUVl35_ih
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAzOSBTYWx0ZWRfX4Nib9TlBa7eF
 JG3C6UfDQMx7EhkD140oZZFDsezhYzW5rhxcJ8S/JL81/ihXIAFkEhoFfxto7odbKSxJYLa/PRY
 +r6/7sFILDcCV0mQr397DJg+bgJcpSY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180039

Add the S[m|s]ctr ISA extension description.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20261106173942.3175069-8-vikram.singh3@oss.qualcomm.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 .../devicetree/bindings/riscv/extensions.yaml | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 79491ef8f86a..dde2f28cfda5 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -202,6 +202,13 @@ properties:
             mechanism in M-mode as ratified in the 20240326 version of the
             privileged ISA specification.
 
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
@@ -263,6 +270,13 @@ properties:
             mechanism in S-mode as ratified in the 20240326 version of the
             privileged ISA specification.
 
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
@@ -1189,6 +1203,21 @@ properties:
             - contains:
                 const: zicntr
 
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

