Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D3C19DF66
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Oct 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605760; cv=none; b=g73dPKnBFb/bpenL7DAO2hIbX+baWYZvOKMpOHdJG28W4pEABTeHwsl6j/kPd2ZHGSCh7PxyElKfIYYvEynsZSOAGUInN4drbdX+0lOcpb3Xcv9xNs+aLTbCcVDx38UzftvfRvzoReKdiQ3YFrp97VEIV7EffOBlZbdxWxW2Yao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605760; c=relaxed/simple;
	bh=hpLsc0JEC3wN00MIXWOfsCFzbBmVLnlyvgd52nzEQe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4f5Oc24KClM34n7BJlkaP11A4jjoAuN92+8dXkeFZzH83TgsOIxFLp/MlrSKLOz39NQMNu8wDIHYyiUPXDVevei7015CSoc8E2AeCCbFBHxqreOXuu025+5xSjzSI1rfG8SZgWsHt8yuXPwzFG/eZrXQUsp+6V1o2ll3xtR2Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=I3yZbDY6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="I3yZbDY6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M2HBbF005317;
	Tue, 22 Oct 2024 14:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=So3Twn6QWsG4soDWWAYO4es+YvEJgvYZXhZybm9gF
	wo=; b=I3yZbDY6Bc4Tq/FiYULcZujdzZOrAMgiv77cUhOmHfjvbS56ttYmUdu/h
	eWRm2Gtn/bBaK0lke+is/Clox7taIB6lnHzBTg58/NmxUVJol0s2Xi0rrHcu1qpi
	AzFIlGs8AeBi4dAdQbRwiHCqGLcH6A7I4shxpjsOY/nGxNxF4O7e0hGpBr+jJbjt
	L7ALuTRkxKK4nhaZhITBs+VF3IbKR/GbyimtwhL1dhgv3PKJ34cGExrT1HHh1Lb2
	iueV2T1e+e7C8X+RsJaUeQ3Q7oqLPgAFfAoG+uWiZv59+zzy2s0PWHjUDie/vkQA
	sr66lvxpHuVmPlR+67A0i8jhGvm3Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcp808-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 14:02:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49ME06i7008584;
	Tue, 22 Oct 2024 14:02:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5fcp806-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 14:02:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MAh8AO018590;
	Tue, 22 Oct 2024 14:02:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42csajb7qc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 14:02:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49ME2Fmt50528722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:02:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82DC02004B;
	Tue, 22 Oct 2024 14:02:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E3CF20040;
	Tue, 22 Oct 2024 14:02:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.248.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 14:02:04 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        akanksha@linux.ibm.com, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: [PATCH] tools/perf/tests/expr: Make the system_tsc_freq test only for intel
Date: Tue, 22 Oct 2024 19:31:56 +0530
Message-Id: <20241022140156.98854-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O02VkF2NcBu12s6_V8_f6krF4iBkKYgF
X-Proofpoint-GUID: CUQtrUpKoybBGq58DZ8aLjOr6o8eANhz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220087

The "Simple expression parser" test fails on powerpc
as below:

 parsing metric: #system_tsc_freq
 Unrecognized literal '#system_tsc_freq'literal: #system_tsc_freq = nan
 syntax error
 FAILED tests/expr.c:247 #system_tsc_freq
 ---- end(-1) ----
 7: Simple expression parser  : FAILED!

In the test, system_tsc_freq is checked as below:

 if (is_intel)
    TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
 else

But commit 609aa2667f67 ("perf tool_pmu: Switch to standard
pmu functions and json descriptions")' changed condition in
tool_pmu__skip_event so that system_tsc_freq event should
only appear on x86

 +#if !defined(__i386__) && !defined(__x86_64__)
 +       /* The system_tsc_freq event should only appear on x86. */
 +       if (strcasecmp(name, "system_tsc_freq") == 0)
 +               return true;
 +#endif

After this commit, the testcase breaks for expr__parse of
system_tsc_freq in powerpc case. Fix the testcase to have
complete system_tsc_freq test within "is_intel" check.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/expr.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index e3aa9d4fcf3a..eb3bd68fc4ce 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -244,11 +244,10 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	if (num_dies) // Some platforms do not have CPU die support, for example s390
 		TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
 
-	TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
-	if (is_intel)
+	if (is_intel) {
+		TEST_ASSERT_VAL("#system_tsc_freq", expr__parse(&val, ctx, "#system_tsc_freq") == 0);
 		TEST_ASSERT_VAL("#system_tsc_freq > 0", val > 0);
-	else
-		TEST_ASSERT_VAL("#system_tsc_freq == 0", fpclassify(val) == FP_ZERO);
+	}
 
 	/*
 	 * Source count returns the number of events aggregating in a leader
-- 
2.43.5

