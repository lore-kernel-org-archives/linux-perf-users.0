Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415714883F;
	Mon, 25 May 2026 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779671171; cv=none; b=bNdQtV9GesAvEL3izB6ECThrXaNerWDMOn+hIRWX6xaXDQEEl7Ey8Yj/Tn8TKGHP/iJllDbArBiPEeUVMLzUJRTnIbGaT3Ta1KG/ly5YN98XXeoHu4aZpUl4zYGTfsT4WTfltXh7j4r5lFSdQktI1L+WOY7IlA3wcYieiIJIgpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779671171; c=relaxed/simple;
	bh=EFl0ilw7DOSK6DwVd5+p0NyA5yFDMXfTnyy1U7dcmAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tpuup+lpPwmPtfSgy4A0l7GWn5mdYp1UCgGJTrMKXevE+2A+zVM7fIfYI6Qn8TJwCQ2VX/n/VmbkioYpzpEpJYeV7582AoKizIE7A1IYv4kz8deewvjas8c9EgSInaakrLa79a4FQ0DoqxAJNJdspdewaX3TkhVhQhxrDG4xOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M42c8lSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M42c8lSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1901F000E9;
	Mon, 25 May 2026 01:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779671170;
	bh=87T7wPlP1JWvoL8tVqclceY6ODGJmso4j6MMQOhWpYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M42c8lSehqXaJunsbuwO04NBbTHQg0LHGZa/SDJ/nO4deZnJ1cPHZz0z7BPTx9JqM
	 ces69qOfruB3eMC3YcWDyS87+msvaIo55Z8KHMvaP0ymrByKV83sP0/8Sm8nKYLcbQ
	 6/WrbwS3RbkO+17oJe6L8gvT0fsMk43ZFPoUclimrq0SGF4Le8R2qcwd8YUEHjjCLW
	 XoK8Vdg9zsD1W1zV1sDrMn4578MNnHPzUQ5Ukx3mlSongrIuSFZdRBavDwKNR35BC7
	 o4Eh6t0kvg0n61ihyEmLlNKOOnBCTFF9JQ0/s59Wr6ZPoAoGiX9xCDPoG+8dukRWDP
	 pCtEA1cZyk3Zw==
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
Subject: [PATCH 02/29] perf session: Bounds-check one_mmap event pointer in peek_event
Date: Sun, 24 May 2026 22:05:22 -0300
Message-ID: <20260525010550.1100375-3-acme@kernel.org>
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

perf_session__peek_event() computes an event pointer directly from
file_offset when one_mmap is active, without verifying that file_offset
and the subsequent event->header.size fall within the mapped region.
A corrupted perf.data file could cause out-of-bounds memory reads.

Add one_mmap_size to the session struct and validate both the header
and full event fit within the mmap before dereferencing.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 29 ++++++++++++++++++++++++++---
 tools/perf/util/session.h |  2 ++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0523fd243e02c09b..c4cd8ad6d810a74c 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1887,12 +1887,27 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	*event_ptr = NULL;
 
 	if (session->one_mmap && !session->header.needs_swap) {
-		event = file_offset - session->one_mmap_offset +
-			session->one_mmap_addr;
+		u64 offset_in_mmap;
+
+		/* Validate offset with integer arithmetic to avoid pointer UB */
+		if ((u64)file_offset < session->one_mmap_offset)
+			return -1;
+
+		offset_in_mmap = (u64)file_offset - session->one_mmap_offset;
+
+		/* Use subtraction to avoid addition overflow */
+		if (offset_in_mmap >= session->one_mmap_size ||
+		    session->one_mmap_size - offset_in_mmap < sizeof(struct perf_event_header))
+			return -1;
+
+		event = session->one_mmap_addr + offset_in_mmap;
 
-		/* Every event must at least contain its own header */
 		if (event->header.size < sizeof(struct perf_event_header))
 			return -1;
+
+		/* Ensure full event is within the mmap region */
+		if (session->one_mmap_size - offset_in_mmap < event->header.size)
+			return -1;
 	} else {
 		if (perf_data__is_pipe(session->data))
 			return -1;
@@ -2560,6 +2575,14 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	if (session->one_mmap) {
 		session->one_mmap_addr = buf;
 		session->one_mmap_offset = rd->file_offset;
+		/*
+		 * mmap_size was set to the full file extent (data_offset +
+		 * data_size) but file_offset was shifted forward by
+		 * page_offset for page alignment.  Reduce by page_offset
+		 * so the bounds check reflects the file-backed portion
+		 * of the mapping — pages beyond the file cause SIGBUS.
+		 */
+		session->one_mmap_size = rd->mmap_size - page_offset;
 	}
 
 	return 0;
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index f05f0d4a6c238dc8..d554e2a1a50ed304 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -71,6 +71,8 @@ struct perf_session {
 	void			*one_mmap_addr;
 	/** @one_mmap_offset: File offset in perf.data file when mapped. */
 	u64			one_mmap_offset;
+	/** @one_mmap_size: Size of the single mmap in bytes. */
+	u64			one_mmap_size;
 	/** @ordered_events: Used to turn unordered events into ordered ones. */
 	struct ordered_events	ordered_events;
 	/** @data: Optional perf data file being read from. */
-- 
2.54.0

