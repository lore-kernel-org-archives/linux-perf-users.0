Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596042;
	b=QvkGsBT6gn25Hp/VCMZPJU+mLplM8vi3hcxY1dj3UE8y4MAm0pd0+W6G4+o+7LqHLFca
	 AObkti3BnI2zIfYt6jNnadRnDFgtDl91eOeA9WRl7akQ5/UoR69CFs/Q7eExGfi1tWqyV
	 Fcfgh9IsV3TPBmZh1l8hGb9hanRmqEzqlbRRXxRi79v4t/w9LKYmmJMvF6LGduVwnV+q5
	 /gQUkITR18EDBGrB6I3Bv4n+pD9EXZffEZeq4oTiL7OC9AWYBk9fMvGvzm73aG5BNj7Kf
	 l7doVJb8uuj/3txDANjxHC8YoeXnytBdHA9xKZOUur9uioiOLiTuM7u691eHSOL/9cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596042;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yq62kjbFDtxAK3raX9EKcggR3VldyMhTYSizs/nAmv0=;
	b=3KY79GqkAAg1oU+XJ4BjowdH4uEmOvCqjWWKgUO1DVDw8rm9dEBRHQDYqe+BBTDS3KAS
	 Y6cfAXP5OM+jlV8noM88n6IIRMBCx39CSVmwH2W+R7PVY+OBYOqzCIhcfQ4Uy4RinuCZe
	 uBJic+AIfo29bjfcoQYCT7TicZCHivDPotgwqpIiynY8l1zrY/KoOOPtqWKRXwUG5YVdz
	 jiJKvuzh6cmT/MLxyc3lQ2za15sPUCxtqabdpV7n8Qp+g8TKqdHuQf6BH2ZjXBSgcPS6s
	 Rsf7DWCSa+CURbdH06MwDC9QaRCTMF2u51q/WXnK7EoDYoYCLFdnpkd9/4JThzNnZsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fBGhuC3x;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F1B606A323;
	Wed, 25 Nov 2026 08:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F1B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fBGhuC3x
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68TDL2629335;
	Wed, 25 Nov 2026 08:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yq62kjbFDtx
	AK3raX9EKcggR3VldyMhTYSizs/nAmv0=; b=fBGhuC3xTnMRrieabBbSgyCyIhZ
	HtP4a6Nutj7kSprsE7HXLFOeKu501ftE9uIScvZ7aT1z3AGG5czq2YttQ6oMp4YX
	rdQJyY4yLMnfBL4pbkx/NlTBTTMFbTIQxUKjJ8JkreIQOGfixI+hbMaXUfVaBWA1
	ctB2ENN6x4wOe6ggMma6KYUrQzSjeNw2EQQHHQLAhTIHH/s98WVgFRhrrBZ0kq95
	JyjC1UynXSGyzt+fTX4tb1C7GO2joTHnSclMw+ypEV2b1V9gRy0qWLhlak9YKfbY
	AhOxE4Djc2NZ1nvmbpcTFsVM6iVL7xJxpNZvqK1ec2k57voFIB2s6gEeBHA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eydb5uv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:40:00 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP8dwGH075779;
	Wed, 25 Nov 2026 08:39:58 GMT
Received: from hu-devc-blr-u24-a.qualcomm.com (hu-vikrsi-blr.qualcomm.com [10.190.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 6AP8dv08075771
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 08:39:57 +0000 (GMT)
Received: by hu-devc-blr-u24-a.qualcomm.com (Postfix, from userid 4853235)
	id 20455248A5; Wed, 25 Nov 2026 14:09:57 +0530 (+0530)
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 7/7] dt-bindings: riscv: add Sxctr ISA extension description
Date: Wed, 25 Nov 2026 14:09:42 +0530
Message-ID: <20261125083942.3695072-8-vikram.singh3@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX/4c+l/UfkmaU
 klsl1UmFfncTKN5N3b/kcGFtV4ybjceDuecKZRj5bwaN478FTK9hR/MrNcDQdQxw/EASS3rcUvd
 0QyyH2mHgl4qac+2Z/E9KqIUEqPG6wI=
X-Proofpoint-ORIG-GUID: Yy3zRXtCmUDa-_2DR-ZVFt8VM6yO30cj
X-Proofpoint-GUID: Yy3zRXtCmUDa-_2DR-ZVFt8VM6yO30cj
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b069ee0 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8
 a=sUaezUCSs8oGO4LR0qkA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzNCBTYWx0ZWRfX+QPW50lTwKp/
 qujIntOPkVbssi24oqeRNgpuTC2d71D8CJkvVsJQmVpH47840tdyt3se76ZA6tn0EIAjdPX0h+y
 qgvfoIn/AAHD8O08m+zPQJusWhIRXFGTgWh/MQIggMq+D7gDAexfclUJMd3gJmdngY46WgmkBZ7
 jwqE5F+tlKAZndQrSQMGDaUAkkK8Az3fAKl1O4IvMLw5Vi5+syB2LCLuVaBnax1XbLsmw+Tjsei
 yr0CwRz75qfDs6Qk5ZbqNxl1QPqwWoj/8HFmFxRI0Sq6Icx6VicyZIe0rZVRSFRcYs2oBdaHO6d
 azOeF8HtgOdmGYU9/Dz3KBVyrLxj2OsLgkvoED37Hg1W7JMOYMP9A99z8vZJIxyNSpcMz3p0qQB
 /QT/d4cR32zlq1zYfwrzLVFWp04T6eOAnVJ5LmDqKSbVtZyv4S/Eoh050omPkCWyJHzYCu/VwPq
 aHbLo/wKwR7V6ntokjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250034

Add the S[m|s]ctr ISA extension description.

Co-developed-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Signed-off-by: Vikram Singh <vikram.singh3@oss.qualcomm.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

