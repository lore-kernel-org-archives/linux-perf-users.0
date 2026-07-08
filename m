Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C837701A;
	Wed,  8 Jul 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517952; cv=none; b=ThpkNCryHRDEc0b1DKlJPO7M1eoJbPnvG52sS1W/TkirGDGVqoOmptQlNdMABo2GliE+1PLdbOTl1Isrp0pMVhOkljii5c7h/qi2KH5D5gUKnxc0168iFxalB4hhh/Cudf7xJhGoxePu9PFZ0QsGVUCLH/1wvf9ZRlULSyGTLu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517952; c=relaxed/simple;
	bh=drSdzFtOTiY51h4BjbUfgI4s48IpJ/f1Y0bzs9T08T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEWSj0uUTyDdhyJTdfLkN0fVF/GZFvKi52Nj2/NLZWtGC0jprwYtEPzLLg12b6VTiDFKoIi7k2V24eKdc9cAEY7eIlP5osgLYLgDdeY/GroglyfWWB9A1RDTX+4FWVxogVMndrsGauqu6DCTXSrlpPOcHHm3M7Amw725r8m+AGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=BPPe5YWg; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="BPPe5YWg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1783517943;
	bh=KkwwfaZwOFp5JoqmM/Z9OkDuIahoICAojXVEbPLrqQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BPPe5YWgrSFd1TnMr8mjHnYjT00J60j/4JIRnu9sqfzut5w8GZ97XvnEW7dPHxqT/
	 p3NAuqEpfAav+BvnvFkFmYjxcPW3P/I3sY/t+jN9Mzi8BrHa8tD8kURYsdh22O1naQ
	 S2M4B7N7ZSNcZfV2UdR+5QHqaw/Lhp0K9EFiKNMg=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 120A7DB5BC;
	Wed, 08 Jul 2026 13:39:03 +0000 (UTC)
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
Subject: [PATCH v3 1/2] perf record: Return the written size from process_comp_header()
Date: Wed,  8 Jul 2026 13:38:33 +0000
Message-ID: <9a23dffc110b0e0ead7120fcbbef57b8e6c0b8a6.1783513665.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783513665.git.d@ilvokhin.com>
References: <cover.1783513665.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

process_comp_header() is called from zstd_compress_stream_to_records()
twice per record: once with data_size == 0 to write the record header,
and once with the payload size to finalize it. It returns the increment
it was passed, and the loop separately decides whether a record still
fits by comparing the remaining 'dst_size' against the header size.

With the fit check split from the code that writes the record,
process_comp_header() cannot reject a record on its own, so any bytes it
writes into 'dst' have to be bounds-checked by the caller instead of
where they are produced.

Pass the space left in 'dst' to process_comp_header(), let it return the
number of bytes written or -1 when the header does not fit, and account
the compressed payload in the loop.

No functional change intended.

Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/perf/builtin-record.c | 17 +++++++++++++----
 tools/perf/util/compress.h  |  6 ++++--
 tools/perf/util/zstd.c      | 25 ++++++++++++++-----------
 3 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ebd3ed0c9b3e..757bf4486898 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1592,16 +1592,25 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
 	}
 }
 
-static size_t process_comp_header(void *record, size_t increment)
+/*
+ * Called once with data_size == 0 to start a record, then once with
+ * data_size == compressed payload size to finalize.
+ * Returns the bytes written, or -1 if it won't fit.
+ */
+static ssize_t process_comp_header(void *record, size_t dst_size,
+				   size_t data_size)
 {
 	struct perf_record_compressed2 *event = record;
 	size_t size = sizeof(*event);
 
-	if (increment) {
-		event->header.size += increment;
-		return increment;
+	if (data_size) {
+		event->header.size += data_size;
+		return 0;
 	}
 
+	if (size > dst_size)
+		return -1;
+
 	event->header.type = PERF_RECORD_COMPRESSED2;
 	event->header.size = size;
 
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
index 21a0eb58597c..d98014902f01 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -31,9 +31,11 @@ int zstd_fini(struct zstd_data *data)
 
 ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
-				       size_t process_header(void *record, size_t increment))
+				       ssize_t process_header(void *record, size_t dst_size,
+							      size_t data_size))
 {
-	size_t ret, size, compressed = 0;
+	size_t ret, compressed = 0;
+	ssize_t size;
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output;
 	void *record;
@@ -55,12 +57,9 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 
 	while (input.pos < input.size) {
 		record = dst;
-		/* process_header writes the event header into record */
-		if (dst_size < sizeof(struct perf_event_header))
-			goto reset;
-		size = process_header(record, 0);
+		size = process_header(record, dst_size, 0);
 		/* Output buffer full — cannot fit even the record header */
-		if (size > dst_size)
+		if (size < 0)
 			goto reset;
 		compressed += size;
 		dst += size;
@@ -74,17 +73,21 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 				(long)src_size, ZSTD_getErrorName(ret));
 			goto reset;
 		}
-		size = output.pos;
+		compressed += output.pos;
+		dst += output.pos;
+		dst_size -= output.pos;
 		/*
 		 * No progress: ZSTD couldn't emit any bytes into the
 		 * remaining output buffer.  Calling process_header
-		 * with size=0 would re-trigger header initialization,
+		 * with output.pos=0 would re-trigger header initialization,
 		 * double-subtracting the header size from dst_size and
 		 * underflowing the unsigned counter.
 		 */
-		if (size == 0)
+		if (output.pos == 0)
+			goto reset;
+		size = process_header(record, dst_size, output.pos);
+		if (size < 0)
 			goto reset;
-		size = process_header(record, size);
 		compressed += size;
 		dst += size;
 		dst_size -= size;
-- 
2.53.0-Meta

