Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52404C433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 12:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3279F61139
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 12:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbhJPMxi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 08:53:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240423AbhJPMxe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 16 Oct 2021 08:53:34 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19GCoplP015190;
        Sat, 16 Oct 2021 08:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dE+qsRj/XqrO/eHsnSxHWFY7i+yedT2V9nLllEP4mko=;
 b=jZiJ11Ts5fFmlAiecCpjKnkbBshU6yCyf+OpDSfHiQ0wBhHxv8gWptpQtrY+anRBSH4X
 76Vjx434Q/59lqmTySDPJsxo4sMeYbv+z2ZgxebuwUO6QmbyrhOomM/APMuK4CFRNLP9
 GhUyCH8lsA+6SXisauo/t9B4u+dIp/CM1xO+TrGaA0pKoddFwTq+Cr5UIXjG6f6gWyQk
 sWQtr3eE7dagpDNxH+ERcuXz0ZsTjljDSz/MTff1I4t1qA2EIR/ULcYS6O6BD9FRI20D
 XO0pOdUEUI7SHAFZkjV88PnUnCPqBrzrpyl1wbfkQaId5Ena6fOqW97BKHUDfy0yA3pI hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bqt4pvhyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 08:51:20 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19GCguaG013190;
        Sat, 16 Oct 2021 08:51:20 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bqt4pvhyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 08:51:19 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19GCmES3014297;
        Sat, 16 Oct 2021 12:51:18 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 3bqpcasmn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 12:51:17 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19GCjWFT49938920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 12:45:32 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23B4B5204F;
        Sat, 16 Oct 2021 12:51:14 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.125.40])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6D8145204E;
        Sat, 16 Oct 2021 12:51:11 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 2/2] tools/perf/test: Add endian test for struct branch_flags
Date:   Sat, 16 Oct 2021 18:20:59 +0530
Message-Id: <20211016125059.691856-2-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211016125059.691856-1-maddy@linux.ibm.com>
References: <20211016125059.691856-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AZzhPL_aRoArKkZzqHkybWhC06A2mvhw
X-Proofpoint-GUID: yxoSnlNxdN0UrElJX_AURJoYvnY2hv9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-16_04,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=432 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110160081
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Extend sample-parsing test to include branch_flag
endian-reverse test. Patch include "util/trace-event.h"
to sample-parsing for importing bigendian() and extends
samples_same() to include "needs_swap" to detect/enable
check for endian-swap.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v1:
- Updated commit message

 tools/perf/tests/sample-parsing.c | 43 +++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 8fd8a4ef97da..a67158c12773 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -13,6 +13,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "util/synthetic-events.h"
+#include "util/trace-event.h"
 
 #include "tests.h"
 
@@ -30,9 +31,18 @@
 	}						\
 } while (0)
 
+/*
+ * Hardcode the expected values for branch_entry flags.
+ * These are based on the input value (213) specified
+ * in branch_stack variable.
+ */
+#define BS_EXPECTED_BE	0xa00d000000000000
+#define BS_EXPECTED_LE	0xd5000000
+#define FLAG(s)	s->branch_stack->entries[i].flags
+
 static bool samples_same(const struct perf_sample *s1,
 			 const struct perf_sample *s2,
-			 u64 type, u64 read_format)
+			 u64 type, u64 read_format, bool needs_swap)
 {
 	size_t i;
 
@@ -100,8 +110,14 @@ static bool samples_same(const struct perf_sample *s1,
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		COMP(branch_stack->nr);
 		COMP(branch_stack->hw_idx);
-		for (i = 0; i < s1->branch_stack->nr; i++)
-			MCOMP(branch_stack->entries[i]);
+		for (i = 0; i < s1->branch_stack->nr; i++) {
+			if (needs_swap)
+				return ((bigendian()) ?
+					(FLAG(s2).value == BS_EXPECTED_BE) :
+					(FLAG(s2).value == BS_EXPECTED_LE));
+			else
+				MCOMP(branch_stack->entries[i]);
+		}
 	}
 
 	if (type & PERF_SAMPLE_REGS_USER) {
@@ -248,7 +264,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		},
 	};
 	struct sample_read_value values[] = {{1, 5}, {9, 3}, {2, 7}, {6, 4},};
-	struct perf_sample sample_out;
+	struct perf_sample sample_out, sample_out_endian;
 	size_t i, sz, bufsz;
 	int err, ret = -1;
 
@@ -313,12 +329,29 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		goto out_free;
 	}
 
-	if (!samples_same(&sample, &sample_out, sample_type, read_format)) {
+	if (!samples_same(&sample, &sample_out, sample_type, read_format, evsel.needs_swap)) {
 		pr_debug("parsing failed for sample_type %#"PRIx64"\n",
 			 sample_type);
 		goto out_free;
 	}
 
+	if (sample_type == PERF_SAMPLE_BRANCH_STACK) {
+		evsel.needs_swap = true;
+		evsel.sample_size = __evsel__sample_size(sample_type);
+		err = evsel__parse_sample(&evsel, event, &sample_out_endian);
+		if (err) {
+			pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
+				 "evsel__parse_sample", sample_type, err);
+			goto out_free;
+		}
+
+		if (!samples_same(&sample, &sample_out_endian, sample_type, read_format, evsel.needs_swap)) {
+			pr_debug("parsing failed for sample_type %#"PRIx64"\n",
+				 sample_type);
+			goto out_free;
+		}
+	}
+
 	ret = 0;
 out_free:
 	free(event);
-- 
2.31.1

