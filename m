Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EC13BACC
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476511; cv=none; b=KTn4ryv86i2NhLECoU+z/kF+maIujwnhViq96JvelWgxDC0+vzPVlWPXZXDbTjAXY3+PzjOPnDoUnCGYjSMU3X15zpCuzcDOhVWa0ga72KL0hTMqiPaD+zYMhA/7wpJIuv2GJu2YBsTodTqPwDIYP6DNwWscyTG6oxZ6CwBIIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476511; c=relaxed/simple;
	bh=9mTHoJuZjsGaopDWQjo1/3rSUGdIezqQlvyuXMuGowI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpcMMZRlJ0Ys1Abr7Z90N7xWNU1dsUSKLkofYnHYiJ1w1k6EkGp3JkkErLZJkG5mfCVuH1saemmmIrSXPMZajjOp0ecP1hAsq0RMJO3rzAf502AGj1OJIOtTv2MuocICvaTS6gQkyw0UmqPPVvXyqbrWw/Ebc2nZVEMLrOBSnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NLB+5qWL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NLB+5qWL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484Ilf16027146;
	Wed, 4 Sep 2024 19:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=wz5GGNrv6JCVD
	Sa+G0YOXgP+iBiQGs5g8w/UA6FykoE=; b=NLB+5qWLY8t2yL7PKjDHMh/RVAeYp
	HgaWohS5yBD3KJOOJUPfwXYfuAE6mJ3erbT8x99XCFbxkefT5A/6ALoidxNscHlK
	XWMYhlThc8dbL48rswLp8FKotG8WY3eKfDRW7+kU5tdiI59P/a4mUtMLHPeABs9U
	OVUAZpmBSmA9Y+pHWkJfHUvU5Ms5DHac1f9mKVWkxaqKetWHeMg/chlzECM1pTLP
	+Pny9bMTgv84XNdXku3x82YcFc9GrXpRT/oy5FdVnRxjjqLNocShHFP/NN1HLSTY
	tuboeOb7AmMSn0FTSj5oKi1KinSzRYmmrO3nN3sVM9pY3uTCIizyvCDyA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btux4tf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:44 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 484IxFar019872;
	Wed, 4 Sep 2024 19:01:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41btux4tew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 484IJr8B007940;
	Wed, 4 Sep 2024 19:01:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41cfqn0xc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 19:01:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 484J1dW842402232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Sep 2024 19:01:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D2C20043;
	Wed,  4 Sep 2024 19:01:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC60320040;
	Wed,  4 Sep 2024 19:01:36 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown [9.39.16.11])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Sep 2024 19:01:36 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v15 1/7] libsubcmd: Don't free the usage string
Date: Thu,  5 Sep 2024 00:31:26 +0530
Message-ID: <20240904190132.415212-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904190132.415212-1-adityag@linux.ibm.com>
References: <20240904190132.415212-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9XerUix-i24poF919PAqsmFuWYwOGlqc
X-Proofpoint-ORIG-GUID: R_eaUFZvhnnMoHHU16xc-aLGRQwG3let
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_16,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040140

Currently, commands which depend on 'parse_options_subcommand()' don't
show the usage string, and instead show '(null)'

    $ ./perf sched
	Usage: (null)

    -D, --dump-raw-trace  dump raw trace in ASCII
    -f, --force           don't complain, do it
    -i, --input <file>    input file name
    -v, --verbose         be more verbose (show symbol address, etc)

'parse_options_subcommand()' is generally expected to initialise the usage
string, with information in the passed 'subcommands[]' array

This behaviour was changed in:

  230a7a71f92212e7 ("libsubcmd: Fix parse-options memory leak")

Where the generated usage string is deallocated, and usage[0] string is
reassigned as NULL.

As discussed in [1], free the allocated usage string in the main
function itself, and don't reset usage string to NULL in
parse_options_subcommand

With this change, the behaviour is restored.

    $ ./perf sched
        Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

           -D, --dump-raw-trace  dump raw trace in ASCII
           -f, --force           don't complain, do it
           -i, --input <file>    input file name
           -v, --verbose         be more verbose (show symbol address, etc)

[1]: https://lore.kernel.org/linux-perf-users/htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e/

Fixes: 230a7a71f92212e7 ("libsubcmd: Fix parse-options memory leak")
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/r/20240904061836.55873-2-adityag@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 8 +++-----
 tools/perf/builtin-kmem.c        | 2 ++
 tools/perf/builtin-kvm.c         | 3 +++
 tools/perf/builtin-kwork.c       | 3 +++
 tools/perf/builtin-lock.c        | 3 +++
 tools/perf/builtin-mem.c         | 3 +++
 tools/perf/builtin-sched.c       | 3 +++
 7 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 4b60ec03b0bb..eb896d30545b 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,10 +633,11 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
-	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
+		char *buf = NULL;
+
 		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
 
 		for (int i = 0; subcommands[i]; i++) {
@@ -678,10 +679,7 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-	if (buf) {
-		usagestr[0] = NULL;
-		free(buf);
-	}
+
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b3cbac40b8c7..a756147e2eec 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -2057,6 +2057,8 @@ int cmd_kmem(int argc, const char **argv)
 
 out_delete:
 	perf_session__delete(session);
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kmem_usage[0]);
 
 	return ret;
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 692267b1b7e8..55ea17c5ff02 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2184,5 +2184,8 @@ int cmd_kvm(int argc, const char **argv)
 	else
 		usage_with_options(kvm_usage, kvm_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kvm_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 6a4281b8fd10..c1daf82c9b92 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2519,5 +2519,8 @@ int cmd_kwork(int argc, const char **argv)
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kwork_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 2c216427e929..062e2b56a2ab 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2712,6 +2712,9 @@ int cmd_lock(int argc, const char **argv)
 		usage_with_options(lock_usage, lock_options);
 	}
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)lock_usage[0]);
+
 	zfree(&lockhash_table);
 	return rc;
 }
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 18e5f9a0ddc2..bb38bb5a1c26 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -546,5 +546,8 @@ int cmd_mem(int argc, const char **argv)
 	else
 		usage_with_options(mem_usage, mem_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)mem_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 0a7b2b2acd56..5981cc51abc8 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3954,5 +3954,8 @@ int cmd_sched(int argc, const char **argv)
 		usage_with_options(sched_usage, sched_options);
 	}
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)sched_usage[0]);
+
 	return 0;
 }
-- 
2.46.0

