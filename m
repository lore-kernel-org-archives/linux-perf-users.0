Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642F538A717;
	Tue, 23 Jun 2026 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242082; cv=none; b=OH9mGezvyc/vbLMkOHY8Bs4VGHOCyuiBNEUPhWfAsFkAb6yYb5bh66B+EeFZE4d5Grvne8815LxOozZ2UAnhbcYM1y1yOwl4A228Mt3vXOTJyXnZOYSEPoCb8ZwWmlPSimbondo37/gvPDm9rwifgKAlgPKOdmOXu/5ZEBrT1JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242082; c=relaxed/simple;
	bh=rOEyspnpopa+0r3sDnFI4QQqzgFCrTdMmF3VsBGFiA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnV1QkXujLhzVK7ySqsxRpc/L8Qdz+N8w4zTjgaHb8BmbbsFD0ZtOzAomeoQ/txF2b40PkcCozW/P38kTyM7L2jEXJhSnlmyJY1JBRvISwTBJp+0Xr72TVwAPOUl58YOSRLJGiVG8AY4zfOe5ly/RDOQwyxYcv3zn4nRsM9AJ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHlnefNW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHlnefNW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C031F00A3A;
	Tue, 23 Jun 2026 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782242081;
	bh=1M/8JvaDJXivkYI+KW51Ks3DvSIAsX5LG8vEC4XGpFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bHlnefNWphMWryils28cAx2yqMh8MJlRd5dBqLFi7vquGPrjR2n9CAwq0Mq7oTCA/
	 P/+zNu6+wuk5daQJf22dvfIw2PNcLbw2caFoOmIrRBEXo8qekFEhbDFnz3AkkClhoA
	 oe48a13yN8mPqZMa58dLPrVVf92/2MOgfCZgChB+0T8ZsYgldUmhIWo6YT24RleHT4
	 VMIBG3UQm9+lcv1bz0eG8giEDddeBMJds9QlaBeFD9jE2gP9w1i4jKCF/yaNjHjq0a
	 Nra+D5TxERjfKHXSoMjQRC0VBTcFOv8zfgCqn5zIc3vVaADYOMiy9zEwYRkxzal0pk
	 tgrRB92hbO3hQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 3/6] perf kvm: Kill STRDUP_FAIL_EXIT()
Date: Tue, 23 Jun 2026 12:14:36 -0700
Message-ID: <20260623191439.3621593-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260623191439.3621593-1-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's used to pass command line options to a copied argv.  But there's no
reason to make the copies as it's all used in the same function.  It can
simply use stack variables.

In fact, it fixes a subtle double free issue.  As parse_options() can
move contents in argv[], some entries may point to the same item.  So
freeing all items in the argv could trigger a double free.  With stack
variables, we don't need to allocate and free them.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c                      | 54 +++++++------------
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  4 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  9 ++--
 tools/perf/util/kvm-stat.h                    | 10 ----
 4 files changed, 24 insertions(+), 53 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 24576e4ebb02cade..eaf9297cc34d32c1 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1682,18 +1682,18 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
+		rec_argv[i] = record_args[i];
 
 	for (j = 0; j < events_tp_size; j++) {
-		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
-		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp(e_machine)[j]);
+		rec_argv[i++] = "-e";
+		rec_argv[i++] = kvm_events_tp(e_machine)[j];
 	}
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(kvm->file_name);
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = kvm->file_name;
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	set_option_flag(record_options, 'e', "event", PARSE_OPT_HIDDEN);
 	set_option_flag(record_options, 0, "filter", PARSE_OPT_HIDDEN);
@@ -1717,10 +1717,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 
 	record_usage = kvm_stat_record_usage;
 	ret = cmd_record(i, rec_argv);
-
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2008,9 +2004,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("record");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "record";
+	rec_argv[i++] = "-o";
+	rec_argv[i++] = file_name;
 	if (need_arch_event) {
 		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
 		if (ret)
@@ -2018,15 +2014,13 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	}
 
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i != rec_argc);
 
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
-	for (j = 0; j < i; j++)
-		free((void *)rec_argv[j]);
 	free(rec_argv);
 	return ret;
 }
@@ -2041,19 +2035,15 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("report");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "report";
+	rec_argv[i++] = "-i";
+	rec_argv[i++] = file_name;
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i != rec_argc);
 
 	ret = cmd_report(i, rec_argv);
-
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2069,19 +2059,15 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 	if (!rec_argv)
 		return -ENOMEM;
 
-	rec_argv[i++] = STRDUP_FAIL_EXIT("buildid-list");
-	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
-	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
+	rec_argv[i++] = "buildid-list";
+	rec_argv[i++] = "-i";
+	rec_argv[i++] = file_name;
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+		rec_argv[i] = argv[j];
 
 	BUG_ON(i != rec_argc);
 
 	ret = cmd_buildid_list(i, rec_argv);
-
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2101,7 +2087,7 @@ static int __cmd_top(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < argc; i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[i]);
+		rec_argv[i] = argv[i];
 
 	BUG_ON(i != argc);
 
@@ -2114,8 +2100,6 @@ static int __cmd_top(int argc, const char **argv)
 	ret = cmd_top(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
index 8d4133c35c12f14b..315b24f9a59297dc 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c
@@ -181,8 +181,8 @@ int __kvm_add_default_arch_event_powerpc(int *argc, const char **argv)
 	if (!perf_pmus__have_event("trace_imc", "trace_cycles"))
 		return -EINVAL;
 
-	argv[j++] = strdup("-e");
-	argv[j++] = strdup("trace_imc/trace_cycles/");
+	argv[j++] = "-e";
+	argv[j++] = "trace_imc/trace_cycles/";
 	*argc += 2;
 
 	return 0;
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 46f9a0adcb608aab..97041f5100fc812f 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -210,16 +210,13 @@ int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid)
  */
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 {
-	int ret = 0, j = *argc;
+	int j = *argc;
 
-	argv[j++] = STRDUP_FAIL_EXIT("-e");
-	argv[j++] = STRDUP_FAIL_EXIT("cycles");
+	argv[j++] = "-e";
+	argv[j++] = "cycles";
 	*argc += 2;
 
 	return 0;
-
-EXIT:
-	return ret;
 }
 
 const char * const *__kvm_events_tp_x86(void)
diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
index 04f9f3193555972f..1db31c0751875875 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -229,14 +229,4 @@ static inline struct kvm_info *kvm_info__new(void)
 	return ki;
 }
 
-#define STRDUP_FAIL_EXIT(s)		\
-	({	char *_p;		\
-		_p = strdup(s);		\
-		if (!_p) {		\
-			ret = -ENOMEM;	\
-			goto EXIT;	\
-		}			\
-		_p;			\
-	})
-
 #endif /* __PERF_KVM_STAT_H */
-- 
2.55.0.rc0.799.gd6f94ed593-goog

