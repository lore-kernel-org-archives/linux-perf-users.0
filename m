Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828A53D47C0;
	Tue, 26 May 2026 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813829; cv=none; b=lUad3Tp9pdoFIyx2sr70UehpiADC3rdH0fLMeNoBq1PbmYnqnFCyBq+eV1Ssw3XmV3h263+tlDgkh0a9/ipk/IMmJBvnxVRY7HasfTowea0nBv3VzUra+fetrWmvrqFpc5V2QBfaVUKXysHcZnKm3jg569oe42uji5rla83SxdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813829; c=relaxed/simple;
	bh=b+vv3fdajviU31diLGCgiN8TPAbzuV9ZqI0oJ211fKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qd7NFEbYU+tuY8ws0CyL0MgfB7pr18zQ76VZTYp+DCBjik5YLoUXqw1y8rMW0YCLzUqo4ilaFdYOkBtjg1nNAiGAJEo9YA26XgogQ1R+LqTGG96oGrDrq/9CgooFWVE2nMMKCxAyyEDd0q0lIj5xyMFOcmXkQwXMpqJhhXwxNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O1S3cvKv; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O1S3cvKv"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QGOCEu2935095;
	Tue, 26 May 2026 09:43:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Zz7MftTdMtbpCLnTR6X1mYOZHc1vxcavzEx/I7D1Ds4=; b=O1S
	3cvKvUUx8rIsQ9NQDIohJ8oDWM7Zvczo9XLwdVdWprvOEHweGj7ZN/XonhuBnkFD
	zzExY0qOuxfpxkgiOwFQR6+L7itbMK067LJIYOfJ6dU2p03LjJezWUrz5hQxqrTJ
	OcTYbiZKQieHTpBo7ESf4F5BR6r4o44I5IDQ/lkIwE+Nn5ap1Sk//WLO3I+y2VAF
	zsHTSeHvGeK2AXY81+uhKGy96uhOh1DCen4eNRqfVjRm03e4AVvf4TCrP8VEaX9t
	2OUH4b2oQVwTEGUkZqIKybzHkT34a6DchkvHZkza0IlVyu3aHmzdG6zCVVeW8txD
	IEm1xcqH0y3EPK3oZXw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4ebbrf8u9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 09:43:35 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 26 May 2026 09:43:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 26 May 2026 09:43:34 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 5E9713F70C7;
	Tue, 26 May 2026 09:43:31 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v6 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Tue, 26 May 2026 22:13:28 +0530
Message-ID: <20260526164330.23878-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=epTvCIpX c=1 sm=1 tr=0 ts=6a15cdb7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=9AQr2LruEoLi4OK7xoYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: Tllr-yeZ8g1NOvjYg3bIcSAhhS15GmLs
X-Proofpoint-GUID: Tllr-yeZ8g1NOvjYg3bIcSAhhS15GmLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE0NSBTYWx0ZWRfX8rAeaiuRoXA1
 oEziy4k/+miTOY1mEridpe9ge8OaJChdfQbFe0FZCcwgxhiZ/fpmwE0elq2IeS9Cr0SlFRXGk6P
 qy2lVRkOqwfsiTRaPy1ZHDa2mfVANpcA6c8NrJTZ1Lb8CEnzfBQwGsCr7UU0wnZ7pfVMOusBpGI
 9IZ4zOvxK4Bz3/crqgArnalYBGhKi4N2k+UzHLpyrNR1pijHBEXa5Wx2RLMNn9drQIb+vmBmS6G
 Kt4vNnJVOWu27LJtOv0+jXcwFhdsNwqkR5HLrIX50q99PmYGm4IDSOBZ6u2P0fzIKreIVjg8F6q
 dVtKpEy1RE0B3iurwnnk8SD97dWQWkUYShSIZnMDoqrVZiU9X5SIKBMXavaStLLFboI9ZZ5vWkP
 OR5WfcD2pxlIJG7+zn9EHEgZxtIoJZItTNqwh7bUGSkyxaUokLPP1YK1AsU3z1bUA+YnMlsEgeY
 LRWOAbKBMmCO2nxHnwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01

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

Changes in v6:
- dt-bindings: Document CN20K in the existing marvell-cn10k-ddr.yaml;
  add maintainer, description, compatible enum entry, and a CN20K example
  with unit-address aligned to reg.
- perf: Route CN20K ZQ events via dedicated sysfs IDs (62/63) and CFG1
  programming; use (eventid - 42) for CFG1 bit positions and reject those IDs
  on non-CN20K silicon.
- perf: Disambiguate CN20K perf width events (58-61) from Odyssey DFI events
  at the same numeric IDs using an early CN20K branch and fallthrough into the
  existing DFI + programmable-event path on Odyssey.
- perf: Run CN20K programmable counters through the same manual-mode / start
  sequence as Odyssey.

Changes in v4:
- Fixed document file name.

Changes in v3:
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

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Geetha sowjanya (2):
  dt-bindings: perf: marvell: Extend CN10K DDR PMU binding for CN20K
  perf: marvell: Add CN20K DDR PMU support

 .../bindings/perf/marvell-cn10k-ddr.yaml      |  18 +-
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 197 ++++++++++++++++--
 2 files changed, 200 insertions(+), 15 deletions(-)

-- 
2.25.1
