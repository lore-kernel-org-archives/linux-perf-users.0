Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794749686;
	b=Njv6W1m5tYA9iIQosFbuBWh0f9knq7ZqSkunPlq4+PGz92ddHsbxjRZftmNlsH9tbfnx
	 3pqGRIsoYoOjvA+G9gT4japDoUbCjnEQumezhcwST6lwY+iobljk30bVDC++CwudQjFzT
	 MMvCX+WbCygAf6Swdm+8KHSLrHOiqUrWjkmwW9+6LFaDcumtfFjM81y3HMRORVt9iCWWt
	 9Yb7AjhiCCjC0F5bz/PKx4Bn6F84W+3UEbzcqQdXjBEqu2py9EP+VkvQaRIqAFWO5cgtq
	 gv0KxfK9/eO3i5ODIotWQeTv2g2PLM9PxLO0y9MXORAq/fA0QJnjF4/SV+szVW1FGMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794749686;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=SXaJcCouKqzKszHrd8o+tsRuU9uzV2AgyYr0jaB7tSc=;
	b=ZVVwtE9UumgRxl6oERCFg+WeO/d865GjZpBaS7eLCshugy1TOBCbnT3uKEeAQoksDPVl
	 lQplMbO+KznBgcgfFuu1yxMxcJfr0WAppS6egQL1H1lu6hYbe41EDwDm7z31PaAs9w/dp
	 20bU0BLQ0Ca5MAL0r9pwhMO4ummiRhIDQKuiPjuaGSmse5sBwJbcbxcNneKxWzcFEGoHf
	 5sUC8AvF8qy+OOlP3006XnMnpVdnCPOPu8ziLTwnZZflayeZDXOIOUj3I0W79fw5mPOr6
	 Nw5dY6YwFF+8ZXYeHYCgiSluMQkkatTJxsv8BiFqHo3QP2xZp06xWzxvWNBYueEFHMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GcuoXa5Z;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AC1606A883;
	Sun, 15 Nov 2026 13:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21AC1606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GcuoXa5Z
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B17441576;
	Sun, 15 Nov 2026 05:34:37 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 663853F85F;
	Sun, 15 Nov 2026 05:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794749680; bh=WyLDFiBub11F9lE/N3p/htOBf89UQLWlE3R+XWt46XQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GcuoXa5ZDB1sNuYrTlsKr2inrUs3rXBf6dMOYZV4iPZI/+LNAQCroBA9P7f+WbT7n
	 nEzBDDPIoUxAUYI99ArDxij+D/xBSnACc98zVWbHpu5uIOvb/5wX0tLYp3K9TOm0vS
	 Y6mUDtG9QV14hCxR4KeqxjNE/f/AfxspyanglWLI=
From: Leo Yan <leo.yan@arm.com>
Date: Sun, 15 Nov 2026 13:34:21 +0000
Subject: [PATCH 3/4] perf test: Cover multi-record thread map synthesis
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-perf_fix_large_threads-v1-3-69c9b86b9ae5@arm.com>
References: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
In-Reply-To: <20261115-perf_fix_large_threads-v1-0-69c9b86b9ae5@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Suyash Mahar <smahar@meta.com>, 
 Amir Ayupov <aaupov@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794749674; l=5467;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=WyLDFiBub11F9lE/N3p/htOBf89UQLWlE3R+XWt46XQ=;
 b=dIYfpagqqInfplOi0hqC7nLRq7i+I4NsmcujwaHtS0IYhaCJdd2WniSVGwNC5dGQ70MxVssbJ
 oDdXE/RB4EiDrl9BVv2UOaMuSSAX9YFMRunLypLtkYXeqVt+iElp3W9
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Extend the thread-map synthesis test with empty maps and sizes around
the one-record and two-record limits.

Check record sizes, entry counts, continuation flags and entry order.
Reassemble each map and verify PIDs and command names, including missing
names and full-width names without a terminating NUL.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/thread-map.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/tools/perf/tests/thread-map.c b/tools/perf/tests/thread-map.c
index 877868107455e87e526e2b336ca1ca3c7314033e..ced1a357233d68f5b81d6f2136e8cc0d0a95fc15 100644
--- a/tools/perf/tests/thread-map.c
+++ b/tools/perf/tests/thread-map.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
+#include <stdint.h>
+#include <linux/kernel.h>
 #include <sys/types.h>
 #include <unistd.h>
 #include <sys/prctl.h>
@@ -8,6 +11,7 @@
 #include "thread_map.h"
 #include "debug.h"
 #include "event.h"
+#include "tool.h"
 #include "util/synthetic-events.h"
 #include <perf/event.h>
 #include <internal/threadmap.h>
@@ -86,9 +90,110 @@ static int process_event(const struct perf_tool *tool __maybe_unused,
 	return 0;
 }
 
+struct thread_map_synthesize {
+	struct perf_tool tool;
+	struct perf_thread_map *source;
+	struct perf_thread_map *threads;
+	int offset;
+	int calls;
+};
+
+static int process_thread_map_chunk(const struct perf_tool *tool,
+				    union perf_event *event,
+				    struct perf_sample *sample __maybe_unused,
+				    struct machine *machine __maybe_unused)
+{
+	struct thread_map_synthesize *data = container_of(tool, struct thread_map_synthesize, tool);
+	struct perf_record_thread_map *map = &event->thread_map;
+	const int max_nr = (UINT16_MAX - sizeof(*map)) / sizeof(map->entries[0]);
+	int nr = min(data->source->nr - data->offset, max_nr);
+	bool more = data->offset + nr < data->source->nr;
+	int ret;
+
+	data->calls++;
+	TEST_ASSERT_VAL("wrong chunk type", event->header.type == PERF_RECORD_THREAD_MAP);
+	TEST_ASSERT_VAL("wrong chunk nr", map->nr == (u64)nr);
+	TEST_ASSERT_VAL("wrong chunk size",
+			event->header.size == sizeof(*map) + nr * sizeof(map->entries[0]));
+	TEST_ASSERT_VAL("wrong continuation marker",
+			event->header.misc == (more ? PERF_RECORD_MISC_THREAD_MAP_MORE : 0));
+
+	ret = thread_map__append_event(&data->threads, map);
+	if (ret)
+		return ret;
+	data->offset += nr;
+	return 0;
+}
+
+static int check_thread_map_chunks(struct thread_map_synthesize *data)
+{
+	const int max_nr = (UINT16_MAX - sizeof(struct perf_record_thread_map)) /
+			   sizeof(struct perf_record_thread_map_entry);
+	int ret;
+
+	ret = perf_event__synthesize_thread_map2(&data->tool, data->source,
+					       process_thread_map_chunk, NULL);
+	TEST_ASSERT_VAL("failed to synthesize chunks", !ret);
+	TEST_ASSERT_VAL("wrong chunk count",
+			data->calls == max(1, (data->source->nr + max_nr - 1) / max_nr));
+	TEST_ASSERT_VAL("incomplete thread map", data->offset == data->source->nr);
+	TEST_ASSERT_VAL("failed to assemble thread map", data->threads);
+	TEST_ASSERT_VAL("wrong assembled nr", data->threads->nr == data->source->nr);
+	TEST_ASSERT_VAL("wrong assembled refcnt", refcount_read(&data->threads->refcnt) == 1);
+
+	for (int i = 0; i < data->source->nr; i++) {
+		const char *expected = perf_thread_map__comm(data->source, i);
+		const char *comm = perf_thread_map__comm(data->threads, i);
+
+		if (!expected)
+			expected = "";
+		TEST_ASSERT_VAL("wrong assembled pid",
+				perf_thread_map__pid(data->threads, i) ==
+				perf_thread_map__pid(data->source, i));
+		TEST_ASSERT_VAL("wrong assembled comm", comm && !strncmp(comm, expected, 16));
+		TEST_ASSERT_VAL("assembled comm not terminated",
+				strlen(comm) == strnlen(expected, 16));
+	}
+	return 0;
+}
+
+static int test_thread_map_chunks(int nr)
+{
+	struct thread_map_synthesize data = { 0 };
+	int ret = -ENOMEM;
+
+	data.source = perf_thread_map__new_array(nr, NULL);
+	if (!data.source)
+		return ret;
+
+	for (int i = 0; i < nr; i++) {
+		char comm[32];
+
+		/* Include missing comms and full-width, non-NUL-terminated wire comms. */
+		perf_thread_map__set_pid(data.source, i, nr - i);
+		if (i % 3 == 0)
+			continue;
+		if (i % 3 == 1)
+			snprintf(comm, sizeof(comm), "thread-%d", i);
+		else
+			strcpy(comm, "1234567890123456");
+		data.source->map[i].comm = strdup(comm);
+		if (!data.source->map[i].comm)
+			goto out;
+	}
+
+	ret = check_thread_map_chunks(&data);
+out:
+	perf_thread_map__put(data.threads);
+	perf_thread_map__put(data.source);
+	return ret;
+}
+
 static int test__thread_map_synthesize(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct perf_thread_map *threads;
+	static const int sizes[] = { 0, 1, 2729, 2730, 3000, 5458, 5459 };
+	int ret;
 
 	TEST_ASSERT_VAL("failed to set process name",
 			!prctl(PR_SET_NAME, NAMEUL, 0, 0, 0));
@@ -103,6 +208,12 @@ static int test__thread_map_synthesize(struct test_suite *test __maybe_unused, i
 		!perf_event__synthesize_thread_map2(NULL, threads, process_event, NULL));
 
 	perf_thread_map__put(threads);
+	for (unsigned int i = 0; i < ARRAY_SIZE(sizes); i++) {
+		ret = test_thread_map_chunks(sizes[i]);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 

-- 
2.34.1

