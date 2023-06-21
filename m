Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FACEB64D7
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 08:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjFUIb4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFUIbs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 04:31:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B743C198D
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 01:31:47 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L88j8C021594;
        Wed, 21 Jun 2023 08:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4KtABcidoeJgovJ+R9vXl/P1iwrKaHWzKauvRWQYRHs=;
 b=ObWamI5WRWm1/qqtR25XyTxzNdroKsqXpE1PlJ6XiLIs0jVMyuuLvgtPymbQvNrd8D2j
 LJuAczLyHWvT20YrQsFuon/ZKndiuFcHN8ja/6ve+w6zqFOUH50ub13iSpn3OOHVHfhi
 9CtTXNex3NxwdyM7DTZdzHWKQoPJtXryIazo4bAUU7R9arNje/njiMMwF7uEevhJayB6
 yquW0scC09cIJ+2/YylsCu0ZETQf8ost0ri/jy5VkAbafriaDNtd9mthtiKXsOWTPJQj
 DHSUlnDUCabi3c8Yb6F9mSC2ltGHHe4uRz/mnsumSIhhRLG0iTn909U/OJ/hKhiPT1OF Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbspm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:38 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L8LTpR021104;
        Wed, 21 Jun 2023 08:31:38 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvpbspkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L5GdYW016286;
        Wed, 21 Jun 2023 08:31:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3r94f51yu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:31:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35L8VWpT20578844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 08:31:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4446E2004B;
        Wed, 21 Jun 2023 08:31:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFED820040;
        Wed, 21 Jun 2023 08:31:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.215.188])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 08:31:29 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 16/22] tools/perf: Fix shellcheck issue for check-headers.sh script
Date:   Wed, 21 Jun 2023 14:00:15 +0530
Message-Id: <20230621083021.71203-17-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
References: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OyG7gMOIwp_kRFEJXtI3Rfp9qRev8RdI
X-Proofpoint-GUID: nRGkiNg1_dEjlVWW98sTKD_ezU2wwfVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210067
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on check-headers.sh generates below warning:

In check-headers.sh line 126:
  check_2 "tools/$file" "$file" $*
                                ^-- SC2048 (warning): Use "$@" (with quotes) to prevent whitespace problems.

In check-headers.sh line 134:
  check_2 "tools/perf/trace/beauty/$file" "$file" $*
                                                  ^-- SC2048 (warning): Use "$@" (with quotes) to prevent whitespace problems.

In check-headers.sh line 186:
cd tools/perf
^-----------^ SC2164 (warning): Use 'cd ... || exit' or 'cd ... || return' in case cd fails.

Fixed the warnings by:
- Using "$@" instead of $*
- Adding exit condition with cd command

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/check-headers.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index a0f1d8adce60..4314c9197850 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -123,7 +123,7 @@ check () {
 
   shift
 
-  check_2 "tools/$file" "$file" $*
+  check_2 "tools/$file" "$file" "$@"
 }
 
 beauty_check () {
@@ -131,7 +131,7 @@ beauty_check () {
 
   shift
 
-  check_2 "tools/perf/trace/beauty/$file" "$file" $*
+  check_2 "tools/perf/trace/beauty/$file" "$file" "$@"
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
@@ -183,7 +183,7 @@ done
 check_2 tools/perf/util/hashmap.h tools/lib/bpf/hashmap.h
 check_2 tools/perf/util/hashmap.c tools/lib/bpf/hashmap.c
 
-cd tools/perf
+cd tools/perf || exit
 
 if [ ${#FAILURES[@]} -gt 0 ]
 then
-- 
2.39.1

