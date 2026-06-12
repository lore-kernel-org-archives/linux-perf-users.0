Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC229385D8D;
	Fri, 12 Jun 2026 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258287; cv=none; b=YgvtqtN7kcJfafyRa6i8pA1POv1knK+M1fb7DlDSQf2BB5iiufBbSPoIB+VLQAUEKqVk3A3v0/QxxDkAkUxFkER/oZJWbX/OhJMlcHc/BSAkI8Td0t+S26aG3fyHpGxF8JfElgR1D7BCAweCwvh+oWuUYyz0okOum+7VKFKBO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258287; c=relaxed/simple;
	bh=JQ3AOO0yOFIWGHrQ/bJDigXRcDrruolTDj3q76S+77I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b8TcToX2NzUn7fY+I8Z/jCQYYMXocxRcm9/qaV93E/N1FkLhDOknItoYKEN6YRZ8vIi0ZRTddolhJit+M+q74KWAu99GwLvKJLbHV+2UJZW/95smjFiTfYYSSiOBA5CzrS5ptrOBYCaq78PBBj/79X9fLb7mVmHZZG4PO1ojUjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BQ0Dad5H; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BQ0Dad5H"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39Bi53782209;
	Fri, 12 Jun 2026 02:57:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Dk84ZQRgSc8xnw8MT3aYpxHJpf1SJ9OoPddG086vJpQ=; b=BQ0
	Dad5HB25OrjSOB+5Ez9ykAVegXrrEw9D76h7BlWHLoebh1ci43eyZmpb0A00/bW4
	4wKavL9L/k3PdzwOZ5oNpZLUiv/7mgdISIpJtIGNX+vJkjjceqs4hWk0k9rzk1Kc
	FiNXGRDUuT4FkIt1FsSO3TTaOdKgNVZfHrM9ui7cbPhQ2cdWB3wPLMJPzm8KCkJI
	yzRArx7HwJQbsLoL5Kf8Skj7mVVlnR1Z2QY7NxWaqIXixwrlfz/7O7PJwcHSUn2y
	S9ySA3ve5WMkpudJnQUifiqRK8ITYemzdPDHzLfTKMZ6E3K+g9MThxCW5Rx8XOFu
	OBTBDza4JQaMmaYheAw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4er6r2hjq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 02:57:51 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Jun 2026 02:57:49 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Jun 2026 02:57:49 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id A3EB23F7040;
	Fri, 12 Jun 2026 02:57:47 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v2 0/3] perf: marvell: LLC-TAD PMU MPAM filtering support
Date: Fri, 12 Jun 2026 15:27:43 +0530
Message-ID: <20260612095746.19679-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX8orRE9Qu8ZtH
 1qMvX4tzVG6OeL8pJndA2WjFBcpy7yqDIWp5UYRbIVsqLgHFoa5BjKE4nal0OuQTJFHnmqqKpMb
 CNtLwbjb/k6nHwtNHSXPflrgpzrWCUxN84widfQ8bFiIygsEoy93G/+kHx4KNo/VkaftWGl0oXH
 dAHmx00Toigyl/4t9Bm8i2B/uKmXbRlpN/Rp9oxrFleZkyjsmP9YkF5YX2odssnbVe5PbNATy5O
 hXn9D2mhPCBH97OE79slq2OkMAa1VwzLkWrUKwff+MBmfgZW+PcZWThdTA+tGWt1xk5HiCtlJJL
 K5U1n6DAW6/vxDRF30wk31LjIZgC7I3wwwUaanv9z3oBQoCFL0GZHhrvUUyWdVmHMQrCOPIFj0H
 13QhCkxHT350VE/lfyS9qMsFZ4MVDDhcWytDZKIL/83liQhok44waLl9s08UchEFeLpeOnPQDvq
 N/1yTiSFysH5aHW3/VA==
X-Authority-Analysis: v=2.4 cv=GoByPE1C c=1 sm=1 tr=0 ts=6a2bd81f cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=KMVilSr8rocH2AwasoUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfXzbl0NpO/5elC
 y0L1rzoTwwa1ZnF6Cu5p/5Hv+OCl1iBCd3i3RPRwvlvSyPxwtKRlTSuxhaCT2PJlEJOwb/OQfmp
 VTWXXx027PnkN/CxbYJMiQAlkJmkhOI=
X-Proofpoint-GUID: KtVaQ1yIH1D98X_-_s8nIePreeDEcsUN
X-Proofpoint-ORIG-GUID: KtVaQ1yIH1D98X_-_s8nIePreeDEcsUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01

This series extends the Marvell LLC-TAD PMU driver for CN10K and CN20K
platforms by adding MPAM-based filtering support and introducing CN20K
hardware support.

Patch 1 adds optional MPAM partition-id (partid) filtering for the subset
of events that support it. The partid and partid_en fields are exposed via
the PMU format attribute, while platforms that do not support filtering
continue to expose a reduced event set without these fields.

This patch also includes several fixes and cleanups:
  - Avoid modifying platform_get_resource() bounds in-place
  - Validate the MMIO window size against tad-cnt
  - Correct ordering of perf registration and CPU hotplug with proper unwind
  - Align the filter-enable bit in config1 with the sysfs format (bit 9)

Patch 2 adds support for the CN20K LLC-TAD PMU. Compared to CN10K, CN20K
uses different PFC/PRF register offsets and introduces additional events.
This patch:
  - Adds a CN20K (V3) profile with platform-specific register offsets
  - Extends the event map and hides CN20K-only events on CN10K
  - Implements CN20K-specific MPAM encoding for filtering
  - Ensures correct counter initialization using local64_set(prev_count)
  - Adds device discovery via OF and ACPI (MRVL000F)

Patch 3 updates the Devicetree binding documentation to add support for
"marvell,cn20k-tad-pmu"


Changes since v1
----------------
- config1: use bit 9 for MPAM filter enable consistently with partid_en in
  the PMU format; allow only bits 0..9 in event_init on CN10K/CN20K paths.
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
