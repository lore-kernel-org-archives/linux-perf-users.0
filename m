Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E85AC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Dec 2021 21:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbhLVVdY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Dec 2021 16:33:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229732AbhLVVdY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Dec 2021 16:33:24 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMJBqRe024450
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : subject : from :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=5fjH0v+auEBXbaltPEj5RJ0gjpCPHmQLHlSv6VDQWKg=;
 b=oyvgPOctUV6wmIPBzrXFaG165NAxHOfKijA7a4+yln2qgR6WDhLZqHBUjAFVlkF5aiMr
 w9GJkP3DpH3wyZjDlEFsnYMIKkslU7jLF3y6gSG832TbYpB11b4YDIYSS9Cjs7/goEbg
 yN0PN4yGMlqnlNxNMgSyhLUaOUIfo4CDl7o9p229ok3hO4/BPOC6EkXega1oeUiX/o/e
 K5P594cXI70dos68Q9Dhg2ul9nK2OJeGzv2JkGfKd183yUBwpVPtT5CUbpq3J+57oyu/
 hRQxNsVor3ZaIRIzvdmAIDzXB7sCgRYLmfV35HMq48pyAuwK4KnSZEWU7sCysyVvs1nm yg== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d49y9aas4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMLNVX8028946
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:23 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3d179b66qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMLXM0H8585992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:22 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D41B2066
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:22 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C983B2065
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:22 +0000 (GMT)
Received: from mww0091.wdc07m.mail.ibm.com (unknown [9.208.69.236])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTPS
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 21:33:22 +0000 (GMT)
To:     linux-perf-users@vger.kernel.org
Subject: [PATCH] perf: Fix perf-record manual typo
From:   "Kevin Grigorenko" <kevin.grigorenko@us.ibm.com>
Message-ID: <OFF9778928.59F62D85-ON002587B3.00757F55-882587B3.00766874@ibm.com>
Date:   Wed, 22 Dec 2021 14:33:20 -0700
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KeepSent: F9778928:59F62D85-002587B3:00757F55; name=$KeepSent; type=4
X-Mailer: HCL Notes Build V1101FP4_10012021 October 01, 2021
X-Disclaimed: 46975
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3jnq213VMJcbM9MTM790hBdpReZ5M357
X-Proofpoint-GUID: 3jnq213VMJcbM9MTM790hBdpReZ5M357
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112220112
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
Date: Wed, 22 Dec 2021 13:21:44 -0800
Subject: [PATCH] perf: Fix perf-record manual typo

Signed-off-by: Kevin Grigorenko <kevin.grigorenko@us.ibm.com>
---
 tools/perf/Documentation/perf-record.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt=20
b/tools/perf/Documentation/perf-record.txt
index 3cf7bac67239..52f98d53a97e 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -258,7 +258,7 @@ OPTIONS
        Call Frame Information) or "lbr" (Hardware Last Branch Record
        facility).
=20
-       In some systems, where binaries are build with gcc
+       In some systems, where binaries are built with gcc
        --fomit-frame-pointer, using the "fp" method will produce bogus
        call graphs, using "dwarf", if available (perf tools linked to
        the libunwind or libdw library) should be used instead.
--=20
2.33.0


