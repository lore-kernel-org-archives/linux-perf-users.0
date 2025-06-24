Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE242E8899;
	Tue, 24 Jun 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794274; cv=none; b=GM0lvIgvnfeWxBuhyEJPtqXbRVTSaCUCi7AkI0SgDUkqHjwNAQOT07rlTEhGBJ8cw5VRGyoZsqDvgBJppbvY8VQ1fi4TTepAGXewS0awwz2Q2fhkbHLWFkHi4QLEUyMZgW/Ne+0ypGWxXfX7Ta3TCoICSBr4XnM0CbmtbUqDrvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794274; c=relaxed/simple;
	bh=69eh9VLJi1J6J2mUImxaQHgQHo4o3bZRjXR+EqdYxsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVwHeroamABXLRMQj1Cq9jOkQtAdevoxdrouprD3r6DciVXa0XyNb/sIE6DMKmwobv68WZDs07ZTan3kYaLxms59xPsXfIPoiMnBb+dr2ekzf2j21iYQYcE6dwZhIxWHl5q5GLQF4R7pJG1jEKbhJ4mr2gcwmnSKiqg/q7QFnDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qpw+IoBo; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qpw+IoBo"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBhtO025867;
	Tue, 24 Jun 2025 19:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=rxdCh/ih79IROOaGKB4RrxcA27cqV
	7R+FSaE62x0ps0=; b=Qpw+IoBoWdQvVVlSl9j2omEn6te6tNpzOBc6ConFkxyYP
	QNq8TkDCDFyY4UGmVs+vFPaVodUiYGcsAU4JgImivSqtN5G7TSyI3n4jdDbAvRhj
	GGRVb/zF+dNmYFmyd8G783qGV+Q7lYwz6yYRlmLIcO2BBIoC4vDoBeUNPFjXgzFu
	FxmZyqdS2C0ajhqaGuTt9WT5K4Je+QMyFP5oV+nGWF6CyLLtT0o/+3ldFKhU1Uks
	O5QdkzSxKX3dxWrP8vSs9ylYwcsRzw6NlCkFmWsz4MjIynVl/WAKuVqt5y7U8MTp
	8avfCQE7fQSuYz2qqwOKS3mqaA/OsRdETQKSS3dDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1ct11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OItoiA024312;
	Tue, 24 Jun 2025 19:44:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkr3hu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OJiLcL031379;
	Tue, 24 Jun 2025 19:44:21 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkr3hsx-1;
	Tue, 24 Jun 2025 19:44:21 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jonathan.cameron@huawei.com, will@kernel.org, mark.rutland@arm.com,
        linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] perf/cxlpmu: Fix allocation argument order and minor formatting
Date: Tue, 24 Jun 2025 12:43:37 -0700
Message-ID: <20250624194350.109790-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
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
X-Proofpoint-GUID: PqjC_nlaZtw1Y-qFVvHsLh536bqsCE2d
X-Proofpoint-ORIG-GUID: PqjC_nlaZtw1Y-qFVvHsLh536bqsCE2d
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685b0016 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=RRer6SffVtzthgszA2kA:9 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2MSBTYWx0ZWRfX8rJ7CwuGrXij 4i6E0tQnxA+HdxRSvz4sodFGTspmbBQCXqmRd63J7VcIuXO7E9Un6n/QYnvxZcBonC1F3UivLjg G+6U+lIxPV5CsSXQ1DKmoORzklNH5xFGFU+hgm0jSDBWib70pvlQ8Ja62HiJ0h/jRhTc/7WgmCo
 Y6gg9xBKFxGkEsKK5gm6L7+S8QRfdH2OJ+9Drc5r/PyCk91kn9H+9ZrdQ5NDymntKWMbctXIETI Q1EZntUxr9447WlR5InW+jqEbZHYOd16pVdDTVKtgAE7j1CjKgluQlXBHB738bTr4y1U5G+c2JR WoRYll03vkTOazU8gAR0zNFRAc7pPb4w2mz5ZjkRyWxNiLYvW0WX9VLvPCJs9AUrKbP5TMj3bzG
 wmLe9fT5YDSlKkREs7o+pgvnoSuCj3Xfj4Lk+kjAaMsGaH9bHsgRcBhz/xx73YgRNrdsCbUD

This patch series includes a few minor cleanups and correctness
improvements in drivers/perf/cxl_pmu.c

Correct the argument order in devm_kcalloc() to follow the
conventional count, size form to avoid any confusion or bugs.

Remove an unintended newline in the IRQ name string passed to
devm_kasprintf() and  fix a formatting issue in the devm_kasprintf()

Fix several typos in comments and documentation strings, improving code
readability and alignment with the CXL specification.

v1 -> v2
created individual patches into a series as suggested Jonathan.

Alok Tiwari (3):
  perf/cxlpmu: Fix devm_kcalloc() argument order in cxl_pmu_probe()
  perf/cxlpmu: Remove unintended newline from IRQ name format string
  perf/cxlpmu: Fix typos in cxl_pmu.c comments and documentation

 drivers/perf/cxl_pmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.46.0

