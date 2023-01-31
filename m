Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B70C636CC
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Jan 2023 13:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAaNsP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjAaNsO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Jan 2023 08:48:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0956A5D
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Jan 2023 05:48:13 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VCiql5022738;
        Tue, 31 Jan 2023 13:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9aK4cFggMryiT0MhB5AvN3YyalJ9FXATpUbI/oGOCYg=;
 b=CHkOj8FvRD0F0kZB83TOSvjX19CV5EiunDnG7S+zexeYE0ROgSPtcm8XCq/zMl+uNjeD
 3t/NVN3/qOPMf9zeKM4HF0ej093flNVhL0MgPW4SHmbVBrDuJPHA3MroJ0KaCyJYVHMh
 oc2vIxtLY++Cz1+9vqEVhRit24azwjhP+vS73fQP8sNL6ixGlAwaGJ1P3dc8h7WkPpjP
 P/0TQqA6MD/20g4mgMdvOGal1VP6xpWh/aYjYSq2rqK58RTaiXf0mX3Nj6v4oPaE8+dQ
 Re1PxhCvIIHbZGRThi6GVxI6AmJ0VqhfbWGSNGc5DxneEMcfFExuwqpbLgxlybNVoXIT 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf390hj5d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:48:00 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30VCxQGd017674;
        Tue, 31 Jan 2023 13:47:59 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf390hj45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:47:59 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30UL5TmG030067;
        Tue, 31 Jan 2023 13:47:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ncvshaheg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:47:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VDlqd648234894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 13:47:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0F1E20049;
        Tue, 31 Jan 2023 13:47:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4E5E20043;
        Tue, 31 Jan 2023 13:47:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.7.122])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 13:47:49 +0000 (GMT)
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To:     acme@kernel.org, jolsa@kernel.org
Cc:     ak@linux.intel.com, namhyung@kernel.org, irogers@google.com,
        james.clark@arm.com, mpe@ellerman.id.au,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Subject: [PATCH] tools/perf: Fix usage of perf probe when libtraceevent is missing
Date:   Tue, 31 Jan 2023 19:17:48 +0530
Message-Id: <20230131134748.54567-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sRckJtM181nNpEixJH3bg9aLqErNWjzg
X-Proofpoint-ORIG-GUID: EaGa8nfo2S_oJc4oHXtx7zopA04Ivv0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310121
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

While parsing the tracepoint events in parse_events_add_tracepoint()
function, code checks for HAVE_LIBTRACEEVENT support. This is needed
since libtraceevent is necessary for tracepoint. But while adding
probe points, check for LIBTRACEEVENT is not done in case of perf probe.
Hence, in environment with missing libtraceevent-devel, it is
observed that adding a probe point shows below message though it
can't be used via perf record.

Example:
Adding probe point:
	./perf probe 'vfs_getname=getname_flags:72 pathname=result->name:string'
	Added new event:
	  probe:vfs_getname    (on getname_flags:72 with pathname=result->name:string)

	You can now use it in all perf tools, such as:

		perf record -e probe:vfs_getname -aR sleep 1

But trying perf record:
	./perf  record -e probe:vfs_getname -aR sleep 1
	event syntax error: 'probe:vfs_getname'
				\___ unsupported tracepoint
	libtraceevent is necessary for tracepoint support
	Run 'perf list' for a list of valid events

The builtin tool like perf record needs libtraceevent to
parse tracefs. But still the probe can be used by enabling
via tracefs. Patch fixes the probe usage message to the user
based on presence of libtraceevent. With the fix,

 # ./perf probe 'pmu:myprobe=schedule'
 Added new event:
   pmu:myprobe          (on schedule)

 perf is not linked with libtraceevent, to use the new probe you can use tracefs:

	cd /sys/kernel/tracing/
	echo 1 > events/pmu/myprobe/enable
	echo 1 > tracing_on
	cat trace_pipe
	Before removing the probe, echo 0 > events/pmu/myprobe/enable

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/builtin-probe.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index ed73d0b89ca2..e72f6cea76f7 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -383,9 +383,18 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
 
 	/* Note that it is possible to skip all events because of blacklist */
 	if (event) {
+#ifndef HAVE_LIBTRACEEVENT
+		pr_info("\nperf is not linked with libtraceevent, to use the new probe you can use tracefs:\n\n");
+		pr_info("\tcd /sys/kernel/tracing/\n");
+		pr_info("\techo 1 > events/%s/%s/enable\n", group, event);
+		pr_info("\techo 1 > tracing_on\n");
+		pr_info("\tcat trace_pipe\n");
+		pr_info("\tBefore removing the probe, echo 0 > events/%s/%s/enable\n", group, event);
+#else
 		/* Show how to use the event. */
 		pr_info("\nYou can now use it in all perf tools, such as:\n\n");
 		pr_info("\tperf record -e %s:%s -aR sleep 1\n\n", group, event);
+#endif
 	}
 
 out_cleanup:
-- 
2.39.0

