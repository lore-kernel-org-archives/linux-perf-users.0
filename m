Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF186207E07
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502407; cv=none; b=a472tBr021dV0D80QlsbXC57DCNgzdMyCotgrgN/vBEeTPJCCa31YR30Sg98PA0dmRc2ta2/UrcCASUPO+qmfaEotmIHZbSdOGzI2rXRZuh8A/i03lbFSFhCv/4IO6ItUib4O/jbYtjhqdJ5rwKAJ+hk68zbR5mL3zfpWZYal6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502407; c=relaxed/simple;
	bh=1uWp3NnObQR1vNt+mY2wiSwOpghm22UY+j9Oz6k94H0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nKvQHBDDoYUn3+JdfvQ9GYrfiAOIf0PpZ5GP4bKUxxRfSnITQLm6PENAvwHUkgVYMn4qbB+NneD0xQ+7dzmMNZGU4zS3i+ZyRstn6aqyo8h/eC1ThYU8U2KWZM3/ofggWHIfq7jroVx/oJC+bqooMclT7vwtpCD82PFydUZIw/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KvAUE7Ys; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KvAUE7Ys"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509NwaDt001006;
	Fri, 10 Jan 2025 09:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=4JWTjYaowA2AgNonAIBe8lJAGtBhfrsYvawa/QHC8
	q4=; b=KvAUE7YsQCPNclkljIzfetJyNBX1Qg2ypu8LABVpSCr1gbycX2tC5r4b+
	/KCGNoRGilTzVV1GwTgS14YgTWobre0jHlJwEO35nnB/WBN0//HLpmfbBvuanSyf
	IgceTDdlCibWugAhZNmnsL3znvQcKzVkLfK4UDtGU0tDOHULazNPCxdmTbZknpOI
	tEnwTOzF/6R1EwDhN8iqfWWPWMcrkNKfOl/EzguL5LkG8m2uGoPpq9Z/b75Ih7oh
	u1khM5WP2QRvfY56Cer3DaNA9BU17KCxHYLQZ9G1ynXk3fAvUYxtOtr3SSsV1WS0
	vmZQ+xvOSvOC1Zq1sSByxEoztH/7g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhsw9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:46:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50A9kapV002070;
	Fri, 10 Jan 2025 09:46:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 442rkhsw9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:46:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50A8iUB4008851;
	Fri, 10 Jan 2025 09:46:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq09qc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 09:46:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50A9kV1E52363666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jan 2025 09:46:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 432882004B;
	Fri, 10 Jan 2025 09:46:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFD0820040;
	Fri, 10 Jan 2025 09:46:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.241.17])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 10 Jan 2025 09:46:23 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org, ravi.bangoria@amd.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com,
        Tejas Manhas <Tejas.Manhas1@ibm.com>
Subject: [PATCH] tools/perf/tests: Update event_groups test to use instructions as one of the sibling event for hw type
Date: Fri, 10 Jan 2025 15:16:20 +0530
Message-Id: <20250110094620.94976-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hEbtGVwie3N2lI0JA3J0jDAvhZ0lc9XZ
X-Proofpoint-GUID: ESjg9RtrWE0iJLPkB0G2M0If43vudTMQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100078

In some of the powerpc platforms, event group testcase fails as below:

   # perf test -v 'Event groups'
   69: Event groups                                                    :
   --- start ---
   test child forked, pid 9765
   Using CPUID 0x00820200
   Using hv_24x7 for uncore pmu event
   0x0 0x0, 0x0 0x0, 0x0 0x0: Fail
   0x0 0x0, 0x0 0x0, 0x1 0x3: Pass

The testcase creates various combinations of hw, sw and uncore
PMU events and verify group creation succeeds or fails as expected.
This tests one of the limitation in perf where it doesn't allow
creating a group of events from different hw PMUs.

The testcase starts a leader event and opens two sibling events.
The combination the fails is three hardware events in a group.
"0x0 0x0, 0x0 0x0, 0x0 0x0: Fail"

Type zero and config zero which translates to PERF_TYPE_HARDWARE
and PERF_COUNT_HW_CPU_CYCLE. There is event constraint in powerpc
that events using same counter cannot be programmed in a group.
Here there is one alternative event for cycles, hence one leader
and only one sibling event can go in as a group.

if all three events (leader and two sibling events), are hardware
events, use instructions as one of the sibling event. Since
PERF_COUNT_HW_INSTRUCTIONS is a generic hardware event and present
in all architectures, use this as third event.

Reported-by: Tejas Manhas <Tejas.Manhas1@ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/event_groups.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/event_groups.c b/tools/perf/tests/event_groups.c
index ccd9d8b2903f..c119ff114948 100644
--- a/tools/perf/tests/event_groups.c
+++ b/tools/perf/tests/event_groups.c
@@ -10,9 +10,10 @@
 #include "header.h"
 #include "../perf-sys.h"
 
-/* hw: cycles, sw: context-switch, uncore: [arch dependent] */
+/* hw: cycles,instructions sw: context-switch, uncore: [arch dependent] */
 static int types[] = {0, 1, -1};
 static unsigned long configs[] = {0, 3, 0};
+static unsigned long configs_hw[] = {1};
 
 #define NR_UNCORE_PMUS 5
 
@@ -93,7 +94,18 @@ static int run_test(int i, int j, int k)
 		return erroneous ? 0 : -1;
 	}
 
-	sibling_fd2 = event_open(types[k], configs[k], group_fd);
+	/*
+	 * if all three events (leader and two sibling events)
+	 * are hardware events, use instructions as one of the
+	 * sibling event. There is event constraint in powerpc that
+	 * events using same counter cannot be programmed in a group.
+	 * Since PERF_COUNT_HW_INSTRUCTIONS is a generic hardware
+	 * event and present in all platforms, lets use that.
+	 */
+	if (!i && !j && !k)
+		sibling_fd2 = event_open(types[k], configs_hw[k], group_fd);
+	else
+		sibling_fd2 = event_open(types[k], configs[k], group_fd);
 	if (sibling_fd2 == -1) {
 		close(sibling_fd1);
 		close(group_fd);
@@ -124,9 +136,18 @@ static int test__event_groups(struct test_suite *text __maybe_unused, int subtes
 				if (r)
 					ret = TEST_FAIL;
 
-				pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
-					 types[i], configs[i], types[j], configs[j],
-					 types[k], configs[k], r ? "Fail" : "Pass");
+				/*
+				 * For all three events as HW events, second sibling
+				 * event is picked from configs_hw. So print accordingly
+				 */
+				if (!i && !j && !k)
+					pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
+						 types[i], configs[i], types[j], configs[j],
+						 types[k], configs_hw[k], r ? "Fail" : "Pass");
+				else
+					pr_debug("0x%x 0x%lx, 0x%x 0x%lx, 0x%x 0x%lx: %s\n",
+						 types[i], configs[i], types[j], configs[j],
+						 types[k], configs[k], r ? "Fail" : "Pass");
 			}
 		}
 	}
-- 
2.43.5

