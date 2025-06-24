Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4602E9ED8;
	Tue, 24 Jun 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794276; cv=none; b=NWwIbt7j1PicbchUB5Tgry8+ip8he0Fkg9MM/hUBZx+fHMv626npy40+7fhKSGtnnqKjsXuYTmMWCz6yeZsaTPgiVTAQp2q7hx4n7EIOb5cnEmwLLi8ZiGJjbrkhmf8s5fhwQhRGQBPlivQx6HWfBk5NCicQKFzsRRG3LwrPRYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794276; c=relaxed/simple;
	bh=sBd4i6NfN8Nagy/LxcY8zqS/alXR3Z8Cwab51tRWFQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3y2lkdmd6GKFEhRWdjXpTkvFhjghBaMmhHK+bGkrjhtX4OueI4xbFvJ/pG2NEwiR+ycnRUn1p1N6gIJ4aoCBDQrkYdmS9jwlwXjSJ27oUP0l7mzdX8jmQsEaQ+BcX1GqEaKKYTKUwUrpPzIsjlPVKa3ucjkn65J9JpdFbKeeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BQgN2+Od; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQgN2+Od"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBaLo006329;
	Tue, 24 Jun 2025 19:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=2heMm
	h50U9/9fd3I2Fq191i4cQ9bhdmCrjgCm4fMKSY=; b=BQgN2+Od7YJocacBGlCV5
	pDROzy4ncWc8lg8zUtT1X/ByT0soj7j8Il5MAlMgiYfKj0T05/pQxSMPyM8M29+g
	X57xGrqGHBDaJPHTJFOLbsyrxpmyGIGlZlqcaGlJBrPU4zdigh611+CL+PoACpdi
	nugIwSwMzSdXl8dgh8kw+iPvqpAvd86YvnuJ0er5CAMQNj0AuUn3GQNLKUPEwvAN
	vGMOvUTXemsMTndDIQqFvQiT3Ct8P9y9CImQtkq2utwDrr0SrAhPfq/68GDqlriv
	RWTzQLvNtBy9RPZSf22se0QuK5IQsagVtAxHs37D3aNIhGry+ldnU5jPdMzb/lDA
	A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egummwph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OJR0Of024157;
	Tue, 24 Jun 2025 19:44:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkr3hvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:25 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OJiLcR031379;
	Tue, 24 Jun 2025 19:44:24 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkr3hsx-4;
	Tue, 24 Jun 2025 19:44:24 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jonathan.cameron@huawei.com, will@kernel.org, mark.rutland@arm.com,
        linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] perf/cxlpmu: Fix typos in cxl_pmu.c comments and documentation
Date: Tue, 24 Jun 2025 12:43:40 -0700
Message-ID: <20250624194350.109790-4-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
References: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240161
X-Proofpoint-ORIG-GUID: DOBrEKH3SOuxSu46q0fPrpr0OyoWn6KR
X-Proofpoint-GUID: DOBrEKH3SOuxSu46q0fPrpr0OyoWn6KR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2MSBTYWx0ZWRfX33tc4A+wJXL5 nAxh1wvPccoTEx1KoWwfDLpmd5FmdoaNX1QW6XvZ/YQG1sqnAPeS5ykaDvufGoN5DggVYUbdMTW bkHyLRc+qVEdUXn4NsX6/pUJA9ucA0rMOXJ+XgSgqk7gJbLKu1zoZyPAPfHC6v7etXx14Z33K7e
 ohEfYjUUI9hSWn8X/C/kcCGcLjo2ddc2EMVK0Fvpceoxv8HSq4P+QA2U8EBwbnHneZOW9xAvqs5 NE6of3+uSfTipWv+CMUJewctb22jzuYn5y94mSiahPP/6BO9KuSRhIaE21TSJScCBGRvOMUCsUf G1x09zfe28srODGyqtvaKwV5IHbKQepPbX43OKh+dbZO5+q7emcEKpJU0jsp/rnlUBrQ7NMBnyD
 GLTisXQ8/6Tn++qWBqfnc9K0g1dKJpSXCHhmEFKePHTt1mmHZnqJ0iryvHFWzHYFzuKho0D9
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685b0019 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=SMJxHL9mSaAU-aCgd-cA:9 cc=ntf awl=host:13207

Fix several minor typo errors in comments:
- Remove duplicated word "a" in "a a VID / GroupID".
- Correct "Opcopdes" to "Opcodes" in CXL spec reference.
- Fix spelling of "implemnted" to "implemented".

Improves code readability and documentation consistency.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/perf/cxl_pmu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 5a475a5a1f095..d094030220bf2 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -113,7 +113,7 @@ struct cxl_pmu_info {
 
 /*
  * All CPMU counters are discoverable via the Event Capabilities Registers.
- * Each Event Capability register contains a a VID / GroupID.
+ * Each Event Capability register contains a VID / GroupID.
  * A counter may then count any combination (by summing) of events in
  * that group which are in the Supported Events Bitmask.
  * However, there are some complexities to the scheme.
@@ -406,7 +406,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
-	/* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
+	/* CXL rev 3.1 Table 3-50 S2M NDR Opcodes */
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
 	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
@@ -627,7 +627,7 @@ static void cxl_pmu_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	/*
-	 * Currently only hdm filter control is implemnted, this code will
+	 * Currently only hdm filter control is implemented, this code will
 	 * want generalizing when more filters are added.
 	 */
 	if (info->filter_hdm) {
-- 
2.46.0

