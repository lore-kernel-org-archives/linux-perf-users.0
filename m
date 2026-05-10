Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C121A19CD0A;
	Sun, 10 May 2026 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384204; cv=none; b=jLhGkrdW+vPz105nXKRvIHIgcDKyzqJAhYD14LutSd8/4ypgGsIbPhKwMhP4YqrQCYYBdqUZnbInHce0oRMUETqKi2m8s8ZSGE+TxQSG06ZsSbmMvPR2fKFImJN7lNleGISaG/sGVc5Sd0Wq6s1JpJ5i+thHEDp1IIz8YBDxdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384204; c=relaxed/simple;
	bh=7eJTKkRkPEdMSMjklTcR1Ee4Xwpm0KUX1Tfr4R7f9Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwyHr03oeMEIp1gSe66XF5+t2ze+1FByKB5QpGl/D5/ZlL4B2KuRs4bKJBB8k8KhDm2giuyZ34AHh7LJelGHq/0mZWu5K01mLZyrcsypLkKQomqwB0peuNtc6oC4AjKFEPELCIutU3IJ2Sabep0P8fJ4NXxgexJIxGvYunsbiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNT13Vju; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNT13Vju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F35CC2BCB8;
	Sun, 10 May 2026 03:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384204;
	bh=7eJTKkRkPEdMSMjklTcR1Ee4Xwpm0KUX1Tfr4R7f9Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vNT13VjuHKT5QcGunpuBo/NSy1IRgCoxKIFAk4RQllVjbTI+iQDXEMi4B6UKXXrLC
	 4oLkdCHPq5UsHoiF9AJNnynYHDsUGfoP5BsjBWhKm2LKXAdiaemAJIViO4dPyYbG77
	 2Fn/0TrY6eW2AbP8NZBaYZw85n+u99dVgTrR6H74vZuB1nvMI+WfJCZstK37smsnpH
	 eQW9V65JjQKsMBg1EYjScBq1FCrkgO9/rIiqN7SllxTHbHVJgSvERB1ihHcll83P2N
	 mjIDeLCScvCNxpw5yxl941Sek3PSjk1jb8UWr++c6X9+D81CB0rvoRzBSJfYtVVBru
	 9AZogGH3pbJGQ==
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
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 23/28] perf tools: Harden compressed event processing
Date: Sun, 10 May 2026 00:34:14 -0300
Message-ID: <20260510033424.255812-24-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
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
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 17 +++++++++++++++++
 tools/perf/util/tool.c   | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index bda8705e87648800..994e54167ea3196b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3849,6 +3849,23 @@ static int process_compressed(struct feat_fd *ff,
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
index ff2150517b75587a..96fa6d6c55cdca1e 100644
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

