Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74A22425B;
	Sun, 10 May 2026 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384184; cv=none; b=tjWFSNN6vn7/KOvBESJUkXFL9zDGoBIL4i7Q9t/tMw9pxGXbdwXwLN5f8pFZzom14yW64LtoX/mGvlq/AKAG4DuTiq8Z3H2QOHV1BAN9ysLIB9Qmm+S2jZs0FWA8/3Cf28sM314vfEaC661S8iAPT2iXAqNxTHXkoKm7Age+yHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384184; c=relaxed/simple;
	bh=52B0C7dWKgMh9o+uce9gU6WCrJG1z3a6g0/2jvqnA9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi6MY1+jLFPJn+TxwjjhqNXwrs6aL+r/NhxGBil1FcByNzf9YCAEVoOXeL7y56Qn2VDJ1+r9imyfeWyd9uPe9xoXBIyLQnpDEyJP2S9YhhQtoHKd8Vvinp5WBTb4vy14lDqI9JCbJffg3w7/5WjjVfcJMZ4RRc571VU3sPE3vYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+bS2Jb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+bS2Jb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB59C2BCF6;
	Sun, 10 May 2026 03:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384183;
	bh=52B0C7dWKgMh9o+uce9gU6WCrJG1z3a6g0/2jvqnA9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u+bS2Jb8CkEpnmYtiXhBK2aLV25AGXfjkG7jl4lghHK/y5/HGqBJXc2Qly5oVeDAF
	 7NM6aU234KZ4pXHwudvfO/EKC8tTMSAz508pvXgIlfmib5rRZCbmPYr1HtYEpb8qQv
	 Kx9R8ybGqV6yv2RJUuFErEYWPjePQl5VHMv7t0pZso6hf31p31kD7GAPY1wvQsvKNv
	 j/HItzU/zuA0iK3P+C/GoKfIGzJSkvesv6hUF0I1FlPR/RJMtjEg7JTffrmMczGKrm
	 JbqaQXHFdNwnakmKwwAc0jS097k67MYRztMW+r2a+UpuFclrKMIiH2Ywk79uh+A9DK
	 4VN3ITwTZ6aYw==
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
	David Carrillo-Cisneros <davidcc@google.com>,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 19/28] perf header: Validate feature section size and add read path bounds checking
Date: Sun, 10 May 2026 00:34:10 -0300
Message-ID: <20260510033424.255812-20-acme@kernel.org>
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
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 62 ++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f4008878bd7eda04..a8655a784eaa5ba9 100644
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
@@ -289,16 +298,22 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	/* At least the null terminator. */
+	if (len < 1 || len > ff->size - ff->offset)
+		return NULL;
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
 
@@ -2775,7 +2790,12 @@ static int process_tracing_data(struct feat_fd *ff __maybe_unused, void *data __
 
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
@@ -4152,6 +4172,7 @@ static int perf_file_section__fprintf_info(struct perf_file_section *section,
 	ff = (struct  feat_fd) {
 		.fd = fd,
 		.ph = ph,
+		.size = section->size,
 	};
 
 	if (!feat_ops[feat].full_only || hd->full)
@@ -4512,6 +4533,7 @@ int perf_header__process_sections(struct perf_header *header, int fd,
 	int sec_size;
 	int feat;
 	int err;
+	struct stat st;
 
 	nr_sections = bitmap_weight(header->adds_features, HEADER_FEAT_BITS);
 	if (!nr_sections)
@@ -4529,7 +4551,29 @@ int perf_header__process_sections(struct perf_header *header, int fd,
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
@@ -4756,7 +4800,7 @@ static int perf_file_section__process(struct perf_file_section *section,
 		.fd	= fd,
 		.ph	= ph,
 		.size	= section->size,
-		.offset	= section->offset,
+		.offset	= 0,
 	};
 
 	if (lseek(fd, section->offset, SEEK_SET) == (off_t)-1) {
-- 
2.54.0

