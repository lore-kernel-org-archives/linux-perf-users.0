Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604129;
	b=RnZHoPmnb9woRFPJ6ude85I0Pd9E2jaA/wsWZ84E0KcbosFFFjoZoR00B710R01Wsr8y
	 vmFlY3mQY5/3DgVSdcNgHmkdFoffSFGsU2dDhkN8IerXf6pKwTyzrB1jdw/b1DKOwJEB9
	 eDBJ05ivYv5IlXiXUKdwcQ+fi8DAdRWIXOpYKfxDMAbRVnN3WvbxXMLUg2vf/jqam/gJV
	 LnUl35V1ZipfIW6vFUcIjLLCgyoZr72zkVuoz96pnauMhI/12eFofIAKcJkVPJOBdRr1j
	 i3Z4Nym0OA1xb/VGUWuahd/bmVPtLqa95XDZyCWtblkf0Y+pYiRAVAxQjKK+Nl6sE1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=YziRX9kGa5FVZVCB6mEvSV6/aWfkTS6yUXdKQ9bw6bY=;
	b=baDlDwvppKVTdROBF5PAsj6+I2h8aGZ0nU45wO5VfzP4BtDQUBPo6dA1vVRKOUTvFiFO
	 MIaUoV/+oaZPSKsd4Xbiq4XnoGaU/p1qH18nA1CIZy3Jdim2kxJu0CjFb11SuItRVOp/r
	 arU/8ZATIGf/ZVOQf9wFsXlX3qNXpMVlhhVDeq2BXInZsi0Qqn0YgEmcDW8YJsGGJCIzL
	 BBAG7jbj6qqjOvGRc/leZSq/8qbxd05oe/z8hPN8K2phG9Ss1GBtzZDF4TYbEsDV3mnfi
	 a+5Dw4FDLnmznfv1oaLT7CKrnOrL1vK798YQwrT9Ftsg2Gjat8fuz3aKlby9Cjj7akQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eJcRu3ra;
	arc=none smtp.remote-ip=209.85.216.71
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2F360A3821
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 21:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2F360A3821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eJcRu3ra
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b18741aaf8so2240586a91.2
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 13:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794604127; x=1795208927; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YziRX9kGa5FVZVCB6mEvSV6/aWfkTS6yUXdKQ9bw6bY=;
        b=eJcRu3ras/+RaTPADVfqafO/B/yNI0pFl3T4CdnTrSP7u83xpn27KCdmQqe2KxJnrh
         Lfc7jqaVrgXF3pbGsZMbXLxXRtQ75i0b0N0lsQrFN4f9Rua+cgXMPIVcHSI0WqqOzglM
         6n0osR0UYcv2szPgk8Reanjtjylh4bjCOn9Rl1/Qams0w7o8tYZNPm9U8ptyqHocqsJ/
         bUAZPWOXC4HeGqRPa5g7z6yn+O+de80nlwLVcfWG6OzQp9VHki1dtXgJHF8+VkAfEI3i
         FWvT1NDoUlartRk6Xko7gpFWPEQp3A7nR8igvJ4+Pf9Ub+5drsNK2ORIdeOlWxJQOF+D
         y6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604127; x=1795208927;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YziRX9kGa5FVZVCB6mEvSV6/aWfkTS6yUXdKQ9bw6bY=;
        b=Jp6dvogDIq99iIlwZA8yXC2Lyy74kSRyJCJuFp66Bq89HKkBhYNjq36ZSwemnHsCB9
         TCSSv0lUMbejQYUodi6DYr9jZ3Z1tkbPstnCopgS8Jl8v/UP1tL59LAV7gYuJkAMsYgU
         w8Vj6AljlcWa6/GYX6+7mixcmEx5kKJ+YLA/52+6nd90McITatwEyxc/TI72ei48ljFC
         FP4LE6RoqT3feJYm05CjkZphR2Uf/U4z5CRVIUZeLhN8E0y9uPwTUo46GLlSmBEMIxPn
         zVgc7gvEK7EI1efk4+kF+AQBt6h7V1y3sLtzxTDf2cmb1Wqd8/57yDXTXAsSqdKEMrK+
         Lpjw==
X-Forwarded-Encrypted: i=1; AL+hErHqHyenaLhWQhCNjGMWnTrbwPi0kduG2PjgZZuI0msOXsYBBXaIotQRqNicM5JEXoNSU6FfrxbKZDT/SEZ3io/X@vger.kernel.org
X-Gm-Message-State: APuU4Z+wwu9Rj8IpWNkfPo6ouAsT/5a1wXTsjAmA/pFOBMNCt0r115+4
	Ifa1JgAM7+/iMPyCZj1b7+owIjYCkJ0Wx7oqq4C/sFCpItrxdpK3sH9dbUEqMO6J0db+1mYNQiK
	tuja1Ulo3zQ==
X-Received: from pjbez11.prod.google.com ([2002:a17:90a:e14b:b0:3b1:127a:9e0d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c8d:b0:3ab:e588:c2a8
 with SMTP id 98e67ed59e1d1-3b1b0d8a4d0mr3794865a91.64.1794604127218; Fri, 13
 Nov 2026 13:08:47 -0800 (PST)
Date: Fri, 13 Nov 2026 13:08:17 -0800
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
Message-ID: <20261113210822.3112700-6-irogers@google.com>
Subject: [PATCH 05/10] perf jevents: Add block-indexed string packing and --compress=zlib
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Kan Liang <kan.liang@linux.intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Compressing big_c_string (~6.9 MiB on x86) as a single monolithic stream
would force perf to allocate and decompress megabytes of unused CPU
models' strings on startup just to look up a single event or metric,
whereas compressing each short string individually suffers from poor
compression ratios and per-string framing overhead.

Introduce "block-indexed string compression" via a --compress=<formats>
option to jevents.py (defaulting to 'none'):
- Sorted, non-folded BigCString byte records are packed sequentially
  into ~8 KiB blocks without splitting any multi-field event or metric
  record across a block boundary (with suffix-folded strings inheriting
  their parent record's block and intra-block offset plus suffix delta).
- Each block is compressed independently into big_c_string_blob[],
  indexed by big_c_string_block_offsets[] and big_c_string_raw_lens[],
  while sharing a common dictionary across blocks so ~8 KiB blocks
  retain high compression ratios.
- Each uint32_t string offset in pmu-events.c is encoded as
  (block_id << 16) | sub_offset (supporting up to 65,536 blocks of up to
  64 KiB each).
- At runtime, pmu_events__get_string(offset) splits offset into block_id
  and sub_offset and uses a lock-free atomic per-block pointer cache
  (big_c_string_cache[], freed at exit via a destructor) to decompress
  only the touched ~8 KiB blocks on demand. Untouched CPU models' blocks
  remain compressed in .rodata at zero heap or CPU cost.

Why ~8 KiB was chosen as the target block size:
- Smaller blocks (1-4 KiB) pay heavily for per-block entropy/frame
  headers and the 14 B/block index and pointer-cache tables (+22% to
  +128% larger .rodata across all architectures, and up to ~9,000 cache
  slots at 1 KiB vs ~1,000 at 8 KiB).
- Larger blocks (16-64 KiB) sit past the knee of the compression curve
  (<15% incremental .rodata savings with a shared dictionary), while
  forcing each O(log N) binary-search probe in find_event/find_metric to
  decompress and fault 2-8x more bytes and anonymous heap pages just to
  inspect a single ~150 B record.
- Targeting 8 KiB (~2 pages per decompressed block) also leaves ample
  headroom below the 64 KiB 16-bit sub_offset ceiling so single
  multi-KiB descriptions and metric expressions (up to ~2.4 KiB today)
  never need to be split across blocks.

Keep compression imports completely lazy via importlib.import_module()
so jevents.py retains zero top-level compression library dependencies,
and leave single-file generation (such as empty-pmu-events.c)
uncompressed.

Implement the initial 'zlib' compression backend using raw Deflate
(wbits=-MAX_WBITS) paired with an automatically constructed <= 32 KiB
preset dictionary of frequent field and phrase substrings. On x86,
--compress=zlib shrinks pmu-events-string.o from ~6.90 MB to ~716 KB
(~9.6x reduction) while only decompressing touched 8 KiB blocks on
demand.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c |   5 +
 tools/perf/pmu-events/jevents.py         | 441 ++++++++++++++++++++---
 2 files changed, 402 insertions(+), 44 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index c40fa30d7235..46a32a4cb9d6 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -11,6 +11,11 @@
 #include <string.h>
 #include <strings.h>
 
+/*
+ * Offset passed to pmu_events__get_string(): a flat byte offset into
+ * big_c_string[] when uncompressed, or (block_id << 16) | sub_offset into
+ * ~8 KiB compressed blocks when built with block-indexed string compression.
+ */
 struct compact_pmu_event {
 	uint32_t offset;
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 783ce2331f44..ec7d460a32b6 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -2,13 +2,15 @@
 # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
 """Convert directories of JSON events to C code."""
 import argparse
+import collections
 import csv
+import importlib
 import json
 import metric
 import os
 import sys
-from typing import (Callable, Dict, Optional, Sequence, Set, Tuple)
-import collections
+from typing import (Callable, Dict, NamedTuple, Optional, Sequence, Set, TextIO,
+                    Tuple)
 
 # Global command line arguments.
 _args = None
@@ -85,26 +87,325 @@ _C_ESCAPE_TABLE = str.maketrans({
 })
 
 
+_BYTE_TO_C_OCTAL = tuple(
+    chr(b) if 32 <= b <= 126 and b not in (0x22, 0x3f, 0x5c) else f'\\{b:03o}'
+    for b in range(256)
+)
+
+# Block-indexed string compression splits BigCString into ~8 KiB record-aligned
+# blocks compressed independently (often with a shared preset/trained
+# dictionary) so pmu_events__get_string() only decompresses touched blocks on
+# demand rather than decompressing all architectures/models upfront.
+# Each uint32_t offset is encoded as (block_id << 16) | sub_offset:
+# - low 16 bits hold the intra-block byte offset (0..65535)
+# - high 16 bits hold the block index (0..65535)
+_BIG_C_STRING_BLOCK_SHIFT = 16
+# 8 KiB sits at the knee of the compression vs. random-access curve: smaller
+# blocks (1-4 KiB) pay 22-128% more .rodata for per-block entropy headers and
+# index entries, while larger blocks (16-64 KiB) yield diminishing compression
+# gains (<15%) at 2-8x higher decompression CPU and heap page-fault cost per
+# O(log N) binary-search probe, and 8 KiB leaves ample headroom below 64 KiB
+# so multi-KiB records never need splitting across blocks.
+_BIG_C_STRING_TARGET_BLOCK_SIZE = 8192
+
+
 def bytes_to_c_literal(b: bytes) -> str:
   """Convert UTF-8 bytes (with NUL terminators) to a C string literal body."""
   return b.decode('utf-8').translate(_C_ESCAPE_TABLE)
 
 
+def write_c_octal_array(out_file: TextIO, name: str, data: bytes) -> None:
+  """Emit a static const unsigned char array initialized as octal string literals."""
+  out_file.write(f'static const unsigned char {name}[] =\n')
+  if not data:
+    out_file.write('\t"";\n')
+    return
+  for i in range(0, len(data), 64):
+    chunk = data[i:i + 64]
+    escaped = ''.join(_BYTE_TO_C_OCTAL[b] for b in chunk)
+    out_file.write(f'\t"{escaped}"\n')
+  out_file.write(';\n')
+
+
+class CompressedStringOutput(NamedTuple):
+  """Artifacts produced by a block compression backend for pmu-events-string.c."""
+  name: str
+  c_headers: Sequence[str]
+  compressed_blocks: Sequence[bytes]
+  extra_c_decls: str
+  decompress_c_fn: str
+  cleanup_c_stmt: str = ''
+
+
+def _build_zlib_dict(blocks: Sequence[bytes], max_dict_bytes: int = 32768) -> bytes:
+  """Build up to a 32 KiB preset Deflate dictionary from frequent substrings."""
+  counts: Dict[bytes, int] = collections.Counter()
+  for block in blocks:
+    for field in block.split(b'\x00'):
+      if not field:
+        continue
+      item = field + b'\x00'
+      if 4 <= len(item) <= 128:
+        counts[item] += 1
+      if len(field) > 24:
+        words = field.split(b' ')
+        for i in range(len(words) - 2):
+          phrase = b' '.join(words[i:i + 3]) + b' '
+          if 8 <= len(phrase) <= 96:
+            counts[phrase] += 1
+
+  scored = [
+      ((cnt - 1) * len(tok), tok)
+      for tok, cnt in counts.items()
+      if cnt >= 3
+  ]
+  scored.sort(reverse=True)
+
+  selected: list[bytes] = []
+  selected_blob = bytearray()
+  for _, tok in scored:
+    if len(selected_blob) + len(tok) > max_dict_bytes:
+      continue
+    if tok in selected_blob:
+      continue
+    selected.append(tok)
+    selected_blob.extend(tok)
+    if len(selected_blob) >= max_dict_bytes:
+      break
+
+  # Deflate assigns shorter distance codes to matches near the end of zdict.
+  selected.reverse()
+  return b''.join(selected)
+
+
+def _compress_blocks_zlib(blocks: Sequence[bytes]) -> Optional[CompressedStringOutput]:
+  """Compress blocks using stdlib zlib raw Deflate with a preset dictionary."""
+  try:
+    zlib_mod = importlib.import_module('zlib')
+  except ImportError:
+    return None
+
+  zdict = _build_zlib_dict(blocks)
+  compressed_blocks: list[bytes] = []
+  for block in blocks:
+    cobj = zlib_mod.compressobj(level=9, wbits=-zlib_mod.MAX_WBITS, zdict=zdict)
+    compressed_blocks.append(cobj.compress(block) + cobj.flush())
+
+  dict_lines = [f'#define BIG_C_STRING_ZDICT_LEN {len(zdict)}U\n']
+  if zdict:
+    dict_lines.append('/* clang-format off */\n')
+    dict_lines.append('static const unsigned char big_c_string_zdict[] =\n')
+    for i in range(0, len(zdict), 64):
+      chunk = zdict[i:i + 64]
+      escaped = ''.join(_BYTE_TO_C_OCTAL[b] for b in chunk)
+      dict_lines.append(f'\t"{escaped}"\n')
+    dict_lines.append(';\n/* clang-format on */\n')
+  else:
+    dict_lines.append('static const unsigned char big_c_string_zdict[] = "";\n')
+
+  decompress_fn = """static bool decompress_block(const unsigned char *src, uint32_t src_len,
+\t\t\t     char *dst, uint32_t dst_len)
+{
+\tz_stream zs = {
+\t\t.next_in = (Bytef *)(uintptr_t)src,
+\t\t.avail_in = src_len,
+\t\t.next_out = (Bytef *)dst,
+\t\t.avail_out = dst_len,
+\t};
+\tint ret;
+
+\tif (inflateInit2(&zs, -MAX_WBITS) != Z_OK)
+\t\treturn false;
+
+\tif (BIG_C_STRING_ZDICT_LEN > 0 &&
+\t    inflateSetDictionary(&zs, big_c_string_zdict,
+\t\t\t\t BIG_C_STRING_ZDICT_LEN) != Z_OK) {
+\t\tinflateEnd(&zs);
+\t\treturn false;
+\t}
+
+\tret = inflate(&zs, Z_FINISH);
+\tinflateEnd(&zs);
+\treturn ret == Z_STREAM_END && zs.avail_out == 0;
+}
+"""
+  return CompressedStringOutput(
+      name='zlib',
+      c_headers=['<zlib.h>'],
+      compressed_blocks=compressed_blocks,
+      extra_c_decls=''.join(dict_lines),
+      decompress_c_fn=decompress_fn,
+  )
+
+
+_COMPRESS_BACKENDS: Dict[
+    str, Optional[Callable[[Sequence[bytes]], Optional[CompressedStringOutput]]]
+] = {
+    'none': None,
+    'zlib': _compress_blocks_zlib,
+}
+
+
+def _parse_compress_candidates(spec: str) -> Sequence[str]:
+  """Validate and split a comma-separated --compress preference list."""
+  candidates = [c.strip() for c in spec.split(',') if c.strip()]
+  if not candidates:
+    raise argparse.ArgumentTypeError('--compress must not be empty')
+  for name in candidates:
+    if name not in _COMPRESS_BACKENDS:
+      known = ', '.join(sorted(_COMPRESS_BACKENDS))
+      raise argparse.ArgumentTypeError(
+          f"Unknown compression format '{name}' (expected one of: {known})")
+  return candidates
+
+
+def _select_compressor(
+    candidates: Sequence[str], blocks: Sequence[bytes]
+) -> Optional[CompressedStringOutput]:
+  """Run the first available compressor in candidates, or None for 'none'."""
+  if not blocks:
+    return None
+  for name in candidates:
+    if name == 'none':
+      return None
+    backend = _COMPRESS_BACKENDS[name]
+    assert backend is not None
+    result = backend(blocks)
+    if result is not None:
+      return result
+  raise RuntimeError(
+      f"None of the requested compression formats ({', '.join(candidates)}) are available"
+  )
+
+
+def write_compressed_string_file(out_file: TextIO, blocks: Sequence[bytes],
+                                 comp: CompressedStringOutput) -> None:
+  """Emit pmu-events-string.c with compressed blocks and a lock-free block cache."""
+  num_blocks = len(blocks)
+  assert len(comp.compressed_blocks) == num_blocks
+  out_file.write('/* SPDX-License-Identifier: GPL-2.0 */\n')
+  out_file.write(f'/* Autogenerated by jevents.py (compress={comp.name}) */\n')
+  out_file.write("""/*
+ * Block-indexed string compression:
+ * Instead of a single monolithic compressed blob (which would force
+ * decompressing megabytes of unused CPU models' strings on startup) or
+ * per-string compression (which degrades compression ratios), event and metric
+ * records are packed into ~8 KiB blocks without splitting records across block
+ * boundaries and each block is compressed independently into big_c_string_blob.
+ *
+ * Every uint32_t string offset passed to pmu_events__get_string() encodes
+ * (block_id << 16) | sub_offset. On lookup, only the referenced block is
+ * decompressed on demand and memoized in the lock-free big_c_string_cache[]
+ * array; untouched blocks remain compressed in .rodata.
+ */
+""")
+  headers = ['<stdbool.h>', '<stddef.h>', '<stdint.h>', '<stdlib.h>'] + list(comp.c_headers)
+  for hdr in headers:
+    out_file.write(f'#include {hdr}\n')
+  out_file.write('\nconst char *pmu_events__get_string(uint32_t offset);\n\n')
+  out_file.write(f'#define BIG_C_STRING_NUM_BLOCKS {num_blocks}U\n')
+  out_file.write(f'#define BIG_C_STRING_BLOCK_SHIFT {_BIG_C_STRING_BLOCK_SHIFT}U\n')
+  out_file.write('#define BIG_C_STRING_SUB_MASK ((1U << BIG_C_STRING_BLOCK_SHIFT) - 1U)\n\n')
+  if comp.extra_c_decls:
+    out_file.write(comp.extra_c_decls)
+    out_file.write('\n')
+
+  blob = b''.join(comp.compressed_blocks)
+  out_file.write('/* clang-format off */\n')
+  write_c_octal_array(out_file, 'big_c_string_blob', blob)
+  out_file.write('\nstatic const uint32_t big_c_string_block_offsets[BIG_C_STRING_NUM_BLOCKS + 1] = {\n')
+  pos = 0
+  offset_strs = ['0U']
+  for cblock in comp.compressed_blocks:
+    pos += len(cblock)
+    offset_strs.append(f'{pos}U')
+  for i in range(0, len(offset_strs), 12):
+    out_file.write('\t' + ', '.join(offset_strs[i:i + 12]) + ',\n')
+  out_file.write('};\n\n')
+
+  out_file.write('static const uint16_t big_c_string_raw_lens[BIG_C_STRING_NUM_BLOCKS] = {\n')
+  len_strs = [f'{len(b)}U' for b in blocks]
+  for i in range(0, len(len_strs), 12):
+    out_file.write('\t' + ', '.join(len_strs[i:i + 12]) + ',\n')
+  out_file.write('};\n')
+  out_file.write('/* clang-format on */\n\n')
+
+  out_file.write('static char *big_c_string_cache[BIG_C_STRING_NUM_BLOCKS];\n\n')
+  out_file.write(comp.decompress_c_fn)
+  out_file.write('\n__attribute__((destructor)) static void big_c_string_cache_free(void)\n{\n')
+  out_file.write('\tfor (size_t i = 0; i < BIG_C_STRING_NUM_BLOCKS; i++) {\n')
+  out_file.write('\t\tfree(big_c_string_cache[i]);\n')
+  out_file.write('\t\tbig_c_string_cache[i] = NULL;\n')
+  out_file.write('\t}\n')
+  if comp.cleanup_c_stmt:
+    out_file.write(comp.cleanup_c_stmt)
+  out_file.write('}\n\n')
+
+  out_file.write("""const char *pmu_events__get_string(uint32_t offset)
+{
+\tuint32_t block_id = offset >> BIG_C_STRING_BLOCK_SHIFT;
+\tuint32_t sub_offset = offset & BIG_C_STRING_SUB_MASK;
+\tchar *block;
+
+\tif (block_id >= BIG_C_STRING_NUM_BLOCKS)
+\t\treturn NULL;
+
+\tblock = __atomic_load_n(&big_c_string_cache[block_id], __ATOMIC_ACQUIRE);
+\tif (!block) {
+\t\tuint32_t comp_off = big_c_string_block_offsets[block_id];
+\t\tuint32_t comp_len = big_c_string_block_offsets[block_id + 1] - comp_off;
+\t\tuint32_t raw_len = big_c_string_raw_lens[block_id];
+\t\tchar *expected = NULL;
+
+\t\tif (sub_offset >= raw_len)
+\t\t\treturn NULL;
+
+\t\tblock = malloc(raw_len);
+\t\tif (!block)
+\t\t\treturn NULL;
+
+\t\tif (!decompress_block(&big_c_string_blob[comp_off], comp_len,
+\t\t\t\t      block, raw_len)) {
+\t\t\tfree(block);
+\t\t\treturn NULL;
+\t\t}
+
+\t\tif (!__atomic_compare_exchange_n(&big_c_string_cache[block_id],
+\t\t\t\t\t\t &expected, block, false,
+\t\t\t\t\t\t __ATOMIC_RELEASE,
+\t\t\t\t\t\t __ATOMIC_ACQUIRE)) {
+\t\t\tfree(block);
+\t\t\tblock = expected;
+\t\t}
+\t} else if (sub_offset >= big_c_string_raw_lens[block_id]) {
+\t\treturn NULL;
+\t}
+
+\treturn &block[sub_offset];
+}
+""")
+
+
 class BigCString:
-  """A class to hold many byte strings concatenated together.
+  """A class to hold many byte strings concatenated or packed into blocks.
 
   Generating a large number of stand-alone C strings creates a large
   number of relocations in position independent code. The BigCString
-  is a helper for this case. It builds a single string which within it
-  are all the other C strings (to avoid memory issues the string
-  itself is held as a list of strings). The offsets within the big
-  string are recorded and when stored to disk these don't need
-  relocation. To reduce the size of the string further, identical
-  strings are merged. If a longer string ends-with the same value as a
-  shorter string, these entries are also merged.
+  is a helper for this case. In uncompressed mode (blocked=False), it
+  builds a single string containing all C strings and records flat byte
+  offsets that require no relocations. To reduce size further, identical
+  strings are merged and shorter strings that match the suffix of a
+  longer string are suffix-folded into the longer entry.
+
+  In block-indexed compression mode (blocked=True), non-folded byte
+  records are packed sequentially into ~8 KiB blocks without splitting a
+  record across block boundaries, and each offset is encoded as
+  (block_id << 16) | sub_offset so individual blocks can be compressed
+  independently and decompressed on demand at runtime.
   """
   strings: Set[bytes]
   big_string: Sequence[str]
+  blocks: Sequence[bytes]
   offsets: Dict[bytes, int]
   metrics: Set[bytes]
 
@@ -119,7 +420,7 @@ class BigCString:
       if is_metric:
         self.metrics.add(b)
 
-  def compute(self) -> None:
+  def compute(self, blocked: bool = False) -> None:
     """Called once all strings are added to compute the string and offsets."""
 
     folded_strings: Dict[bytes, bytes] = {}
@@ -149,31 +450,57 @@ class BigCString:
       if key != val:
         fold_into_strings[val].add(key)
 
-    # big_string_offset is the current byte location within the C string
-    # being appended to - comments, etc. don't count. big_string is
-    # the C string literal contents represented as a list.
-    big_string_offset = 0
     self.big_string = []
+    self.blocks = []
     self.offsets = {}
 
     def string_cmp_key(b: bytes) -> Tuple[bool, bytes]:
       return (b in self.metrics, b)
 
-    # Emit all strings that aren't folded in a sorted manner.
-    for b in sorted(self.strings, key=string_cmp_key):
-      if b not in folded_strings:
-        self.offsets[b] = big_string_offset
-        self.big_string.append(f'/* offset={big_string_offset} */\n"')
-        self.big_string.append(bytes_to_c_literal(b))
-        self.big_string.append('"')
-        if b in fold_into_strings:
-          also = [bytes_to_c_literal(x).replace('*/', r'\*\/')
-                  for x in sorted(fold_into_strings[b])]
-          self.big_string.append(' /* also: ' + ', '.join(also) + ' */')
-        self.big_string.append('\n')
-        big_string_offset += len(b)
-
-    # Compute the offsets of the folded strings.
+    if blocked:
+      blocks: list[bytes] = []
+      cur_parts: list[bytes] = []
+      cur_len = 0
+      max_sub_len = 1 << _BIG_C_STRING_BLOCK_SHIFT
+      for b in sorted(self.strings, key=string_cmp_key):
+        if b in folded_strings:
+          continue
+        assert len(b) <= max_sub_len, f'Oversized string ({len(b)} bytes)'
+        if cur_len > 0 and cur_len + len(b) > _BIG_C_STRING_TARGET_BLOCK_SIZE:
+          blocks.append(b''.join(cur_parts))
+          cur_parts = []
+          cur_len = 0
+        block_id = len(blocks)
+        self.offsets[b] = (block_id << _BIG_C_STRING_BLOCK_SHIFT) | cur_len
+        cur_parts.append(b)
+        cur_len += len(b)
+      if cur_parts:
+        blocks.append(b''.join(cur_parts))
+      assert len(blocks) <= max_sub_len, f'Too many blocks ({len(blocks)})'
+      self.blocks = blocks
+    else:
+      # big_string_offset is the current byte location within the C string
+      # being appended to - comments, etc. don't count. big_string is
+      # the C string literal contents represented as a list.
+      big_string_offset = 0
+      # Emit all strings that aren't folded in a sorted manner.
+      for b in sorted(self.strings, key=string_cmp_key):
+        if b not in folded_strings:
+          self.offsets[b] = big_string_offset
+          self.big_string.append(f'/* offset={big_string_offset} */\n"')
+          self.big_string.append(bytes_to_c_literal(b))
+          self.big_string.append('"')
+          if b in fold_into_strings:
+            also = [bytes_to_c_literal(x).replace('*/', r'\*\/')
+                    for x in sorted(fold_into_strings[b])]
+            self.big_string.append(' /* also: ' + ', '.join(also) + ' */')
+          self.big_string.append('\n')
+          big_string_offset += len(b)
+
+    # Compute the offsets of the folded strings. In blocked=True mode, folded_b
+    # resides wholly within a single <= 64 KiB block, so adding the non-negative
+    # delta (len(folded_b) - len(b)) advances the low 16-bit sub_offset without
+    # overflowing into block_id.
     for b, folded_b in folded_strings.items():
       assert b not in self.offsets
       self.offsets[b] = self.offsets[folded_b] + len(folded_b) - len(b)
@@ -1479,6 +1806,16 @@ def main() -> None:
         ftw(item.path, list(parents) + [item.name], action)
 
   ap = argparse.ArgumentParser()
+  ap.add_argument(
+      '--compress',
+      default='none',
+      type=_parse_compress_candidates,
+      help=(
+          'Comma-separated preference list for block-indexed string '
+          'compression, packing strings into independently compressed ~8 KiB '
+          'blocks indexed by (block_id << 16) | sub_offset (e.g. zlib,none)'
+      ),
+  )
   ap.add_argument('arch', help='Architecture name like x86')
   ap.add_argument('model', help='''Select a model such as skylake to
 reduce the code size.  Normally set to "all". For architectures like
@@ -1510,6 +1847,11 @@ such as "arm/cortex-a34".''',
 #include <string.h>
 #include <strings.h>
 
+/*
+ * Offset passed to pmu_events__get_string(): a flat byte offset into
+ * big_c_string[] when uncompressed, or (block_id << 16) | sub_offset into
+ * ~8 KiB compressed blocks when built with block-indexed string compression.
+ */
 struct compact_pmu_event {
 \tuint32_t offset;
 };
@@ -1556,7 +1898,15 @@ struct pmu_table_entry {
     ftw(arch_path, [], preprocess_one_file)
 
   assert _bcs is not None
-  _bcs.compute()
+  use_blocks = bool(_args.output_string_file) and _args.compress[0] != 'none'
+  comp_output: Optional[CompressedStringOutput] = None
+  if use_blocks:
+    _bcs.compute(blocked=True)
+    comp_output = _select_compressor(_args.compress, _bcs.blocks)
+    if comp_output is None:
+      _bcs.compute(blocked=False)
+  else:
+    _bcs.compute(blocked=False)
   _args.output_file.write('/* clang-format off */\n')
   if not _args.output_string_file:
     _args.output_file.write('static const char big_c_string[] =\n')
@@ -1573,20 +1923,23 @@ struct pmu_table_entry {
 
 """)
   else:
-    _args.output_string_file.write('/* SPDX-License-Identifier: GPL-2.0 */\n')
-    _args.output_string_file.write('/* Autogenerated by jevents.py */\n')
-    _args.output_string_file.write('#include <stdint.h>\n\n')
-    _args.output_string_file.write('const char *pmu_events__get_string(uint32_t offset);\n\n')
-    _args.output_string_file.write('/* clang-format off */\n')
-    _args.output_string_file.write('static const char big_c_string[] =\n')
-    if _bcs.big_string:
-      for s in _bcs.big_string:
-        _args.output_string_file.write(s)
+    if comp_output is not None:
+      write_compressed_string_file(_args.output_string_file, _bcs.blocks, comp_output)
     else:
-      _args.output_string_file.write('""\n')
-    _args.output_string_file.write(';\n')
-    _args.output_string_file.write('/* clang-format on */\n\n')
-    _args.output_string_file.write("""const char *pmu_events__get_string(uint32_t offset)
+      _args.output_string_file.write('/* SPDX-License-Identifier: GPL-2.0 */\n')
+      _args.output_string_file.write('/* Autogenerated by jevents.py */\n')
+      _args.output_string_file.write('#include <stdint.h>\n\n')
+      _args.output_string_file.write('const char *pmu_events__get_string(uint32_t offset);\n\n')
+      _args.output_string_file.write('/* clang-format off */\n')
+      _args.output_string_file.write('static const char big_c_string[] =\n')
+      if _bcs.big_string:
+        for s in _bcs.big_string:
+          _args.output_string_file.write(s)
+      else:
+        _args.output_string_file.write('""\n')
+      _args.output_string_file.write(';\n')
+      _args.output_string_file.write('/* clang-format on */\n\n')
+      _args.output_string_file.write("""const char *pmu_events__get_string(uint32_t offset)
 {
 \treturn &big_c_string[offset];
 }
-- 
2.56.1.703.gf848ed807c-goog

