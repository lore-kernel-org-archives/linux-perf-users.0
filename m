Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263E3B47FF;
	Tue, 26 May 2026 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830332; cv=none; b=BT5PymIbdxmqTi9ffAFpvk6pAEdFIzFwkE5uRd9utodUElfv9yhx0fdvnO+rz/DbHtFrbx9BLnpIDBNFJgQd0r3bNyYtZeX+uX+BojHxBUammFixqZ8cBWIMn1UKodoT9ve5Q23MiV8drNFYbsP4aRaHqi4SDEvce2EpIpT+FQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830332; c=relaxed/simple;
	bh=eiVYkRqohCAAgwJ1x4LdrDqpvvrJJ2X8doypd8lLppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8fVjWkuSc+oY8zLJKZ4YoQEz7V9Aj2MtpfZBcJ8OxAY6Qw0K49Bs/3SO1i1r2wVs3MDVl3eopM9zS6i7BY+AZkl6jYRBkpClyMDoJm1LjmWbRHw7tkPBA1q7WhGzf0b5MWTnajjmnEYg6yEklHmaY5oWsmpQlQ5dJDs6v+bEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6MJLhqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6MJLhqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2C21F000E9;
	Tue, 26 May 2026 21:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830331;
	bh=2zHJwBEeIA/Pf+33FPHv0njK7SPUFwC+poNQl/qO5lQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A6MJLhqga8730WKeAm4LillYknaE8HjCmyYqPYhJWM+KHFdevGkAP/mhFdogmlBj8
	 CHdqC6F+vCSpAxb1EknsYlmahvMZ00o7veB3mQy43tXI6pziR23Xj/x5U/6DfGQkfx
	 Fap9GCRgIVAyCMhhyETu2ip4Bx1Y5FL5+5Y7NI0eloYDB7rBB6L9I0k2daOdecrqGC
	 46vE4l4rO2qh/Ri3CsTB5SAs/PoNZkKkcE9O9nysoBNvSS4Zxn/2FO9Y4GGSJbpO/F
	 gFhomYOuhvXaAhKpXDmTohU67K56PS48Hc7O9aN/XcGnYwSBFjMJL0KyXDHJaEWfpm
	 U7qMsrNYEwwZA==
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
Subject: [PATCH 10/29] perf session: Validate HEADER_ATTR attr.size before swapping
Date: Tue, 26 May 2026 18:17:46 -0300
Message-ID: <20260526211806.1193848-11-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Harden PERF_RECORD_HEADER_ATTR handling against crafted perf.data:

- Validate attr.size: must be >= PERF_ATTR_SIZE_VER0, a multiple
  of sizeof(u64), and fit within the event payload.
- Copy only min(attr.size, sizeof(struct perf_event_attr)) bytes
  into a local attr, zeroing the rest so legacy files don't leak
  adjacent event data into new fields.
- Keep the original attr.size so perf_event__synthesize_attr()
  uses it for both allocation and ID-array placement.

Fix perf_event__synthesize_attr() to use attr->size (not the
compiled sizeof) for event allocation and layout, so perf inject
correctly re-synthesizes attrs from files recorded by a different
perf version.  Without this, the ID array destination pointer
(computed via perf_record_header_attr_id()) would be inconsistent
with the allocation when attr->size differs from sizeof.

Also fix the parse-no-sample-id-all test to set attr.size, which
is now validated, and improve error handling in read_attr() for
short reads and invalid attr sizes.

Handle ABI0 pipe/inject events where attr.size is 0: use a local
attr_size variable set to PERF_ATTR_SIZE_VER0 for both the bounded
copy and ID array position, instead of writing back to the event.
Native-endian files may be MAP_SHARED (read-only mmap), so writing
to the event buffer would SIGSEGV.  The swap path handles ABI0 in
perf_event__attr_swap() which writes to the MAP_PRIVATE copy.

header.size alignment is now validated centrally in
perf_session__process_event() (see "Add minimum event size and
alignment validation").

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c               | 23 ++++--
 tools/perf/tests/parse-no-sample-id-all.c |  6 ++
 tools/perf/util/header.c                  | 96 +++++++++++++++++++++--
 tools/perf/util/session.c                 | 31 ++++++++
 tools/perf/util/synthetic-events.c        | 25 +++++-
 5 files changed, 166 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 41a3721a194dc9b9..d8cb1f562f690ce4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -229,6 +229,7 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 	struct perf_event_attr attr;
+	u32 raw_attr_size, attr_size;
 	size_t n_ids;
 	u64 *ids;
 	int ret;
@@ -244,24 +245,34 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (!inject->itrace_synth_opts.set)
 		return perf_event__repipe_synth(tool, event);
 
-	if (event->header.size < sizeof(struct perf_event_header) + sizeof(u64)) {
+	if (event->header.size < sizeof(struct perf_event_header) + PERF_ATTR_SIZE_VER0) {
 		pr_err("Attribute event size %u is too small\n", event->header.size);
 		return -EINVAL;
 	}
 
-	if (event->header.size - sizeof(event->header) < event->attr.attr.size) {
+	/*
+	 * ABI0 pipe/inject events have attr.size == 0; default to
+	 * PERF_ATTR_SIZE_VER0 (the ABI0 footprint) for the bounded
+	 * copy and ID array position.  Same pattern as
+	 * perf_event__process_attr() in header.c.
+	 */
+	raw_attr_size = event->attr.attr.size;
+	attr_size = raw_attr_size ?: PERF_ATTR_SIZE_VER0;
+
+	if (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
+			      raw_attr_size > event->header.size - sizeof(event->header))) {
 		pr_err("Attribute event size %u is too small for attr.size %u\n",
-		       event->header.size, event->attr.attr.size);
+		       event->header.size, raw_attr_size);
 		return -EINVAL;
 	}
 
 	memset(&attr, 0, sizeof(attr));
 	memcpy(&attr, &event->attr.attr,
-	       min_t(size_t, sizeof(attr), (size_t)event->attr.attr.size));
+	       min_t(size_t, sizeof(attr), attr_size));
 
-	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids = event->header.size - sizeof(event->header) - attr_size;
 	n_ids /= sizeof(u64);
-	ids = perf_record_header_attr_id(event);
+	ids = (void *)&event->attr.attr + attr_size;
 
 	attr.size = sizeof(struct perf_event_attr);
 	attr.sample_type &= ~PERF_SAMPLE_AUX;
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index 50e68b7d43aad030..8ac862c94879f3a3 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -82,6 +82,9 @@ static int test__parse_no_sample_id_all(struct test_suite *test __maybe_unused,
 			.type = PERF_RECORD_HEADER_ATTR,
 			.size = sizeof(struct test_attr_event),
 		},
+		.attr = {
+			.size = sizeof(struct perf_event_attr),
+		},
 		.id = 1,
 	};
 	struct test_attr_event event2 = {
@@ -89,6 +92,9 @@ static int test__parse_no_sample_id_all(struct test_suite *test __maybe_unused,
 			.type = PERF_RECORD_HEADER_ATTR,
 			.size = sizeof(struct test_attr_event),
 		},
+		.attr = {
+			.size = sizeof(struct perf_event_attr),
+		},
 		.id = 2,
 	};
 	struct perf_record_mmap event3 = {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc32da2..967c3d8ff12c8676 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4770,9 +4770,15 @@ static int read_attr(int fd, struct perf_header *ph,
 	if (sz == 0) {
 		/* assume ABI0 */
 		sz =  PERF_ATTR_SIZE_VER0;
+	} else if (sz < PERF_ATTR_SIZE_VER0) {
+		pr_debug("bad attr size %zu, expected at least %d\n",
+			 sz, PERF_ATTR_SIZE_VER0);
+		errno = EINVAL;
+		return -1;
 	} else if (sz > our_sz) {
 		pr_debug("file uses a more recent and unsupported ABI"
 			 " (%zu bytes extra)\n", sz - our_sz);
+		errno = EINVAL;
 		return -1;
 	}
 	/* what we have not yet read and that we know about */
@@ -4782,11 +4788,21 @@ static int read_attr(int fd, struct perf_header *ph,
 		ptr += PERF_ATTR_SIZE_VER0;
 
 		ret = readn(fd, ptr, left);
+		if (ret <= 0) {
+			if (ret == 0)
+				errno = EIO;
+			return -1;
+		}
 	}
 	/* read perf_file_section, ids are read in caller */
 	ret = readn(fd, &f_attr->ids, sizeof(f_attr->ids));
+	if (ret <= 0) {
+		if (ret == 0)
+			errno = EIO;
+		return -1;
+	}
 
-	return ret <= 0 ? -1 : 0;
+	return 0;
 }
 
 #ifdef HAVE_LIBTRACEEVENT
@@ -5094,11 +5110,42 @@ int perf_event__process_attr(const struct perf_tool *tool __maybe_unused,
 			     union perf_event *event,
 			     struct evlist **pevlist)
 {
-	u32 i, n_ids;
+	struct perf_event_attr attr;
+	u32 i, n_ids, raw_attr_size;
 	u64 *ids;
+	size_t attr_size, copy_size;
 	struct evsel *evsel;
 	struct evlist *evlist = *pevlist;
 
+	/*
+	 * HEADER_ATTR event layout (pipe/inject mode):
+	 *
+	 *   [header (8 bytes)] [attr (attr_size bytes)] [id0 id1 ... idN]
+	 *   |<------------------ header.size --------------------------->|
+	 *
+	 * attr_size varies across perf versions: VER0 = 64 bytes,
+	 * current sizeof(struct perf_event_attr) = larger.  A newer
+	 * producer may emit a larger attr than we understand.
+	 *
+	 * attr.size == 0 (ABI0) means the producer didn't set it
+	 * (e.g., bench/inject-buildid, older perf).  Treat as VER0.
+	 *
+	 * Require 8-byte alignment so the u64 ID array is aligned
+	 * and attr.size fits cleanly within the payload.
+	 *
+	 * Read attr.size once — the event may be on a shared mmap
+	 * and re-reading could yield a different value.
+	 */
+	raw_attr_size = event->attr.attr.size;
+	if (event->header.size < sizeof(event->header) + PERF_ATTR_SIZE_VER0 ||
+	    (raw_attr_size && (raw_attr_size < PERF_ATTR_SIZE_VER0 ||
+			      raw_attr_size % sizeof(u64) ||
+			      raw_attr_size > event->header.size - sizeof(event->header)))) {
+		pr_err("PERF_RECORD_HEADER_ATTR: invalid attr.size %u (event size %u, min %d)\n",
+		       raw_attr_size, event->header.size, PERF_ATTR_SIZE_VER0);
+		return -EINVAL;
+	}
+
 	if (dump_trace)
 		perf_event__fprintf_attr(event, stdout);
 
@@ -5108,13 +5155,46 @@ int perf_event__process_attr(const struct perf_tool *tool __maybe_unused,
 			return -ENOMEM;
 	}
 
-	evsel = evsel__new(&event->attr.attr);
+	/*
+	 * attr_size = footprint of the attr in the event — determines
+	 * where the ID array starts.  For ABI0, assume VER0 (64 bytes).
+	 *
+	 * copy_size = how much we copy into our local struct, capped at
+	 * sizeof(attr) so a newer producer's larger attr doesn't
+	 * overflow.  Fields beyond copy_size are zeroed.
+	 *
+	 * Do NOT write attr_size back to the event — native-endian
+	 * files use MAP_SHARED (read-only), writing would SIGSEGV.
+	 * The swap path handles ABI0 in perf_event__attr_swap()
+	 * which writes to the writable MAP_PRIVATE copy instead.
+	 */
+	attr_size = raw_attr_size ?: PERF_ATTR_SIZE_VER0;
+	copy_size = min(attr_size, sizeof(attr));
+	memcpy(&attr, &event->attr.attr, copy_size);
+	if (copy_size < sizeof(attr))
+		memset((void *)&attr + copy_size, 0, sizeof(attr) - copy_size);
+
+	/*
+	 * Normalize ABI0: the swap path sets attr.size = VER0 on the
+	 * event, but the native path leaves it as 0.  Set it on the
+	 * local copy so perf inject re-synthesizes with consistent
+	 * layout regardless of endianness.
+	 */
+	attr.size = attr_size;
+
+	evsel = evsel__new(&attr);
 	if (evsel == NULL)
 		return -ENOMEM;
 
 	evlist__add(evlist, evsel);
 
-	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	/*
+	 * IDs occupy the remainder after header + attr.  Use attr_size
+	 * (not copy_size) — even if the producer's attr is larger than
+	 * our struct, the IDs start after attr_size bytes in the event.
+	 * Validation above guarantees attr_size <= payload size.
+	 */
+	n_ids = event->header.size - sizeof(event->header) - attr_size;
 	n_ids = n_ids / sizeof(u64);
 	/*
 	 * We don't have the cpu and thread maps on the header, so
@@ -5124,7 +5204,13 @@ int perf_event__process_attr(const struct perf_tool *tool __maybe_unused,
 	if (perf_evsel__alloc_id(&evsel->core, 1, n_ids))
 		return -ENOMEM;
 
-	ids = perf_record_header_attr_id(event);
+	/*
+	 * Locate IDs at attr_size bytes past the attr start in the
+	 * event.  Cannot use perf_record_header_attr_id() — that
+	 * macro reads event->attr.attr.size, which is 0 for ABI0
+	 * on the native-endian path (no swap handler to fix it up).
+	 */
+	ids = (void *)&event->attr.attr + attr_size;
 	for (i = 0; i < n_ids; i++) {
 		perf_evlist__id_add(&evlist->core, &evsel->core, 0, i, ids[i]);
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 3f72b80aac56b04e..aef10d42be35487a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -623,8 +623,39 @@ do { 						\
 static int perf_event__hdr_attr_swap(union perf_event *event,
 				     bool sample_id_all __maybe_unused)
 {
+	u32 attr_size, payload_size;
 	size_t size;
 
+	/*
+	 * Validate attr.size (still foreign-endian) before calling
+	 * perf_event__attr_swap(), which uses it via bswap_safe()
+	 * to decide which fields to swap.  A crafted attr.size
+	 * larger than the event payload would swap past the event
+	 * boundary and corrupt adjacent memory.
+	 *
+	 * header.size alignment is already validated by
+	 * perf_session__process_event().  The min_size table
+	 * guarantees header.size >= sizeof(header) +
+	 * PERF_ATTR_SIZE_VER0, so attr.size is safe to access.
+	 */
+	attr_size = bswap_32(event->attr.attr.size);
+	/*
+	 * ABI0: size field not set.  This only happens in pipe/inject
+	 * mode where HEADER_ATTR events carry their own attr.  For
+	 * regular perf.data files, read_attr() uses f_header.attr_size
+	 * from the file header instead.  Assume PERF_ATTR_SIZE_VER0.
+	 */
+	if (!attr_size)
+		attr_size = PERF_ATTR_SIZE_VER0;
+	payload_size = event->header.size - sizeof(event->header);
+
+	if (attr_size < PERF_ATTR_SIZE_VER0 || attr_size % sizeof(u64) ||
+	    attr_size > payload_size) {
+		pr_err("PERF_RECORD_HEADER_ATTR: invalid attr.size %u (min: %d, max: %u, 8-byte aligned)\n",
+		       attr_size, PERF_ATTR_SIZE_VER0, payload_size);
+		return -1;
+	}
+
 	perf_event__attr_swap(&event->attr.attr);
 
 	size = event->header.size;
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index d665b0f94b321433..5307d707711d876c 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -2181,11 +2181,21 @@ int perf_event__synthesize_attr(const struct perf_tool *tool, struct perf_event_
 				u32 ids, u64 *id, perf_event__handler_t process)
 {
 	union perf_event *ev;
-	size_t size;
+	size_t attr_size, size;
 	int err;
 
-	size = sizeof(struct perf_event_attr);
-	size = PERF_ALIGN(size, sizeof(u64));
+	/*
+	 * Use attr->size for the event layout, not the compiled
+	 * sizeof(struct perf_event_attr), so that synthesized events
+	 * match the source perf.data layout.  This matters for perf
+	 * inject, which re-synthesizes attrs from a file that may
+	 * have been recorded by a different version of perf.
+	 * perf_record_header_attr_id() locates the ID array at
+	 * attr->size bytes past the attr.
+	 */
+	attr_size = attr->size ?: sizeof(struct perf_event_attr);
+
+	size = PERF_ALIGN(attr_size, sizeof(u64));
 	size += sizeof(struct perf_event_header);
 	size += ids * sizeof(u64);
 
@@ -2194,7 +2204,14 @@ int perf_event__synthesize_attr(const struct perf_tool *tool, struct perf_event_
 	if (ev == NULL)
 		return -ENOMEM;
 
-	ev->attr.attr = *attr;
+	/*
+	 * Copy only the bytes we understand; zalloc ensures that any
+	 * extra bytes between sizeof(struct perf_event_attr) and
+	 * attr_size are zero when the source file uses a newer, larger
+	 * struct.
+	 */
+	memcpy(&ev->attr.attr, attr, min(sizeof(struct perf_event_attr), attr_size));
+	ev->attr.attr.size = attr_size;
 	memcpy(perf_record_header_attr_id(ev), id, ids * sizeof(u64));
 
 	ev->attr.header.type = PERF_RECORD_HEADER_ATTR;
-- 
2.54.0

