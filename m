Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583C2F363B;
	Mon, 24 Nov 2025 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019454; cv=pass; b=MMA1vKipD2IO7EoNtu7B5DZQi93xHybpbum6y43pHachr3ShLsjmID6fCWxBvS+t78AYezlNmPQ1TEMExcd4P0rP0j470Uuq6bQLGXXvY297DexaPdlid4GvLnIr311ZXwV9/dIk9DiZuYAyYFJI1Zaw3T9F8q1ozvBo1wVIWZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019454; c=relaxed/simple;
	bh=sevA2JknAt6QkW2DSkMZ3VhBnHCK3YacoP54ZHcgmWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=omsKV7rqmrYxfMdjXG4kxayVfIfI2ORxDlcJBGWpbwS7Y6g58VVuaeEm7DC1l2hBllr7qE5p9TxTHzUj+KItCKA4ANbOYcajTJH/1hkk8fb/qjKtQIlw0cNBIsqcULc3O7qTQtUbWyV1+F+nddPPvUsJkH8zm2aThsve8lnEHSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b=KRnndxy0; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="KRnndxy0"
ARC-Seal: i=1; a=rsa-sha256; t=1764019404; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lwGWhKvYKAA5wqGBCWEyvVALDc9rSON3LbY6YQODPwmrzwUS0AtzHZqieyVJoXSkdzrPoDD8QTmuSpZ5Oe3nYPDwDZ1mUse9/LK2qdGQxW9eflEhAvM+ekTThdtY97g7jvQ/Kg/aazYRdPIvW/WhogXxr9h6Fi+Pc581RyE6Erk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764019404; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+xnE+1HBZXX6YMytZ+iSpT2O0yHGEOoCmf6XDPOjcn4=; 
	b=HkGZBc48lpYMgw8VVJZ+/7twx7QYnxEkrp55glHAVu7925nxsMlOoRzuk1tdfOf/EM2uzaWx8mApG97sDfCuCkd9u3MMfqCzP83CcXGWQho4e11pNpkuJLP0zDyfPouSTUfQ2gIrFvVPPuUDk/odhec1qTpSniRDzhMzAvQN3WM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
	dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764019404;
	s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+xnE+1HBZXX6YMytZ+iSpT2O0yHGEOoCmf6XDPOjcn4=;
	b=KRnndxy0SdoWeFLVVXH+5xZDtZHU9Om3rGAKMv1fEGoq75V/BEQomw2EAlojDvSm
	RV3APzmw9P5031b//eSrKMOCWGUtRrrLGG7ybTIpFVqFYcUbTDN4Jz3x0Bgx/YyE0Pw
	49U7mCe9CNlHqG4ZmJLZgfQY1/yjQ4rXoTUEf/ig=
Received: by mx.zohomail.com with SMTPS id 1764019401636556.5261613838819;
	Mon, 24 Nov 2025 13:23:21 -0800 (PST)
From: Derek Foreman <derek.foreman@collabora.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>
Cc: kernel@collabora.com,
	Derek Foreman <derek.foreman@collabora.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf data: Allow filtering conversion by start and end time
Date: Mon, 24 Nov 2025 15:23:00 -0600
Message-ID: <20251124212301.450296-1-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

This adds a feature to allow restricting the range of converted samples
with start and end times specified in nanoseconds.

Use it like this:

  $ perf data convert --to-json out.json -s 12345 -e 13340

Start, end, or both may be omitted.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 tools/perf/Documentation/perf-data.txt |  6 ++++++
 tools/perf/builtin-data.c              |  4 ++++
 tools/perf/util/data-convert-bt.c      | 18 ++++++++++++++++++
 tools/perf/util/data-convert-json.c    | 18 ++++++++++++++++++
 tools/perf/util/data-convert.h         |  3 +++
 5 files changed, 49 insertions(+)

diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index 417bf17e265c..db0de1f354a3 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -40,6 +40,12 @@ OPTIONS for 'convert'
 --force::
 	Don't complain, do it.
 
+-s::
+	Start time, in nanoseconds. Samples before this time will not be converted.
+
+-e::
+	End time, in nanoseconds. Samples after this time will not be converted.
+
 -v::
 --verbose::
         Be more verbose (show counter open errors, etc).
diff --git a/tools/perf/builtin-data.c b/tools/perf/builtin-data.c
index ce51cbf6dc97..da813c62e284 100644
--- a/tools/perf/builtin-data.c
+++ b/tools/perf/builtin-data.c
@@ -33,6 +33,8 @@ const char *to_ctf;
 struct perf_data_convert_opts opts = {
 	.force = false,
 	.all = false,
+	.range_start = 0,
+	.range_end = 0,
 };
 
 const struct option data_options[] = {
@@ -45,6 +47,8 @@ const struct option data_options[] = {
 #endif
 		OPT_BOOLEAN('f', "force", &opts.force, "don't complain, do it"),
 		OPT_BOOLEAN(0, "all", &opts.all, "Convert all events"),
+		OPT_U64('s', "start", &opts.range_start, "Earliest timestamp to convert"),
+		OPT_U64('e', "end", &opts.range_end, "Latest timestamp to convert"),
 		OPT_END()
 	};
 
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 3d2e437e1354..6819f11fe900 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -91,9 +91,13 @@ struct convert {
 	struct perf_tool	tool;
 	struct ctf_writer	writer;
 
+	u64			start;
+	u64			end;
+
 	u64			events_size;
 	u64			events_count;
 	u64			non_sample_count;
+	u64			skipped;
 
 	/* Ordered events configured queue size. */
 	u64			queue_size;
@@ -811,6 +815,12 @@ static int process_sample_event(const struct perf_tool *tool,
 	if (WARN_ONCE(!priv, "Failed to setup all events.\n"))
 		return 0;
 
+	if (sample->time < c->start ||
+	    (c->end && sample->time > c->end)) {
+		++c->skipped;
+		return 0;
+	}
+
 	event_class = priv->event_class;
 
 	/* update stats */
@@ -1626,6 +1636,9 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 	c.tool.namespaces      = perf_event__process_namespaces;
 	c.tool.ordering_requires_timestamps = true;
 
+	c.start = opts->range_start;
+	c.end = opts->range_end;
+
 	if (opts->all) {
 		c.tool.comm = process_comm_event;
 		c.tool.exit = process_exit_event;
@@ -1677,6 +1690,11 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
 		data.path, path);
 
+	if (c.skipped)
+		fprintf(stderr,
+			"[ perf data convert: Skipped %" PRIu64 " samples",
+			c.skipped);
+
 	fprintf(stderr,
 		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
 		(double) c.events_size / 1024.0 / 1024.0,
diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 9dc1e184cf3c..dcbba34d6b08 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -35,7 +35,11 @@ struct convert_json {
 	struct perf_tool tool;
 	FILE *out;
 	bool first;
+	u64 start;
+	u64 end;
+
 	u64 events_count;
+	u64 skipped;
 };
 
 // Outputs a JSON-encoded string surrounded by quotes with characters escaped.
@@ -165,6 +169,12 @@ static int process_sample_event(const struct perf_tool *tool,
 		return -1;
 	}
 
+	if (sample->time < c->start ||
+	    (c->end && sample->time > c->end)) {
+		++c->skipped;
+		return 0;
+	}
+
 	++c->events_count;
 
 	if (c->first)
@@ -320,6 +330,9 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 	struct convert_json c = {
 		.first = true,
 		.events_count = 0,
+		.start = opts->range_start,
+		.end = opts->range_end,
+		.skipped = 0,
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
@@ -407,6 +420,11 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
 			"[ perf data convert: Converted '%s' into JSON data '%s' ]\n",
 			data.path, output_name);
 
+	if (c.skipped)
+		fprintf(stderr,
+				"[ perf data convert: Skipped %" PRIu64 " samples.\n",
+				c.skipped);
+
 	fprintf(stderr,
 			"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples) ]\n",
 			(ftell(c.out)) / 1024.0 / 1024.0, c.events_count);
diff --git a/tools/perf/util/data-convert.h b/tools/perf/util/data-convert.h
index 1b4c5f598415..5d055e1c31c8 100644
--- a/tools/perf/util/data-convert.h
+++ b/tools/perf/util/data-convert.h
@@ -3,11 +3,14 @@
 #define __DATA_CONVERT_H
 
 #include <stdbool.h>
+#include <linux/types.h>
 
 struct perf_data_convert_opts {
 	bool force;
 	bool all;
 	bool tod;
+	u64 range_start;
+	u64 range_end;
 };
 
 #ifdef HAVE_LIBBABELTRACE_SUPPORT
-- 
2.47.3

