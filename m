Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CEBC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E3760249
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ1LkE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:40:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39674 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229578AbhJ1LkD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 07:40:03 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SAuIk7004020;
        Thu, 28 Oct 2021 11:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=joIPSH0ykY2Qao0fpFQiHTKwQm8KchNNM+xHMAAYZ9Q=;
 b=BWMTZjonZ3mfJ+9qkA3S3jm0AKFUueGTmezUmNNDInQeAamnnCdaAY1pyVmEZBLsj3H1
 6SaNu8xjOaSc/goWVHJ6trC6lpEs6xT9bw40lANMh14l5yqlEu/5XRhSw31i4rQMvMwt
 seu5egPjNBoGQ/XjETIhseJCviCq2zeS9FAaXlbLqjdJy8S6oFJaXwYUQm0dVQ6dO3x9
 4gN4ijogXAz6Nc+Qm3qc9n1XmVv4RV7leWjkAJlnv1ieiFQo8DPXUw8Y3GzL0fqVQXgG
 V50hvGOwOWdIKmEHUA5e1U3fx9fwD2KOvB/DwP8rS7HbAW99VhFybbnoBkL9amQZKtfe jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byra2kne0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:27 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19SBUbGD032477;
        Thu, 28 Oct 2021 11:37:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3byra2kndp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19SBYf4v009961;
        Thu, 28 Oct 2021 11:37:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3bx4etghws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 11:37:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19SBVATP63832392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Oct 2021 11:31:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0030A4203F;
        Thu, 28 Oct 2021 11:37:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A3A42041;
        Thu, 28 Oct 2021 11:37:18 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.61.213])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Oct 2021 11:37:17 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v3 1/2] tools/perf: Add bitfield_swap to handle branch_stack endian issue
Date:   Thu, 28 Oct 2021 17:07:13 +0530
Message-Id: <20211028113714.600549-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: heF2LXHBQeAxvn1RiKqvy9k5Kf6YnBu9
X-Proofpoint-GUID: WrY2T6jdXt_U6AVRFEwgVnyT2XOFkE4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-28_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 suspectscore=0
 spamscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=663 mlxscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110280063
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
Changelog v2:
- used tep_is_bigendian() instead bigendian()
  to avoid perf test python fail.
 
Changelog v1:
- Renamed function and macro
- Added comments in code

 tools/perf/util/evsel.c | 77 +++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.h | 13 +++++++
 2 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..4e929b9d9718 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2221,6 +2221,54 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
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
+	 *
+	 * tep_is_bigendian() is used here instead of
+	 * bigendian() to avoid python test fails.
+	 */
+	if (tep_is_bigendian()) {
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
@@ -2408,6 +2456,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		const u64 max_branch_nr = UINT64_MAX /
 					  sizeof(struct branch_entry);
+		struct branch_entry *e;
+		unsigned int i;
 
 		OVERFLOW_CHECK_u64(array);
 		data->branch_stack = (struct branch_stack *)array++;
@@ -2416,10 +2466,33 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
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

