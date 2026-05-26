Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBD23C1F57;
	Tue, 26 May 2026 21:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830361; cv=none; b=IBkY0RNzUlB/tlea2Y8azmFLG2iaBIzu0CHvwv9WZEGTxGpLEltvvNBaHSneB1ALuxvax+FkgpaHBQB5+q7DML3db7VqmZu9ZnrKc8fZ78xYUygilCld8y/ERheDNsDI/G0tYaCXY5rD+hpKfaBCklxzn019ziFYCo+/qHJq59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830361; c=relaxed/simple;
	bh=jXjvoV4cpNi9Z/JaNAGHITCqK28buPQzHl0Tsj1uLyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiltXuUNxxddTKx/YTtolWlrGoAdh268Ww7o3cOkAA9HeM5nUVCKbz2sD6jOuRxQJCCq6XSouls9CEwluB1ia0p6h6XlvE56UHv75NTIqXlPobhk1Lxz98FWfYdkyPnQijNNmwlo/D3QE3qxOha5KinIJD23abUexFStxkFME/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeZ2GNzy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeZ2GNzy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9961F00A3A;
	Tue, 26 May 2026 21:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830360;
	bh=XiuT+0Wo8/JradWW/zhKNB69DQkSoJ7QybFBqeEaTqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UeZ2GNzy8LK5jhvUpqCM3mLBagIqbExfPq2ylPFMk4O42lFzbZKH4T5In7WYHFuFk
	 PpzwYBQehpuPVNkjaeSl/u+zGQCne82sCvp7q1OyLH3zSf0ppM1M4sJrrtkerVubB8
	 B8mUgNkPCIwO1VrxR3fmH4d1aV7fLc14WgmpIMBJVUTHSChudYBufxRe1UEieXgS6H
	 C4iYsZNsSZaWug8Ug8/DfMturMqURtiHAwQ29uHRiHFl6XQlfNO090xWJCHw6QiHiP
	 o5+0Wjrv8tcbOhzg6LnqlexWlJLz3SaifwWXZapjrxwrfJdv3wVSHdIW4r6vyR2vVT
	 n+MUt7VhhPjLQ==
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
Subject: [PATCH 19/29] perf header: Validate f_attr.ids section before use in perf_session__read_header()
Date: Tue, 26 May 2026 18:17:55 -0300
Message-ID: <20260526211806.1193848-20-acme@kernel.org>
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
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 77 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f4e0e257ff7226ac..fe23bbd8370c0190 100644
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
 
@@ -4951,6 +4978,15 @@ int perf_session__read_header(struct perf_session *session)
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
 
@@ -4967,6 +5003,45 @@ int perf_session__read_header(struct perf_session *session)
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
 
-- 
2.54.0

