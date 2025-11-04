Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB0E23AE87;
	Tue,  4 Nov 2025 04:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762230394; cv=none; b=OzyLaOnMYrw4tAgUphxNbXS7C3w5uKgeYQGy/BtKDrMvxY21Kzq3BJBw0rYb8SkqeppgexhPDhWKy2phNVmeKCjoe+JQ5K4yy8tdIOTwfEpFODXYBTt6HGtChKlhflBQVJKZbSzR5Ii68EMvEYuI4Z4w86x/AXg24sJHgrsBNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762230394; c=relaxed/simple;
	bh=NskOXQTX1AIJssgwS4mypVCGygtDmgNj9O6sSHMG8R0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLFt7ACxeAWmLSOkl6aNoY/CwkXXsc3XJeyQqk3IDSujkQHpAsmrfTIWZEkPdYiUqm7EbsIx0R/w+3PzPAAFeF+0HXdXXyWsdihDALRkzy1PmkMWFCsKdlJelRfCU2ZeOhWRVXyU8CfyDdXk3BDej4217WwucVI85AW1k6XcAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAwYrBpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAwYrBpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975ECC4CEF8;
	Tue,  4 Nov 2025 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762230393;
	bh=NskOXQTX1AIJssgwS4mypVCGygtDmgNj9O6sSHMG8R0=;
	h=From:To:Cc:Subject:Date:From;
	b=HAwYrBpCqyFGCInd2o5bevhIDsTrq/tCUNJ+hOuX4Lb/1y/NqFH0iuS58y5OayUyn
	 HXppfbcSzDyxmkUkioiUCHNFNkwv7rKU8Mhab0DLbro4klDTPM2KBQJF8uQ1RIVAev
	 /4lox8h6XwLyd8YQFZGhnA4tHM5OdgerHEGtFUm+cwiOYUwOBaBA3oIKfuc8Phr9LT
	 vs5iLVxVPXArdIGh3BtqFk2twPZd3S4GY5VASD4OHVNGB3w1XPybcvplIfsG0kRlfJ
	 QFv4CnxJZ0qqvK8FiX79GmNtLxAUIdE5P8ROCArESJVQGhpHGYLm43A73jsjPHgD9a
	 exrPt/4Acm4LA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf record: Make sure to update build-ID cache
Date: Mon,  3 Nov 2025 20:26:32 -0800
Message-ID: <20251104042632.1560922-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.2.997.g839fc31de9-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change on enabling --buildid-mmap by default brought an issue
with build-id handling.  With build-ID in MMAP2 records, we don't need
to save the build-ID table in the header are of a perf data file.

But the actual file contents still need to be cached in the debug
directory for annotation etc.  Split the build-ID header processing and
caching and make sure perf record to save hit DSOs in the build-ID cache
by moving perf_session__cache_build_ids() to the end of the record__
finish_output().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 30 +++++++++++++++---------------
 tools/perf/util/header.c    |  1 -
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ffb94a8339b03ec2..fe10bb7f35cbea05 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1890,15 +1890,14 @@ record__finish_output(struct record *rec)
 	}
 
 	/* Buildid scanning disabled or build ID in kernel and synthesized map events. */
-	if (!rec->no_buildid) {
+	if (!rec->no_buildid || !rec->no_buildid_cache) {
 		process_buildids(rec);
 
 		if (rec->buildid_all)
 			perf_session__dsos_hit_all(rec->session);
 	}
 	perf_session__write_header(rec->session, rec->evlist, fd, true);
-
-	return;
+	perf_session__cache_build_ids(rec->session);
 }
 
 static int record__synthesize_workload(struct record *rec, bool tail)
@@ -3083,7 +3082,7 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		else if (!strcmp(value, "no-cache"))
 			rec->no_buildid_cache = true;
 		else if (!strcmp(value, "skip"))
-			rec->no_buildid = true;
+			rec->no_buildid = rec->no_buildid_cache = true;
 		else if (!strcmp(value, "mmap"))
 			rec->buildid_mmap = true;
 		else if (!strcmp(value, "no-mmap"))
@@ -4192,24 +4191,25 @@ int cmd_record(int argc, const char **argv)
 		record.opts.record_switch_events = true;
 	}
 
-	if (!rec->buildid_mmap) {
-		pr_debug("Disabling build id in synthesized mmap2 events.\n");
-		symbol_conf.no_buildid_mmap2 = true;
-	} else if (rec->buildid_mmap_set) {
-		/*
-		 * Explicitly passing --buildid-mmap disables buildid processing
-		 * and cache generation.
-		 */
-		rec->no_buildid = true;
-	}
 	if (rec->buildid_mmap && !perf_can_record_build_id()) {
 		pr_warning("Missing support for build id in kernel mmap events.\n"
 			   "Disable this warning with --no-buildid-mmap\n");
 		rec->buildid_mmap = false;
 	}
+
 	if (rec->buildid_mmap) {
 		/* Enable perf_event_attr::build_id bit. */
 		rec->opts.build_id = true;
+		/* Disable build-ID table in the header. */
+		rec->no_buildid = true;
+	} else {
+		pr_debug("Disabling build id in synthesized mmap2 events.\n");
+		symbol_conf.no_buildid_mmap2 = true;
+	}
+
+	if (rec->no_buildid_set && rec->no_buildid) {
+		/* -B implies -N for historic reasons. */
+		rec->no_buildid_cache = true;
 	}
 
 	if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
@@ -4306,7 +4306,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = -ENOMEM;
 
-	if (rec->no_buildid_cache || rec->no_buildid) {
+	if (rec->no_buildid_cache) {
 		disable_buildid_cache();
 	} else if (rec->switch_output.enabled) {
 		/*
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4f2a6e10ed5cc0bd..4de7ca16b5522c47 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -335,7 +335,6 @@ static int write_build_id(struct feat_fd *ff,
 		pr_debug("failed to write buildid table\n");
 		return err;
 	}
-	perf_session__cache_build_ids(session);
 
 	return 0;
 }
-- 
2.51.2.997.g839fc31de9-goog

