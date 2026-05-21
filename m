Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCFF2FD1AA;
	Thu, 21 May 2026 01:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325919; cv=none; b=gsfItad2VS86kCfFGAI09AOsSKss2DwImxzPuZlrks9p66HCcNzYU+auAjTyNztVLdwhs/W9IDz5M6UUwejotXTX/q8Iyw7/mFCIZOP0KD9+lFxZi7qs11fiAyBLR5n18zALHczYYnwkCSgukDcuqjtotlhwhWMRVqWp4Nb2HyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325919; c=relaxed/simple;
	bh=4GiJux1QXQ0TO/PnVj5QD9bUFxkgW1/aL3+3VWPmNd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDpV2yJyzhi1kp6OEIHuES2h7DxZj8Q08/NcjhrRYreDDCmglEsQfPE7TZ6TN3DW7uk3l8RWxBZEfyIOp8o/0fsLPGnCeQrRx8yh6gC+D9tSyNQY1ldRtBSYnhANkYpWAsm7/RSfhRemw9OZyXxa9lnaa/ryAZaZFAyax2NLDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRkxCwju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRkxCwju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E691F000E9;
	Thu, 21 May 2026 01:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325918;
	bh=cDSk8lTfw789EePfAjRGrLwoyOcs30FApoVLrMXWXu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eRkxCwjuOt0xzfXy1/Gfi0LRXcbFspWUp9pcZk8iiy0oPsxOmNUA98/AjXpYzZtGP
	 4Kj1uQw0M+HcIFsWwwGZJ0FBfvBOW4+B5AxnQXrfgzWhOEQoJenNMbVhkFt1jZDV84
	 73zr2qtgN+scDKPRGZMcQi2MRmB0ph7LpfkINS5PFTsNtBppHupDu5X0+VLH9QFMdx
	 ZlUKGxDR77pbqsgOISr0WG/0XB8Ckq1+6fO1NTaO9qYrTMFpJEw8ZM/qeM3Fyp6APb
	 aF9iE4X148yujCLVWtleDIPPipOSPR2nXrcc5sKt9XWFGOcHdRcCEo+c1OtnRAGCg4
	 crmBNU24luxyA==
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
	Wang Nan <wangnan0@huawei.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 20/27] perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
Date: Wed, 20 May 2026 22:10:05 -0300
Message-ID: <20260521011027.622268-21-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

read_event_desc() reads nre (event count), sz (attr size), and nr
(IDs per event) from the file and uses them to control allocations
and loops without validating them against the section size.

A crafted perf.data could trigger large allocations or many loop
iterations before __do_read() eventually rejects the reads.

Add bounds checks in read_event_desc():
- Reject sz smaller than PERF_ATTR_SIZE_VER0.
- Require at least one event (nre > 0).
- Check that nre events fit in the remaining section, using the
  minimum per-event footprint of sz + sizeof(u32).
- Pre-swap attr->size to native byte order, then reject values
  below PERF_ATTR_SIZE_VER0 or above sz before calling
  perf_event__attr_swap() to prevent heap out-of-bounds access.
- Handle ABI0 (attr.size == 0): substitute PERF_ATTR_SIZE_VER0,
  and on native-endian files write the value back so
  free_event_desc() does not treat the zero as its end-of-array
  sentinel (it iterates while attr.size != 0).  The swap path
  skips the write-back — perf_event__attr_swap() has its own
  ABI0 fallback that sets VER0 after swapping.
- Check that nr IDs fit in the remaining section before allocating.

Fixes: b30b61729246 ("perf tools: Fix a problem when opening old perf.data with different byte order")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 54 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index bea1446046282ce9..05674b76df9b47f6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2173,9 +2173,28 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 	if (do_read_u32(ff, &nre))
 		goto error;
 
+	/* Size of each of the nre attributes. */
 	if (do_read_u32(ff, &sz))
 		goto error;
 
+	/*
+	 * Require at least one event with an attr no smaller than the
+	 * first published struct, and reject sz values where
+	 * sz + sizeof(u32) would overflow size_t (possible on 32-bit)
+	 * or nre == UINT32_MAX where nre + 1 wraps to 0 in the calloc.
+	 *
+	 * The minimum section footprint per event is sz bytes for the
+	 * attr plus a u32 for the id count, check that nre events fit.
+	 */
+	if (!nre || sz < PERF_ATTR_SIZE_VER0 ||
+	    sz > ff->size || (size_t)sz > SIZE_MAX - sizeof(u32) ||
+	    nre == UINT32_MAX ||
+	    nre > (ff->size - ff->offset) / (sz + sizeof(u32))) {
+		pr_err("Invalid HEADER_EVENT_DESC: nre=%u sz=%u (min %d)\n",
+		       nre, sz, PERF_ATTR_SIZE_VER0);
+		goto error;
+	}
+
 	/* buffer to hold on file attr struct */
 	buf = malloc(sz);
 	if (!buf)
@@ -2191,6 +2210,9 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		msz = sz;
 
 	for (i = 0, evsel = events; i < nre; evsel++, i++) {
+		struct perf_event_attr *attr = buf;
+		u32 attr_size;
+
 		evsel->core.idx = i;
 
 		/*
@@ -2200,6 +2222,32 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (__do_read(ff, buf, sz))
 			goto error;
 
+		/* Reject before attr_swap to prevent OOB via bswap_safe() */
+		attr_size = ff->ph->needs_swap ? bswap_32(attr->size) : attr->size;
+		/* ABI0: size == 0 means the producer didn't set it */
+		if (!attr_size) {
+			attr_size = PERF_ATTR_SIZE_VER0;
+			/*
+			 * Write back so free_event_desc() doesn't
+			 * treat this event as the end-of-array sentinel
+			 * (it iterates while attr.size != 0).
+			 *
+			 * Only for native — the swap path must NOT
+			 * write native-endian VER0 here because
+			 * perf_event__attr_swap() would re-swap it
+			 * to 0x40000000, defeating bswap_safe() bounds.
+			 * perf_event__attr_swap() has its own ABI0
+			 * fallback that sets VER0 after swapping.
+			 */
+			if (!ff->ph->needs_swap)
+				attr->size = attr_size;
+		}
+		if (attr_size < PERF_ATTR_SIZE_VER0 || attr_size > sz) {
+			pr_err("Event %d attr.size (%u) invalid (min: %d, max: %u)\n",
+			       i, attr_size, PERF_ATTR_SIZE_VER0, sz);
+			goto error;
+		}
+
 		if (ff->ph->needs_swap)
 			perf_event__attr_swap(buf);
 
@@ -2221,6 +2269,12 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!nr)
 			continue;
 
+		/* Prevent oversized allocation from crafted nr */
+		if (nr > (ff->size - ff->offset) / sizeof(*id)) {
+			pr_err("Event %d: id count %u exceeds remaining section\n", i, nr);
+			goto error;
+		}
+
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
-- 
2.54.0

