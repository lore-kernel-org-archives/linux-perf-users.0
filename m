Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C5413B287;
	Sat, 13 Jul 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889768; cv=none; b=WW+4GR9i47hfRhvuDtUmwolMIFiomLsdkCFy6PPdV0YpRiqAnQTT+ePwk6YKe7ei5Dr8Q7KB7Ms/y1lzU4n+cwMHH1dagHnlYjEZYV0l5rVFGnYBkAkC9bBSHSJb6ke3LADXknRPvVao6I5rgNGEqp/jxDwfYAxoKS6cDhxDMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889768; c=relaxed/simple;
	bh=+8ou4jOda7rMv75YTQ7kLFOSOP6gThDj9zdygA14m1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W7jn2pSCBKvqvV3GcVYKiyKJH/RKKW3//wTHVhglbLAloYLNcVTajzxBjE7vFvZe9CDyA9h0ZqEgwK/W9DUlya+0qTIqEBsQ9kjshokuomvdHzvd/UbYq++z+0OfrWjvXQxDB/T3qmlQVnxj5UjOv2bObQvuGJRO1p9gahJMiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rmJMTSpr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rmJMTSpr"
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46DGR9xQ007645;
	Sat, 13 Jul 2024 16:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=gaEeJvcdxtPqR
	OzBKZFbR4JjVC2CIIbd8gbZSMkJASY=; b=rmJMTSpri59gKIHUVwlZIfm0NWeBV
	ISoPJlFWem7SINOd57iNVx012arqN3Ep48i89O1B4hWE+zwtNkPYAMWGPNHXCecw
	P5fJxJW54kGvgCtGvYsXQPcUCVUi3S+OoIvngxCb+Rs12Ziz0NYj+EPbTTZH2oEz
	6DuM9tc6fxtdTGtsQi/1t48HJ101seD6oTfmrk0rrCUpNhEZ/IOnJTc6NQmRYjw/
	qMe72Vfkc2GQWc5EFtW09L6O6erItP5+JNLgc9XSzlz1L9S1e+C/pi7cxdeD1GO3
	S1+Giy/rS5XgyG8ldpJzaiEqzGkGQzzDYuoMxTAwj4qv0AYjRjhZf2LFw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40brr2gcd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:52 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46DGtqon015146;
	Sat, 13 Jul 2024 16:55:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40brr2gccr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46DDneFY011368;
	Sat, 13 Jul 2024 16:55:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40bpec1fku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jul 2024 16:55:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46DGtjKw53739804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jul 2024 16:55:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 976A920040;
	Sat, 13 Jul 2024 16:55:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF08420043;
	Sat, 13 Jul 2024 16:55:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.49.134])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jul 2024 16:55:42 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, segher@kernel.crashing.org,
        christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V7 03/18] tools/perf: Update TYPE_STATE_MAX_REGS to include max of regs in powerpc
Date: Sat, 13 Jul 2024 22:25:14 +0530
Message-Id: <20240713165529.59298-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
References: <20240713165529.59298-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FY1-UpCxQAkFwVv0ONoydQKjb5mQ0b80
X-Proofpoint-ORIG-GUID: _UMfHxLYjlu6OYwEw_J68fB13MX_U7UC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-13_13,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407130127

TYPE_STATE_MAX_REGS is arch-dependent. Currently this is defined
to be 16. While checking if reg is valid using has_reg_type,
max value is checked using TYPE_STATE_MAX_REGS value. Define
this conditionally for powerpc.

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/annotate-data.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 6fe8ee8b8410..992b7ce4bd11 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -189,7 +189,11 @@ struct type_state_stack {
 };
 
 /* FIXME: This should be arch-dependent */
+#ifdef __powerpc__
+#define TYPE_STATE_MAX_REGS  32
+#else
 #define TYPE_STATE_MAX_REGS  16
+#endif
 
 /*
  * State table to maintain type info in each register and stack location.
-- 
2.43.0

