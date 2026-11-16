Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794812469;
	b=xRgLTNyZnj6CXVeluRCFDPz25TT1jgaauloctKEsWDNm63VncDu/lmtt1dNhsUKNXqEG
	 9G/Z4jwLWqcWBV2XJC4f9RaDS9MUEB1qElbLwQmfOswMrWQmNTyN9+VHiyk0EkeTmGgA2
	 p9Gn1+HhostidOT3eJOFPpBLnR51AXOscL7vOEDIioc+i5OYITBP0g38/oAmI0E7bK06g
	 EXdVM4GVgVcguCX7JEGMlfsI7UeBbkwt7Lo5wb99lfZwEWH58RO4vdezStSJThFg7pA+4
	 cQVFT5IUmrwXQPfIFyKWkie3YRIcx2g9mU7FnmIwPyLL7qtCaJwnfsfszbeN5e3qWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794812469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=BZskXXSYGagr3q0TS4sT/gUPYzryrWdxlcZQVXFakYI=;
	b=MfGXxIj8DxBOH/OYNWDOnvjJNXMSqA1uBpXSPtVqiybXJEWa/nsLk+zoqI/1ag3Si+nn
	 LCrqYHZy/v1ufDrLuv6UYe6JqUck5KMQZVbIJrFJW66YI8KmhOe1T9vRPG+NKkdzJTy74
	 JiG++e0FaNk83UZ+O0XHmui2aCl2k+BTKlTqsIIrR+Vp8RLb14OcCqih/XLS1LRjBiOfi
	 PJZxu9kOO124o7orrE/94IJ7Ho1TSA/PNjlXjwpNuYS7ye+aPyX8ZhbVFl8LhfabPLhK9
	 oVML2/AGP2nHguSNNpirw9fMKhmVewrePrW00NdiYaRS5CQBactfXBKQjBpRVPoQYHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N9+q7WQB;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCE60A2607
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Nov 2026 07:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16BCE60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N9+q7WQB
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so4077495eec.1
        for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 23:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794812467; x=1795417267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZskXXSYGagr3q0TS4sT/gUPYzryrWdxlcZQVXFakYI=;
        b=N9+q7WQB1z/hGlgpX8OntLWTJN11Xw8fSAPDbRgp2+Z5FlD5JFB7C7DwbWF72wnuQq
         RgYLtHJCWoUej8ACsxbcTMK5vdYZcwxAHlyg7ocR8E/A+vGyGvlRzfYqrRBqCKOqeSBS
         7pOMTPXM45ABwQLjs6FzREZ8oa7PIIgxdeXteYucNjQ0hwnB0TpiZ9A5ywRS4DrWLpA2
         TDhIPzJ08hRv5iJCwt8vgUXy5snB6a+jIjWMBwNTXFrZvFCMpZhDb5OMFRbNX9jdCFm7
         kkMwGoqhxb+7Rr0y4pZvnOyKycQqIrWy8X6BFVAwS0bt8BshsTnZojsm+rwtp7TsKShG
         vqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794812467; x=1795417267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZskXXSYGagr3q0TS4sT/gUPYzryrWdxlcZQVXFakYI=;
        b=T6SxBYqsrkUoebEM4mkRKEFpR6faKJhTPGbeBy2DKV4PxyW1j0zV6me5RxRbzbBVAJ
         ZDlihD8T3I7BC7Q5r8vGPxVMJ8g5TPkwOjINZN/FhKKcktCvME0OzrC8Gn3GxJz6FGeV
         wWUf4URyJ+FfP+kuotZXdwnsYD9DfcN6hnVTsR2rLycuJghuRbXEIA9mIq7RzU7n6Dd4
         o35ZGN1jZYqfISfwxLZ9jup6dlte6YoRYT8x9MUsUQ8ZKG0P2btkCMPsxnWfUqH+ERtB
         QnsHHQz7AjUAsdoQucm9bCH2JaS1BpiZw0b0Y1FTm/VQ99wwlAQhObFycAG9yO2Hm/hb
         58cw==
X-Forwarded-Encrypted: i=1; AL+hErEM+kEZONYR4prmTfRbVBY6IdbQZ7hLFmyGsJg8nCWifvwWi8/8AXkgAZZNNzxd2QCUArIqqtoRDPAEayNs35qL@vger.kernel.org
X-Gm-Message-State: APuU4Z/hnBeygwQFWPsBPf3Bkmui/hEkfzXSATFmvpcLYMlLpSl2gIfe
	DssYMp9zUG8aX6479CpRHQe5Lhp14zJM4CJyScgFMuGngxjSVTtZKau7uGf10JVbCcFqgfHJ7b8
	I2X0ALYG2Jg==
X-Received: from dycpq7.prod.google.com ([2002:a05:7301:fd07:b0:36c:9ca8:5abe])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2a9c:b0:372:79a0:e8a3
 with SMTP id 5a478bee46e88-37963374fdemr10070918eec.1.1794812466901; Sun, 15
 Nov 2026 23:01:06 -0800 (PST)
Date: Sun, 15 Nov 2026 23:00:34 -0800
In-Reply-To: <20261116070038.2968725-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261116070038.2968725-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261116070038.2968725-8-irogers@google.com>
Subject: [PATCH v2 07/10] perf jevents: Add --compress=zstd block compression backend
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a 'zstd' block-indexed string compression backend to jevents.py that
trains a single shared 64 KiB Zstandard dictionary across all ~8 KiB
string blocks (itself stored zstd-compressed in .rodata and digested
once on demand into a shared ZSTD_DDict freed at exit) and compresses
each ~8 KiB block independently with ZSTD_compress_usingCDict().

Without a dictionary, each ~8 KiB block starts with an empty match
window and must emit its own Huffman/FSE entropy tables from scratch.
Sharing a trained 64 KiB dictionary pre-seeds both common event/metric
substrings and precomputed entropy tables across all blocks, shrinking
compressed .rodata by ~26% compared to dictionary-free ~8 KiB zstd
blocks (738 KiB vs 1,003 KiB across all architectures, recovering over
half the gap toward a single non-seekable 521 KiB whole-table stream)
while keeping every block independently decompressible via
(block_id << 16) | sub_offset.

To avoid mandatory third-party Python package dependencies across Python
versions, lazily probe three Zstandard bindings in order:
  1. Python 3.14+ standard-library compression.zstd
  2. python-zstandard (zstandard) if installed
  3. ctypes binding to the system libzstd shared library

When total string data is too small to train a dictionary, gracefully
fall back to dictionary-free Zstandard frames. On x86, --compress=zstd
shrinks pmu-events-string.o from ~6.90 MB to ~587 KB (~11.8x reduction).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 266 +++++++++++++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 293c6ee10e60..efa4866bb447 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -281,12 +281,278 @@ def _compress_blocks_lzma(blocks: Sequence[bytes]) -> Optional[CompressedStringO
   )
 
 
+def _zstd_compress_via_ctypes(
+    blocks: Sequence[bytes], dict_capacity: int, level: int
+) -> Optional[Tuple[Sequence[bytes], bytes, bytes]]:
+  """Compress blocks and dictionary via ctypes binding to libzstd."""
+  try:
+    ctypes = importlib.import_module('ctypes')
+    ctypes_util = importlib.import_module('ctypes.util')
+    lib_name = ctypes_util.find_library('zstd') or 'libzstd.so.1'
+    lib = ctypes.CDLL(lib_name)
+  except (ImportError, OSError):
+    return None
+
+  c_size_t = ctypes.c_size_t
+  c_void_p = ctypes.c_void_p
+  c_uint = ctypes.c_uint
+  c_int = ctypes.c_int
+
+  try:
+    lib.ZSTD_isError.argtypes = [c_size_t]
+    lib.ZSTD_isError.restype = c_uint
+    lib.ZDICT_isError.argtypes = [c_size_t]
+    lib.ZDICT_isError.restype = c_uint
+    lib.ZDICT_trainFromBuffer.argtypes = [
+        c_void_p, c_size_t, c_void_p, ctypes.POINTER(c_size_t), c_uint
+    ]
+    lib.ZDICT_trainFromBuffer.restype = c_size_t
+    lib.ZSTD_compressBound.argtypes = [c_size_t]
+    lib.ZSTD_compressBound.restype = c_size_t
+    lib.ZSTD_compress.argtypes = [c_void_p, c_size_t, c_void_p, c_size_t, c_int]
+    lib.ZSTD_compress.restype = c_size_t
+    lib.ZSTD_createCCtx.argtypes = []
+    lib.ZSTD_createCCtx.restype = c_void_p
+    lib.ZSTD_freeCCtx.argtypes = [c_void_p]
+    lib.ZSTD_freeCCtx.restype = c_size_t
+    lib.ZSTD_createCDict.argtypes = [c_void_p, c_size_t, c_int]
+    lib.ZSTD_createCDict.restype = c_void_p
+    lib.ZSTD_freeCDict.argtypes = [c_void_p]
+    lib.ZSTD_freeCDict.restype = c_size_t
+    lib.ZSTD_compress_usingCDict.argtypes = [
+        c_void_p, c_void_p, c_size_t, c_void_p, c_size_t, c_void_p
+    ]
+    lib.ZSTD_compress_usingCDict.restype = c_size_t
+  except AttributeError:
+    return None
+
+  raw_dict = b''
+  total_bytes = sum(len(b) for b in blocks)
+  if total_bytes >= 16384:
+    full_blob = b''.join(blocks)
+    sample_step = 2048
+    sample_lens = [
+        min(sample_step, len(full_blob) - off)
+        for off in range(0, len(full_blob), sample_step)
+    ]
+    if len(sample_lens) >= 8:
+      sizes_arr = (c_size_t * len(sample_lens))(*sample_lens)
+      dict_buf = ctypes.create_string_buffer(dict_capacity)
+      dsize = lib.ZDICT_trainFromBuffer(
+          dict_buf, dict_capacity, full_blob, sizes_arr, len(sample_lens)
+      )
+      if not lib.ZDICT_isError(dsize) and dsize > 0:
+        raw_dict = dict_buf.raw[:dsize]
+
+  cctx = lib.ZSTD_createCCtx()
+  if not cctx:
+    return None
+  cdict = None
+  try:
+    if raw_dict:
+      cdict = lib.ZSTD_createCDict(raw_dict, len(raw_dict), level)
+      if not cdict:
+        raw_dict = b''
+
+    max_block_len = max(len(b) for b in blocks)
+    dst_cap = lib.ZSTD_compressBound(max(max_block_len, len(raw_dict)))
+    dst_buf = ctypes.create_string_buffer(dst_cap)
+    compressed_blocks: list[bytes] = []
+
+    for block in blocks:
+      if cdict:
+        res = lib.ZSTD_compress_usingCDict(
+            cctx, dst_buf, dst_cap, block, len(block), cdict
+        )
+      else:
+        res = lib.ZSTD_compress(dst_buf, dst_cap, block, len(block), level)
+      if lib.ZSTD_isError(res):
+        return None
+      compressed_blocks.append(dst_buf.raw[:res])
+
+    comp_dict = b''
+    if raw_dict:
+      dres = lib.ZSTD_compress(dst_buf, dst_cap, raw_dict, len(raw_dict), level)
+      if lib.ZSTD_isError(dres):
+        return None
+      comp_dict = dst_buf.raw[:dres]
+
+    return compressed_blocks, raw_dict, comp_dict
+  finally:
+    if cdict:
+      lib.ZSTD_freeCDict(cdict)
+    lib.ZSTD_freeCCtx(cctx)
+
+
+def _compress_blocks_zstd(blocks: Sequence[bytes]) -> Optional[CompressedStringOutput]:
+  """Compress ~8 KiB blocks independently with zstd and a shared trained dictionary.
+
+  Trains a single 64 KiB Zstandard dictionary across all blocks (itself stored
+  zstd-compressed in .rodata and digested once on demand into a shared
+  ZSTD_DDict) so each ~8 KiB block achieves high compression ratios while
+  remaining independently decompressible via (block_id << 16) | sub_offset.
+  Probes Python 3.14+ compression.zstd, python-zstandard, or ctypes libzstd.
+  """
+  dict_capacity = 65536
+  level = 9
+  result: Optional[Tuple[Sequence[bytes], bytes, bytes]] = None
+
+  # 1. Try Python 3.14+ standard library compression.zstd.
+  try:
+    py_zstd = importlib.import_module('compression.zstd')
+    raw_dict = b''
+    zdict_obj = None
+    full_blob = b''.join(blocks)
+    if len(full_blob) >= 16384:
+      samples = [full_blob[i:i + 2048] for i in range(0, len(full_blob), 2048)]
+      try:
+        zdict_obj = py_zstd.train_dict(samples, dict_capacity)
+        raw_dict = bytes(zdict_obj.dict_content)
+      except Exception:
+        raw_dict = b''
+        zdict_obj = None
+    if zdict_obj is not None:
+      cblocks = [py_zstd.compress(b, level=level, zstd_dict=zdict_obj) for b in blocks]
+      cdict_bytes = py_zstd.compress(raw_dict, level=level)
+    else:
+      cblocks = [py_zstd.compress(b, level=level) for b in blocks]
+      cdict_bytes = b''
+    result = (cblocks, raw_dict, cdict_bytes)
+  except ImportError:
+    pass
+
+  # 2. Try third-party zstandard module if installed.
+  if result is None:
+    try:
+      zstd_pkg = importlib.import_module('zstandard')
+      raw_dict = b''
+      pkg_dict = None
+      full_blob = b''.join(blocks)
+      if len(full_blob) >= 16384:
+        samples = [full_blob[i:i + 2048] for i in range(0, len(full_blob), 2048)]
+        try:
+          pkg_dict = zstd_pkg.train_dictionary(dict_capacity, samples)
+          raw_dict = pkg_dict.as_bytes()
+        except Exception:
+          raw_dict = b''
+          pkg_dict = None
+      comp = zstd_pkg.ZstdCompressor(level=level, dict_data=pkg_dict)
+      cblocks = [comp.compress(b) for b in blocks]
+      cdict_bytes = (
+          zstd_pkg.ZstdCompressor(level=level).compress(raw_dict)
+          if raw_dict else b''
+      )
+      result = (cblocks, raw_dict, cdict_bytes)
+    except ImportError:
+      pass
+
+  # 3. Fall back to ctypes binding to system libzstd.
+  if result is None:
+    result = _zstd_compress_via_ctypes(blocks, dict_capacity, level)
+
+  if result is None:
+    return None
+
+  compressed_blocks, raw_dict, comp_dict = result
+  if raw_dict:
+    dict_lines = [
+        f'#define BIG_C_STRING_ZDICT_RAW_LEN {len(raw_dict)}U\n',
+        f'#define BIG_C_STRING_ZDICT_COMP_LEN {len(comp_dict)}U\n',
+        '/* clang-format off */\n',
+        'static const unsigned char big_c_string_zdict[] =\n',
+    ]
+    for i in range(0, len(comp_dict), 64):
+      chunk = comp_dict[i:i + 64]
+      escaped = ''.join(_BYTE_TO_C_OCTAL[b] for b in chunk)
+      dict_lines.append(f'\t"{escaped}"\n')
+    dict_lines.append(';\n/* clang-format on */\n\n')
+    dict_lines.append('static ZSTD_DDict *big_c_string_ddict;\n')
+    extra_c_decls = ''.join(dict_lines)
+
+    decompress_fn = """static const ZSTD_DDict *get_zstd_ddict(void)
+{
+\tZSTD_DDict *ddict = __atomic_load_n(&big_c_string_ddict, __ATOMIC_ACQUIRE);
+
+\tif (!ddict) {
+\t\tZSTD_DDict *expected = NULL;
+\t\tvoid *dict_buf = malloc(BIG_C_STRING_ZDICT_RAW_LEN);
+
+\t\tif (!dict_buf)
+\t\t\treturn NULL;
+\t\tif (ZSTD_decompress(dict_buf, BIG_C_STRING_ZDICT_RAW_LEN,
+\t\t\t\t    big_c_string_zdict,
+\t\t\t\t    BIG_C_STRING_ZDICT_COMP_LEN) !=
+\t\t    BIG_C_STRING_ZDICT_RAW_LEN) {
+\t\t\tfree(dict_buf);
+\t\t\treturn NULL;
+\t\t}
+\t\tddict = ZSTD_createDDict(dict_buf, BIG_C_STRING_ZDICT_RAW_LEN);
+\t\tfree(dict_buf);
+\t\tif (!ddict)
+\t\t\treturn NULL;
+\t\tif (!__atomic_compare_exchange_n(&big_c_string_ddict, &expected,
+\t\t\t\t\t\t ddict, false,
+\t\t\t\t\t\t __ATOMIC_RELEASE,
+\t\t\t\t\t\t __ATOMIC_ACQUIRE)) {
+\t\t\tZSTD_freeDDict(ddict);
+\t\t\tddict = expected;
+\t\t}
+\t}
+\treturn ddict;
+}
+
+static bool decompress_block(const unsigned char *src, uint32_t src_len,
+\t\t\t     char *dst, uint32_t dst_len)
+{
+\tconst ZSTD_DDict *ddict = get_zstd_ddict();
+\tZSTD_DCtx *dctx;
+\tsize_t ret;
+
+\tif (!ddict)
+\t\treturn false;
+\tdctx = ZSTD_createDCtx();
+\tif (!dctx)
+\t\treturn false;
+\tret = ZSTD_decompress_usingDDict(dctx, dst, dst_len, src, src_len, ddict);
+\tZSTD_freeDCtx(dctx);
+\treturn !ZSTD_isError(ret) && ret == dst_len;
+}
+"""
+    cleanup_stmt = (
+        '\tif (big_c_string_ddict) {\n'
+        '\t\tZSTD_freeDDict(big_c_string_ddict);\n'
+        '\t\tbig_c_string_ddict = NULL;\n'
+        '\t}\n'
+    )
+  else:
+    extra_c_decls = ''
+    decompress_fn = """static bool decompress_block(const unsigned char *src, uint32_t src_len,
+\t\t\t     char *dst, uint32_t dst_len)
+{
+\tsize_t ret = ZSTD_decompress(dst, dst_len, src, src_len);
+
+\treturn !ZSTD_isError(ret) && ret == dst_len;
+}
+"""
+    cleanup_stmt = ''
+
+  return CompressedStringOutput(
+      name='zstd',
+      c_headers=['<zstd.h>'],
+      compressed_blocks=compressed_blocks,
+      extra_c_decls=extra_c_decls,
+      decompress_c_fn=decompress_fn,
+      cleanup_c_stmt=cleanup_stmt,
+  )
+
+
 _COMPRESS_BACKENDS: Dict[
     str, Optional[Callable[[Sequence[bytes]], Optional[CompressedStringOutput]]]
 ] = {
     'none': None,
     'lzma': _compress_blocks_lzma,
     'zlib': _compress_blocks_zlib,
+    'zstd': _compress_blocks_zstd,
 }
 
 
-- 
2.56.1.703.gf848ed807c-goog

