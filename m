Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD326ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Sep 2022 04:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIEEzF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 5 Sep 2022 00:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiIEEzE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 5 Sep 2022 00:55:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61F21837
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Sep 2022 21:55:02 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28541KH4018626;
        Mon, 5 Sep 2022 04:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3Mu2d0c6v8vZ6us4SFYqeK9NDC6MEcp3sH5VFKCno6k=;
 b=AAJSHRe5YtCLAqsvn3xUT09h9q0rjiej+urAh6LVOx/17glTJpLVBxEHI0Lx+riWz54Q
 rdK0h7qbsbJBjWI0neOfmxsJ9nOqqiDsm607HD9pIQ/3vJg4A5fwhLj3h7P6NFgYSImK
 l4afmTsoR5JlvEd4wrU+zkdb0h+7H8opkgTVi15bGAQJIzYZWGBU9oKIq9Ax5I2DALba
 jY7eSePqiQNd53N9yYW2zqUqir6vZsUewNGvcmQRIbZVmuqP8BcIGLtn4hQv/f5DqSVj
 iocldWKnPtRDrRvJezdDt6/OtFk/LqZ4GHQTfmBQezvdh+/NkbaNewjZ06b1LSBz8DYp hA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jd845tt37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 04:54:54 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2854o37g024829;
        Mon, 5 Sep 2022 04:54:52 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jbxj8sw05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Sep 2022 04:54:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2854tCrp45023512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Sep 2022 04:55:12 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E07DEA4040;
        Mon,  5 Sep 2022 04:54:48 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5F41A4051;
        Mon,  5 Sep 2022 04:54:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.52.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  5 Sep 2022 04:54:46 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com
Subject: [PATCH 2/2] tools/perf: Fix out of bound access to cpu mask array
Date:   Mon,  5 Sep 2022 10:24:41 +0530
Message-Id: <20220905045441.1643-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220905045441.1643-1-atrajeev@linux.vnet.ibm.com>
References: <20220905045441.1643-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ysz9oca1HPlZCoCmOZBhRMfoKoJyoRA8
X-Proofpoint-GUID: Ysz9oca1HPlZCoCmOZBhRMfoKoJyoRA8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_02,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050020
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The cpu mask init code in "record__mmap_cpu_mask_init"
function access "bits" array part of "struct mmap_cpu_mask".
The size of this array is the value from cpu__max_cpu().cpu.
This array is used to contain the cpumask value for each
cpu. While setting bit for each cpu, it calls "set_bit" function
which access index in "bits" array. If we provide a command
line option to -C which is greater than the number of CPU's
present in the system, the set_bit could access an array
member which is out-of the array size. This is because
currently, there is no boundary check for the CPU. This will
result in seg fault:

<<>>
./perf record -C 12341234 ls
Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS
Segmentation fault (core dumped)
<<>>

Debugging with gdb, points to function flow as below:

<<>>
set_bit
record__mmap_cpu_mask_init
record__init_thread_default_masks
record__init_thread_masks
cmd_record
<<>>

Fix this by adding boundary check for the array.

After the patch:
<<>>
./perf record -C 12341234 ls
Perf can support 2048 CPUs. Consider raising MAX_NR_CPUS
Failed to initialize parallel data streaming masks
<<>>

With this fix, if -C is given a non-exsiting CPU, perf
record will fail with:

<<>>
 ./perf record -C 50 ls
Failed to initialize parallel data streaming masks
<<>>

Reported-by: Nageswara Sastry <rnsastry@linux.ibm.com>
Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/builtin-record.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4713f0f3a6cf..09b68d76bbdc 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3358,16 +3358,22 @@ static struct option __record_options[] = {
 
 struct option *record_options = __record_options;
 
-static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
+static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
 {
 	struct perf_cpu cpu;
 	int idx;
 
 	if (cpu_map__is_dummy(cpus))
-		return;
+		return 0;
 
-	perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
+		/* Return ENODEV is input cpu is greater than max cpu */
+		if ((unsigned long)cpu.cpu > mask->nbits)
+			return -ENODEV;
 		set_bit(cpu.cpu, mask->bits);
+	}
+
+	return 0;
 }
 
 static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
@@ -3379,7 +3385,9 @@ static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const cha
 		return -ENOMEM;
 
 	bitmap_zero(mask->bits, mask->nbits);
-	record__mmap_cpu_mask_init(mask, cpus);
+	if (record__mmap_cpu_mask_init(mask, cpus))
+		return -ENODEV;
+
 	perf_cpu_map__put(cpus);
 
 	return 0;
@@ -3461,7 +3469,12 @@ static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_ma
 		pr_err("Failed to allocate CPUs mask\n");
 		return ret;
 	}
-	record__mmap_cpu_mask_init(&cpus_mask, cpus);
+
+	ret = record__mmap_cpu_mask_init(&cpus_mask, cpus);
+	if (ret) {
+		pr_err("Failed to init cpu mask\n");
+		goto out_free_cpu_mask;
+	}
 
 	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu().cpu);
 	if (ret) {
@@ -3702,7 +3715,8 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
 	if (ret)
 		return ret;
 
-	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
+	if (record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus))
+		return -ENODEV;
 
 	rec->nr_threads = 1;
 
-- 
2.35.1

