Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B45520B7F2
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502240; cv=none; b=JG0zxa2vsPTuE6iH6iYr9u0x8wuV3bG48GPl//cHh/wq+JDs5Y5bP9c3Sv8hD+hdEN0jWm2pVHY1mnrh3ioRWKYS22AKfbc9xUQTrU2lHKmZwGZ+U3uiyboOexbIs+RfyZwrQlebfhYbSuWouaktDgEObrxuzpiHy/yIvtpBirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502240; c=relaxed/simple;
	bh=I0b0D5xtbrRYD2Vif3h/w2iK/wXbNViwsT+ya6rm28s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=If/tw6pXhKBb7kakL4B+R4ob4hXB9D26yx/OFfzX9sWx3Wvq7r1LIcH5Nsj5rp3q5bsTK2cPC1fMtckBsde/nhQccLHRImeIZBK2gvDyR5kF5ZzZfgfd8GoWVcc/sxRTRmCbMU5FkyNOjOexIyIBSzsEV/j1l2setZkViGiG3Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a9ivZtts; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a9ivZtts"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509NaGfW018158;
	Fri, 10 Jan 2025 09:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Q15Qs22smqoIRdd57Er+BBVsac7o
	QoNNAeF9ajmNHjk=; b=a9ivZtts+eZCel7EAVYBohbqWBrjA+zQfuQvLmEME+FW
	5xiiLM6Mqxzq4AUSR/6D5LYHgMaPaswBlpxlsGMzzaKLl8cKLlsL94SBWViJydxx
	M0iOTwo9lRnq+2elhrl8/cOoH3tobBfLFsosY85uMQTHcJS/nRltWRUnJBvZbmew
	Ls2gqLLxqEeYf0/4hdNvFyLSrNGfSUKSU5lv4+TCMjB8aVZ0Iwpabw5HqgyyyTW7
	6ClqykijLbTZI1AxkO8TnkAlcg7X+TvwzxkrjyQxnsQsV4h6qbkU9iWbYCnr7KGI
	gx7pRSyDNKxriP1u+1wM9oZPqHe86FjBuoJ2qAEPlQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9asw7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:43:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50A9efm3013605;
	Fri, 10 Jan 2025 09:43:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442r9asw7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:43:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A9NEBg008974;
	Fri, 10 Jan 2025 09:43:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq09q3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:43:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50A9hYwl21037528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 09:43:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 564FB2004B;
	Fri, 10 Jan 2025 09:43:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C2F20040;
	Fri, 10 Jan 2025 09:43:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.17])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jan 2025 09:43:27 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, vmolnaro@redhat.com,
        mpetlan@redhat.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: [PATCH V2] tools/perf/tests/base_probe: Fix check for the count of existing probes in test_adding_kernel
Date: Fri, 10 Jan 2025 15:13:24 +0530
Message-Id: <20250110094324.94604-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XgF3CVrlekrAvSZ0E1Ww3Ry2vnMElDRM
X-Proofpoint-ORIG-GUID: l2G_PTBcpE4blZkPYnPmoCQgJMFNnW34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501100078

perftool-testsuite_probe fails in test_adding_kernel as below:
	Regexp not found: "probe:inode_permission_11"
	-- [ FAIL ] -- perf_probe :: test_adding_kernel :: force-adding probes ::
	second probe adding (with force) (output regexp parsing)
	event syntax error: 'probe:inode_permission_11'
	  \___ unknown tracepoint

	Error:  File /sys/kernel/tracing//events/probe/inode_permission_11
	not found.
	Hint:   Perhaps this kernel misses some CONFIG_ setting to
	enable this feature?.

The test does the following:
1) Adds a probe point first using :
    $CMD_PERF probe --add $TEST_PROBE
2) Then tries to add same probe again without —force
and expects it to fail. Next tries to add same probe again
with —force. In this case, perf probe succeeds and adds
the probe with a suffix number. Example:

 ./perf probe --add inode_permission
 Added new event:
  probe:inode_permission (on inode_permission)

 ./perf probe --add inode_permission --force
 Added new event:
  probe:inode_permission_1 (on inode_permission)

  ./perf probe --add inode_permission --force
 Added new event:
  probe:inode_permission_2 (on inode_permission)

Each time, suffix is added to existing probe name.
To get the suffix number, test cases uses :
NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`

This will work if there is no other probe existing
in the system. If there are any other probes other than
kernel probes or inode_permission, ( example: any probe),
"perf probe -l" will include count for other probes too.

Example, in the system where this failed, already some
probes were default added. So count became 10
  ./perf probe -l | wc -l
  10

So to be specific for "inode_permission", restrict the
probe count check to that probe point alone using :
NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`

Similarly while removing the probe using "probe --del *",
( removing all probes ), check uses:

 ../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE"

But if there are other probes in the system, the log will
contain reference to other existing probe too. Hence change
usage of check_all_lines_matched.pl to check_all_patterns_found.pl
This will make sure expecting string comes in the result

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 v1 -> v2:
 No code changes. After being reviewed by Michael Petlan, since
 initial patch was posted in 2024-10-14, rebased on top of latest
 perf-tools-next

 tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
index d541ffd44a93..f8b5f096d0d7 100755
--- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
+++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
@@ -169,7 +169,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second pr
 (( TEST_RESULT += $? ))
 
 # adding existing probe with '--force' should pass
-NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`
+NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
 $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
 PERF_EXIT_CODE=$?
 
@@ -205,7 +205,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
 $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
 PERF_EXIT_CODE=$?
 
-../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
+../common/check_all_patterns_found.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
 CHECK_EXIT_CODE=$?
 
 print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"
-- 
2.43.5

