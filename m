Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E4253954;
	Fri, 19 Sep 2025 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248320; cv=none; b=Er9VPYDytcNe6bpGWGYQ0JRpHX8XawZhM2Z+AxZav+DS/MaVMIv1NiP4ysnyiveQUOX7a7GNcWVIOG0XKkEZW2aMqXZzUm7W/R0ITpXZAXJKKQWT+RDupG12DXdTBN17A/ZLSgBs+9p03st/ypCrFpxyfhVL+Na+QFGb/9VAfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248320; c=relaxed/simple;
	bh=QzGVMe3lVcb6ZKSoThxuJl4/bhzkFS08LPC0B3BFTeY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZmZuyc7m0R5dS8jX5341Plq6FIUY2C43OV9rraW266P+kljU3dWhA5Xtx2DRW/zLaf70xa99/r6L35p+kTYsZFKT4peIuzdXdQXIQm/jFqWC90Uyctz24hjVd5JZoa3+h/AJRegAmGUDxx0cHeN7YE68Bcn8Ldh9JWqXJUkZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMiXlqzD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMiXlqzD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758248319; x=1789784319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QzGVMe3lVcb6ZKSoThxuJl4/bhzkFS08LPC0B3BFTeY=;
  b=ZMiXlqzDzVT5yCdjhQAQ8BBgBLwBymR9P8n2XP3phIVADT+XePDvle+E
   t00NyONmDfg7DYRyNm+gVVrAOLbBEcielsD+WqoHxPFJ6CO3FLAIsXQRq
   axPm26L+8SPULY7O+3jpGzMfy03GLo3q6d63BpDGnIH6Rj0WgY2MX+CTp
   icUt6vFlS48wdbZq1+N5g6/a0vyW9E4ukNLUJzLAVCgQ/o/3TqfHnwLr6
   hVKXiPRbm8joF1aRRsinDDFmzjs+1tzYf5+C4JJaHp+OKHG3/+Nw2OeqL
   VHSnegfQTDUe0YgQxJUk6BoX19JY4yWAN/V1traK3c8zelmGfLGwwyd8b
   w==;
X-CSE-ConnectionGUID: E6f1qkxZRJiY2bkfm7vksQ==
X-CSE-MsgGUID: LCwIImJXQX2UWI0di1eI/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="64229117"
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="64229117"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 19:18:39 -0700
X-CSE-ConnectionGUID: dyjLt5DLTZ61QucRBtcUXw==
X-CSE-MsgGUID: LiT31gXXRbiqLqGqxHQmyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,276,1751266800"; 
   d="scan'208";a="175535596"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 18 Sep 2025 19:18:36 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 1/6] perf tools kvm: Add missed memory allocation check and free
Date: Fri, 19 Sep 2025 10:16:54 +0800
Message-Id: <20250919021659.1263351-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
References: <20250919021659.1263351-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current code allocates rec_argv[] array, but doesn't check if the
allocation is successful and explicitly free the rec_argv[] array.

Add them back.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 81 ++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 7b15b4a705e4..9813f1eb56f9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1638,9 +1638,11 @@ static int kvm_events_report_vcpu(struct perf_kvm_stat *kvm)
 
 #define STRDUP_FAIL_EXIT(s)		\
 	({	char *_p;		\
-	_p = strdup(s);		\
-		if (!_p)		\
-			return -ENOMEM;	\
+		_p = strdup(s);		\
+		if (!_p) {		\
+			ret = -ENOMEM;	\
+			goto EXIT;	\
+		}			\
 		_p;			\
 	})
 
@@ -1688,7 +1690,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 		rec_argv[i] = STRDUP_FAIL_EXIT(record_args[i]);
 
 	for (j = 0; j < events_tp_size; j++) {
-		rec_argv[i++] = "-e";
+		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
 		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp[j]);
 	}
 
@@ -1696,7 +1698,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	rec_argv[i++] = STRDUP_FAIL_EXIT(kvm->file_name);
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	set_option_flag(record_options, 'e', "event", PARSE_OPT_HIDDEN);
 	set_option_flag(record_options, 0, "filter", PARSE_OPT_HIDDEN);
@@ -1719,7 +1721,13 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
 	set_option_flag(record_options, 0, "transaction", PARSE_OPT_DISABLED);
 
 	record_usage = kvm_stat_record_usage;
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 static int
@@ -2006,52 +2014,79 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
-	rec_argv[i++] = strdup("record");
-	rec_argv[i++] = strdup("-o");
-	rec_argv[i++] = strdup(file_name);
+	if (!rec_argv)
+		return -ENOMEM;
+
+	rec_argv[i++] = STRDUP_FAIL_EXIT("record");
+	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
+	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_record(i, rec_argv);
+	ret = cmd_record(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 static int __cmd_report(const char *file_name, int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
-	rec_argv[i++] = strdup("report");
-	rec_argv[i++] = strdup("-i");
-	rec_argv[i++] = strdup(file_name);
+	if (!rec_argv)
+		return -ENOMEM;
+
+	rec_argv[i++] = STRDUP_FAIL_EXIT("report");
+	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
+	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_report(i, rec_argv);
+	ret = cmd_report(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 static int
 __cmd_buildid_list(const char *file_name, int argc, const char **argv)
 {
-	int rec_argc, i = 0, j;
+	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
 
 	rec_argc = argc + 2;
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
-	rec_argv[i++] = strdup("buildid-list");
-	rec_argv[i++] = strdup("-i");
-	rec_argv[i++] = strdup(file_name);
+	if (!rec_argv)
+		return -ENOMEM;
+
+	rec_argv[i++] = STRDUP_FAIL_EXIT("buildid-list");
+	rec_argv[i++] = STRDUP_FAIL_EXIT("-i");
+	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
 	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = argv[j];
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
 
 	BUG_ON(i != rec_argc);
 
-	return cmd_buildid_list(i, rec_argv);
+	ret = cmd_buildid_list(i, rec_argv);
+
+EXIT:
+	for (i = 0; i < rec_argc; i++)
+		free((void *)rec_argv[i]);
+	free(rec_argv);
+	return ret;
 }
 
 int cmd_kvm(int argc, const char **argv)
-- 
2.34.1

