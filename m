Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EE831079B;
	Thu, 18 Jun 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798820; cv=none; b=YnuAeaI4WSi8pkJCkP6RjUnebMhvmEYgWON8dPSepf1m/iKe+9jWu5jxCa04zooKnIHSCsz1qfGRePImnvAVed4tEpzNGDir9/eXGMInwxila4+Oz5wBkJqNfVXqx7KtcSwwYWVp5rXLkDxO5IB2wg1UbnihLyMYQVQ6u3P9ffs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798820; c=relaxed/simple;
	bh=9q/iOv+VZn0k6RR4pQ4ZjagOUrxXhaDIsDsXhZ5OYWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cenTnnm1DqfiK04b693x32tYpL9qGZIVczM7ybYQLSZM6RXupwXTIbykBUyQwuZk/tKrodLczl0PJNjR25xw11KsT4DekLR1M53VlizEX+KhdvTIyDMrRhJCx975nEKNT8WNxTb13ltruNdLi8yN8EMOCT4mp2o0gxKAvtlTQa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ZS/p5lIu; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ZS/p5lIu"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id CCBC3D180A;
	Thu, 18 Jun 2026 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1781798371;
	bh=GMrlM71V5NN4Ct486vom2tEp4snFIhVpO8vmRw31gtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZS/p5lIuVI7E9DjUMPQC4OZUdF4KqUGk3uLuZFv2JeLgr+QyOXJ+y/O2tUgbE/tRV
	 +3juIUyf9rKHI/mxs6vBoLmw6wetBLqbXz1PAuJncnyAMYblP2os9mSZUY13VE9zTO
	 +IduJMluOSSw4x2D5eKyzEQfiWUhMBBpKJf0I6ew=
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
Subject: [PATCH 2/3] perf record: Avoid overrunning the zstd output buffer
Date: Thu, 18 Jun 2026 15:59:08 +0000
Message-ID: <7860259ac13e539dfb907489be29d0487d36aeb8.1781797544.git.d@ilvokhin.com>
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

zstd_compress_stream_to_records() compresses one mmap chunk into 'dst'
as a chain of records, decrementing 'dst_size' as each record's header
and compressed payload are written, but it never checks that the space
left can still hold a record before writing one.

When the compressed output does not fit in 'dst', 'dst_size -= size'
underflows ('dst_size' is a size_t), the output size is then taken as
max_record_size again, and ZSTD_compressStream() writes past the end
of 'dst'.

Bail out when the remaining 'dst_size' can no longer hold a full record
(header + max_record_size + 8-byte alignment) rather than writing past
'dst'.

Fixes: f24c1d7523e6 ("perf tools: Introduce Zstd streaming based compression API")
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/perf/util/zstd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 1955fa2431d1..a0f6572ad201 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -32,7 +32,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 				       void *src, size_t src_size, size_t max_record_size,
 				       size_t process_header(void *record, size_t data_size))
 {
-	size_t ret, size, compressed = 0;
+	size_t ret, size, compressed = 0, hdr_size = 0;
 	ZSTD_inBuffer input = { src, src_size, 0 };
 	ZSTD_outBuffer output;
 	void *record;
@@ -53,8 +53,14 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 	}
 
 	while (input.pos < input.size) {
+		if (hdr_size &&
+		    dst_size < hdr_size + max_record_size + sizeof(u64)) {
+			pr_err("failed to compress: output buffer too small\n");
+			return -1;
+		}
 		record = dst;
 		size = process_header(record, 0);
+		hdr_size = size;
 		compressed += size;
 		dst += size;
 		dst_size -= size;
-- 
2.53.0-Meta

