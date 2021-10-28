Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC35EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976C860249
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhJ1LkH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:40:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60132 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1LkG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 07:40:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SApiRf027220;
        Thu, 28 Oct 2021 11:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mpKZsVC7bkqUHWPdhUOP1i5WrUtVyGSY/LjQMqONk40=;
 b=eCtdqseywteDJBLcESe3aGUSCOPWs0ARVg/H0LAItYKCNSNFdQKD4/raCZiv+yY85K+0
 q24cFmfUUwnJiigLGQDwsMIyIFh5EaCBHMt5YN871grTQr5UzMhgy1YHLmspZdYs2WpJ
 ptRtygmJYR9VnjO6vRxr69IHyE7rew9S0TIEaNlqsCvfzg5xrOklRUtsm8SCwvWb4hv4
 24Gx/11Tzxo750cf/3pnRCzGl1M6ZVFzQ8lMJy6RgaQDgQJvbVRuIHwpGwG/bydvSvH4
 25x2NlBmVcyYdb2tfKmGV42eDLexr6EUrv+n00lSCvY+FXgjZFKFkIVqz8KToE+X6T+1 iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bytfwrvkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:33 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19SBTScW026092;
        Thu, 28 Oct 2021 11:37:33 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bytfwrvjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:33 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19SBX3a7029551;
        Thu, 28 Oct 2021 11:37:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bx4f1rj4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19SBbR9A60293376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 11:37:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8338F4204F;
        Thu, 28 Oct 2021 11:37:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8226F4204B;
        Thu, 28 Oct 2021 11:37:23 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.61.213])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 11:37:23 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v3 2/2] tools/perf/test: Add endian test for struct branch_flags
Date:   Thu, 28 Oct 2021 17:07:14 +0530
Message-Id: <20211028113714.600549-2-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211028113714.600549-1-maddy@linux.ibm.com>
References: <20211028113714.600549-1-maddy@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HxSzh0wFoOJCXjfhmR_zxrwG1eQB9_u-
X-Proofpoint-ORIG-GUID: pr32ZE8GJOhHxCnTsBziQkuBgwNqGWVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 mlxscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=431
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110280063
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Extend sample-parsing test to include branch_flag
bitfield-endian swap test. Patch include "util/trace-event.h"
to sample-parsing for importing tep_is_bigendian() and
extends samples_same() to include "needs_swap" to
detect/enable check for bitfield-endian swap.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v2:
- used tep_is_bigendian() instead bigendian()
  to avoid perf test python fail.
- Updated commit message

Changelog v1:
- Updated commit message

 tools/perf/tests/sample-parsing.c | 43 +++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 8fd8a4ef97da..c83a11514129 100644
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
+				return ((tep_is_bigendian()) ?
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

