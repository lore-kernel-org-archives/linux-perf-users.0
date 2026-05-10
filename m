Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAD19CD0A;
	Sun, 10 May 2026 03:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384152; cv=none; b=SJHNmW9VYBb2QhAaln3MNwELoYZ7rPZHi/UtTxPvE2DNmhi2BXDipIqZHCpVuQhoNGbS/9+Js7alUNKDJhkiSHo9PeRr2uORz50rILkN8wL5l/YxnxG1Ao8CTHQQTAaJVBLyXknlRtz5TpT8supPWHw/vJd3Uou1ZQFTSsj2otw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384152; c=relaxed/simple;
	bh=t02wNdgSfNbf5loBv1JRfR4V7UwPBFip15dJG7QRtUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYCSquVtnZHSRlj7d9VmJ2iKqUTTRG3UPXyn6jKKWMlvZYbf+oSPfpymiMVRoabLjE88lB5ue9hUpZXsVjeP9QDwO1uPEbBDYb0398rAJ3kgyug0wrrlJiiipihJGHq5tOh/U8+upcyFlMDtPub9qE4iBz8X/KiOf5XBLQuvV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXcSSEAV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXcSSEAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDACFC2BCFB;
	Sun, 10 May 2026 03:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384152;
	bh=t02wNdgSfNbf5loBv1JRfR4V7UwPBFip15dJG7QRtUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XXcSSEAVcmaaAsfuA1O9XMbc2uzoxQ2wWweOkOdLV3Aah07QQexEBO1wSl+OyVhQm
	 EEvvThEtYErvBDH7BWMauOdTeTXP8d9IWXHiOWKNdBlVF5hMKtscP3qNj2+FMGra+V
	 0u4y7WExEgiJjuHWNi1G2fHCzWjUKn+UrXW4aWlJ0Gn/9cZGTOtKRQ7X63BOQW1axW
	 mvBMrUyI5Rpc4IdLER9RlNqlWROKLZe7JYaHS6lM43E5A3WDZ3sE/1I6bJ6AR1+sqc
	 J271q+JailLCn3SKL3oC18V/eT3dQTTBu9sWMdLYdHsoi3oDDFAp95W2PZnM0TTBxq
	 MoUCgt78a0Ypg==
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
	Blake Jones <blakejones@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 14/28] perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA events
Date: Sun, 10 May 2026 00:34:05 -0300
Message-ID: <20260510033424.255812-15-acme@kernel.org>
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

PERF_RECORD_BPF_METADATA has no entry in perf_event__swap_ops[],
so its nr_entries field is never byte-swapped when reading a
cross-endian perf.data file.  Downstream processing in
perf_event__fprintf_bpf_metadata() loops over nr_entries, so a
foreign-endian value causes out-of-bounds reads.

Add a swap handler that byte-swaps nr_entries after validating
that header.size is large enough.  The entries[] array contains
only char arrays (key/value strings), so no per-entry swap is
needed — but ensure NUL-termination on the writable cross-endian
path.

Validate header.size, nr_entries, and string NUL-termination in
the common event delivery path so that native-endian files with
malicious values are also rejected.

Fixes: ab38e84ba9a8 ("perf record: collect BPF metadata from existing BPF programs")
Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Blake Jones <blakejones@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 83 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a2dba77c6a2b9d2f..876e20c4ba8a7808 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -942,6 +942,45 @@ static int perf_event__time_conv_swap(union perf_event *event,
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
+	if (nr > max_nr)
+		nr = max_nr;
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
@@ -1041,6 +1080,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
+	[PERF_RECORD_BPF_METADATA]	  = perf_event__bpf_metadata_swap,
 	[PERF_RECORD_SCHEDSTAT_CPU]	  = perf_event__schedstat_cpu_swap,
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = perf_event__schedstat_domain_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
@@ -2181,9 +2221,50 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	case PERF_RECORD_FINISHED_INIT:
 		err = tool->finished_init(tool, session, event);
 		break;
-	case PERF_RECORD_BPF_METADATA:
+	case PERF_RECORD_BPF_METADATA: {
+		u64 max_entries;
+
+		if (event->header.size < sizeof(event->bpf_metadata)) {
+			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: header.size (%u) too small, skipping\n",
+				   event->header.size);
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
+		max_entries = (event->header.size - sizeof(event->bpf_metadata)) /
+			      sizeof(event->bpf_metadata.entries[0]);
+		if (event->bpf_metadata.nr_entries > max_entries) {
+			pr_warning("WARNING: PERF_RECORD_BPF_METADATA: nr_entries %" PRIu64 " exceeds max %" PRIu64 ", skipping\n",
+				   (u64)event->bpf_metadata.nr_entries, max_entries);
+			err = 0;
+			break;
+		}
+
+		for (u64 i = 0; i < event->bpf_metadata.nr_entries; i++) {
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

