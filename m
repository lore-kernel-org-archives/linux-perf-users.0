Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E951E1C3A;
	Thu, 30 Jan 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738238300; cv=none; b=oX5Tyja0NfsumeHj7F7/8WCVfRZdFL005B3JYBRAXucz6lkL+N6VLPtZgGLfapoaJQ2ECjydF9tBl/yGbQZNlUW0M9dw/9WJb4MolI9tCMtF9+4DsIOEw5e93mkWwF8uTenxm1sd8+eFRBrMT5QIoZP3gLS6Tk0Dc3jO/HGVnVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738238300; c=relaxed/simple;
	bh=lJ9MUh0KdOgcF+EQH3Wnx+dTakHWZ7r8kI8RMhsAuU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XSAEayBTPT1XXpFhXaUMgblU5aUej4QYk00MPfUItw6PeZ4WXYf9ynBOlg2HsUDOCiHQlupVyWf9GqhVdOFh57IClEOyhFEtJrBfUfKdJWyDR6xVmf3HBq6meq7zLOm0yr3grARoGxuZ/Y57t0UflEaX/2oY83l02eaO0Ss/QxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WWsO1BjK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WWsO1BjK"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMwimJ024129;
	Thu, 30 Jan 2025 11:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=x2GVpYT05VBJQNz4MvTJuqSf2UpwfYveTHEUCyhI9
	VE=; b=WWsO1BjKDBZGAu6+8d6WhUJKhkT0rr8VQuClHQKmBegiDkSmiiXpfibZS
	X0XLjOK8N7YSkMeGJm1YKkiU7r87y/c2NXqqSSjP8XkxgdVssra4i0nTt2HVFpAK
	VKaiQMB3TdepVEp7INYrNxCj6Nppu4oVxlQYPkhf3sAt/gmldjdZUx8O85PsJhMc
	ioueK64pueikosgaGEvTbCW3/S7sOB5Je7pjkPtusCBXN+QSBd+oRVPcwqIciwi4
	JtWAzDPWHDhfVciHluyZolLExIK2hJVnjp8B9F4VdxLis/MF0gMc/WYbR14FU1Pv
	eiW5TRwczffVwRAxGYITh0dPnAjaQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fpm1nb6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:58:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50U7e5xn019348;
	Thu, 30 Jan 2025 11:58:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44db9n5wmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 11:58:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50UBwAnX19792162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 11:58:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 05E6D2007A;
	Thu, 30 Jan 2025 11:58:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25D020079;
	Thu, 30 Jan 2025 11:58:09 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jan 2025 11:58:09 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@linaro.org>
Subject: [PATCH 1/2] perf test: Fix perf test 114 perf record test subtest precise_max
Date: Thu, 30 Jan 2025 12:57:55 +0100
Message-ID: <20250130115756.3961722-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nvmxOcdb3NHrjqrmDq4fcP4HnSwBG2wd
X-Proofpoint-GUID: nvmxOcdb3NHrjqrmDq4fcP4HnSwBG2wd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_06,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300089

On s390 the event instructions can not be used for recording.
This event is only supported by perf stat.

Test that each event cycles and instructions supports sampling.
If the event can not be sampled, skip it.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Suggested-by: James Clark <james.clark@linaro.org>
---
 tools/perf/tests/shell/record.sh | 43 +++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 0fc7a909ae9b..b905acde8358 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -273,27 +273,42 @@ test_topdown_leader_sampling() {
 }
 
 test_precise_max() {
+  local -i skipped=0
+
   echo "precise_max attribute test"
-  if ! perf stat -e "cycles,instructions" true 2> /dev/null
+  # Just to make sure event cycles is supported for sampling
+  if perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
   then
-    echo "precise_max attribute [Skipped no hardware events]"
-    return
+    if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
+    then
+      echo "precise_max attribute [Failed cycles:P event]"
+      err=1
+      return
+    fi
+  else
+    echo "precise_max attribute [Skipped no cycles:P event]"
+    ((skipped+=1))
   fi
-  # Just to make sure it doesn't fail
-  if ! perf record -o "${perfdata}" -e "cycles:P" true 2> /dev/null
+  # On s390 event instructions is not supported for perf record
+  if perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
   then
-    echo "precise_max attribute [Failed cycles:P event]"
-    err=1
-    return
+    # On AMD, cycles and instructions events are treated differently
+    if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+    then
+      echo "precise_max attribute [Failed instructions:P event]"
+      err=1
+      return
+    fi
+  else
+    echo "precise_max attribute [Skipped no instructions:P event]"
+    ((skipped+=1))
   fi
-  # On AMD, cycles and instructions events are treated differently
-  if ! perf record -o "${perfdata}" -e "instructions:P" true 2> /dev/null
+  if [ $skipped -eq 2 ]
   then
-    echo "precise_max attribute [Failed instructions:P event]"
-    err=1
-    return
+    echo "precise_max attribute [Skipped no hardware events]"
+  else
+    echo "precise_max attribute test [Success]"
   fi
-  echo "precise_max attribute test [Success]"
 }
 
 # raise the limit of file descriptors to minimum
-- 
2.48.1

