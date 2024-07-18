Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927977F47F
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293228; cv=none; b=ocIO8v7mBlM/bS5Fq/oTnjGKK1dMOXgegotCPd45tUwqJcCEipQAjq1OggD5iRoGeYuAfcqHfLJx4heBwhx71nIuMY0RINgTZu6cYLILnrbm3PbWva6LExyyE4a9Lqa9lQsQKbFwoy0LE1+e8Ux8PdY6WrKxqLzeWhGXE6dNO5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293228; c=relaxed/simple;
	bh=yhflHwbBfTXhoM4cRy1ufD3jC1fu1mZ1RFEjFnGUa8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PecEgnVmz9G+h2dtyNLP8ha5zaRzUOUa/pkpA/AyLd6Zs5b5XeS0cIGupWLJS+XtoPGkRJLiQevKVsZD6b+TYuiKQX7zKquPLcY+Zn3a+wux05BPGwJ1GW/ua+E1zxosP8/77KXDI0h0LCMT1u1lgMSn9ZfSkWJ5CByN15aZ7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zk35pSsS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zk35pSsS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I8p50M031344;
	Thu, 18 Jul 2024 09:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=0iJ0WBqBmcPGn
	q8vnj5rul55TBF+7VYo8xe3KfPXpt4=; b=Zk35pSsSYMyWO8xQSX15jlSHjByPO
	LxKWqBREx3dXsUOXcXRh/zBFVzPizzTPW3G9fVRwKj9wpCVZFcQMVkzxzAbxw2FR
	FWN+Vvn8o2vnVz6M3lSo9QMIKtvRDons20hZoPLma9kiKe2HVge0knU5P+Pudl6T
	gagMqSgiXsru7H8ivd7R4teD8rd2iNtXBKpl/+DqIzKY5SGm0+477DdXJR+X9Pri
	m00MSy5m4RtYYhTZ34Zd4Zwq8rMxy88DPwf4FbxCOjpE10oy4kjVPDUhCHcnaAHC
	xOuN0Hjg/PfDjhCX0zKjE/Bbsn72tVOJ41UXmH9x3LZSQuZskDLi3wl5g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ey4m8416-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I90M4n011063;
	Thu, 18 Jul 2024 09:00:22 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ey4m8411-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I8sKhU006082;
	Thu, 18 Jul 2024 09:00:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkmgtd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I90G6j53084650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:00:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A329A2004E;
	Thu, 18 Jul 2024 09:00:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CC7F20040;
	Thu, 18 Jul 2024 09:00:14 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:00:14 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v13 6/7] perf: Fix inconsistencies in feature names
Date: Thu, 18 Jul 2024 14:29:56 +0530
Message-ID: <20240718085957.550858-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mMiL-iI1fxz6lJxHjq-I4NiQjXt7S8Kq
X-Proofpoint-ORIG-GUID: K5rPomnxpDaLX3UlkBNdEAaZWBqxJMRK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=735 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407180056

Fix two inconsistencies in feature names as discussed in [1]:
1. Rename "dwarf-unwind-support" to "dwarf-unwind"
2. 'get_cpuid' feature and 'HAVE_AUXTRACE_SUPPORT' names don't
   look related, change the feature name to 'auxtrace' to match the
   macro name, as 'get_cpuid' string is not used anywhere to check the
   feature presence

[1]: https://lore.kernel.org/linux-perf-users/ZoRw5we4HLSTZND6@x1/

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 tools/perf/Documentation/perf-check.txt | 4 ++--
 tools/perf/builtin-check.c              | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
index b081514d240a..10f69fb6850b 100644
--- a/tools/perf/Documentation/perf-check.txt
+++ b/tools/perf/Documentation/perf-check.txt
@@ -49,8 +49,8 @@ feature::
                 debuginfod              /  HAVE_DEBUGINFOD_SUPPORT
                 dwarf                   /  HAVE_DWARF_SUPPORT
                 dwarf_getlocations      /  HAVE_DWARF_GETLOCATIONS_SUPPORT
-                dwarf-unwind-support    /  HAVE_DWARF_UNWIND_SUPPORT
-                get_cpuid               /  HAVE_AUXTRACE_SUPPORT
+                dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
+                auxtrace                /  HAVE_AUXTRACE_SUPPORT
                 libaudit                /  HAVE_LIBAUDIT_SUPPORT
                 libbfd                  /  HAVE_LIBBFD_SUPPORT
                 libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 16a04b5456d9..0b76b6e42b78 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -29,8 +29,8 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("debuginfod", HAVE_DEBUGINFOD_SUPPORT),
 	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
 	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
-	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
-	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
+	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
-- 
2.45.2

