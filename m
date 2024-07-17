Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651DB44C6C
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721212447; cv=none; b=XKFVeXbTKd9R49NYQ9r3mfAutgAHZyzi0rqDTtelP5gzh7oVDhrjcdtj9cG9HBbV2AgfAo/f0bpsmlIY6dhzlQ8TaE27WW+P7qrlMVU2fnHm/qqv3wbJjLE55u1xHcmkt1llZJKD4x7HXpb/9Jk9NMtYElBAXupS8A8haQL0CvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721212447; c=relaxed/simple;
	bh=Q6KM6lR+izkbvtAcurmoXUFLvkzyr3NZnjnwJBW8BEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gJ9heIug/dZpeWwZW+BrZndtYWkYk0hQtYxiEnrYo46XGR7jN+gCo7iFrElMS6tsGe/6dbuiF22L6oATeerRKS1PLhXKWCr7h9YfxMsDM5LS8ZycLUqBnqTlgyKnZ2Z31rdwgrXFTChtHtwFDsvIMsf547a4yeCCLyQ8uOJADNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TJfwoGh2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TJfwoGh2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HAQbVG000975;
	Wed, 17 Jul 2024 10:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=z8M2vpHhw/98n7pT8NO5uJ7udEirhhcFPRbylac
	Iveg=; b=TJfwoGh2gYZzre97WWITUDfMJ+Drvb0a8S7M0DiIvKw7eOaBh2KiMcq
	Csbc5m9iz6KTlk/4lebevjvS16U65/KSZ1kZFikZET/ZSV0vtHVPABulxzfeLmHb
	3f9WrE47iBQD+owaGcWuFVkxmaxDlmXIAmic5KRHd750EXNdcdhVF+FsxkDvIeSE
	yptcYhIjl+OTPm7IghHDRfjMvL6LACbh/6FVusJ82wH6+kSyuLBLfZG0owMfpkKq
	N90BtxeaZWmq2ryDUY2qrpwWK2KqXzZc93goN7elZqmKTrmtU72/Yt3o24zrRpyQ
	tV0XMolZATCg4P9ui4ckKrZyTJInJJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e9kp0c5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 10:33:59 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46HAXwPf012175;
	Wed, 17 Jul 2024 10:33:58 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40e9kp0c5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 10:33:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46H9dv2l005921;
	Wed, 17 Jul 2024 10:33:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40dwkn3pwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 10:33:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46HAXr0T53150202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 10:33:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D97252004E;
	Wed, 17 Jul 2024 10:33:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 498732004D;
	Wed, 17 Jul 2024 10:33:52 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jul 2024 10:33:52 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: linux-perf-users@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Subject: [RFC PATCH] tools/lib/subcmd: Don't free the usage string
Date: Wed, 17 Jul 2024 16:03:51 +0530
Message-ID: <20240717103351.268344-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GcIuUKWnmd9K77GzMzjjM6X68PJhNlLI
X-Proofpoint-GUID: G5AzF9QQJ5bJxKEcfJtU_3aU79peJYDE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_06,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2407170080

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

    commit 230a7a71f9221 ("libsubcmd: Fix parse-options memory leak")

Where the generated usage string is deallocated, and usage[0] string is
reassigned as NULL.

As discussed in [1], free the allocated usage string in the main function
itself, and don't reset usage string to NULL in parse_options_subcommand

With this change, the behaviour is restored.

    $ ./perf sched
        Usage: perf sched [<options>] {record|latency|map|replay|script|timehist}

           -D, --dump-raw-trace  dump raw trace in ASCII
           -f, --force           don't complain, do it
           -i, --input <file>    input file name
           -v, --verbose         be more verbose (show symbol address, etc)

[1]: https://lore.kernel.org/linux-perf-users/htq5vhx6piet4nuq2mmhk7fs2bhfykv52dbppwxmo3s7du2odf@styd27tioc6e/

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
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
index 6fd95be5032b..6b88b8b40784 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -2058,6 +2058,8 @@ int cmd_kmem(int argc, const char **argv)
 
 out_delete:
 	perf_session__delete(session);
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kmem_usage[0]);
 
 	return ret;
 }
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 71165036e4ca..988bef73bd09 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -2187,5 +2187,8 @@ int cmd_kvm(int argc, const char **argv)
 	else
 		usage_with_options(kvm_usage, kvm_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kvm_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
index 56e3f3a5e03a..fd53838b5a78 100644
--- a/tools/perf/builtin-kwork.c
+++ b/tools/perf/builtin-kwork.c
@@ -2520,5 +2520,8 @@ int cmd_kwork(int argc, const char **argv)
 	} else
 		usage_with_options(kwork_usage, kwork_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)kwork_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 0253184b3b58..b25d50716e63 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -2713,6 +2713,9 @@ int cmd_lock(int argc, const char **argv)
 		usage_with_options(lock_usage, lock_options);
 	}
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)lock_usage[0]);
+
 	zfree(&lockhash_table);
 	return rc;
 }
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 863fcd735dae..b7c1cf6d0e5a 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -517,5 +517,8 @@ int cmd_mem(int argc, const char **argv)
 	else
 		usage_with_options(mem_usage, mem_options);
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)mem_usage[0]);
+
 	return 0;
 }
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 8750b5f2d49b..d6acc53ae89e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -3805,5 +3805,8 @@ int cmd_sched(int argc, const char **argv)
 		usage_with_options(sched_usage, sched_options);
 	}
 
+	/* free usage string allocated by parse_options_subcommand */
+	free((void *)sched_usage[0]);
+
 	return 0;
 }
-- 
2.45.2

