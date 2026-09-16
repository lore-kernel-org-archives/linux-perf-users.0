Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD74D9567;
	Wed, 16 Sep 2026 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583583; cv=none; b=sL+YUJ9vEmQ4GX5jvCQD5tRFqk0eM8PMCWvDDDHL/c1cCVhokxq1ZIKcKzj3MKDv+1cdTS0LkY7Duv16lZOaFZxEe5DSQ1y8Ioc2wLh/5/NpsnUwTVd+Z86yUqYycMMb+lXu54UsRhVhc8qfX61X2se+Y92BUL+SJOjei3Ffiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583583; c=relaxed/simple;
	bh=vcrRIdYWh+TkOxK4o1c2gaMNRQIaB920uKIymM152zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jr48DbzHQJyYvYNcT8DIPZQ4kLhLCuKDKOMU5t4gjFObZNjOAbcNhAQUdqRoJVO7tmxj1SGL1z/s+XuRNpb63kh0Vxtv22QAqj4CbxybMUblOopxiEGXm3UUeAUI4U0XL1jvzUXnytTVS/xSxfPg621L/VxcTqpePXyGER8S/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVBE0tC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVBE0tC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8C1F0089E;
	Wed, 16 Sep 2026 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583578;
	bh=PesbCEUBP8rgUhZmjbD7d1nULNdWHibHSP58/nvi8YQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PVBE0tC5ThVwGGQRo1KpSYuBbK4HO/tMq72vd8LGVS8dQd4xE8973bZoKmTBBfHqf
	 Lbg8plfculrLfALJDCZNNoeOMH9MlieV+aMeD2lsUiXS72fhVqn9G//toKkQR6pYfM
	 5mNHjMyaPur759UzIhM2lzI8YbVgwhWu6iZaw09YN6n0TDFI9/mrUK8KBhtAEKlz6o
	 7aj15RhD3PD9L3mCYjRRX1qFh1ogDGRTxA9KZ88PaUYBHIHI42XWgfeefRRojovXin
	 Opw6fxRC9C88vFXF+r3+ExQwD3vrAPtQxIwp9Zkq0SF/J1uvGtbE1o3itZhC2uzipT
	 iR4ZYRCJBelRQ==
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
Subject: [PATCH 11/12] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Wed, 16 Sep 2026 15:32:12 -0300
Message-ID: <20260916183215.54305-12-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916183215.54305-1-acme@kernel.org>
References: <20260916183215.54305-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The data-type profiling per-sample stream keys cross-CPU contention on
sample->cpu: without PERF_SAMPLE_CPU the cpu field is the (u32)-1 "no
CPU info" sentinel, documented as such in perf_session__deliver_event(),
and same-instance reads and writes from different cores are
indistinguishable from same-CPU traffic, so pahole's false-sharing
detector cannot tell them apart.

builtin-record.c already defines --sample-cpu and 'perf mem record'
forwards unknown options to the record parser, so passing it explicitly
works today; make it the default, next to the -d (addr) and -W (weight)
the command already requests, documenting it in perf-mem(1).

The rec_argv array is sized as nine arguments per memory PMU plus the
user arguments, not counting the arguments __cmd_record() adds itself,
up to eight with all the optional flags.  On PMUs with separate load and
store events the four event arguments plus the fixed ones already filled
the array to its last slot, so this new argument would write past it;
reserve space for the fixed arguments explicitly.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-mem.txt |  4 ++++
 tools/perf/builtin-mem.c              | 18 ++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 6101a26b3a781e69..6f38cda1a45ada16 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -99,8 +99,13 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 	argc = parse_options(argc, argv, options, record_usage,
 			     PARSE_OPT_KEEP_UNKNOWN);
 
-	/* Max number of arguments multiplied by number of PMUs that can support them. */
-	rec_argc = argc + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
+	/*
+	 * Max number of arguments multiplied by number of PMUs that can
+	 * support them, plus the arguments added directly below, at most:
+	 * "record", "-W", "-d", "--sample-cpu", "--phys-data",
+	 * "--data-page-size", "--all-user" and "--all-kernel".
+	 */
+	rec_argc = argc + 8 + 9 * (perf_pmu__mem_events_num_mem_pmus(pmu) + 1);
 
 	if (mem->cpu_list)
 		rec_argc += 2;
@@ -135,6 +140,15 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem,
 
 	rec_argv[i++] = "-d";
 
+	/*
+	 * The data-type profiling per-sample stream keys cross-CPU
+	 * contention on sample->cpu (PERF_SAMPLE_CPU); without it the cpu
+	 * field is the (u32)-1 'no CPU info' sentinel and same-instance
+	 * reads and writes from different cores are indistinguishable
+	 * from same-CPU traffic.
+	 */
+	rec_argv[i++] = "--sample-cpu";
+
 	if (mem->phys_addr)
 		rec_argv[i++] = "--phys-data";
 
-- 
2.55.0

