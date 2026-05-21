Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C22D77F7;
	Thu, 21 May 2026 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325861; cv=none; b=Yf/q8IJW9ssx6a2Jxdpg0rPsN60i5RYwtEXq3ImmVv3nErMWXuYSpBZjAzPcjDGEWXyrJC8mVfRVv4FsThTD9E16/rXuoMoD2K+XvhFLAQnqzEvwH1Y6xX0gcR6Pg0MbgUXeL7R9rQ9bGUDU80I+HXnhfkW1xIsTp1HUVWXMl0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325861; c=relaxed/simple;
	bh=+Edn1W5D1lH3mkv/wNnAzNI8XUDdDqW4IdCE5fIqW3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8lL7/b5J2So+8gZiB6Mgmghz6VUGPrqIqJdkwYtiALggfCMCOIkzO/7H+ErwiWQyqKnJqnzNW2hbIaVwbPpuCCQ7XDbyfRhyVtVejsjgGiwFuffcux/5cD09jHRrg8UNjSeDRYvh3ruAxkoR7C71mlgOsYk1T2a1vEXEzsu3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vaj13XG7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vaj13XG7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201B21F00A3B;
	Thu, 21 May 2026 01:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325860;
	bh=8aEgEHClTwj637dxSQmr23LP5M7sCrrXvlG5+XKfntU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vaj13XG7NJ1TxybJtiAH02nwDMcSpzsaCz0Dr3xV2F9fwsPGKVLfxSTLnqL8FPfxU
	 j7Rkp1V0+3qHTxXhyhJ7eWfJfnAK4HZKc9zi2EquhYk9v6Temg0sXZYW2E5GjDtEMF
	 ucNmavHzZ2En6+Rw44JVvZBiqjA2wTYebpjMsO2Vv/uEsAeAorSHHtnJ3vRtaLmy2N
	 djqjekS8SJUUkLCC5dlEdDQfan8iVnOmnBWFpbW0ctkl1m+ykCVphZumVGPLGimLgK
	 NFvsoD70aptAzzFwtgQxxlt3Mr9sZ6of4j4yk7j/y8ik+ZsdwE1hd2RvXG6XtXL5aW
	 grDUoEkxrbiVA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 05/27] perf session: Fix PERF_RECORD_READ swap and dump for variable-length events
Date: Wed, 20 May 2026 22:09:50 -0300
Message-ID: <20260521011027.622268-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The kernel dynamically sizes PERF_RECORD_READ based on
attr.read_format: only the fields enabled by PERF_FORMAT_TOTAL_TIME_ENABLED,
PERF_FORMAT_TOTAL_TIME_RUNNING, PERF_FORMAT_ID, and PERF_FORMAT_LOST
are emitted, packed with no gaps.

perf_event__read_swap() unconditionally byte-swapped time_enabled,
time_running, and id at their fixed struct offsets, causing
out-of-bounds access on smaller events and swapping the wrong
bytes when not all format fields are present.  It also swapped
sample_id_all at a fixed offset past the full struct, which is
wrong for shorter events.

Replace the individual field swaps with a single mem_bswap_64()
over the entire tail from value onward.  Since every field after
pid/tid is u64 regardless of which combination is present, this
correctly handles any read_format combination and any trailing
sample_id_all fields.

Similarly, dump_read() accessed optional fields via fixed struct
offsets, displaying values from wrong positions when not all
format bits are set.  Walk the packed u64 array sequentially
instead, with bounds checks against event->header.size.

Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 58 +++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 82ab29525a4b07e5..08fbd6a248ea949c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -354,17 +354,21 @@ static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
 		swap_sample_id_all(event, &event->fork + 1);
 }
 
-static void perf_event__read_swap(union perf_event *event, bool sample_id_all)
+static void perf_event__read_swap(union perf_event *event,
+				  bool sample_id_all __maybe_unused)
 {
+	size_t tail;
+
 	event->read.pid		 = bswap_32(event->read.pid);
 	event->read.tid		 = bswap_32(event->read.tid);
-	event->read.value	 = bswap_64(event->read.value);
-	event->read.time_enabled = bswap_64(event->read.time_enabled);
-	event->read.time_running = bswap_64(event->read.time_running);
-	event->read.id		 = bswap_64(event->read.id);
-
-	if (sample_id_all)
-		swap_sample_id_all(event, &event->read + 1);
+	/*
+	 * Everything after pid/tid is u64: the read values (variable
+	 * set determined by attr.read_format, which we don't have
+	 * here) optionally followed by sample_id_all fields.
+	 * Since all are u64, swap the entire remaining tail at once.
+	 */
+	tail = event->header.size - offsetof(struct perf_record_read, value);
+	mem_bswap_64(&event->read.value, tail);
 }
 
 static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
@@ -1200,8 +1204,9 @@ static void dump_deferred_callchain(union perf_event *event, struct perf_sample
 
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
-	struct perf_record_read *read_event = &event->read;
 	u64 read_format;
+	__u64 *array;
+	void *end;
 
 	if (!dump_trace)
 		return;
@@ -1213,18 +1218,37 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 		return;
 
 	read_format = evsel->core.attr.read_format;
+	/*
+	 * The kernel packs only the enabled read_format fields
+	 * after value, with no gaps.  Walk the packed array
+	 * instead of using fixed struct offsets.
+	 */
+	array = &event->read.value + 1;
+	end = (void *)event + event->header.size;
 
-	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
-		printf("... time enabled : %" PRI_lu64 "\n", read_event->time_enabled);
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
+		if ((void *)(array + 1) > end)
+			return;
+		printf("... time enabled : %" PRI_lu64 "\n", *array++);
+	}
 
-	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
-		printf("... time running : %" PRI_lu64 "\n", read_event->time_running);
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING) {
+		if ((void *)(array + 1) > end)
+			return;
+		printf("... time running : %" PRI_lu64 "\n", *array++);
+	}
 
-	if (read_format & PERF_FORMAT_ID)
-		printf("... id           : %" PRI_lu64 "\n", read_event->id);
+	if (read_format & PERF_FORMAT_ID) {
+		if ((void *)(array + 1) > end)
+			return;
+		printf("... id           : %" PRI_lu64 "\n", *array++);
+	}
 
-	if (read_format & PERF_FORMAT_LOST)
-		printf("... lost         : %" PRI_lu64 "\n", read_event->lost);
+	if (read_format & PERF_FORMAT_LOST) {
+		if ((void *)(array + 1) > end)
+			return;
+		printf("... lost         : %" PRI_lu64 "\n", *array++);
+	}
 }
 
 static struct machine *machines__find_for_cpumode(struct machines *machines,
-- 
2.54.0

