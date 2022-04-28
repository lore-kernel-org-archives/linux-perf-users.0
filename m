Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176E9C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Apr 2022 15:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbiD1PMP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiD1PMO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Apr 2022 11:12:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEE3AF1E6
        for <linux-perf-users@vger.kernel.org>; Thu, 28 Apr 2022 08:08:59 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SF6EFZ036517;
        Thu, 28 Apr 2022 15:08:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=RJIkd+tgKfSnkJ0v+n0oh1N70fr51pqdau+bA0HLRto=;
 b=T0osE3NwJ5n2hQRH5pWtroUXzsQOLVapQc7eqJhDK/1woUgcvIuHIwh9Acy2N39Qx6TS
 W/Nw/FreyCm1KD7gtaBX/A5imCT11Qt4YdWq7KYKCqo4EPQJoBNGMeEUndoBkDUHEY+v
 ewLEBnT9+4nPZqqvnLU1PRXESFnsZrpWrqkC3Cbhljp2j6yjMvBJvv/UW6Tb2h8tAEN/
 VMR/+TDLfTxjE8c2iU6h0Y2FwTmHH97FTeUe0/Eg6eI5jOZyVKJv4xC0Hk4MXWPB/kYj
 4cJmtMBtKoaOoGZiwYX7Qg3m1erFmUc1vLo1VzdpGuLdRmHDXdkCMWgx1RsY4UkXpax0 qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvap9m4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:08:50 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23SF74qr000328;
        Thu, 28 Apr 2022 15:08:50 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fqvap9m3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:08:50 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23SEwcB9009605;
        Thu, 28 Apr 2022 15:08:47 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj7qqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Apr 2022 15:08:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23SF8iuM47972816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 15:08:44 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6802AA405C;
        Thu, 28 Apr 2022 15:08:44 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67981A4054;
        Thu, 28 Apr 2022 15:08:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.163.4.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Apr 2022 15:08:39 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org, disgoel@linux.vnet.ibm.com
Cc:     mpe@ellerman.id.au, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        rnsastry@linux.ibm.com, kjain@linux.ibm.com, irogers@google.com
Subject: [PATCH 1/2] tools/perf: Add utility function to read /proc/cpuinfo for any field
Date:   Thu, 28 Apr 2022 20:38:28 +0530
Message-Id: <20220428150829.30733-2-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428150829.30733-1-atrajeev@linux.vnet.ibm.com>
References: <20220428150829.30733-1-atrajeev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BdSbWH6hDF6bbF_GalXGSqPY4JRPvuvW
X-Proofpoint-GUID: 65of7KKPjdp5PZUX4t5vFrXKcCcVlXFM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280091
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

/proc/cpuinfo provides information about type of processor, number
of CPU's etc. Reading /proc/cpuinfo file outputs useful information
by field name like cpu, platform, model (depending on architecture)
and its value separated by colon.

Add new utility function "cpuinfo_field" in "util/header.c" which
accepts field name as input string to search in /proc/cpuinfo content.
This returns the first matching value as resulting string. Example,
calling the function "cpuinfo_field(platform)" in powerpc returns
the platform value. This can be used to fetch processor information
from "cpuinfo" by other utilities/testcases.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/util/header.c | 54 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a27132e5a5ef..0c8dfd0c1e78 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -983,6 +983,60 @@ static int write_dir_format(struct feat_fd *ff,
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
+/*
+ * Return entry from /proc/cpuinfo
+ * indicated by "search" parameter.
+ */
+char *cpuinfo_field(const char *search)
+{
+	FILE *file;
+	char *buf = NULL;
+	char *copy_buf = NULL, *p;
+	size_t len = 0;
+	int ret = -1;
+
+	if (!search)
+		return NULL;
+
+	file = fopen("/proc/cpuinfo", "r");
+	if (!file)
+		return NULL;
+
+	while (getline(&buf, &len, file) > 0) {
+		ret = strncmp(buf, search, strlen(search));
+		if (!ret)
+			break;
+	}
+
+	if (ret)
+		goto done;
+
+	/*
+	 * Trim the new line and separate
+	 * value for search field from ":"
+	 * in cpuinfo line output.
+	 * Example output line:
+	 * platform : <value>
+	 */
+	copy_buf = buf;
+	p = strchr(copy_buf, ':');
+	if (p && *(p+1) == ' ' && *(p+2))
+		copy_buf = p + 2;
+	p = strchr(copy_buf, '\n');
+	if (p)
+		*p = '\0';
+
+	/* Copy the filtered string to buf */
+	strcpy(buf, copy_buf);
+
+	fclose(file);
+	return buf;
+
+done:
+	free(buf);
+	fclose(file);
+	return NULL;
+}
 /*
  * Check whether a CPU is online
  *
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0eb4bc29a5a4..b0f754364bd4 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -166,4 +166,5 @@ int get_cpuid(char *buffer, size_t sz);
 
 char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused);
 int strcmp_cpuid_str(const char *s1, const char *s2);
+char *cpuinfo_field(const char *search);
 #endif /* __PERF_HEADER_H */
-- 
2.35.1

