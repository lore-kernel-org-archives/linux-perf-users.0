Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C72F8BC3;
	Sun, 24 May 2026 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593370; cv=none; b=rR/0jJB6v4EvpiL1M+5L7QVLOyj2I0hzQB+IZp8dLYTUNJBdpMk0txKxaukCDgzL4YSLCk9qH1J2Es8lja1tHO/jUpas5GhoMWAHjcjq/VZXLdXfvqY/RBPA4u/f2DEscrPz3Hfxhq0f3stk1RwVbtjEDQuo8AdG1fFq0798NGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593370; c=relaxed/simple;
	bh=2tspnYnFV2/mcTNat8MjyF0yJMZPMqCkwJiD0xzu5Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rKQXEH7M6akdk/sy3octxnnezXUYTkDt7cea5Q0u+2+BTtcBzVmVH6t3z5rLllXOCv3IsIn7c0JZK1GzKF03nxpGmLVjfRY7xVk6VvjTTWjasbmZ/+3aI4ZdBBXBThcES73vSZJRh4YGNNW5wACCx91Ax/AejVC3ksjQWICIBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXsT9IuG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXsT9IuG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C811F00A3A;
	Sun, 24 May 2026 03:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593368;
	bh=mVc8jbO9aj9r6TWlD3OrE7dSxeoBoQfzzEhSx+Srlww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EXsT9IuGkUEgDYzMQUE2+si3zuLsWziSAwCg9YhSwkLyWUTBLkvEMNjPWgCVG3Yzs
	 is46wD+91E8W4Dk80r4jLe/juImbrKFsqQU2sIpgg3yVAeteHqjgXB9zB49qtNSPAb
	 8pw78FFmMCadg3lXqzH0IXi541umiGaYbqWyaQn9tJ9/i2WMOrqUSpdJYIoHdkqbaM
	 TmMwJVZU74G0WDujITRkuumMubJX2DKR0m4eVRC6CUBRZSzaFwnjJnGihfp9R1t4f3
	 tYBjgfpaBdBr7x+mLKbSm6JhlsPLs/1Yh/eyp2WMfwSw+Wrq4XoWSYtdXPJWha9cdn
	 mEn948iBvtvEQ==
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
Subject: [PATCH 21/29] perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
Date: Sun, 24 May 2026 00:26:55 -0300
Message-ID: <20260524032709.1080771-22-acme@kernel.org>
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
index 90417a478c8db2e1..37d7c9849e0e9199 100644
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

