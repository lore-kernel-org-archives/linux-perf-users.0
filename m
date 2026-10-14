Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652F4565114
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999267; cv=none; b=JpYmEziOsZOVZ6u5qC+/v4Y3Kz20bMm4J5wLvnwBUcu/8OIoYBPM8cwlz8bBG8lw7p6Ael9qdN7Zn4ZOI6USWFgRnUFV1Wanxf1pl8x3DmXcXEGp871AQeoUE4FGB82ZdvS1ppFoSSWajQCHDjZXOxTB0XGduusp7+2JwJNfS/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999267; c=relaxed/simple;
	bh=UmwoUy2RLKROTQa9nLKvk2PAEQc/mPogh9co6DXStm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZDLireYr1trW+/VQ9DJiV1DX/5CUmbSPpIYomG6hRTXDlCT5qWHcyLT4I0F4W0zu9lmMv3TbDi/E/AVvtA8QtZtdxkAQeIPNihepdiefs+BoIOJLbDEHkxlLds4FKzGlWe6auAUMaAscBTArkHyELlEPUIZilw/ORQIWD3RDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name; spf=pass smtp.mailfrom=intelfx.name; dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b=bvzGbVmm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=intelfx.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intelfx.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=intelfx.name header.i=@intelfx.name header.b="bvzGbVmm"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso3236310f8f.2
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intelfx.name; s=google; t=1791999259; x=1792604059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1nJDWDOJGAldhZBmhrDDp81nykTikheSxGLMobXSOw=;
        b=bvzGbVmmTCBjN1yHm0OW7eSQHeMD9Y5PfDdTkgBA86yLd7rARPD0+ubPtXPMH1a+pS
         y5hQg+mCUMIVBr7LZ2rnrfuEcA+ec4v0QU7VUVfqOI2+5dd4bxM4rwIQdAgpA8N3AcoP
         y/IMI4jffCjlTUj6ZXGq7rRa6Fp2nZ3QF/LAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999259; x=1792604059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1nJDWDOJGAldhZBmhrDDp81nykTikheSxGLMobXSOw=;
        b=X57JJHkMumcUH6m17+3Z5GGCmuxBSC759Cv8c4h6oVZnrc+SmiuYXbyKCtTJ4rXzjL
         mbDMYBDZg4S0KeL3ZnIaBXE7d9Bkp7vzEAnWOAIg4IV+18pKL96ONjLbJJiiqyidW3y4
         gQo4yfD/wIgIrHOdTXLiGSGyk7AZjonbQbdoN0CYov2fSv40O4VCIwehgCfAaI1D2uBc
         nS1DGio3xMbjtV3XAvkf2yPQ1BHoWuGUpU+jTLa5Y+yfoxDaYvp6sQAh5/Pa5vgtvgwG
         d8EBhXJzV7nyPVCw+rAPX/2hHzeCLM2nUl1e/+5oQ0h3kLf4EDfPImW14xmo+vydFJr3
         49WQ==
X-Gm-Message-State: AFq9FYJZtsBmoC/n/4HwBb//V+Zz99SctyrBVDmJMpHsE3bjxYyBDFY/
	566yB5MC8QlYnB0jiGulBFvER/8Bggk6nr13UQ7MXOMRO78aJOWXByuQ+CsYfUBCDPQ=
X-Gm-Gg: AYBFou2dLN8kmo6MlOpjzcoD6qmw8M9L0wxVQeSrSzwIat8VS+nCbza71mTObpqZL5k
	4wfELP1BCpX2PBGd+hjQzuACqqwWKkjUuI9A/J6DcMKbf0FazjL2P4GVnOVTw77giGj0ofOKxD5
	nwNO0zB+xOBOGvGtySHEPqq2AjYdvtLxGS9nK8ZvJX9vRJXJGommNol9zqSQzK/hTGRu940DvS8
	1iDd5EigLMdau8aKN8tpjNMsHmTWVaWBn6fk7T1OrPoCigLnHRX8x/VfUeKM2F4PEQEO5yDL8if
	4F1t124vBgKp7ujBue5D79f5wf77yfkUFQy/9XOT1qUrdkNjidnazxEJqgSMGUwW8fid5ZuWrOu
	pFmGUs5UixVi8xJhw6PDhPv3BKkh6M3ryvmoSWofjEXW/cJcJV9EL6G0nyg/ZO+OlNSjBVXK7JZ
	oorp5CKaF70hh93J4C3pxnQQJKXop3M/bEUu40m4msTZijY1aD1bs/jM3/
X-Received: by 2002:a05:6000:188a:b0:48b:b1a1:a002 with SMTP id ffacd0b85a97d-48dbacf561dmr34815477f8f.24.1791999258718;
        Wed, 14 Oct 2026 10:34:18 -0700 (PDT)
Received: from localhost ([2a00:1358:e0ce:6800::3db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm8994724f8f.29.2026.10.14.10.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:18 -0700 (PDT)
From: Ivan Shapovalov <intelfx@intelfx.name>
Date: Wed, 14 Oct 2026 20:34:07 +0300
Subject: [PATCH 1/4] perf: zstd: zstd_decompress_stream ->
 zstd_decompress_buffer
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-perf-zstd-v1-1-9652727886fa@intelfx.name>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2632; i=intelfx@intelfx.name;
 h=from:subject:message-id; bh=UmwoUy2RLKROTQa9nLKvk2PAEQc/mPogh9co6DXStm4=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0did012TXdDVVdHM2x2aGVTbFF6Mk1wO
 VdTR0xMTzd4Vks4STdSL0x4K3dtb2Uxc2Q4M3B5WE0rZEwvRGxWCituaU4ySlU3dWVVaE4rVjNk
 NVN5TUloeE1jaUtLYkxzdmo4dDdOSGNDVXFIUERma3dzeGhaUUlad3NERktRQVQKcVhuSHlMREp
 vVm5lKzMvc2Y2WW5iUWFTN0wrZXFmSHVjVFRmWEJjWG1mUlFlT24xMTlLTURITmlNK1AwUGh4VQ
 pPNmkxVitUM1ZCYXJTS0c2d20vWGY5NytlUHJVcm03alNRd0EKPUlOQ0sKLS0tLS1FTkQgUEdQI
 E1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=intelfx@intelfx.name; a=openpgp;
 fpr=04DEA27EEF682F17083D892295D5D5F5A5A5E5E5

Existing zstd_decompress_stream() function is a misnomer. Rename that
to zstd_decompress_buffer() to free the name for a future _actual_
streaming decompression function.

Signed-off-by: Ivan Shapovalov <intelfx@intelfx.name>
---
 tools/perf/util/compress.h | 4 ++--
 tools/perf/util/tool.c     | 2 +-
 tools/perf/util/zstd.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/compress.h b/tools/perf/util/compress.h
index ec6c38129e248..e7aa89d31fc6f 100644
--- a/tools/perf/util/compress.h
+++ b/tools/perf/util/compress.h
@@ -57,7 +57,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 				       ssize_t process_header(void *record, size_t dst_size,
 							      size_t data_size));
 
-size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
+size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size,
 			      void *dst, size_t dst_size);
 #else /* !HAVE_ZSTD_SUPPORT */
 
@@ -82,7 +82,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data __maybe_unused,
 	return 0;
 }
 
-static inline size_t zstd_decompress_stream(struct zstd_data *data __maybe_unused, void *src __maybe_unused,
+static inline size_t zstd_decompress_buffer(struct zstd_data *data __maybe_unused, void *src __maybe_unused,
 					    size_t src_size __maybe_unused, void *dst __maybe_unused,
 					    size_t dst_size __maybe_unused)
 {
diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
index 25c9b378aa163..d7956cd75c26d 100644
--- a/tools/perf/util/tool.c
+++ b/tools/perf/util/tool.c
@@ -101,7 +101,7 @@ static int perf_session__process_compressed_event(const struct perf_tool *tool _
 		goto err_decomp;
 	}
 
-	decomp_size = zstd_decompress_stream(session->active_decomp->zstd_decomp, src, src_size,
+	decomp_size = zstd_decompress_buffer(session->active_decomp->zstd_decomp, src, src_size,
 				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
 	if (!decomp_size) {
 		munmap(decomp, mmap_len);
diff --git a/tools/perf/util/zstd.c b/tools/perf/util/zstd.c
index d98014902f012..af113660d1ce0 100644
--- a/tools/perf/util/zstd.c
+++ b/tools/perf/util/zstd.c
@@ -104,7 +104,7 @@ ssize_t zstd_compress_stream_to_records(struct zstd_data *data, void *dst, size_
 	return -1;
 }
 
-size_t zstd_decompress_stream(struct zstd_data *data, void *src, size_t src_size,
+size_t zstd_decompress_buffer(struct zstd_data *data, void *src, size_t src_size,
 			      void *dst, size_t dst_size)
 {
 	size_t ret;

-- 
2.55.0.8.g37e2a0019f

