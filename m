Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202A420E60;
	Wed,  1 Jul 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934916; cv=none; b=jYCWJzYpwnIVs5AViEi7NzzYtY5bimMVyedJsSIZemWakxF0SJiUPMNfZToFgmVtBA8fiFlsUR9eKdG8H/tXxe1ud3zEU0ApR6A4lF4L3+rQk0E2hmyaQyaJ8Hz2aRQ4GLONHzmGt18thL6EOAQlswPkpNG4ZnEj/1f/J/DgPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934916; c=relaxed/simple;
	bh=70eTUZ8OzFZdhHrXhuAU32aJYxmFsw9QnR1tP5IU+5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzuKPS2vy1y9jOpUPxAarUhiwD6t1aHzZeB+4FbHIbFDoUKdyYOTSTC4jcqK61+rJBD59LETBLb5UobA6IbwWK2+vQgzavafWalYAzqQMd6TNNEnEXVOEuv48fnf0yKUaKi6g7gsl5V0G9wWdRYbeDuib+pk9re0MYXGTDthhGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dXxuv17q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dXxuv17q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9071F00A3A;
	Wed,  1 Jul 2026 19:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934914;
	bh=caC9A/GjGUypj46119NaScvbV2xlGQ0Unnb3Q+g9zHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dXxuv17qeNu+5NxMG9IDBpV42sLQXdPU5LxcEpK8mqDKKJpf+KzXliRwTS/b3FWaL
	 d1cU/yzCqI/VBFUPe/gw0vXOfPBi9FrFbDis8dyQ/ySrcsM5JZqKLeKGHQAbZoMs9N
	 ma0Vj/dsQrvufFt7QJ0ROm9o3YvhyxaA8i1n/7JSJF64FEEq1ldN8hxwUEMiIXXGxy
	 y7fkTyywTBGIFOryMkdBXRw8ZHafWiVKJCn4CHJJSPFbKk7n+vjnt8ss881do8A8TA
	 QU0WVLMkyojf+ZOFbJS4mmpLkL9FW3CDAWYeAc1g28bzp7lrqvSmcPq0EYyXQQ1q/F
	 NS4jIVK699hXg==
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
Subject: [PATCH v3 2/6] perf kvm: Check kvm_need_default_arch_event() early
Date: Wed,  1 Jul 2026 12:41:49 -0700
Message-ID: <20260701194153.401218-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260701194153.401218-1-namhyung@kernel.org>
References: <20260701194153.401218-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's a subtle issue with option parsing in perf record.  It calls the
function with PARSE_OPT_STOP_AT_NON_OPTION so that it can pass later
options to the external command it runs.

But perf kvm record passes the default arch events after the argv.  So
if user calls it with command, then it passes the event to the external
command and fails it like below:

  $ sudo perf kvm --host record sleep 1
  sleep: invalid option -- 'e'
  Try 'sleep --help' for more information.
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.046 MB perf.data.kvm (5 samples) ]

We can check if the default options are needed before passing the extra
command line to make sure it's passed to perf record.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-kvm.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2f00cc1fd1c7cdbd..24576e4ebb02cade 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1996,13 +1996,14 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 {
 	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
+	int need_arch_event = !!kvm_need_default_arch_event(EM_HOST, argc, argv);
 
 	/*
 	 * Besides the 2 more options "-o" and "filename",
 	 * kvm_add_default_arch_event() may add 2 extra options,
-	 * so allocate 4 more items.
+	 * so allocate more items conditionally.
 	 */
-	rec_argc = argc + 2 + 2;
+	rec_argc = argc + 2 + (2 * need_arch_event);
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
 		return -ENOMEM;
@@ -2010,22 +2011,22 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	rec_argv[i++] = STRDUP_FAIL_EXIT("record");
 	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
 	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
-	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
-
-	BUG_ON(i + 2 != rec_argc);
-
-	if (kvm_need_default_arch_event(EM_HOST, argc, argv)) {
+	if (need_arch_event) {
 		ret = kvm_add_default_arch_event(EM_HOST, &i, rec_argv);
 		if (ret)
 			goto EXIT;
 	}
 
+	for (j = 1; j < argc; j++, i++)
+		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
+
+	BUG_ON(i != rec_argc);
+
 	ret = cmd_record(i, rec_argv);
 
 EXIT:
-	for (i = 0; i < rec_argc; i++)
-		free((void *)rec_argv[i]);
+	for (j = 0; j < i; j++)
+		free((void *)rec_argv[j]);
 	free(rec_argv);
 	return ret;
 }
-- 
2.55.0.rc0.799.gd6f94ed593-goog

