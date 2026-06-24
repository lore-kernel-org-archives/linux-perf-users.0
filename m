Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793683E51E4;
	Wed, 24 Jun 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334736; cv=none; b=QZnNQC3UlLVOIrU51hrz+qW3BaE6OHav7bG8s5DhXLhPzi2ifnGKuZ8OIM6HpK6avgJ7rVrGHJOEVQdq5SYTmudPyquvHRhHFMwfvDNnWSD4mCoa/yPDhRdbHZarndu+zJj6fTGXtohpJrTtnyUmv6XUYBjMtBZu2c8AqAmHnbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334736; c=relaxed/simple;
	bh=YGGQf9dhGbmbCJqBPshZrMoC5SWqkROcKUZGJx6lo8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lul0r7hFKp5ZcoHfJ1hOt74t4ppTWieGodHlYhoZxNz4uKaC57CW9772F9aoFRJ0iyqdncO5YNrMOi6LfrO/ygczvEHB+ydNpYPg7F8eewsvuYneM/mLrHdwQyUPHdyutXt9EDmwtPPaAGWvKoOggffYeWKd5yvv38nP8ql9K48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adscovgv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adscovgv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4CE1F000E9;
	Wed, 24 Jun 2026 20:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334735;
	bh=w8f8N8IPBDVtHs9aRocSn84SJNcAg5lfJXV/2ZixKMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adscovgviIZoMhIfYBCXapiu4/BlYcMwcdSKX5g2uzxaw9GHQQg2itdWs/8pOtkmY
	 1PE7kZNWl8u4QEG6/LMS6AK5+L0sNoyHh5l5jSVw566i0MWpyUdhAqKlRovokiUASp
	 ln2ux5s06FhwmSWOIo1VCjvABw/2rzaAfJwvz6By7J09IAZQL2D1vgbO7KxtJjyLdG
	 VDOcm3z9RdgpzCgh5CoNlyrVeXEx3fJ7zgQI+eZOr4y5qbPlgYPoYtBb+17B4EIVTl
	 3FD0ZbY7fVe2rLH/CXVw1YzKI/hfa5yITVJJ0SVb1C+hfkRTQcudMwDvVTv3SzRRX8
	 l9/1vmT0XOVvw==
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
Subject: [PATCH v3 5/8] perf timechart: Release event samples at the end
Date: Wed, 24 Jun 2026 13:58:31 -0700
Message-ID: <20260624205852.3864874-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260624205852.3864874-1-namhyung@kernel.org>
References: <20260624205852.3864874-1-namhyung@kernel.org>
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
2.55.0.rc0.799.gd6f94ed593-goog

