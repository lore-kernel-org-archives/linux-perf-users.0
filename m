Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5098A3C6A27;
	Tue,  7 Apr 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775579099; cv=none; b=Our1riZtekXIePGkv19m3REpqSsYx6AQcodktJktioMMLfzNJQyE2iWZCOWQr50XpM5f+i73y90EP+Rg41gNOKW01uQdgzc6prDtTq57DlKDnDncI+mAPaYZftPuuOZL7QQ49hK7bLK7G5q77KTqS9bZBcklHzpNHIShV/7b3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775579099; c=relaxed/simple;
	bh=pBF4SEXkjFLp7DPWE26mQt/IObzGyYOwvMKygTLzOvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uAXvdqv6c64zJXBPK6UU6ZCxcGSGjQf40QsYx3Mlmxl13WTStkv0+VHB7wGCdeyTHGbNSwikHi1AFukEe9m79ss/Zm8Ffj1Ao4yoWgqM6IoF0yBxDW0cQqFG6PBGqHRwklSzMGaHy8umSJ5QAgbFoh4V/gPhPXzWWjpSW95fI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Pab0btmp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Pab0btmp"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EIPmR2601069;
	Tue, 7 Apr 2026 08:35:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=V96PxtxjjCu7m4wxga8K+elwPTNPNCtkr0qpIMETfAs=; b=Pab
	0btmprdE2DiOzGsBMNZYYxtgKfFVS6Azt3KkW67VM2i061sQMtACEWolRqxYFAYg
	w8ZVW3urDZzfYYs9RMhIVuUWK4d6amgLc/ROSGvxLbGFn43DyWhX9mmMyMqc/8pQ
	NKetQvamwH1NXr/s7U7zAUqMGQFUsICENtXCtLrr7Hki54N2prdAyvTmNo0jmKMF
	68QALmRCLEoXS4f8i8oCXcItNCnqEKfiLJMtIaUi2WRk0uSJeiDaxWYRQi0wlfsP
	13M81CvOEtvyokESdrTam6xqF4HIOHg/2OjeKQIkAnbaGzNPT9M1ap79PvYfsF4t
	vPI6m7zcJQlVJsCS8Vw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4dcms9hywj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 08:35:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 7 Apr 2026 08:35:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 7 Apr 2026 08:35:15 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 23EDB3F7043;
	Tue,  7 Apr 2026 08:35:12 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v4 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Tue, 7 Apr 2026 21:05:09 +0530
Message-ID: <20260407153511.4250-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0MiBTYWx0ZWRfX9+rGzVi6n+j1
 ygWog7w6cZ6dvPmqvUgzLbQcpdBQ+xjB4l/S20ElbJNYFOPWytYPfcTgbpF9unr+6JTaGvR65i5
 Z42t+kgTO97qgykY/NzeH1I8snV55IbaqYrY3kM/G1vBmUm3iUL+wD4R7P8W8Ll5uRZLC6sKgxU
 vVOhNNTycDAE0aKLHl9aJn5P0B04kT8eHSJ+cJ3IZReLFuT2VguS2UznOkruYwC1OLmvaikhKJK
 CwDe8+nRWO5IYn11giqYKo7p5HVa3jPJWRauN8jstKtijjpNXwIQlFb1AJ3R4P+V067ZY5OtW6w
 W2Zu5zxymdVVPm/hVBLMfIybpoYOjRfE/f+OiVnmAF30+RV+SklYhlv9BhSUfXri6LWNuuA4FKu
 AkmK/jlXOfR/691jUcslYa356MfsfE64rjt563zscaBvetOgZ/+ZJplenZBGMsX4inS4YGU7BkL
 r74K9+E+ezGs5b9TWJA==
X-Proofpoint-GUID: anZ_Aoj0OH_XX9yVr0TGrivMbGseZEhe
X-Authority-Analysis: v=2.4 cv=FuY1OWrq c=1 sm=1 tr=0 ts=69d52434 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=adgkevBCHCmUBQKKAzcA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: anZ_Aoj0OH_XX9yVr0TGrivMbGseZEhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01

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

 .../bindings/perf/marvell-cn20k-ddr-pmu.yaml  |  39 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 187 ++++++++++++++++--
 2 files changed, 210 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr-pmu.yaml

-- 
2.25.1

