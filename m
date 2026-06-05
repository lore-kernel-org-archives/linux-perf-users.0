Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B593D4103;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780701117; cv=none; b=oADePNdI/UTWTMLXYTWYMwjj8tXJaAxS9+KhDFpiXvJFkmU7d55O2+MF9uRBgDBvz3ePk0xvtqT+maYVkPqI3zFEjlZz0N511c4EsH9rNHRrpcCp64MeIo8X287XIl9TqUDGTnLWqIkzXq3ROF1LMRgWCh5+lqbYh3TmD1g/+U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780701117; c=relaxed/simple;
	bh=jpBTqInRbgQxdCIwDI4YdK9vHSjJaqxKka/nVdGlfLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COayaaFSXarztAunm06SqFHwSPj2l+ov9emLF7SbJQg4hD+Spiy4vZjVmJkfzNiEEKZ/ZGvv1L7cyoiO6uzNbxeRP3yYBI13OwXCqxTGjNT+ErYkiR2yMNpiCdGLVh0dFtVFrvIwUM46LYVlFttulQtywsYoncyLmaroqHcYHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX78hrkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX78hrkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101451F0089B;
	Fri,  5 Jun 2026 23:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780701116;
	bh=YPIoOh7krPlHLe1es6eCkUrkktxwGB9Au0T9+DGZFTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DX78hrkKcBB53scyNOMsIOEbHHVa8ezQJ0qB/ndXBZVzaNjEFbHzFmhocPnZqkSPR
	 04grE5O7VXXa8Ow4O/U/Jd2wZT7QY4P1/7mdZQs92uT777ku9sM++qAzcIDDJUlm5+
	 o303JR4Ttdik2WE/FE2ZLDJxSe7cxDOo7SNWntnyoEwXIXMtxxQN0RUBHZD8dAwCvc
	 V/tTW5/P26fQqTHk/nRv8Apr4xh1nD77M2PvxGu0goyn5Qa7bV+W94KmUhl1T/FSiY
	 VUwXBUhHB20mY2BjMhWWE1lNqeiLHkKF72H+RgZY2YXk1/g3nhjtTcET012/dPS8+E
	 tiLx+rgsc2ckg==
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
Subject: [PATCH 1/4] perf timechart: Release event samples at the end
Date: Fri,  5 Jun 2026 16:11:52 -0700
Message-ID: <20260605231155.2415760-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605231155.2415760-1-namhyung@kernel.org>
References: <20260605231155.2415760-1-namhyung@kernel.org>
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
 tools/perf/builtin-timechart.c | 54 ++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 04dbb944a42720b4..7c4ace51302e260c 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1548,6 +1548,59 @@ static void write_svg_file(struct timechart *tchart, const char *filename)
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
+				free((char *)cs->backtrace);
+				free(cs);
+				cs = next;
+			}
+
+			while (ios) {
+				struct io_sample *next = ios->next;
+
+				free(ios);
+				ios = next;
+			}
+
+			free(c->comm);
+			free(c);
+			c = next_comm;
+		}
+		p = next_pid;
+	}
+
+	while (pwr) {
+		struct power_event *next = pwr->next;
+
+		free(pwr);
+		pwr = next;
+	}
+
+	while (we) {
+		struct wake_event *next = we->next;
+
+		free((char *)we->backtrace);
+		free(we);
+		we = next;
+	}
+}
+
 static int process_header(struct perf_file_section *section __maybe_unused,
 			  struct perf_header *ph,
 			  int feat,
@@ -2079,6 +2132,7 @@ int cmd_timechart(int argc, const char **argv)
 
 	ret = __cmd_timechart(&tchart, output_name);
 out:
+	timechart__release(&tchart);
 	zfree(&cpus_cstate_start_times);
 	zfree(&cpus_cstate_state);
 	zfree(&cpus_pstate_start_times);
-- 
2.54.0.1032.g2f8565e1d1-goog

