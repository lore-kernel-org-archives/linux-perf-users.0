Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D72E9ECB;
	Tue, 24 Jun 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750794276; cv=none; b=giQICA8KtPPApCurL3eNgb1oqlR+IoxzDasxoOIqmGf5YXqTc7KkPvrWhqiBOWGFsKKTR8+ec2oSkKpHZPQpavjp1flHkFFOUMITUjwbhfibv/Oaj7bzw8eSRBDoU7S0Kd+Yx3OG1jhY3lZCy2oVEdDbrF7TaDCD6EAh+BUrTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750794276; c=relaxed/simple;
	bh=IN3wWVe2Hmc/vA1fI2DD1642OUHRN6fgGeZ4GithXTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brsRI4rEJo1eOHReQTGPVd5iUQRpGzBRmr5KFJM6D/EHIE4rCtQ7vzkNPyyLeD0nM4RSC8wSRpoYqRLRu2rhb+ptKd9L6rHXH6SmhFxn8Nlfd66xtd2PmbhZwuJDDSg6HXkA+HtAGC+l0hr6vF2tOBrD1cXYczMqJsXmjrgX4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GYoEp7+X; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GYoEp7+X"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OHBbgO000471;
	Tue, 24 Jun 2025 19:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=rSQSn
	qeu99rtGwswH/49UwEvNR5Ue855Zlm0k6zy62k=; b=GYoEp7+Xoi2Mzvn/2Gufh
	bViIhH8fj7ibVPdMb6oRkzXPZVbMPzTMkYefd7TaI/zAiMb5FtNR/DpzAyKM1ZhB
	/1WL9T6F23FZMKAYSoB9VwJ/MqQh/hsgRIkk9VdyQn0A6vnxS5LbQ6SFRZUf4VB7
	xAoQKjrChtzrQd80X/PkHJzPdZD8HhnovFt0i8vlnY9xysA7rSB43nzNgdJuLfrW
	row0zcRuyEsDoTrypPI9osfDYZ2jR/dRnW8LilIy2V7K4MEtwsrWyfxgt0YFNHTJ
	BFQmbmOvsHwPwjhTCLGVqJlxJY2I+YhUOeFqmPJ6FTdu3mml6/VB48ZpBelMdNe4
	g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5mv9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OJL0QB024130;
	Tue, 24 Jun 2025 19:44:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehkr3hux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 19:44:24 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55OJiLcP031379;
	Tue, 24 Jun 2025 19:44:23 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ehkr3hsx-3;
	Tue, 24 Jun 2025 19:44:23 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jonathan.cameron@huawei.com, will@kernel.org, mark.rutland@arm.com,
        linux-cxl@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] perf/cxlpmu: Remove unintended newline from IRQ name format string
Date: Tue, 24 Jun 2025 12:43:39 -0700
Message-ID: <20250624194350.109790-3-alok.a.tiwari@oracle.com>
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
X-Proofpoint-GUID: r9lWqjKSoLzLxSWK6Kd40sKVpCDsTu0Z
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685b0019 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=CPhUkEKbwItqaMuKtVMA:9 cc=ntf awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDE2MSBTYWx0ZWRfXxzYD+jXRRTna UN/jOhYHlKpcDRDJeRAQ+GG6VVRhs8BH6vFOt8NJE/e0J0IRWtUAXsXAzbTza5gWKkGQg1FpTP2 FPjd2yaBjyCc/FpVwUo5EiONJa8hS2mjB3p5yq523oM7YAMW24z3AHPoQxt4WLQ3VhrhZz6YXww
 HMUaPCcggE+ZIKH+E0De+pS4qUey8N1PQ5L9Jf9appCAlYEcmmGeyn8F3Na3xRjW+K6/3RqMOqP y2a7GaMXnEFGNIjiUl4ftZwwfUYSS6LHQwNnKtBYcpljyEOO59+xo7O92HdEOV99EhtL8/YH+Ev iCK4gp6nVIryPvcYGn2y+BxkYCtOB6UR1HpYuSN5yLPQtLOZ1EM0b+onR/9qGusAJhne54bWZd5
 vPo/aHvWozvpsvWNi5y9jfSuJ8VM16MTlpWFK34CydWUss6auNTD2s5SUUZsaBFF7kVp4gTo
X-Proofpoint-ORIG-GUID: r9lWqjKSoLzLxSWK6Kd40sKVpCDsTu0Z

The IRQ name format string used in devm_kasprintf() mistakenly included
a newline character "\n".
This could lead to confusing log output or misformatted names in sysfs
or debug messages.

This fix removes the newline to ensure proper IRQ naming.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/perf/cxl_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
index 8998c0a2f3a2d..5a475a5a1f095 100644
--- a/drivers/perf/cxl_pmu.c
+++ b/drivers/perf/cxl_pmu.c
@@ -873,7 +873,7 @@ static int cxl_pmu_probe(struct device *dev)
 		return rc;
 	irq = rc;
 
-	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow\n", dev_name);
+	irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_overflow", dev_name);
 	if (!irq_name)
 		return -ENOMEM;
 
-- 
2.46.0

