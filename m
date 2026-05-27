Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8E29405;
	Wed, 27 May 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896505; cv=none; b=TI4sxmpIEQUvVhDE7gx2cqOiuxqXGaYq4bs3+SOgMmvJJI1SKzuY4qytFn05C9nrwP/TI6587P1bbq/uE+w4B/E522iatwD3UdGJYpQeJHeO7z5HqXxQDsdMWZsvfp68K7f7i6EOk/kTX3K2vahq1+i7lbeGNyMnDFqJ/cnxICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896505; c=relaxed/simple;
	bh=51gVXyA4OBCAPXWFwW/XpGjkEtuxmzNDx28k6XpMSC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C7CWz+CEJbPM9qmML1Z+hHA6yxrAbosHLuuQKdXU6B7BoE3JbyOR3/VEH3Wy+/JC5K+OAwH7JvwWlwA6ApwniRAnomOwqWbbyuN5/TSXWy9rHgKThSu0/aSRzWkWSUTWO3ShRiHPR7vHCbTcy/bU8JTqYfqibVNLs4ajgmU5fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=lZU3yPf2; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="lZU3yPf2"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RAKMKB3852642;
	Wed, 27 May 2026 08:41:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=m+yW0YI9v+aTDr43rbPKu5hLCh2aj79A80qAF73oHAs=; b=lZU
	3yPf2x/lE0hS7gfM7dRE7cqjuhy/LGdQX85MUyvkmCOZUvs4K53gDgvvEo8FB8kl
	nTch6+LUCwbgvxmMRzjDa+JmlEz937vzH0AOAHtFm7lUdmEsbDan8Y9zN/MHtYSJ
	UJ/0EgljTdVemj3FwgQ4MxTi1LeqQpulrUafNoS8nFfN/JWbJbYWt282/n1EdWFx
	fmW02Vp5ewPgWGAyghylIF0Tc4QqCyF7aa4XDCfrTGjVciT+fNWAZaBpWWoPK8Ky
	1jlpcHhFHhsejc2mm5fZKjfuYH1bJeiHR2F5X1cXbEd9za4J4JjpBFadjcNofva9
	Hwmc68O7Auv9VD2StgQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4edxs6guec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 08:41:23 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 27 May 2026 08:41:22 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 27 May 2026 08:41:22 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id C65E13F7057;
	Wed, 27 May 2026 08:41:19 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v7 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Wed, 27 May 2026 21:11:16 +0530
Message-ID: <20260527154118.12884-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: CM2n0PRux09vVVSnWfI5_ZLtwPOU0Ifj
X-Authority-Analysis: v=2.4 cv=ScjHsPRu c=1 sm=1 tr=0 ts=6a1710a3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=jmD4vOC-WGh-49o7kLYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: CM2n0PRux09vVVSnWfI5_ZLtwPOU0Ifj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1NyBTYWx0ZWRfXz7qxPUUXYa87
 OlJKIHqs7pMYq9fN7QgbmcoV+g3ht5RDTJJoKfk6SUesj6n5Aqhp8vPNQfzP+ecwsYcgXzeYz3h
 v5zjX61YhKscJMYshgpNfRoD49eEvHWeCKvdAhxi3LhhCTITtzF4inkgEjHHVoGt799JvPes88u
 5PQCvMQ/1+BSxzgKH5e7gj/Uk756Tksx2gbfMYUOA05XV5V+9l30K6pY8zMRmPXNmfAMNLDMo4C
 FzCRL9o+6EMEQh5kCKJGsrFw4N4w2yvZGYwy/j0HxX4x1NXCd8ZG7DS8lV0NuDcqAaEDjsGzp1E
 3ILF+ynvXqQ97XQRdVo2pCok6nGqmGBih6jsW/T+Cn2ZnJx8CY6AQS7qhFNAWhi9DcMEf/+sYDz
 usr1HTz5mbIrPiwtQoRpB17T2vjw/Nod10TWANrk9HdLkFw0N5qB3c/0yKhbULsvklfec+75Cig
 E5Y3jSAoFdKafyyjzog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01

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

Changes in v7:
- dt-bindings: dropped the CN20K DeviceTree example.
- perf: Handle ZQ sysfs IDs (62/63) in a dedicated switch case before the
  DFI range so GCC does not see overlapping case labels and Odyssey IDs
  58-61 no longer fall through into ZQ handling.
- perf: Resolve shared numeric IDs 58-61 inside the DFI case for CN20K vs
  Odyssey (identical bitmap); extend programmable-event coverage to CAS
  events (36-38) for CN20K sysfs.
- perf: On event_add failure from ddr_perf_get_event_bitmap, cancel the
  hrtimer if needed and free the counter slot instead of returning with
  partial setup.
- perf: For CN20K, zero CFG0 before writing ZQ to CFG1 and zero CFG1
  before non-ZQ CFG0 so stale masks do not combine across banks.

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
