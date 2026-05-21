Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374C31E83D;
	Thu, 21 May 2026 01:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325915; cv=none; b=XD9o0CS4BRJMD2913omu0nc7UeuDkP0/CXdpr9iLE/JAN9VkCswu3YAJTIECsGj9GqKzz+xbqwHY7CfcSMCaVOx3ZJFza03MVRp/53alINVuRFNo4ihlzgFwHeoIrLsxtss5Ql+YdLxbaKSGeSkDOT7cYA4fBTkobpKiqKncVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325915; c=relaxed/simple;
	bh=Y2h+CVvXwGxDcsNibmCM4j/7sROHXesboSchM2mh8gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmw1kOMlhSPVJw2F+3HV2mCgTNECJM4cmo/ocCH/nbXvIHxJNIF0TauzkNIYGQNckXGUAbRcBehApije68AB3IEoDVrg20DZgWyw2fHy/kp9aZHe2a+K7AnXV3WMghMw5+ljrcpF/GGapKaIVm1/wj5449ZXnG8t81yzJW8XvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK5vnpZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK5vnpZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A561F00A3B;
	Thu, 21 May 2026 01:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325914;
	bh=rJ47xZ5z5sp6xTwzTpQXJSwv9U/H2TiBxMS2fbkB5mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK5vnpZM8RAdfKt75p7Z/HTZgsC+1vo3kcX9AUAXPFtSyzLqxpUrDea0P3n3nWI0l
	 5auQD6jGP5IWuIWuIfJiRV+Hn54Bh7Q/PWmpZSwwScDr2hAaCfjR4cy48jfK7XrWH4
	 y08yNxtn+ptBdnKz3ZdQWo7J3/F7YJr6j8fRbx4LrJB9jDdIbOVuELJdHIseT2gl7k
	 2lRX5tJ1cnDDItCcuFTedA8kvGCc8W00Ez2Cs5Uw8+X7ratyBPNm9J8oQCYq9TYUV7
	 +Aytq7mrOy3pkqIgw0bVvhliSJL41RMldvX55hN/z+onAsHpS5Mt6BhnylnypKrZlq
	 2ARko21r4NoZQ==
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
	David Carrillo-Cisneros <davidcc@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 19/27] perf header: Validate feature section size and add read path bounds checking
Date: Wed, 20 May 2026 22:10:04 -0300
Message-ID: <20260521011027.622268-20-acme@kernel.org>
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

Harden feature section parsing against crafted perf.data files:

1. perf_header__process_sections() reads the feature section table
   and passes each section's offset and size directly to the
   processing callbacks without validating them against the actual
   file size.  A crafted section size would make all downstream
   bounds checks against ff->size ineffective since they compare
   against the untrusted, inflated bound.  Add an fstat() check
   with S_ISREG() guard and verify that each section's offset +
   size does not extend past EOF.

2. __do_read_buf() validates reads against ff->size (section size),
   but __do_read_fd() had no such check, so a malformed perf.data
   with an understated section size could cause reads past the end
   of the current section into the next section's data.  Add the
   bounds check in __do_read(), the common caller of both helpers,
   so it is enforced uniformly for both the fd and buf paths.
   Track the section-relative offset in __do_read_fd() so the
   check works for the fd path.  Reject negative sizes which on
   32-bit can occur when a u32 >= 0x80000000 is passed as ssize_t.

3. do_read_string() relied on file data being null-padded.  Add
   explicit null-termination (buf[len-1] = '\0') after reading
   and validate length (>= 1, fits within section) before
   allocating, so callers like process_cpu_topology() never
   receive an unterminated string.

4. Initialize feat_fd.offset to 0 (section-relative) instead of
   section->offset (file-absolute) so the bounds tracking is
   consistent with __do_read()'s section-relative comparison.
   Adjust process_build_id() to use lseek() for its file-absolute
   offset needs since it cannot rely on ff->offset for that.

5. Propagate ff->size to perf_file_section__fprintf_info() so its
   reads are also bounded.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 65 ++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index ad0a6aab8a6d5336..bea1446046282ce9 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -233,23 +233,32 @@ static int __do_read_fd(struct feat_fd *ff, void *addr, ssize_t size)
 
 	if (ret != size)
 		return ret < 0 ? (int)ret : -1;
+	ff->offset += size;
 	return 0;
 }
 
 static int __do_read_buf(struct feat_fd *ff, void *addr, ssize_t size)
 {
-	if (size > (ssize_t)ff->size - ff->offset)
-		return -1;
-
 	memcpy(addr, ff->buf + ff->offset, size);
 	ff->offset += size;
 
 	return 0;
-
 }
 
 static int __do_read(struct feat_fd *ff, void *addr, ssize_t size)
 {
+	/*
+	 * Reject negative sizes, which on 32-bit can occur when a
+	 * u32 >= 0x80000000 is passed as ssize_t.  The cast to
+	 * ssize_t is safe because perf_header__process_sections()
+	 * validates that each section fits within the file size
+	 * before any feature callback reaches here, and only
+	 * feature sections (metadata like build IDs, topology, etc.)
+	 * use this path — these cannot legitimately approach 2GB.
+	 */
+	if (size < 0 || size > (ssize_t)ff->size - ff->offset)
+		return -1;
+
 	if (!ff->buf)
 		return __do_read_fd(ff, addr, size);
 	return __do_read_buf(ff, addr, size);
@@ -289,16 +298,25 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	/* At least the null terminator. */
+	if (len < 1 || len > ff->size - ff->offset) {
+		pr_debug("do_read_string: invalid length %u (remaining %zu)\n",
+			 len, (size_t)(ff->size - ff->offset));
+		return NULL;
+	}
+
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
 
 	if (!__do_read(ff, buf, len)) {
 		/*
-		 * strings are padded by zeroes
-		 * thus the actual strlen of buf
-		 * may be less than len
+		 * do_write_string() writes len including the null
+		 * terminator, padded to NAME_ALIGN.  Ensure the
+		 * string is always null-terminated even if the file
+		 * data has been tampered with.
 		 */
+		buf[len - 1] = '\0';
 		return buf;
 	}
 
@@ -2775,7 +2793,12 @@ static int process_tracing_data(struct feat_fd *ff __maybe_unused, void *data __
 
 static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
 {
-	if (perf_header__read_build_ids(ff->ph, ff->fd, ff->offset, ff->size))
+	off_t offset = lseek(ff->fd, 0, SEEK_CUR);
+
+	if (offset == (off_t)-1)
+		return -1;
+
+	if (perf_header__read_build_ids(ff->ph, ff->fd, offset, ff->size))
 		pr_debug("Failed to read buildids, continuing...\n");
 	return 0;
 }
@@ -4152,6 +4175,7 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 	ff = (struct  feat_fd) {
 		.fd = fd,
 		.ph = ph,
+		.size = section->size,
 	};
 
 	if (!feat_ops[feat].full_only || hd->full)
@@ -4512,6 +4536,7 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 	int sec_size;
 	int feat;
 	int err;
+	struct stat st;
 
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
 	if (!nr_sections)
@@ -4529,7 +4554,29 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 	if (err < 0)
 		goto out_free;
 
+	if (fstat(fd, &st) < 0) {
+		pr_err("Failed to stat the perf data file\n");
+		err = -1;
+		goto out_free;
+	}
+
 	for_each_set_bit(feat, header->adds_features, header->last_feat) {
+		/*
+		 * FIXME: block devices have st_size == 0, so we skip
+		 * bounds checking entirely.  Historically perf never
+		 * prevented using a block device as input, but it
+		 * probably should — there's no valid use case for it
+		 * and it bypasses all file-size validation.
+		 */
+		if (S_ISREG(st.st_mode) &&
+		    (sec->offset > (u64)st.st_size ||
+		     sec->size > (u64)st.st_size - sec->offset)) {
+			pr_err("Feature %s (%d) section extends past EOF (offset=%" PRIu64 ", size=%" PRIu64 ", file=%" PRIu64 ")\n",
+			       header_feat__name(feat), feat,
+			       sec->offset, sec->size, (u64)st.st_size);
+			err = -1;
+			goto out_free;
+		}
 		err = process(sec++, header, feat, fd, data);
 		if (err < 0)
 			goto out_free;
@@ -4756,7 +4803,7 @@ static int perf_file_section__process(struct perf_file_section *section,
 		.fd	= fd,
 		.ph	= ph,
 		.size	= section->size,
-		.offset	= section->offset,
+		.offset	= 0,
 	};
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
-- 
2.54.0

