Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F32C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3198161409
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhJEJV7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:21:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJEJV6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 05:21:58 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1958g82k024319;
        Tue, 5 Oct 2021 05:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=4KWtlySNTnqXB8CFgnNbWgTinUBqt+TDSXQNhwqkcs0=;
 b=TaBfo1H0odQKIJBKeAPqkw8VXiyPhQMhJIR5owlTZLhHog8FXrsCVWXWXyPYHfZm+RC+
 wFJHT5OzLobwG7Anodh4DVj2sX55UrkE6VLlyGNPziCV2DZhdgeSoFsUuBgGre3PmZHl
 hRf17OTsO51rYn8mIdWa7cr5r2d55O+2Omnce4g5vjfrm3fHeUzcUVFr2SvNdqBqoiY+
 VfV5MEwXQgfW75tJ1Sw496Rw5HZB3FkynwrGUOsExHc29DsK5w2R880380+yw8ehoG0f
 EKG++wHnKtdpHhjN/7TVTdVpfAgtsHD9Zi4qIgleLvp3j7/dRD4nCMnDVp+UIeEowaXZ eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgkdw8rx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 05:19:22 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1959I2sL025054;
        Tue, 5 Oct 2021 05:19:22 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bgkdw8rw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 05:19:21 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1959CViH022035;
        Tue, 5 Oct 2021 09:19:18 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3beepjgfkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Oct 2021 09:19:18 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1959JDuA40173884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Oct 2021 09:19:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EAD8A4080;
        Tue,  5 Oct 2021 09:19:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7A96A406F;
        Tue,  5 Oct 2021 09:19:03 +0000 (GMT)
Received: from li-e8dccbcc-2adc-11b2-a85c-bc1f33b9b810.ibm.com.com (unknown [9.43.64.84])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Oct 2021 09:19:03 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, ak@linux.intel.com
Cc:     linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        yao.jin@linux.intel.com, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, kan.liang@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        paulus@samba.org, kjain@linux.ibm.com
Subject: [PATCH 1/4] perf: Add comment about current state of PERF_MEM_LVL_* namespace and remove an extra line
Date:   Tue,  5 Oct 2021 14:48:34 +0530
Message-Id: <20211005091837.250044-1-kjain@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tGFMIXsCZcH_fh0aN6SIELorgBuR0UKd
X-Proofpoint-GUID: 1wCRPklwI3u1dYJI1JF0PA0VZpJADI8p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-04_05,2021-10-04_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050052
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add a comment about PERF_MEM_LVL_* namespace being depricated
to some extent in favour of added PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_}
fields.

Remove an extra line present in perf_mem__lvl_scnprintf function.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 include/uapi/linux/perf_event.h       | 8 +++++++-
 tools/include/uapi/linux/perf_event.h | 8 +++++++-
 tools/perf/util/mem-events.c          | 1 -
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index f92880a15645..e1701e9c7858 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1241,7 +1241,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index f92880a15645..e1701e9c7858 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -1241,7 +1241,13 @@ union perf_mem_data_src {
 #define PERF_MEM_OP_EXEC	0x10 /* code (execution) */
 #define PERF_MEM_OP_SHIFT	0
 
-/* memory hierarchy (memory level, hit or miss) */
+/*
+ * PERF_MEM_LVL_* namespace being depricated to some extent in the
+ * favour of newer composite PERF_MEM_{LVLNUM_,REMOTE_,SNOOPX_} fields.
+ * Supporting this namespace inorder to not break defined ABIs.
+ *
+ * memory hierarchy (memory level, hit or miss)
+ */
 #define PERF_MEM_LVL_NA		0x01  /* not available */
 #define PERF_MEM_LVL_HIT	0x02  /* hit level */
 #define PERF_MEM_LVL_MISS	0x04  /* miss level  */
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index f0e75df72b80..ff7289e28192 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -320,7 +320,6 @@ int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info)
 	/* already taken care of */
 	m &= ~(PERF_MEM_LVL_HIT|PERF_MEM_LVL_MISS);
 
-
 	if (mem_info && mem_info->data_src.mem_remote) {
 		strcat(out, "Remote ");
 		l += 7;
-- 
2.26.2

