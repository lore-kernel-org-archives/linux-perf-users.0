Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C6282F29;
	Sun, 10 May 2026 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384189; cv=none; b=hs7kPdhk5BTlfqNMSTxoUb9feeIT3kklPk9FEcxroorrKJ0laNHdoxUhJoOJt0+gBwesvxSbr+py2qommNnVgQMQ19sir7QpgBxlVhQkNnndjFVEh9xVFlHxx/uIzV+XaIgESoGLlAdy9NXfWmwZYca1icDaNb9JSk175Y+gSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384189; c=relaxed/simple;
	bh=Uo4Aj5hoW5Le1FOXzlcX4O+kIwQ370Wtq6/SPTihl34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u255jwqaHGU+q7w5zA6jRHdphUccue6LSJy4bwrZbDxG+Q+Y2iO/mIlI/VK+MiaGW25es4C3FhkTk9E9UK4KlyAGjHI8pRQcJiBhzqtaSuuVcgbgR7g2CnGZ1TJAVPtkFbbDu2ll6Xi/tYb3q/MGmVJJOAr1Mu3wb1jLLjGmw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7l9hfj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7l9hfj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D0CC2BCB8;
	Sun, 10 May 2026 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384189;
	bh=Uo4Aj5hoW5Le1FOXzlcX4O+kIwQ370Wtq6/SPTihl34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O7l9hfj7Dp14b8jc6MInjVvey1O+Z883IU0uWN6O0o4Xpfov/9NE0IKPkvqv04l9+
	 R5lhDK6ywGW3l1QRCd6MIj2A75x2kmhnpnyrzH4RAeQA8q+s82hCDQAMYx/rnjmNg8
	 C5VpUaGyUEmcSdPglXA/oAWgqI6dU5KTAKE5g6ti0b91ins8mC26Vux63xo+48lsGH
	 U9BjbU1L0HBAhn9PM+wVAxhL+XqaZIsRif7eZm22d26u2EGk5+z4CVdxcgFUd8xazi
	 HG89K6Q6PdGBCQii/yhTTxoyumvHCxIffHzKw07e8JwCMePbsG/iUP7Rfxsw8F2jnQ
	 UiM5pqYh1obvA==
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
	Wang Nan <wangnan0@huawei.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 20/28] perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
Date: Sun, 10 May 2026 00:34:11 -0300
Message-ID: <20260510033424.255812-21-acme@kernel.org>
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
- Reject attr->size > sz before calling perf_event__attr_swap()
  to prevent heap out-of-bounds access.
- Check that nr IDs fit in the remaining section before allocating.

Fixes: b30b61729246 ("perf tools: Fix a problem when opening old perf.data with different byte order")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 50 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a8655a784eaa5ba9..0bbe90865e9c1ceb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2170,9 +2170,25 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
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
+	    nre > (ff->size - ff->offset) / (sz + sizeof(u32)))
+		goto error;
+
 	/* buffer to hold on file attr struct */
 	buf = malloc(sz);
 	if (!buf)
@@ -2188,6 +2204,9 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		msz = sz;
 
 	for (i = 0, evsel = events; i < nre; evsel++, i++) {
+		struct perf_event_attr *attr = buf;
+		u32 attr_size;
+
 		evsel->core.idx = i;
 
 		/*
@@ -2197,6 +2216,32 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
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
 
@@ -2218,6 +2263,10 @@ static struct evsel *read_event_desc(struct feat_fd *ff)
 		if (!nr)
 			continue;
 
+		/* Prevent oversized allocation from crafted nr */
+		if (nr > (ff->size - ff->offset) / sizeof(*id))
+			goto error;
+
 		id = calloc(nr, sizeof(*id));
 		if (!id)
 			goto error;
@@ -4995,7 +5044,6 @@ int perf_session__read_header(struct perf_session *session)
 	}
 
 	err = -ENOMEM;
-
 	if (perf_file_header__read(&f_header, header, fd) < 0)
 		return -EINVAL;
 
-- 
2.54.0

