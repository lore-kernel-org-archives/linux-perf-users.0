Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78C4E2F0B;
	Thu, 24 Sep 2026 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790285317; cv=none; b=efSKT/8u/aHMPN9lXr7ijzMYhT1UXcE3+bTs7wfgp//uL1GPjBya16PiB5dbiP8fnKj39I4f/Y5QKva9j1Etcp3MOhU6JgEkTSVINdH8RAuhKxfwfu3/bW+1/2NMklERDN2h0w5QYth287hmRb1dgGcT0KEtNbw4cLUytFAQhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790285317; c=relaxed/simple;
	bh=eS2gsMBGKVP+FfEWA8fe2ToTtO8enH2bmmCgZy/cRPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P0CoIhD9GWpQJ2GrWXV3jHrtBnSlkUGDpELvQCNcE7R9wL1r428O4/U3x4EG7hvkOCIeb1YY4NwUpdzGovNW9xUniBATMjpxnbAMLoEjMe2QulMv4z3pl/25x1MvE+49tYIP74qy+wAsrFLOGodNfvFFVq7oo3BalnCUJJTLJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyN8ripL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyN8ripL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB21F00898;
	Thu, 24 Sep 2026 21:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790285313;
	bh=9mYogseKBX+5WWtCwyglsgqeN/PRVM6Ugb0klUJ5z6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AyN8ripLPmVurgFrC86nT8TThRme1uGKi5dslZniQvqcrXm3oImH9Fumlkqyd1j9F
	 DFChbQF00nqQ1qAx5fWmqicXluKw/Ej61y7fjcr8YCadCvXO4cBtHEo6YUFQfwKy1o
	 gpM2d2YJ06Kuhi1oI9EoEWJFza+owRyUp1x07Br52FUWySeiojPtedHY+69nRlWpAz
	 hc3OddDHEnozDMIUBDGjEvhyy3msn279bfenJGCEjwu5cMRKFlYKUhM5UM6RO73+Yc
	 w9+MzkYk0L1+ops5nauatLpiSg3BQLhcPtbfykjx+CuOJOntflCLF0Xv64HzhZqI2T
	 dHE7KgMzf3xkA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 5/6] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Thu, 24 Sep 2026 23:28:08 +0200
Message-ID: <20260924212809.1733663-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924212809.1733663-1-acme@kernel.org>
References: <20260924212809.1733663-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data type profiling per-sample stream keys cross-CPU contention on
sample->cpu, which without PERF_SAMPLE_CPU is the "no CPU info"
sentinel, making same-instance accesses from different cores
indistinguishable from same-CPU traffic.  'perf mem record' already
passes -d and -W to the record parser, add --sample-cpu and document it
in perf-mem(1).

Also grow rec_argv: the new entry overflows it on PMUs with separate
load and store events, as the space for the fixed arguments was not
reserved.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt | 4 ++++
 tools/perf/builtin-mem.c              | 7 +++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 4d164836d0943119..fe51c5e3333dc4a0 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -14,6 +14,10 @@ DESCRIPTION
 -----------
 "perf mem record" runs a command and gathers memory operation data
 from it, into perf.data. Perf record options are accepted and are passed through.
+It also requests the address (-d), the weight (-W, where supported) and the
+CPU id (--sample-cpu) of every sampled access by default; the CPU id is what
+lets per-sample analysis tell reads and writes to the same data from
+different cores apart from same-CPU traffic.
 
 "perf mem report" displays the result. It invokes perf report with the
 right set of options to display a memory access profile. By default, loads
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 6101a26b3a781e69..ade53688ebcd0f10 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -99,8 +99,8 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	argc = parse_options(argc, argv, options, record_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	/* Max number of arguments multiplied by number of PMUs that can support them. */
-	rec_argc = argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
+	/* Max number of arguments per PMU plus the fixed ones added below. */
+	rec_argc = argc + 8 + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
 
 	if (mem->cpu_list)
 		rec_argc += 2;
@@ -135,6 +135,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/* Cross-CPU contention keys on sample->cpu, -1 without PERF_SAMPLE_CPU. */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.53.0

