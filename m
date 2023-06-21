Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE696EB64DC
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jun 2023 08:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjFUIa5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jun 2023 04:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFUIa4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jun 2023 04:30:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CF610DA
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jun 2023 01:30:55 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L872Ft024414;
        Wed, 21 Jun 2023 08:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=13KG55BGj3ZjCFxK/Pmae1TV1C/sdk1d+lFMZ/NlVhg=;
 b=pUn0OnbqUPPpFhI6g3yS76PLeQMZaKJHt4z48pncNAW7ONf9YatNZ9vQVY13cnv+VidV
 JH2RBqMPEbwGjNnwD2ER9Pi3vwJI0gqLB/COmMnK5zp7Oyk6MGgs+N4KgKyktYHiaVkv
 dJsR+6p0aC44LTVOLMzwSSsGCnL+JfnbHlGlf4Ymj2tZVh5QVA2AXHb6RI7Lk9rFLXqH
 maph52GYhMapUzjy8mrvCpyQECOEXvg7dzfsr0JB1+Tk/P36U1Dj6iF0DA2tQJGMoCyC
 yO0Cfomj2SLFSBCHk1/NFwl2kS7FtFGPl8a+hsXqFR9JrDT6m0nWQERYT8PyJQ6u5T0V ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvq01q6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35L87Pea029608;
        Wed, 21 Jun 2023 08:30:46 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbvq01q5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:46 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L3G3Qt023748;
        Wed, 21 Jun 2023 08:30:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3r943e2028-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 08:30:43 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35L8Uek528705322
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 08:30:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A41A20049;
        Wed, 21 Jun 2023 08:30:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C4B620040;
        Wed, 21 Jun 2023 08:30:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.109.215.188])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jun 2023 08:30:37 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org, ravi.bangoria@amd.com, john.g.garry@oracle.com
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 03/22] tools/perf/tests: Fix shellcheck warning for record_offcpu.sh testcase
Date:   Wed, 21 Jun 2023 14:00:02 +0530
Message-Id: <20230621083021.71203-4-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
References: <20230621083021.71203-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PACP_kjmWOJMsRD8ky25aAS9q-mYg5No
X-Proofpoint-GUID: 6CzG1_qbMRsOIal0qGSpttVUliTua-Ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=837 lowpriorityscore=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210067
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on record_offcpu.sh throws below warning:

In tests/shell/record_offcpu.sh line 13:
  trap - exit term int
         ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
              ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                   ^-^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.

In tests/shell/record_offcpu.sh line 20:
trap trap_cleanup exit term int
                  ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                       ^--^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.
                            ^-^ SC3049 (warning): In POSIX sh, using lower/mixed case for signal names is undefined.

In tests/shell/record_offcpu.sh line 25:
  if [ `id -u` != 0 ]
       ^-----^ SC2046 (warning): Quote this to prevent word splitting.

Fixed the warnings by:
- Capitalize signals(INT, TERM, EXIT) to avoid mixed/lower case naming of
signals.
- Adding quotes to avoid word splitting.

Result from shellcheck after patch changes:
     $ shellcheck -S warning record_offcpu.sh
     $

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index f062ae9a95e1..a0d14cd0aa79 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -10,19 +10,19 @@ perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 cleanup() {
   rm -f ${perfdata}
   rm -f ${perfdata}.old
-  trap - exit term int
+  trap - EXIT TERM INT
 }
 
 trap_cleanup() {
   cleanup
   exit 1
 }
-trap trap_cleanup exit term int
+trap trap_cleanup EXIT TERM INT
 
 test_offcpu_priv() {
   echo "Checking off-cpu privilege"
 
-  if [ `id -u` != 0 ]
+  if [ "$(id -u)" != 0 ]
   then
     echo "off-cpu test [Skipped permission]"
     err=2
-- 
2.39.1

