Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025062D0AC1;
	Wed, 30 Apr 2025 20:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046552; cv=none; b=LyAyWyLc+RPRJatWfyHyDcxfRUPIrDdUPUg/A8dKoamfNkhA5Fb1/u6N1fmXeTwDOF80impkqtrxMdVIIn2VYNzN3rIubED3Ea2bsr1NZ3MFlU620+FD8BScEdcu3+Br5rt1wWrqt+9rGIfp4FNvBqZBb6yzSuVZ8Z0t1uNtYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046552; c=relaxed/simple;
	bh=v2DS2F47cm5vHlwHkpeETqDniZGIwCDv5zjC3kDKgeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCOp7JIOO7ww3SMFHWfEEYM9nDoDCBRrvD90j5ftTyIrmI5yvAJpu8FZv/M62u/F+4fI/jTHNspcf1oRrmzBh4M7P0l4nTykyl7EloWz8pMOOFj7JMYU9qMBAnW4t6y7DOwfFvdPxYJVuDVtsNE+GTm4uebLN4VjeBUruSexdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qx6dLuxB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qx6dLuxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA4C4CEEA;
	Wed, 30 Apr 2025 20:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746046551;
	bh=v2DS2F47cm5vHlwHkpeETqDniZGIwCDv5zjC3kDKgeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qx6dLuxBAXI3qKfUdDyf+iSTI8EAKyxhhb7awzsGRy/VLL62/T0isaigpVSY6A7If
	 0YRxmJPVA+kEDLPLWaXB69YacZUnP+HCV8MgAx9axW2DmI91h+kXvBdqrzvbW2R6lk
	 5wdnidaU2v4KfI4w/OsVl4u9LhTqxy5I00sSJluwVtmjLqupHnNWrddxHpypIFrnr/
	 z1UeOHn/hT5uFtA8x6v2L+ATgIFs75Awg2uAI9klOxMCjEAzw6uv+daJhHyelhUsaJ
	 BwWJXHRhgNOq2pC0Uj4MObfRvFTKYv5+6CCgRoWo326WAtfMLd1tpYxZhED0MH3KoN
	 cff741D3kAzqQ==
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
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Leo Yan <leo.yan@arm.com>
Subject: [PATCH 02/11] perf record: Add --sample-mem-info option
Date: Wed, 30 Apr 2025 13:55:39 -0700
Message-ID: <20250430205548.789750-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430205548.789750-1-namhyung@kernel.org>
References: <20250430205548.789750-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no way to enable PERF_SAMPLE_DATA_SRC without PERF_SAMPLE_ADDR
which brings a lot of overhead due to the number of MMAP[2] records.

Let's add a new option to enable this information separately.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 7 ++++++-
 tools/perf/builtin-record.c              | 6 ++++++
 tools/perf/util/evsel.c                  | 2 +-
 tools/perf/util/record.h                 | 1 +
 4 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index c7fc1ba265e2755d..c59f1e79f2b4a6f8 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -340,7 +340,7 @@ OPTIONS
 
 -d::
 --data::
-	Record the sample virtual addresses.
+	Record the sample virtual addresses.  Implies --sample-mem-info.
 
 --phys-data::
 	Record the sample physical addresses.
@@ -368,6 +368,11 @@ OPTIONS
 	the sample_type member of the struct perf_event_attr argument to the
 	perf_event_open system call.
 
+--sample-mem-info::
+	Record the sample data source information for memory operations.
+	It requires hardware supports and may work on specific events only.
+	Please consider using 'perf mem record' instead if you're not sure.
+
 -n::
 --no-samples::
 	Don't sample.
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba20bf7c011d7765..6637a3acb1f1295f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -3436,6 +3436,8 @@ static struct option __record_options[] = {
 		    "Record the sampled data address data page size"),
 	OPT_BOOLEAN(0, "code-page-size", &record.opts.sample_code_page_size,
 		    "Record the sampled code address (ip) page size"),
+	OPT_BOOLEAN(0, "sample-mem-info", &record.opts.sample_data_src,
+		    "Record the data source for memory operations"),
 	OPT_BOOLEAN(0, "sample-cpu", &record.opts.sample_cpu, "Record the sample cpu"),
 	OPT_BOOLEAN(0, "sample-identifier", &record.opts.sample_identifier,
 		    "Record the sample identifier"),
@@ -4130,6 +4132,10 @@ int cmd_record(int argc, const char **argv)
 		goto out_opts;
 	}
 
+	/* For backward compatibility, -d implies --mem-info */
+	if (rec->opts.sample_address)
+		rec->opts.sample_data_src = true;
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1d79ffecd41f10ec..0f86df259c822799 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1425,7 +1425,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 		evsel__set_sample_bit(evsel, CPU);
 	}
 
-	if (opts->sample_address)
+	if (opts->sample_data_src)
 		evsel__set_sample_bit(evsel, DATA_SRC);
 
 	if (opts->sample_phys_addr)
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e5b19..f1956c4db3195070 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -28,6 +28,7 @@ struct record_opts {
 	bool	      sample_time_set;
 	bool	      sample_cpu;
 	bool	      sample_identifier;
+	bool	      sample_data_src;
 	bool	      period;
 	bool	      period_set;
 	bool	      running_time;
-- 
2.49.0.906.g1f30a19c02-goog

