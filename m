Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457D1230BD5;
	Mon, 25 May 2026 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671179; cv=none; b=gG39ZkhWnVGb++OYtBCmGWosefO93h1mp7VqedgFO2C1oq2zcLVzQQhNlYwX3SS5bsgoQnaUHeaLmZh427oImLjYF/4/TxXOQ10EpvGX5dwvkpbZWqXNM6fxbD4jG3zYGhsiKhoJMMe+aNOp3kTjo0tXFI4ibOlg6PzYzUnjEvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671179; c=relaxed/simple;
	bh=+FrKb/aPODbOMn4tQ14jFX4fEXNRcobwejc6zdUYsII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW54tJu77CFp9u2IQZ3Bdr7A36Zk2UEeo9PM5xXrE2kqsOazsnHMjXvWVko150bFTE0F/7M7+EyW16jhGoLQEaDyuvrUNtXj4ViJ70JjFCquZGUEgWsnctwHv4s9wzat/frhyDxRPhitxgLkGLk/5PEYFvQmcXvaeI5jPGP4C9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRxr37GK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRxr37GK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B944D1F000E9;
	Mon, 25 May 2026 01:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671177;
	bh=k+eYrXi6ugs6c61M2VwpDukIgVhLCh3dx5xvKu/yrMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRxr37GKQulZ+3qByzgPUvJXUcLohe5tpVP47thJm0i20dyD/uNIrM737PaJRkPZA
	 hUuwVA98W8v9J/N75tNI3chPYl+77lj5FqFHZ5hTA/qyGOEbGQ+re1+W0Li5aYs30w
	 HU4UPdAVXseJRrOKHbi35Z26sHVe4UiF4DzbU2RDUe+cZ9PNbUD/toJjG87Tea+as3
	 uDlvIP1Dl2zIz365NolAZ6VVz9L2UY/B4FMIrB1gzPWrrzljCLZLynuCx6LoaBj7R2
	 0U/3yI0EMFPkIJLKnvjD/D5MDque5fDwJvSoqZBCuWoyMzRBJdkARqU0mIOParbOSK
	 QPnnVACPBjFyA==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 04/29] perf zstd: Fix compression error path in zstd_compress_stream_to_records()
Date: Sun, 24 May 2026 22:05:24 -0300
Message-ID: <20260525010550.1100375-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525010550.1100375-1-acme@kernel.org>
References: <20260525010550.1100375-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The error fallback does memcpy(dst, src, src_size) intending to store
uncompressed data when compression fails, but this has three bugs:

1. dst has been advanced past the record header (and potentially
   past earlier compressed records), so the copy writes to the
   wrong offset in the output buffer.

2. src still points to the start of the input, not to the
   remaining uncompressed data at src + input.pos.  On a second
   or later iteration, previously compressed data would be
   duplicated.

3. No check that dst_size >= src_size — if the remaining output
   space is smaller, this is an out-of-bounds write.

Replace with return -1 after resetting the ZSTD compression
context via ZSTD_initCStream().  The -1 propagates through
zstd_compress() -> record__pushfn() -> perf_mmap__push() to the
recording loop, which breaks out and terminates recording.

Add an out_child_no_flush label in __cmd_record() so the
mmap-read failure path skips the final record__mmap_read_all()
flush — retrying the same read that just failed would just fail
again, and the flush is only useful when the mmap data is intact
but the control path (auxtrace, switch_output) had an error.

Consolidate all error paths through a single 'reset' label to
ensure the compression context is always reset on failure —
including the output-buffer-full path, where a bare return
without resetting would leave stale stream state that corrupts
output if the caller retries.

Also guard against process_header() writing the event header
before the buffer-full check: add a sizeof(perf_event_header)
pre-check so the callback never writes past the output buffer.

Guard against ZSTD making no progress: if output.pos is zero
after ZSTD_compressStream(), calling process_header(record, 0)
would re-trigger header initialization, double-subtracting the
header size from dst_size and underflowing the unsigned counter.

Also fix two pre-existing issues in the same function:

- Add a dst_size guard before subtracting the record header
  size: if the output buffer is nearly full, the unsigned
  dst_size -= size underflows to a huge value, causing
  ZSTD_compressStream to write past the buffer boundary.

- Check the ZSTD_initCStream() return value and log an error
  if the context reset itself fails.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |  6 +++++-
 tools/perf/util/zstd.c      | 27 +++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cc601796b2c8ae60..f1877bac815d76b2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2743,7 +2743,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
-			goto out_child;
+			goto out_child_no_flush;
 		}
 
 		if (auxtrace_record__snapshot_started) {
@@ -2890,6 +2890,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_child:
 	record__stop_threads(rec);
 	record__mmap_read_all(rec, true);
+	goto out_free_threads;
+out_child_no_flush:
+	/* mmap read already failed — retrying would just fail again */
+	record__stop_threads(rec);
 out_free_threads:
 	record__free_thread_data(rec);
 	evlist__finalize_ctlfd(rec->evlist);
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 57027e0ac7b658a8..ecda9deb53b738fa 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <string.h>
+#include <linux/perf_event.h>
 
 #include "util/compress.h"
 #include "util/debug.h"
@@ -54,7 +55,13 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 
 	while (input.pos < input.size) {
 		record = dst;
+		/* process_header writes the event header into record */
+		if (dst_size < sizeof(struct perf_event_header))
+			goto reset;
 		size = process_header(record, 0);
+		/* Output buffer full — cannot fit even the record header */
+		if (size > dst_size)
+			goto reset;
 		compressed += size;
 		dst += size;
 		dst_size -= size;
@@ -65,10 +72,18 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 		if (ZSTD_isError(ret)) {
 			pr_err("failed to compress %ld bytes: %s\n",
 				(long)src_size, ZSTD_getErrorName(ret));
-			memcpy(dst, src, src_size);
-			return src_size;
+			goto reset;
 		}
 		size = output.pos;
+		/*
+		 * No progress: ZSTD couldn't emit any bytes into the
+		 * remaining output buffer.  Calling process_header
+		 * with size=0 would re-trigger header initialization,
+		 * double-subtracting the header size from dst_size and
+		 * underflowing the unsigned counter.
+		 */
+		if (size == 0)
+			goto reset;
 		size = process_header(record, size);
 		compressed += size;
 		dst += size;
@@ -76,6 +91,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 	}
 
 	return compressed;
+
+reset:
+	/* Reset so the context is usable if the caller retries */
+	ret = ZSTD_initCStream(data->cstream, data->comp_level);
+	if (ZSTD_isError(ret))
+		pr_err("failed to reset compression context: %s\n",
+			ZSTD_getErrorName(ret));
+	return -1;
 }
 
 size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
-- 
2.54.0

