Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F0F507
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Apr 2025 03:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745206932; cv=none; b=GbmouDBibJ1UTHewvVTOJn3pNTxXRr/o3u7jJ8bY7CnP7MuFOArhzEe2nuJV80+RprR1hPoxX9hAucJZcB8d5UeH7A+oOWdJkzzpbZUzsi0MCpkGu/YV9bnnsE2fdCf2iWKlFqdFK/yzKHcSoyK1+MCmBw9wMkenFRlvcXtfFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745206932; c=relaxed/simple;
	bh=BlMegyJmIrg1QP3e4bBD3yKDUakoM5rEZf05PMh9Cb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OE+nDbGEBzXNOCsP5hR9orOgGzaRJiNEwL9WnvwSn+/Md5liuI1WVZFZiF8acEVJsAeL8HEIFcUlFY8hTweTHFKXU3keOSgdgD7zFRttJm06XiNwt/LSLjESoQ98PYvUnhF+Fnneh70/dIWi+dNHgDYZUhUY4+B9t1TuMgL9KEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ducOmJp6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ducOmJp6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53KErVxK022741;
	Mon, 21 Apr 2025 03:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=u/3GNyTjvWv0mxebvfUvL/V06uoGFyDe0LOLP9Uqn
	IY=; b=ducOmJp6IhNGUFRuPMDwCnXqeaHjEiFw4DHY8DL28cxOA7rWvN/FD0T/a
	wJoMD4YOAgIZJ+z7DFQ1g015CBpsEP2BQdH7pjlcahiq8PSJ3R5nCyRwSDUKsVIf
	YDoUVGuDWF+EsZleSNgeFOP1Ci8+1fZLQ3rxsphXTkzV64JmNxCIse78SFyfG0C8
	2ACTmjH33VQjGYmhAIG89Jk+x+cT2yc3xB6ctTtjDZ/LGXVq7QwddIDyw7aOuM9n
	g8T19KEPbFo1x1K/nS+86JYhq4JTzDeWoNmdcKRiX8pLB+fkTUPOut6Mj649reDj
	k68Fa3xfqMBL6d/hmcPeC0W3+BJ/A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464ycrjbg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 03:42:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53L3fxuo024674;
	Mon, 21 Apr 2025 03:41:59 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 464ycrjbg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 03:41:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53KNFOHp001858;
	Mon, 21 Apr 2025 03:41:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 464rcjvcgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 03:41:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53L3ftG849742116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Apr 2025 03:41:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E78872004B;
	Mon, 21 Apr 2025 03:41:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA99120040;
	Mon, 21 Apr 2025 03:41:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.250.177])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Apr 2025 03:41:47 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com, jiang.peng9@zte.com.cn, venkat88@linux.ibm.com,
        Tejas.Manhas1@ibm.com, Athira Rajeev <atrajeev@linux.ibm.com>
Subject: [PATCH] tools headers: Update the include/vdso/unaligned.h to sync headers
Date: Mon, 21 Apr 2025 09:11:43 +0530
Message-Id: <20250421034143.67607-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Jp7xrN4C c=1 sm=1 tr=0 ts=6805be88 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=jsV3ipladHLh7Js4ScoA:9
X-Proofpoint-GUID: bSBy9oQTuYubOkNOdSrZgVGfPyrwojfn
X-Proofpoint-ORIG-GUID: KOojRW8EQ1d0B8E5ZfGeT6jLp3mWLnPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-21_02,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504210025

To pick up the changes in:
	commit acea9943271b ("vdso: Address variable shadowing in macros")

Addressing this perf tools build warning:

	diff -u tools/include/vdso/unaligned.h include/vdso/unaligned.h

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
---
 tools/include/vdso/unaligned.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/include/vdso/unaligned.h b/tools/include/vdso/unaligned.h
index eee3d2a4dbe4..ff0c06b6513e 100644
--- a/tools/include/vdso/unaligned.h
+++ b/tools/include/vdso/unaligned.h
@@ -2,14 +2,14 @@
 #ifndef __VDSO_UNALIGNED_H
 #define __VDSO_UNALIGNED_H
 
-#define __get_unaligned_t(type, ptr) ({						\
-	const struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);	\
-	__pptr->x;								\
+#define __get_unaligned_t(type, ptr) ({							\
+	const struct { type x; } __packed * __get_pptr = (typeof(__get_pptr))(ptr);	\
+	__get_pptr->x;									\
 })
 
-#define __put_unaligned_t(type, val, ptr) do {					\
-	struct { type x; } __packed *__pptr = (typeof(__pptr))(ptr);		\
-	__pptr->x = (val);							\
+#define __put_unaligned_t(type, val, ptr) do {						\
+	struct { type x; } __packed * __put_pptr = (typeof(__put_pptr))(ptr);		\
+	__put_pptr->x = (val);								\
 } while (0)
 
 #endif /* __VDSO_UNALIGNED_H */
-- 
2.47.1

