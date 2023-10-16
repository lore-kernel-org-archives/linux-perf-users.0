Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425828E0E
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FkFtb+4X"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F829C
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Oct 2023 07:32:10 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GEPfA2017437;
	Mon, 16 Oct 2023 14:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cnFwgAHbcvlYX6GO0i+0qi7rbOdXKLz6agt5dSZ3D0s=;
 b=FkFtb+4Xl1uinIy9j69gclz52auLxAzeGN3/5+6A3rXQ4PSJ60u8b5+GmcBOGMBY7AYK
 qdThfmV4ieNkh04bnA0j+/7mtKRsUaRDL6oT+qsEURUyy0nRdCPC9VPhFgEg9SR1wsno
 MyQizvlQMiiUvQwH+BL4ywqm8tlV0F8mZ5h2i3glZIhTywntjF71CvaSS3YSsrBS+O9s
 6S60VABxYwUXRbcpJvtnEx9hkkzvM4Cwbpti6MSb7qolbaJ76jXipQnrInUCBtAv79sy
 zg62Y8w+2kAQrj5e7qK7w0euxl+rDbRMxzKZ5FRnrTEMLQmt9Xl2X2xaqk0IwAMcA+B2 PA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ts6x209k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Oct 2023 14:32:06 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39GCDXJd012850;
	Mon, 16 Oct 2023 14:32:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tr5py1j2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Oct 2023 14:32:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39GEW2MG22807282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Oct 2023 14:32:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 261A120043;
	Mon, 16 Oct 2023 14:32:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2437C20040;
	Mon, 16 Oct 2023 14:32:00 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.179.8.233])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Oct 2023 14:31:59 +0000 (GMT)
From: Kajol Jain <kjain@linux.ibm.com>
To: acme@kernel.org
Cc: maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, disgoel@linux.ibm.com,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, Disha Goel <disgoel@linux.vnet.ibm.com>
Subject: [PATCH] perf vendor events: Update PMC used in PM_RUN_INST_CMPL event for power10 platform
Date: Mon, 16 Oct 2023 20:01:10 +0530
Message-Id: <20231016143110.244255-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bbwBm1PQzCm1QTEGMFhPMWNjWJBZYlNt
X-Proofpoint-GUID: bbwBm1PQzCm1QTEGMFhPMWNjWJBZYlNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_07,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The CPI_STALL_RATIO metric group can be used to present the high
level CPI stall breakdown metrics in powerpc, which will show:

- DISPATCH_STALL_CPI ( Dispatch stall cycles per insn )
- ISSUE_STALL_CPI ( Issue stall cycles per insn )
- EXECUTION_STALL_CPI ( Execution stall cycles per insn )
- COMPLETION_STALL_CPI ( Completion stall cycles per insn )

Commit cf26e043c2a9 ("perf vendor events power10: Add JSON
metric events to present CPI stall cycles in powerpc)" which added
the CPI_STALL_RATIO metric group, also modified
the PMC value used in PM_RUN_INST_CMPL event from PMC4 to PMC5, 
to avoid multiplexing of events.
But that got revert in recent changes. Fix this issue by changing
back the PMC value used in PM_RUN_INST_CMPL to PMC5.

Result with the fix:

 ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>

 Performance counter stats for 'workload':

        68,745,426      PM_CMPL_STALL                    #     0.21 COMPLETION_STALL_CPI
         7,692,827      PM_ISSUE_STALL                   #     0.02 ISSUE_STALL_CPI
       322,638,223      PM_RUN_INST_CMPL                 #     0.05 DISPATCH_STALL_CPI
                                                  #     0.48 EXECUTION_STALL_CPI
        16,858,553      PM_DISP_STALL_CYC
       153,880,133      PM_EXEC_STALL

       0.089774592 seconds time elapsed

"--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be scheduled
in all group for more accuracy.

Fixes: 7d473f475b2a ("perf vendor events: Move JSON/events to appropriate files for power10 platform")
Reported-by: Disha Goel <disgoel@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/pmu-events/arch/powerpc/power10/pmc.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
index c606ae03cd27..0e0253d0e757 100644
--- a/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
+++ b/tools/perf/pmu-events/arch/powerpc/power10/pmc.json
@@ -195,7 +195,7 @@
     "BriefDescription": "Threshold counter exceeded a value of 128."
   },
   {
-    "EventCode": "0x400FA",
+    "EventCode": "0x500FA",
     "EventName": "PM_RUN_INST_CMPL",
     "BriefDescription": "PowerPC instruction completed while the run latch is set."
   }
-- 
2.39.3

