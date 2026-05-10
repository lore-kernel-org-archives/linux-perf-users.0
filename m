Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6340F1F0995;
	Sun, 10 May 2026 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384101; cv=none; b=hWEJsTcmKdk8YUvhu5XlGK4v3iNmXveAzVr3L2Rlyc+6BqNvyryoX8JHse28/miRf+Rlhoofc6zrMf9VNmj9wCWWS/uvCYcJpPaLiPBEwKaJpNzK0/pmSkrDNNfG63LwX9jG0qPZvuEdM7DMAYootHkqOjsh10UPhovDGfdvYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384101; c=relaxed/simple;
	bh=kO/zKhM1q+2sUbndHha4D8Medz5q2w1EfzTYaMn6Ng4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmJC7Bs7EH44QWyD4+eHzT6oxhpFN3LQFXR/VJJGMvAXw1PA8RGUKUJontYr/FhIclKX2kNuYciQUphwa/zjDQoGJ1/gSAb1FWdt3VzgRI6LnnmiT19IkllD0QPGtKK7yTxpOAudeOEuysXsY6CWTCghmtT2fR6ZGQdG7PYG1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adBKdL5b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adBKdL5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2EBC2BCF6;
	Sun, 10 May 2026 03:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384101;
	bh=kO/zKhM1q+2sUbndHha4D8Medz5q2w1EfzTYaMn6Ng4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=adBKdL5b/ZamG8xfLl3FdM3Yhmm6eP4Uz32ZX8HGqOGmb6ixWN/cNp4JICWgf7bs5
	 ERqE50JV8Z1B36Y63fP76yWN7G9FzfcXzfppuEf3m3BwdQprdvm6fVGVaOWH03ENcG
	 7TmkyXMNOtUD8wThUWsWX6kJ3/A6nAFYT8C4PKe0mdqo7zOvstvSgPyr8xdNXQXlHw
	 NDGNs61iAB1GkuvdXIiqkkoOipbXI7e/b+nj3fIIGD4gbAnU6Y/JcTkA5CW7jcWiRC
	 NHIb9Y8OI5Pnvf1T9KJ8KbhIoglfrHeZ3059ZXiSb4PusuDgTCCRBFXMY2MLMU6PHT
	 XHIRuroObNf2A==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 05/28] perf session: Fix PERF_RECORD_READ swap and dump for variable-length events
Date: Sun, 10 May 2026 00:33:56 -0300
Message-ID: <20260510033424.255812-6-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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
bytes when not all format fields are present.  It also dropped
the sample_id_all swap entirely.

Replace the individual field swaps with a single mem_bswap_64()
over the entire tail from value onward.  Since every field after
pid/tid is u64 regardless of which combination is present, this
correctly handles any read_format combination and any trailing
sample_id_all fields.

Similarly, dump_read() accessed optional fields via fixed struct
offsets, displaying values from wrong positions when not all
format bits are set.  Walk the packed u64 array sequentially
instead, with bounds checks against event->header.size.

Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 61 +++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index aae0651fb6f025a1..20b70d6fb7cc8ed4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -354,17 +354,22 @@ static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
 		swap_sample_id_all(event, &event->fork + 1);
 }
 
-static void perf_event__read_swap(union perf_event *event, bool sample_id_all)
+static void perf_event__read_swap(union perf_event *event,
+				  bool sample_id_all __maybe_unused)
 {
-	event->read.pid		 = bswap_32(event->read.pid);
-	event->read.tid		 = bswap_32(event->read.tid);
-	event->read.value	 = bswap_64(event->read.value);
-	event->read.time_enabled = bswap_64(event->read.time_enabled);
-	event->read.time_running = bswap_64(event->read.time_running);
-	event->read.id		 = bswap_64(event->read.id);
+	size_t tail;
 
-	if (sample_id_all)
-		swap_sample_id_all(event, &event->read + 1);
+	event->read.pid = bswap_32(event->read.pid);
+	event->read.tid = bswap_32(event->read.tid);
+	/*
+	 * Everything after pid/tid is u64: the read values (variable
+	 * set determined by attr.read_format, which we don't have
+	 * here) optionally followed by sample_id_all fields.
+	 * Since all are u64, swap the entire remaining tail at once.
+	 */
+	tail = event->header.size - offsetof(struct perf_record_read, value);
+	tail &= ~(size_t)(sizeof(__u64) - 1);
+	mem_bswap_64(&event->read.value, tail);
 }
 
 static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
@@ -1198,8 +1203,9 @@ static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event
 
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
-	struct perf_record_read *read_event = &event->read;
 	u64 read_format;
+	__u64 *array;
+	void *end;
 
 	if (!dump_trace)
 		return;
@@ -1211,18 +1217,37 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
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

