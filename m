Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78D20265A;
	Mon, 28 Oct 2024 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152107; cv=none; b=IP+q8HL88ByUISCOnwzU1Vxmpl/NTVwVMV1amklfBxtTHV1Ws+V1WR4ap/dt65pL5Ir/FQG7cvW334uM4XLQAnAgRdT3iAoZrwtfhUkjA5GkX9PI4WDsP5LuojdbuoU4rOjzaqKEdUCEnWja8Hjw9g4zRJimD4Bl/cX2ix3rp38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152107; c=relaxed/simple;
	bh=VzfRU4G/Kb7tAIbwnjXLnk+gZjKfLSgD/FG+/ML7ies=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGai9aGHRHkCMkrb+EXfFO0SzjuFm9tqxkFuy7Cqe+EDGhRAiJdTvOM8LkbmeSIzNrzrBZLgeDN7neuehOB1axPZFieZNCmzysMfZCOn/vyiqrecG7y14X+CH4OQLOiApTlxSXhO4zmHBltbIpA7on4iajR43mr3dYyWH03pfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivH6GT58; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivH6GT58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265BAC4CEEB;
	Mon, 28 Oct 2024 21:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152107;
	bh=VzfRU4G/Kb7tAIbwnjXLnk+gZjKfLSgD/FG+/ML7ies=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ivH6GT58gjZgyJMxuEayQGz8xgpRdBtk/oL8Djp2oLtCbm8C825dMP5wxwtz9WcFl
	 86UQVSXHpFuM4Y1yu3p0DS/NhKj8BFNWDQUnjOAl7Zub3/4qKQW4W0bdh81KzLbAKe
	 5ZhS78iGSFM7OdGrHMtb0wabd1v8/NGc6NHRBxVY4OhKQRez62bSPxbuld0tJPzvFR
	 jLc31bhrYCe3rrng2x5a4ZSlNGfram7FC7r8dcmfaY66B7QE51dpU0+x6ykLgmNAew
	 xUy0dimS5xDLlyxr1rcAy3fDoM/H1iA3BD3ZYUdj4vZ0msuyaW5e+z45x5eCJ7PdCb
	 T4DLtuGQePXag==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org,
	Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	linux-trace-kernel@vger.kerne.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 17/19] perf record: Enable defer_callchain for user callchains
Date: Mon, 28 Oct 2024 14:47:44 -0700
Message-ID: <498473058e06c83fdd01ea9e83d499b6233ce080.1730150953.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730150953.git.jpoimboe@kernel.org>
References: <cover.1730150953.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

And add the missing feature detection logic to clear the flag on old
kernels.

  $ perf record -g -vv true
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             0 (PERF_TYPE_HARDWARE)
    size                             136
    config                           0 (PERF_COUNT_HW_CPU_CYCLES)
    { sample_period, sample_freq }   4000
    sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
    read_format                      ID|LOST
    disabled                         1
    inherit                          1
    mmap                             1
    comm                             1
    freq                             1
    enable_on_exec                   1
    task                             1
    sample_id_all                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
    bpf_event                        1
    defer_callchain                  1
  ------------------------------------------------------------
  sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -22
  switching off deferred callchain support

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/perf/util/evsel.c | 17 ++++++++++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 701092d6b1b6..ad89644b32f2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -912,6 +912,14 @@ static void __evsel__config_callchain(struct evsel *evsel, struct record_opts *o
 		}
 	}
 
+	if (param->record_mode == CALLCHAIN_FP && !attr->exclude_callchain_user) {
+		/*
+		 * Enable deferred callchains optimistically.  It'll be switched
+		 * off later if the kernel doesn't support it.
+		 */
+		attr->defer_callchain = 1;
+	}
+
 	if (function) {
 		pr_info("Disabling user space callchains for function trace event.\n");
 		attr->exclude_callchain_user = 1;
@@ -2089,6 +2097,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 static void evsel__disable_missing_features(struct evsel *evsel)
 {
+	if (perf_missing_features.defer_callchain)
+		evsel->core.attr.defer_callchain = 0;
 	if (perf_missing_features.branch_counters)
 		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_COUNTERS;
 	if (perf_missing_features.read_lost)
@@ -2144,7 +2154,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.branch_counters &&
+	if (!perf_missing_features.defer_callchain &&
+	    evsel->core.attr.defer_callchain) {
+		perf_missing_features.defer_callchain = true;
+		pr_debug2("switching off deferred callchain support\n");
+		return true;
+	} else if (!perf_missing_features.branch_counters &&
 	    (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
 		perf_missing_features.branch_counters = true;
 		pr_debug2("switching off branch counters support\n");
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 15e745a9a798..f0a1e1d78942 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -221,6 +221,7 @@ struct perf_missing_features {
 	bool weight_struct;
 	bool read_lost;
 	bool branch_counters;
+	bool defer_callchain;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.47.0

