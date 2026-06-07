Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D492BE057;
	Sun,  7 Jun 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780838272; cv=none; b=GG4NYx+2S2a6NDaVYjaJcb3ZL52DfcMPD/gSrX38n5dsmKCE4ApgNo5oXj4RBH9Cu0LU+TsA8K1t0PvaPSm8ujVfQigul3OxUBWriwLCPG4AJNSW01e11CznB0attrZRtjB/IoAjB5/Z7OwDhuDMQLQNyV8yQQhPPfRhHy/tFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780838272; c=relaxed/simple;
	bh=mymz8hMsPk/854Rxjm3BYemCDGO+hhJlropTRKwRRV4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/CDMvJR4Kx24zfkSayqcBpPrmZBhY8AzHCHDralZBtM+sF8p5geZtlpjnV6sBFAoTFb42+6Flt+Y1Qpzif1u2ZPzW7Ag0Azv4Ofv8R6AU+Ubotc0+S0Yrisip0fmmAOhxA3KfXn2yqjs4Sf+c/uOC1sQ0Po+M/lgfDKI8LPWew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=CCaS3Zmd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="CCaS3Zmd"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657B1DpJ3644857;
	Sun, 7 Jun 2026 05:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=rOdHEacwbEYqnbjI8muvDVSMA0W4NJxUkCaq5J6Qp5E=; b=CCa
	S3Zmd2eyAK4+9NLoKlSkUAC/eIujUqsjK7pVlYUIOw5WxuodawUxxGnCLmFljNXk
	QHUrkBHWUYGWO+TT+cNfeKsUg8nsVtajUJxOCLS9Q9dqbuDtx1OtWBfCVf13T9Qe
	odUOu+KJh1nRQm0o2vyReOc0zyNl/Q8y/mO+CTCsDv5fZ+fLMgrZlsncUXz2ZkBR
	x6hFzpWK9ym6NTIo0sIOb83OmVhUWCZTxKtyLFmeJUa+zvAr2owK4PIoOn6XE7Jx
	feCnzC4iQFmlswKajJRSp0uPTYnG4KKkX86/PLHpC0fthhmYJgqqZkbWaoGJSLD1
	ND88gCkYdP/XVn6o3QQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4en4a5gmc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 05:51:06 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 7 Jun 2026 05:51:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 7 Jun 2026 05:51:06 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 38C893F70C5;
	Sun,  7 Jun 2026 05:51:02 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH 0/3] perf: marvell: LLC-TAD PMU MPAM filtering and CN20K support
Date: Sun, 7 Jun 2026 18:20:58 +0530
Message-ID: <20260607125101.17778-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=HpBG3UTS c=1 sm=1 tr=0 ts=6a25693a cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=t6Rdc7sheOvqEPeo2a0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 4NAtQbjwxdP84H6pLHwtUxd9GIq4jlFF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEyOCBTYWx0ZWRfX6DMcniO66Y2g
 JypRtDdqILsgCJITg73KlwjlQmjx8mkLa54gdoz8qTig3WOPL3DLjUJDFuwqwHbXJN9YZOJtEuq
 b4mxEvHiNZ56KXMt1wYC90vFvEvOgYZmRNM649Ar7OfVvWUR5OolYTcY6eIY9iaO/rlwH+p8fUO
 9ujYaPzpoqq2Y+h09ysvSzGl8k5WoYniHM8kNl8ScOpVDgf8lhRvhuJnMgEkvb5SWFz0IBYrPjD
 Ho5vRN40NXNZQ1TJPf37mIBVUQG+N9LqVSIc+DzbTBmvZV7IdT1TkHK3cCwSxUO4zRnS8O5VWwx
 CO0mea81HC/GpB1SWNNAF9izLDmSMmNTom2FyWlKvq+Xsf1FIjMLV/CtmvBWN0NlaQ54IuuFPfO
 E2VuuK3co835zRCYwZ7pXi17+ML+Dn7rjjZvo3c2Amhz0iKhSUGlZGsQXtk8O9IPzqiXZ2kKOYE
 19dBeQ5O1QtgnpQTWUg==
X-Proofpoint-GUID: 4NAtQbjwxdP84H6pLHwtUxd9GIq4jlFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01

This series extends the Marvell LLC-TAD performance driver used on CN10K
and CN20K systems.

Patch 1 adds optional MPAM partition-id filtering for the subset of TAD
events that support it, exposes a partid field in the PMU format string,
and keeps the reduced Odyssey event surface without advertising partid
where it does not apply.

Patch 2 introduces CN20K LLC-TAD support: non-standard PFC/PRF offsets,
additional programmable events, CN20K-specific MPAM encoding for the V3
profile, and device discovery via DeviceTree and ACPI.


Tanmay Jagdale (1):
  perf: marvell: Add MPAM partid filtering to CN10K TAD PMU

Geetha sowjanya (1):
  perf: marvell: Add CN20K LLC-TAD PMU support
  dt-bindings: perf: marvell: Extend CN10K TAD PMU binding for CN20K

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

-- 
2.25.1
