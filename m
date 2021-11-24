Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87879C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Nov 2021 09:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhKXJHK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 04:07:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229829AbhKXJHK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 04:07:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO7HON5026892;
        Wed, 24 Nov 2021 09:04:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9Vgz3T9kFl+gBK9ezHEyJYFv2Ykz+cPLVwZrhziGFdI=;
 b=sX6Aic0iN+ADVKW8k/aRTAaSSIRHDCUdBQvUas3c8rozakZXiwIPv0HJQvkFWC8+rGMY
 gjx0AUKadLCHMUba6khsHqUmrzfcb4TDf/0JqvbPANhzeW/MtJpDKKX8DHK8vLXYBcDl
 HAUUpmktrmnaSJh69Hhljd82eMjeuhsVhGPpXsoun0gxjI7vXIBn5u1NkfpxmrTnZ872
 VZQt2/n3pEUCy5gpUbpXrD6Hq/JKQ8KE3IaE2bpe+ELkQblwb7pAVOsrRPflVsd/bVJt
 BfBv2hEMFEzYzuXDv3No/4jLLQdWv5TEUB8MBacZ4lfy72VacnAs8voKtSuiW9aVMPvZ xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chgvft1c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 09:03:59 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AO8otH8002746;
        Wed, 24 Nov 2021 09:03:59 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chgvft1bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 09:03:59 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO93B9E025080;
        Wed, 24 Nov 2021 09:03:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3cer9jyhtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 09:03:56 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO8uhhL28115212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 08:56:43 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5F684C058;
        Wed, 24 Nov 2021 09:03:53 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B65A4C05A;
        Wed, 24 Nov 2021 09:03:53 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 09:03:53 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] tools/perf: Fix perf test 7 Simple expression parser on s390
Date:   Wed, 24 Nov 2021 10:03:43 +0100
Message-Id: <20211124090343.9436-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Cfx5rNvz7yPCWnY13h6ILxo8OyUx3DwZ
X-Proofpoint-ORIG-GUID: QyeHBjpnVYmEYaYqDZ5hpCJtRGkNUVpV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_03,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240050
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Commit fdf1e29b6118 ("perf expr: Add metric literals for topology.")
fails on s390:
 # ./perf test -Fv 7
   ...
 # FAILED tests/expr.c:173 #num_dies >= #num_packages
   ---- end ----
   Simple expression parser: FAILED!
 #

Investigating this issue leads to these functions:
 build_cpu_topology()
   +--> has_die_topology(void)
        {
           struct utsname uts;

           if (uname(&uts) < 0)
                  return false;
           if (strncmp(uts.machine, "x86_64", 6))
                  return false;
           ....
        }

which always returns false on s390. The caller build_cpu_topology()
checks has_die_topology() return value. On false the
the struct cpu_topology::die_cpu_list is not contructed and has zero
entries. This leads to the failing comparison: #num_dies >= #num_packages.
s390 of course has a positive number of packages.

Fix this by adding s390 architecture to support CPU die list.

Output after:
 # ./perf test -Fv 7
  7: Simple expression parser                                        :
  --- start ---
  division by zero
  syntax error
  ---- end ----
  Simple expression parser: Ok
 #
Cc: Ian Rogers <irogers@google.com>
Fixes: fdf1e29b6118 ("perf expr: Add metric literals for topology.")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/cputopo.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
index 51b429c86f98..aad7a9e6e31b 100644
--- a/tools/perf/util/cputopo.c
+++ b/tools/perf/util/cputopo.c
@@ -165,7 +165,8 @@ static bool has_die_topology(void)
 	if (uname(&uts) < 0)
 		return false;
 
-	if (strncmp(uts.machine, "x86_64", 6))
+	if (strncmp(uts.machine, "x86_64", 6) &&
+	    strncmp(uts.machine, "s390x", 5))
 		return false;
 
 	scnprintf(filename, MAXPATHLEN, DIE_CPUS_FMT,
-- 
2.31.1

