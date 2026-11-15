Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794703169;
	b=y8AyoFVJIOpN5G6G5UlnMF85Fs8Xz53tXSwKDKobWSUkQvPSbANVIjIhY2wbPmTV7T4p
	 yd9HfMbz5uC5hUYkA4FsoKYGq6+Kh4Yq73ZarKffK3lTlQBhbsZQEvVJNbcvW7ErINVJ0
	 84XZtJdahV3ayo9JS6puu0hDvSWvWyVYZt5J4U88sUsEcc9xxGZydLXxrYcjhfdSdtvec
	 zp2p1+N+DEqZtNmFJdvnliYcsNpJwsxaAh6Jdh9QpbvPVnJTvSbbGcQhFugsJFZiqYPMV
	 oVcPlJplOxU+b9uk5ak+j2zR/bn3L8WV4G0f+9cH0SO9iqn8kp+Gcvr0nMHi9cJ5C9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794703169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tG3TwJW+J1JqnPjNeoFVDsdxOoEFkP+pmJh5VpZnCWI=;
	b=0d9TVLo4xzFvZY5I/4Tyd8HNMuMKYdjLSxiZ5da2GSvB36BTrWK3G47MuDmwobKpFXGu
	 DC+2totI2+mNj5JkuA5flf4GmwHzI74up4QPqQHrVaFzeppPypqXY9p2t/WVgQf/vMVmI
	 LecLUV3xHmLrZL5eUiGHy7KQ+eWBJau7n9Io32Dq/vZQTkvHAbMs0RMnxuC5fDxJbyzf8
	 OIf+tYNHmmKZ49eaM9LADeiCcvTLgQsLIha4NFtOhCHt+dnrRknMRTqMC21lzC3NRG4no
	 YZc6BSvIO4U6zz48N5n05B6pp4erShjM0FN+1tuZbf8sQF53zAEvc4PxBYgC0vIfpKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="SyTLNdZ/";
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC65606A8A3
	for <linux-perf-users@vger.kernel.org>; Sun, 15 Nov 2026 00:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AC65606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyTLNdZ/
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6767d92cde6so2274276d50.0
        for <linux-perf-users@vger.kernel.org>; Sat, 14 Nov 2026 16:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794703168; x=1795307968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tG3TwJW+J1JqnPjNeoFVDsdxOoEFkP+pmJh5VpZnCWI=;
        b=SyTLNdZ/vXgZ8RGN6nqVHTfHG3FbZfmpMUqY+8D14IGlGoWN5Lgxyz4hZATbXm9eHD
         65LHjRh9mb6cF5UlTqBZqrSMCV5TLQUNJLragsX6RF4JmVvH5nmFbm0vpXyF+ZW5cCTk
         rDnYulxbTSuXEoMc0uwbq1GnF9MOLHDuSckxL6U0aXDXQU5BnR7ekPXqPvHmFodGNajS
         pF8F7uS/G2LsF7C8QJcSKko3aAeGKKflJ2dEJrdnEhe6WBrRpKhgDqcOc+58QhXzUyHC
         M6aueTtlR8ege5+NEeEvwyEQdWHHxoWX3c5YpkwTMI6ddF9200XUkKJhIr04mzTzhF9o
         SKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794703168; x=1795307968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tG3TwJW+J1JqnPjNeoFVDsdxOoEFkP+pmJh5VpZnCWI=;
        b=Dmxz5QcddBUgdH/lXoAIwSQsBHiD7j9Ok8Hks0MHPiJDbu6SHIv0Aqshy7bktFo8DQ
         Z4HoRgBHXRDrFHbAw6iUhDJUVQ0HG/6QkCleuAEZKZw5OUQb6PdQq+A3vXmd6BfMNesn
         Z81yQ5FwQIp5t8CD0i1bzUnThvDlQSnzhmLUajiK8ji+VkuDh+WLJXkcmhUwp8ffzPX3
         dOnpDKDHBJdmraGYajduXBN5fBIM+wsJ5+QDqsfeutMdAg9PcqYn5kqlwmZMoxd59aoH
         MdGxSUD0kSnCJZwXtLsbpTZW+zjXBZ6cEa13BpaLHIYq80kkpxb9l/PrXLyZZ8LnhYd4
         Cjaw==
X-Forwarded-Encrypted: i=1; AL+hErFw/2kpqOreD6lwjzyRQ0XZ8OkPWEnyzMFKzqm4ZcXOBIOOK2Zdy49DIoQu6iG6LaHv9TNy/AgN/ZZsp8uBomRh@vger.kernel.org
X-Gm-Message-State: APuU4Z9pLFaMFH8GZWJJEbc0FbPXhyQzbOQ8PqkjC7tuPe67SjKAIg9j
	RLvDdHC3Y0DdnbqUac6nR6FCRSIZF4w6L8erS3cdGzjVS9Y9SZ9HjJnQ
X-Gm-Gg: AYBFou3XSoGGVmOzRs/ufdEjKDTItOJ/wznHpBU00mepmFQ7Y/zUvWBeCfIvuKdK/H3
	aQ3D/7iBknN1iudEcIY1SmdptGKjURMgara/MIobxw2vKiU6Yg5/SLB2tozBDo2qwr8BgrYlhaH
	A2pDGr7v+SkhPMLG/10590Ch65WVFPbbTW9IVAst/XWgi6cSu41F6+lFfyHQtDk2se1ui+WIscs
	vjQia/nK1ITM5SBnJ42+Y2rdUGv7QXegE1YJ702iIfR0sPVizf2o70XlCM4ItaV9XweyGC3D+Qe
	/0G/ifqRaL/chy2FR5HJkYeLrw46nSXpyQUTeHX4qbHQrloY0MMSC1t7TR7VD41DduleqkyYVR0
	glGU/Q9+ceBe0lmE6d4VagerIYLqvzDH+XDZ3nUPXqTFARDAddd9oQiwqOVAxZZGsH2LuvpRc/E
	2UkQAwdslCmzp+sQ8C7K94WghE5UvYFWZPvYqYc0zc27wwck8xT13AJx2TfdS5sfUdbcB0GnG9H
	jfh6dCbfOPNH9rOVFQlLvRfihM8tF7ny00/HisNYkrmcMAP5cYc749Y6J5lxxE0+wlmZIITuIiX
	42+CCCSyMeSsBibEG4aFqNRdbBwkI+GfcqSIEAlAflmPHvbTAjzIgiZGOgNdZYaP1GRFpcWy2GM
	rHg==
X-Received: by 2002:a05:690e:419c:b0:67c:1b89:b117 with SMTP id 956f58d0204a3-67d8972ec68mr4388147d50.77.1794703168379;
        Sat, 14 Nov 2026 16:39:28 -0800 (PST)
Received: from codey.attlocal.net ([2600:1700:22f5:3930::a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm189602d50.19.2026.11.14.16.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 16:39:28 -0800 (PST)
From: Lalit Maganti <lalitmaganti@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: adrian.hunter@intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lalit Maganti <lalitmaganti@gmail.com>
Subject: [PATCH 4/4] perf python: Compress the traces of the perfetto script
Date: Sun, 15 Nov 2026 00:39:16 +0000
Message-ID: <20261115003916.1873857-5-lalitmaganti@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261115003916.1873857-1-lalitmaganti@gmail.com>
References: <20261115003916.1873857-1-lalitmaganti@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Perfetto reads zstd and gzip traces directly, so compress the output by
default. Add a -c/--compression option:
 - auto (default): zstd if Python has compression.zstd (3.14+), else
   gzip, so only the standard library is needed
 - zstd: level 9
 - gzip: level 6, with no time or file name in the header so the output
   is reproducible
 - none

Without -o, the output file gets a matching extension: perf.pftrace.zst,
perf.pftrace.gz or perf.pftrace.

For 4496 samples of a two-thread workload, the trace is 127KB
uncompressed, 37KB with gzip and 30KB with zstd. Compressing takes a few
milliseconds.

The shell test now checks every compression the Python running it
supports.

Assisted-by: LLM
Signed-off-by: Lalit Maganti <lalitmaganti@gmail.com>
---
 tools/perf/python/perfetto.py             | 64 ++++++++++++++++++++---
 tools/perf/tests/shell/script_perfetto.sh | 58 ++++++++++++++------
 2 files changed, 99 insertions(+), 23 deletions(-)

diff --git a/tools/perf/python/perfetto.py b/tools/perf/python/perfetto.py
index e168b146e538..3fd3857bde13 100755
--- a/tools/perf/python/perfetto.py
+++ b/tools/perf/python/perfetto.py
@@ -10,12 +10,18 @@ The protobuf wire format is simple enough that the few messages needed are
 encoded by hand below, which avoids a dependency on the protobuf package and
 generated bindings. The field numbers in this file are taken from the .proto
 files under protos/perfetto/trace/ in the Perfetto repository and are stable.
+
+Perfetto reads zstd and gzip compressed traces natively, so the trace is
+compressed with whichever the Python standard library has (zstd since 3.14).
 """
 from __future__ import annotations
 
 import argparse
+import gzip
 import http
 import http.server
+import importlib
+import io
 import os
 import sys
 import time
@@ -24,10 +30,26 @@ import webbrowser
 from collections.abc import Hashable
 from dataclasses import dataclass, field
 from enum import IntEnum
-from typing import BinaryIO, Dict, Optional, Tuple
+from types import ModuleType
+from typing import Dict, Optional, Tuple
 
 import perf
 
+# zstd in the standard library, available since Python 3.14. Imported by name so
+# that the script also type checks with older versions.
+try:
+    ZSTD: Optional[ModuleType] = importlib.import_module('compression.zstd')
+except ImportError:
+    ZSTD = None
+
+# Levels that compress traces close to the maximum at a fraction of its cost.
+ZSTD_LEVEL = 9
+GZIP_LEVEL = 6
+
+# The default trace file name, extended with the compression's file extension.
+DEFAULT_OUTPUT = 'perf.pftrace'
+COMPRESSION_EXTENSIONS = {'zstd': '.zst', 'gzip': '.gz', 'none': ''}
+
 # The only port that the Content Security Policy of ui.perfetto.dev allows
 # fetching traces from.
 UI_FETCH_PORT = 9001
@@ -388,7 +410,7 @@ class Sequence:
 class PerfettoWriter:
     """Writes perf samples to a Perfetto trace file."""
 
-    def __init__(self, out: BinaryIO) -> None:
+    def __init__(self, out: io.BufferedIOBase) -> None:
         self.out = out
         self.session: Optional[perf.session] = None
         self.sequences: Dict[str, Sequence] = {}
@@ -523,9 +545,22 @@ class PerfettoWriter:
                            varint_field(TracePacketField.TIMESTAMP_CLOCK_ID, clock))
 
 
-def convert(input_path: str, output_path: str) -> PerfettoWriter:
+def open_output(raw: io.BufferedIOBase, compression: str) -> io.BufferedIOBase:
+    """Returns a file that compresses what is written to it into raw."""
+    if compression == 'zstd':
+        assert ZSTD is not None
+        out: io.BufferedIOBase = ZSTD.ZstdFile(raw, mode='wb', level=ZSTD_LEVEL)
+        return out
+    if compression == 'gzip':
+        # No file name or time in the header, so the output is reproducible.
+        return gzip.GzipFile(filename='', mode='wb', fileobj=raw,
+                             compresslevel=GZIP_LEVEL, mtime=0)
+    return raw
+
+
+def convert(input_path: str, output_path: str, compression: str) -> PerfettoWriter:
     """Converts a perf.data file to a Perfetto trace file."""
-    with open(output_path, 'wb') as out:
+    with open(output_path, 'wb') as raw, open_output(raw, compression) as out:
         writer = PerfettoWriter(out)
         session = perf.session(perf.data(input_path), sample=writer.process_sample)
         writer.session = session
@@ -593,16 +628,31 @@ def main() -> int:
         description='Convert perf.data to a Perfetto trace and open it in the Perfetto UI')
     parser.add_argument('-i', '--input', default='perf.data',
                         help='perf.data file to read (default: perf.data)')
-    parser.add_argument('-o', '--output', default='perf.pftrace',
-                        help='Perfetto trace file to write (default: perf.pftrace)')
+    parser.add_argument('-o', '--output',
+                        help=f'Perfetto trace file to write (default: {DEFAULT_OUTPUT} '
+                        'with the extension of the compression)')
+    parser.add_argument('-c', '--compression', default='auto',
+                        choices=['auto', *COMPRESSION_EXTENSIONS],
+                        help='compression of the trace; auto is zstd if Python has it '
+                        '(3.14 or later), else gzip (default: auto)')
     parser.add_argument('-n', '--no-open', action='store_true',
                         help='only write the trace, do not open it in the Perfetto UI')
     parser.add_argument('--origin', default='https://ui.perfetto.dev',
                         help='Perfetto UI to open the trace in (default: https://ui.perfetto.dev)')
     args = parser.parse_args()
 
+    compression = args.compression
+    if compression == 'auto':
+        compression = 'zstd' if ZSTD is not None else 'gzip'
+    elif compression == 'zstd' and ZSTD is None:
+        print('zstd compression needs Python 3.14 or later, use --compression gzip',
+              file=sys.stderr)
+        return 1
+    if args.output is None:
+        args.output = DEFAULT_OUTPUT + COMPRESSION_EXTENSIONS[compression]
+
     try:
-        writer = convert(args.input, args.output)
+        writer = convert(args.input, args.output, compression)
     except (OSError, TypeError, ValueError) as err:
         # The perf module reports events it cannot handle as TypeError or
         # ValueError. Do not leave a truncated trace behind.
diff --git a/tools/perf/tests/shell/script_perfetto.sh b/tools/perf/tests/shell/script_perfetto.sh
index 87797b377922..503563d77982 100755
--- a/tools/perf/tests/shell/script_perfetto.sh
+++ b/tools/perf/tests/shell/script_perfetto.sh
@@ -47,25 +47,51 @@ if ! perf record -o "${perfdata}" -e cpu-clock -g -- perf test -w noploop > /dev
 fi
 nr_samples=$(perf script -i "${perfdata}" -F tid | wc -l)
 
-echo "Converting ${nr_samples} samples"
-if ! output=$("${PYTHON}" "${script}" --no-open -i "${perfdata}" -o "${trace}"); then
-  echo "perf script perfetto test [Failed: conversion]"
-  exit 1
-fi
-echo "${output}"
+# Writes a trace of any compression the script supports, decompressed, to stdout.
+decompress() {
+  "${PYTHON}" - "$1" <<'PYEOF'
+import gzip, importlib, sys
+data = open(sys.argv[1], 'rb').read()
+if data[:2] == b'\x1f\x8b':
+    data = gzip.decompress(data)
+elif data[:4] == b'\x28\xb5\x2f\xfd':
+    data = importlib.import_module('compression.zstd').decompress(data)
+sys.stdout.buffer.write(data)
+PYEOF
+}
 
-if ! echo "${output}" | grep -q "Wrote ${nr_samples} samples"; then
-  echo "perf script perfetto test [Failed: expected ${nr_samples} samples]"
-  exit 1
-fi
+test_compression() {
+  local compression=$1
 
-# Interned strings are stored as is in the trace, so the source of the samples,
-# the event and the symbol of the workload must all be in there.
-for expected in linux.perf cpu-clock noploop; do
-  if ! grep -q "${expected}" "${trace}"; then
-    echo "perf script perfetto test [Failed: no ${expected} in trace]"
-    exit 1
+  echo "Converting ${nr_samples} samples with ${compression} compression"
+  if ! output=$("${PYTHON}" "${script}" --no-open --compression "${compression}" \
+                -i "${perfdata}" -o "${trace}"); then
+    echo "perf script perfetto test [Failed: ${compression} conversion]"
+    return 1
   fi
+  echo "${output}"
+
+  if ! echo "${output}" | grep -q "Wrote ${nr_samples} samples"; then
+    echo "perf script perfetto test [Failed: expected ${nr_samples} samples]"
+    return 1
+  fi
+
+  # Interned strings are stored as is in the trace, so the source of the
+  # samples, the event and the symbol of the workload must all be in there.
+  for expected in linux.perf cpu-clock noploop; do
+    if ! decompress "${trace}" | grep -qa "${expected}"; then
+      echo "perf script perfetto test [Failed: no ${expected} in ${compression} trace]"
+      return 1
+    fi
+  done
+}
+
+compressions="none gzip auto"
+if "${PYTHON}" -c "import compression.zstd" 2> /dev/null; then
+  compressions="${compressions} zstd"
+fi
+for compression in ${compressions}; do
+  test_compression "${compression}" || exit 1
 done
 
 echo "perf script perfetto test [Success]"
-- 
2.56.0

