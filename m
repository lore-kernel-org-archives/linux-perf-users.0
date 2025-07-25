Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AD22F16E
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Jul 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753463315; cv=none; b=KBjgoBaXtKx37h/D8wKA6AB2OHhzqFSNGdRj9QHwVUiWQ1RkXM215Q7u594gMUApbhLovxs2Ikl3uyYzf/V1VL5ca16Mb68ryK4KJ0IjIFnwnoGCleILGN2pWyCOqDPsrHi3wi95E/ALZR88zP/jwy+fLatc/po6el5mTGHStFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753463315; c=relaxed/simple;
	bh=coBDswm9pTdkyrjyJFlDeBPxBqkjEejM0hqXsIUp1mU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+aC96+PiyD+ocQYf8z6UP0ouK3Y/vSJvjZDD1hLO9DWdn9vTkFlu1+vYGdJEzwn92jevgFh05tZS5vRA9rpeHrH9eoH2zpYuvOjyaOw+tN/iCCxwMJ0mFe4i0uFltyD6T6Lt4YlqM1PLqNC2rGWpk91x/tl14NgmAgrkRtbTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gc3QO3Ih; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gc3QO3Ih"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PAIghU004194;
	Fri, 25 Jul 2025 17:08:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=TQLjD39m20SmRuGFWaCcSsqR8IKlOGU9JB6MMnDqD
	Ds=; b=gc3QO3Ih0yV15P0I1OE8wUjtIJUihb+Ru8Lu1QIWcKqYuUPjEBb+yQaC4
	2DQ9cWDoSbBTbvKvuWczROfm0ROwW6H0jvRSpA5viHDCyxFy5DGPNRxRQticDL+F
	Y81cCi8ttVkd+gUioRqqr6CfyS0kp5DtXOTy+Mk2X8qUndF4woaqlD14q+7VkSfS
	O09X5oQqTKKWTP6tm/KGJZlI/2qLb7IbcvkSAi5nEuLD/cc2EK0mMqgVXEAdAcsG
	8slMzNg9lB8gb9Lo7xOdlGB4EHA50qjA/p4Klvn2ETgWTvP3sVLGUyvpaAZWlHHw
	6FJDcgY0P0IGobrwgpW/SNmetmkgg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjv8f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:08:30 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56PGv9g8025749;
	Fri, 25 Jul 2025 17:08:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wcjv8eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:08:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56PH7jvG014296;
	Fri, 25 Jul 2025 17:08:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480pppjg24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:08:07 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56PH849248234906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 17:08:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 049602004B;
	Fri, 25 Jul 2025 17:08:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9D8720043;
	Fri, 25 Jul 2025 17:08:03 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Jul 2025 17:08:03 +0000 (GMT)
From: Jan Polensky <japo@linux.ibm.com>
To: adrian.hunter@intel.com, irogers@google.com, namhyung@kernel.org,
        tmricht@linux.ibm.com (Thomas Richter)
Cc: linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/1] perf test: Ensure lock contention using pipe mode
Date: Fri, 25 Jul 2025 19:08:01 +0200
Message-ID: <20250725170801.3176678-1-japo@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ExR3GfgtUvCG9_vHZux4GEG1l7jo8wG
X-Proofpoint-ORIG-GUID: Ky9w4C2d7L2jtXH8mfJ8Hyx4NVgeSG5L
X-Authority-Analysis: v=2.4 cv=QOloRhLL c=1 sm=1 tr=0 ts=6883ba0e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=FONH68XXmmWuh1bSqZ8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE0NyBTYWx0ZWRfX8A6OFzUNcNKe
 hdZG50rkA+t0nRH6+giLP77VJACBLliSyyPNKb/XpizKaTPzifK4r3upMLKO8xrIBWZ5KFaB+wK
 sFwtlnfnvPrOLsPjHkwAcrWPBn01FdyFAw55VLgtSjlcXdP1s8UToIoq/g+kS3ZTAY8BfX8XJwl
 9kqizSQPspajNxEpWYeBhcm13ci2ut4PDKQdrhbUYgV4B+CQOnrfUUUgqleExEcXTeKor8KS36S
 f2j15yOfI/3wANTXXzoLgQXGPsMzYiw4hyMu+BdgktUzt5d10E9uNsyPIFSGNLYdn7/Zml24zb9
 sYEWo25NodV4OIQpUgvSwWcoD7HYRtwMFQq3iVv7eF2L7flNeRZNl21VkFDJTvKiZPEr7Hc9Uab
 0tlMJAgMq2opUY7qyLHUU25mhQ/PUOR1uc+WW6Ym6F8SrXvicGWbXLOHcSU0vPg1d23ln6dF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250147

The 'kernel lock contention analysis test' requires reliable triggering
of lock contention. On some systems, previous benchmark calls failed to
generate sufficient contention due to low system activity or resource
limits.

This patch adds the -p (pipe) option to all calls of perf bench sched
messaging, ensuring consistent lock contention without relying on
socket-based communication.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jan Polensky <japo@linux.ibm.com>
---
 tools/perf/tests/shell/lock_contention.sh | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
index 30d195d4c62f..2c2887b22407 100755
--- a/tools/perf/tests/shell/lock_contention.sh
+++ b/tools/perf/tests/shell/lock_contention.sh
@@ -44,7 +44,7 @@ check() {
 test_record()
 {
 	echo "Testing perf lock record and perf lock contention"
-	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
+	perf lock record -o ${perfdata} -- perf bench sched messaging -p > /dev/null 2>&1
 	# the output goes to the stderr and we expect only 1 output (-E 1)
 	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
@@ -64,7 +64,7 @@ test_bpf()
 	fi

 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -75,7 +75,7 @@ test_bpf()
 test_record_concurrent()
 {
 	echo "Testing perf lock record and perf lock contention at the same time"
-	perf lock record -o- -- perf bench sched messaging 2> /dev/null | \
+	perf lock record -o- -- perf bench sched messaging -p 2> /dev/null | \
 	perf lock contention -i- -E 1 -q 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] Recorded result count is not 1:" "$(cat "${result}" | wc -l)"
@@ -99,7 +99,7 @@ test_aggr_task()
 	fi

 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -t -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -122,7 +122,7 @@ test_aggr_addr()
 	fi

 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -l -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -140,7 +140,7 @@ test_aggr_cgroup()
 	fi

 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -g -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result count is not 1:" "$(cat "${result}" | wc -l)"
 		err=1
@@ -162,7 +162,7 @@ test_type_filter()
 		return
 	fi

-	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -Y spinlock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(grep -c -v spinlock "${result}")" != "0" ]; then
 		echo "[Fail] BPF result should not have non-spinlocks:" "$(cat "${result}")"
 		err=1
@@ -194,7 +194,7 @@ test_lock_filter()
 		return
 	fi

-	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -L tasklist_lock -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(grep -c -v "${test_lock_filter_type}" "${result}")" != "0" ]; then
 		echo "[Fail] BPF result should not have non-${test_lock_filter_type} locks:" "$(cat "${result}")"
 		err=1
@@ -222,7 +222,7 @@ test_stack_filter()
 		return
 	fi

-	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a lock from unix_stream:" "$(cat "${result}")"
 		err=1
@@ -250,7 +250,7 @@ test_aggr_task_stack_filter()
 		return
 	fi

-	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -t -S unix_stream -E 1 -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a task from unix_stream:" "$(cat "${result}")"
 		err=1
@@ -266,7 +266,7 @@ test_cgroup_filter()
 		return
 	fi

-	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -g -E 1 -F wait_total -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a cgroup result:" "$(cat "${result}")"
 		err=1
@@ -274,7 +274,7 @@ test_cgroup_filter()
 	fi

 	cgroup=$(cat "${result}" | awk '{ print $3 }')
-	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging > /dev/null 2> ${result}
+	perf lock con -a -b -g -E 1 -G "${cgroup}" -q -- perf bench sched messaging -p > /dev/null 2> ${result}
 	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
 		echo "[Fail] BPF result should have a result with cgroup filter:" "$(cat "${cgroup}")"
 		err=1
@@ -309,7 +309,7 @@ test_csv_output()
 	fi

 	# the perf lock contention output goes to the stderr
-	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging > /dev/null 2>&1
+	perf lock con -a -b -E 1 -x , --output ${result} -- perf bench sched messaging -p > /dev/null 2>&1
 	output=$(grep -v "^#" ${result} | tr -d -c , | wc -c)
 	if [ "${header}" != "${output}" ]; then
 		echo "[Fail] BPF result does not match the number of commas: ${header} != ${output}"
--
2.48.1

