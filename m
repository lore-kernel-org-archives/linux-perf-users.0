Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85C523AB
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 07:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730705388; cv=none; b=jku8Cd5dcDFQlIHHpueTqfFZz8IeFd/FS1crdAbt+z1QSc+3z4pBTmc55ft53cXtFci8It74xJfUtswy/AxwxBCfovQogEEXcnlQsfbYI7hiMH1uSu3bPRwsYFAkp5VKWFGxjCtTevDeCzFCF14bPBVSOZ09kigWcgi64/UmsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730705388; c=relaxed/simple;
	bh=oUQ32piPeN8jJRUwC3Naout15DeriTwDeQi51kII9Ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HD682OhFKssvnwRzWEdSW9xpxW+FZFlDggpPc6WptqXyJ8hfQDpBedsLxhzcFXsURwMZ0GK3WU5K7n3ICou9RAi3zefU2G7SpfUTERPIQg907JYqg5CVfYMBt8BuaRQtXmsK0QI5I4UlfL9oem/OrreHoOeCk8vL6cuMPuyb8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bmqOAw7r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bmqOAw7r"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A47ARJa027925;
	Mon, 4 Nov 2024 07:29:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nLkYmtBtDHpw5HrNqvFnObaxUKs9S56IrfEc9MjTF
	YM=; b=bmqOAw7rMQGlZZEQsIj8lgWzXPM8n2SH27rugvAO3kj9kdej1hiEg6dpd
	Dt4MKRfQX0WIMH9dvpbP6CIJtgYw2EA3tnX9MFAP2bLIUt5uHPzhx2eyRsuVql4d
	OuvCp4QhD3Tn0H+IIbHyBZQV965rE9q6+U1WKBaNyJBCIdM4VUJTcWYe/NpRy78B
	AXX6rDVemj/p9OVZ6Izyi6dvEB3UgBrWto8Xivsk1hCXDWlBx5fSH0kM4i3tGHdx
	AeDUVuJxmJ4sFbuddWmq4aewrDHGnOUCOdr4DdnFahGPaJvh8bd6rJaqfJpojgjC
	cXzTLEpLmSq5enPC6w0Quyjlzp2SA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42psn382hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 07:29:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A47TVI9004558;
	Mon, 4 Nov 2024 07:29:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42psn382hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 07:29:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A47Sfum008439;
	Mon, 4 Nov 2024 07:29:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywk2hb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 07:29:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A47TQd227591278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 07:29:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C271D20040;
	Mon,  4 Nov 2024 07:29:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A775B2004B;
	Mon,  4 Nov 2024 07:29:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.251.57])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 07:29:20 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akanksha@linux.ibm.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, mpetlan@redhat.com, hbathini@linux.ibm.com,
        vmolnaro@redhat.com
Subject: [PATCH V2] tools/perf/tests/shell/base_probe: Enhance print_overall_results to print summary information
Date: Mon,  4 Nov 2024 12:59:14 +0530
Message-Id: <20241104072914.15196-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pVk7GQDBCzbM2ZGIi_BXwaRz0xX4W3VR
X-Proofpoint-ORIG-GUID: tSeJ-X5kw_Q-aO8JITQmfOhyQvtEfFBC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 mlxscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411040062

Currently print_overall_results prints the number of
fails in the summary, example from base_probe tests in
testsuite_probe:

 ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
	11 failures found

test_invalid_options contains multiple tests and out
of that 11 failed. Sometimes it could happen that it
is due to missing dependency in the build or environment
dependency.

Example, perf probe -L requires DWARF enabled. otherwise
it fails as below:
 ./perf probe -L
  Error: switch `L' is not available because NO_DWARF=1

"-L" is tested as one of the option in :
   for opt in '-a' '-d' '-L' '-V'; do
   <<perf probe test>>
   print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument
	for $opt"

Here -a and -d doesn't require DWARF. Similarly there
are few other tests requiring DWARF. To hint the user that
missing dwarf could be one issue, update print_overall_results
to print a comment string along with summary hinting the possible
cause. Update test_invalid_options.sh and test_line_semantics.sh
to pass the info about dwarf requirement since these tests
failed when perf is built without DWARF. Use the check for
presence of dwarf with "perf check feature" and append the
hint message based on the result.

With the change:
 ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
 11 failures found :: Some of the tests need DWARF to run

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 v1 -> v2:
 Check presence of dwarf using "perf check feature". Add
 failure hint message for dwarf based on this check

 tools/perf/tests/shell/base_probe/test_invalid_options.sh | 5 ++++-
 tools/perf/tests/shell/base_probe/test_line_semantics.sh  | 5 ++++-
 tools/perf/tests/shell/common/init.sh                     | 3 ++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
index 1fedfd8b0d0d..c51d8d9bfdb7 100755
--- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
+++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
@@ -22,6 +22,9 @@ if ! check_kprobes_available; then
 	exit 0
 fi
 
+# Check for presence of dwarf
+$CMD_PERF check feature -q dwarf
+[ $? -ne 0 ] && HINT_FAIL="Some of the tests need DWARF to run"
 
 ### missing argument
 
@@ -75,5 +78,5 @@ done
 
 
 # print overall results
-print_overall_results "$TEST_RESULT"
+print_overall_results "$TEST_RESULT" $HINT_FAIL
 exit $?
diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
index d8f4bde0f585..f5d3b6e8d0d6 100755
--- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
+++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
@@ -23,6 +23,9 @@ if ! check_kprobes_available; then
 	exit 0
 fi
 
+# Check for presence of dwarf
+$CMD_PERF check feature -q dwarf
+[ $? -ne 0 ] && HINT_FAIL="Some of the tests need DWARF to run"
 
 ### acceptable --line descriptions
 
@@ -51,5 +54,5 @@ done
 
 
 # print overall results
-print_overall_results "$TEST_RESULT"
+print_overall_results "$TEST_RESULT" $HINT_FAIL
 exit $?
diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index 075f17623c8e..0862cbc1c6f7 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -46,10 +46,11 @@ print_results()
 print_overall_results()
 {
 	RETVAL="$1"; shift
+	TASK_COMMENT="$*"
 	if [ $RETVAL -eq 0 ]; then
 		_echo "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY"
 	else
-		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found"
+		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found :: $TASK_COMMENT"
 	fi
 	return $RETVAL
 }
-- 
2.43.5

