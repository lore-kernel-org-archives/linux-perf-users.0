Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38EBC636CC
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Feb 2023 14:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBGOFQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Feb 2023 09:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjBGOFH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Feb 2023 09:05:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDF744B6;
        Tue,  7 Feb 2023 06:05:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317CCL72008904;
        Tue, 7 Feb 2023 14:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=M9UwC4YSVpfyHNddSzSo9Og0mScJAzhIdyg9OzhqzsM=;
 b=Z1KzKeyj2SvApOFfxzDu9Vy5dLwZWE3IT9Rdxtol0+ysL29FL6GU0ddnPE6C2vbPGB4P
 8SK2CNwhto7DTy/yStUjbXlqenFnNpdEj3ScIj/k3NdbvIJ6jcpxjndlWXfPYLQVP80e
 chvO2gSgNYBP64Sb+CufuBh4s4w4rZrhT73lDiTm5G7LLMtVicUILUrG7+svgwbd7vMK
 GnDzuno+75xTy0SLB7CBtSLfgC8gAtaYQ5cMnHON3aCeEwnXiuAgqQcJbWj15I6zNEPy
 QuT8RHPhkWFUOYfCWkBnE0zos6D8MM3lyfDuf48VKpitmdCTUFBsfnHk26yn9auwNIkz ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpeju10m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:05:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 317DAs2f029407;
        Tue, 7 Feb 2023 14:05:03 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nkpeju0xu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:05:03 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316JlULJ007292;
        Tue, 7 Feb 2023 14:05:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3nhemfjmj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 14:05:00 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 317E4v5i23527898
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Feb 2023 14:04:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 239502004B;
        Tue,  7 Feb 2023 14:04:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE14420043;
        Tue,  7 Feb 2023 14:04:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Feb 2023 14:04:56 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel-next@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org,
        irogers@google.com, hca@linux.ibm.com, egorenar@linux.ibm.com,
        gor@linux.ibm.com
Cc:     svens@linux.ibm.com, sumanthk@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] tools/perf: Fix perf tool build error in util/pfm.c
Date:   Tue,  7 Feb 2023 15:04:47 +0100
Message-Id: <20230207140447.1827741-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hs2Suvv3UqTF_WDP4tmJwdub4uzBInD2
X-Proofpoint-GUID: 25Spd2cM0vz6PRHfomnQnrKPx86uXk8F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_05,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070126
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I have downloaded linux-next and build the perf tool using

 # make LIBPFM4=1

to have libpfm4 support built into perf. The build fails:

 # make LIBPFM4=1
....
INSTALL libbpf_headers
  CC      util/pfm.o
util/pfm.c: In function ‘print_libpfm_event’:
util/pfm.c:189:9: error: too many arguments to function ‘print_cb->print_event’
  189 |         print_cb->print_event(print_state,
      |         ^~~~~~~~
util/pfm.c:220:25: error: too many arguments to function ‘print_cb->print_event’
  220 |                         print_cb->print_event(print_state,

The build error is caused by
commit d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
which changes the function prototype of
  struct print_callbacks {
      ...
      void (*print_event)(...);  --> last two parameters removed.
  };

but does not adjust the usage of this function prototype in util/pfm.c.
In file util/pfm.c function print_event() is still invoked with 13 parameters
instead of 11. The compile fails.

When I adjust the file util/pfm.c as in this patch, the build works file.
Please check this patch for correctness, I have just fixed the compile
issue.

Fixes d9dc8874d6ce ("perf pmu-events: Remove now unused event and metric variables")
Cc: irogers@google.com
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 tools/perf/util/pfm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index ac3227ba769c..b59ba825ddc9 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -193,8 +193,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 			/*scale_unit=*/NULL,
 			/*deprecated=*/NULL, "PFM event",
 			info->desc, /*long_desc=*/NULL,
-			/*encoding_desc=*/buf->buf,
-			/*metric_name=*/NULL, /*metric_expr=*/NULL);
+			/*encoding_desc=*/buf->buf);
 
 	pfm_for_each_event_attr(j, info) {
 		pfm_event_attr_info_t ainfo;
@@ -224,8 +223,7 @@ print_libpfm_event(const struct print_callbacks *print_cb, void *print_state,
 					/*scale_unit=*/NULL,
 					/*deprecated=*/NULL, "PFM event",
 					ainfo.desc, /*long_desc=*/NULL,
-					/*encoding_desc=*/buf->buf,
-					/*metric_name=*/NULL, /*metric_expr=*/NULL);
+					/*encoding_desc=*/buf->buf);
 		}
 	}
 }
-- 
2.39.1

