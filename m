Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E792367D9;
	Sun, 29 Mar 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774797906; cv=none; b=ppfd2WcCv+EDyrOLE1BC5/E1imxg4lr03Dbi6iyAtfT9iQlvIHL+3mZ/laVnSIIyGqr6geOiv6fs5WoWDJGtJbUaJ2Fn26YVtnj9F6pg9STBysHjoCcNsLmSw8OGMWOXWaDHQ4mE9WRnbtA555HrQ/RB80yNJOAqUNU90uBJ/fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774797906; c=relaxed/simple;
	bh=/XTvzY/z637VnwzBLRpQzWBePAU6+I0ZIf71xCMwWpk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dU6jkNzuU/LmLEaYcDk8Us7OUkiAKA0ppTrTPs3neY5y5DxiaacnWYSupsSsu/fhENbLY6pKfX6bwIq6Cb+gjBm4/SM8ZBcADxElCGa4HMMdq925QGOHYs89QMQIGPNzn6p8ptgpC2wzVWKXPHPJIyXYgN3qXt1SxptjqNCAKuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ZM36BFl4; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ZM36BFl4"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TAvNFh3148474;
	Sun, 29 Mar 2026 08:24:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=dSTWTisZC7qHFtnvjGqfuBKqkwNcsHPHtyRlsXTafDg=; b=ZM3
	6BFl4xA+2IqF4kDw8ZeWGuCpVVLzXdzbKYMa51xlOc7BVXR+aKgOn3RcY2QuG1N1
	Shlpm+SNxeZEpR4dPHwTEvlf+2U9mldiH2kchfr8A17Wqsi8hi4PJ0Uvg52hajSm
	TSh9SSKbmtaC0PqySFx1KuZrDMjlQ4+Vyktz64Ibyf+4l8jv9o6oIg1qJ7VRavsP
	Q/Lmoiz17SB7i8FRZJfQrhuSaiXtDmyvEj2+weeDOKSlmfjtYXLdmtPloDoIEFhQ
	wzeObDVKsTcaCrPUFCpgSP2rLMagnwdXLMa1gjSSk6JpJSA44uxyXp4biljHmI1N
	c9KtnY7vWiOlg/LzxXQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d6cbjsx39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 29 Mar 2026 08:24:43 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 29 Mar 2026 08:24:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 29 Mar 2026 08:24:42 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 501723F70A3;
	Sun, 29 Mar 2026 08:24:40 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v2 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Sun, 29 Mar 2026 20:54:37 +0530
Message-ID: <20260329152439.10573-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI5MDExOSBTYWx0ZWRfX82PwbOSGQcTk
 abLIH1ry8qwVG7mTofV3IJgkM63PVX1trEmaAJh1DuFj3AIagPdgvvqk8pcv5gDvs3LC5KXTlmS
 Pb8UqDq6/B6mz5jc78g/uH1WCwhAvlwQmlNWHpio80mdGBFSJCyTmGKiUJRO1Z4SzkDi7EdZxF/
 FSigI1MvPeY//k8fG0j+6J3y363xmk6YwVJTVLpYjfkMQfCZA0L24Ekvfo5CEesehYCDWHEn7Kr
 75Lq2fIh04T+BjZ6xmZM8zVcEXfVWr4tpjz/QaZgO4GT9bHLqUe/HLcWhON0m9lH28GFUbGdIYF
 ojMs9Gxr6A5o/eSe3NACkTRuH+9umNh4lyLml09b/Gr+Op6O4fPb3Ne6DYyVNhoqKG9VYTIXnY4
 GGCg9gRLLXn9OckH573QZzmbYQD8E21YjYqcG9zzp4M85BC0t7cAe/AujiDmss9plsFJW00Enw7
 6+aRaYvEP6JG34cRwsg==
X-Proofpoint-GUID: LYaSR4RAhHpENY-j6uPpg1-_o8eqnexB
X-Authority-Analysis: v=2.4 cv=Pf3yRyhd c=1 sm=1 tr=0 ts=69c9443b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=g9OxYFsRBXyit7-cW8EA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: LYaSR4RAhHpENY-j6uPpg1-_o8eqnexB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_04,2026-03-28_01,2025-10-01_01

This series adds support for the Marvell CN20K DRAM Subsystem (DSS)
performance monitor in the existing marvell_cn10k_ddr_pmu driver, and
documents the device tree binding for the new compatible string.

The CN20K PMU provides eight programmable counters and two fixed
counters (DDR reads and writes).  Patch 1 adds the devicetree schema for
"marvell,cn20k-ddr-pmu".  Patch 2 wires OF and ACPI (MRVL000B) match
entries, adds CN20K register offsets and event maps, and refactors
platform data to use silicon variant flags.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Changes in v1:
- Added a description field to the binding.
- Simplified the compatible property using 'const' instead of 'items/enum'.
- Updated the example node name to include a unit-address matching the reg base.

Geetha sowjanya (2):
  dt-bindings: perf: marvell: Document CN20K DDR PMU
  perf: marvell: Add CN20K DDR PMU support

 .../bindings/perf/marvell-cn20k-ddr.yaml      |  37 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 186 ++++++++++++++++--
 2 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml

-- 
2.25.1

