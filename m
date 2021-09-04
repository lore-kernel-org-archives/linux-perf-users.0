Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B0AC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 06:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B00460F51
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 06:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhIDGvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Sep 2021 02:51:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37762 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229994AbhIDGvv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Sep 2021 02:51:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1846dYaO111932;
        Sat, 4 Sep 2021 02:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HSFFzgYL/AzQXQIr3bE3zekv9HRm4Owh9F2sCAuKP6o=;
 b=WnvODbQImP8BQjX1TY+Rzp9BtOOEVj1V8jKhf+f9wdCn0cZd32spbQjkhnW4BVyYzkzg
 q9gAhQO/gyL8yeJBzFMYib831ATdjOBw7Vu7HSqynQv9rh5P9DA0KDspbSCKuM8n7FEK
 oEUPF8/7d8TzTuatCJlr/eYeAuN8BNB/Ql4JtJO1MWs6o8L50anWJQ5oi+hw8zfCUU23
 ZH0BcfqfRTBu0fZahTMyGQLxd0+YjfafDdZBl251Rv6d/Q7yhgAInYO3Iju9bpctnpzv
 69laqamk1i7ebRBdU157V0k6CqV5u0jNfqOIIluu/mC1h02fLxuBjq8IFS0lp6OfRXkW ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3av1tvsqnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 02:50:10 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1846o9UL145637;
        Sat, 4 Sep 2021 02:50:09 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3av1tvsqmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 02:50:09 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1846Vrpp025926;
        Sat, 4 Sep 2021 06:50:07 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3av02hhecc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 04 Sep 2021 06:50:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1846jwK053084554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 4 Sep 2021 06:45:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C5014C05E;
        Sat,  4 Sep 2021 06:50:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F00A64C040;
        Sat,  4 Sep 2021 06:49:54 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.43.55.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  4 Sep 2021 06:49:54 +0000 (GMT)
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
Subject: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
Date:   Sat,  4 Sep 2021 12:19:30 +0530
Message-Id: <20210904064932.307610-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L6NsZ3BWVeszSLtJ59a0Zd1PCgBqs-WZ
X-Proofpoint-ORIG-GUID: 6QXnz4B6sKpuGnC80-emFXhP8oY3eGB_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-04_02:2021-09-03,2021-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109040044
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add couple of new macros to represent onchip L2 and onchip L3 accesses.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 include/uapi/linux/perf_event.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..030b3e990ac3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
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
-- 
2.26.2

