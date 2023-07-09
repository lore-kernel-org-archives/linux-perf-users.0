Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51187C001DF
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 18:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjGIS2f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jul 2023 14:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjGIS2d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jul 2023 14:28:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB70115
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 11:28:32 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369IMOMW005261;
        Sun, 9 Jul 2023 18:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=P0CCNRyJfDkFJfrzp7BAucvhadwLDOI73E4hPSkQU/w=;
 b=i/qjFdWyGGrWBF0zPR8/rS0Q/a7ODz1c+m3Hxs7HUJY2tGjE+RLBTQQx9bWru+B0UWQd
 88g1mPDhpfcTSwZbLwJZMdWSAZtqtDxgpLexaf1ynQnK21gydZ7aIRyThZVDDF3tb5Wf
 5GDPm36EHxQCevzLSVr4eSGxSXweHR4mRb58P6S2/QcmZKUX5cudfXSb5bWnoOBb7N3W
 CcsHsOzP6HeqOrfPLejA8PtKoOuSA9nuw4gB/Z4rOl3m+vscqaMKSKE3qy/8zs53RPLo
 d1KrbeHJqe1gqqPvNA9uFYQZAfcM+YUiZC/Vo9F6dU40D5UPPq3659AIVrE4IUR4LxcU GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr24181dp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:25 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 369ISPl5019778;
        Sun, 9 Jul 2023 18:28:25 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr24181dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 369HQAgT007831;
        Sun, 9 Jul 2023 18:28:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rpye58mqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 369ISJQn36962918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jul 2023 18:28:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE4132004E;
        Sun,  9 Jul 2023 18:28:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F1E720040;
        Sun,  9 Jul 2023 18:28:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.24.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jul 2023 18:28:17 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 05/26] tools/perf/tests: Fix shellcheck issue for stat_bpf_counters_cgrp.sh testcase
Date:   Sun,  9 Jul 2023 23:57:39 +0530
Message-Id: <20230709182800.53002-6-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7qd6ZMDEUMNlrKPGhdsMUcJnucxkg7OR
X-Proofpoint-ORIG-GUID: do8k2CDYATca02-LVN9vyBqmkPe-qI8T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-09_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307090169
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on lock_contention.sh generates below warning:

In stat_bpf_counters_cgrp.sh line 28:
	if [ -d /sys/fs/cgroup/system.slice -a -d /sys/fs/cgroup/user.slice ]; then
                                            ^-- SC2166 (warning): Prefer [ p ] && [ q ] as [ p -a q ] is not well defined.

In stat_bpf_counters_cgrp.sh line 34:
	local self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
        ^-------------^ SC3043 (warning): In POSIX sh, 'local' is undefined.
              ^-------^ SC2155 (warning): Declare and assign separately to avoid masking return values.
                        ^-- SC2046 (warning): Quote this to prevent word splitting.

In stat_bpf_counters_cgrp.sh line 51:
	local output
        ^----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

In stat_bpf_counters_cgrp.sh line 65:
	local output
        ^----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

Fixed above warnings by:
- Changing the expression [p -a q] to [p] && [q].
- Fixing shellcheck warnings for local usage, by prefixing
  function name to the variable.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 .../tests/shell/stat_bpf_counters_cgrp.sh     | 28 ++++++++-----------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
index d724855d097c..a74440a00b6b 100755
--- a/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
+++ b/tools/perf/tests/shell/stat_bpf_counters_cgrp.sh
@@ -25,22 +25,22 @@ check_bpf_counter()
 find_cgroups()
 {
 	# try usual systemd slices first
-	if [ -d /sys/fs/cgroup/system.slice -a -d /sys/fs/cgroup/user.slice ]; then
+	if [ -d /sys/fs/cgroup/system.slice ] && [ -d /sys/fs/cgroup/user.slice ]; then
 		test_cgroups="system.slice,user.slice"
 		return
 	fi
 
 	# try root and self cgroups
-	local self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
-	if [ -z ${self_cgrp} ]; then
+	find_cgroups_self_cgrp=$(grep perf_event /proc/self/cgroup | cut -d: -f3)
+	if [ -z ${find_cgroups_self_cgrp} ]; then
 		# cgroup v2 doesn't specify perf_event
-		self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
+		find_cgroups_self_cgrp=$(grep ^0: /proc/self/cgroup | cut -d: -f3)
 	fi
 
-	if [ -z ${self_cgrp} ]; then
+	if [ -z ${find_cgroups_self_cgrp} ]; then
 		test_cgroups="/"
 	else
-		test_cgroups="/,${self_cgrp}"
+		test_cgroups="/,${find_cgroups_self_cgrp}"
 	fi
 }
 
@@ -48,13 +48,11 @@ find_cgroups()
 # Just check if it runs without failure and has non-zero results.
 check_system_wide_counted()
 {
-	local output
-
-	output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
-	if echo ${output} | grep -q -F "<not "; then
+	check_system_wide_counted_output=$(perf stat -a --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, sleep 1  2>&1)
+	if echo ${check_system_wide_counted_output} | grep -q -F "<not "; then
 		echo "Some system-wide events are not counted"
 		if [ "${verbose}" = "1" ]; then
-			echo ${output}
+			echo ${check_system_wide_counted_output}
 		fi
 		exit 1
 	fi
@@ -62,13 +60,11 @@ check_system_wide_counted()
 
 check_cpu_list_counted()
 {
-	local output
-
-	output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
-	if echo ${output} | grep -q -F "<not "; then
+	check_cpu_list_counted_output=$(perf stat -C 1 --bpf-counters --for-each-cgroup ${test_cgroups} -e cpu-clock -x, taskset -c 1 sleep 1  2>&1)
+	if echo ${check_cpu_list_counted_output} | grep -q -F "<not "; then
 		echo "Some CPU events are not counted"
 		if [ "${verbose}" = "1" ]; then
-			echo ${output}
+			echo ${check_cpu_list_counted_output}
 		fi
 		exit 1
 	fi
-- 
2.39.1

