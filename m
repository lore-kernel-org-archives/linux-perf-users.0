Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646C4C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 11:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D25960EE5
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Oct 2021 11:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhJRLwU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 07:52:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231493AbhJRLwT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Oct 2021 07:52:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19IAKeP3013043;
        Mon, 18 Oct 2021 07:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qH77bcujz8a0KbKrVFbusdAeLe1Zg2ePPVU4SvPTDgk=;
 b=NvHNFZULnWIQFqMsnr2d0ggc803dJysajprwxBu2fcdgj5HKtS3MypNKY09QNF4S7Plr
 Pp1lHcSYcGcX6xFodkSq0Q0XHMl3ik16Ms615meWBZrbvnZVDWfR1qP4m4sm+ZNTACg+
 mlU6ayzY1hUMDAXJEhGj6tW8CEuwS89JyteiNXJwqFjoxwsm6c3zQuDYW5DS9I2vMVVD
 wnm8YED5DAVCN83qbmbgo04V5zDIEjEVRzV1XnpWVIQ1Bg47TOkgxvyHom/geSc6vKAf
 wMiolGjLQuKpU1KDmAQdO9OwXHSDlswp/GFhR1nN24sBzEZ54aCkHrsOGB5wEnnyCjnz XQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bs4f1wdkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 07:50:01 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19IBlXBw014043;
        Mon, 18 Oct 2021 11:49:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bqp0jds99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 11:49:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19IBnulo50135412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Oct 2021 11:49:56 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED99D5204E;
        Mon, 18 Oct 2021 11:49:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.190.48])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2790E5205F;
        Mon, 18 Oct 2021 11:49:53 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [V4 2/2] tools/perf: Add perf tools support to expose instruction and data address registers as part of extended regs
Date:   Mon, 18 Oct 2021 17:19:48 +0530
Message-Id: <20211018114948.16830-3-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018114948.16830-1-atrajeev@linux.vnet.ibm.com>
References: <20211018114948.16830-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JI6qBXK9Le8_jxgrlJpQbGADww6FXOLM
X-Proofpoint-ORIG-GUID: JI6qBXK9Le8_jxgrlJpQbGADww6FXOLM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_03,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=900
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110180071
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Patch enables presenting of Sampled Instruction Address Register (SIAR)
and Sampled Data Address Register (SDAR) SPRs as part of extended regsiters
for perf tool. Add these SPR's to sample_reg_mask in the tool side (to use
with -I? option).

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
---
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 11 +++++++----
 tools/perf/arch/powerpc/include/perf_regs.h     |  2 ++
 tools/perf/arch/powerpc/util/perf_regs.c        |  2 ++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
index 085094553f3b..749a2e3af89e 100644
--- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -61,17 +61,19 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_PMC4,
 	PERF_REG_POWERPC_PMC5,
 	PERF_REG_POWERPC_PMC6,
+	PERF_REG_POWERPC_SDAR,
+	PERF_REG_POWERPC_SIAR,
 	/* Max mask value for interrupt regs w/o extended regs */
 	PERF_REG_POWERPC_MAX = PERF_REG_POWERPC_MMCRA + 1,
 	/* Max mask value for interrupt regs including extended regs */
-	PERF_REG_EXTENDED_MAX = PERF_REG_POWERPC_PMC6 + 1,
+	PERF_REG_EXTENDED_MAX = PERF_REG_POWERPC_SIAR + 1,
 };
 
 #define PERF_REG_PMU_MASK	((1ULL << PERF_REG_POWERPC_MAX) - 1)
 
 /*
  * PERF_REG_EXTENDED_MASK value for CPU_FTR_ARCH_300
- * includes 9 SPRS from MMCR0 to PMC6 excluding the
+ * includes 11 SPRS from MMCR0 to SIAR excluding the
  * unsupported SPRS MMCR3, SIER2 and SIER3.
  */
 #define PERF_REG_PMU_MASK_300	\
@@ -79,11 +81,12 @@ enum perf_event_powerpc_regs {
 	(1ULL << PERF_REG_POWERPC_MMCR2) | (1ULL << PERF_REG_POWERPC_PMC1) | \
 	(1ULL << PERF_REG_POWERPC_PMC2) | (1ULL << PERF_REG_POWERPC_PMC3) | \
 	(1ULL << PERF_REG_POWERPC_PMC4) | (1ULL << PERF_REG_POWERPC_PMC5) | \
-	(1ULL << PERF_REG_POWERPC_PMC6))
+	(1ULL << PERF_REG_POWERPC_PMC6) | (1ULL << PERF_REG_POWERPC_SDAR) | \
+	(1ULL << PERF_REG_POWERPC_SIAR))
 
 /*
  * PERF_REG_EXTENDED_MASK value for CPU_FTR_ARCH_31
- * includes 12 SPRs from MMCR0 to PMC6.
+ * includes 14 SPRs from MMCR0 to SIAR.
  */
 #define PERF_REG_PMU_MASK_31	\
 	(PERF_REG_PMU_MASK_300 | (1ULL << PERF_REG_POWERPC_MMCR3) | \
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 04e5dc07e93f..93339d17acc4 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -77,6 +77,8 @@ static const char *reg_names[] = {
 	[PERF_REG_POWERPC_PMC4] = "pmc4",
 	[PERF_REG_POWERPC_PMC5] = "pmc5",
 	[PERF_REG_POWERPC_PMC6] = "pmc6",
+	[PERF_REG_POWERPC_SDAR] = "sdar",
+	[PERF_REG_POWERPC_SIAR] = "siar",
 };
 
 static inline const char *__perf_reg_name(int id)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index 8116a253f91f..8d07a78e742a 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -74,6 +74,8 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(pmc4, PERF_REG_POWERPC_PMC4),
 	SMPL_REG(pmc5, PERF_REG_POWERPC_PMC5),
 	SMPL_REG(pmc6, PERF_REG_POWERPC_PMC6),
+	SMPL_REG(sdar, PERF_REG_POWERPC_SDAR),
+	SMPL_REG(siar, PERF_REG_POWERPC_SIAR),
 	SMPL_REG_END
 };
 
-- 
2.33.0

