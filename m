Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E12279DC3;
	Sun, 10 May 2026 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384178; cv=none; b=mgcBCRRwDx/IDfOTMccjHxo2evXuOa46X4TM7VBEqipGbB1cnEj9IYyiq+tV/jiOyajJRNuqhCXRLokHkI3RW+a9/NVErMTofHwMSkhEQgwsnDSt4kVKAidennVQsK7cZQKHVHKf1G8aeWqUPGH3MwCtzeL4K9lvgzbrUHvs/Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384178; c=relaxed/simple;
	bh=tH3tmp78z7itj/qw5X2HyXxSWIjyUOUgDP8ZA33W1H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBbKTyLY4NNB07r29nBgfKer5+L3H9/GBJ6Y1mYGa+WfjM9SpEgFtH4Bqtu72cIMEIV4QRn2dZLpY/yDc6tI6iig9sNjz2qif3z2FI0sJfJwl8sSuZld/C2CCMj6MD+A5WgNgD29oM6ySk2ncTLMAKuxmA8NNadmetn3mdnXucs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxS3EbCE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxS3EbCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB847C2BCF6;
	Sun, 10 May 2026 03:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384178;
	bh=tH3tmp78z7itj/qw5X2HyXxSWIjyUOUgDP8ZA33W1H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxS3EbCE1ME3B/y+XfdMbNfJxOx9MZTR9xcyYcP4ieS6zsJShW6rdEvXd4UiReNQv
	 kLaK3PIFk6h9fMhWpBKwLLRBbHmkxnWYzZt1QKFW5CI77yAKtt0i4cSte+5gMHMUMP
	 DI8sskHVKersMrLkLt7bBsNmQgDRvySr0KyttgO9TqrOkJct4T9w0XHP+t6lUk3x1f
	 dZ9YRELoy8aXekfJH42NtGVRpoqZNwI5BsSu5AfcL0iBYuzfwlOBBoQ7NGu4DwZI9V
	 PXjsOnduqwyHFc44MN/oUiozPwICNOUMAeqTHbt+2QM0YUzCSD5QzLHy+lRGrHO6ht
	 Wa6tMFh9zstow==
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
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 18/28] perf header: Validate f_attr.ids section before use in perf_session__read_header()
Date: Sun, 10 May 2026 00:34:09 -0300
Message-ID: <20260510033424.255812-19-acme@kernel.org>
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

perf_session__read_header() reads f_attr.ids.size from the perf.data
file and divides it by sizeof(u64) to compute nr_ids, which is
declared as int.  No validation is performed on the value before it
is used to allocate arrays and drive a read loop.

On 32-bit architectures, a crafted f_attr.ids.size of 0x100000000
(4 GB) produces nr_ids = 0x20000000, but the allocation size
1 * 0x20000000 * 8 overflows size_t to 0, so zalloc(0) returns a
valid pointer.  The subsequent loop writes 0x20000000 IDs into that
zero-length buffer, corrupting the heap.

On 64-bit, the u64-to-int truncation silently drops high bits,
processing fewer IDs than the file claims.  While not exploitable,
this is a data integrity issue.

Add validation before using f_attr.ids:

- Cap nr_attrs (attrs.size / attr_size) to MAX_NR_ATTRS (1 << 16)
  with overflow-safe u64 comparison before assigning to int
- Reject ids.size not aligned to sizeof(u64)
- Cap ids.size / sizeof(u64) to MAX_IDS_PER_ATTR (1 << 24) to
  prevent int truncation and size_t overflow on 32-bit
- Reject ids sections that extend past the end of the file,
  guarded by S_ISREG() so non-regular files (block devices,
  pipes) are not falsely rejected

Also fix perf_header__getbuffer64() to set errno = EIO when
readn() returns 0 (EOF).  Without this, the out_errno path in
perf_session__read_header() returns -errno which is 0 (success)
on truncated files, causing downstream NULL dereferences.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 78 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5cbeda0335f1140c..f4008878bd7eda04 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -64,6 +64,25 @@
 #include <event-parse.h>
 #endif
 
+/*
+ * nr_ids * sizeof(struct perf_sample_id) must not overflow
+ * size_t on 32-bit; the struct is ~104 bytes (32-bit) or
+ * ~184 bytes (64-bit), so 1<<24 (16M) keeps the product
+ * under 2 GB on 32-bit.
+ *
+ * This is a per-attribute cap only — the total across all
+ * attributes is not capped because legitimate high-core-count
+ * workloads (e.g. 5000 tracepoints × 4096 CPUs) can exceed
+ * a single-attribute limit.
+ */
+#define MAX_IDS_PER_ATTR	(1 << 24)
+/*
+ * Cap nr_attrs to prevent resource exhaustion from crafted
+ * files.  65536 is well beyond any real workload (perf stat
+ * typically uses < 100 events) but prevents u64-to-int
+ * truncation on the attr count.
+ */
+#define MAX_NR_ATTRS		(1 << 16)
 #define MAX_BPF_DATA_LEN	(256 * 1024 * 1024)
 #define MAX_BPF_PROGS		131072
 #define MAX_CACHE_ENTRIES	32768
@@ -4468,8 +4487,13 @@ int perf_session__inject_header(struct perf_session *session,
 static int perf_header__getbuffer64(struct perf_header *header,
 				    int fd, void *buf, size_t size)
 {
-	if (readn(fd, buf, size) <= 0)
+	ssize_t n = readn(fd, buf, size);
+
+	if (n <= 0) {
+		if (n == 0)
+			errno = EIO;
 		return -1;
+	}
 
 	if (header->needs_swap)
 		mem_bswap_64(buf, size);
@@ -4803,6 +4827,8 @@ static int read_attr(int fd, struct perf_header *ph,
 	if (ret <= 0) {
 		pr_debug("cannot read %d bytes of header attr\n",
 			 PERF_ATTR_SIZE_VER0);
+		if (ret == 0)
+			errno = EIO;
 		return -1;
 	}
 
@@ -4903,6 +4929,7 @@ int perf_session__read_header(struct perf_session *session)
 	struct perf_file_header	f_header;
 	struct perf_file_attr	f_attr;
 	u64			f_id;
+	struct stat		input_stat;
 	int nr_attrs, nr_ids, i, j, err = -ENOMEM;
 	int fd = perf_data__fd(data);
 
@@ -4952,6 +4979,15 @@ int perf_session__read_header(struct perf_session *session)
 		return -EINVAL;
 	}
 
+	if (fstat(fd, &input_stat) < 0)
+		return -errno;
+
+	/* Check before assigning to int to avoid u64-to-int truncation */
+	if (f_header.attrs.size / f_header.attr_size > MAX_NR_ATTRS) {
+		pr_err("Too many attributes: %" PRIu64 " (max %d)\n",
+		       f_header.attrs.size / f_header.attr_size, MAX_NR_ATTRS);
+		return -EINVAL;
+	}
 	nr_attrs = f_header.attrs.size / f_header.attr_size;
 	lseek(fd, f_header.attrs.offset, SEEK_SET);
 
@@ -4968,6 +5004,45 @@ int perf_session__read_header(struct perf_session *session)
 			perf_event__attr_swap(&f_attr.attr);
 		}
 
+		/*
+		 * Validate ids section: must be aligned to u64, and
+		 * the count must fit in an int to avoid truncation in
+		 * nr_ids and size_t overflow in perf_evsel__alloc_id()
+		 * on 32-bit architectures.
+		 */
+		if (f_attr.ids.size % sizeof(u64)) {
+			pr_err("Invalid ids section size %" PRIu64 " for attr %d, not aligned to u64\n",
+			       f_attr.ids.size, i);
+			err = -EINVAL;
+			goto out_delete_evlist;
+		}
+
+		/*
+		 * Cap the ID count to avoid int truncation of nr_ids
+		 * on 64-bit and size_t overflow in the allocation
+		 * paths (nr_ids * sizeof(u64), nr_ids *
+		 * sizeof(struct perf_sample_id)) on 32-bit.
+		 */
+		if (f_attr.ids.size / sizeof(u64) > MAX_IDS_PER_ATTR) {
+			pr_err("Invalid ids section size %" PRIu64 " for attr %d, too many IDs\n",
+			       f_attr.ids.size, i);
+			err = -EINVAL;
+			goto out_delete_evlist;
+		}
+
+		/*
+		 * FIXME: see perf_header__process_sections() — block
+		 * devices bypass this check because st_size is 0.
+		 */
+		if (S_ISREG(input_stat.st_mode) &&
+		    (f_attr.ids.offset > (u64)input_stat.st_size ||
+		     f_attr.ids.size > (u64)input_stat.st_size - f_attr.ids.offset)) {
+			pr_err("Invalid ids section for attr %d: offset=%" PRIu64 " size=%" PRIu64 " exceeds file size %" PRIu64 "\n",
+			       i, f_attr.ids.offset, f_attr.ids.size, (u64)input_stat.st_size);
+			err = -EINVAL;
+			goto out_delete_evlist;
+		}
+
 		tmp = lseek(fd, 0, SEEK_CUR);
 		evsel = evsel__new(&f_attr.attr);
 
@@ -4982,6 +5057,7 @@ int perf_session__read_header(struct perf_session *session)
 		evlist__add(session->evlist, evsel);
 
 		nr_ids = f_attr.ids.size / sizeof(u64);
+
 		/*
 		 * We don't have the cpu and thread maps on the header, so
 		 * for allocating the perf_sample_id table we fake 1 cpu and
-- 
2.54.0

