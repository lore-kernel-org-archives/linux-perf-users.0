Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8E23DBD41;
	Fri, 10 Apr 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858973; cv=none; b=iZP5+p5L0NnS1iZpJ6eR5PpFBLaBbd+3BzQE+/ZRlyIb/d4J0uM0OrgP3I88hOCye5qVAkqschkJpqUtvRk55fa9wmV/ogo1iZvSgnFnDDWnSzuRiLZbB2UmbFIYW0G5plyV0NC9EUlhsuJaEhCcCKH+rwxDVxRzSknHjbqGEG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858973; c=relaxed/simple;
	bh=9tBE5rnu1zSYpmohReFZ3WZHY+jkTYGMyy6ZAi7z448=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2Bh0KyIYjrDmQben41GPBngkmK2BD4ffQFc4lGI9KT5kCBWI//ExBiNsOapnA6FWg+TVBftLMrn8qB03YdYGNvjJ3koScXUIBZOWmfnyjEtPttsZH3Sf8ELPzYtNq+fX/H3tOnhFSC5DqKZkiX4ih/BKkNf8Mq0IxkiI+vVkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p30pfaan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p30pfaan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF81C19421;
	Fri, 10 Apr 2026 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858973;
	bh=9tBE5rnu1zSYpmohReFZ3WZHY+jkTYGMyy6ZAi7z448=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p30pfaan8iAFKpM51HeswUxEcAp+thkkTIZcc1LGUC4PDotUk9I9lz6hil49sAxuD
	 51QxULz9wRUI+MQAKDlRG4oJchmqHxdCZDGVYTmS/Y54GTfa8l8CJ0rZoVBeD555Ve
	 nPjp+JBCop7L68mZRfHUNR2NalySaAGXl4bjP7+wMtuSMjMI5o9AGxYL963LUf7TB+
	 7nlBpvoI6K1AbpgwiDFwWEwd3ewU8OrXooXazHd1+tv/RM6TYDhoDIMEwvOhFRXIJx
	 rX0a2fd4biLF5MGBn1/k9E2dd1vDnPtgGLVaXfSlA87xTn9cvXpng0LRBZ384+5WSj
	 vJ1ivpMxCcnmQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/13] perf header: Sanity check HEADER_CPU_TOPOLOGY
Date: Fri, 10 Apr 2026 19:08:56 -0300
Message-ID: <20260410220905.200051-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add validation to process_cpu_topology() to harden against malformed
perf.data files:

- Verify nr_cpus_avail was initialized (HEADER_NRCPUS processed first)
- Bounds check sibling counts (cores, threads, dies) against nr_cpus_avail
- Fix two bare 'return -1' that leaked env->cpu by using 'goto free_cpu'

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Code:claude-opus-4-6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 4cb748763c8a0741..acd6b07528e013a4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2861,6 +2861,11 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	int cpu_nr = env->nr_cpus_avail;
 	u64 size = 0;
 
+	if (cpu_nr == 0) {
+		pr_err("Invalid HEADER_CPU_TOPOLOGY: missing HEADER_NRCPUS\n");
+		return -1;
+	}
+
 	env->cpu = calloc(cpu_nr, sizeof(*env->cpu));
 	if (!env->cpu)
 		return -1;
@@ -2868,6 +2873,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	if (do_read_u32(ff, &nr))
 		goto free_cpu;
 
+	if (nr > (u32)cpu_nr) {
+		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_cores (%u) > nr_cpus_avail (%d)\n",
+		       nr, cpu_nr);
+		goto free_cpu;
+	}
+
 	env->nr_sibling_cores = nr;
 	size += sizeof(u32);
 	if (strbuf_init(&sb, 128) < 0)
@@ -2887,7 +2898,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 	env->sibling_cores = strbuf_detach(&sb, NULL);
 
 	if (do_read_u32(ff, &nr))
-		return -1;
+		goto free_cpu;
+
+	if (nr > (u32)cpu_nr) {
+		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_threads (%u) > nr_cpus_avail (%d)\n",
+		       nr, cpu_nr);
+		goto free_cpu;
+	}
 
 	env->nr_sibling_threads = nr;
 	size += sizeof(u32);
@@ -2936,7 +2953,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		return 0;
 
 	if (do_read_u32(ff, &nr))
-		return -1;
+		goto free_cpu;
+
+	if (nr > (u32)cpu_nr) {
+		pr_err("Invalid HEADER_CPU_TOPOLOGY: nr_sibling_dies (%u) > nr_cpus_avail (%d)\n",
+		       nr, cpu_nr);
+		goto free_cpu;
+	}
 
 	env->nr_sibling_dies = nr;
 	size += sizeof(u32);
-- 
2.53.0

