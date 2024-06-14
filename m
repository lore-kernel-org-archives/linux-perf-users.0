Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F2E1974EA;
	Fri, 14 Jun 2024 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718386081; cv=none; b=ZaFvIZXr7685mymE1ECtK3Y5EgQWHZzmRFnG1evaxHZJgZgkHEK9F8bMGBzMVF669rySBmR0FOdRA1pdxjWjN/9loZ2cubFL0evdMq1xrHgiL+zobssP2oJHtGJn8SFmcmiUtVTRSRRloBE9ZCFL8pwGSQez+547SZ4+Wk4PYX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718386081; c=relaxed/simple;
	bh=ZVrC8dAFlld6QOtBPCy44tAfoqjF/SAWRNfcYP4u++Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYO6Hx4JYJZ1DfP4SNNS3zgDHxVq/3YZlqFdJrpeY4iUwh7N80vBS9CXXCM9bVAscRSstd8bfIlEvjXpsyWEDp5xUvfpqVOaDrJtVjlYCpTmmiMK72QTXVeG5xKcxcoZ2HUT/PWlkyj0CvGe8oeT8OF7lj4qhwqGkw07zTxFKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ys8xAZF9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ys8xAZF9"
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45EHRGfq019193;
	Fri, 14 Jun 2024 17:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=V1EQ6RecA7t8Y5/LVEqOqhLJ7j
	z7INvLl65FW2DIKz8=; b=Ys8xAZF9mM/MXvCG02G6uq9bzzrWD9ZoBadw1gidOG
	9DNYAT0WZ/Vu2IVLDGDCyShiB3pYMbevU8Hk/Mgo/FJYWZEXUurGlpAlX98QBJ8g
	6zZQiwVi0T4GsiJAPiwflmZcylIo6VhF1plE7BnFhx1FZ5U+75aWoRraaO5gRU/u
	na9gocQQTWnPLEwEYcn5W+CcQmc2pNOPTRYDCMlqCFymlMQMLGpsDOzctc/tyzI0
	upGBcz/gHYfPQDWUGONIK+wqLI9vNZJ3FRshaQfppE112ZhTcLvN6zQaHCvQJX+C
	ZVeQ19m3yKvrKJP5gBV9RM/s8Za9uBiIf26exOCi8ixg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsuv8204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:54 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45EHRs1g020280;
	Fri, 14 Jun 2024 17:27:54 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yrsuv8203-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45EGvLet003881;
	Fri, 14 Jun 2024 17:27:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2mqkf4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Jun 2024 17:27:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45EHRlJj49480148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 17:27:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5433320043;
	Fri, 14 Jun 2024 17:27:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EBE920040;
	Fri, 14 Jun 2024 17:27:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.82.18])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Jun 2024 17:27:44 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH 1/2] tools/perf: Fix the string match for "/tmp/perf-$PID.map" files in dso__load
Date: Fri, 14 Jun 2024 22:57:41 +0530
Message-Id: <20240614172742.56976-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 27fuRxKjMOr40xlvC-Ls6mxsaXWcfAAf
X-Proofpoint-ORIG-GUID: PLlcIsxh1kgd-uIjFHg_d7LRsf9ad8eU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-14_15,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406140119

Perf test for perf probe of function from different CU fails
as below:

	./perf test -vv "test perf probe of function from different CU"
	116: test perf probe of function from different CU:
	--- start ---
	test child forked, pid 2679
	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.Msa7iy89bx/testfile
	  Error: Failed to add events.
	--- Cleaning up ---
	"foo" does not hit any event.
	  Error: Failed to delete events.
	---- end(-1) ----
	116: test perf probe of function from different CU                   : FAILED!

The test does below to probe function "foo" :

	# gcc -g -Og -flto -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.c
	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
	# gcc -g -Og -c /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.c
	-o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o
	# gcc -g -Og -o /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-foo.o
	/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile-main.o

	# ./perf probe -x /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile foo
	Failed to find symbol foo in /tmp/perf-uprobe-different-cu-sh.XniNxNEVT7/testfile
	   Error: Failed to add events.

Perf probe fails to find symbol foo in the executable placed in
/tmp/perf-uprobe-different-cu-sh.XniNxNEVT7

Simple reproduce:

 # mktemp -d /tmp/perf-checkXXXXXXXXXX
   /tmp/perf-checkcWpuLRQI8j

 # gcc -g -o test test.c
 # cp test /tmp/perf-checkcWpuLRQI8j/
 # nm /tmp/perf-checkcWpuLRQI8j/test | grep foo
   00000000100006bc T foo

 # ./perf probe -x /tmp/perf-checkcWpuLRQI8j/test foo
   Failed to find symbol foo in /tmp/perf-checkcWpuLRQI8j/test
      Error: Failed to add events.

But it works with any files like /tmp/perf/test. Only for
patterns with "/tmp/perf-", this fails.

Further debugging, commit 80d496be89ed ("perf report: Add support
for profiling JIT generated code") added support for profiling JIT
generated code. This patch handles dso's of form
"/tmp/perf-$PID.map" .

The check used "if (strncmp(self->name, "/tmp/perf-", 10) == 0)"
to match "/tmp/perf-$PID.map". With this commit, any dso in
/tmp/perf- folder will be considered separately for processing
(not only JIT created map files ). Fix this by changing the
string pattern to check for regex of form "/tmp/perf-*.map"

With the fix,
	# ./perf test "test perf probe of function from different CU"
	117: test perf probe of function from different CU                   : Ok

Signed-off-by: Athira Rajeev<atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/symbol.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9e5940b5bc59..bfb88a4b0987 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -41,6 +41,7 @@
 #include <limits.h>
 #include <symbol/kallsyms.h>
 #include <sys/utsname.h>
+#include <regex.h>
 
 static int dso__load_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
@@ -1797,9 +1798,18 @@ int dso__load(struct dso *dso, struct map *map)
 	struct nscookie nsc;
 	char newmapname[PATH_MAX];
 	const char *map_path = dso__long_name(dso);
+	regex_t    regex;
+	const char *pattern =  "(^/tmp/perf-).*(map)";
 
 	mutex_lock(dso__lock(dso));
-	perfmap = strncmp(dso__name(dso), "/tmp/perf-", 10) == 0;
+	if (regcomp(&regex, pattern, REG_EXTENDED)) {
+		pr_debug("regcomp() failed in dso__load\n");
+		ret = -1;
+		goto out;
+	}
+
+	perfmap = !regexec(&regex, dso__name(dso), 0, NULL, 0);
+
 	if (perfmap) {
 		if (dso__nsinfo(dso) &&
 		    (dso__find_perf_map(newmapname, sizeof(newmapname),
-- 
2.35.3

