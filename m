Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA072D8DBB;
	Sun, 24 May 2026 03:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593387; cv=none; b=NcMhgVDbDGYccbWlKCgrwyVJRE4FoUZ/JCpdb5e+nQzgTdnwIJLxbAiFYB6/Bq4ZlU4zy2w6uhp2vkSnEB78dvzFFbSO2E0ZvP6SmNXtILNHbXCXvanwhg0CqfusdtQiOr2jbsn3kdltoNgTWeffNM23sYUD5ZDCIFbeacErUXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593387; c=relaxed/simple;
	bh=7BfUSFxhvQiZ/9erI37Zh7/DZXO4bcePBxeXoTrkHF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k94I0b1kCclfEN4hZkoLyMNYbnPCumm44j0kWjnnKUx2nNYs0V6qd3foREckjfaQLPQyZD9j+jgLkFwarSMBll569qTGpWwKIiYwPBmzPmulQEA9CDl2FMq0toJX/+XNUDh5a8fyzn7HH/fz+GMgn9fqwT7JiR9ry48QZecmCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeNIgAm+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeNIgAm+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACB31F000E9;
	Sun, 24 May 2026 03:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593385;
	bh=JwN1/rjTuPK2ADJs/TduD1p/8EDddQ/xzHOt5TDJr4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UeNIgAm++FzT2QqzotNdTW8Q4APTLNQWhWgO6jog+gzxgtHkqgoLbvCxIziTwyEM9
	 no7iIeKZKh/pSDpDpLoSj5U7U0LFMUnzFnVetKrzm8eoN9a6Pf5z8FLYvA/PBFutjK
	 jVGSZOQL+mjWTnsBI+uVl9lTAeGM2yR3YetdyYxxR79nMWKnsHi5vDGODgMTh/qqrS
	 KU0gWrIVFCFfEb4xCOoxF5OpSLegL9poh+9VJjuhFAfY7lEv+s6nnBplBpaZiymNbV
	 6RB0lQJ40tprJJOhcEXobWtLe53cG9P9NjZTGeRU2O90VaYOWpL2XS4hi68uoBqoLP
	 ix9QOPzE+2+qA==
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
Subject: [PATCH 24/29] perf tools: Harden compressed event processing
Date: Sun, 24 May 2026 00:26:58 -0300
Message-ID: <20260524032709.1080771-25-acme@kernel.org>
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

Add several hardening checks to the compressed event decompression
pipeline:

1. Guard against decomp_last_rem underflow: check that
   decomp_last->head does not exceed decomp_last->size before
   subtracting.  A u64 underflow here would produce a huge
   decomp_len, causing an oversized mmap allocation.

2. Validate comp_mmap_len from the HEADER_COMPRESSED feature
   section: reject values that are not 4K-aligned, smaller than
   4096, or larger than ~2 GB (prevents size_t overflow when
   adding decomp_last_rem on 32-bit, while allowing legitimate
   large mmap buffers from perf record -m).

3. Validate COMPRESSED event header size: reject events where
   header.size is too small to contain the fixed struct fields,
   preventing underflow in the payload size calculation.

4. Validate COMPRESSED2 event data_size: check that data_size
   does not exceed the available payload (header.size minus the
   fixed struct fields) for the newer compressed format.

5. Reject compressed events when the HEADER_COMPRESSED feature
   is missing from the file header, which means no decompression
   context was initialized.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 17 +++++++++++++++++
 tools/perf/util/tool.c   | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 66929c5557b21494..cbc740fd29e6846c 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3861,6 +3861,23 @@ static int process_compressed(struct feat_fd *ff,
 	if (do_read_u32(ff, &(env->comp_mmap_len)))
 		return -1;
 
+	/*
+	 * FIXME: perf.data should record the recording system's page
+	 * size — it affects mmap buffer alignment, sample addresses,
+	 * and data_page_size/code_page_size interpretation.  Without
+	 * it we assume 4K (the smallest Linux page size) as a safe
+	 * minimum alignment for comp_mmap_len validation.
+	 *
+	 * Cap at 2 GB to keep decomp_len + decomp_last_rem +
+	 * sizeof(struct decomp) within size_t range on 32-bit.
+	 */
+	if (env->comp_mmap_len < 4096 || env->comp_mmap_len % 4096 ||
+	    env->comp_mmap_len > (2U * 1024 * 1024 * 1024 - 4096)) {
+		pr_err("Invalid HEADER_COMPRESSED: comp_mmap_len (%u) must be a 4K-aligned value in [4096, %u]\n",
+		       env->comp_mmap_len, 2U * 1024 * 1024 * 1024 - 4096);
+		return -1;
+	}
+
 	return 0;
 }
 
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 225a77d530ce8ab3..18641919473a859f 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -24,7 +24,15 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 	size_t mmap_len, decomp_len = perf_session__env(session)->comp_mmap_len;
 	struct decomp *decomp, *decomp_last = session->active_decomp->decomp_last;
 
+	if (!decomp_len) {
+		pr_err("Compressed events found but HEADER_COMPRESSED not set\n");
+		return -1;
+	}
+
 	if (decomp_last) {
+		/* Prevent u64 underflow in decomp_last_rem */
+		if (decomp_last->head > decomp_last->size)
+			return -1;
 		decomp_last_rem = decomp_last->size - decomp_last->head;
 		decomp_len += decomp_last_rem;
 	}
@@ -47,14 +55,37 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 		decomp->size = decomp_last_rem;
 	}
 
+	/*
+	 * Events are read directly from the mmap'd file; fields could
+	 * theoretically change via a FUSE-backed file, but that applies
+	 * to the entire event processing pipeline, not just here.
+	 */
 	if (event->header.type == PERF_RECORD_COMPRESSED) {
+		if (event->header.size < sizeof(struct perf_record_compressed))
+			goto err_decomp;
 		src = (void *)event + sizeof(struct perf_record_compressed);
 		src_size = event->pack.header.size - sizeof(struct perf_record_compressed);
 	} else if (event->header.type == PERF_RECORD_COMPRESSED2) {
+		/*
+		 * prefetch_event() only guarantees that the 8-byte
+		 * event header fits; validate that header.size covers
+		 * the data_size field before accessing it, otherwise a
+		 * crafted event reads data_size from adjacent memory.
+		 */
+		if (event->header.size < sizeof(struct perf_record_compressed2))
+			goto err_decomp;
 		src = (void *)event + sizeof(struct perf_record_compressed2);
 		src_size = event->pack2.data_size;
+		/*
+		 * data_size is independent of header.size (which
+		 * includes padding); verify it doesn't exceed the
+		 * actual payload to prevent out-of-bounds reads in
+		 * zstd_decompress_stream().
+		 */
+		if (src_size > event->header.size - sizeof(struct perf_record_compressed2))
+			goto err_decomp;
 	} else {
-		return -1;
+		goto err_decomp;
 	}
 
 	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
@@ -77,6 +108,11 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 	pr_debug("decomp (B): %zd to %zd\n", src_size, decomp_size);
 
 	return 0;
+
+err_decomp:
+	munmap(decomp, mmap_len);
+	pr_err("Couldn't decompress data\n");
+	return -1;
 }
 #endif
 
-- 
2.54.0

