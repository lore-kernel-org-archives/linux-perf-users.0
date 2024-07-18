Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1E2E419
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721293216; cv=none; b=NVoshpiPkMuMLKUZZXinhUwiTFefan2HNhTdo0XYbOg+Ni7bUyBDLCdo7AVJUCNpjsxBJVqyJRQl6+T3ZgKyXNoISYj5jERv0HdOI461k2jFnTMjtyVoRf4ire+fOaE7VVZO5L05+M9el0geruDSPFqJ6zIIs15admbRtq4uMzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721293216; c=relaxed/simple;
	bh=77MZjPhv5w8NF0+sJeUimnRJjymfn9gFefWKuOCz+yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvcUt1crTtyZjSRntuny+DZaFBaLgO6sm3NLIDclJzFShZwvERNqVygp72uFjgwfRFb7JozENr/+P/srnbh+KPxY6Ll8q2l3zrZSyItzfjU4xUOIaYrbozesFv9BGb6GPLWjdDRl3nWPHxO8ZubdXssp6lF3xkMpPeYAULSzVBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=leZ+KMPg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="leZ+KMPg"
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I7uZjS003070;
	Thu, 18 Jul 2024 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=dPrZ7A55C31Sz
	bc1jnp6o/uRTvfeYzTvZvIhGsmuNKw=; b=leZ+KMPgawMmJtsRGp4Xozc067Yma
	pT9g9BVOVHSO1zzeYKTvuARALMskN2wrB5LY83R2yGjd1VFsvm77ggYBy9LT1nib
	T38RAmnv8+zA0360R6kO81ll5YYwppU/FQmZIIi3FWnTWHfd/cJf56GcN0ePequa
	DTig72xsIG9SlY5ABIanNOEeohBRexPbG0ewLVFzhkf0G0cZa4U5b/gqVHx9c0gW
	3KytIz3raWvOkLnn8hQY5dst0HmOWhv8aOl/NlSv7UfDb36NsTIkCV5hackn+DN3
	pYuEYkN+lFzDx/ExP+Vqx7qPpaE8cKzHilc0anFk7CRzbZxYaB24lCucA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu05yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:11 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46I90A93003375;
	Thu, 18 Jul 2024 09:00:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40expu05y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46I8lZ2F000453;
	Thu, 18 Jul 2024 09:00:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40dwkk8sd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 09:00:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46I903wo53805460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jul 2024 09:00:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEEAE20040;
	Thu, 18 Jul 2024 09:00:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9540320043;
	Thu, 18 Jul 2024 09:00:01 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.in.ibm.com (unknown [9.109.199.72])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jul 2024 09:00:01 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, maddy@linux.ibm.com,
        atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH v13 1/7] tools/lib/subcmd: Don't free the usage string
Date: Thu, 18 Jul 2024 14:29:51 +0530
Message-ID: <20240718085957.550858-2-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718085957.550858-1-adityag@linux.ibm.com>
References: <20240718085957.550858-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H_RJ1SGiIqkqIsgjCY_dTQzKFXpj6a17
X-Proofpoint-ORIG-GUID: QyaEMtJFUYt_wUhHfxx7XORBntZDH0nf
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
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407180056

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
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Fixes: 230a7a71f922 ("libsubcmd: Fix parse-options memory leak")
Acked-by: Namhyung Kim <namhyung@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

---
Note:
This patch is independent of the series.

But I kept it along with the series, since the rest of the patches should
be applied only after this patch is applied (else the 'free' in
builtin-check.c will crash)
---
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

