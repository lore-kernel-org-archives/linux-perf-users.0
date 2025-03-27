Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620A20E6FD;
	Thu, 27 Mar 2025 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073952; cv=none; b=s4I8KZhsNkwfZcj5KWIN/yCVYhgvWZ7kg3o7OE7hb8DcKIUW5WWGYo7QnibOGsyvgw2/nWctZaZfNQkVH2nqypoSdAt2WviuEnZgI8KLdlonv5OFR1y44CKGcICyXNakEiCbBPdmZb3Lp+q1lHhoUI1acMcAzoHRx7FnnA2VU3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073952; c=relaxed/simple;
	bh=us6/gKs10Fouv846f018rTH4cOgzi+hHLbKvRYI2XiM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oK074MrO9A14oMfDJ7CyClGLDwZF/owrIad6eibith2KEBhDD9D2mLyWy0/OdOxnxNKoH/Ix1LOrzd3csSj/jBkldEEMW4Gxulzt9V4+Y6/HflfX+avzIXJpFkDOnJCWilUn6v88WWLTHXCCBDICGK9JiCEKrLFemmhBLvQCTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fGjMVt5h; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fGjMVt5h"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R75sHR013524;
	Thu, 27 Mar 2025 04:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=kKioJc/LT31Rrdp+xV9eQMV
	SniWLhoF/+IM7ONWRAbQ=; b=fGjMVt5hFBcrccIe/ucR88sX2QaOo5HSq+ADd/Q
	pNZsInDY1hZ+dgyDOtjBgWxLix7Dc8HnLosAA0l8drh7IlIz0k/3fkBlIEUwLYco
	/2C1uZB/fMuNJIdApn7ujwLUOYO4YmMOIJaLI4TpZ+2ZtxOnOytLXEFaIieI4fEf
	HtNIW+Pcsk0FdLKu3GDxA3howbaitryW9SGF5opCeUbCrL3KWpVIe580EXA/9nug
	QBc0czWvGpCqdr+Wq5/Cd3G8nihFgFNQB3A6+ap+arzNYND83pXqOUYEYHI7kJQ9
	a+lnC2lEqH8+g29tWiBC55CuDG7NBceHzEi5n5zncZRCNVQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45n1yv8gd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 04:12:09 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 27 Mar 2025 04:12:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 27 Mar 2025 04:12:08 -0700
Received: from optiplex.marvell.com (unknown [10.28.34.253])
	by maili.marvell.com (Postfix) with ESMTP id A98FB5E6867;
	Thu, 27 Mar 2025 04:12:03 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <john.g.garry@oracle.com>,
        <leo.yan@linux.dev>, <will@kernel.org>, <acme@kernel.org>,
        <adrian.hunter@intel.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>, <lcherian@marvell.com>,
        Tanmay Jagdale
	<tanmay@marvell.com>
Subject: [PATCH V3 0/2] Fix Coresight instruction synthesis logic
Date: Thu, 27 Mar 2025 16:41:47 +0530
Message-ID: <20250327111149.461012-1-tanmay@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Te0e9O-PCUOm0cDuoHHQhGq7ENOtphTZ
X-Authority-Analysis: v=2.4 cv=dKCmmPZb c=1 sm=1 tr=0 ts=67e53289 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Vs1iUdzkB0EA:10 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=b8-QEG12Fff0ABwj1n4A:9 a=W4TVW4IDbPiebHqcZpNg:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Te0e9O-PCUOm0cDuoHHQhGq7ENOtphTZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01

When we use perf to catpure Coresight trace and generate instruction
trace using 'perf script', we get the following output:

# perf record -e cs_etm/@tmc_etr0/ -C 9 taskset -c 9 sleep 1
# perf script --itrace=i1ns --ns -Fcomm,tid,pid,time,cpu,event,ip,sym,addr,symoff,flags,callindent
..
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed54 coresight_timeout+0x28
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed58 coresight_timeout+0x2c
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed5c coresight_timeout+0x30
 perf  9024/9024  [009]  2690.650470551:      instructions:   call                                 0 ffffb305591aed60 coresight_timeout+0x34
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed7c coresight_timeout+0x50
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed80 coresight_timeout+0x54
 perf  9024/9024  [009]  2690.650470551:      instructions:   jmp                                  0 ffffb305591aed84 coresight_timeout+0x58
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede4 coresight_timeout+0xb8
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aede8 coresight_timeout+0xbc
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedec coresight_timeout+0xc0
 perf  9024/9024  [009]  2690.650470552:      instructions:   jcc                                  0 ffffb305591aedf0 coresight_timeout+0xc4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccec ete_sysreg_read+0x0
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  9024/9024  [009]  2690.650470557:      instructions:   call                                 0 ffffb305591bcd00 ete_sysreg_read+0x14

This output has the following issues:
1. Non-branch instructions have mnemonics of branch instructions (Column 6)
2. Branch target address is missing (Column 7)

This patch fixes these issues by changing the logic of instruction syntehsis
for the Coresight trace queues.

Output after applying the patch:
 ...
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed54 coresight_timeout+0x28
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed58 coresight_timeout+0x2c
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed5c coresight_timeout+0x30
 perf  6111/6111  [008]   457.332794461:      instructions:   jmp                   ffffb305591aed7c ffffb305591aed60 coresight_timeout+0x34
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed7c coresight_timeout+0x50
 perf  6111/6111  [008]   457.332794461:      instructions:                                        0 ffffb305591aed80 coresight_timeout+0x54
 perf  6111/6111  [008]   457.332794461:      instructions:   jcc                   ffffb305591aede4 ffffb305591aed84 coresight_timeout+0x58
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede4 coresight_timeout+0xb8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aede8 coresight_timeout+0xbc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591aedec coresight_timeout+0xc0
 perf  6111/6111  [008]   457.332794462:      instructions:   call                  ffffb305591bccec ffffb305591aedf0 coresight_timeout+0xc4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccec ete_sysreg_read+0x0
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf0 ete_sysreg_read+0x4
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf4 ete_sysreg_read+0x8
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccf8 ete_sysreg_read+0xc
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bccfc ete_sysreg_read+0x10
 perf  6111/6111  [008]   457.332794462:      instructions:                                        0 ffffb305591bcd00 ete_sysreg_read+0x14

Changes in V3
  - Rebased to latest coresight-next branch
  - Added Reviewed-by tags from V2 [2]

Changes in V2
  - Updated commit message of Patch 1
  - As discussed in the previous version [1], there were differences in instruction
    trace output before and after the patch. The timestamps for the instructions
    were not in sync. Added a patch 2 which fixes this issue.

Changes in V1
  - https://lkml.org/lkml/2023/6/23/912

[1] https://lkml.org/lkml/2023/6/28/506
[2] https://lore.kernel.org/lkml/b2c02eb9-0940-4770-a4b7-22d2af8078db@arm.com/

Tanmay Jagdale (2):
  perf: cs-etm: Fixes in instruction sample synthesis
  perf: cs-etm: Store previous timestamp in packet queue

 tools/perf/util/cs-etm.c | 49 +++++++++++++++++++++++++++++++---------
 tools/perf/util/cs-etm.h |  1 +
 2 files changed, 39 insertions(+), 11 deletions(-)

-- 
2.43.0

