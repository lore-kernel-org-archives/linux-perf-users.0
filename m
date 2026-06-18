Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806E33A029;
	Thu, 18 Jun 2026 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798820; cv=none; b=DDhX34r1PHHV6ibZXSsWBmBG5+3P4uWn/X0GvNM8b0/18ME4BoU2VNEDh03bOoqtV45qbZQgp5fSlVT81sIPhWy8LMBRt969sZU15SXK5SIlbiXMufy7Vb/hSmwIPXDyILViX7HWcfFB6+VDgJQ82UujABw5g4GPf0jkN/yK/Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798820; c=relaxed/simple;
	bh=n+vuyLuer3pWijf6SuzoH3GVrFMiH0PF139J23zJaD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DODSxMXZm7EndMlQgmGKqmfoI7pTIZs3VgmCNlF+jQU4lmOzSf90wAwbuOt8y+hgRFp5f52fh3RQ3PA4m3fBTNeEUc5/kvB3FkNPElM8YqjfxwxFbgHEG7zzFcUI1IC2t2i3uR5wzKFcP3qtb3JVsQXv45ouKqa4hV6XO72S80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=ntjy/t9I; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="ntjy/t9I"
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 1C05FD180E;
	Thu, 18 Jun 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1781798371;
	bh=cynnQGOvMUJBKCypgk5qhucq5/QqqI6UosBZ7jCiCCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ntjy/t9ILvXaRxYt10anYZtsIFXpgD92wdmqhfkBMRe62v82G5ZYRUinNF+CrhWhf
	 HQbGsUX5zqovccthl0iqNH5qj7ADG4K0QT8wb27wFFFIbt8U+OwdEFsDVitlI+SgRT
	 mQQEEuBcH07JelXMn5S+q2BkKrH4KpUjnbfn3n5U=
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
Subject: [PATCH 3/3] perf record: Don't store raw data on zstd compression failure
Date: Thu, 18 Jun 2026 15:59:09 +0000
Message-ID: <6fb9225500ede2bb607a287d6b8b5bea9065b780.1781797544.git.d@ilvokhin.com>
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
index a0f6572ad201..2de777d49ee0 100644
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
 		size = output.pos;
 		size = process_header(record, size);
-- 
2.53.0-Meta

