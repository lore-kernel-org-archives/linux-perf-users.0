Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C426B742;
	Tue, 30 Jun 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803848; cv=none; b=P2Ye+7r1A1XkWpMvxjqHN2W8e9gx76KBGVlIZv6WjTCFASjAKgt25pdpUmTgjxIIVbW+6qRA7VVxYqjsp91SQZERBDwD1bEkRefUIfH/Z2bDMdHD7yWC0H32r7sxa7gr23JYr6in3PLO2O0FrvVjvhXPBpsq2OHFJT5cOB4Wq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803848; c=relaxed/simple;
	bh=JqZJP21lCWtWbxeT8DRjG109JH/zlAGCQvixFwXlUfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rg12RxRqoZKk8g/xZToA2vsLFbzjFRPiMsb9iNaE0WKEktJtctdfvKahoD9tFM3X20Y5FR5Cqamj9tKY8jhmnlR5nYIrk+ndckAb6HhAn1BiEsbJVZXyfniE33IfUpypzGcIQj168m0SGw4iPyc46qETjoK9T5OqnaZq7V353O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=fqMa6E1F; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="fqMa6E1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1782803845;
	bh=yl4lBvhKtymGECG8PBkuQg3Xj2MGd956ocDQu44WW34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fqMa6E1FZQ808BJ4E55h9Z66xCQ9sqAgmDaBP6E6NPLIaQxnVUhSf+iEvIU0DYh0R
	 3oEeiXozJmiSTiRqeONCSU45h8oUKhn+99Ro+2Lo+Ho+o6uhph8XS0zDRnvcX30zKC
	 BaUf15yzET3Q9gUTseLOoH5swOARPcPCko3qjhrU=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 8A42BDB24B;
	Tue, 30 Jun 2026 07:17:25 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com,
	Farid Zakaria <fmzakari@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH v2 2/3] perf record: Avoid overrunning the zstd output buffer
Date: Tue, 30 Jun 2026 07:17:01 +0000
Message-ID: <dc9557edfb93f0470f7854906e8fcf1ccb0ed0c7.1782743187.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782743187.git.d@ilvokhin.com>
References: <cover.1782743187.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zstd_compress_stream_to_records() compresses one mmap chunk into 'dst'
as a chain of records, decrementing 'dst_size' as each record's header
and compressed payload are written, but it never checks that the space
left can still hold a record before writing one.

When the compressed output does not fit in 'dst', 'dst_size -= size'
underflows ('dst_size' is a size_t), the output size is then taken as
max_record_size again, and ZSTD_compressStream() writes past the end
of 'dst'.

Pass the space left in 'dst' to process_comp_header() and let it return
-1 when the record header or its 8-byte alignment padding would not fit.
Stop compressing on -1 instead of writing past 'dst'.

Fixes: f24c1d7523e6 ("perf tools: Introduce Zstd streaming based compression API")
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/perf/builtin-record.c | 11 +++++++++--
 tools/perf/util/compress.h  |  6 ++++--
 tools/perf/util/zstd.c      | 23 ++++++++++++++++++-----
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 2562c3177eae..fc89ccc78d4d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1581,8 +1581,10 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
  * Called once with data_size == 0 to start a record, then once with
  * data_size == compressed payload size to finalize and 8-byte-pad it
  * (unaligned records trip ASan in the reader).
+ * Returns the bytes written, or -1 if it won't fit.
  */
-static size_t process_comp_header(void *record, size_t data_size)
+static ssize_t process_comp_header(void *record, size_t dst_size,
+				   size_t data_size)
 {
 	struct perf_record_compressed2 *event = record;
 	size_t size = sizeof(*event);
@@ -1593,10 +1595,15 @@ static size_t process_comp_header(void *record, size_t data_size)
 		event->data_size = data_size;
 		event->header.size = PERF_ALIGN(size + data_size, sizeof(u64));
 		padding = event->header.size - size - data_size;
+		if (padding > dst_size)
+			return -1;
 		memset(record + size + data_size, 0, padding);
-		return data_size + padding;
+		return padding;
 	}
 
+	if (size > dst_size)
+		return -1;
+
 	event->header.type = PERF_RECORD_COMPRESSED2;
 	event->header.size = size;
 	event->data_size = 0;
diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index 6cfecfca16f2..ec6c38129e24 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -54,7 +54,8 @@ int zstd_fini(struct zstd_data *data);
 
 ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
-				       size_t process_header(void *record, size_t increment));
+				       ssize_t process_header(void *record, size_t dst_size,
+							      size_t data_size));
 
 size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
 			      void *dst, size_t dst_size);
@@ -75,7 +76,8 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
 				       void *dst __maybe_unused, size_t dst_size __maybe_unused,
 				       void *src __maybe_unused, size_t src_size __maybe_unused,
 				       size_t max_record_size __maybe_unused,
-				       size_t process_header(void *record, size_t increment) __maybe_unused)
+				       ssize_t process_header(void *record, size_t dst_size,
+							      size_t data_size) __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 1955fa2431d1..04910dfed84f 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -30,9 +30,11 @@ int zstd_fini(struct zstd_data *data)
 
 ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
-				       size_t process_header(void *record, size_t data_size))
+				       ssize_t process_header(void *record, size_t dst_size,
+							      size_t data_size))
 {
-	size_t ret, size, compressed = 0;
+	size_t ret, compressed = 0;
+	ssize_t size;
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output;
 	void *record;
@@ -54,7 +56,11 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 
 	while (input.pos < input.size) {
 		record = dst;
-		size = process_header(record, 0);
+		size = process_header(record, dst_size, 0);
+		if (size < 0) {
+			pr_err("failed to compress: output buffer too small\n");
+			return -1;
+		}
 		compressed += size;
 		dst += size;
 		dst_size -= size;
@@ -68,8 +74,15 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 			memcpy(dst, src, src_size);
 			return src_size;
 		}
-		size = output.pos;
-		size = process_header(record, size);
+		compressed += output.pos;
+		dst += output.pos;
+		dst_size -= output.pos;
+
+		size = process_header(record, dst_size, output.pos);
+		if (size < 0) {
+			pr_err("failed to compress: output buffer too small for padding\n");
+			return -1;
+		}
 		compressed += size;
 		dst += size;
 		dst_size -= size;
-- 
2.53.0-Meta

