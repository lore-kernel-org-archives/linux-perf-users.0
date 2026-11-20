Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188338;
	b=U38nEW3sbTWntZeJaPhzGClXu1Oq+2j793dGVTFjI7Q7WbITh/nAjPuo9R2qqXtv8Rbp
	 xx8pdOsC2aQvwd2lu/vUlByo8wpQLe0ZNyNfb1puqvZCz7JaxI0jivPkyzchF/sFLMrKs
	 FuWE9b0qyPlJqlgIMBeAahGNNwWa9HfGfM7thbxPqerWvkskG5xFFRFsQMB4MK4jDlrJt
	 T7Lw0nOFoblvQ4stJotjCgVjAoZWHyF8ZZFgV4DnbWCqSWD+nJucuM9Ob2lBgeTw2EEgl
	 iFiZApkYvV4DWpAkIf5Dr4F1eTrfKLZs2Qr1JBrJtjVPqWbRI4fqcO0BZ18OYv3Pg9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188338;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version;
	bh=NruqjrzalzzTg4oV6juNI3CdG+RLSbvEqYvadZ0/8lo=;
	b=4c6k1FrV7boyVVgCY2ai+Hv0pk+c70rr+mRxpORNFOVxHQ9utXpd9Kv1KolSrDI3GeBd
	 Zs3jKRqFg8q2x/ApeaC3JwEeM+wuY+l271548IUCw9r0OKAE0b7sjqFCISHyEPW4GudEP
	 tfSJ+sf0ftFHyYwxkAKnS7PQxthDyFqInvD9CAshKeLKyny/2kPh/Pbg/0EOLdmN7QZKE
	 zBGdD7SExKWTFpiTqOE+VZrG5ob+5spc58sjS56LlFeSU3qQveg8odXCQUy8/W4OG3leC
	 7O56vY6zYoYLfvr7Cp6ieENgCIMn7dkzNo67gj2i1fPJYns7wNcv4lD43pRqQvUh/Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fb.com;
	spf=pass smtp.mailfrom=meta.com;
	dkim=pass header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b="np8/aHj3";
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E16606A332;
	Fri, 20 Nov 2026 15:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9E16606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.a=rsa-sha256 header.s=pps82601-s2048-2026-q3 header.b=np8/aHj3
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfS0o1873902;
	Fri, 20 Nov 2026 07:24:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=Nruqjrzal
	zzTg4oV6juNI3CdG+RLSbvEqYvadZ0/8lo=; b=np8/aHj3LHQWW9++k8OBg0QKn
	0P7aNARqZYV2xfSsbVVblDs3Mh39LX8aQQcR9Q58l0hRKBMlABYUBn8vjAYzIkbH
	on+XG/gopHjHFN0lUvWddGiY6LxcFcj+fnhjYI05vViWt9Zj+Z5+1JiFYKyXYb9x
	O9ka+RoiOIWL61KQjM95TTmzfB5SR8BoDTsGJgE6GibLE0PcSwkGOvWwnC0UXp3T
	7y7kGy/b8YvbNO8jkgG9AcdTc0hM7039W8y+ERT7HZI7wBSpwnWnzBvHbTFc1Psz
	LEXKXAB7DMHuRTqkhdAO+2myPu++raK57xX6e1oxy4pZElTMH1f0CWZHclolg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j1yjp2hw0-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 20 Nov 2026 07:24:58 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 20 Nov
 2026 15:24:50 +0000
From: Amir Ayupov <aaupov@fb.com>
To: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>,
        Suzuki K
 Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>,
        Alexander
 Shishkin <alexander.shishkin@linux.intel.com>
CC: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel
 Pereira <danielmaraboo@gmail.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/7] coresight: Pulse an ETM external output for a PMU event
Date: Fri, 20 Nov 2026 07:21:13 -0800
Message-ID: <cover.1795182850.git.aaupov@fb.com>
X-Mailer: git-send-email 2.52.1
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfX0Zo74rK81oG7
 lR0oc/HFzFp8C77Yv3lq9fdS0V86nUeFPVIflkcTg2MgDygeNL2F0rB8tOTKQ1FMXRz8+n5HcHh
 Yr528WIhrRsuvCumum4muYhZARMy/lTwtuPXqKMMjf8iJGmyQ5OpG4Fmxs8li9KwizdKZJEEUZN
 gJ9j7JZo+QFy/P9k1uwrWGdahNISothRlFkpIWZf3BUoSmFA5QYM+gbdLCAT2BYppXQLWWOuz3I
 Y73DVTmnbJtY+yuvlyr6lrG05TL6KFZZvKmGPQupYAWj41AVzn9N7FJnd0MCYKUfj5woHLxt7Qi
 Hw9z3psKtKlERKb+TUUtvF/LAwi+Ldj3Les+o8b2Q7IcHPVwtOnqfBy3iyRyh+7Py8ihr3MsS0H
 0RTSiY0OwIABVfQS19Rhyzvqo9O8Fh2x4NUdnfkunfuhOiE7gvAnB7x+gYLMGwIqc47EaqhkPPR
 gSO4Jx/sAXgc+klSEAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2MSBTYWx0ZWRfXwxoU52NhYTNw
 v9Q0L1j9pXQsV/8c959PuX2v5mK9ATFAtXslaUB9YflT+Jxps6f4kDy33SR946csNRBlU3kqw/x
 uCKYPeqRQ/IdIKv/caA0x8Ukya2ZoxU=
X-Proofpoint-GUID: HDMQrvRP0TjTS39IVLi8BmK-j6vasnN-
X-Authority-Analysis: v=2.4 cv=aPtlOr9m c=1 sm=1 tr=0 ts=6b00664a cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8
 a=jm_8UMYxSsQ4F8tPgyoA:9
X-Proofpoint-ORIG-GUID: HDMQrvRP0TjTS39IVLi8BmK-j6vasnN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

Add an ETMv4 configuration, pmu_pulse, that drives trace unit external
output 1 on every traced cycle, so a PMU event counting it (TRCEXTOUT1)
can end a fixed-length ETM window, for example with aux-action=pause.
The feature only loads on an ETE whose PMU counts its external outputs.

Output 1 is fixed by the configuration; the perf command selects the
matching TRCEXTOUT1 consumer separately. Output 0 is avoided because it
is the trace trigger, and a detected trigger stops TRBE capture. Each
window includes the counted trace cycles plus pause interrupt latency.

Patch 1 is Leo's fix for TRCIDR0.NUMEVENT decoding, which patch 6 relies
on for the number of external outputs. An ARM PMU maintainer Ack is
requested on patch 5 so the series can be taken through the CoreSight
tree.

Changes in v5:
- Compare the class and capability fields with FIELD_GET() (Suzuki). The
  class check stays an intersection: built-in features name a single
  class, while ETMv4 devices register with both SRC_ALL and SRC_ETM4.
- Move both ARMV8_PMUV3_MAX_COMMON_EVENTS and
  ARMV8_PMUV3_EXT_COMMON_EVENT_BASE to linux/perf/arm_pmuv3.h and include
  it from linux/perf/arm_pmu.h (Suzuki, James). Add Will and Mark for an
  Ack on that patch.
- Rename the capability to CS_CFG_MATCH_CAP_ETE_TRCEXTOUT, as it only
  applies to ETE (Suzuki).
- Drop caps.trcextout and pass the probe-time result to
  etm4_cscfg_register() instead (Suzuki). The check reads PMCEID on the
  trace unit's CPU, so it stays in etm4_init_arch_data(), which runs
  there, while etm4_cscfg_register() may run on any CPU.
- Add James's Reviewed-by to all but patch 2, and Leo's Tested-by to all.
- Link to v4: https://lore.kernel.org/r/cover.1792989860.git.aaupov@fb.com

Changes in v4:
- Fix the arm64 build: v3 defined pmuv3_event_implemented() in
  linux/perf/arm_pmuv3.h after including asm/arm_pmuv3.h, which broke
  files that include asm/arm_pmuv3.h directly, such as
  arch/arm64/kernel/cpufeature.c. Move it to the arm64 asm/arm_pmuv3.h,
  after the helpers it uses.
  Breakage reported by kernel test robot.
- Link to v3: https://lore.kernel.org/r/cover.1792907332.git.aaupov@fb.com

Changes in v3:
- Rebase onto coresight next, which moves the capability fields into
  drvdata->caps (Leo).
- Carry Leo's "coresight: etm4x: Fix event count decoding" (Leo).
- Add Leo's Reviewed-by to "Fail to enable a configuration not loaded on
  the device".
- Define CS_CFG_MATCH_CLASS_MASK and CS_CFG_MATCH_CAP_MASK with
  GENMASK_U32() and split the match check into early returns (Leo). The
  class check stays an intersection, as ETMv4 devices register with
  SRC_ALL | SRC_ETM4 while the built-in features only set SRC_ETM4.
- Remove the unused CS_CFG_MATCH_INST_ANY in a separate patch (Leo).
- Replace the per-output CS_CFG_MATCH_CAP_PMU_EXTOUT(n) bits with a single
  CS_CFG_MATCH_CAP_TRCEXTOUT, set on ETE only (Leo, James).
- Check the PMU events through a new pmuv3_event_implemented() helper
  instead of open-coding PMCEID0_EL0 in etm4x (James).
- Use PMU-agnostic event names in the documentation example (Daniel).
- Add Daniel's Reviewed-by to "Add pmu_pulse/extout_pulse".
- Link to v2: https://lore.kernel.org/r/20261012230527.750567-1-aaupov@fb.com

Amir Ayupov (6):
  coresight: syscfg: Fail to enable a configuration not loaded on the
    device
  coresight: syscfg: Match feature capabilities separately from device
    class
  coresight: syscfg: Remove unused CS_CFG_MATCH_INST_ANY
  perf: arm_pmuv3: Add pmuv3_event_implemented()
  coresight: etm4x: Report whether the PMU counts the external outputs
  coresight: Add pmu_pulse/extout_pulse

Leo Yan (1):
  coresight: etm4x: Fix event count decoding

 .../trace/coresight/coresight-config.rst      |  5 +
 .../trace/coresight/coresight-perf.rst        | 15 +++
 arch/arm64/include/asm/arm_pmuv3.h            | 20 ++++
 drivers/hwtracing/coresight/Makefile          |  1 +
 .../coresight/coresight-cfg-pmu-pulse.c       | 55 +++++++++++
 .../coresight/coresight-cfg-preload.c         |  2 +
 .../coresight/coresight-cfg-preload.h         |  2 +
 .../hwtracing/coresight/coresight-config.h    | 11 ++-
 .../hwtracing/coresight/coresight-etm4x-cfg.c |  7 +-
 .../hwtracing/coresight/coresight-etm4x-cfg.h |  2 +-
 .../coresight/coresight-etm4x-core.c          | 42 ++++++++-
 .../coresight/coresight-etm4x-sysfs.c         | 29 +++---
 .../coresight/coresight-syscfg-configfs.c     |  3 +
 .../hwtracing/coresight/coresight-syscfg.c    | 93 ++++++++++++-------
 include/linux/perf/arm_pmu.h                  |  3 +-
 include/linux/perf/arm_pmuv3.h                |  8 ++
 16 files changed, 239 insertions(+), 59 deletions(-)
 create mode 100644 drivers/hwtracing/coresight/coresight-cfg-pmu-pulse.c


base-commit: 343cfcbb3ecfdb80aa576a428cfa3b65ad783842
-- 
2.52.1

