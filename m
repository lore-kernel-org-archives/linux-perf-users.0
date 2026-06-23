Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6DE3C1F5E;
	Tue, 23 Jun 2026 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198202; cv=none; b=K8H7i7zDIex9D9bfQcS9/EQARpfgHUL81mD4VYzrz2t2otPXZjkNuACzsVv0a6+eTYsj1pZh4Yme29yRQE0q3gmyIdsZaPQFLJDLJQosG1EN75YWb/JkcvCyq+YwEE5DhsgP3a2ys9U0Jn4Qd4nGhvoN1Qzv/0URG3hezX41P4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198202; c=relaxed/simple;
	bh=p1mR4Wd88RLPZD9tiiLb8TXA8ss9PkURms7olwv8di0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXPxGSmsPxH9ra7l1t7jV5BPcjn/+Q1MpY09qKX5VoTC1aE46KRgsV8xGoAZxEeKRlFl+tJ+5xnT/NwG8okPM9jwgfYGX/Al8896B93qz5qEN946Uaooo1KgeIgt/wHuPx0pWFKOX3NKBnP0V6s+Nqs1UE7i1R4J3hqBwP93L18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLin3hSM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLin3hSM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909B81F000E9;
	Tue, 23 Jun 2026 07:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198200;
	bh=/IqXl7Q2np/x0vzuCOps53obzaR29sde3UHnxcrPYBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XLin3hSMCYnuD+Y3qv3eaCWcvzkxIppDRsyUhn8hSswhtxEPKsyc0KO9/IwKDp0Us
	 6EIDcsWETND104BtKa3pOL5cxR3o/oyChSXw6ay2bMG/Z81rCLMp2/34VxePH9q1We
	 sxv7O0NU7+BVZhM34S2QTDYjK2VSGgWnl1DzOBEoV32Z3BQVc2pu3gq2Lez+8Kyizg
	 9QzxNOMW/XkTlhR6caD5G1kXObyxr+6nSVRh99rRxS4nAwXdYivqY9ApuwEm1PjClr
	 j5/56usE7843zBOge78eNb8k7j/B80QNYSDF9JtE4hvvk8XqNlVsFX8DB0pv0cPGKp
	 frlsFwtnPXIug==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] perf kvm: Kill STRDUP_FAIL_EXIT()
Date: Tue, 23 Jun 2026 00:03:12 -0700
Message-ID: <20260623070313.55225-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623070313.55225-1-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
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
 tools/perf/builtin-kvm.c                     | 54 +++++++-------------
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c |  9 ++--
 tools/perf/util/kvm-stat.h                   | 10 ----
 3 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index cec26f898bf6eaeb..84f9ce4481f73842 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1681,18 +1681,18 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
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
@@ -1716,10 +1716,6 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 
 	record_usage = kvm_stat_record_usage;
 	ret = cmd_record(i, rec_argv);
-
-EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
@@ -2007,9 +2003,9 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
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
@@ -2017,15 +2013,13 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
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
@@ -2040,19 +2034,15 @@ static int __cmd_report(const char *file_name, int argc, const char **argv)
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
@@ -2068,19 +2058,15 @@ __cmd_buildid_list(const char *file_name, int argc, const char **argv)
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
@@ -2100,7 +2086,7 @@ static int __cmd_top(int argc, const char **argv)
 		return -ENOMEM;
 
 	for (i = 0; i < argc; i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[i]);
+		rec_argv[i] = argv[i];
 
 	BUG_ON(i != argc);
 
@@ -2111,8 +2097,6 @@ static int __cmd_top(int argc, const char **argv)
 	ret = cmd_top(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
 	free(rec_argv);
 	return ret;
 }
diff --git a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
index 7bef7657a68a3e55..923b157bec2979b0 100644
--- a/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
+++ b/tools/perf/util/kvm-stat-arch/kvm-stat-x86.c
@@ -210,19 +210,16 @@ int __cpu_isa_init_x86(struct perf_kvm_stat *kvm, const char *cpuid)
  */
 int __kvm_add_default_arch_event_x86(int *argc, const char **argv)
 {
-	int ret = 0, j = *argc;
+	int j = *argc;
 
 	if (!x86__is_intel_cpu())
 		return 0;
 
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
index 111b02fd0878efc2..47bb0bfcb9bf6b53 100644
--- a/tools/perf/util/kvm-stat.h
+++ b/tools/perf/util/kvm-stat.h
@@ -228,14 +228,4 @@ static inline struct kvm_info *kvm_info__new(void)
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
2.54.0

