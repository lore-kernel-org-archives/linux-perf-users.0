Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9C4C001E0
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 18:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjGIS2d (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jul 2023 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjGIS2b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jul 2023 14:28:31 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A5711B
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 11:28:30 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369IGri8019671;
        Sun, 9 Jul 2023 18:28:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S0RcyZPhTCSXm7kAdIj+U3089rhPHnI3SkpI51fKezQ=;
 b=JZadm+Oakxnpgh7XGSTlXXLE0NgCmKARDcz21y3CNUq6w/srv4N404T2VIukDes6ExI6
 LImPRTe2J0w8RzYhI9byl59mIEx6sv5QJRIMUl7vTq6/R8y9XwhDM2E/LgXzGe2U9vx0
 pydDCbAjderGf7AT+fLG8vZpNayf32/zJoSn1mIgkbGkG3em413/xN5pTBAU6uJjtQWe
 CgXp+gYx0bqUR/VD1xbijufv2MGe8y4NXT99PRO7awhDtM8aFJMkaC6lIUbAk2lX/gli
 BmT2DtME/m0kR/qpnm8U/TBT5xgcQj3knMPTGL/1nwk7NmylAvEtZ/udEAeG2jJHSro4 cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21h04kg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:17 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 369ISHGC012849;
        Sun, 9 Jul 2023 18:28:17 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21h04ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:17 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3698Ils2023412;
        Sun, 9 Jul 2023 18:28:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rpye50mh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:28:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 369ISCow42729854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jul 2023 18:28:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 241682004F;
        Sun,  9 Jul 2023 18:28:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC54B2004D;
        Sun,  9 Jul 2023 18:28:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.24.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jul 2023 18:28:09 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 02/26] tools/perf/tests: Fix shellcheck warning for probe_vfs_getname.sh testcase
Date:   Sun,  9 Jul 2023 23:57:36 +0530
Message-Id: <20230709182800.53002-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2GyWK2UxS2K4uXKy3FqlQyDWVTLZ7wxJ
X-Proofpoint-GUID: BTGrOm_BD11Ybebsu7E5Chwz0GclfOBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-09_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=984
 lowpriorityscore=0 impostorscore=0 phishscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307090169
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kajol Jain <kjain@linux.ibm.com>

Running shellcheck on probe_vfs_getname.sh throws below warning:

In tests/shell/probe_vfs_getname.sh line 7:
. $(dirname $0)/lib/probe.sh
  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

In tests/shell/probe_vfs_getname.sh line 11:
. $(dirname $0)/lib/probe_vfs_getname.sh
  ^-----------^ SC2046 (warning): Quote this to prevent word splitting.

Fixed the warning by adding quotes to avoid word splitting.

ShellCheck result with patch:
    # shellcheck -S warning probe_vfs_getname.sh
    #

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 tools/perf/tests/shell/probe_vfs_getname.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
index 5d1b63d3f3e1..871243d6d03a 100755
--- a/tools/perf/tests/shell/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/probe_vfs_getname.sh
@@ -4,11 +4,11 @@
 # SPDX-License-Identifier: GPL-2.0
 # Arnaldo Carvalho de Melo <acme@kernel.org>, 2017
 
-. $(dirname $0)/lib/probe.sh
+. "$(dirname $0)"/lib/probe.sh
 
 skip_if_no_perf_probe || exit 2
 
-. $(dirname $0)/lib/probe_vfs_getname.sh
+. "$(dirname $0)"/lib/probe_vfs_getname.sh
 
 add_probe_vfs_getname || skip_if_no_debuginfo
 err=$?
-- 
2.39.1

