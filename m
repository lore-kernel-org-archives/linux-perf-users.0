Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E66275AFE;
	Mon, 11 Aug 2025 05:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891815; cv=none; b=YV5dZk2PtRSVzS/Y0YrrSqn/d6mUZmQZFZlXnUwg6swN/Rn/5HaA7ZaEj7WQyCWwD4IjnO0PLfnfSv8rKR8Crdp/krHJ51cUoLkQ+KOY6FPqdGAf1qY47aFZuoljWKec2M1jQIaisVfuSIup4/tZdQIgF+V0kNLya0JA5vGZcH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891815; c=relaxed/simple;
	bh=qcM6TGJPeWkRUF6ZZeRPFpg13+suD5RKptjZcO9U53I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LV/lVQTrIoo3OknthkWHa7cYPAHR64FBk/4Ag7levFqwwtFmUaShxego+KjtQ/6xCZwlGrj1ZBr8d5/iW4st4l3ix8KR8aPav8XymDYmA87RqNoeDCPhpAID61pVwsch2eJ8FGE6/DlTjDEzVokRdcEEHrdRl+ap9rGSO8oWakc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCoTdBC6; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCoTdBC6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754891814; x=1786427814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcM6TGJPeWkRUF6ZZeRPFpg13+suD5RKptjZcO9U53I=;
  b=MCoTdBC6oXk+20efDBIfApSs0c+m6Q+eXKBZ2sUVnQZx1KsbZz8al7Ev
   fhLI2666oYr4UDrObUTjPsN9IV1wym5/J5xrrsOZLbi0q0FgbqXdnBXYt
   6zkir2PA1/I8tKoEWYY6y2yRr2DBl7/A4uX8oIxuHfxrdGFbYMXYM/Ame
   wm8TxDab3gihzk1dB1ummsKWMr6b0cPomP3nWcJ2HE9UZ2mgb+6LlaGI5
   scSQ91IocrQDTQ67x9hbff0H+unqhxZN/LRdbSFpmp94/zg+PqtCOC7RP
   b9JVljec/t3Pja4EZJiwltYFDgm1tQTqu8M4TXjP7BQ11Qv5EG02Tmg/y
   g==;
X-CSE-ConnectionGUID: pSOdQNCXScuZ+9LdVvEb5A==
X-CSE-MsgGUID: 1U05cSEOSCKcw+oGvIk4nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57043602"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57043602"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2025 22:56:54 -0700
X-CSE-ConnectionGUID: MoJbtCi2SRC77M2l3xiD2w==
X-CSE-MsgGUID: ax+hY/ZNR++4meV8p7ZWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="171183704"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa005.jf.intel.com with ESMTP; 10 Aug 2025 22:56:51 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 1/6] perf tools kvm: Add missed memory allocation check and free
Date: Mon, 11 Aug 2025 13:55:41 +0800
Message-Id: <20250811055546.296678-2-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
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

