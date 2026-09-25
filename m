Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71BE4C2251;
	Fri, 25 Sep 2026 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790348862; cv=none; b=EYw905MCtNlQZWb37uyMYJLwEmMGwsNdbqgCtxI6cj9FIPcIb7IOwmwhWsM0b14boW4imnYGqcj/e5Hc4xcP437N8/y5vlK6vNfltxjalScFuBA+AxH+vRQ7ai+nj4AbHyFggP3CmGTu/+dHROR3jg+xwoyB0zL4XGXb1/7LHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790348862; c=relaxed/simple;
	bh=eS2gsMBGKVP+FfEWA8fe2ToTtO8enH2bmmCgZy/cRPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sC+LfjrO3ys03KFfJXLIfslCbgzXdW+7ISGaRpo1H5cE3R1e977wCzd/5FYVq5qMWO8j+wxJMZ67OIXw4WkHPXlfg209ZujiRCvqUgbpF4Jp6axfjBpw4mVTuWmEmhUNHfOiI7oL8I7rW9QG4ccU52Z0eO/Xywo5ktEi1Sdg2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYD+KN7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYD+KN7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5841F0089B;
	Fri, 25 Sep 2026 15:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790348836;
	bh=9mYogseKBX+5WWtCwyglsgqeN/PRVM6Ugb0klUJ5z6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYD+KN7uBoEDBGgr8KXCSxsYvy4iHMs+RWdA1xuih0QVQ22/IkO+DZdX8+gOMpE4w
	 kfd7blqKbmoLc9hgeho1J0034cgMIzm3NThRtcKDT57NjsoiT/agx9LtSeFLo3hZ3x
	 XmCVoruP45loKqT1OXVWPWHiZ++mHlUcmBfnlAFmsqwXI+2ZWQPkTdIuk8PkxphZPm
	 8IMiYmLph3P/p6uCBFtvvrjjiIMiPw7Eu14m8225UM5S7NcidhC7f+2qNrOMbk/xpB
	 8kI5vO6haIkUqWjeGp31WRRMDzkbCAqT40/gzXdxDihgHMeklwARIS5L6IH3nuICGF
	 VArUBYuqbuXoA==
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
Subject: [PATCH 5/6] perf mem record: Request PERF_SAMPLE_CPU by default
Date: Fri, 25 Sep 2026 17:06:56 +0200
Message-ID: <20260925150657.1826942-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925150657.1826942-1-acme@kernel.org>
References: <20260925150657.1826942-1-acme@kernel.org>
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

