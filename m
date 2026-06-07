Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CA1A6822;
	Sun,  7 Jun 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780837542; cv=none; b=jRv1cm5bkfeeBySZJORv2NvBParkUGf9CTEPVqVj62sYWRY7wmjKc07mnv01gjj08I3QWLV+1S0YgSUN7RZU9NOu/+yG6NdN49OdqjqhXdx947E+vfGV5CEhS3p99R+uM8wCkj+xdrDFu56vIkvomm7RO417AiKPoDzqAbBgknw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780837542; c=relaxed/simple;
	bh=PPDJAMg14oqT50Y0gJO+dAmrsAOhLH6wQ3dQ1Tfpv1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bh0Hm97BML3bV5HU1tpMaaxBBIdClBKIp+ge6oHteaNllDRzIk05souUvWpNyk2bB5s3wRV6rpoASmis4nMekbHCeZiNErhtU+2eo8qSmdUtKfwlvb5Bczs2iskQjMGEXelMkLhiOyQr+mOjEMYlDdDIQXsCLrpDq2WJpFr4Xc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eds3Ek3v; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eds3Ek3v"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657B1cqb3698744;
	Sun, 7 Jun 2026 05:51:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=aWcYYpxWpHV0gRGBfsC2kHwRU
	bnJJhhEUIpChyiUSAY=; b=eds3Ek3vxSQhI88b03EtftC7ngUl7P+H+3bHyH3j3
	z/6irkzQ1ovrrh/aha/+whitXyNs5Jfp2ZXc6f1pTyKAN0LcXjsVZVIUqoQ1jfnJ
	1nwnpjWKoH2aTM6tHJJ/BrI5HSsUF0ItKZOsPxsw60IL5lF+NbyNJp1iJ+L1HHDU
	fJN6pPoaNWnRBpQPHF3ir/2mdf/3Oz+AEiTJVn1G+n4YX8LBJz04DOVs8+aqo7AB
	bwOpjjx9kDyC5G/KlLHd7vWhTm+zdH464sXr9SyEDy5bG3pHSMOH2UeCCCfZuB7b
	eX1aa7GU7c5FmxMgQfFtyg/Aqlqsv9UDvu/CQRaDBGCVg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4emk2ek3f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 05:51:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 05:51:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 05:51:15 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id AEE213F70C5;
	Sun,  7 Jun 2026 05:51:12 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH 3/3] dt-bindings: perf: marvell: Extend CN10K TAD PMU binding for CN20K
Date: Sun, 7 Jun 2026 18:21:01 +0530
Message-ID: <20260607125101.17778-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260607125101.17778-1-gakula@marvell.com>
References: <20260607125101.17778-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEyOCBTYWx0ZWRfX7i5rzTf4t3Bz
 k6XEnIA6TnTI+IBPSxZScs0dLR6I9MigGv8ogGoXd9SXOujlSmQpE4MnYBFBzhRbnLJ5N6rqKoc
 cSL/V9GUlNnpZQ4Q348eJdpHsXWEK89Z0LuELtyMBX8uhSm3y7imjHnfuzH2RkwnLU2IyWNn/++
 t6i0alma3eR7M8ym41ptMWlTXis6LICnw9MAB+nus453guVFDPVL/RMFzUgMTXc/VSHpU3zMEtQ
 Wyi77hsRc9gMuypqmMMcq8YtDWY0sR/D7WucOZq12eY0gtqzMS0uzWQgyD83P5oPzUpG+kJWzoH
 mgwSgMzZ9663HP3IoFW8TIbbiEyQXh4MfpU3HMXM5E6g7V/vZy1Logrc1ll4RYIB0Owl3vUAvuw
 tMjoaPdjFU8rUI9j4rLaNh2qPTHm6SUKF7//DlOOg8pg+sjQHlMeU7J8HEtW8V+h88Zz/B4IRSI
 aGgBcfWJelhxraapTVw==
X-Proofpoint-GUID: Knqm4btXgidxs7KvtiAQGoPwpMAezOuj
X-Authority-Analysis: v=2.4 cv=bJUm5v+Z c=1 sm=1 tr=0 ts=6a256944 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=gEfo2CItAAAA:8 a=M5GUcnROAAAA:8
 a=rc1d4UPXP1xlpl8uFC8A:9 a=sptkURWiP4Gy88Gu7hUp:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Knqm4btXgidxs7KvtiAQGoPwpMAezOuj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01

Allow marvell,cn20k-tad-pmu alongside marvell,cn10k-tad-pmu, document
CN20K in the title and description, add a maintainer, and include a
CN20K example node with the same required properties as CN10K.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../bindings/perf/marvell-cn10k-tad.yaml      | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
index 362142252667..1612052b59ae 100644
--- a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
@@ -4,23 +4,27 @@
 $id: http://devicetree.org/schemas/perf/marvell-cn10k-tad.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Marvell CN10K LLC-TAD performance monitor
+title: Marvell CN10K / CN20K LLC-TAD performance monitor
 
 maintainers:
   - Bhaskara Budiredla <bbudiredla@marvell.com>
+  - Geetha sowjanya <gakula@marvell.com>
 
 description: |
-  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
-  shared on-chip last level cache (LLC). The tad pmu measures the
-  performance of last-level cache. Each tad pmu supports up to eight
-  counters.
+  The Tag-and-Data units (TADs) maintain coherence and contain the
+  shared on-chip last level cache (LLC) on Marvell CN10K and CN20K SoCs.
+  The TAD PMU measures last-level cache performance. Each TAD PMU
+  supports up to eight counters.
 
-  The DT setup comprises of number of tad blocks, the sizes of pmu
-  regions, tad blocks and overall base address of the HW.
+  The DT setup describes the number of TAD blocks, the sizes of PMU
+  regions and TAD pages, and the overall MMIO base of the hardware.
 
 properties:
   compatible:
-    const: marvell,cn10k-tad-pmu
+    items:
+      - enum:
+          - marvell,cn10k-tad-pmu
+          - marvell,cn20k-tad-pmu
 
   reg:
     maxItems: 1
-- 
2.25.1

