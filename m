Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C0DEB64DC
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjGIS3M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 9 Jul 2023 14:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGIS3K (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 9 Jul 2023 14:29:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1A11C
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 11:29:09 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 369IHmh7004531;
        Sun, 9 Jul 2023 18:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AiQBhZI6o/xL/AdMWZBwh6XcNALOlDZUevA1vDf12Hg=;
 b=jDJD9DBneIJLhjnuPLZCWS04W/dcCmPfEIrTn1/9bVDLAwChmGaD3944wTo8yZVCAZKP
 FnTsuYdmxD087CUP70BMID4mm5ZraoUIrxg51iAMkEbQds2LBa08lCVvN/BLG+CxpB2d
 9666TFu11VtpDDA+NVzAHu9KIpNLcVjEHM6eFBI2STcn9pdy7gZ1YdwCGiFAg/cCRrzg
 0qkDbaNGwT4Ulm1R+yvj6Q0hh41T3KxTy5VY31AMY9IpW1dDcBTjSAmI2cV8Gfrf+xDB
 zpI0e5GEgSTETifo31NKtV6ArYeyA3914H2ePz1l8tzyTXF3U/V9OlQb44L5EzUOQZD0 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21nr3xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:04 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 369IIjai007186;
        Sun, 9 Jul 2023 18:29:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rr21nr3x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3699SNK8016786;
        Sun, 9 Jul 2023 18:29:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye58v4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jul 2023 18:29:01 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 369ISwB721627432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jul 2023 18:28:58 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9005A20043;
        Sun,  9 Jul 2023 18:28:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FE7820040;
        Sun,  9 Jul 2023 18:28:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.24.202])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jul 2023 18:28:56 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH V2 20/26] tools/perf/trace: Fix x86_arch_prctl.sh to address shellcheck warnings
Date:   Sun,  9 Jul 2023 23:57:54 +0530
Message-Id: <20230709182800.53002-21-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
References: <20230709182800.53002-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 14BOTet6GK0pUL6-w7Q9ON1eA4Gx7zUI
X-Proofpoint-GUID: UZuMgiPEuv6nfYVcjvRHxDClTlVR88yM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-09_12,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307090169
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Running shellcheck on x86_arch_prctl.sh generates below warning:

  In ./tools/perf/trace/beauty/x86_arch_prctl.sh line 10:
      	local idx=$1
        ^-------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

  In ./tools/perf/trace/beauty/x86_arch_prctl.sh line 11:
	local prefix=$2
        ^----------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

   In ./tools/perf/trace/beauty/x86_arch_prctl.sh line 12:
	local first_entry=$3
        ^---------------^ SC3043 (warning): In POSIX sh, 'local' is undefined.

Fix this by removing local since these are variables
used only in specific function

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/trace/beauty/x86_arch_prctl.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/trace/beauty/x86_arch_prctl.sh b/tools/perf/trace/beauty/x86_arch_prctl.sh
index fd5c740512c5..b1596df251f0 100755
--- a/tools/perf/trace/beauty/x86_arch_prctl.sh
+++ b/tools/perf/trace/beauty/x86_arch_prctl.sh
@@ -7,9 +7,9 @@
 prctl_arch_header=${x86_header_dir}/prctl.h
 
 print_range () {
-	local idx=$1
-	local prefix=$2
-	local first_entry=$3
+	idx=$1
+	prefix=$2
+	first_entry=$3
 
 	printf "#define x86_arch_prctl_codes_%d_offset %s\n" $idx $first_entry
 	printf "static const char *x86_arch_prctl_codes_%d[] = {\n" $idx
-- 
2.39.1

