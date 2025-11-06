Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E72DD5F3;
	Thu,  6 Nov 2025 19:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455626; cv=none; b=n+M58PBuxn+s5ayhAf/NcRjEUmu/07LdqzKXQALg+IN9A8uQHCFZ/07vamDeV/OlAypftkJ1osFOh/v08YRr9ENrXJYQA3aasErisCe38HOOpPQzLKnt24rpbCU+f8/ndZz9z3H0GYYfoL8KhErW4hqHKBScKElKYmTKkNoGjV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455626; c=relaxed/simple;
	bh=sW3D/DUO6/EhIkY8q0f6Kkg/PnTPkA07mZ2Ez9rrBdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I9H27vY/+hxbTnhoINzDP2fpfIxIiANyu+s8e3KNnT+1el/owjF1kXHCaJg0A1DI99IUPdC/g/PxdLcuZ4g1KzVNeK4lxfnEX1Y6zCTb0N/AVPeZvGKTheMwHN5hugIgfg9EAWpRmwHvyvgt5IDLtCIuAtJUH3nuXzxe+DT/pV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2zHWdml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2zHWdml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FFDC116B1;
	Thu,  6 Nov 2025 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762455626;
	bh=sW3D/DUO6/EhIkY8q0f6Kkg/PnTPkA07mZ2Ez9rrBdc=;
	h=From:To:Cc:Subject:Date:From;
	b=u2zHWdml42KH0K55TUrZUBwO2N64NjE1KEHTrNNutncMKoqkwQGRTBtrTc5ndCKIh
	 g6e209jA0sqQ7f6xF23hMdwXz70cjf/Jy3DTEPOAYL8zqEM5e6ZoTeHOwPhped16rg
	 rTdm8Ejg5Q/pZfYElvUzswmCy8SFtuExJa+61RzE8GBv1UYhNAa3iffAY7rSlGD52N
	 tpFqUOKv2hzBLEQhbBXMu2OrQWbpUKAOeQw2BaYn8NWQBSBSJuKumMVk2y3FtvfbYa
	 uI5lQgmVLk9CWoidJioFJAwL7xq58ixvlTNW0o1hkA+b9BJXwx/n1Y6V/qEE+wjHV+
	 nkfrRju3pMLcg==
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
Subject: [PATCH v2] perf record: Make sure to update build-ID cache
Date: Thu,  6 Nov 2025 11:00:23 -0800
Message-ID: <20251106190023.1772629-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent change on enabling --buildid-mmap by default brought an issue
with build-id handling.  With build-ID in MMAP2 records, we don't need
to save the build-ID table in the header of a perf data file.

But the actual file contents still need to be cached in the debug
directory for annotation etc.  Split the build-ID header processing and
caching and make sure perf record to save hit DSOs in the build-ID cache
by moving perf_session__cache_build_ids() to the end of the record__
finish_output().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* fixed commit log  (Ian)

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
2.51.2.1041.gc1ab5b90ca-goog

