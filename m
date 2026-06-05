Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE411246782;
	Fri,  5 Jun 2026 23:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703493; cv=none; b=EBvKMysf5xgQZeeefRrQIiL61/jrJcrtkddewabGQTszMswUPKTEiV+bLHh4Big8AyB1Fz5QnrNQxEkrAkPka1G71dBe7KV4bWMNr7+T1a0t5o4uVe/IrmcVkFy4XE7cGgY7cg7GHcejHodXLq86F3XXiWcF1haaPxi+z4V+FEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703493; c=relaxed/simple;
	bh=qa3ZWWBQ2o3s9ahDXB5YmZfH2t0BKM1dpi9Ny4l5HO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ34sGw6BhqpHCF5T9oR0tMwb8Wtp/pcbxvdPtWNRAU3TzI+KpnBuvhIbHC9DUTEjR6WgLL7XzM7bFW3FW91IPqi9mQPcCJOZTtlWbJA4Ir87xtL41JF8MdZ6EFcn2b9fFrR1hsvoq5usyV9uLSG8cIVcuHshWd+BTQsiJZJims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQaHM8WR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQaHM8WR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A501F00898;
	Fri,  5 Jun 2026 23:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703492;
	bh=l4CVvZgRR1gb6eF3OEOwj8fb+3rz4r90kPcbC/vfZuE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQaHM8WRg5xUh7FippfWT+U4vfk8IwMhnGwtTmeZG8Zowq3qgL+RcsU7qHls26JXM
	 qWEf2DXDblLM5WQGZUhXSQSjKBv0ZGWdQMajkCwkAS8JUP9abOOdkhvUIHzyVxoPF2
	 Fj5bDEzSPLn5m0wXsV5gseHCAKrxCZMZpKPulJaNLhkTwCEUTLNt0+rjZ0ngHc5QJI
	 v/qUhmJDB9EhDY/XO0lIVknWM9j8c1QxQYaOZ+8iIeEh4KdyV1mmk9f1572ha/S+rx
	 uCGIqhlyTCJPhi4HhvSnLw+zzYkgX/UIfj6yIsr/Mu49PClPQlhJje3ZYsNggG3gDU
	 cnzgbqPS++2tQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 1/4] perf timechart: Release event samples at the end
Date: Fri,  5 Jun 2026 16:51:28 -0700
Message-ID: <20260605235131.2440270-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605235131.2440270-1-namhyung@kernel.org>
References: <20260605235131.2440270-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add timechart__release() to free all data structures added during the
sample processing.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-timechart.c | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 04dbb944a42720b4..27d17268395ed760 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1548,6 +1548,73 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
 	svg_close();
 }
 
+static void timechart__release(struct timechart *tchart)
+{
+	struct per_pid *p = tchart->all_data;
+	struct power_event *pwr = tchart->power_events;
+	struct wake_event *we = tchart->wake_events;
+
+	while (p) {
+		struct per_pid *next_pid = p->next;
+		struct per_pidcomm *c = p->all;
+
+		while (c) {
+			struct per_pidcomm *next_comm = c->next;
+			struct cpu_sample *cs = c->samples;
+			struct io_sample *ios = c->io_samples;
+
+			while (cs) {
+				struct cpu_sample *next = cs->next;
+
+				zfree(&cs->backtrace);
+				cs->next = NULL;
+				free(cs);
+
+				cs = next;
+			}
+
+			while (ios) {
+				struct io_sample *next = ios->next;
+
+				ios->next = NULL;
+				free(ios);
+
+				ios = next;
+			}
+
+			zfree(&c->comm);
+			c->next = NULL;
+			free(c);
+
+			c = next_comm;
+		}
+
+		p->next = NULL;
+		free(p);
+
+		p = next_pid;
+	}
+
+	while (pwr) {
+		struct power_event *next = pwr->next;
+
+		pwr->next = NULL;
+		free(pwr);
+
+		pwr = next;
+	}
+
+	while (we) {
+		struct wake_event *next = we->next;
+
+		zfree(&we->backtrace);
+		we->next = NULL;
+		free(we);
+
+		we = next;
+	}
+}
+
 static int process_header(struct perf_file_section *section __maybe_unused,
 			  struct perf_header *ph,
 			  int feat,
@@ -2079,6 +2146,7 @@ int cmd_timechart(int argc, const char **argv)
 
 	ret = __cmd_timechart(&tchart, output_name);
 out:
+	timechart__release(&tchart);
 	zfree(&cpus_cstate_start_times);
 	zfree(&cpus_cstate_state);
 	zfree(&cpus_pstate_start_times);
-- 
2.54.0.1032.g2f8565e1d1-goog

