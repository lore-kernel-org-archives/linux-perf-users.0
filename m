Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98022248AE;
	Wed, 10 Dec 2025 02:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765334019; cv=none; b=sfcPDNHQyqXNmYzbo1ae+4cwajDTp3BU3Dc8+bl3T49+Y+CK/nMwy8hj9OFYVkGkSChKrkd1ABMxuGevhm0/ArsmbGAuaK8kUWGWRUEL/Qp3iqFoDZXhi1nrGdzZJHcKDdFOvOpyst5FHCp8amxB75FEn4TnAv8XOv5GwF2ZZoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765334019; c=relaxed/simple;
	bh=9lgjBEPzdz9Ps357DUI1BL41O7zYzHj2Or+QpVRHjGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+ghyR+At2QVQrOWhn0Zeqx0qn6wg8azyxHEmzVapxW5UihMd9NG85jy5NGp0fCVRIjEAgyy6RQZh+xfFwEVFgSxOPEUjKUHc5I++6YKKVizP18XKrvlRU49RAhmbCtdw38QR/9b/CcLScRTyGBMPVr/lDyOsKg0BWfPtkv+Dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haYhk88v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haYhk88v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE8EC4CEF5;
	Wed, 10 Dec 2025 02:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765334018;
	bh=9lgjBEPzdz9Ps357DUI1BL41O7zYzHj2Or+QpVRHjGE=;
	h=From:To:Cc:Subject:Date:From;
	b=haYhk88vc5PFnABLKashq3r6lTQKW/Jvu3sN/SPPivYVbboQ35MRi48cy+TcZLlzo
	 4MLMUwbmNe+YIEF1uKsw6UoLmXcX6lKxSWqTf3zej188uBsASTBSxEyblou6PlSa44
	 /Z6et1tZOePKcwqvtvdhB4LTW1VpARR/z0BybJcEUgjKTQNXeUllCQGqnftECAX76R
	 HdS7DevIcV7M/zO1i0XdLh/oz4t9W7r36QfkHs/FZZb4SK1DUjCmVZkCK8wYr1zZfw
	 2YA/5FXjERJANICK5ogkFgKSjGBpaqlxN0LtenH+khvQv+kZYzBwv0ezoVg+KoS8co
	 9o870w2fcNStw==
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
Subject: [PATCH 1/4] perf record: Split --data-mmap option
Date: Tue,  9 Dec 2025 18:33:24 -0800
Message-ID: <20251210023327.1669863-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently -d/--data option controls both PERF_SAMPLE_ADDR bit and
perf_event_attr.mmap_data flag.  Separate them using new --data-mmap
option to support recording only one of them.

For data-type profiling, data MMAP is unnecessary but it wastes a lot
of space in the ring buffer and data file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt |  8 +++++++-
 tools/perf/builtin-record.c              | 19 +++++++++++++------
 tools/perf/util/evsel.c                  |  5 +++--
 tools/perf/util/record.h                 |  2 ++
 4 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index e8b9aadbbfa50574..c402e74172f6a22d 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -344,7 +344,8 @@ OPTIONS
 
 -d::
 --data::
-	Record the sample virtual addresses.  Implies --sample-mem-info.
+	Record the sample virtual addresses.  Implies --sample-mem-info and
+	--data-mmap.
 
 --phys-data::
 	Record the sample physical addresses.
@@ -861,6 +862,11 @@ filtered through the mask provided by -C option.
 	Prepare BPF filter to be used by regular users.  The action should be
 	either "pin" or "unpin".  The filter can be used after it's pinned.
 
+--data-mmap::
+	Enable recording MMAP events for non-executable mappings.  Basically
+	perf only records executable mappings but data mmaping can be useful
+	when you analyze data access with sample addresses.  So using -d option
+	would enable this unless you specify --no-data-mmap manually.
 
 include::intel-hybrid.txt[]
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2584d0d8bc820676..cbfbd9bb10634093 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1881,7 +1881,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 						 process_synthesized_event,
 						 &rec->session->machines.host,
 						 needs_mmap,
-						 rec->opts.sample_address);
+						 rec->opts.record_data_mmap);
 	perf_thread_map__put(thread_map);
 	return err;
 }
@@ -2191,7 +2191,7 @@ static int record__synthesize(struct record *rec, bool tail)
 
 		err = __machine__synthesize_threads(machine, tool, &opts->target,
 						    rec->evlist->core.threads,
-						    f, needs_mmap, opts->sample_address,
+						    f, needs_mmap, opts->record_data_mmap,
 						    rec->opts.nr_threads_synthesize);
 	}
 
@@ -3006,8 +3006,9 @@ int record_opts__parse_callchain(struct record_opts *record,
 	ret = parse_callchain_record_opt(arg, callchain);
 	if (!ret) {
 		/* Enable data address sampling for DWARF unwind. */
-		if (callchain->record_mode == CALLCHAIN_DWARF)
-			record->sample_address = true;
+		if (callchain->record_mode == CALLCHAIN_DWARF &&
+		    !record->record_data_mmap_set)
+			record->record_data_mmap = true;
 		callchain_debug(callchain);
 	}
 
@@ -3686,6 +3687,9 @@ static struct option __record_options[] = {
 	OPT_CALLBACK(0, "off-cpu-thresh", &record.opts, "ms",
 		     "Dump off-cpu samples if off-cpu time exceeds this threshold (in milliseconds). (Default: 500ms)",
 		     record__parse_off_cpu_thresh),
+	OPT_BOOLEAN_SET(0, "data-mmap", &record.opts.record_data_mmap,
+			&record.opts.record_data_mmap_set,
+			"Record mmap events for non-executable mappings"),
 	OPT_END()
 };
 
@@ -4249,9 +4253,12 @@ int cmd_record(int argc, const char **argv)
 		goto out_opts;
 	}
 
-	/* For backward compatibility, -d implies --mem-info */
-	if (rec->opts.sample_address)
+	/* For backward compatibility, -d implies --mem-info and --data-mmap */
+	if (rec->opts.sample_address) {
 		rec->opts.sample_data_src = true;
+		if (!rec->opts.record_data_mmap_set)
+			rec->opts.record_data_mmap = true;
+	}
 
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9cd706f6279313c2..ec6552a6f667fec6 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1445,10 +1445,11 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		attr->inherit_stat = 1;
 	}
 
-	if (opts->sample_address) {
+	if (opts->sample_address)
 		evsel__set_sample_bit(evsel, ADDR);
+
+	if (opts->record_data_mmap)
 		attr->mmap_data = track;
-	}
 
 	/*
 	 * We don't allow user space callchains for  function trace
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index ea3a6c4657eefb74..93627c9a73387ddd 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -40,6 +40,8 @@ struct record_opts {
 	bool	      record_cgroup;
 	bool	      record_switch_events;
 	bool	      record_switch_events_set;
+	bool	      record_data_mmap;
+	bool	      record_data_mmap_set;
 	bool	      all_kernel;
 	bool	      all_user;
 	bool	      kernel_callchains;
-- 
2.52.0.223.gf5cc29aaa4-goog

