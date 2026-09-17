Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BAF5678F2;
	Thu, 17 Sep 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660599; cv=none; b=VqjbAQXsDOTjEJx1pLrVJTcTGGWKhFOv7OZa1tMnrrQY2t/Gfse9HjEVOlMKSwe2VJZ+gfGeodYXlxS9Op5OvOPJOKMoX9owaBTeR0rrGedq3Wld/pediWz7dF1ECH2Lu1GGYoxfRm+qR/lpEQJWadqIJYov7crcQabQdaZ/9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660599; c=relaxed/simple;
	bh=wxs2XxPjV4TsQRFaOZYnOMvLj8n/AHgTau/C8WqoWYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXfYVOYo4TOx3GZSXU7Li1bwcJTaa7Vt3t4r2MJkdMwet73R79Ee3A9IqYl4jARigQR5iPi6RT7dy8AletLpmKqjJtOrO8xKiwjQEWy/oRPteHsz4qW7rXzvufOOgXUBfKarpvHSd8OeTxnCZEFznuz4Dflr6v1qvY8j9MgaAw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVV3uzih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVV3uzih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF1A1F00893;
	Thu, 17 Sep 2026 15:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789660598;
	bh=eLkJrvnAeHJo+bmYbI04lAs1t48D/OuOuWuJv/uf5x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TVV3uzihdfQU8zcgpPMxe9ZwKQc9F6ev4ugXva2nvMCXinbZT7jarO2yuihcLSlDu
	 gDvPcZ0ixlWBY0Ur04jjML//2e08ejGwImkAtTmxMxDEzYP+A98/BOLfSlHyluJTDh
	 oy93A/zoymxeJmjMWNbsc5VHohEWfUrmA3Jwn+h7UP4hAgTKSRvoF689sFIEbzqKf7
	 atQkQqTAlsRgiDnYq+AtMFBPRGQBUELfZmlBrl8/FBF3yH0toFgRgIiavSlaLhlUw6
	 FTmPTzMWv2FTc2KpfNexjChimNf+2YkZoIR0WT9PsXMKaIWdh4ZeZ6lo33zrzeZHuX
	 LSkDXej2+Mcaw==
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
Subject: [PATCH 14/15] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Thu, 17 Sep 2026 12:55:25 -0300
Message-ID: <20260917155528.62607-15-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917155528.62607-1-acme@kernel.org>
References: <20260917155528.62607-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data type profiling per-sample stream keys cross-CPU contention on
sample->cpu; without PERF_SAMPLE_CPU that field is the (u32)-1 "no CPU
info" sentinel, so same-instance accesses from different cores are
indistinguishable from same-CPU traffic.  'perf mem record' already
passes -d (addr) and -W (weight) explicitly to the record parser, add
--sample-cpu as well and document it in perf-mem(1).

The rec_argv array only had room for nine arguments per PMU plus the
user arguments, not counting the up to eight __cmd_record() adds itself,
which a new argument would overflow on PMUs with separate load and store
events; reserve space for the fixed arguments too.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt |  4 ++++
 tools/perf/builtin-mem.c              | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 6101a26b3a781e69..f25592bc52728655 100644
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
@@ -135,6 +135,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/*
+	 * The data type profiling per-sample stream keys cross-CPU contention
+	 * on sample->cpu; without PERF_SAMPLE_CPU it is the (u32)-1 'no CPU
+	 * info' sentinel.
+	 */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.55.0

