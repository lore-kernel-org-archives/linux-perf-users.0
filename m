Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B674EDCB4
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999270; cv=none; b=p+t07UKxNPIP6+NJNRVp1YY5sEcBWmI7UyELu5r5VDjrQb0gb54vYeZSznfEd7b60RrGupAFB/xxKgcPCxvd0fH0ijQhqIygnf4Aolu7w6yMZSqbv/4gxZ4/os5QsTW29jLBUfL+QxkIrrGPeTzT0d2OzDNs12n9o1ZYDaNQue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999270; c=relaxed/simple;
	bh=lAl1Sz6UtxNzLv/NGEiZAxIbxVN+cdv3/XLoEIh0W9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CNjh9wratI6z5o7+1AtO8/CjiQb3Oauv/ILQ3YL+cYExr/8PMNEzrX4wu7xPUJjeLPrYiUC3nxnnJU1sLIreg1cASlItk8SNuGJHqtnVfITt1fd87aGIqZjoNOCs1V3QmvIR31aXEytLQZNEq0plO9JreTU1pgmSXA27Pspi54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=ZHgT4T9a; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="ZHgT4T9a"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a02667ccebso32311665e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 10:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1791999263; x=1792604063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4bPqAU0YcptqOfDY2eaFYdAmTQF/YWW9ZR1qf0BXew=;
        b=ZHgT4T9a7wUwsDyc6iSQtH7687RS+g2JAm3MVvZPIZW3emMgIFyaKJ0vUyaDX0AbiX
         vHThg5YqdYIu7KBHuUkeOJcmd9Vj7abtsCDoKK8Xh2ca8JpjkLhnc7m2mG2FpBO+rOpS
         6rH+6mwjhx75Rq30sOK23h8lh8OBiLVa9EWUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999263; x=1792604063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4bPqAU0YcptqOfDY2eaFYdAmTQF/YWW9ZR1qf0BXew=;
        b=dZE+kBisfcKlUNt5kgQuweYumHHlXL3wvoQe9uz7NZ8j+qZcCDXmypGV73QS8W0rMc
         zuxs9egtPDFZ/f1gmC+EwV+mn5FBy3jEAbnmI7g9hLarG5YbtcQ7gGDVDPwRwvte9FKs
         p96gsiCrJJFRkZC1Uy0/RxOIf9Excg7OAqon0/XB+GOErgFf7PK+KpIK+JXVTwCvSPGW
         Y8YFWmpcr7iqESFD2Ttfpwq6X7XJhBmLNIKhUKzSI6468OrJ5vc9NWqO0rcGwSFBdUEQ
         WQO14KSejQQcuNlhzNMzdCfNwDjd22AnxY2PtNQHKJ2R1iND/i/3ghUzv2L48VoVzbAJ
         tKKw==
X-Gm-Message-State: AFq9FYIgfj5VHGfvcVVLurAYftH1KCkS8ZCRL7jbGo53mOqLlSS3jk7r
	f5zpohF9haOcrkcVZc+UGxevd6uJ5jRa1tgx0XFKCBMrpiW+nCP5KLQ5ziKw3uhUo28aLyhXC5r
	7mv6FedgB8g==
X-Gm-Gg: AYBFou1mZLcvZc2lZxIpBmy3PYz2UPrx7DVUrwVJ6snDXsw2PAe903DGMP96+wFnpdD
	7LjHNfy3e0zQHhJcSjd9Ik/DZgsg1yDeTxZ8eFM3ySKiW4fQDFqq7WfpwDYiK2979mpZvrgtf6s
	an9UIFyiGxZ7hzf+k9IS/zcAYfZyVwVh4jSn97vNcLmbhxl+cZv/Q6rhU+TKSsYeo6qisWdLtGO
	jnXpFUN1EUCKsJG8TrJJmSmqca3GLWeQWuxuE0eq5QAV3gpi71k0we2sEbupaiaSQRXyvdRygG1
	cj76+2lETUy/QnQ8UDcn7i6elWuiF/XqM8wUeHqsGIEbIllsnaBDSnCXCC7BeglzDJfkQeR85oV
	6UtbQwz7a6np+gtKYds/kDk92WiMdU0w5V7Os96SBiZO6nPbsY5r296mCEvyZdnrK/7+34vSaO4
	HE5U/uPD2zfNYPcX/bZim+KhkryJBi7V0hWDd0BMD56wjGA3h+Yq4q/zZr
X-Received: by 2002:a05:600c:6215:b0:4a0:eae0:b30e with SMTP id 5b1f17b1804b1-4a18e4ca157mr299272915e9.22.1791999263451;
        Wed, 14 Oct 2026 10:34:23 -0700 (PDT)
Received: from localhost ([2a00:1358:e0ce:6800::3db])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd67a080sm9558415e9.3.2026.10.14.10.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:22 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
Date: Wed, 14 Oct 2026 20:34:09 +0300
Subject: [PATCH 3/4] perf: zstd: add streaming decompression and format
 probe functions
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-perf-zstd-v1-3-9652727886fa@intelfx.name>
References: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
In-Reply-To: <20261014-perf-zstd-v1-0-9652727886fa@intelfx.name>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ivan Shapovalov <intelfx@intelfx.name>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4572; i=intelfx@intelfx.name;
 h=from:subject:message-id; bh=lAl1Sz6UtxNzLv/NGEiZAxIbxVN+cdv3/XLoEIh0W9E=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdDVVdHM2x2aGVTbFF6Mk1wO
 VdTR0xMTzd4V2UveVBNWkZMdGhCOUxlL1l1dXZ0VStCR256T1huCi96bXVIWXM0dm52UlFvMTZ0
 bzVTRmdZeExnWlpNVVdXM2ZlbmhUMmFPMEhwa09lR1hKZzVyRXdnUXhpNE9BVmcKSWd2dU0velB
 XUDZ4Y21kQ3Y5V0tMVzN6Wm5hWFBMT01QWC9zZ01qMkNYNkxuM0oxWlUwNnlQQlB6MW14Vk01RQ
 o2RmVBZ1dpVTJDWlhydm5lejJZYXh4dE1qSFM1WUpQMDRpMDdBQT09Cj1wMENhCi0tLS0tRU5EI
 FBHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=intelfx@intelfx.name; a=openpgp;
 fpr=04DEA27EEF682F17083D892295D5D5F5A5A5E5E5

Add an actual streaming zstd decompression (fd->fd) entry point,
plus a file->fd wrapper and a helper to detect zstd magic on a file
for compressions[] in dso.c.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 tools/perf/util/compress.h |  18 ++++++++
 tools/perf/util/zstd.c     | 104 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index e7aa89d31fc6f..fd6b541358bb6 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -59,6 +59,9 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 
 size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size,
 			      void *dst, size_t dst_size);
+int zstd_decompress_stream(struct zstd_data *data, int input_fd, int output_fd);
+int zstd_decompress_to_fd(const char *input, int output_fd);
+bool zstd_is_compressed(const char *input);
 #else /* !HAVE_ZSTD_SUPPORT */
 
 static inline int zstd_init(struct zstd_data *data __maybe_unused, int level __maybe_unused)
@@ -88,6 +91,21 @@ static inline size_t zstd_decompress_buffer(struct zstd_data *data __maybe_unuse
 {
 	return 0;
 }
+
+static inline int zstd_decompress_stream(struct zstd_data *data, int input_fd, int output_fd)
+{
+	return -1;
+}
+
+static inline int zstd_decompress_to_fd(const char *input, int output_fd)
+{
+	return -1;
+}
+
+static inline bool zstd_is_compressed(const char *input)
+{
+	return false;
+}
 #endif
 
 #endif /* PERF_COMPRESS_H */
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 3af8910bb87cf..982655a1f1a51 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -1,7 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <errno.h>
+#include <fcntl.h>
 #include <string.h>
+#include <unistd.h>
 #include <linux/perf_event.h>
+#include <internal/lib.h>
 
 #include "util/compress.h"
 #include "util/debug.h"
@@ -172,3 +176,103 @@ size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size
 
 	return output.pos;
 }
+
+int zstd_decompress_stream(struct zstd_data *data, int input_fd, int output_fd)
+{
+	ssize_t ret;
+	bool unflushed = false;
+	char buf_in[ZSTD_DStreamInSize()];
+	char buf_out[ZSTD_DStreamOutSize()];
+	ZSTD_inBuffer in = {};
+	ZSTD_outBuffer out = {};
+
+	ret = zstd_init_dstream(data);
+	if (ret < 0)
+		return ret;
+
+	for (;;) {
+		if (in.pos == in.size) {
+			/* out of input, read more */
+			ret = read(input_fd, buf_in, sizeof(buf_in));
+			if (ret < 0) {
+				pr_err("zstd: failed to read() %zu bytes: %s\n",
+				       sizeof(buf_in), strerror(errno));
+				return ret;
+			}
+			in = (ZSTD_inBuffer) {
+				.src = &buf_in,
+				.pos = 0,
+				.size = ret,
+			};
+		}
+
+		if (in.pos == in.size && !unflushed) {
+			/* out of input, out of file, and nothing to flush, exit */
+			break;
+		}
+
+		out = (ZSTD_outBuffer) {
+			.dst = &buf_out,
+			.pos = 0,
+			.size = sizeof(buf_out),
+		};
+		ret = ZSTD_decompressStream(data->dstream, &out, &in);
+		if (ZSTD_isError(ret)) {
+			pr_err("zstd: failed to decompress %zu bytes into buffer of %zu bytes (wrote %zu): %s\n",
+				in.size, out.size, out.pos, ZSTD_getErrorName(ret));
+			return -1;
+		}
+		unflushed = ret > 0;
+
+		ret = writen(output_fd, out.dst, out.pos);
+		if (ret < 0) {
+			pr_err("zstd: failed to write() %zu bytes: %s\n",
+			       out.pos, strerror(errno));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+int zstd_decompress_to_fd(const char *input, int output_fd)
+{
+	int input_fd = -1;
+	int ret;
+	struct zstd_data data;
+
+	input_fd = open(input, O_RDONLY);
+	if (input_fd < 0) {
+		pr_err("zstd: failed to open(%s): %s\n", input, strerror(errno));
+		return -1;
+	}
+
+	ret = zstd_init(&data, ZSTD_CLEVEL_DEFAULT);
+	if (ret < 0)
+		goto err;
+
+	ret = zstd_decompress_stream(&data, input_fd, output_fd);
+
+err:
+	zstd_fini(&data);
+	close(input_fd);
+	return ret;
+}
+
+bool zstd_is_compressed(const char *file)
+{
+	int fd = open(file, O_RDONLY);
+	const uint32_t magic_le = htole32(ZSTD_MAGICNUMBER);
+	char buf[4];
+	ssize_t rc;
+
+	if (fd < 0) {
+		pr_err("zstd: failed to open(%s): %s\n", file, strerror(errno));
+		return -1;
+	}
+
+	rc = read(fd, buf, sizeof(buf));
+	close(fd);
+	return rc == sizeof(buf) ?
+	       memcmp(buf, (const char *) &magic_le, sizeof(buf)) == 0 : false;
+}

-- 
2.55.0.8.g37e2a0019f

