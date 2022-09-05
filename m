Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E089CECAAD3
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Sep 2022 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiIEOT7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238060AbiIEOTv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 10:19:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17514D1A
        for <linux-perf-users@vger.kernel.org>; Mon,  5 Sep 2022 07:19:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 285D0ceM011284;
        Mon, 5 Sep 2022 14:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FraiXt2QxafFMXEBwYIVY6B6bOaa1PFeujW1/oKLjsQ=;
 b=h00m5mDRVjJc94qvtT3YyCPs/FYSkyu9RHo4PP6aoqfXa0b8ugBokFVgG17cp6qRmDnT
 pUJMcQtG1aRlNmq4YxrQr+MOybxhOhcp99BlG38uUZWqsiUDuRA2G4a3DAMF3nR39Zd8
 07LQ59xMnS3kBPjb1jK8Olc+8Lav6GODOleL2cRYu4LVCdmnQDhHjfsVrNp325AOvWIz
 qy28jq4APaUpdwBa3bufPgI5je4tHX5tLiayyMqCq7YMwyfz4+/wPbLNte19a1cOgpIp
 zYObo6OZg/vXswk/uLf13OaKQ//D9G+Ag8pl1vrDlGQGQU1bwg4xE3mqpjwB+KL8jVWO Kg== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jdhm5affh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 14:19:38 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 285E85hw001848;
        Mon, 5 Sep 2022 14:19:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3jbxj8svd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 14:19:36 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 285EJX6430736716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 14:19:33 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E982AE04D;
        Mon,  5 Sep 2022 14:19:33 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D1DCAE045;
        Mon,  5 Sep 2022 14:19:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.39.18])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 14:19:31 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH V2 1/2] tools/perf: Fix out of bound access to affinity "sched_cpus"
Date:   Mon,  5 Sep 2022 19:49:28 +0530
Message-Id: <20220905141929.7171-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -bf6OPbPgPdRbus08R138QXWKuHYfxlk
X-Proofpoint-ORIG-GUID: -bf6OPbPgPdRbus08R138QXWKuHYfxlk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-05_09,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209050067
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The affinity code in "affinity_set" function access array
named "sched_cpus". The size for this array is allocated in
affinity_setup function which is nothing but value from
get_cpu_set_size. This is used to contain the cpumask value
for each cpu. While setting bit for each cpu, it calls
"set_bit" function which access index in sched_cpus array.
If we provide a command-line option to -C which is more than
the number of CPU's present in the system, the set_bit could
access an array member which is out-of the array size. This
is because currently, there is no boundary check for the CPU.
This will result in seg fault:

<<>>
 ./perf stat -C 12323431 ls
Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS
Segmentation fault (core dumped)
<<>>

Fix this by adding boundary check for the array.

After the fix from powerpc system:

<<>>
./perf stat -C 12323431 ls 1>out
Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS

 Performance counter stats for 'CPU(s) 12323431':

   <not supported> msec cpu-clock
   <not supported>      context-switches
   <not supported>      cpu-migrations
   <not supported>      page-faults
   <not supported>      cycles
   <not supported>      instructions
   <not supported>      branches
   <not supported>      branch-misses

       0.001192373 seconds time elapsed
<<>>

Reported-by: Nageswara Sastry <rnsastry@linux.ibm.com>
Tested-by: Nageswara Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 From v1 -> v2:
 Addressed review comment from Jiri Olsa by changing condition
 check to directly use "cpu_set_size * 8" for comparing with the
 cpu number.

 tools/perf/util/affinity.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
index 4d216c0dc425..4ee96b3c755b 100644
--- a/tools/perf/util/affinity.c
+++ b/tools/perf/util/affinity.c
@@ -49,8 +49,14 @@ void affinity__set(struct affinity *a, int cpu)
 {
 	int cpu_set_size = get_cpu_set_size();
 
-	if (cpu == -1)
+	/*
+	 * Return:
+	 * - if cpu is -1
+	 * - restrict out of bound access to sched_cpus
+	 */
+	if (cpu == -1 || ((cpu >= (cpu_set_size * 8))))
 		return;
+
 	a->changed = true;
 	set_bit(cpu, a->sched_cpus);
 	/*
-- 
2.35.1

