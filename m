Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81267399001;
	Tue, 23 Jun 2026 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198201; cv=none; b=hVuH5Vhq8AsFAXhCEcNZe0f3wH4Lrdfq90y/VSxcRl6moIWbb3sCbjmTjubaPSRQcUHbp29W6gDbuiGCx7BDFnLEf8rGZk1/Dsto//ghtY7pufifSziNyU3ipc3JzX+53ja3rH/83q6P/q+ajBiCtRT5EllMmBWG74Mbd3G2odw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198201; c=relaxed/simple;
	bh=SPPlzNQeZXQdJfgWqdsBN8cJX8myAOgsOMuxOJscpHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkcwxMbAyQ9DSXYnK1FbHHFky4AuAxoMuqrhxnzGFziL5wrhbWfUX7XtjAXxmzDKoe8wlGhAPevHgkmzKD9h3o/9jbPKM7aR+tPsmdWB9MHlvgsa2Bm7Sk1Av7Vxyeh+FmxgcndTf4PUIBIvFYSASLQ5x0cKifSWTZnY1gTnwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d56Znfdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d56Znfdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F031F00A3E;
	Tue, 23 Jun 2026 07:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198200;
	bh=sAUBqAlSC2h11QcgVKxI8iZzmTOn/CSHD/JG+NdbN1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d56Znfdm1KDM4wR9chtsU49CsJtOVkQphWOwAEcQhmP/zPNo/BXnYEbe6kmljdqvM
	 mBwJcIEMKGtZgG8R+YcBhMPRMD0m9chZy9VOm7b2soWfil+rq6xaH13R7Uo31vOlnp
	 yo9kXqSEw8PD3tkueOl1EJ3xYG8x4ofkN3esHmR7iv5PNhiPd1ckfYtcrlo8RVcJeb
	 tbM2uFZd6nk/nXJVPQ+3IbgkFLi3Qoh9ss4EfK7R4DvLOq01U55RE5UuxPveHYnvRK
	 zH0DLg5E/Kt8YeasTY43bNPPiMpIhm2YBTqa/OwiEXotl2HIGT5MaXHJVrnLoODS0x
	 PrsjXO4VkSEIA==
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
Subject: [PATCH 2/4] perf kvm: Check kvm_need_default_arch_event() early
Date: Tue, 23 Jun 2026 00:03:11 -0700
Message-ID: <20260623070313.55225-3-namhyung@kernel.org>
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
index acb1d2f8148c7c9b..cec26f898bf6eaeb 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1995,13 +1995,14 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 {
 	int rec_argc, i = 0, j, ret;
 	const char **rec_argv;
+	int need_arch_event = !!kvm_need_default_arch_event(argc, argv);
 
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
@@ -2009,22 +2010,22 @@ static int __cmd_record(const char *file_name, int argc, const char **argv)
 	rec_argv[i++] = STRDUP_FAIL_EXIT("record");
 	rec_argv[i++] = STRDUP_FAIL_EXIT("-o");
 	rec_argv[i++] = STRDUP_FAIL_EXIT(file_name);
-	for (j = 1; j < argc; j++, i++)
-		rec_argv[i] = STRDUP_FAIL_EXIT(argv[j]);
-
-	BUG_ON(i + 2 != rec_argc);
-
-	if (kvm_need_default_arch_event(argc, argv)) {
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
2.54.0

