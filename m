Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DDC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9DB61058
	for <linux-perf-users@archiver.kernel.org>; Sat, 16 Oct 2021 12:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhJPMxd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 16 Oct 2021 08:53:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236685AbhJPMxc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 16 Oct 2021 08:53:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19G7CB5U015202;
        Sat, 16 Oct 2021 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Fyon+M6XTQkos0JsrDloHJf/JXpOExcV3gxMociKpPo=;
 b=AnsNK0n8DfTk2+CCMoGtjSxv8R3IQOlqZComSjIbcW14hG2eY618rBi0GyRzwqGb375L
 c2MHVJIykSlTcmyOXTYz5KttTCRra/4J9m3gpgx3H0nrjqbBxtR0ZU5tdgdaVly6FdlE
 3rtRXvq//POE4wNn5ImfQHJBsdAZxmQNqT3zX51MykpZCck2P+j2Wx2ODm3Mf9DUvlcr
 6YOmElEgXSCFu0ilYylDTHPw+Bjqhg/LA2Q3KQdSM/0BjYamyHNj4Vy3qzhR4cyZOkpp
 cHBu1cf0beFPCeMUxGyF1/I22j9txhv7mOQN0M7O029hPBHBLucShTc4hruRP5i4Hgsr 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bqt4pvhy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 08:51:16 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19GClQJU028809;
        Sat, 16 Oct 2021 08:51:15 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bqt4pvhxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 08:51:15 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19GCmQNW023716;
        Sat, 16 Oct 2021 12:51:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bqp0j1ug7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Oct 2021 12:51:13 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19GCpA5u64028980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 12:51:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B2415204E;
        Sat, 16 Oct 2021 12:51:10 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.125.40])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A2A1A5204F;
        Sat, 16 Oct 2021 12:51:07 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 1/2] tools/perf: Add bitfield_swap to handle branch_stack endian issue
Date:   Sat, 16 Oct 2021 18:20:58 +0530
Message-Id: <20211016125059.691856-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: N0EML5LbXYzR2-YSVMDU1sEC8jAw6drv
X-Proofpoint-GUID: x-G_Va7AYL0hD2iEw9lPDKnYybU96HQL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-16_04,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=664 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110160081
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

branch_stack struct has bit field definition which
produces different bit ordering for big/little endian.
Because of this, when branch_stack sample is collected
in a BE system and viewed/reported in a LE system, bit
fields of the branch stack are not presented properly.
To address this issue, a evsel__bitfield_swap_branch_stack()
is defined and introduced in evsel__parse_sample.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
Changelog v1:
- Renamed function and macro
- Added comments in code

 tools/perf/util/evsel.c | 74 +++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.h | 13 ++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..746e642d4d32 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2221,6 +2221,51 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
 	data->weight = *array;
 }
 
+u64 evsel__bitfield_swap_branch_flags(u64 value)
+{
+	u64 new_val = 0;
+
+	/*
+	 * branch_flags
+	 * union {
+	 * 	u64 values;
+	 * 	struct {
+	 * 		mispred:1	//target mispredicted
+	 * 		predicted:1	//target predicted
+	 * 		in_tx:1		//in transaction
+	 * 		abort:1		//transaction abort
+	 * 		cycles:16	//cycle count to last branch
+	 * 		type:4		//branch type
+	 * 		reserved:40
+	 * 	}
+	 * }
+	 *
+	 * Avoid bswap64() the entire branch_flag.value,
+	 * as it has variable bit-field sizes. Instead the
+	 * macro takes the bit-field position/size,
+	 * swaps it based on the host endianness.
+	 */
+	if (bigendian()) {
+		new_val = bitfield_swap(value, 0, 1);
+		new_val |= bitfield_swap(value, 1, 1);
+		new_val |= bitfield_swap(value, 2, 1);
+		new_val |= bitfield_swap(value, 3, 1);
+		new_val |= bitfield_swap(value, 4, 16);
+		new_val |= bitfield_swap(value, 20, 4);
+		new_val |= bitfield_swap(value, 24, 40);
+	} else {
+		new_val = bitfield_swap(value, 63, 1);
+		new_val |= bitfield_swap(value, 62, 1);
+		new_val |= bitfield_swap(value, 61, 1);
+		new_val |= bitfield_swap(value, 60, 1);
+		new_val |= bitfield_swap(value, 44, 16);
+		new_val |= bitfield_swap(value, 40, 4);
+		new_val |= bitfield_swap(value, 0, 40);
+	}
+
+	return new_val;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -2408,6 +2453,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		const u64 max_branch_nr = UINT64_MAX /
 					  sizeof(struct branch_entry);
+		struct branch_entry *e;
+		unsigned int i;
 
 		OVERFLOW_CHECK_u64(array);
 		data->branch_stack = (struct branch_stack *)array++;
@@ -2416,10 +2463,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			return -EFAULT;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
-		if (evsel__has_branch_hw_idx(evsel))
+		if (evsel__has_branch_hw_idx(evsel)) {
 			sz += sizeof(u64);
-		else
+			e = &data->branch_stack->entries[0];
+		} else {
 			data->no_hw_idx = true;
+			/*
+			 * if the PERF_SAMPLE_BRANCH_HW_INDEX is not applied,
+			 * only nr and entries[] will be output by kernel.
+			 */
+			e = (struct branch_entry *)&data->branch_stack->hw_idx;
+		}
+
+		if (swapped) {
+			/*
+			 * struct branch_flag does not have endian
+			 * specific bit field definition. And bswap
+			 * will not resolve the issue, since these
+			 * are bit fields.
+			 *
+			 * evsel__bitfield_swap_branch_flags() uses a
+			 * bitfield_swap macro to swap the bit position
+			 * based on the host endians.
+			 */
+			for (i = 0; i < data->branch_stack->nr; i++, e++)
+				e->flags.value = evsel__bitfield_swap_branch_flags(e->flags.value);
+		}
+
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..2e82cdbe2c08 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -482,4 +482,17 @@ struct evsel *evsel__leader(struct evsel *evsel);
 bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
+
+/*
+ * Macro to swap the bit-field postition and size.
+ * Used when,
+ * - dont need to swap the entire u64 &&
+ * - when u64 has variable bit-field sizes &&
+ * - when presented in a host endian which is different
+ *   than the source endian of the perf.data file
+ */
+#define bitfield_swap(src, pos, size)	\
+	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
+
+u64 evsel__bitfield_swap_branch_flags(u64 value);
 #endif /* __PERF_EVSEL_H */
-- 
2.31.1

