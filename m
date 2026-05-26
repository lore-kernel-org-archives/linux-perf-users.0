Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7C3D4123;
	Tue, 26 May 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813830; cv=none; b=p9fhTTTFc91B1l+MY1KFN+9f15CI9GD/Quj49LQBhlQ0ctFE1KnyICblj9jx44zto2ZR/h4qsJyzZ0p9mM2S5eRdeJKXmnUxSWD/DF6ySyc6HxPSzfvlMAeRPfe8f946lEROhn5JnNur6Wi5q4LVvCw0UQLxeiokVOJ1faDtDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813830; c=relaxed/simple;
	bh=OUONPcSkBVglUXrJZjgcZjb3ZeOght1P0EpjVoRFfAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3DD4ljIaIFiMclSy4cHLgJbNL79Pag1ZuF6pWNgPtS414XXnNb6JedIRuDnCSLsJuNyJjd5cAXCKnMRdwc72cf3mVa2nIVERSAMZr0WjMKtyJuVT8FTyoSiMsJu/NDaGrqWCVxmdTAbPaCTqz7UyxIIsZZHxMY5Qsxy3IPkp8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hlJXfCZB; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="hlJXfCZB"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QB7E0h3724400;
	Tue, 26 May 2026 09:43:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=BBTg1eE/1oWssJcmckcNGbb5A
	VGahvXtqeWtCGgTeKw=; b=hlJXfCZBvFWMiIHwT5tTONZDoXWphtgv9oOQ5TAg/
	sw9XkATGxlr/LoaUrcoyS+P1DMjJ17JRzHWSjN8BldIcYQBbc5cQRu7L1HlNPQtg
	neapQurjdQ6hWakC+i6juixXJ+zZAqZ5LtBjDo1Piy/4Ece9ik7RpKXXfkVeFzre
	f5qHm05+NvgBNcJKvIzp1J0PdEHWagpnZptDnnPQJ6+kwmDZ0Y82F80jvZhLmWRQ
	heEeHfdPBEDq51wE6Qhh47Ya3TQG9HLqyqSbZg7soClK9wCrye3t3Gvry9sm120p
	sYgo972b2VTyFDLP7Q0sGv684NAk83O+ayBTLu28j196A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ec0g6eq0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:43:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 09:43:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 09:43:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 2FE463F70C7;
	Tue, 26 May 2026 09:43:33 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v6 1/2] dt-bindings: perf: marvell: Extend CN10K DDR PMU binding for CN20K
Date: Tue, 26 May 2026 22:13:29 +0530
Message-ID: <20260526164330.23878-2-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260526164330.23878-1-gakula@marvell.com>
References: <20260526164330.23878-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BK6DalQG c=1 sm=1 tr=0 ts=6a15cdb9 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=gEfo2CItAAAA:8 a=M5GUcnROAAAA:8
 a=9AufDOCnfQXnCl7mI70A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: JQhONNLmzFy8JI3PRJUCM-A422-pjb_Y
X-Proofpoint-ORIG-GUID: JQhONNLmzFy8JI3PRJUCM-A422-pjb_Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0NSBTYWx0ZWRfX006vW+oEXb/Y
 CCjzbJ+03PZ3ZM8XCSuBJuVYruM9UO0OckfmNXadLxlISXRYTG5mPjfEqkq5LCODAJ0SBylUf/5
 /YFticxLj1VtBRVNQndjpUZenRRXUw38Ae7/vCrVOusDkKYqJ0GoYbVxXw8Dg2lShy/ICfFYCx/
 pPW6ZN4sdkmCvEqJBLXvfD6zG4uALfT0Nwokp21sACkgHTQ9ch1qSugkWVAHhDmO20jhonQ6X/o
 fuy9+cvRRLuWhsyO8YF2Ye8pbfGMGzIB52rVhsNxrqbRYecKj5pXb3hZYDNrPg4liDp6HizN1Rz
 pAMkmG2NP8Zzp9ieyCULBKVVODl+qZvYk8eNopURWUR9czrC0Pp07/k7B6YZblNOuTTSIv6k3vt
 BnBC8ySIDUYq+iOloTyhnR0hU/haS2I+q8Dzj7zrBYRUzta1dKDKsqtIYukc5hEUNvFJjORO07f
 2Xxk++TO8i4mjxZ+L5w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01

Marvell CN20K SoCs integrate a DDR Performance Monitoring Unit (PMU)
associated with the DDR controller. The block provides hardware counters
to monitor DDR traffic and performance events and is accessed via a
dedicated MMIO region.

The CN20K DDR PMU is functionally equivalent to the CN10K DDR PMU, with
minor register offset differences.

Changes in v6:
- dt-bindings: Document CN20K in the existing marvell-cn10k-ddr.yaml;
  add maintainer, description, compatible enum entry, and a CN20K example
  with unit-address aligned to reg.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../bindings/perf/marvell-cn10k-ddr.yaml       | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
index a18dd0a8c43a..79fae9fdb6f1 100644
--- a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
@@ -4,16 +4,22 @@
 $id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell CN10K DDR performance monitor
+title: Marvell CN10K / CN20K DDR performance monitor
+
+description:
+  Performance Monitoring Unit (PMU) for the DDR controller on Marvell
+  CN10K and CN20K SoCs. The block is accessed via a dedicated MMIO region.
 
 maintainers:
   - Bharat Bhushan <bbhushan2@marvell.com>
+  - Geetha sowjanya <gakula@marvell.com>
 
 properties:
   compatible:
     items:
       - enum:
           - marvell,cn10k-ddr-pmu
+          - marvell,cn20k-ddr-pmu
 
   reg:
     maxItems: 1
@@ -35,3 +41,13 @@ examples:
             reg = <0x87e1 0xc0000000 0x0 0x10000>;
         };
     };
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@c20000000000 {
+            compatible = "marvell,cn20k-ddr-pmu";
+            reg = <0xc200 0x00000000 0x0 0x100000>;
+        };
+    };
-- 
2.25.1

