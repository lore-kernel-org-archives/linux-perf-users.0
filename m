Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Aug 2023 05:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjHKFVp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Aug 2023 01:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjHKFVo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Aug 2023 01:21:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55A2D43
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Aug 2023 22:21:43 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37B4qvvN005490;
        Fri, 11 Aug 2023 05:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9l8vPvoK8yrX9U4uziLBRmTJjQno2TXZK4U204VeK3w=;
 b=qoDoOPI9k/bM3rws29ccOeTxwFcDPYunWRM8o5lJcSpxuniSLhNysETKYeKSUfOy5fH3
 7Z1yvLIncJsszmX4qZ/hxIcBJbZ7meTvWST5tI2aNDoKGEupDw+1+HefGCGk44Y89NQB
 YQAONdZziKMC8TOzc16CDkYSYe6rV9Hv4boA9vW8lP5OLMPRv0FTQ5HlrjbInTjsWmuy
 rhmtxOt7bPhxiamwDmy+ZNJ/wumLlh/XPVQKPfQ7ReWqRjivC70rMco+p3/hMByALSLD
 7dX0H0mRd7tJzak1tq/edeu9SD6z1eL4TWLU4nygJJgBQz6WgsQ2Ed8YiqhayiyUGdT+ dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdebrgkde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:21:39 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37B5EUH9009782;
        Fri, 11 Aug 2023 05:21:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdebrgkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:21:38 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37B2wLt4006432;
        Fri, 11 Aug 2023 05:21:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2evd8en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 05:21:37 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37B5LYFm23397090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 05:21:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 096E12005A;
        Fri, 11 Aug 2023 05:21:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A106C2004D;
        Fri, 11 Aug 2023 05:21:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.95.190])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 11 Aug 2023 05:21:31 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, irogers@google.com,
        namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: [PATCH 1/2] tools/perf: Add text_end to "struct dso" to save .text section size
Date:   Fri, 11 Aug 2023 10:51:27 +0530
Message-Id: <20230811052128.70282-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YdNLeToOOWK1_TIdb4rg2f4MMr1kM0xf
X-Proofpoint-ORIG-GUID: n_7RX8nV6hBf_8KhuJdGwRk3fYpveWao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308110046
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Update "struct dso" to include new member "text_end".
This new field will represent the offset for end of text
section for a dso. This value is derived as:
sh_size (Size of section in byes) + sh_offset (Section file
offst) of the elf header for text.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/dso.h        | 1 +
 tools/perf/util/symbol-elf.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index b41c9782c754..70fe0fe69bef 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -181,6 +181,7 @@ struct dso {
 	u8		 rel;
 	struct build_id	 bid;
 	u64		 text_offset;
+	u64		 text_end;
 	const char	 *short_name;
 	const char	 *long_name;
 	u16		 long_name_len;
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 8bd466d1c2bd..252d26a59e64 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1512,8 +1512,10 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	}
 
 	if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshdr,
-				".text", NULL))
+				".text", NULL)) {
 		dso->text_offset = tshdr.sh_addr - tshdr.sh_offset;
+		dso->text_end = tshdr.sh_offset + tshdr.sh_size;
+	}
 
 	if (runtime_ss->opdsec)
 		opddata = elf_rawdata(runtime_ss->opdsec, NULL);
-- 
2.31.1

