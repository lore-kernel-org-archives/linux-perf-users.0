Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA72727F3;
	Sun, 10 May 2026 03:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384091; cv=none; b=ZrPoW20E0rSE65Vbk7tzHW80am5ztOcWVCVXiB0djioHV5HHKg9BMC5tMrMXqj6Zz+UJ1+H2XgBgyKwTfX66vXyVLbNeDxhdYm9oaPnD3ZJ1HTkErbv+4AvS+0G5JsJOGXDoGfgNuIlkWI5aPk87KUgaKAs+T4KyPEaZzg+LTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384091; c=relaxed/simple;
	bh=drpqOMoHiMEkjNluijjknlVXT5VXSJxN/q8XhxC6Zzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3dmciLJOrId3AzJhD7Xg4W2pK5kePz0oLOkb3+PqYZ4kt/VA15pSrDuEhLjvPpIhRR7Bv+7Vtx1GywqSJIHKxG7qfPey0LwekyAkL/G0tlDc5PwKhXgogZlvK0dKeAFZzS3jzTyzJnV5IhL3YlzZAkw1GofvJ7D2n1EaE8ulpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSBhSmgT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSBhSmgT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E1C2BCB8;
	Sun, 10 May 2026 03:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384091;
	bh=drpqOMoHiMEkjNluijjknlVXT5VXSJxN/q8XhxC6Zzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSBhSmgTuhXPQzanHqUdKPtT0jZ3MaPw2+geXl36ASM/yY2G2sxg/gJwsBo4X0l3K
	 K0SL/jO0FHCVmeXBMQnd2IoaGzMBHsrK8qEKHQHEpkQg26Z1InaMioKV3dBd4aTVVL
	 YZUO9g0z48XPXgrEtpj0WMkssILqsC7J6f46+as6uR9rZ2OFilNiPPtfQRZacpWMbe
	 av/531eq4jrRFQSnom3bNGcEicCEbXl2Y1TcHxDRCbvVVAL+INyhketTSKJfj11JKf
	 WwJEwgP8hw9jpi1hmHZuvWjzlhMbQJKsKaGscnHYW7Az+xyUiwPcTjwXjNQ8A3W/6q
	 ua9RyHXm0CP1w==
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
Subject: [PATCH 03/28] perf zstd: Fix compression error path in zstd_compress_stream_to_records()
Date: Sun, 10 May 2026 00:33:54 -0300
Message-ID: <20260510033424.255812-4-acme@kernel.org>
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

The error fallback does memcpy(dst, src, src_size) intending to store
uncompressed data when compression fails, but this has three bugs:

1. dst has been advanced past the record header (and potentially
   past earlier compressed records), so the copy writes to the
   wrong offset in the output buffer.

2. src still points to the start of the input, not to the
   remaining uncompressed data at src + input.pos.  On a second
   or later iteration, previously compressed data would be
   duplicated.

3. No check that dst_size >= src_size — if the remaining output
   space is smaller, this is an out-of-bounds write.

Replace with return -1 after resetting the ZSTD compression
context via ZSTD_initCStream(), so the context is usable for
the flush retry in __cmd_record's out_child cleanup.  The -1
propagates through zstd_compress() → record__pushfn() →
perf_mmap__push() to the recording loop, which breaks out and
runs the out_child flush with the reset context.

Also fix two pre-existing issues in the same function:

- Add a dst_size guard before subtracting the record header
  size: if the output buffer is nearly full, the unsigned
  dst_size -= size underflows to a huge value, causing
  ZSTD_compressStream to write past the buffer boundary.

- Check the ZSTD_initCStream() return value and log an error
  if the context reset itself fails.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/zstd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index 57027e0ac7b658a8..fde9907cf4768eff 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -55,6 +55,9 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 	while (input.pos < input.size) {
 		record = dst;
 		size = process_header(record, 0);
+		/* Output buffer full — cannot fit even the record header */
+		if (size > dst_size)
+			return -1;
 		compressed += size;
 		dst += size;
 		dst_size -= size;
@@ -65,8 +68,16 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 		if (ZSTD_isError(ret)) {
 			pr_err("failed to compress %ld bytes: %s\n",
 				(long)src_size, ZSTD_getErrorName(ret));
-			memcpy(dst, src, src_size);
-			return src_size;
+			/*
+			 * Reset so the context is usable for the flush
+			 * retry in __cmd_record's out_child cleanup.
+			 */
+			ret = ZSTD_initCStream(data->cstream, data->comp_level);
+			if (ZSTD_isError(ret)) {
+				pr_err("failed to reset compression context: %s\n",
+					ZSTD_getErrorName(ret));
+			}
+			return -1;
 		}
 		size = output.pos;
 		size = process_header(record, size);
-- 
2.54.0

