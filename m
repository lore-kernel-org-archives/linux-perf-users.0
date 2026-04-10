Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3612D9EF0;
	Fri, 10 Apr 2026 00:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781644; cv=none; b=VTWs8he3bwTYyWcAHKENt0SdFkBDmLYlFUtvQ8rqCAZI00tm0um9T/6FizummoxB4LUR4zZAo/b6QAFg/zbz5k/Hzn3PPPhkpyF+vfMKiXI0pN/fuTmhb20Wmyk77bw39dx4N41hg02P3phGyWLhxKEkSseKLUljHS3mByEdwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781644; c=relaxed/simple;
	bh=Jp9ziUk5X76/b2jCuzlaqwh1cSCiY99GdmNG2gPISJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IC78YXVtGv47JOHyHTKhXvcpErt80WX/7tckSSCThkif+WBlp1EH2GV1cYrZlrFkED8RWHy8xulKaCYRHBWKMqha7cPl/ND4Lc2o5/iwFvBlXFCEDsio2qvCnYzfb4TekWtdIRPEMR86fnIHAr6SStq9KBNQzpZNAl8gB6Ijizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucuKUn0s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucuKUn0s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BDAC4CEF7;
	Fri, 10 Apr 2026 00:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781644;
	bh=Jp9ziUk5X76/b2jCuzlaqwh1cSCiY99GdmNG2gPISJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ucuKUn0spmd3qonplG883bMrsGnNaTLSBwO+mLoumVorCf1Em37hP5Ssx02ie9EOD
	 72A+h+DZg46aKsiPIaOxnfblra/2aa77KPSXyz4mTdqpndPTMLT80U3CxJa+nxzqRZ
	 eSPpcv1nCwccCjXLW0GWYTFQDN8kS31bsogOhVEZ92o1td2lMGmXxCRcIjb6IsG0bt
	 9jkcdb9HKWuVOLE7gt6RZcO0v/l6Mp8/uag2Txrphmc6sYBQ31cbOpcYUqwz0kvnP9
	 wWhiUWN5a1RgYypsHkQvyQtNzzQ1pcoBkhWihhIO4u+SSgD7LX7ReHvpuUKy0z1azP
	 luMuH1NvkXeDw==
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
Date: Thu,  9 Apr 2026 21:39:51 -0300
Message-ID: <20260410004000.148138-5-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
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
index 2d23dbc666b676be..a7df8ed9a69e9231 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2859,6 +2859,11 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2866,6 +2871,12 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2885,7 +2896,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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
@@ -2934,7 +2951,13 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
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

