Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621343B9610;
	Wed,  1 Apr 2026 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775031433; cv=none; b=PkNjsAD8RcQs2cRGmYOQTZHRNzMoQxCFCskUffg5HxSm3AY1buzLphqOXuaVsU4LfM7Ikn20eiu3OF98ihGHp5BF41Tv90VKLb+0lGv/W+hL7/HNgOKRmHRzOdGvhvVk7WP0SGzhSRaearQ2ORlijRfbcj4x7wATIH0tI1VuTfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775031433; c=relaxed/simple;
	bh=zd7xjxqq7IvOrJO4WSClbykgiZPWsZ4Bm7lTJYjmK3Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nLiAyqg+6r/e3dnGQYZGgAtep3tFuINQlhqaW7d70m6EvP+fRY6wRlktAHHfg7WsVcrfZDph1FVdgD7CmqYyZeZY3hmneLI+j6ruSZZqS3Ecb+HJDPZF2xU+Dfobm8HnpVVAFwquPx0h+kZOFhfcWygsvkAJV+drTkYvRT9m16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fzZHIL0M; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fzZHIL0M"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VMGfsk2040922;
	Wed, 1 Apr 2026 01:16:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=RkfnkA4c1dqWR9iP4oUu+0lpykz2ZBHeEm5u6kBkk0M=; b=fzZ
	HIL0M59rvEEtOf2Nt/wurF3IxcUjWOfauyjBIYU1VO1RqKvUZrOmUsrEg/tm5Pd7
	/1Wvg8Ua8QBNHgRo/kji7Tmuc5IYoLEWv9eieqczxk3VX4AWS3MB8r70CDO6TbOG
	+W6Cj2/bxR4ImeC92mBgup9tKeZQyJFAZ5xYB0TOQlpACw/HeavYCaTbDRV0e/yo
	TOnUF4zfmA0woNnmcUB9/oovSn6BclvVMkvFEsOyopf7z0F4eGJ56F+Qk29ZzHrh
	tw3o1naAIQqQr+FHnGVaXmTJ9ppDUGwv4DJQQhhsl6C+KpAvdRwt9RfIIeZVWnKj
	eihzmLLCx6ic8GSEjuA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4d8ck3uc8b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 01:16:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Apr 2026 01:16:45 -0700
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 1 Apr 2026 01:16:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 1 Apr 2026 01:16:43 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 529973F7055;
	Wed,  1 Apr 2026 01:16:41 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>
Subject: [PATCH v3 0/2] perf: marvell: Add CN20K DDR PMU support
Date: Wed, 1 Apr 2026 13:46:38 +0530
Message-ID: <20260401081640.23740-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: yIu8xWzqBm4JafdGAdkZHYflZP05CU_2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA3MyBTYWx0ZWRfXxNu3LdOuiBmW
 tP6zsk4IFwRxoy7zl3AR/ATh4ajGp6yYsUiKltl645+cjnFOY97bgfvvtgmG1fAYoXRREWVf4CV
 6SFzQILM9rb4b8MI8o/KrgNJL2SXgBWsQyiT3tJJNAEkKFfeCJ2RLvQFEGPiu0IVLR0U0k6YoS3
 Z5FW2usPswuxk52RCtbQ8poLzI16GZSMMDYS31UoCU6pQGW+wfriFMhVL0HKDpnFzzn9ZUoKt1X
 /bG23gqp5kz/VmVzPDPjPA5TI1c/tNktRjxdIR8XfU9rBiVTv/MrQXmLYbJvuiGa1QEC+tU5WCK
 igzFg4OdIbQBF0H51WmcZVbS3956mmlNaIGLPikH4QaLRC1ZZYj4xJ9IYxXg8v2JpzeAQEAtjna
 hTLjkJxXxltdAynCEO9nWUdTc+Yjn+nj7FvZXnxU4fOK5+XZkaKwhvLX+G142dMoftpkwoRwzVu
 YM0O5LY7CTUy4OJUQ5w==
X-Proofpoint-ORIG-GUID: yIu8xWzqBm4JafdGAdkZHYflZP05CU_2
X-Authority-Analysis: v=2.4 cv=EKMLElZC c=1 sm=1 tr=0 ts=69ccd46e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=g9OxYFsRBXyit7-cW8EA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01

This series adds support for the Marvell CN20K DRAM Subsystem (DSS)
performance monitor in the existing marvell_cn10k_ddr_pmu driver, and
documents the device tree binding for the new compatible string.

The CN20K PMU provides eight programmable counters and two fixed
counters (DDR reads and writes).  Patch 1 adds the devicetree schema for
"marvell,cn20k-ddr-pmu".  Patch 2 wires OF and ACPI (MRVL000B) match
entries, adds CN20K register offsets and event maps, and refactors
platform data to use silicon variant flags.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>

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

 .../bindings/perf/marvell-cn20k-ddr.yaml      |  37 ++++
 drivers/perf/marvell_cn10k_ddr_pmu.c          | 186 ++++++++++++++++--
 2 files changed, 207 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn20k-ddr.yaml

-- 
2.25.1

