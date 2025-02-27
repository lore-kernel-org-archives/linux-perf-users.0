Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40817A301
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 05:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740634679; cv=none; b=OSt5GibNQeyiOmSQjB2acg6npipTOIVeO+xeQ53/U2GZir9JStTpxms/YsZQ+dNbAw5ppdKdygthSJJo/zJRcWQWa4N7qKWporxe2+DxqEJ8hxFzrw01tFXPsM8XCCZXE00lkuucjj+jjlPu+m+Eea+OJ3Tl/3RlrQqyIwNjs8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740634679; c=relaxed/simple;
	bh=1rR8jJytB0xOWPKYHQktN0m5VHhgDH25+tdcqL5+DMc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=farK6XdTeTCFpck7p6uw0pnOrlC1OQkaFHGbTaQgNvxEAv7NHRAldKRHycrdkullh7USYgK2Vo4Xin/z/F8yqHiOXt7MNjWkfzGL+/6jhuapSOz8adgFOulamnziEwT7BCVAuSnpEo4/7ZWkeG1V47IQpNK+LA52ezR8a5vDeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ZWBYkZY; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ZWBYkZY"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220ec5c16e9so10948895ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 21:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740634677; x=1741239477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNXHD5DNJ0i81uXEwr6P8BHsc0a1tUaVvv2V9KdSOQI=;
        b=1ZWBYkZYjea/v1ly1c9Lt8xM8ZEgBatTaI4xMfYbGMfoTbnOYMcBSCuz6hqng8vTeH
         h5aucpU2P3tFzDSKFk425x1ZxbTVJAqP2UOX5rqh44pYqOYqzRDHLLwIRD/PHi6Goug9
         6+eWEtb8UuKKIcE2aQclGwmdHSpOwrtV8pH1oEL9YG/Db2Q14r0yaMaA+9AGFSqMsLCG
         BBROPOG5A+WzdfLe1hBmXTprngwy8nJ1Ll2mAtne8rEGX41JQUcAlLgqLJlTpaDSwQsD
         yoin+/n5dwTwDWAYFkNw0S/FFO/4sNZLXUTBKQqak+gY/P9aL+AFVJt9fswldaXzebYD
         /N6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740634677; x=1741239477;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNXHD5DNJ0i81uXEwr6P8BHsc0a1tUaVvv2V9KdSOQI=;
        b=lp8IF4mEasUQ1CqS17ioHXvNUBNOHh6vMMTU015Idzl2AH+l/c3Qqata3sOFUh5OIq
         1c4A8IWVuKbjQ+M8+nVnesNaBQ9FAUpv1fP7VYeM62khNJKRU19GWotQIlsdFnFbbH3U
         J6oLfwqlLWCwfmVMrniwfdvxQH+UL22cR8XKaEjyDr2hI8RVXW1CUttYlUsTCcjxdbBO
         EshZY/3ZvxAlwRLhFQTsn9kmgF+a6J7cpyZpCPb45fmVrhgjHb1hi2FsWN7J8/xg3/aS
         Hw95KTCBEf95n/W6TYc9bG8CJKIjCwegTycBIFI4TaUBMRkJcKuuAuBiggjJGzzELBdo
         wTDw==
X-Forwarded-Encrypted: i=1; AJvYcCWWswGC+gDE0J8EwQe4MYXZz/rs3/cK65LgMTIC8qU575S7a5jz+xl7mpJ9yMJ0Bu9O+SHu5iG7fXtiK5R/0R36@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4suQCM6suqOK5M1QwGfNh8Zy1shy/L8MFM3o74pgeWoWYuDGs
	0cuT0Ap4PN5+IS0yq3U/Y0zJMRMnpMzrqtmIy7lNU4PsitQnyvgr2HsXbWu5BmOAlcgnv4gLygr
	1pQ==
X-Google-Smtp-Source: AGHT+IER97Jw/ACd2Odf62iA/qw1Yjy4n/9vLNreTndsODFm/yHM+CafP2o9GcFGYni3mrG3YWZG7HpI5c8=
X-Received: from pfbfc4.prod.google.com ([2002:a05:6a00:2e04:b0:732:1e74:6e9a])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:174b:b0:730:9424:ea3e
 with SMTP id d2e1a72fcca58-73426cd90a9mr30689926b3a.11.1740634677362; Wed, 26
 Feb 2025 21:37:57 -0800 (PST)
Date: Wed, 26 Feb 2025 21:34:06 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227053738.788153-1-ctshao@google.com>
Subject: [PATCH v1 1/2] perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, terrelln@fb.com, 
	leo.yan@arm.com, dvyukov@google.com, ak@linux.intel.com, 
	james.clark@linaro.org, christophe.leroy@csgroup.eu, ben.gainey@arm.com, 
	linux-perf-users@vger.kernel.org
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
 tools/lib/perf/Documentation/libperf.txt      |  1 +
 tools/lib/perf/include/perf/event.h           | 12 ++++++++++
 .../Documentation/perf.data-file-format.txt   | 17 +++++++++++---
 tools/perf/builtin-record.c                   | 23 +++++++++++++++----
 tools/perf/util/event.c                       |  1 +
 tools/perf/util/session.c                     |  5 +++-
 tools/perf/util/tool.c                        | 11 +++++++--
 7 files changed, 59 insertions(+), 11 deletions(-)

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
index 010a4edcd384..f5faceb0e248 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -604,6 +604,10 @@ contain information that otherwise would be in perf.data file's header.
 
 	PERF_RECORD_COMPRESSED 			= 81,
 
+The header is followed by compressed data frame that can be decompressed
+into array of perf trace records. The size of the entire compressed event
+record including the header is limited by the max value of header.size.
+
 struct compressed_event {
 	struct perf_event_header	header;
 	char				data[];
@@ -618,10 +622,17 @@ This is used, for instance, to 'perf inject' events after init and before
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
2.48.1.658.g4767266eb4-goog

