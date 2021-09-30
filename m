Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1FBC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 07:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8454D615E5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 07:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbhI3HGU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:06:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63978 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233661AbhI3HGT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 03:06:19 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U6gK7O021987;
        Thu, 30 Sep 2021 03:04:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q00eudB6gXZxLSoYORbSMIt2sLyq3sde+WvhQ39CBBU=;
 b=Go0UVew+ul8n9PLdFBg5H6omIpN2qANt8lBfC+528iB9eUvl/EuYQnq/NhuYVCQ87dzf
 xGSkHRjBlt6EgvTWOk7iEwHte4vAGNJDlzko8tDaaNDXxnodXhw3nu20VYBiUXvzd3Xt
 lDs2QfSjpFu16ufUB36cpRbyHtqgSKhSqmZoGiukN8gagkmXEWdWG5+vjjl2DzLv3SZM
 0RPrTtFaKv1CWkPKfgofaP4knVpHjJcctgf3YB2vOKfr8wVOhTEmAp7OMFz0ItcAXu15
 NJ6PdfwXG4/OxJI3961g5z0u3xNYiSuLFLIrxTqzGAU3iDydOmJxapQUPMJcfylS54+V YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd86qrg0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 03:04:32 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U6jhgu001508;
        Thu, 30 Sep 2021 03:04:31 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd86qrfyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 03:04:31 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18U727fo009668;
        Thu, 30 Sep 2021 07:04:29 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3b9udag5h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 07:04:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18U6xHi658458532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 06:59:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E46B311C04A;
        Thu, 30 Sep 2021 07:04:24 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EBB211C04C;
        Thu, 30 Sep 2021 07:04:20 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.101.207])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 07:04:20 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 2/2] tools/perf/test: Add endian test for struct branch_flags
Date:   Thu, 30 Sep 2021 12:34:10 +0530
Message-Id: <20210930070410.52703-2-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210930070410.52703-1-maddy@linux.ibm.com>
References: <20210930070410.52703-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G2Zj_TAqG3-2aMfTjFSdbU52BPTjocGp
X-Proofpoint-GUID: g8TTNauH8Q9QQt9CnIxSDesbxlnFt9Je
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_02,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=464 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109300042
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Extend sample-parsing test to include branch_flag
endian-reverse test. Patch include "util/trace-event.h"
to sample-parsing for importing bigendian() and extends
samples_same() to include "needs_swap" to detect/enable
check for endian-reverse.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
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

