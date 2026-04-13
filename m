Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01E6318ED2;
	Mon, 13 Apr 2026 16:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099398; cv=none; b=gKdNHMDkr2uh3/WqAwYMJJsoLJ5WdFFYBNUl6MIlY6cLpsU2vEgs99nTXykIosSaNyvLvwsULnuGLTLCz5hmzV8V6EUEAyDrFrC+9W0TnzXfCG9cDchM53WRQuKboG/IWoYfNRlhSed8cTjnlCryH05i0mSrVJkbkgbqRl25DXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099398; c=relaxed/simple;
	bh=AuWb7HW5VkrRk14/Y3YtJvPjs7s/zO4LfmozcOxWUVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bIvwuhQ3AxUAZOAUxobM1fIzjqaATUzATuF5q8URKpIgAuN32LaPrcAp/CyWPsBGz5tswNL1TEE+XFGroWn39CxUO2qA6dNa/CqDE1CZIge6x0lSYxiEvmv/z6WgDvTTPo48tDnmyq06mfDJzab4FkGWF/2aAVLuJhvosyRIpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ztayu3j8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ztayu3j8"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D8f4j83064118;
	Mon, 13 Apr 2026 09:56:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=SaMe/XCfATJZ2LJcHZ4lSlaqFFo8ZIhHj8aFqQq8m1w=; b=Zta
	yu3j8M08aS2q2T+sEcF+zHOzBiAPJCdRJdB3/oDXS/Eqak3li39quJDhQKkJISvD
	FaEna2J9kDMm9aZz5QC1L5gsJ+ImrnbeaqzzRgqx9UVseAjrLPok/bxYlpqD/AhF
	ELBTS3v352+BGq+9SIjjqehSYyML+QDQ8ekaMGlTfhrcQuZAvskQS0hvuOe230yW
	4v327coq8jqpjZFQ3o805ABLcBx4JeoKrJuF4MJ04JKU75tPPYDH2J9QYwnaaz/A
	M29sPSvJHeozFzmoCHHJlMW0BFKVKNOrq4nG0bN8E26O8Y8Gh8DtqkwAS0vONhqM
	FphNsxWz7WFX6gKx6pQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dgw6hh3sf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 09:56:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 09:56:26 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 13 Apr 2026 09:56:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 13 Apr 2026 09:56:25 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id E3EAD3F7075;
	Mon, 13 Apr 2026 09:56:22 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v5 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Mon, 13 Apr 2026 22:26:19 +0530
Message-ID: <20260413165621.10921-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=BY7oFLt2 c=1 sm=1 tr=0 ts=69dd203b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=adgkevBCHCmUBQKKAzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: mimk6iZsQBwJGLdnfxC0-_l_kfZuqGiR
X-Proofpoint-ORIG-GUID: mimk6iZsQBwJGLdnfxC0-_l_kfZuqGiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfXxW18DiTN7u24
 T8+lCtTW87VKhOR7/FFOZQL86/hY7zUFGBIGw3sNPbRA0k7FIfMIgNv0t9zicES6vXWb6OeJsUg
 TZ3427BLf+6/WA/HhIghVqLj45BIlcj1/v9eOc7XvzT0p+w+XiwNUdspWzBTycv/FAf6fpOdEkd
 8w6j2HPzLwIyOU38Hy8ULNrRkDQogx3EIvDfn5LtDtyzwx7/5GLysI9UWLlDvl2Fx+qqZ8BrUjO
 bKeritahmHOCm8NNz1bAyLrLzsZQ2b/ENsEVpxzwG6SO+MV685oVOSAl4tVqTWNSIEayan7TljH
 4roV4VWAiaa6ihbkUDkOXiOBM4PgurBFQ5zpOnNOFMWI0LRIeyvc+AkvjpNO1Etq6mKV3e2f2dy
 exL1tKV5qC+Q4rEWpJOsXjIxX167bf8I9ZB/sUq5Xgkx8ji5WH7UZ2blBxnGPCGwEJpkjLlnVnY
 m/PdpZpBVghLelyc+xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01

This series adds support for the DDR Performance Monitoring Unit (PMU)
present in Marvell CN20K SoCs.

The DDR PMU is part of the DRAM Subsystem (DSS) and provides hardware
counters to monitor DDR traffic and performance events. The block
implements eight programmable counters and two fixed-function counters
tracking DDR read and write activity, and is accessed via a dedicated
MMIO region.

CN20K is the successor to CN10K, and the DDR PMU hardware is functionally
equivalent to the CN10K implementation, with only minor differences in
register offsets and event mappings. To allow software to distinguish
between the two silicon variants, this series introduces a specific
"marvell,cn20k-ddr-pmu" compatible and extends the existing
marvell_cn10k_ddr_pmu driver to handle CN20K via variant-specific data.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Chnages in v4:
 - Fixed document file name.

Chnages in v3:
- Expanded cover letter and commit message to better describe the DDR PMU
  hardware and its relationship to CN10K
- Fixed the file name.

Changes in v2:
 - Fixed YAML syntax error triggered by a tab character in the examples
  section, which caused dt_binding_check to fail.

Changes in v1:
- Added a description field to the binding.
- Simplified the compatible property using 'const' instead of 'items/enum'.
- Updated the example node name to include a unit-address matching the reg base.

Geetha sowjanya (2):
  dt-bindings: perf: marvell: Document CN20K DDR PMU
  perf: marvell: Add CN20K DDR PMU support

 .../bindings/perf/marvell,cn20k-ddr-pmu.yaml  |  39 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 187 ++++++++++++++++--
 2 files changed, 210 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell,cn20k-ddr-pmu.yaml

-- 
2.25.1

