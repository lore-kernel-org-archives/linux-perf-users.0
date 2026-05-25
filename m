Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99089239085;
	Mon, 25 May 2026 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671219; cv=none; b=kp01d24UXzqhj13FitHSA0RTAz51y3xlY2LhdYRN+eisLRh44pz5Ly/QBjqaXZ0EMJQfT93ImcCSy9BJlz71O+dYqrj9KODhw95ktYRcrn8fzPyGZZCCRSrlECog04mhjDE5iQDbyxUW2hZQfgx34gaRbCF9CITXSwF1zqPZVkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671219; c=relaxed/simple;
	bh=lV3o7wSqt6gf7qo3X4B75PPG9EyW2b4n3mNAXZLNqiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9DGi8XO7JXy3gHaAqGhXGGysRQwrkolM5PeM8WRVriP3Do/CBxCxQd1Ktag1wGkzOKcSpMAbOQuvVrToDNYtO+umfWO+sPwqnSYv34/IWy/rubGCU3EtDkyqpQjv01Nzdv3wuJUj4hxCENnJ7QHNOQwEDWvZZnzqlvnvTNtouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nihGZtdE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nihGZtdE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F10A1F000E9;
	Mon, 25 May 2026 01:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671218;
	bh=0jd9gLHDEow7WRRukiyWGgglP3tX3lCGhXqiW8lqeyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nihGZtdEDgrWX7UkpMG3fCfRZcsSibNRz9QFAoP9N7T/uaZQuGiRQev7hofG0nebq
	 ESEzxYkh8oZVjHpyhG8S98q0qInm8ZqZk7x/fXaRqRggy0dGxntIo3AUoBau0TtuVN
	 t63XlLyXziXAHgDL9PWJOGa8SKYnhJAic/ALE6HOsjhaQKvm+jMd7pAUF27RPq7s/g
	 koZPsLGS9/Ndr161pcT9UIzta02GpcofpST5dKZWuEpkX8EPHZQMioBYRl2UgangUS
	 ZUIOqGDyjs8qHTTblddN+7A8OKTNAZlf018pt8DCABVmlRlh3JRIA+SPXMlFz43qyA
	 DGzKwN1RrK6Ig==
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
	Blake Jones <blakejones@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 15/29] perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA events
Date: Sun, 24 May 2026 22:05:35 -0300
Message-ID: <20260525010550.1100375-16-acme@kernel.org>
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

PERF_RECORD_BPF_METADATA has no entry in perf_event__swap_ops[], so its
nr_entries field is never byte-swapped when reading a cross-endian
perf.data file.  Downstream processing in
perf_event__fprintf_bpf_metadata() loops over nr_entries, so a
foreign-endian value causes out-of-bounds reads.

Add a swap handler that byte-swaps nr_entries after validating that
header.size is large enough.  The entries[] array contains only char
arrays (key/value strings), so no per-entry swap is needed — but ensure
NUL-termination on the writable cross-endian path.

Validate header.size, nr_entries, and string NUL-termination in the
common event delivery path so that native-endian files with malicious
values are also rejected.  Snapshot nr_entries via READ_ONCE() before
validation — the event is on a MAP_SHARED mmap that could theoretically
change between the bounds check and the loop.

Changes in v2:
- Snapshot event->header.size via READ_ONCE() into a local variable
  to prevent a double-fetch underflow in the max_entries calculation
  (Reported-by: sashiko-bot@kernel.org)
- Write back clamped nr_entries to the event on the swap path,
  consistent with NAMESPACES and STAT_CONFIG handlers — without
  writeback the native path sees the inflated nr and skips the
  event entirely (Reported-by: sashiko-bot@kernel.org)

Fixes: ab38e84ba9a8 ("perf record: collect BPF metadata from existing BPF programs")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Blake Jones <blakejones@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 89 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 092fccbea8f8017e..95eb793026de6d8d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -961,6 +961,48 @@ static int perf_event__time_conv_swap(union perf_event *event,
 	return 0;
 }
 
+static int perf_event__bpf_metadata_swap(union perf_event *event,
+					 bool sample_id_all __maybe_unused)
+{
+	u64 i, nr, max_nr;
+
+	/* Fixed header must fit before accessing nr_entries or prog_name */
+	if (event->header.size < sizeof(event->bpf_metadata))
+		return -1;
+
+	event->bpf_metadata.nr_entries = bswap_64(event->bpf_metadata.nr_entries);
+
+	/*
+	 * Ensure NUL-termination on the cross-endian path where the
+	 * mapping is writable (MAP_PRIVATE + PROT_WRITE).  Fixing
+	 * the string in place is preferred over rejecting because it
+	 * preserves the event for downstream processing — only the
+	 * last byte is lost.
+	 *
+	 * The native-endian path (MAP_SHARED + PROT_READ) cannot
+	 * write, so it validates and skips unterminated events in
+	 * perf_session__process_user_event() instead.  The two
+	 * strategies produce different outcomes for the same
+	 * malformed input (fix vs skip), which is inherent in the
+	 * writable-vs-read-only mapping model.
+	 */
+	event->bpf_metadata.prog_name[BPF_PROG_NAME_LEN - 1] = '\0';
+
+	nr = event->bpf_metadata.nr_entries;
+	max_nr = (event->header.size - sizeof(event->bpf_metadata)) /
+		 sizeof(event->bpf_metadata.entries[0]);
+	if (nr > max_nr) {
+		/* Persist clamped value so the native path processes entries, not skips */
+		nr = max_nr;
+		event->bpf_metadata.nr_entries = nr;
+	}
+
+	for (i = 0; i < nr; i++) {
+		event->bpf_metadata.entries[i].key[BPF_METADATA_KEY_LEN - 1] = '\0';
+		event->bpf_metadata.entries[i].value[BPF_METADATA_VALUE_LEN - 1] = '\0';
+	}
+	return 0;
+}
 static int
 perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
 			       bool sample_id_all __maybe_unused)
@@ -1060,6 +1102,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
@@ -2203,9 +2246,53 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_FINISHED_INIT:
 		err = tool->finished_init(tool, session, event);
 		break;
-	case PERF_RECORD_BPF_METADATA:
+	case PERF_RECORD_BPF_METADATA: {
+		u64 nr_entries, max_entries;
+		u32 hdr_size = READ_ONCE(event->header.size);
+
+		if (hdr_size < sizeof(event->bpf_metadata)) {
+			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
+				   hdr_size);
+			err = 0;
+			break;
+		}
+
+		/*
+		 * Native-endian files are mmap'd read-only — validate
+		 * NUL-termination instead of writing.
+		 */
+		if (strnlen(event->bpf_metadata.prog_name,
+			    BPF_PROG_NAME_LEN) == BPF_PROG_NAME_LEN) {
+			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: prog_name not null-terminated, skipping\n");
+			err = 0;
+			break;
+		}
+
+		/* Snapshot — event is mmap'd and could change between reads */
+		nr_entries = READ_ONCE(event->bpf_metadata.nr_entries);
+		max_entries = (hdr_size - sizeof(event->bpf_metadata)) /
+			      sizeof(event->bpf_metadata.entries[0]);
+		if (nr_entries > max_entries) {
+			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
+				   nr_entries, max_entries);
+			err = 0;
+			break;
+		}
+
+		for (u64 i = 0; i < nr_entries; i++) {
+			if (strnlen(event->bpf_metadata.entries[i].key,
+				    BPF_METADATA_KEY_LEN) == BPF_METADATA_KEY_LEN ||
+			    strnlen(event->bpf_metadata.entries[i].value,
+				    BPF_METADATA_VALUE_LEN) == BPF_METADATA_VALUE_LEN) {
+				pr_warning("WARNING: PERF_RECORD_BPF_METADATA: entry %" PRIu64 " key/value not null-terminated, skipping\n", i);
+				err = 0;
+				goto out;
+			}
+		}
+
 		err = tool->bpf_metadata(tool, session, event);
 		break;
+	}
 	case PERF_RECORD_SCHEDSTAT_CPU:
 		err = tool->schedstat_cpu(tool, session, event);
 		break;
-- 
2.54.0

