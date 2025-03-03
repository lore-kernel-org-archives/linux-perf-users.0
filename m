Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37A84A3E
	for <linux-perf-users@vger.kernel.org>; Mon,  3 Mar 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027022; cv=none; b=W77ZSzJyZYtbEKK06Fopg7UzGgNS90kMeDIcaUegFmBJC4DQAwX8vslg2+JdELsm6WzWU/Wa8bR8vKrMFQUd76IZPfQQAP3LNDJ6zQtStHPb4Fq1OvWPUsAtKgphuCz54baYiIb8AQtn8VfYh5XVqcgCHF3WoKjseSWtR7flPaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027022; c=relaxed/simple;
	bh=AiW+DTPcnhyBSCgRnqgPg8u/ghgUAH9ao0pYg17lCBQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sVyJN/UQgVifRD/2hl+vMLWCqWyaQ1HTZ9gvjjHLFXGWMo94xiLmzK5qlj6q9RkEjcJctVuUadg26MSkFnlyFdJfkF2EB91Ow18tz2oiLBP/QiFQ98mT6p+eWcU6tA3rmtHnTtXiX4s2kiO52bj8dyU+ajMPjQDvBZTQdBpttik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdw+Sf29; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdw+Sf29"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb019b13aso13721044a91.3
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Mar 2025 10:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741027020; x=1741631820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G++k4W7n+duBWzePELDvk0hBNSPbp+/yi/W/D3fZOT8=;
        b=zdw+Sf290tnMO3esoJmRn8tNVpMfE3T9Tm4Mt4+GAUQl1eUFFrEkojEOngoxsKV93z
         vgzSscO6joQwopp+7fo0wYKf/l9LffoJpKgPvhCxD5jl8GTAOXJsFyEACcDH4FyqJjN4
         PsrqX1q5ukKvJs0SPp6g9DnT7JqHcYn9JN1Btc1trBcCKciBc+jtJzYH7kkT7ntU9yG1
         73Ntl3lxU6Y270dynSC1eX8ADoLcyk5xiIA83mFeXLG/w0+QymB9McSl1Nle3UAAvM6C
         zHDCYLEkKVtDxSmJnOsYcG18hHzcUjKvWHDJmYvMOa+e9tmSqOeqwBqo3p3Y8JrHQahn
         ZaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741027020; x=1741631820;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G++k4W7n+duBWzePELDvk0hBNSPbp+/yi/W/D3fZOT8=;
        b=nudgUEy2sM+/ZfZCrQWDE/3qXHHq5PKLvddjd6rP5V3kmJg8+wYnb/WKU4PaBkJusN
         QDqcz1pWy4WcT/FCF5eCU2R3+laGOpvwwEoDLgVtnjI6ThAnGejaR0HXkvmD0H3Zmy4C
         pU+W/XwvBBWvo0t+sQyFTELbbPUo7TwXlFed/qc2EoVJFYtuWvmZcmA/v7cfjslKMiBV
         UD18kB7NHKL+L7SxsOAOkS7HC50VKPkeRNM6PuWg0eWc9r4fQmOStEj8UUAFdhwDgUkn
         Gw9ZZOipXODa06umDIDPULuCx0P8P2K0yAFfHTFv0gWnC/MZ+luKc1QQkHSugpvjAmrY
         N8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUgfYrjdLmYIfCL/NojEK2QZAfAz10F7p6kEhJbM3Vhepcggf0VOoxwJDPpuoIfAAfA7fe2wHGf7cUNDrSdwP5P@vger.kernel.org
X-Gm-Message-State: AOJu0YzELyy/akJGXrg0mAq8+bodUSp8w4ibYysDd2g6I+sFrBnb/NB8
	zcXUpo7thtT59PGkf1d62/uk4lQaxu+3AuPbKcAw+ChJoWmS0YKbRicccJ8B0KhZPiypsJmWYBV
	e6Q==
X-Google-Smtp-Source: AGHT+IEb9dzTwTTSzzri/IFr9sj0tYmEtHIiN4Tk2J9uYgPzzdlQFIjtCirLTNbMcwBigQI0UK/vmpadPZw=
X-Received: from pgc18.prod.google.com ([2002:a05:6a02:2f92:b0:ad5:45a5:645a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1592:b0:1f2:f1a9:b2d1
 with SMTP id adf61e73a8af0-1f2f4ccb3bbmr22442550637.13.1741027019767; Mon, 03
 Mar 2025 10:36:59 -0800 (PST)
Date: Mon,  3 Mar 2025 10:32:40 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303183646.327510-1-ctshao@google.com>
Subject: [PATCH v2 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com, 
	leo.yan@arm.com, james.clark@linaro.org, christophe.leroy@csgroup.eu, 
	ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The original PERF_RECORD_COMPRESS is not 8-byte aligned, which can cause
asan runtime error:

  # Build with asan
  $ make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g -fno-omit-frame-pointer -fsanitize=undefined"
  # Test success with many asan runtime errors:
  $ /tmp/perf/perf test "Zstd perf.data compression/decompression" -vv
   83: Zstd perf.data compression/decompression:
  ...
  util/session.c:1959:13: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 13 byte alignment
  0x7f69e3f99653: note: pointer points here
   d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
                ^
  util/session.c:2163:22: runtime error: member access within misaligned address 0x7f69e3f99653 for type 'union perf_event', which requires 8 byte alignment
  0x7f69e3f99653: note: pointer points here
   d0  3a 50 69 44 00 00 00 00  00 08 00 bb 07 00 00 00  00 00 00 44 00 00 00 00  00 00 00 ff 07 00 00
                ^
  ...

Since there is no way to align compressed data in zstd compression, this
patch add a new event type `PERF_RECORD_COMPRESSED2`, which adds a field
`data_size` to specify the actual compressed data size. The
`header.size` contains the total record size, including the padding at
the end to make it 8-byte aligned.

Tested with `Zstd perf.data compression/decompression`

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
v2:
  Add deprecated comment for `PERF_RECORD_COMPRESSED`.

 tools/lib/perf/Documentation/libperf.txt      |  1 +
 tools/lib/perf/include/perf/event.h           | 12 ++++++++++
 .../Documentation/perf.data-file-format.txt   | 24 +++++++++++++++----
 tools/perf/builtin-record.c                   | 23 ++++++++++++++----
 tools/perf/util/event.c                       |  1 +
 tools/perf/util/session.c                     |  5 +++-
 tools/perf/util/tool.c                        | 11 +++++++--
 7 files changed, 64 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 59aabdd3cabf..4072bc9b7670 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -210,6 +210,7 @@ SYNOPSIS
   struct perf_record_time_conv;
   struct perf_record_header_feature;
   struct perf_record_compressed;
+  struct perf_record_compressed2;
 --

 DESCRIPTION
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 37bb7771d914..09b7c643ddac 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -457,6 +457,16 @@ struct perf_record_compressed {
 	char			 data[];
 };

+/*
+ * `header.size` includes the padding we are going to add while writing the record.
+ * `data_size` only includes the size of `data[]` itself.
+ */
+struct perf_record_compressed2 {
+	struct perf_event_header header;
+	__u64			 data_size;
+	char			 data[];
+};
+
 enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_USER_TYPE_START		= 64,
 	PERF_RECORD_HEADER_ATTR			= 64,
@@ -478,6 +488,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_HEADER_FEATURE		= 80,
 	PERF_RECORD_COMPRESSED			= 81,
 	PERF_RECORD_FINISHED_INIT		= 82,
+	PERF_RECORD_COMPRESSED2			= 83,
 	PERF_RECORD_HEADER_MAX
 };

@@ -518,6 +529,7 @@ union perf_event {
 	struct perf_record_time_conv		time_conv;
 	struct perf_record_header_feature	feat;
 	struct perf_record_compressed		pack;
+	struct perf_record_compressed2		pack2;
 };

 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 010a4edcd384..cd95ba09f727 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -370,7 +370,7 @@ struct {
 	u32	mmap_len;
 };

-Indicates that trace contains records of PERF_RECORD_COMPRESSED type
+Indicates that trace contains records of PERF_RECORD_COMPRESSED2 type
 that have perf_events records in compressed form.

 	HEADER_CPU_PMU_CAPS = 28,
@@ -602,7 +602,14 @@ struct auxtrace_error_event {
 Describes a header feature. These are records used in pipe-mode that
 contain information that otherwise would be in perf.data file's header.

-	PERF_RECORD_COMPRESSED 			= 81,
+	PERF_RECORD_COMPRESSED 			= 81, /* deprecated */
+
+The header is followed by compressed data frame that can be decompressed
+into array of perf trace records. The size of the entire compressed event
+record including the header is limited by the max value of header.size.
+
+It is deprecated and new files should use PERF_RECORD_COMPRESSED2 to gurantee
+8-byte alignment.

 struct compressed_event {
 	struct perf_event_header	header;
@@ -618,10 +625,17 @@ This is used, for instance, to 'perf inject' events after init and before
 regular events, those emitted by the kernel, to support combining guest and
 host records.

+	PERF_RECORD_COMPRESSED2			= 83,

-The header is followed by compressed data frame that can be decompressed
-into array of perf trace records. The size of the entire compressed event
-record including the header is limited by the max value of header.size.
+8-byte aligned version of `PERF_RECORD_COMPRESSED`. `header.size` indicates the
+total record size, including padding for 8-byte alignment, and `data_size`
+specifies the actual size of the compressed data.
+
+struct perf_record_compressed2 {
+	struct perf_event_header	header;
+	__u64				data_size;
+	char				data[];
+};

 Event types

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9af3f21fd015..d07ad670daa7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -648,14 +648,27 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;

 	if (record__comp_enabled(rec)) {
+		struct perf_record_compressed2 *event = map->data;
+		size_t padding = 0;
+		u8 pad[8] = {0};
 		ssize_t compressed = zstd_compress(rec->session, map, map->data,
 						   mmap__mmap_len(map), bf, size);

 		if (compressed < 0)
 			return (int)compressed;

-		size = compressed;
-		bf   = map->data;
+		bf = event;
+		thread->samples++;
+
+		/*
+		 * The record from `zstd_compress` is not 8 bytes aligned, which would cause asan
+		 * error. We make it aligned here.
+		 */
+		event->data_size = compressed - sizeof(struct perf_record_compressed2);
+		event->header.size = PERF_ALIGN(compressed, sizeof(u64));
+		padding = event->header.size - compressed;
+		return record__write(rec, map, bf, compressed) ||
+		       record__write(rec, map, &pad, padding);
 	}

 	thread->samples++;
@@ -1534,7 +1547,7 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)

 static size_t process_comp_header(void *record, size_t increment)
 {
-	struct perf_record_compressed *event = record;
+	struct perf_record_compressed2 *event = record;
 	size_t size = sizeof(*event);

 	if (increment) {
@@ -1542,7 +1555,7 @@ static size_t process_comp_header(void *record, size_t increment)
 		return increment;
 	}

-	event->header.type = PERF_RECORD_COMPRESSED;
+	event->header.type = PERF_RECORD_COMPRESSED2;
 	event->header.size = size;

 	return size;
@@ -1552,7 +1565,7 @@ static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
 			    void *dst, size_t dst_size, void *src, size_t src_size)
 {
 	ssize_t compressed;
-	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
+	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed2) - 1;
 	struct zstd_data *zstd_data = &session->zstd_data;

 	if (map && map->file)
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index c23b77f8f854..80c9ea682413 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -77,6 +77,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
 	[PERF_RECORD_COMPRESSED]		= "COMPRESSED",
 	[PERF_RECORD_FINISHED_INIT]		= "FINISHED_INIT",
+	[PERF_RECORD_COMPRESSED2]		= "COMPRESSED2",
 };

 const char *perf_event__name(unsigned int id)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..db2653322f9f 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1400,7 +1400,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int err;

 	perf_sample__init(&sample, /*all=*/true);
-	if (event->header.type != PERF_RECORD_COMPRESSED || perf_tool__compressed_is_stub(tool))
+	if ((event->header.type != PERF_RECORD_COMPRESSED &&
+	     event->header.type != PERF_RECORD_COMPRESSED2) ||
+	    perf_tool__compressed_is_stub(tool))
 		dump_event(session->evlist, event, file_offset, &sample, file_path);

 	/* These events are processed right away */
@@ -1481,6 +1483,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		err = tool->feature(session, event);
 		break;
 	case PERF_RECORD_COMPRESSED:
+	case PERF_RECORD_COMPRESSED2:
 		err = tool->compressed(session, event, file_offset, file_path);
 		if (err)
 			dump_event(session->evlist, event, file_offset, &sample, file_path);
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 3b7f390f26eb..37bd8ac63b01 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -43,8 +43,15 @@ static int perf_session__process_compressed_event(struct perf_session *session,
 		decomp->size = decomp_last_rem;
 	}

-	src = (void *)event + sizeof(struct perf_record_compressed);
-	src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
+	if (event->header.type == PERF_RECORD_COMPRESSED) {
+		src = (void *)event + sizeof(struct perf_record_compressed);
+		src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
+	} else if (event->header.type == PERF_RECORD_COMPRESSED2) {
+		src = (void *)event + sizeof(struct perf_record_compressed2);
+		src_size = event->pack2.data_size;
+	} else {
+		return -1;
+	}

 	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
--
2.48.1.711.g2feabab25a-goog

