Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AC2EAD15;
	Sun, 24 May 2026 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593410; cv=none; b=PXg1oLJAk5oAnmYYOUil/R67Y9Jcf+lZX6AYC0xM/biXbJX2G0OjovQcwEvtheBJmrJF+jqTslbLkwcwJ4UDLndvJ2N+MXE257YW833PdefQWXpHcE1fXVfeHnjwFI+vYRc6sZAS/a7rK2j4kjuI/kNNIogy7BDwhRFE7nUfhHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593410; c=relaxed/simple;
	bh=rItqzPRmU/xpdnzE1C+afQ03SmxQhgVJ8cYeVfUwWbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+EfANCQK+bNxOC6tq9EUC8YLWvpgo0/NrXbAyhBIV1Ly5H+ppyGm4NKNWTjV9ogNNvQfxuPqnMzM/WegpT9RuKiA2obmONuPggtVIPX8IWOwNdKsIZCaRRfWNYxPntWdijBbzRkg9fmV633JXKuaFpYzNGOkWA/aa4iRyv8c2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjoHgdBC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjoHgdBC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9131F000E9;
	Sun, 24 May 2026 03:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593408;
	bh=uyloJ5CWvDknpgDaWeB4NA7R1vMC1TxnHV6llApw15E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjoHgdBC5sRIyz7lj4EJYCdGla0za7scoev3PgKtixx2ZVyr5OHyv3Zg8QSpRZunO
	 b6343uI/l95H0EHWn1owiEmdtX21k1PB4+V3nk7IPTAcA4IUqACzvlPwQolzhZ9j+W
	 GcA9a3hMrADgz5PT514exsm0ZccNp4Q0K+K07DhyzqqgfhiVae0BpkazRlmkym/D6y
	 GANCwvV2pWva/9tgm7mHn5qtH+Xl2irvptYPbq35wZ+0ODo+8SWdEUvD4pcn4tixNF
	 AE+fRK4XOJk1W3AiO7JmxcKobP4bMYNScVvsGqOA/YxLjEr0FiN8M/kG3FugbkBkWN
	 Rv0zILGgnlwsA==
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
Subject: [PATCH 28/29] perf session: Snapshot event->header.size in process_user_event()
Date: Sun, 24 May 2026 00:27:02 -0300
Message-ID: <20260524032709.1080771-29-acme@kernel.org>
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

On native-endian files, events are read from MAP_SHARED memory.
Multiple reads of event->header.size can return different values
if the file is concurrently modified, allowing an attacker to
bypass bounds checks performed on an earlier read.

Snapshot header.size into a local variable at function entry using
READ_ONCE() to prevent compiler rematerialization, and use it for
all size-dependent arithmetic within the function.  This ensures
every bounds calculation uses the same value that was validated
by the reader.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 69eb404f805d87d1..d62cb21920e042f5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2219,6 +2219,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 {
 	struct ordered_events *oe = &session->ordered_events;
 	const struct perf_tool *tool = session->tool;
+	const u32 event_size = READ_ONCE(event->header.size);
 	struct perf_sample sample;
 	int fd = perf_data__fd(session->data);
 	s64 err;
@@ -2260,7 +2261,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		break;
 	case PERF_RECORD_HEADER_BUILD_ID:
 		if (!perf_event__check_nul(event->build_id.filename,
-					   (void *)event + event->header.size,
+					   (void *)event + event_size,
 					   "HEADER_BUILD_ID")) {
 			err = 0;
 			break;
@@ -2283,7 +2284,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 * place already.
 		 */
 		if (!perf_data__is_pipe(session->data))
-			lseek(fd, file_offset + event->header.size, SEEK_SET);
+			lseek(fd, file_offset + event_size, SEEK_SET);
 		err = tool->auxtrace(tool, session, event);
 		break;
 	case PERF_RECORD_AUXTRACE_ERROR:
@@ -2293,14 +2294,14 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_THREAD_MAP: {
 		u64 max_nr;
 
-		if (event->header.size < sizeof(event->thread_map)) {
+		if (event_size < sizeof(event->thread_map)) {
 			pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
-			       event->header.size);
+			       event_size);
 			err = -EINVAL;
 			break;
 		}
 
-		max_nr = (event->header.size - sizeof(event->thread_map)) /
+		max_nr = (event_size - sizeof(event->thread_map)) /
 			 sizeof(event->thread_map.entries[0]);
 		if (event->thread_map.nr > max_nr) {
 			pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 "\n",
@@ -2314,7 +2315,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	}
 	case PERF_RECORD_CPU_MAP: {
 		struct perf_record_cpu_map_data *data = &event->cpu_map.data;
-		u32 payload = event->header.size - sizeof(event->header);
+		u32 payload = event_size - sizeof(event->header);
 
 		/*
 		 * Native-endian events are mmap'd read-only, so we
@@ -2378,8 +2379,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		break;
 	}
 	case PERF_RECORD_STAT_CONFIG: {
-		/* Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof */
-		u64 max_nr = (event->header.size - sizeof(event->stat_config)) /
+		/* Cannot underflow: perf_event__min_size[] guarantees event_size >= sizeof */
+		u64 max_nr = (event_size - sizeof(event->stat_config)) /
 			     sizeof(event->stat_config.data[0]);
 
 		/*
@@ -2410,7 +2411,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		 */
 		memset(&session->time_conv, 0, sizeof(session->time_conv));
 		memcpy(&session->time_conv, &event->time_conv,
-		       min((size_t)event->header.size, sizeof(session->time_conv)));
+		       min((size_t)event_size, sizeof(session->time_conv)));
 		err = tool->time_conv(tool, session, event);
 		break;
 	case PERF_RECORD_HEADER_FEATURE:
@@ -2427,11 +2428,10 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		break;
 	case PERF_RECORD_BPF_METADATA: {
 		u64 nr_entries, max_entries;
-		u32 hdr_size = READ_ONCE(event->header.size);
 
-		if (hdr_size < sizeof(event->bpf_metadata)) {
+		if (event_size < sizeof(event->bpf_metadata)) {
 			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
-				   hdr_size);
+				   event_size);
 			err = 0;
 			break;
 		}
@@ -2447,9 +2447,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 			break;
 		}
 
-		/* Snapshot — event is mmap'd and could change between reads */
 		nr_entries = READ_ONCE(event->bpf_metadata.nr_entries);
-		max_entries = (hdr_size - sizeof(event->bpf_metadata)) /
+		max_entries = (event_size - sizeof(event->bpf_metadata)) /
 			      sizeof(event->bpf_metadata.entries[0]);
 		if (nr_entries > max_entries) {
 			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
-- 
2.54.0

