Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8B24438B;
	Wed, 26 Feb 2025 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601841; cv=none; b=bVptL0h90JwW85aamN/WZvl3ev2HVxnsCv/1DSoYuBhlX+lWBctKF8K6oYIF/dEAhQOjeuKrzf9fP/CpNyK00rjbyEQFX+xFPIBf7986nI77XB53udsMi6hg5mp3fFM+cgvjCL79Z5hxRkWj1WEUpN8MiYH7JjiWY1AE69Vip/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601841; c=relaxed/simple;
	bh=wZTCWf6ZebZc0yurgS6uOME+IY65fpn8ucRzbLvZEuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKQbXlrk4Cd/9POfhBMspUb79SZHYcrJsZ4kSHLuptew6EzOo5BvmZQ9WdY3xTT+v5zPuUaUMNMTXDaWJwHvypujeXqQojFOTA6h10AVV/GvtGGchUZlyeZrvg1Q5vYsCQIT4CWEv12L1y9hmrVMpw3cYWO5l2os34AxB4MTCQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bog87JRo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bog87JRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B7DC4CED6;
	Wed, 26 Feb 2025 20:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740601840;
	bh=wZTCWf6ZebZc0yurgS6uOME+IY65fpn8ucRzbLvZEuc=;
	h=From:To:Cc:Subject:Date:From;
	b=bog87JRoUr35Ua+nDXLhR4CvKuyz/6jzbVtHG6XTLy/rffkOAclE36VRuoGYGVku0
	 mojYrOdH/nGCDCVS2XVzZOBeh5idlZD2qpRpwCUF50BaR63DvO0UDUp6ISViTdIRXt
	 ekOo6UZ5qHIXSSGqcjPRQ9+Kuyucqg9qpQs2AvbGgEikgpE4x1mHvCjVmxAG1Talau
	 ove7itQ9i6iMIZQzrj0rEATMt4TaEFXMNMFALDYli5lb5pC4JYo41Q8a4B5P4HRKkB
	 W1m+ObYx6KAYND2+bYmb6cD4pQl4yMQKSoZNu/0CMreELUd5I+XEHSYdlxdKLHEeJb
	 Wrh4ZFat6zXaA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Song Liu <song@kernel.org>
Subject: [PATCH] perf tools: Skip BPF sideband event for userspace profiling
Date: Wed, 26 Feb 2025 12:30:39 -0800
Message-ID: <20250226203039.1099131-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BPF sideband information is tracked using a separate thread and
evlist.  But it's only useful for profiling kernel and we can skip it
when users profile their application only.

It seems it already fails to open the sideband event in that case.
Let's remove the noise in the verbose output anyway.

Cc: Song Liu <song@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c |  3 +++
 tools/perf/builtin-top.c    |  3 +++
 tools/perf/util/evlist.c    | 14 ++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 21 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0e45bd64185403ae..cc61f5d6c599039c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2535,6 +2535,9 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		goto out_free_threads;
 	}
 
+	if (!evlist__needs_bpf_sb_event(rec->evlist))
+		opts->no_bpf_event = true;
+
 	err = record__setup_sb_evlist(rec);
 	if (err)
 		goto out_free_threads;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6440b5c1757d92ce..c284a384542ff822 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1833,6 +1833,9 @@ int cmd_top(int argc, const char **argv)
 		goto out_delete_evlist;
 	}
 
+	if (!evlist__needs_bpf_sb_event(top.evlist))
+		top.record_opts.no_bpf_event = true;
+
 #ifdef HAVE_LIBBPF_SUPPORT
 	if (!top.record_opts.no_bpf_event) {
 		top.sb_evlist = evlist__new();
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index f0dd174e2debdbe8..43adf6b3d855771a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2594,3 +2594,17 @@ bool evlist__has_bpf_output(struct evlist *evlist)
 
 	return false;
 }
+
+bool evlist__needs_bpf_sb_event(struct evlist *evlist)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel__is_dummy_event(evsel))
+			continue;
+		if (!evsel->core.attr.exclude_kernel)
+			return true;
+	}
+
+	return false;
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index adddb1db1ad2b25d..edcbf1c10e92f0c4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -435,5 +435,6 @@ void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
 void evlist__uniquify_name(struct evlist *evlist);
 bool evlist__has_bpf_output(struct evlist *evlist);
+bool evlist__needs_bpf_sb_event(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.48.1.658.g4767266eb4-goog

