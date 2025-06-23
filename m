Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C821B393C;
	Mon, 23 Jun 2025 18:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704299; cv=none; b=gizXSEYHGfwKrN3f+IWSxn+65MDuxdd3jWVAI+fyjn+Q2uJvgRBuMbe0t5fMMJ3bUzBnhNbRUdBAQ5gJgRU638HVYFf0Wxs6L0XL+DZMQvjP7EAPYPwNDs6mi0/OcMn+cshXXFn/KSahkqxXLAmzmKys1zLGWUKAPAHbsnVQ3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704299; c=relaxed/simple;
	bh=GopSPIKKUHWzzImCePFGXP3aY/mN3axe8ECTeJ4KnZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9xmMdG0QOjV+kNI0cz1cJnfg+JyKQcfm/KDotBhuXnf5JbAUVNxC857w+NITrt97FAhQCwzVepwmPEWBd0iKdH99l4JPmrhybJVWvj9P5OeYkhU5TqRS3gfXd/2MhnIAHvnMWibaHCzUdrPDhDKHAjIhaZJUbyUmOX3wD3o2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=q98buHEj; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q98buHEj"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NGY1rA015508;
	Mon, 23 Jun 2025 18:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=vSIsgPuR8bu5IBeEFtMHltrZ67ejw
	0HFaP2JXTm2H0w=; b=q98buHEj9Inho9ZeTC3r1onche4RYpqeIQI157XhYzGfK
	QE3N2BzKosQ3l5oAeDLBr1pzEZwA+m9B75rpgF+uBxmTznK7cWq86wsiTIk+jkax
	MONM2Z/y4x/ggPbm71PNLNZUh0Xlm82oPibEBieSR0Z0tuIpEcD+LX7a3onxNijU
	fEdlw9up8ZSAJgxL2xldOH7m8iYpByIsvoyv5DRo+6WFvH9YHHiqNEK71PK8/u3S
	Vfp94m2iocjwAo0uWLan77jMZblXAxoIMl24Ws116lxRgaBPB1OwePif+SCckO7Q
	MVtrv+kj6st6RsXfnAhPhtCZ+6K5oiJCj3My5OBvw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8muc63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 18:44:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55NHFXlO031509;
	Mon, 23 Jun 2025 18:44:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpp7264-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 18:44:45 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55NIijgS038720;
	Mon, 23 Jun 2025 18:44:45 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpp725k-1;
	Mon, 23 Jun 2025 18:44:45 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jonathan.cameron@huawei.com, will@kernel.org, mark.rutland@arm.com,
        linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-perf-users@vger.kernel.org
Subject: [PATCH] perf/cxlpmu: Fix allocation argument order and minor formatting issues
Date: Mon, 23 Jun 2025 11:44:11 -0700
Message-ID: <20250623184415.42751-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-06-23_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230119
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=6859a09e cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=6G97NM66kQU3OCPaGyAA:9
X-Proofpoint-ORIG-GUID: UCeJiwcs_lg7LaFR4Ps15_D8noW1eo4H
X-Proofpoint-GUID: UCeJiwcs_lg7LaFR4Ps15_D8noW1eo4H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDExOCBTYWx0ZWRfXyqejpg88gnG4 5TXWVqePVDMNlTMnMWXdgo55GbvvNtOf9f873xpGDt8FOxQdlTaZT/rDj88mNsPwBpu9aEdCvWB LcQmWLOnWxO0cFqlPdS26gsfIpcoIKK2k61YpnUTC7DQwaEItLqC4pS6029pbn0R4zyxQ+wAKHm
 2b3Mj6+NiZtJdbjlW44aftR3k/hqfxHTRAu8NDwTePMSPsMfWf4LoPlwHlu0Eex3BZqGiAmDHft Zm3DLyJAsKzc+fIwM5L2iN6KNhienEeCr6kLVldbMuwRiFrGrU/DEmRPbj0mWaI2sQj1HXqCJfZ pg736P4J6vc/+stbf07fDQxvayYBJIHMkqfDf8kvpKu/q+Z/pd1Sd88VNAvzZ/Y2UTqqHqypTyn
 AQvW69yfgpVib/T7PFHlcJ2R3EVOTE93zhRSUPvB6DfdqkkdI4/Mg0DWknWBTJ0BALZIbFXW

Correct the argument order in devm_kcalloc() to follow the conventional
count, size form to avoid any confusion or bugs.
Also fix a formatting issue in the devm_kasprintf() call by removing a
stray newline and fix a duplicated word in a comment.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/perf/cxl_pmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index d6693519eaee2..fb0b29f149807 100644
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
@@ -834,8 +834,8 @@ static int cxl_pmu_probe(struct device *dev)
 	if (rc)
 		return rc;
 
-	info->hw_events = devm_kcalloc(dev, sizeof(*info->hw_events),
-				       info->num_counters, GFP_KERNEL);
+	info->hw_events = devm_kcalloc(dev, info->num_counters,
+				       sizeof(*info->hw_events), GFP_KERNEL);
 	if (!info->hw_events)
 		return -ENOMEM;
 
@@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
 		return rc;
 	irq = rc;
 
-	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name);
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow", dev_name);
 	if (!irq_name)
 		return -ENOMEM;
 
-- 
2.46.0

