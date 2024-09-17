Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA1194139;
	Tue, 17 Sep 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726612119; cv=none; b=C0X6dNiDiFOPONES4aEBEqOMVvYw7qf09r6jMUlQkQVDKxGthXTMcwULKjZf5WCvVCMGwPus42UFE1wWrskJ6aNm4KMwXxaekHu7rr3bh0d2NLQER5T3KTANtHPnIn/8NuAgdzezqiAmXWQPOsC8rWC/LhzIXagYCw59kAQRxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726612119; c=relaxed/simple;
	bh=AQQN1mnda2JM7GBlwwL4yRhYxSncFVa6aSSrMJcPoM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLaenABJOH763pFqXZ9hLnQhH7adB6SWyZQxk5sRxUaSXkuTl/IiQwqv1QPyOMEmmYMqOSdRNxwlBgAq4/Si67wRIqWRaanSkpiKnuc9VFirP12jyAZ7p+YmR5U7zcjMmkJg7ZhtBB936ueUoiN80pOkqqomvg+9Xek1EBRscKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSsfoT+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSsfoT+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEC9C4CED0;
	Tue, 17 Sep 2024 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726612118;
	bh=AQQN1mnda2JM7GBlwwL4yRhYxSncFVa6aSSrMJcPoM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oSsfoT+tdqtfE5/R1Up6M/jwbXaK6OINoX/6NSpce/dnFQJpn54AylJAEriQgFkXS
	 /JxPtiizo/xPif82+MxAoAwHd0HBAb1FMwQAyG+q2MLG10O4ROFK8I4qqSVG2FHN7Y
	 Xppcy4dOeYKawdvuY/DADxeCoaZcybAhQza1xr30bnP+alGMNlbIpgkD28aLpYJ/vM
	 G4tKzUlcce+9sqRMj/u5gNG1CDEf2TFXHaSPhP2sxUzX7G/j4e5O9rPiRLWDAFJlWL
	 nzvMxBT3Jjs6LXRxu+jKiPUa4atKhdy+N59Tg8gaweaMwksqb+kbt0opSdyQ3euJNY
	 FUsn9Xxm9yXrg==
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
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	linux-toolchains@vger.kernel.org
Subject: [PATCH 3/5] perf record: Enable defer_callchain for user callchains
Date: Tue, 17 Sep 2024 15:28:18 -0700
Message-ID: <20240917222820.197594-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240917222820.197594-1-namhyung@kernel.org>
References: <20240917222820.197594-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 tools/perf/util/evsel.c | 17 ++++++++++++++++-
 tools/perf/util/evsel.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 701092d6b1b64124..ad89644b32f23035 100644
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
index 15e745a9a798fa29..f0a1e1d789420a94 100644
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
2.46.0.792.g87dc391469-goog

