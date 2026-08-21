Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAF228C2BF
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302393; cv=none; b=FAiPO9sIwpd1EnVO6pJ81dLVHjeOSmAnCk3aReP2D+LdbqMuydUUTCuus3ef+JuwH71xvhjHIS2h0nqloJudead4Tmn5RRLPaiZXs1PTbPlEvkWhqBx2IKtJDZxxYdMFhCOOB13fnzsMvTakDWXu9qp71RgzSIIarDeYnZdswag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302393; c=relaxed/simple;
	bh=g9uW7vvpoz4UGuYFYljPJ8v+4ecwdoXeakS2Z0Nwi+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRRYqeZgL32yBeXxe9xtoZ5uiYa/IxPkT6kB9VQ+u+6Fq9dRuF3hfqjqtb3SY/XdPm1nCaOrVo27Lavzi8xG4bqh2wPMnFYdA0b/ghI+7IFNQjzB4M25my3pUmvzxFo1bWcARIzeldSd/8BrvRVMN+2o9X+dMvYC2D9Qs5Ig+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2OoAXUk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2OoAXUk"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so541339f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787302390; x=1787907190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rVFk6e2u37aNi/Yv6Vtl1AMCTMYHsSeRuZzfxsO9ww=;
        b=i2OoAXUkUpV0VwpjE+vTTXWM0qD25h614dw1G27IUyST43woZMUFR2mXFHRq+CiY0l
         iWqBOVoKjWwCGIFLtZqXGQt2kfNU2TVsTiNMKSqA3iB/yc0vL0KU0ENsXuxiJiSqtBYH
         9wULgKbSZ5/9FGLprcRq44s8oShceQvjPGMM3l5fdbt773UW63HYErt78RB109ima8mR
         a7gBQ8grUCDTkxouyzUKd9Hiplcp+uZYFX1vJhbm0+t4qHLJwyPFy4KKDeWv1lQo5FDW
         4CZDk0EVn4JLrwkCxYEuy1WZMdEeqHoMv7VRAIQCJNVsgjMHFkeiqSbwsV42LoN2CPqR
         Z3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302390; x=1787907190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rVFk6e2u37aNi/Yv6Vtl1AMCTMYHsSeRuZzfxsO9ww=;
        b=iX+q6yaHFQYZm/Ve8UmoWrxqEmMHrkkwR/jz1+jpi4kvVeWQgsBSM4NjWYijD970LU
         KGjdXD7pPudMNb6J3OWqqhAPGftIXwQLyJ0I/4xD2FMHe69DuEGX8Gu3Frw8+f02n+is
         Z4e15odWCdC9+kzMhGfBAzTC0KLogSDVuSZLpZb4L6o5g4AErLZRsCoxtsN38idEw3qw
         ft4vrBwOXUwG6odcQ6lZ2SRQXnI+nMw4cZ4k+CFxyKLy7de/TZpjrrf/yDcPWgt/PuA9
         DJRM6lK1fbP1Z38Q0EeBzNrxW0mFpvfiQD9crUFGaGunc5+Qq7CVlhrjRraicaYZYA3B
         A5hQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp9sxMnzmLpJA6URcGccCYzw5HT+yJrqBgiP4fn8VeTtu8VXSxOlT/khJZcPyrts7ZKHS9RX29uagpvn6oCypVd@vger.kernel.org
X-Gm-Message-State: AOJu0YwNbRzo2acJML36J23H6yWpgh8dFV+o43IHUC18gIW6Upc4KDIE
	O6ajl+Ejtt3BVDZUKLOrDAqwvjzvLt03T2jeWoTWhGPzNFnCL+xOwxTe
X-Gm-Gg: AR+sD12lpjVbkNHlnawLy8b1X0q/GppQW2BozO0vUtKsI3i3QvGk7h9VFf6toxx/4/C
	+YlaLf/qt3Mnf8rsFBDhhgckFeoAtz86My/eH5J9c3iUJ/bS0CU9/8rJ/EGTB7Dq21j+n6izJ/f
	X/LDX1FAz1E8IIPvE1tj9ZzD2TKkyVOjev7XU56kemEsEAT3oaYqib2HSRzOfdlLfQdWxlEeBVD
	qlmu89qr8VzObpzSHQoOaek0J8w1Jkd4Up+yO49z6VmXAGA0/OtDG14nDBJ0he4QAqpvk79PzKG
	ZN8YvHSxW2zAzeLrSYYbm6tQQT5SUhNN252h4Xtkr+WbZiXGG0bw/Y0ylQW3c1BLGSzRtIu/j4E
	asO2A7pDK3cOuvWtqogJlxx43CG777vr0vZ9Y5NVqRibEP6S6mD2VBTtA4HcvzO2CGyc4NvD8Ih
	IwtIl29Tit7ZhOlOywg1n4hyQvCPfvsNfTQSaclJoVNXWhA8xi2o3mDsOwcSuWRNrpYHFTFF41y
	pkTTTgSU+T0y2yRu8gGwiXYohq/Ixk0Jw==
X-Received: by 2002:a05:600d:6401:10b0:499:bdf1:7578 with SMTP id 5b1f17b1804b1-499bdf1758fmr8328125e9.3.1787302390083;
        Fri, 21 Aug 2026 01:53:10 -0700 (PDT)
Received: from amwld-tmagires1.us.drwholdings.com ([149.14.21.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b7d23sm17004585f8f.22.2026.08.21.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:53:09 -0700 (PDT)
From: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
Subject: [RFC PATCH 1/1] perf scripts flamegraph: Add --asm option
Date: Fri, 21 Aug 2026 10:50:44 +0200
Message-ID: <20260821085044.982835-2-tudor.magirescu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821085044.982835-1-tudor.magirescu@gmail.com>
References: <20260821085044.982835-1-tudor.magirescu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flamegraph script reports samples at function granularity, so a wide
frame shows which function is hot but not which part of it. Obtaining
that requires perf annotate, which reports per-instruction counts without
the calling context of a flame graph.

Add an --asm option to emit more fine-grained flame graphs by including
instruction-level information. By enabling this option, instructions
appear as the leaves in the flame graph call stacks:

main
  a(int)
    imul   $0x3b9aca07,%rax,%rdx [0x13ad]

Signed-off-by: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
---
 tools/perf/scripts/python/flamegraph.py | 120 ++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index ad735990c5be..424919e24aed 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -19,14 +19,23 @@
 # pylint: disable=missing-function-docstring
 
 import argparse
+from dataclasses import dataclass
 import hashlib
 import io
 import json
 import os
 import subprocess
 import sys
+import re
 from typing import Dict, Optional, Union
 import urllib.request
+from perf_trace_context import perf_config_get
+
+
+def default_objdump():
+    config = perf_config_get("annotate.objdump")
+    return config if config else "objdump"
+
 
 MINIMAL_HTML = """<head>
   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
@@ -67,10 +76,101 @@ class Node:
         }
 
 
+@dataclass
+class Symbol:
+    start: int
+    size: int
+
+
+class Instructions:
+    def __init__(self):
+        self.symbols:      dict[str, dict[str, Symbol]] = {}
+        self.instructions: dict[tuple[str, str], dict[int, str]] = {}
+        self.objdump_line: re.Pattern = re.compile(r"^\s+([0-9a-f]+):\s+(.*)")
+        self.symbol_line: re.Pattern = re.compile(
+            r"^([0-9a-f]+) (.{7})\s+\S+\s+([0-9a-f]+)\s+(.*)$")
+        self.objdump:      str = default_objdump()
+
+    def load_symbols(self, dso: str) -> dict[str, Symbol]:
+        result = subprocess.run(
+            [self.objdump, "--demangle", "-t", dso],
+            capture_output=True, text=True, check=False
+        )
+
+        if result.returncode != 0:
+            return {}
+
+        symbols: dict[str, Symbol] = {}
+
+        for line in result.stdout.splitlines():
+            match = self.symbol_line.match(line)
+            if not match:
+                continue
+
+            value, flags, size_str, name = match.groups()
+            # the 7th flag column holds the symbol type, "F" for a function
+            if flags[6] != "F":
+                continue
+
+            size = int(size_str, 16)
+            if size == 0:
+                continue
+
+            # a name may be preceded by its visibility
+            parts = name.split(maxsplit=1)
+            if len(parts) == 2 and parts[0] in (".hidden", ".protected",
+                                                ".internal"):
+                name = parts[1]
+
+            symbols[name.strip()] = Symbol(start=int(value, 16), size=size)
+
+        return symbols
+
+    def load_instructions(self, dso: str, sym: Symbol) -> dict[int, str]:
+        result = subprocess.run(
+            [
+                self.objdump, "-d",
+                "--no-show-raw-insn",
+                f"--start-address=0x{sym.start:x}",
+                f"--stop-address=0x{sym.start + sym.size:x}",
+                dso,
+            ],
+            capture_output=True, text=True, check=False
+        )
+
+        instructions: dict[int, str] = {}
+
+        for line in result.stdout.splitlines():
+            match = self.objdump_line.match(line)
+            if not match:
+                continue
+            addr = int(match.group(1), 16)
+            insn = match.group(2).strip()
+            instructions[addr] = insn
+
+        return instructions
+
+    def lookup_instruction(self, dso: str, func: str,
+                           off: int) -> Optional[tuple[int, Optional[str]]]:
+        if dso not in self.symbols:
+            self.symbols[dso] = self.load_symbols(dso)
+
+        sym = self.symbols[dso].get(func)
+        if sym is None:
+            return None
+
+        if (dso, func) not in self.instructions:
+            self.instructions[(dso, func)] = self.load_instructions(dso, sym)
+
+        addr = sym.start + off
+        return (addr, self.instructions[(dso, func)].get(addr))
+
+
 class FlameGraphCLI:
     def __init__(self, args):
         self.args = args
         self.stack = Node("all", "root")
+        self.instructions = Instructions() if args.asm else None
 
     @staticmethod
     def get_libtype_from_dso(dso: Optional[str]) -> str:
@@ -119,6 +219,22 @@ class FlameGraphCLI:
             name = event.get("symbol", "[unknown]")
             libtype = self.get_libtype_from_dso(event.get("dso"))
             node = self.find_or_create_node(node, name, libtype)
+
+        if self.args.asm:
+            # use the sample IP directly rather than callchain[0], since with
+            # precise event recording (i.e. :pp) the top callchain entry may
+            # point to the next instruction rather than the sampled IP
+            sym_name = event.get("symbol")
+            sym_off  = event.get("symoff")
+            dso      = event.get("dso")
+
+            if sym_name and sym_off is not None and dso:
+                found = self.instructions.lookup_instruction(dso, sym_name, sym_off)
+                if found is not None:
+                    addr, insn = found
+                    name = f"{insn} [0x{addr:x}]" if insn else f"[0x{addr:x}]"
+                    libtype = self.get_libtype_from_dso(dso)
+                    node = self.find_or_create_node(node, name, libtype)
         node.value += 1
 
     def get_report_header(self) -> str:
@@ -259,6 +375,10 @@ if __name__ == "__main__":
                         dest="event_name",
                         type=str,
                         help="specify the event to generate flamegraph for")
+    parser.add_argument("--asm",
+                        default=False,
+                        action="store_true",
+                        help="annotate leaf frames with instruction-level nodes")
 
     cli_args = parser.parse_args()
     cli = FlameGraphCLI(cli_args)
-- 
2.43.0

