Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C62FD7B1;
	Thu, 21 May 2026 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325885; cv=none; b=JpLrimbYSv3sdRTabonaZYtWFvYG2Xig5yBpJcZnGRLNchB3Gu3A0WPCR8yG5R3wPrmLkyf9b2KIcnjX98rhbDDa1vG33h5Dynn7PJWT29e2aQnUv1Var8pH26iZTBUm4odaV9m10PgaFEbGukcsGyyXk+7CwCiGJmf3ACzk54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325885; c=relaxed/simple;
	bh=1SOJSwIX3t2JM9X64XValMipqj7cnobsY/vXuA+6gNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOvIZ81njPyXGmXDcRcQr4hlTSXu8xaxyfGUJatH5hInnlJKnTsMJBjbUiXghDpoZCJFXMimda5gwkRuoLpmn2Pvw2aptfL7bH0rj2Ea7gFee4K/WlOQLovCeAmyCnewcquO1nuZLS7UxYTdLROcQ0zjHX0V4SHhWaL8cW9yoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C51ptIin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C51ptIin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557E01F00A3B;
	Thu, 21 May 2026 01:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325883;
	bh=D6SMoKb3bqygMIT1ITAqmLnHrsjXk5ZwX0fxqPaGOT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C51ptIin7I68Sqp2nwtRC3dEJSysYrugEbdsUkUlBCI5YHLtzz9z7kQqSIcQObwGP
	 Q1J+qIDuFhCNFIn2IZ0sWEIo6DwstwYY/fdTatXsRWC0k0XrCZzqf6tK2f4Roh9PAD
	 VZoiDQL8aCTSFjOH2RQe/ThdFGwc6HRLCN/hMVc7RI/DUh5yl30rp4bCOtZA2YJWkZ
	 rsMN1pmUEbgv1+Dt3smfT9tgSLKA6v/iIkqX+kIIIVouR4+J7gYztdceUof0/YzDqW
	 FJX/bn2dagJHgeK3HxlmGGfjLgUEPAsG5KAgUBvUwXsh8ZGWprJK2Eiv7HE3hr+rsU
	 yg8DmyX5pxIhw==
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
Subject: [PATCH 11/27] perf header: Byte-swap build ID event pid and bounds check section entries
Date: Wed, 20 May 2026 22:09:56 -0300
Message-ID: <20260521011027.622268-12-acme@kernel.org>
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

perf_header__read_build_ids() swaps the event header fields for cross-endian
perf.data files but not bev.pid. This causes perf_session__findnew_machine()
to look up the wrong machine for guest VM build IDs, misattributing them.
Swap bev.pid alongside the header fields.

Also add a build_id_swap callback for stream-mode build ID events,
and validate NUL-termination of build_id.filename on the native-endian
delivery path (perf_session__process_user_event) — events with
unterminated filenames are skipped.

Harden perf_header__read_build_ids() against crafted perf.data files:

- Add overflow check on offset + size to prevent wrap past ULLONG_MAX.
- Reject bev.header.size == 0 which would loop forever.
- Reject bev.header.size > remaining section to prevent reading past
  the section boundary.
- Guard memcmp(filename, "nel.kallsyms]", 13) with len >= 13 to avoid
  reading uninitialized stack memory on short filenames.
- Force NUL-termination of filename before passing it to functions
  like machine__findnew_dso() that use strlen/strcmp.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c  | 50 +++++++++++++++++++++++++++++++++++----
 tools/perf/util/session.c | 16 ++++++++++++-
 2 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 967c3d8ff12c8676..c0b5c99f462ad925 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <limits.h>
 #include "string2.h"
 #include <sys/param.h>
 #include <sys/types.h>
@@ -2578,7 +2579,13 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 	} old_bev;
 	struct perf_record_header_build_id bev;
 	char filename[PATH_MAX];
-	u64 limit = offset + size;
+	u64 limit;
+
+	/* Prevent offset + size from wrapping past ULLONG_MAX */
+	if (size > ULLONG_MAX - offset)
+		return -1;
+
+	limit = offset + size;
 
 	while (offset < limit) {
 		ssize_t len;
@@ -2589,6 +2596,10 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 		if (header->needs_swap)
 			perf_event_header__bswap(&old_bev.header);
 
+		/* size == 0 loops forever; size > remaining reads past section */
+		if (old_bev.header.size == 0 || old_bev.header.size > limit - offset)
+			return -1;
+
 		len = old_bev.header.size - sizeof(old_bev);
 		if (len < 0 || len >= PATH_MAX) {
 			pr_warning("invalid build_id filename length %zd\n", len);
@@ -2597,6 +2608,13 @@ static int perf_header__read_build_ids_abi_quirk(struct perf_header *header,
 
 		if (readn(input, filename, len) != len)
 			return -1;
+		/*
+		 * The file data may lack a null terminator, which could
+		 * indicate a corrupt or crafted perf.data file.  Ensure
+		 * filename is always a valid C string before passing it
+		 * to functions like machine__findnew_dso().
+		 */
+		filename[len] = '\0';
 
 		bev.header = old_bev.header;
 
@@ -2624,17 +2642,32 @@ static int perf_header__read_build_ids(struct perf_header *header,
 	struct perf_session *session = container_of(header, struct perf_session, header);
 	struct perf_record_header_build_id bev;
 	char filename[PATH_MAX];
-	u64 limit = offset + size, orig_offset = offset;
+	u64 limit, orig_offset = offset;
 	int err = -1;
 
+	/* Prevent offset + size from wrapping past ULLONG_MAX */
+	if (size > ULLONG_MAX - offset)
+		return -1;
+
+	limit = offset + size;
+
 	while (offset < limit) {
 		ssize_t len;
 
 		if (readn(input, &bev, sizeof(bev)) != sizeof(bev))
 			goto out;
 
-		if (header->needs_swap)
+		if (header->needs_swap) {
 			perf_event_header__bswap(&bev.header);
+			bev.pid = bswap_32(bev.pid);
+		}
+
+		/*
+		 * size == 0 would loop forever (offset never advances);
+		 * size > remaining would read past the section boundary.
+		 */
+		if (bev.header.size == 0 || bev.header.size > limit - offset)
+			goto out;
 
 		len = bev.header.size - sizeof(bev);
 		if (len < 0 || len >= PATH_MAX) {
@@ -2644,6 +2677,13 @@ static int perf_header__read_build_ids(struct perf_header *header,
 
 		if (readn(input, filename, len) != len)
 			goto out;
+		/*
+		 * The file data may lack a null terminator, which could
+		 * indicate a corrupt or crafted perf.data file.  Ensure
+		 * filename is always a valid C string before passing it
+		 * to functions like machine__findnew_dso().
+		 */
+		filename[len] = '\0';
 		/*
 		 * The a1645ce1 changeset:
 		 *
@@ -2657,7 +2697,9 @@ static int perf_header__read_build_ids(struct perf_header *header,
 		 * '[kernel.kallsyms]' string for the kernel build-id has the
 		 * first 4 characters chopped off (where the pid_t sits).
 		 */
-		if (memcmp(filename, "nel.kallsyms]", 13) == 0) {
+		/* Guard short filenames against memcmp reading past the buffer */
+		if (len >= (ssize_t)sizeof("nel.kallsyms]") - 1 &&
+		    memcmp(filename, "nel.kallsyms]", sizeof("nel.kallsyms]") - 1) == 0) {
 			if (lseek(input, orig_offset, SEEK_SET) == (off_t)-1)
 				return -1;
 			return perf_header__read_build_ids_abi_quirk(header, input, offset, size);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index be31634e7a83da67..dad482d7e800984d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -669,6 +669,14 @@ static int perf_event__hdr_attr_swap(union perf_event *event,
 	return 0;
 }
 
+static int perf_event__build_id_swap(union perf_event *event,
+				     bool sample_id_all __maybe_unused)
+{
+	/* Only pid needs swapping — build_id[] is a raw byte array */
+	event->build_id.pid = bswap_32(event->build_id.pid);
+	return 0;
+}
+
 static int perf_event__event_update_swap(union perf_event *event,
 					 bool sample_id_all __maybe_unused)
 {
@@ -997,7 +1005,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_HEADER_ATTR]	  = perf_event__hdr_attr_swap,
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
-	[PERF_RECORD_HEADER_BUILD_ID]	  = NULL,
+	[PERF_RECORD_HEADER_BUILD_ID]	  = perf_event__build_id_swap,
 	[PERF_RECORD_HEADER_FEATURE]	  = perf_event__header_feature_swap,
 	[PERF_RECORD_ID_INDEX]		  = perf_event__all64_swap,
 	[PERF_RECORD_AUXTRACE_INFO]	  = perf_event__auxtrace_info_swap,
@@ -1984,6 +1992,12 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		err = tool->tracing_data(tool, session, event);
 		break;
 	case PERF_RECORD_HEADER_BUILD_ID:
+		if (!perf_event__check_nul(event->build_id.filename,
+					   (void *)event + event->header.size,
+					   "HEADER_BUILD_ID")) {
+			err = 0;
+			break;
+		}
 		err = tool->build_id(tool, session, event);
 		break;
 	case PERF_RECORD_FINISHED_ROUND:
-- 
2.54.0

