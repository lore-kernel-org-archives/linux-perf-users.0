Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0123ED6A;
	Sun, 24 May 2026 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593281; cv=none; b=PaPq2K36YnXeP/RZ+JN+q1BCmb6277E1+9I4vYK3sdUM5Yj23E+vmTsIPCIq9u+0QSiB0oUHIfuiDk0IKgbysKh4lo1D7h7ftYQTIWzYvgvr7Q8CZa5rkCnMhCTtvNGCBtajuZ4hKvCm37/VmBt11ygKC6TljfiNW/tz70k5cvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593281; c=relaxed/simple;
	bh=1icRCEUVUbNpEULRDqf7Od1F6V14idhuhW/lrdRGItg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2XL24+daLGpN8OJv9FfY7c6BXOFEZjHlzgP0vidDox69udKsX50YcX4qhqSVVrMVtop51q/4esuDS8QtWVXA44iE4jPA734ZZnveci7LwuDOU621vCep6qQTAEVbTA/xr7/NrO+fl35lQzVbFJQ4WjBgiMlULbHzRi3H/iTkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPMnwjpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPMnwjpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6055B1F000E9;
	Sun, 24 May 2026 03:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593279;
	bh=5DHJa/rQqcvUROnaKpJ3Zcfqv/577LXlWJV3fLKo5RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PPMnwjpwttLN9Fh5VHflGAE+extuMiDDqeNBaUeJErvKa+Cj5OmI+Uf7npiWp3xC7
	 JeZ1RWt/Uennzc9zc+eTfB8eyoMvDRA+cC68lyycZP0xL5soCfnfuIUxGhrJh5iaIs
	 TubBktiIHiizUgAQlR5vVESkoz4qji/MppmRIN1XEj8aVo8jys3tdRWkr9UzXZXeQa
	 Qry9Ly6aghw7GltlN9jSs4inPLb1kOWdU7LHp6p0C557IDXq28toqMOFvRM7zsE03Z
	 XVqSKv91khmM9FRyMut16orB4R8qzr5oNhxL0Fx8M38Iw8fCyRf3VaX/EiIxmdz4XP
	 EcY8JwYPZXONg==
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
Subject: [PATCH 06/29] perf session: Fix PERF_RECORD_READ swap and dump for variable-length events
Date: Sun, 24 May 2026 00:26:40 -0300
Message-ID: <20260524032709.1080771-7-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 tools/perf/util/session.c | 61 ++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index c4cd8ad6d810a74c..24f2ba599b8079bd 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -354,17 +354,24 @@ static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
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
+	/* mem_bswap_64 rounds up to 8-byte chunks — unaligned tail overruns the buffer */
+	if (tail % sizeof(u64))
+		return;
+	mem_bswap_64(&event->read.value, tail);
 }
 
 static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
@@ -1200,8 +1207,9 @@ static void dump_deferred_callchain(union perf_event *event, struct perf_sample
 
 static void dump_read(struct evsel *evsel, union perf_event *event)
 {
-	struct perf_record_read *read_event = &event->read;
 	u64 read_format;
+	__u64 *array;
+	void *end;
 
 	if (!dump_trace)
 		return;
@@ -1213,18 +1221,37 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
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

