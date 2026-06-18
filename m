Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D032B128;
	Thu, 18 Jun 2026 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781797000; cv=none; b=c0KkdYpAbS4ROb4Fm1yg0betH1dlImQzfPT0qFr7Aq+5yYaIccKVA767XU9qGb54TJm95/DXLtdptG/VHtYXJeDYN5dbPeQV8XEpGZmBy77Qnqu9WtfSqSQFCWrmVD38njwLirGwRG0JDTUy7sdNkxClJvpFbVipJGKyGs6UEVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781797000; c=relaxed/simple;
	bh=Wv/bNO1Ojd/ZW15DazFr/LlwQ9ocW6SAy3Z/Aue3rAY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pugmjKk1GH50Vm3rJ2++o3dRua9p5+YzyBZxmR4vLebV9W/xOLnx4pvhOf2djP+LE+On5yl4CYMCpOcQSwuzrde11cjdEAVrrdcWfw+6Grkx1gRY3BXtwqo9sStghRobaK7i/5gUSNKoOGmd16eSGdFrdrkw0O9ykLEk7nbSCEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LsWepN1I; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LsWepN1I"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFHpRe806272;
	Thu, 18 Jun 2026 08:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=Yc+JfLgikwxjCr5j+j2Q2fnT4FL1p+R5+nJe9mPLB3M=; b=LsW
	epN1I2U6TPBIUj2gyzk9jTZVVvACSQ+bt0wWi1BWFGvYlsM7qlZlwNk3Jf4v6exo
	pvDA/bV68oHnA32+FLb4J1fYQPD3TsNRUSpuM6JvLnc5terFF5jUzdA6Zj0y8VDy
	/+gdNQ8HwRvpoaqMASGZvczwfHFG3xdG2P1qVUHyJSFFJQyE+4OPbyEBQypcoTGC
	U1mQTCi6rCB7Hm07W9PQn+njhcpFOMCITi0xJ8KI4IP2Zw/yR5DsBWu06A9l4bCR
	Ar0g0vUPXeP22eUdQjG+e4s8j/HRqqUliVIFwjU60+vm0fmhwL+mnDqK5LYjDnIo
	Sfk3I7AMINcZOT9u8hg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eueg5f723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 08:36:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 18 Jun 2026 08:36:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 18 Jun 2026 08:36:13 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 5205A3F707F;
	Thu, 18 Jun 2026 08:36:11 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <mark.rutland@arm.com>, <will@kernel.org>, <krzk+dt@kernel.org>,
        <gakula@marvell.com>
Subject: [PATCH v4 0/3] perf: marvell: LLC-TAD PMU MPAM filtering support
Date: Thu, 18 Jun 2026 21:06:07 +0530
Message-ID: <20260618153610.13649-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: dtXVFOpK0IhSpt_Sfy_TFL4TI6MW7uNB
X-Proofpoint-ORIG-GUID: dtXVFOpK0IhSpt_Sfy_TFL4TI6MW7uNB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX+fAdVVDUmkew
 q6cbssobW2sd6DMwTYp20Eo5rBKyjIQDsSZy51cEtCQl9R/veh7xjqLom/4zoIASkm2EfI4vuDL
 0kobpRpNqtmD/WOHlO/ktvNxBS8jWHk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NSBTYWx0ZWRfX6TftFU6qEfAU
 KQ/XA2AnV1R1TswdaYEOYV9yAWUm21zmUvu6soXxNWBdQeS8TUQbCHnTBrRO1Kbc6goSJcRLQZO
 wLV1fswwPamFr+eedaMevoBlI81bdrq8QZhI1bUDt6DamSE+EXTWD1eC+YfPHHtd7Kf5g40kthf
 RvyHoAwGgaHNcRDa8rBq6GCxAbAecwLOrCXhEkEUf/m26NbXHO9REMhZ75kRCTsDsnsOinYvXw9
 vVHqURXG2lCQG32xLCQiyFpfTR5zuGIxFPdT9PHymVgWpn+sEI1wzmX3AtpO9BTFFAHuQFmf1PD
 jxAjIOnZ0MQAiFmJWkWfwwJzGmxbf+AK9q3h7FFCQC3JyPmAfxcutz8cJnEELm25Hw/dqZqDmtm
 ad1P3yXSa7l9ZRcvIMg+NKIcSujizCqda3xnE/IWwvo6IAZLQLbALjwrazDquH65/mmrD3dNE5g
 1x3sRA/2k7JZOvOYBjA==
X-Authority-Analysis: v=2.4 cv=UqNT8ewB c=1 sm=1 tr=0 ts=6a34106e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ZR7J5KnPW87OS3voGYgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01

This series extends the Marvell LLC-TAD performance driver used on CN10K
and CN20K systems.

Patch 1 adds optional MPAM partition-id filtering for the subset of TAD
events that support it, exposes partid / partid_en in the PMU format string,
and keeps the reduced Odyssey event surface without advertising partid where
it does not apply.  It also fixes probe resource handling (no in-place
mutation of platform_get_resource() bounds, validate MMIO window vs
tad-cnt), registers CPU hotplug before perf_pmu_register with unwind, and
aligns the filter-enable bit in config1 with the sysfs format (bit 9).

Patch 2 introduces CN20K LLC-TAD support: non-standard PFC/PRF offsets,
additional programmable events with visibility checks so CN10K does not
advertise V3-only events, CN20K-specific MPAM encoding for the V3 profile,
local64_set(prev_count) on counter start, and device discovery via OF and
ACPI.

Patch 3 extends the DeviceTree binding for marvell,cn20k-tad-pmu.

Changes since v3
----------------
- Add perf_ready: tad_pmu_offline_cpu skips perf_pmu_migrate_context until after
  successful perf_pmu_register, so a CPU offline between hotplug add and perf
  register does not touch perf core state for an unregistered PMU.

Changes since v2
----------------
- Validate the eventId using an appropriate mask to ensure it is restricted to 8 bits.

Changes since v1
----------------
- config1: use bit 9 for MPAM filter enable consistently with partid_en in
  the PMU format; allow only bits 0..9 in event_init on CN10K/CN20K paths.
- Reject reserved bits in attr.config and use the same 8-bit event index in
  start_counter as in event_init so MPAM validation cannot be bypassed.
- Register CPU hotplug before perf_pmu_register in probe (mainline order); add
  perf_ready so offline migration is skipped until after perf registration
  (reconciles v1 vs v2 ordering feedback).
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
