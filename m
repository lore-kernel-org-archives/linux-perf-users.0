Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2E9CA4D
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Oct 2023 05:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lCKrDAxm"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6080A4
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Oct 2023 22:01:14 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3994qvY7008922;
	Mon, 9 Oct 2023 05:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=sDUoyabGWzxEWBrtwJTyKu0PQ2CG1WGLjVTsX0Hb108=;
 b=lCKrDAxmlgWaAMMXP4YMGzR0tMXqWquN+yhpolWkznncXEtoEdBuC6HSMEXIWpGwELLX
 IWN0uqLLN+wNfKhm4oDVuh0TiECD3Pm1qb2PKukPub4AH0uyI7CScWWGrWzlHmoxdXl6
 WJim4wSDFvc5w4AV4vrfjX3JWgnQ/v4VHKL/eTlDOIrhPgpdOjGAKkukxi/cC3nHYIVh
 DQvS/FR+s0Kd5eHmf52HeSo7OJ4OYZJ7LmOyM6sqZra/Kvgasbm/5lRQumXmsIFsy5kA
 t4uwBiwGukacMYi4PumC2z6vUkj+ncAn2UXwltRxnWxTypVW0M2U5ISMMTNL0HFpSGzr qA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmaver4pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Oct 2023 05:01:01 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3994tMpw015101;
	Mon, 9 Oct 2023 05:01:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmaver4p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Oct 2023 05:01:01 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3994wjgK024461;
	Mon, 9 Oct 2023 05:01:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhns71w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Oct 2023 05:01:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39950vJC19202608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Oct 2023 05:00:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 623A420040;
	Mon,  9 Oct 2023 05:00:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7811820043;
	Mon,  9 Oct 2023 05:00:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.22.224])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Oct 2023 05:00:55 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH] tools/perf/arch/powerpc: Fix the CPU ID const char* value by adding 0x prefix
Date: Mon,  9 Oct 2023 10:30:52 +0530
Message-Id: <20231009050052.64935-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zm9QGSD8uTZJVnfacC3qvDdtG0ng-aa0
X-Proofpoint-ORIG-GUID: ggYt-NiK_jrT3pR80EwT1n7kmFRIU31H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_03,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090043
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Simple expression parser test fails in powerpc as below:

    4: Simple expression parser
    test child forked, pid 170385
    Using CPUID 004e2102
    division by zero
    syntax error
    syntax error
    FAILED tests/expr.c:65 parse test failed
    test child finished with -1
    Simple expression parser: FAILED!

This is observed after commit:
'commit 9d5da30e4ae9 ("perf jevents: Add a new expression builtin strcmp_cpuid_str()")'

With this commit, a new expression builtin strcmp_cpuid_str
got added. This function takes an 'ID' type value, which is
a string. So expression parse for strcmp_cpuid_str expects
const char * as cpuid value type. In case of powerpc, CPU IDs
are numbers. Hence it doesn't get interpreted correctly by
bison parser. Example in case of power9, cpuid string returns
as: 004e2102

cpuid of string type is expected in two cases:
1. char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);

   Testcase "tests/expr.c" uses "perf_pmu__getcpuid" which calls
   get_cpuid_str to get the cpuid string.

2. cpuid field in  :struct pmu_events_map

   struct pmu_events_map {
           const char *arch;
	   const char *cpuid;

   Here cpuid field is used in "perf_pmu__find_events_table"
   function as "strcmp_cpuid_str(map->cpuid, cpuid)". The
   value for cpuid field is picked from mapfile.csv.

Fix the mapfile.csv and get_cpuid_str function to prefix
cpuid with 0x so that it gets correctly interpreted by
the bison parser

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/header.c          | 2 +-
 tools/perf/pmu-events/arch/powerpc/mapfile.csv | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index c8d0dc775e5d..6b00efd53638 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -34,7 +34,7 @@ get_cpuid_str(struct perf_pmu *pmu __maybe_unused)
 {
 	char *bufp;
 
-	if (asprintf(&bufp, "%.8lx", mfspr(SPRN_PVR)) < 0)
+	if (asprintf(&bufp, "0x%.8lx", mfspr(SPRN_PVR)) < 0)
 		bufp = NULL;
 
 	return bufp;
diff --git a/tools/perf/pmu-events/arch/powerpc/mapfile.csv b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
index a534ff6db14b..f4908af7ad66 100644
--- a/tools/perf/pmu-events/arch/powerpc/mapfile.csv
+++ b/tools/perf/pmu-events/arch/powerpc/mapfile.csv
@@ -13,6 +13,6 @@
 #
 
 # Power8 entries
-004[bcd][[:xdigit:]]{4},1,power8,core
-004e[[:xdigit:]]{4},1,power9,core
-0080[[:xdigit:]]{4},1,power10,core
+0x004[bcd][[:xdigit:]]{4},1,power8,core
+0x004e[[:xdigit:]]{4},1,power9,core
+0x0080[[:xdigit:]]{4},1,power10,core
-- 
2.39.3

