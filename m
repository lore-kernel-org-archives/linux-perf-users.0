Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C312FF70
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430743; cv=none; b=j3jUILL9c2Bs2LwNrZ4kSyMRu6WDjlt7mtMgatuA0lxFTDc1QHpgOhmJvmH1NhBBEi37jp0+VSM6M2JEAvLoi2Ne2WVPTLMMQySgUZ8ZxPvzyDcmI2vXn+o35xGQeu03LsvtZM9mWXRAH1HcE1gPb7hs4YDgXasaVoA2UXFWHhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430743; c=relaxed/simple;
	bh=s07O5YPhi1ys0vomXtO9ZiMPVZFW8YPPEjkYcnRMiWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9gY8TuoY5AXy7+4c/iU4B/zFpEKK5PRm4Iu+BsykNyjSoGqdsKDk31Zig0RlsNDh0FAfiIrm3GFk3nPmW/Wqe8kb5MFZHBhJ5+5WB33t/sYrQkXlrhT18SCFt5qcFVhn4LtdcUkgqQOiQvzXqjK1biZbApSR+0Ze5/GoFPswZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cgalDEH8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cgalDEH8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4843lePX006165;
	Wed, 4 Sep 2024 06:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=DmTPCOnHSp11r
	HyK2YG/oCReYCyQ6l65ErMlT8CGBXQ=; b=cgalDEH8IyaiFJZExaylU3EogUoQt
	YFUeAYdhPABqYQ3EtmCxdmMZtWdUJpoUkHYcEkNU72kDJEK4UjBDEoPg229h2ZTy
	rBdYysTmNT96APu0FuQqGZ3rnd1G9R5XBUvIoPkSsriAbqfkj1Z/5gp/x8+oKuhs
	keuUwN5qX22W/xC2H3SGh4DtDskXFHXehTNSlSZFdqRnxDjSNXgMTsSjlmG+Ycg9
	djLxhR/sXEuvyntHB/yhwEb8Hcu5vnKWb1arV/FJgZOFO9WFXCXXUvQPXDquOwCi
	Kj8wXlpS97+lM6xYOd0nUmu73tjT98yUUGdhcAk3XleY+AjQLyAY0UIXg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhfr4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4846FgRn031891;
	Wed, 4 Sep 2024 06:18:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41bttyhfqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4841fH2O009141;
	Wed, 4 Sep 2024 06:18:57 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cg73p1gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 06:18:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4846Is0047055336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 06:18:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F7620049;
	Wed,  4 Sep 2024 06:18:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A6120040;
	Wed,  4 Sep 2024 06:18:51 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.38])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 06:18:51 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v14 6/7] perf: Fix inconsistencies in feature names
Date: Wed,  4 Sep 2024 11:48:35 +0530
Message-ID: <20240904061836.55873-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904061836.55873-1-adityag@linux.ibm.com>
References: <20240904061836.55873-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klfoc8WRtYbNZUL4KCsgznQXxBHK3Ta6
X-Proofpoint-ORIG-GUID: Gw-2kce_rziYp87iREqprxTdUIA7P-XV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_04,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=736
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2409040045

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
2.46.0

