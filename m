Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3737D128;
	Wed, 10 Jun 2026 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121245; cv=none; b=UA867RZLl/93d/SLcEjJ6i3a9fN72c9RTSOKWev+c6BKF+fLH8BZyQthRDzgKN4OVseafABkI95Xn/Pj6+e/8EGLXy5+3JYPVN24AAzZ5lEYU4GeT2ih2RZcobB9HrdI5ymM8nYdtoOqlC3oqdCjfQ2dQsIRqpI0YD9vYfyYwbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121245; c=relaxed/simple;
	bh=r1FvOriVrZR3ostN93vKiIt9jeaWj8eqZ/bXbnkMTng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFngUS3RPxCQVH8ugTJ4T38ACWqlI0J8kTw98iXYg3jUaZ0r3fXfSfMiNN/PTyNyiaTgUuT73taXv9GyGytVUF+/JQ6T52NmnWygnusW2cgMwiNoJhBDVSGc7ysvEYuMqkIWxBBmMFpBiiZnTl3WEQzTgDQubYD4IcyGX0dr4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNeFA8QG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNeFA8QG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEB41F00893;
	Wed, 10 Jun 2026 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121243;
	bh=nfTxi6hJrsAftZWf73Htz3mo6TQ573ldugdjpeqF6A8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JNeFA8QGiL2prGKcRFZgxLWxWVeNsRZzSLatk6LOwpEw5i2m9LJUAHvTapHDq2CGj
	 ZMyCpjnez2IOiue3We9Tm5+0IsFh+sPdjJQwwX7dLLPGR7w27tjwJjnBvVUtRcfcZK
	 6NxLRKnMEoRNWHWdeOOJYT4EmVOWvnexFcoPz7nlTriODndcv6thz/pnbhCK6GTo4Q
	 YAnnRMvS4R8U5zuJOncBCOPg3XOHItc2QiN7pxQl7i8+UDvX7nQGOVmA14xbKjp1bk
	 cHgo2c5I3mpei82WAQTUrNa3hOcwozJVKCI/eaD8SMxpvFqyliEh+/bSwQclKbpPZ6
	 pyXfNBesaLXuQ==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 23/23] perf symbols: Add bounds checks to read_build_id() note iteration in minimal build
Date: Wed, 10 Jun 2026 16:51:56 -0300
Message-ID: <20260610195157.2091137-24-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

symbol-minimal.c's read_build_id() iterates ELF notes with the same
pattern as symbol-elf.c's elf_read_build_id(): pointer arithmetic
driven by n_namesz and n_descsz from 32-bit note header fields,
without validating that the name and desc fit within the note section
data.  A malformed ELF file with oversized note sizes causes
out-of-bounds reads past the section data buffer.

Add the same bounds check as the libelf path: validate namesz and
descsz individually against remaining data before advancing the
pointer, avoiding size_t overflow on 32-bit.

Fixes: b691f64360ecec49 ("perf symbols: Implement poor man's ELF parser")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-minimal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index 8221dc9868f7c9f8..091071d06416e290 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -1,3 +1,4 @@
+#include "debug.h"
 #include "dso.h"
 #include "symbol.h"
 #include "symsrc.h"
@@ -44,7 +45,7 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 	ptr = note_data;
 	while ((ptr + sizeof(*nhdr)) < (note_data + note_len)) {
 		const char *name;
-		size_t namesz, descsz;
+		size_t namesz, descsz, remaining;
 
 		nhdr = ptr;
 		if (need_swap) {
@@ -56,6 +57,14 @@ static int read_build_id(void *note_data, size_t note_len, struct build_id *bid,
 		namesz = NOTE_ALIGN(nhdr->n_namesz);
 		descsz = NOTE_ALIGN(nhdr->n_descsz);
 
+		/* validate individually to avoid size_t overflow on 32-bit */
+		remaining = note_data + note_len - ptr - sizeof(*nhdr);
+		if (namesz > remaining || descsz > remaining - namesz) {
+			pr_warning("%s: oversized note: n_namesz=%u, n_descsz=%u\n",
+				   __func__, nhdr->n_namesz, nhdr->n_descsz);
+			break;
+		}
+
 		ptr += sizeof(*nhdr);
 		name = ptr;
 		ptr += namesz;
-- 
2.54.0

