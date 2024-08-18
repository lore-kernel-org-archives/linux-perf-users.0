Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A48BF0;
	Sun, 18 Aug 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724016590; cv=none; b=Sh/fmz/if/xovG6lD+FPaJwdLVlk3TPzoyBzNFPxnx5crr2/pU4u4nkp9oVjmbHMyCRB8rNGWZ8sPZ68N7lfLzy2XPwqCt6hPCJi5Ou/mKt2znc7CPqx8eS6VQHzC0s+V+y3/raAw7892sPkZry5x65JV/er7VDMNP9Ms9qz6MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724016590; c=relaxed/simple;
	bh=qp6dMtx2LZlRDxRu3OKyqe8ACPVRhg7F0pj3AdEPaWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3QXr/sWsvbGhAQOdhwF9HewTOpH0+uXSzs0Bcd1ezmATjwy6qCyv0qoPUcqXK7jt6ECyG1r9elp6Yw30F5hCSQnr+yCgQm9CRfrZxGp5q143pJbLK409uVGuNaRa6zQj5xjAMVZAqeswtnwkvLuDMsxIo4odlfhjSI26jPONfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEMQ29aU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEMQ29aU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A166C32786;
	Sun, 18 Aug 2024 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724016589;
	bh=qp6dMtx2LZlRDxRu3OKyqe8ACPVRhg7F0pj3AdEPaWY=;
	h=From:To:Cc:Subject:Date:From;
	b=CEMQ29aUIow4CH2q23qhZ6EWjsO87QxZVQ5R5zN8X+tRw6m1P0+xTB3unzCncuqc6
	 NGg4jMPDn3nnGHRapMx7/11aW2+5nKwnB/GU7PcPTb0xg8DslLuFl7o2SsJCwxU5GN
	 eyg3sOhQSNsMHm8YOa4S9lvQcEHpIjmOkz9risROYWAanqreiK25thYLc+O/tdPrk/
	 jc38iZ2cYRuxnwoLCL/GuL7RoG8WctM1AJas99rZgyJ9WmHrRAiO7s/W2iSO/RotGy
	 CFLzTH9GHYsB5IYBasi1Rfw+0JsfT8lT4mdfVg/nwd2EBknhcqwZ4BY+ULjYz/7ZAS
	 Z55OymdtpJYOw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/2] perf record: Fix sample cgroup & namespace tracking
Date: Sun, 18 Aug 2024 14:29:47 -0700
Message-ID: <20240818212948.2873156-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent change in perf_tool constification broke the cgroup and/or
namespace tracking by resetting tool fields.  It should set the values
after perf_tool__init().

Fixes: cecb1cf154b30 ("perf record: Use perf_tool__init()")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 39367709fd99..adbaf80b398c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2374,13 +2374,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	signal(SIGTERM, sig_handler);
 	signal(SIGSEGV, sigsegv_handler);
 
-	if (rec->opts.record_namespaces)
-		tool->namespace_events = true;
-
 	if (rec->opts.record_cgroup) {
-#ifdef HAVE_FILE_HANDLE
-		tool->cgroup_events = true;
-#else
+#ifndef HAVE_FILE_HANDLE
 		pr_err("cgroup tracking is not supported\n");
 		return -1;
 #endif
@@ -2406,6 +2401,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	tool->mmap2		= build_id__process_mmap2;
 	tool->itrace_start	= process_timestamp_boundary;
 	tool->aux		= process_timestamp_boundary;
+	tool->namespace_events	= rec->opts.record_namespaces;
+	tool->cgroup_events	= rec->opts.record_cgroup;
 	session = perf_session__new(data, tool);
 	if (IS_ERR(session)) {
 		pr_err("Perf session creation failed.\n");
-- 
2.46.0.184.g6999bdac58-goog

