Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C4C433F5
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0736056B
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 06:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhIDGwH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:52:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38678 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232778AbhIDGwG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Sep 2021 02:52:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1846YNoO139311;
        Sat, 4 Sep 2021 02:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XTUic6tUeukDesd8hD1d+bhUmL5WKQ/iC+uWSwiyWvo=;
 b=WL1l1d+wMIQnkqUvALXVlivsWm9kwax/SMsrfeakEhQzyuVyV9ZuuFm6q1bwSvU21Vnr
 RXs3KCcxctLx7aksVmx+Zk6NFxQJyNs+KRFCD6A9Wvi4fw68OLDY3afzHqweTsu9Vs0p
 FbPNzr+3GgQ+NKZJCh8iRFk9tGyylCagU4ci6BqPOeWCl7Nk2Vv4GKxLqrCJH8SF4xV6
 4A8ZVGdxfDAh75Imj/IUFdge+HwiiH8oWzMuaZHT1dmdMTk4K3ptHOtIU1RB/3FqYPTf
 pCkmlBSvLEUNJnW01XhM8AGa1xoNS/VWj+ksfozJ4t+3Svok+SPbyZqe5RSbePK5In98 HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3av2s48un2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 02:50:28 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1846gvVs167669;
        Sat, 4 Sep 2021 02:50:27 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3av2s48ump-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 02:50:27 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1846WMnJ000875;
        Sat, 4 Sep 2021 06:50:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3av0e8sagm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 06:50:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1846oMxh51577302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Sep 2021 06:50:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 214204C063;
        Sat,  4 Sep 2021 06:50:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41BC34C050;
        Sat,  4 Sep 2021 06:50:15 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.43.55.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  4 Sep 2021 06:50:14 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org
Subject: [PATCH 2/3] perf: Add macros to specify onchip L2/L3 accesses
Date:   Sat,  4 Sep 2021 12:19:31 +0530
Message-Id: <20210904064932.307610-2-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904064932.307610-1-kjain@linux.ibm.com>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vfn5RswQX45GrUynouvKzwWboh437Mul
X-Proofpoint-ORIG-GUID: 8rwH5_WniquqzoTDEcortWe3VSP-j7cI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-04_02:2021-09-03,2021-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109040044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add couple of new macros to represent onchip L2 and onchip L3 accesses.
Patch also adds the decoding strings in the mem_lvlnum data structure.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/include/uapi/linux/perf_event.h | 4 +++-
 tools/perf/util/mem-events.c          | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..030b3e990ac3 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1265,7 +1265,9 @@ union perf_mem_data_src {
 #define PERF_MEM_LVLNUM_L2	0x02 /* L2 */
 #define PERF_MEM_LVLNUM_L3	0x03 /* L3 */
 #define PERF_MEM_LVLNUM_L4	0x04 /* L4 */
-/* 5-0xa available */
+#define PERF_MEM_LVLNUM_OC_L2	0x05 /* On Chip L2 */
+#define PERF_MEM_LVLNUM_OC_L3	0x06 /* On Chip L3 */
+/* 7-0xa available */
 #define PERF_MEM_LVLNUM_ANY_CACHE 0x0b /* Any cache */
 #define PERF_MEM_LVLNUM_LFB	0x0c /* LFB */
 #define PERF_MEM_LVLNUM_RAM	0x0d /* RAM */
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df72b80..f846a91220c2 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -294,6 +294,8 @@ static const char * const mem_lvl[] = {
 };
 
 static const char * const mem_lvlnum[] = {
+	[PERF_MEM_LVLNUM_OC_L2] = "OnChip L2",
+	[PERF_MEM_LVLNUM_OC_L3] = "OnChip L3",
 	[PERF_MEM_LVLNUM_ANY_CACHE] = "Any cache",
 	[PERF_MEM_LVLNUM_LFB] = "LFB",
 	[PERF_MEM_LVLNUM_RAM] = "RAM",
-- 
2.26.2

