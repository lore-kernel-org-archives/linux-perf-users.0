Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47CCC07E95
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDEB6138C
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jul 2021 09:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbhGMJWN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jul 2021 05:22:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234397AbhGMJWN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jul 2021 05:22:13 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16D93ck5023805;
        Tue, 13 Jul 2021 05:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=MatbeyZ0SxVOS2gBPMLnqMBOxl2inB3UbJ7bpIt2WBg=;
 b=s0H2W4Iq7SrGBfDjvCrYRfyN8/pFVw5rFXYBIQ1qa0JelUak/ZhESXldyOFu97JRfWYJ
 q1Q/Djn2qEnxvrzTyKOZhwca/YQOvAtDwcVDwL4jj33PF4/HoejWD6PgjA0AExxyAK9F
 DoB0x7Lpl2q/qW6+M42SF7M5sjuAVONGV2kD5/sp/Vl+sPwpgXMqYt2MThyfg83f6OWs
 /z8Bl+RkdcomSVOZuxFnaRTWsoKuEosfKtBZ3c4I2czyBTlIYI50Xkwi+i0wwIlHwgAQ
 eeJyiejPGr88/1J2+6L+wpxhlPwx5QAMJFrJkn8S+XVw9j4YqOYkCdOu7j5aHXMUSBH0 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrmtxayx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:19:13 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16D94pKD028052;
        Tue, 13 Jul 2021 05:19:13 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrmtxayb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 05:19:12 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16D98GJp029490;
        Tue, 13 Jul 2021 09:19:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 39q368gmnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 09:19:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16D9J8wk35389940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 09:19:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 225BB52052;
        Tue, 13 Jul 2021 09:19:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C49AE5204F;
        Tue, 13 Jul 2021 09:19:07 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] libperf: fix build error with LIBPFM4=1
Date:   Tue, 13 Jul 2021 11:19:07 +0200
Message-Id: <20210713091907.1555560-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: s9_lfE23xdlRphDFJqnFWtf5fw9JOYxE
X-Proofpoint-ORIG-GUID: mHT3aL4ucBVdoYBSOXUjqMM4jL-ej9TA
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_03:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130057
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix build error with LIBPFM4=1:
  CC      util/pfm.o
util/pfm.c: In function ‘parse_libpfm_events_option’:
util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
  102 |                         evsel->leader = grp_leader;
      |                              ^~

Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/perf/util/pfm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index dd9ed56e0504..756295dedccc 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -99,7 +99,7 @@ int parse_libpfm_events_option(const struct option *opt, const char *str,
 			grp_leader = evsel;
 
 		if (grp_evt > -1) {
-			evsel->leader = grp_leader;
+			evsel__set_leader(evsel, grp_leader);
 			grp_leader->core.nr_members++;
 			grp_evt++;
 		}
-- 
2.25.1

