Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604130;
	b=qzLL6dAQkrx5D1NTCO0c5O+o+wpef+TPGaO11Yhs26/HA3oMmDcVi/TB8UmMmH6+cyO2
	 5qfSTQBTMSAfbfFjdNHuCffjuXwDcpti4A0sw1lT8V29iF7EDd5oX4sLxfcCeUe4VIfZx
	 Ipfu7lTlg5Dmspogua0iHYk/mPe9zBqiFqyce/S1tucSaYvSM6rOmtQrFCBTiBRFFJCAr
	 1g2YRqH/pLvOBL/s7dRKLXFAXe1obF1JcbxysC3ImH92jXpNyK7ZILO7Z9uaxcUVM6Xcq
	 z4yTcGcK11n4iQVN8m954T0UwXWq3FLiz7Vu6Ykv1eS40ab5oCMiUL6L5zNE7H1hKTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604130;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=bvoS+hUWcOEV2fjXabuBqdvvjcqr2Q7oZBLquTFu6aw=;
	b=xCYRw+RcKzMxdrKaFhaeSf3EPvbtc4N/OlVcpBa8MN0utoydfvPppWT02pDCkAhKfJtu
	 gOeTPRc+yKc2EkmweGpjfAD9BK1Uq81bGAIw5eLNn9fjksA4WkPTQ4wT97A0fK1IsqE7B
	 Bodu9vnCIvqYUyJoDpG7+yr+4JZbojGDU6CYz9oww8IC4P1T6mnVAkunB1FJm39ftURwy
	 nLhWBzSdMPjse9Aa1yivUI35GWOZFqNeGcXaIYBLWGw1Dm+4kn9co9pwRoCiiwHrRgOTd
	 n1+1dmoMf9fROriFEUEtt4nUpkae9VQR13AOYR4dw6JabXMJnM4lhQcumJxTU5EjIyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c1qMJUl7;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A560A2637
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C4A560A2637
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=c1qMJUl7
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac8f449d1bso1086217a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604130; x=1795208930; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvoS+hUWcOEV2fjXabuBqdvvjcqr2Q7oZBLquTFu6aw=;
        b=c1qMJUl7UpCv8kt1G5jdiA6m4CULxe80pST/LV+/3CxTxyQUvbZZljAZqyQvGjMnlK
         ZGs6ppoNibgf8d3LumsPZo+637Iz2YKemPyUAM/Q0WpBOt+FyNBULSvT9qhMb4B8DtLf
         3CXznnMcXiYgfla+4LzEv8lgEcq7l2VGEAdHWkIsceWBDohAWPidnidT3a+qG9Vqbtyi
         7FOsomCIKnZk1WCbr7ohH9bNd7INQscu/s+f0AXahd0hQyIowQt5BHPdM6mZfgDcs5FT
         2zA62OYv+LkZdigyfN3YmDgPjKk9mlTrL5FHqlX3exRCZpC+Du1rUvnOfAhpUTwAJbuQ
         Aiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604130; x=1795208930;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvoS+hUWcOEV2fjXabuBqdvvjcqr2Q7oZBLquTFu6aw=;
        b=ACQt6sHa/lwICFnjnAS7KGTCQ1ahJNOK02Qbdv5uJ/vnahSRNof8awva+ULi+fTent
         ofAuW2s61bdZAdrEOU1mKJVI/YEsT0leQmXaHANDOmLKr9Tbb30Sp/HbUegkoEgMz5SW
         YA2WReKLjeS5hdPZJIkZ88MEp6/SHL06HoDLiUXRFECAFqZwLIowilCm2hxHolrySO9U
         2ar1xlYleheMN/EjlXlwm9czs7hPPhnWHkvQ8+tYGqZc/fseuz/ymW1sFUWJRXeatXn3
         C4Gx06zWEQBVa4hn1cMSy464YCIxF4RRZaCNQKuZb/9Zl73ZLmfkOH4SeqxYrkPMBU0s
         30ig==
X-Forwarded-Encrypted: i=1; AL+hErHuZLaTbu8l8tz4RUt4UhRbhjopCDfet/3YZpNT943lzPCZBti1f+PLRQrdv2nv6r+PGdanEN2nFYY4BFdJYO0Q@vger.kernel.org
X-Gm-Message-State: APuU4Z98q3ypHSDOBTwb2/Zfj+GHF3Q2rYjg9SCPBTkXDDJm+FU58DYW
	EFEEJjtX7AheHQOfvTIpzFOrfctIji42JWy8kTTISrZhdIB+ySBQK3akcRv+3Xo5TPeo/R78c4K
	MI7oxTe21sw==
X-Received: from pjhh16.prod.google.com ([2002:a17:90a:510:b0:3ab:3656:a8d5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0d:b0:39e:4c7f:7308
 with SMTP id 98e67ed59e1d1-3b1b0b506e8mr3231134a91.31.1794604129479; Fri, 13
 Nov 2026 13:08:49 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:18 -0800
In-Reply-To: <20261113210822.3112700-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113210822.3112700-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261113210822.3112700-7-irogers@google.com>
Subject: [PATCH 06/10] perf jevents: Add --compress=lzma block compression backend
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an 'lzma' block-indexed string compression backend to jevents.py
using Python's standard-library lzma module (imported lazily) to
compress each ~8 KiB string block independently as a raw LZMA2 stream
(FORMAT_RAW + FILTER_LZMA2, dict_size=64 KiB) decoded on demand via
liblzma's lzma_raw_buffer_decode() in pmu-events-string.c.

This provides random-access per-block string decompression indexed by
(block_id << 16) | sub_offset on builds where liblzma is enabled without
libzstd or zlib. On x86, --compress=lzma shrinks pmu-events-string.o
from ~6.90 MB to ~819 KB.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index ec7d460a32b6..a7fad9bbf7b4 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -238,10 +238,54 @@ def _compress_blocks_zlib(blocks: Sequence[bytes]) -> Optional[CompressedStringO
   )
 
 
+def _compress_blocks_lzma(blocks: Sequence[bytes]) -> Optional[CompressedStringOutput]:
+  """Compress blocks using stdlib lzma raw LZMA2 streams."""
+  try:
+    lzma_mod = importlib.import_module('lzma')
+  except ImportError:
+    return None
+
+  dict_size = 1 << _BIG_C_STRING_BLOCK_SHIFT
+  filters = [{'id': lzma_mod.FILTER_LZMA2, 'preset': 6, 'dict_size': dict_size}]
+  compressed_blocks = [
+      lzma_mod.compress(block, format=lzma_mod.FORMAT_RAW, filters=filters)
+      for block in blocks
+  ]
+
+  decompress_fn = f"""static bool decompress_block(const unsigned char *src, uint32_t src_len,
+\t\t\t     char *dst, uint32_t dst_len)
+{{
+\tlzma_options_lzma opt = {{
+\t\t.dict_size = {dict_size}U,
+\t\t.preset_dict = NULL,
+\t\t.preset_dict_size = 0,
+\t}};
+\tconst lzma_filter filters[] = {{
+\t\t{{ .id = LZMA_FILTER_LZMA2, .options = &opt }},
+\t\t{{ .id = LZMA_VLI_UNKNOWN, .options = NULL }},
+\t}};
+\tsize_t in_pos = 0, out_pos = 0;
+\tlzma_ret ret;
+
+\tret = lzma_raw_buffer_decode(filters, NULL, src, &in_pos, src_len,
+\t\t\t\t     (uint8_t *)dst, &out_pos, dst_len);
+\treturn ret == LZMA_OK && in_pos == src_len && out_pos == dst_len;
+}}
+"""
+  return CompressedStringOutput(
+      name='lzma',
+      c_headers=['<lzma.h>'],
+      compressed_blocks=compressed_blocks,
+      extra_c_decls='',
+      decompress_c_fn=decompress_fn,
+  )
+
+
 _COMPRESS_BACKENDS: Dict[
     str, Optional[Callable[[Sequence[bytes]], Optional[CompressedStringOutput]]]
 ] = {
     'none': None,
+    'lzma': _compress_blocks_lzma,
     'zlib': _compress_blocks_zlib,
 }
 
-- 
2.56.1.703.gf848ed807c-goog

