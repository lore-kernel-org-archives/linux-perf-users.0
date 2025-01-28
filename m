Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB51ACEBD;
	Tue, 28 Jan 2025 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738076610; cv=none; b=GI7558ARWfJkpY6v+L6gHYSCk3JiBeEgdlcwMiNFggNdllkeWpXCO3xGDT63lE7q3TXlwwDrIrwxhNzFlpWobexVbco2IuV2m9MCw38oPz/mW77DUi4XQNbqsLniSub6IKtuJRW36PSWE+xlxj70XGQb23W3YMEED3UYkKPD8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738076610; c=relaxed/simple;
	bh=Q8zYJBLp6YWexD4aEHV80XE2DKZqgWlm/dBF8NDocEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYOA6RF5EjACnn6h6wxJ+c9ug0zljEmwTWqSyg2zX1b05Js6QMYS0VI+bWynCBj0tD4aeoU96arhH9mBjgwWXsUHtXgLTa/bX2s3NX2hTXK6Jn/hYxnNIbvauDOugumePK4x299gnIDBUfHBYaTuRSQS/YUiT67PtLTUjWidgyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RLw3t+UH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RLw3t+UH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDB6WH011073;
	Tue, 28 Jan 2025 15:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PA6/nDIaXcXzhasarNRYFKR13XEoD8+iitZG/X6e4
	OY=; b=RLw3t+UHUGkIkoKAcgawkY6PdOnsiQlYM9RR6ZHb8JR4S4Cs5Xlr7/9wz
	iyRGaeSCXiaj2FsoqfdI9nr8wPkUrHyblmYWnj6ibhsWrDJH09BNyRbm1oAhyR1p
	4kNaYITnz93KluXtWdeHK6xMM+Ib85mJvXfYfdD+Uc3KPPVvAtvOxJ5JXKdMyn7a
	tMuT1RIOpN5ZIyqPTcPZCBOFIlkQ6i7CJNaaWZmv9f0f2dMvmpG3u/BBT3QhNKWD
	9YmCFxfrFX4Sci43q/CdTtelEPxMfsBW8cNwLF8wQTVHMAaIIzt9HXkDy6f8PQOK
	NXcrLwU4qRXdNUXL4pwh+dWCIAzFA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ena9ueer-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:03:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50SDk5Oi019213;
	Tue, 28 Jan 2025 15:03:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9mus3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 15:03:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50SF3Jw958982804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 15:03:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C73B220043;
	Tue, 28 Jan 2025 15:03:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AF882004D;
	Tue, 28 Jan 2025 15:03:19 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jan 2025 15:03:19 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, james.clark@linaro.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Fix perf test 114 perf record test for s390
Date: Tue, 28 Jan 2025 16:03:07 +0100
Message-ID: <20250128150307.1129522-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E5nH4LlGgn6jztsF--y1lg9zGvZz7xfj
X-Proofpoint-GUID: E5nH4LlGgn6jztsF--y1lg9zGvZz7xfj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280111

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.
Skip all tests which use perf record -e instruction ....

Cc: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/tests/shell/record.sh | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..297d0e459875 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -287,11 +287,15 @@ test_precise_max() {
     return
   fi
   # On AMD, cycles and instructions events are treated differently
-  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+  # On s390 event instructions can not be used for recording
+  if [ $(uname -m) != s390x ]
   then
-    echo "precise_max attribute [Failed instructions:P event]"
-    err=1
-    return
+    if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+    then
+      echo "precise_max attribute [Failed instructions:P event]"
+      err=1
+      return
+    fi
   fi
   echo "precise_max attribute test [Success]"
 }
@@ -307,7 +311,8 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
-test_leader_sampling
+# On s390 event instructions can not be used for recording
+[ $(uname -m) != s390x ] && test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
 
-- 
2.48.1

