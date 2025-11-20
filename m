Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B417920C463;
	Thu, 20 Nov 2025 00:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599648; cv=none; b=g4Z+v/hXGaN9VbZ0v8FimpJ2a1QtZybB8eQY37aLhqZ02FvUcbLj2Pokmvf2A8kUadwnd14waZDlmciMFox8PX3CfuswpVY8w0tSqhUseiiHWzD5UiT1YMH3s9GQjDy5aRNa9YdWZXnrRdd/BeR3HlOHsKA0zqAS9Nmp71Oz6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599648; c=relaxed/simple;
	bh=GSME5nff5XXuhe2v0ydsFjK7nNzu4ZaRVfUseJqa0JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHfbTWEIz9LUvxM7Q3FDsGNhP9qwhE/pkpRvItVwRJiFvu2zizbs8ywLbib2UNXbKoTW7QpSsWS2byOwbqnPzelSioz+FQGa/nKSZ/Xt3BuwuejBD/HVRpThN5donMcZTXHtXPt0OtVZFpjwIRtuycl6revHMSQo+nKARKs+lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YocJ9Av+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YocJ9Av+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E83C4CEF5;
	Thu, 20 Nov 2025 00:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763599648;
	bh=GSME5nff5XXuhe2v0ydsFjK7nNzu4ZaRVfUseJqa0JI=;
	h=From:To:Cc:Subject:Date:From;
	b=YocJ9Av+ooypG3Je6+/WLIgyr1HFk5n48+KW+lh/x/Sjc6JbxC3b1adwJPnw9xe8T
	 tWLY5/Cw21mH1pUsS+aYSVHN1muKcZCqzRBVyotPkoAvwuXe/Ts8oQC6whDZXgOOd5
	 /hpRCGNzEv0Z13tskPU8itDsPYmQGaB7+Z8G9DAlT8dBF1KVGdK54/f8BRlA86wWz5
	 2MMgQNO/RPCbJkVMgLRNCuRCz1m0FCH6uJDOoaWdhQohfYntPLi7wb3y93BF8fJfe+
	 FKGksL/QcjGa2zaLZEZMHwr8zHxKGky0QHIaA7CmTVtkb/0sQPVOJocy6s4KVlTbVn
	 LvOwD9BgLUaZw==
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
Subject: [PATCH v2 1/3] perf list: Print matching PMU events for --unit
Date: Wed, 19 Nov 2025 16:47:24 -0800
Message-ID: <20251120004726.61660-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When --unit option is used, pmu_glob is set to the argument.  It should
match with event PMU and display the matching ones only.  But it also
shows raw events and metrics after that.

  $ perf list --unit tool
  List of pre-defined events (to be used in -e or -M):

  tool:
    core_wide
         [1 if not SMT,if SMT are events being gathered on all SMT threads 1 otherwise 0. Unit: tool]
    duration_time
         [Wall clock interval time in nanoseconds. Unit: tool]
    has_pmem
         [1 if persistent memory installed otherwise 0. Unit: tool]
    num_cores
         [Number of cores. A core consists of 1 or more thread,with each thread being associated with a logical Linux CPU. Unit: tool]
    num_cpus
         [Number of logical Linux CPUs. There may be multiple such CPUs on a core. Unit: tool]
    ...
    rNNN                                               [Raw event descriptor]
    cpu/event=0..255,pc,edge,.../modifier              [Raw event descriptor]
         [(see 'man perf-list' or 'man perf-record' on how to encode it)]
    breakpoint//modifier                               [Raw event descriptor]
    cstate_core/event=0..0xffffffffffffffff/modifier   [Raw event descriptor]
    cstate_pkg/event=0..0xffffffffffffffff/modifier    [Raw event descriptor]
    drm_i915//modifier                                 [Raw event descriptor]
    hwmon_acpitz//modifier                             [Raw event descriptor]
    hwmon_ac//modifier                                 [Raw event descriptor]
    hwmon_bat0//modifier                               [Raw event descriptor]
    hwmon_coretemp//modifier                           [Raw event descriptor]
    ...

  Metric Groups:

  Backend: [Grouping from Top-down Microarchitecture Analysis Metrics spreadsheet]
    tma_core_bound
         [This metric represents fraction of slots where Core non-memory issues were of a bottleneck]
    tma_info_core_ilp
         [Instruction-Level-Parallelism (average number of uops executed when there is execution) per thread (logical-processor)]
    tma_info_memory_l2mpki
         [L2 cache true misses per kilo instruction for retired demand loads]
    ...

This change makes it print the tool PMU events only.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-list.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 16400366f8276a7a..28bf1fc7f5eeff8f 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -130,7 +130,7 @@ static void default_print_event(void *ps, const char *topic,
 	if (deprecated && !print_state->deprecated)
 		return;
 
-	if (print_state->pmu_glob && pmu_name && !strglobmatch(pmu_name, print_state->pmu_glob))
+	if (print_state->pmu_glob && (!pmu_name || !strglobmatch(pmu_name, print_state->pmu_glob)))
 		return;
 
 	if (print_state->exclude_abi && pmu_type < PERF_TYPE_MAX && pmu_type != PERF_TYPE_RAW)
@@ -612,8 +612,10 @@ int cmd_list(int argc, const char **argv)
 	print_cb.print_start(ps);
 
 	if (argc == 0) {
-		default_ps.metrics = true;
-		default_ps.metricgroups = true;
+		if (!unit_name) {
+			default_ps.metrics = true;
+			default_ps.metricgroups = true;
+		}
 		print_events(&print_cb, ps);
 		goto out;
 	}
-- 
2.52.0.rc1.455.g30608eb744-goog

