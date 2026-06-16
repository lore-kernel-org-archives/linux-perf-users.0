Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356E345CCE;
	Tue, 16 Jun 2026 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593937; cv=none; b=o67aEyvZzzSGWS9Jg8lT8gykUMOse9pxTQF99U+8T14mfI5p33VCOaBVLRSZxDLs+xpQnX3GmGgk1LIujBWMU+VFWLL6cuNKPw5JdXu4JXk/5oSrpC1XH5WCQU7WQhcaKrfcDqXrClERXExHQYXNJxUQSv5z8bEHkBfmu2wgve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593937; c=relaxed/simple;
	bh=frngJV/hBWqNzrMhtzgewkS3rTGgy3IIT//Vn06Ndy0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FecVVD1sLhxynmV7c/bn2ZZal1d2BPFDea8kFjR1QWwToFYeCHbcmdfrIFjmfzPM/seaAfQNK/ckQyg5BWFo5VPybgZc71Ym0CCTu++vaogwJghQtwjaR9xTFpoMkmBQi+EAPUYbUIE2tATG6scoxvp1pVDldLSdMa1yD6of1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZCa4qIr8; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZCa4qIr8"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G66QlT2715623;
	Tue, 16 Jun 2026 00:11:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=KFQhCwI2XRgHAY4VX3EsV/7XNZL6c8jN5EtxQfawdAc=; b=ZCa
	4qIr8SdV1ZCDHNFGClaSkzMcjvrcrE3MMcVPG56eb/m+uAmFXC/eW9CPSftX/xjb
	LtlR0kOl7W0Oe+6jiW2gKafzGX9agvt49Ux7Hjh1FvQKRBmTYdeO5oHNCp/hAZrB
	eAmVhj357a2yi7OWAPi2ryLc2P4zu1X36AiF3YLi9tp4KzQL9QMDTeNOOIqEori3
	n8h40psZKz5vd7EyDigIxjMXJ8INb+ejNk3w41xqMXHeyApgf0jqhC24JTj4jy8K
	GRia9ospOyDMRcWI0BvMOoT+FsF5iHApe88j6+Twvg9/Lj2r4nisqHoRIoOdIhZE
	HOisgggOVsCerDdGbVQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4es6qek0jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 00:11:54 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 16 Jun 2026 00:11:54 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 16 Jun 2026 00:11:54 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 2F27F3F7099;
	Tue, 16 Jun 2026 00:11:50 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v3 0/3] perf: marvell: LLC-TAD PMU MPAM filtering support
Date: Tue, 16 Jun 2026 12:41:46 +0530
Message-ID: <20260616071149.12523-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: g6AZezlY3GdQFavchmv-96kWSL4d7Kru
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfX9JM50qDX2sfs
 bdLI6e6hPfb+ThZWnsM3sFxYzfCxlT9m3XkIN/FbERUQG2P15NZJP0zRejsueRFwcHAFv7m3RY1
 w0/24gNWhWkZgvIAbGAh3Pbq2m5pi1c=
X-Authority-Analysis: v=2.4 cv=TuXWQjXh c=1 sm=1 tr=0 ts=6a30f73a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=mgbCCiCACyxXVg7t1IEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: g6AZezlY3GdQFavchmv-96kWSL4d7Kru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA3MCBTYWx0ZWRfXxEfNl4NPKD0V
 ZN7a4Idw+ktfHjIzEWqvf2vmqZNVtDa0JnaqS77HV7BR5BTgQh6gY4Z/jptY1FxQiugPgRZ+RV8
 wuowBxWvSRI5lko1XbOHsaKxWW2Rh5QkC4ikWY8eO0TtUaPW8mShrrZmEIZTFQLUM2soGd9yMNx
 Xcv3DuckXLKcC1BSP5o71AawU28NJwhXW1FDIQ6wagrbAaoK2Pjvu0zeU90qEy2tvfuK561TU+O
 OJvPmdW9rbpPRxWWIvAff4+T0OEFo5zJXLXjoPIJ0kF49Qi4i9HWpjIvSBkSHLp1NgsGnnPC7Aj
 bKQNg0WlLJpIDXXgmdyGGB+aiX51E5Lcqg5G/fVRIeIpph4gxAXgR4HqzNch+RXRqyk24DvNQDI
 5XbHfQwADOLFxEtZRth04T3OQbwpxYqQnjpXWvXKC8CtQ8ArZrtDtKlS7CGExzuLKszdaW+hq8k
 8s+MFifJVUUnGV0OTZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01

This series extends the Marvell LLC-TAD performance driver used on CN10K
and CN20K systems.

Patch 1 adds optional MPAM partition-id filtering for the subset of TAD
events that support it, exposes partid / partid_en in the PMU format string,
and keeps the reduced Odyssey event surface without advertising partid where
it does not apply.  It also fixes probe resource handling (no in-place
mutation of platform_get_resource() bounds, validate MMIO window vs
tad-cnt), orders perf registration vs hotplug with unwind, and aligns the
filter-enable bit in config1 with the sysfs format (bit 9).

Patch 2 introduces CN20K LLC-TAD support: non-standard PFC/PRF offsets,
additional programmable events with visibility checks so CN10K does not
advertise V3-only events, CN20K-specific MPAM encoding for the V3 profile,
local64_set(prev_count) on counter start, and device discovery via OF and
ACPI.

Patch 3 extends the DeviceTree binding for marvell,cn20k-tad-pmu.

Changes since v2
----------------
- Validate the eventId using an appropriate mask to ensure it is restricted to 8 bits.

Changes since v1
----------------
- config1: use bit 9 for MPAM filter enable consistently with partid_en in
  the PMU format; allow only bits 0..9 in event_init on CN10K/CN20K paths.
- Reject reserved bits in attr.config and use the same 8-bit event index in
  start_counter as in event_init so MPAM validation cannot be bypassed.
- Hide V3-only sysfs events on V1.
- Reset prev_count when starting counters after clearing hardware.
- DT binding: explain non-fallback compatibles for CN10K vs CN20K.

Tanmay Jagdale (1):
  perf: marvell: Add MPAM partid filtering to CN10K TAD PMU

Geetha sowjanya (2):
  perf: marvell: Add CN20K LLC-TAD PMU support
  dt-bindings: perf: marvell: Extend CN10K TAD PMU binding for CN20K

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

-- 
2.25.1
