Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2882EA145;
	Tue, 24 Jun 2025 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794277; cv=none; b=gDCOjVqXgcDSfRGZ+nUZXrLlkfx4LyRpMXk4vaYoPuLDkf53Zx4lMKk6CgJ4taxP18j94KvEnMqJX1h18gUbWL0w1k1xXGCBR6WJPYg1JvuKTHLbemZD3Hf3mU8f+QJWPORddnt49Zcp16fFRS59G0pGmr8R/qIUOxrA01SOb3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794277; c=relaxed/simple;
	bh=3pFsyry3ogPsPI2M+Srbmm7Hms/oHfolhCZF5ZerzyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPZSNJqTtD894NQM7n9zZjrXmrD97Ydj5F8/zMFWDigfPl6HwTAmQel2Q4UtKHJI6yJp/tTDWgIUuc56oDJ7mniE53SNUTCQuixSuyio0sDj2vcFqC+t+5f85OekQnUQmbbXWLgIzB4uiViI+53EZh7+E3m3AOiOHMhCYk/SU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p3AZS7rh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p3AZS7rh"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBjic029946;
	Tue, 24 Jun 2025 19:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=L+xWg
	Q/9RAPDdeXdahMohh/91ikHv/27/0j3Sa/Uu0U=; b=p3AZS7rho9rTKGflpKuNT
	NjRwqgUBPbrbvZqKYdSCNaSpDvPR9BRL+iMUGA4QIza/cAu0xhQEc0x8uJoi3TTO
	6Z0xKea0vU/B6WFPFg8e54jssn/kFBhB/us290XfYyfvdBtmWG4aziB3vLloHefI
	krkePVXub/jIyeGu0e0op965hcMHsDH76eX+rMo+6zVw0oHm/2P4JJUwHYWp6IYA
	eF5sI96YDqJ/xOgrQb6ikjzPrEKeTgiwYiIXDJCE64KbTlcPag1hZx378tMXK4iu
	KlTwOJCHe0S/V0Jqvl+evqI88lESRn9WztFyzZ2uzE/zIOOttduAKdmcmicJtm54
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y5xyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OJFAdc024643;
	Tue, 24 Jun 2025 19:44:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkr3huj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:23 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OJiLcN031379;
	Tue, 24 Jun 2025 19:44:22 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkr3hsx-2;
	Tue, 24 Jun 2025 19:44:22 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jonathan.cameron@huawei.com, will@kernel.org, mark.rutland@arm.com,
        linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] perf/cxlpmu: Fix devm_kcalloc() argument order in cxl_pmu_probe()
Date: Tue, 24 Jun 2025 12:43:38 -0700
Message-ID: <20250624194350.109790-2-alok.a.tiwari@oracle.com>
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
X-Proofpoint-ORIG-GUID: WwzDPj097zbDIdTUO8vgaoJoCcdL-zik
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2MSBTYWx0ZWRfXxrlLTDf9HdRS DYtBlN1G4DH9OFH10nBhKuFBOSpZxvArKTarQaRzul1L2zgETlYq1ohdNp8y5bbgwdxhjIfXJtx pJRS7Ag7O2U/TVSSK60BKmyAcjN1Zripwv0Ol7UEivAO8TpyOL0N0aOT0ucs0C37wuwMfTExBYn
 Ldnut56lvTEygwbbkM9YPiwGXHhzspwC8kBQU0X/Va1bthVlM5gFGK52te6Klpr5qCxm5R84Brh rvecnS0cF1AE15yiackeI23gzccUmjG3b0lFSjqBbU6gEey1rRd6OOQsFfidSiFMwtLatdqATDB u5RYjs7FgP8Ij0yYzb5dYdUnp/NkAqm/KIZNEZmK7AtllXx+Xwi/cu98jJjl7V2WRWgkum5ZJch
 nijbZJOthefsXZjsox76I1pNwHNc5VjVNb5VMVWw1mFFm21CXXXHVspNBaXAWAIACpWYlqkU
X-Proofpoint-GUID: WwzDPj097zbDIdTUO8vgaoJoCcdL-zik
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=685b0018 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=yaHg9FHjClEfhIwcEPsA:9 cc=ntf awl=host:13207

The previous code mistakenly swapped the count and size parameters.
This fix corrects the argument order in devm_kcalloc() to follow the
conventional count, size form, avoiding potential confusion or bugs.

Previous usage:
  devm_kcalloc(dev, sizeof(*info->hw_events), info->num_counters,
   GFP_KERNEL);

New usage:
  devm_kcalloc(dev, info->num_counters, sizeof(*info->hw_events),
   GFP_KERNEL);

Previous incorrect order could lead to unexpected memory allocation
behavior. This fix ensures correct allocation of hw_event structure.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/perf/cxl_pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index d6693519eaee2..8998c0a2f3a2d 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -834,8 +834,8 @@ static int cxl_pmu_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	info->hw_events = devm_kcalloc(dev, sizeof(*info->hw_events),
-				       info->num_counters, GFP_KERNEL);
+	info->hw_events = devm_kcalloc(dev, info->num_counters,
+				       sizeof(*info->hw_events), GFP_KERNEL);
 	if (!info->hw_events)
 		return -ENOMEM;
 
-- 
2.46.0

