Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2AFC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 14:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53EB060F94
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 14:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbhJFOK0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:10:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238945AbhJFOKY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 10:10:24 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196E7K2x008663;
        Wed, 6 Oct 2021 10:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g+qyH8l+fcwTWG6Zm4l3Rk+Vj2Edz1eDILE4/IQPrTo=;
 b=R825m2Mb13VTQfMFLoOhhZDYIYVBo9qxb7low7ZzS8tMRctFPknXuHdXC1YHmFvE43Fz
 m5IaNXNpAaKhq+GOLzjzcue/XrlSOuAjN1Wu0GuFSZzFCS4nMjX0ah0uI7Eb1fnrfh45
 l4GS7dWxZr7AyoVGFPS3bf0+OfcU4k4URhGzmovACZ+Tf6hPWagi14Hogtyk6/fBu6gb
 NkKl2Nr4VC1L10jfHjIVgM3wRIiLg+4Gx2IOpde/uPOGU/TxYuQAIJs5SuUsFb995RVx
 Xyojzdg79ksPXk2oL5jys4d0VZIed++y/HN2/0tqQJqLm+mBgmsGfWmYj4B5ZXJbbgvx Pg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh33kd479-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:08:00 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196E7kCe010195;
        Wed, 6 Oct 2021 10:08:00 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bh33kd46j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 10:08:00 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196E76hf029255;
        Wed, 6 Oct 2021 14:07:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 3beepjunx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 14:07:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196E7rT25047020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 14:07:53 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C90CA405C;
        Wed,  6 Oct 2021 14:07:53 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC6CBA4065;
        Wed,  6 Oct 2021 14:07:45 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.124.20])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 14:07:45 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org, kjain@linux.ibm.com
Subject: [PATCH v3 3/4] tools/perf: Add mem_hops field in perf_mem_data_src structure
Date:   Wed,  6 Oct 2021 19:36:53 +0530
Message-Id: <20211006140654.298352-4-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211006140654.298352-1-kjain@linux.ibm.com>
References: <20211006140654.298352-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YESwmiZ3sd2HqfezDEhJWODrpXpDwNWv
X-Proofpoint-GUID: 9deWcEOhlQhYcniAZSdVtspqr6thITzQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_03,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110060089
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Going forward, future generation systems can have more hierarchy
within the node/package level but currently we don't have any data source
encoding field in perf, which can be used to represent this level of data.

Add a new field called 'mem_hops' in the perf_mem_data_src structure
which can be used to represent intra-node/package or inter-node/off-package
details. This field is of size 3 bits where PERF_MEM_HOPS_{NA, 0..6} value
can be used to present different hop levels data.

Also add corresponding macros to define mem_hop field values
and shift value.

Currently we define macro for HOPS_0 which corresponds
to data coming from another core but same node.

Add functionality to represent mem_hop field data in
perf_mem__lvl_scnprintf function with the help of added string
array called mem_hops.

For ex: Encodings for mem_hops fields with L2 cache:

L2                      - local L2
L2 | REMOTE | HOPS_0    - remote core, same node L2

Since with the addition of HOPS field, now remote can be used to
denote cache access from the same node but different core, a check
is added in the c2c_decode_stats function to set mrem only when HOPS
is zero along with set remote field.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/include/uapi/linux/perf_event.h | 11 +++++++++--
 tools/perf/util/mem-events.c          | 19 ++++++++++++++++++-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index e1701e9c7858..2fc09579e24a 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1210,14 +1210,16 @@ union perf_mem_data_src {
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_blk:3,	/* access blocked */
-			mem_rsvd:21;
+			mem_hops:3,	/* hop level */
+			mem_rsvd:18;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:21,
+		__u64	mem_rsvd:18,
+			mem_hops:3,	/* hop level */
 			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
@@ -1313,6 +1315,11 @@ union perf_mem_data_src {
 #define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
 #define PERF_MEM_BLK_SHIFT	40
 
+/* hop level */
+#define PERF_MEM_HOPS_0		0x01 /* remote core, same node */
+/* 2-7 available */
+#define PERF_MEM_HOPS_SHIFT	43
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index ff7289e28192..3167b4628b6d 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -301,6 +301,16 @@ static const char * const mem_lvlnum[] = {
 	[PERF_MEM_LVLNUM_NA] = "N/A",
 };
 
+static const char * const mem_hops[] = {
+	"N/A",
+	/*
+	 * While printing, 'Remote' will be added to represent
+	 * 'Remote core, same node' accesses as remote field need
+	 * to be set with mem_hops field.
+	 */
+	"core, same node",
+};
+
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 {
 	size_t i, l = 0;
@@ -325,6 +335,9 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 		l += 7;
 	}
 
+	if (mem_info && mem_info->data_src.mem_hops)
+		l += scnprintf(out + l, sz - l, "%s ", mem_hops[mem_info->data_src.mem_hops]);
+
 	printed = 0;
 	for (i = 0; m && i < ARRAY_SIZE(mem_lvl); i++, m >>= 1) {
 		if (!(m & 0x1))
@@ -471,8 +484,12 @@ int c2c_decode_stats(struct c2c_stats *stats, struct mem_info *mi)
 	/*
 	 * Skylake might report unknown remote level via this
 	 * bit, consider it when evaluating remote HITMs.
+	 *
+	 * Incase of power, remote field can also be used to denote cache
+	 * accesses from the another core of same node. Hence, setting
+	 * mrem only when HOPS is zero along with set remote field.
 	 */
-	bool mrem  = data_src->mem_remote;
+	bool mrem  = (data_src->mem_remote && !data_src->mem_hops);
 	int err = 0;
 
 #define HITM_INC(__f)		\
-- 
2.26.2

