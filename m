Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE116C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 07:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E30617E5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Sep 2021 07:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348463AbhI3HGO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Sep 2021 03:06:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233661AbhI3HGO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Sep 2021 03:06:14 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18U5T7BR008286;
        Thu, 30 Sep 2021 03:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=MhmHp9wX5+qeFhbd7KU4HBwtVVghFYxBAcJ6s8OhlqE=;
 b=o/rDkQ5pBKGbfyKg1NCsl31o21/D5qkB4AFIU4wvXDO6ktnqncRbiKCH2hvpS4785MUu
 Sz2CHE/t90GIzERQrEL3PGhFUUWgSBJmVLooM9/wBkJZjVB83EG67fjAREZY5jIS8DdH
 Cdc3Z3tlSEQaNirkyq4MCa8Qp95sEKcfUQTeXdS1IKrWy4awggD0RYBJynvPW3BR4rMh
 Z1yj/nqWaEadtxeutQ53ksg7O+0mqmPjd3hDNRx3isUCYhrpQqxfxLHfeKhEht9mUtBN
 HMePezwrYv+aK+y6kIFx+IMdtk+KQF4WoCzVePywSS8bXfzfuAvxNtT360RhOKHtnyNg JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd74khxqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 03:04:26 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18U70Smb026624;
        Thu, 30 Sep 2021 03:04:25 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bd74khxpd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 03:04:25 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18U73FfY025331;
        Thu, 30 Sep 2021 07:04:23 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9uda84u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 07:04:22 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18U6xEmL57737556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Sep 2021 06:59:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C827211C052;
        Thu, 30 Sep 2021 07:04:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DAFD11C064;
        Thu, 30 Sep 2021 07:04:14 +0000 (GMT)
Received: from Madhavan.com (unknown [9.43.101.207])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Sep 2021 07:04:14 +0000 (GMT)
From:   Madhavan Srinivasan <maddy@linux.ibm.com>
To:     acme@kernel.org
Cc:     michael@ellerman.id.au, eranian@google.com, mark.rutland@arm.com,
        namhyung@kernel.org, kjain@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, jolsa@redhat.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH 1/2] tools/perf: Add reverse_fn to handle branch_stack endian issue
Date:   Thu, 30 Sep 2021 12:34:09 +0530
Message-Id: <20210930070410.52703-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tiH2QL5t5-j2QWGdjmbUtD4wiUa-szxl
X-Proofpoint-GUID: pPq64JZ1pIJvFW4L_gnnUoh8wydgmPAs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-30_02,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 spamscore=0
 phishscore=0 mlxlogscore=569 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109300042
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

branch_stack struct has bit field definition which
produces different bit ordering for big/little endian.
Because of this, when branch_stack sample is collected
in a BE system and viewed/reported in a LE system, bit
fields of the branch stack are not presented properly.
To address this issue, a evsel__reverse64_branch_stack_flags()
is defined and introduced in evsel__parse_sample.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/perf/util/evsel.c | 64 +++++++++++++++++++++++++++++++++++++++--
 tools/perf/util/evsel.h |  5 ++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbfeceb2546c..007be66b69a2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2221,6 +2221,46 @@ void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
 	data->weight = *array;
 }
 
+u64 evsel__reverse64_branch_stack_flags(u64 value)
+{
+	u64 new_val = 0;
+
+	/*
+	 * branch_stack flag (u64)
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
+	 */
+	if (bigendian()) {
+		new_val = reverse_64(value, 0, 1);
+		new_val |= reverse_64(value, 1, 1);
+		new_val |= reverse_64(value, 2, 1);
+		new_val |= reverse_64(value, 3, 1);
+		new_val |= reverse_64(value, 4, 16);
+		new_val |= reverse_64(value, 20, 4);
+		new_val |= reverse_64(value, 24, 40);
+	} else {
+		new_val = reverse_64(value, 63, 1);
+		new_val |= reverse_64(value, 62, 1);
+		new_val |= reverse_64(value, 61, 1);
+		new_val |= reverse_64(value, 60, 1);
+		new_val |= reverse_64(value, 44, 16);
+		new_val |= reverse_64(value, 40, 4);
+		new_val |= reverse_64(value, 0, 40);
+	}
+
+	return new_val;
+}
+
 int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			struct perf_sample *data)
 {
@@ -2408,6 +2448,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		const u64 max_branch_nr = UINT64_MAX /
 					  sizeof(struct branch_entry);
+		struct branch_entry *e;
+		unsigned int i;
 
 		OVERFLOW_CHECK_u64(array);
 		data->branch_stack = (struct branch_stack *)array++;
@@ -2416,10 +2458,28 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			return -EFAULT;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
-		if (evsel__has_branch_hw_idx(evsel))
+		if (evsel__has_branch_hw_idx(evsel)) {
 			sz += sizeof(u64);
-		else
+			e = &data->branch_stack->entries[0];
+		} else {
 			data->no_hw_idx = true;
+			e = (struct branch_entry *)&data->branch_stack->hw_idx;
+		}
+
+		if (swapped) {
+			/*
+			 * struct branch_flag does not have endian specific
+			 * bit field definition. And bswap will not resolve the
+			 * issue, since these are bit fields.
+			 *
+			 * evsel__reverse64_branch_stack_flags() uses a reverse64
+			 * macro to reverse the bit position based on the host
+			 * endians.
+			 */
+			for (i = 0; i < data->branch_stack->nr; i++, e++)
+				e->flags.value = evsel__reverse64_branch_stack_flags(e->flags.value);
+		}
+
 		OVERFLOW_CHECK(array, sz, max_size);
 		array = (void *)array + sz;
 	}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 1f7edfa8568a..1127c23710cf 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -482,4 +482,9 @@ struct evsel *evsel__leader(struct evsel *evsel);
 bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
+
+#define reverse_64(src, pos, size)	\
+	((((src) >> (pos)) & ((1ull << (size)) - 1)) << (63 - ((pos) + (size) - 1)))
+
+u64 evsel__reverse64_branch_stack_flags(u64 value);
 #endif /* __PERF_EVSEL_H */
-- 
2.31.1

