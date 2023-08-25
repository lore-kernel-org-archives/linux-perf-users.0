Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093C0C71133
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 10:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjHYKr6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 06:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244622AbjHYKrv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 06:47:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2130810FE
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 03:47:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PAcrJI030578;
        Fri, 25 Aug 2023 10:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vORVjgrNXrXdQSTfy+F4EtBeL1hRw3CnRqymTOtSRZE=;
 b=cObyumU2w0oTDGqWJKtPDOuI5WDczs0cyP0wOzizP/1a4vD8MyvwHRMpD4RhoXr5Csbh
 sszvlOww1MdAr3Z6y3onaAIq+q9GVTMQOZfVcN/WhJwNvyE/m2RG8ocqzx6emsvJnWXd
 ASahHkhkmSa+X7iRtLaUwWPA+h/YLn6H0ieNz02KStXhtKdu5w6zCirju80AE//Pr5s4
 4hd9e/lW+WyNuLaRLQkVQ4NfxkhpMclzIlLGKarjqDt7xQjuSvUi9iDoMwPlHoiioxLn
 kGJrn91fthywjUWDCqW8X1iFesXhEx/4vIPaMUckQPWuFfKhEpUxAmRzXXGvi6C6mYVp 6Q== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sptf2rfw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:47:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37PAXewY004042;
        Fri, 25 Aug 2023 10:47:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn21rxv4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:47:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PAlgJR55181590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 10:47:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31B532004D;
        Fri, 25 Aug 2023 10:47:42 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 895F720040;
        Fri, 25 Aug 2023 10:47:34 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.34.48])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 10:47:32 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        disgoel@linux.ibm.com, kjain@linux.ibm.com,
        linux-perf-users@vger.kernel.org, namhyung@kernel.org
Subject: [PATCH] perf lock contention: Fix typo in max-stack option description
Date:   Fri, 25 Aug 2023 16:17:00 +0530
Message-Id: <20230825104700.440809-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_2onSQRtojakbTNew-n3pXjbuQyh15P
X-Proofpoint-GUID: m_2onSQRtojakbTNew-n3pXjbuQyh15P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_08,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250092
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix typo in max-stack option description by changing lopck contention
to lock contention.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/builtin-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index c15386cb1033..76d4f8b2bf7d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2506,7 +2506,7 @@ int cmd_lock(int argc, const char **argv)
 	OPT_CALLBACK('M', "map-nr-entries", &bpf_map_entries, "num",
 		     "Max number of BPF map entries", parse_map_entry),
 	OPT_CALLBACK(0, "max-stack", &max_stack_depth, "num",
-		     "Set the maximum stack depth when collecting lopck contention, "
+		     "Set the maximum stack depth when collecting lock contention, "
 		     "Default: " __stringify(CONTENTION_STACK_DEPTH), parse_max_stack),
 	OPT_INTEGER(0, "stack-skip", &stack_skip,
 		    "Set the number of stack depth to skip when finding a lock caller, "
-- 
2.39.3

