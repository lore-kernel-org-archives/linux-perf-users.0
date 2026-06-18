Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEE31ED7D;
	Thu, 18 Jun 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798820; cv=none; b=PEgZlexxNsVhTrL1JKsGx0K2eXjZMBfiZdDsf8AmMu+eT+U/gILjB2Vt2/WFGOsJUG/oGskt0klKSnxfwubtGjurWWW1kGG9bkK1t6NKSh8M3+3vzqToW5TZEcRhRVVyExqpUg1rfW+ZjsT/xdxPWAGAwotRkHp8H2DSuYBMuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798820; c=relaxed/simple;
	bh=acPVG5cRc48ikNcx0TKLQCGB7swUlsDk0+/OUQbGvWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeVAG5sW8R1oVqVt2L+VeW3ACFsRXg6EnePFvbHzqLB4P3olTtkmyTMjoXjk111+/XLQLhu2/MQU63gBXIPAvLIMGywAOmdygTTyk6c0kdQncVVcjhRyuK0wmgEkJZJr5MaZqo32kAWwK9aOThCdC0OO/EFrRwMscnpQ4ftxmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=2c/wRjOc; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="2c/wRjOc"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 87316D1807;
	Thu, 18 Jun 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1781798370;
	bh=8fe8z80qpEjkeS/iWu+EZWaqjdnu1Gy8KmwoHnk+xP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2c/wRjOcbuKwTFXhy+Z/AOxUp4A6cttHmqRw5OBZlWM326JtvWbPNAdUlT+QVo7En
	 qUZgkiw1QTLfuyb8Fz0YLebi7NI63CRbMWFC5+Zi/HAqIr9NYIL5241UcGrs/OSN6w
	 U01uI6Ovf52zXxPWq3Ssl4J1Bw06oXgAs+gwJvVo=
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kernel-team@meta.com,
	Farid Zakaria <fmzakari@meta.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 1/3] perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push
Date: Thu, 18 Jun 2026 15:59:07 +0000
Message-ID: <efb81ee56e376079050d79690c00c718bbb444cf.1781797544.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781797544.git.d@ilvokhin.com>
References: <cover.1781797544.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With Zstd compression enabled ('perf record -z'), a single mmap push
whose compressed output exceeds the maximum record size makes
zstd_compress_stream_to_records() emit several PERF_RECORD_COMPRESSED2
records back to back. record__pushfn() however rewrote only the first
record's header to describe the whole blob as one record:

  event->data_size   = compressed - sizeof(struct perf_record_compressed2);
  event->header.size = PERF_ALIGN(compressed, sizeof(u64));
  padding            = event->header.size - compressed;
  ...
  record__write(rec, map, &pad, padding);

perf_event_header::size is a __u16, so once the compressed blob no
longer fits in it the header.size assignment truncates and 'padding'
(size_t) underflows. write() is then handed that bogus length and fails
with EFAULT, aborting the recording:

  failed to write perf data, error: Bad address

The bytes that did reach the file are mis-framed, so reading it back
cannot be decompressed.

This is easy to hit with a high event rate and a large buffer, e.g.:

  perf record -z -F max -m 32M --per-thread -- perf test -w thloop 5 1

The single-record fixup is wrong by construction: because header.size is
16 bits a compressed record cannot exceed 64KB, so the compressor must
split a push into a chain of records, and the session reader already
consumes them as such.

Frame each record where it is produced instead: process_comp_header()
now sets the per-record data_size, 8-byte-aligns header.size and zeroes
the trailing padding, and record__pushfn() just writes the resulting
blob, as the AIO path already does. max_record_size is reduced by
sizeof(u64) so the per-record alignment padding cannot push header.size
past its u16 field.

There is no on-disk format change; a perf.data written by the fixed tool
is still read by existing perf.

Fixes: 208c0e168344 ("perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2")
Reported-by: Farid Zakaria <fmzakari@meta.com>
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/perf/builtin-record.c                   | 40 ++++++------
 .../record+zstd_comp_decomp_multi_record.sh   | 64 +++++++++++++++++++
 tools/perf/util/zstd.c                        |  2 +-
 3 files changed, 86 insertions(+), 20 deletions(-)
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4a5eba498c02..314600812207 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -652,27 +652,14 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		struct perf_record_compressed2 *event = map->data;
-		size_t padding = 0;
-		u8 pad[8] = {0};
 		ssize_t compressed = zstd_compress(rec->session, map, map->data,
 						   mmap__mmap_len(map), bf, size);
 
 		if (compressed < 0)
 			return (int)compressed;
 
-		bf = event;
 		thread->samples++;
-
-		/*
-		 * The record from `zstd_compress` is not 8 bytes aligned, which would cause asan
-		 * error. We make it aligned here.
-		 */
-		event->data_size = compressed - sizeof(struct perf_record_compressed2);
-		event->header.size = PERF_ALIGN(compressed, sizeof(u64));
-		padding = event->header.size - compressed;
-		return record__write(rec, map, bf, compressed) ||
-		       record__write(rec, map, &pad, padding);
+		return record__write(rec, map, map->data, compressed);
 	}
 
 	thread->samples++;
@@ -1590,18 +1577,28 @@ static void record__adjust_affinity(struct record *rec, struct mmap *map)
 	}
 }
 
-static size_t process_comp_header(void *record, size_t increment)
+/*
+ * Called once with data_size == 0 to start a record, then once with
+ * data_size == compressed payload size to finalize and 8-byte-pad it.
+ */
+static size_t process_comp_header(void *record, size_t data_size)
 {
 	struct perf_record_compressed2 *event = record;
 	size_t size = sizeof(*event);
 
-	if (increment) {
-		event->header.size += increment;
-		return increment;
+	if (data_size) {
+		size_t padding;
+
+		event->data_size = data_size;
+		event->header.size = PERF_ALIGN(size + data_size, sizeof(u64));
+		padding = event->header.size - size - data_size;
+		memset(record + size + data_size, 0, padding);
+		return data_size + padding;
 	}
 
 	event->header.type = PERF_RECORD_COMPRESSED2;
 	event->header.size = size;
+	event->data_size = 0;
 
 	return size;
 }
@@ -1610,7 +1607,12 @@ static ssize_t zstd_compress(struct perf_session *session, struct mmap *map,
 			    void *dst, size_t dst_size, void *src, size_t src_size)
 {
 	ssize_t compressed;
-	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed2) - 1;
+	/*
+	 * Reserve space so per-record PERF_ALIGN() padding keeps header.size
+	 * within u16.
+	 */
+	size_t max_record_size = PERF_SAMPLE_MAX_SIZE
+		- sizeof(struct perf_record_compressed2) - sizeof(u64);
 	struct zstd_data *zstd_data = &session->zstd_data;
 
 	if (map && map->file)
diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
new file mode 100755
index 000000000000..42efe7260def
--- /dev/null
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# Zstd perf.data compression/decompression of multi-record data
+
+# SPDX-License-Identifier: GPL-2.0
+
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+recout=$(mktemp /tmp/__perf_test.zstd.rec.XXXXX)
+injout=$(mktemp /tmp/__perf_test.zstd.inj.XXXXX)
+perf_tool=perf
+
+cleanup() {
+	rm -f "${perfdata}" "${perfdata}".old "${perfdata}".decomp "${recout}" "${injout}"
+}
+trap cleanup EXIT TERM INT
+
+skip_if_no_z_record() {
+	$perf_tool record -h 2>&1 | grep -q -- '-z, --compression-level'
+}
+
+collect_z_record() {
+	echo "Collecting compressed record file:"
+	[ "$(uname -m)" != s390x ] && gflag='-g'
+	$perf_tool record -o "${perfdata}" $gflag -z -F max -m 32M --per-thread -- \
+		$perf_tool test -w thloop 5 1 \
+		>/dev/null 2>"${recout}"
+}
+
+check_record() {
+	echo "Checking record did not fail to write data:"
+	if grep -q "failed to write perf data" "${recout}"; then
+		cat "${recout}"
+		return 1
+	fi
+}
+
+check_decompress() {
+	echo "Checking compressed file decompresses cleanly:"
+	if ! $perf_tool inject -i "${perfdata}" -o "${perfdata}".decomp 2>"${injout}"; then
+		cat "${injout}"
+		return 1
+	fi
+	if grep -Eqi "decompress|corrupt|failed to process type" "${injout}"; then
+		cat "${injout}"
+		return 1
+	fi
+}
+
+skip_if_no_z_record || exit 2
+collect_z_record
+check_record || exit 1
+
+# Need >1 record, else the multi-record path wasn't exercised.
+# Skip rather than pass/fail spuriously.
+nr=$($perf_tool report -i "${perfdata}" --stats 2>/dev/null |
+	awk '/COMPRESSED2 events:/ { print $3 }')
+if [ -z "${nr}" ] || [ "${nr}" -lt 2 ]; then
+	echo "less than two compressed records (${nr:-0}), skipping"
+	exit 2
+fi
+echo "Produced ${nr} compressed records"
+
+check_decompress
+err=$?
+exit $err
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 57027e0ac7b6..1955fa2431d1 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -30,7 +30,7 @@ int zstd_fini(struct zstd_data *data)
 
 ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_t dst_size,
 				       void *src, size_t src_size, size_t max_record_size,
-				       size_t process_header(void *record, size_t increment))
+				       size_t process_header(void *record, size_t data_size))
 {
 	size_t ret, size, compressed = 0;
 	ZSTD_inBuffer input = { src, src_size, 0 };
-- 
2.53.0-Meta

