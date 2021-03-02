Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42991C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E320464E90
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Mar 2021 05:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhCCFDM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 00:03:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351150AbhCBNcx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 Mar 2021 08:32:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122D9UEg123988;
        Tue, 2 Mar 2021 08:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=B7QvNdz9JIbVex4ApMnvbHorcJfu+NDYlHxR3nM7NlI=;
 b=N0IeWVEmlc/c1apHBCz8a3RvGVZwhZgncbb0fBECpkJZgqNmHzsPj/9kau0g4KkWHA49
 RozHJz7Ox/o2/GB+zQy9V6X+FynFq19kee4xx+PwYW33d9IdGIibfc8nt0SBO/aQbyNw
 qtYJA10GAfoe2k46I2OOYVARuoR7w5qvJMTEV10ZvmLep9ftNS+tkfhAlF8Mu7vfM3v5
 iMz5GeeSisePg6CD01qXmajuOXmxh4ExCKbZRJQojjp3rK9Sfl1yWwfwTGTIvvEzB02C
 NTT3Z7A7GMH/ramWxpA8Qj3KBMwGA0CH/e4Nm92FZuPVt3UAEiEsjzZ+GLN+O8ZnbtBe 4A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 371n8v20c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 08:31:35 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 122DO1MJ006228;
        Tue, 2 Mar 2021 13:31:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 37150crd14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 13:31:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 122DVUO741812476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Mar 2021 13:31:30 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CF0852050;
        Tue,  2 Mar 2021 13:31:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 30D4E52051;
        Tue,  2 Mar 2021 13:31:30 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        heiko.carstens@de.ibm.com, kan.liang@linux.intel.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Test case 27 fails on s390 and non-x86 platforms
Date:   Tue,  2 Mar 2021 14:31:19 +0100
Message-Id: <20210302133119.3325530-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103020107
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Executing perf test 27 fails on s390:
 [root@t35lp46 perf]# ./perf test -Fv 27
 27: Sample parsing
 --- start ---
 ---- end ----
 Sample parsing: FAILED!
 [root@t35lp46 perf]#

The root cause is
commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")
This commit introduced a test case for PERF_SAMPLE_WEIGHT_STRUCT
but does not adjust non-x86 weak linkage functions.

The error is in test__sample_parsing() --> do_test()
Function do_test() defines two structures of type struct perf_sample named
sample and sample_out. The first sets member sample.ins_lat = 117

Structure sample_out is constructed dynamically using functions
perf_event__synthesize_sample() and evsel__parse_sample().
Both functions have an x86 specific function version which sets member
ins_lat. The weak common functions do not set member ins_lat.

Later in function samples_same() both data in variable sample and sample_out
are compared. The comparison fails because sample.ins_lat is 117
and samples_out.ins_lat is 0, the weak functions never set member ins_lat.

Output after:
 [root@t35lp46 perf]# ./perf test -Fv 27
 27: Sample parsing
 --- start ---
 ---- end ----
 Sample parsing: Ok
[root@t35lp46 perf]#

Fixes:
commit c7444297fd3769 ("perf test: Support PERF_SAMPLE_WEIGHT_STRUCT")

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/evsel.c            | 8 +++++---
 tools/perf/util/synthetic-events.c | 6 +++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1bf76864c4f2..c9efed5c173d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2106,10 +2106,12 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
 }
 
 void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
-					  const __u64 *array,
-					  u64 type __maybe_unused)
+					  const __u64 *array, u64 type)
 {
-	data->weight = *array;
+	if (type & PERF_SAMPLE_WEIGHT)
+		data->weight = *array & 0xffffffff;
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT)
+		data->ins_lat = (*array >> 32) & 0xffff;
 }
 
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index b698046ec2db..af7ecbc57cbe 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1507,9 +1507,13 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 }
 
 void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
-					       __u64 *array, u64 type __maybe_unused)
+					       __u64 *array, u64 type)
 {
 	*array = data->weight;
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		*array &= 0xffffffff;
+		*array |= ((u64)data->ins_lat << 32);
+	}
 }
 
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
-- 
2.29.2

