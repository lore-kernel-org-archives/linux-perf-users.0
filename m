Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997FC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 Nov 2021 02:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKYCy2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Nov 2021 21:54:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43998 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237994AbhKYCw2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Nov 2021 21:52:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP0qPWE006787;
        Thu, 25 Nov 2021 02:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=C40OB4Jccg7bkamDzO65YMLvJwNjBcaIPgub+YQyaT8=;
 b=IG7VdxhQvDts5HjBoA8G98Lu7leKleFEesCCwvXQf7pi4Vy8XqJUQM3O/0fklohQnKI3
 b4leJW+q6eQ2SqHuHkkoI9xn7O3XYU8mvD9w5mt5ezZdzZz5CwBW4iEkNctNc6bNex5H
 7PlDSb6lsyRgnG648Qx11pdpY8FBEHFXLgKbF3jXwcjM/2aQFBYmX6RvtXFzDHqZjPha
 bTBPZMYKCrUwSVbJgkiM0uoFG5DpaXuQ0iGDOJcAUD6wkKFeWHZW+woHmdZqinmcHn53
 4yfrFZE8Ic3F6gXhQN4lNyVL5l1F+mSMglrUcSlmV7R3OgHEhPiqS7oUsUaS3/Uu5NOI OA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cj0b19hfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 02:49:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AP2l1UL023426;
        Thu, 25 Nov 2021 02:49:09 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3cernaejws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 02:49:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AP2n50R30015834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 02:49:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F97AE057;
        Thu, 25 Nov 2021 02:49:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23A5DAE04D;
        Thu, 25 Nov 2021 02:49:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.111.17])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Nov 2021 02:49:00 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, namhyung@kernel.org
Subject: [PATCH 2/2] tools/perf: Update global/local variants for p_stage_cyc in powerpc
Date:   Thu, 25 Nov 2021 08:18:51 +0530
Message-Id: <20211125024851.22895-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211125024851.22895-1-atrajeev@linux.vnet.ibm.com>
References: <20211125024851.22895-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hTpYosNbS29M8sv0f6v-3T6K79djDb-Q
X-Proofpoint-GUID: hTpYosNbS29M8sv0f6v-3T6K79djDb-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111250011
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update the arch_support_sort_key() function in powerpc
to enable presenting local and global variants of sort
key: p_stage_cyc. Update the "se_header" strings for
these in arch_perf_header_entry() function along with
instruction latency.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reported-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/arch/powerpc/util/event.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
index 3bf441257466..cf430a4c55b9 100644
--- a/tools/perf/arch/powerpc/util/event.c
+++ b/tools/perf/arch/powerpc/util/event.c
@@ -40,8 +40,12 @@ const char *arch_perf_header_entry(const char *se_header)
 {
 	if (!strcmp(se_header, "Local INSTR Latency"))
 		return "Finish Cyc";
-	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
+	else if (!strcmp(se_header, "INSTR Latency"))
+		return "Global Finish_cyc";
+	else if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
 		return "Dispatch Cyc";
+	else if (!strcmp(se_header, "Pipeline Stage Cycle"))
+		return "Global Dispatch_cyc";
 	return se_header;
 }
 
@@ -49,5 +53,7 @@ int arch_support_sort_key(const char *sort_key)
 {
 	if (!strcmp(sort_key, "p_stage_cyc"))
 		return 1;
+	if (!strcmp(sort_key, "local_p_stage_cyc"))
+		return 1;
 	return 0;
 }
-- 
2.27.0

