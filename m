Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD7339708;
	Tue, 30 Jun 2026 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782803849; cv=none; b=gK1BtGwNkDBhczHpn9tsuiKobPi+fdK9H4TjAQ2R7l0jcqtAYeJLAhoFrLbdZojJwQVaTWk5o4Pc6gU4UHdRMIQ2WuFxuSoacc8MnA0g4jZFsORcXrG1vu2IANwlWhOlM4agCGZUWVTOVfO3jnuh9eJO1QBVY+WRg6Xxuk41Cis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782803849; c=relaxed/simple;
	bh=PyaHk8gGrmn8EnpAcgNsPUslDmswjRQHoWo6BDI6YoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AusGVMcWWQPmEhoYeYamZfebHxGO/DDmR37olfhTZB6SuKzrwYvXeUOQmFKh1VAicr+WrZ/k6oNru7zv3bI1KMLs8VCtjFFv2HEunoz5lJMw/qDhapopk8guTzk11x1F69Hxry2qYRqjUnFK9UCby90ncuGTTj0z1H2tmqYBG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=UzpzyVEV; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="UzpzyVEV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1782803846;
	bh=kirs1SWImPRrk/cZfOtWeeKrD6r0TJvQyHUoc/Jip18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UzpzyVEVtnXE3c6hmdPzUie6l97BaWtBn+O2xGXiB8ee4wnpbALnWv5g8M2ITePhV
	 f4Q42EkxTiPcLPbBkUXssbQ1csK2swnAiKkes+94PLKAXGzA2X+ngHNVTduPUob2X+
	 HYxyfrcCRsI//5Jkag+Pf9trLK4HDf2BbqMGEPDo=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id DDD31DB24F;
	Tue, 30 Jun 2026 07:17:25 +0000 (UTC)
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
Subject: [PATCH v2 3/3] perf record: Don't store raw data on zstd compression failure
Date: Tue, 30 Jun 2026 07:17:02 +0000
Message-ID: <e38549e990c8aa25f3b6d0e9e02f32368bc46c64.1782743187.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1782743187.git.d@ilvokhin.com>
References: <cover.1782743187.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a ZSTD_compressStream() error, zstd_compress_stream_to_records()
falls back to copying the uncompressed input into the output buffer and
returning its size. That cannot work:

- a COMPRESSED2 payload is always fed to zstd_decompress_stream(), so
  raw bytes placed there can never be read back.

- the record header is never finalized: process_header() is not called
  to write the real header.size and data_size, so they keep their
  initial values and do not match the bytes written.

- the copy is unbounded and can write past the output buffer.

Propagate the error instead.

Fixes: f24c1d7523e6 ("perf tools: Introduce Zstd streaming based compression API")
Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
---
 tools/perf/util/zstd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 04910dfed84f..cbb150b0f807 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include <string.h>
-
 #include "util/compress.h"
 #include "util/debug.h"
 
@@ -71,8 +69,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 		if (ZSTD_isError(ret)) {
 			pr_err("failed to compress %ld bytes: %s\n",
 				(long)src_size, ZSTD_getErrorName(ret));
-			memcpy(dst, src, src_size);
-			return src_size;
+			return -1;
 		}
 		compressed += output.pos;
 		dst += output.pos;
-- 
2.53.0-Meta

