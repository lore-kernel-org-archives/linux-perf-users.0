Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F64854E6
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 15:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844272; cv=none; b=bX7VliSoVrYY9v1hyRu3i8tXjhYEnfhp46U142RrNjBC29GD9DXJMQjS17M+vnfoVbep3Ccx0dkOKFvnBmZVmXGeODlkyU+0GJfc9DnJe6wUedg9dz9N2n4CMC9wUhuenuTD5epAJuDPGkkn4RGaSwju47KTrc1OT/vFAW8Zs/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844272; c=relaxed/simple;
	bh=vzah4bqF+Lfew+OKBpRErTO4subNKLNmzwZmD0fElkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEJH1BCTcA8qFPiHGaV5xRf371hHJ0ksecPZT8JwV/Qiz6CDbBWAmlfDdrgIDZYsYVAuwPktV9fjr/sST7ebVgwiSWvmsQaL9u6H6aq6SK0ukb258HA5lRe+BFo+l2wYRV9HMXfk4TTQ9qENqjXREEBE23vUfxN++QBDxoZscPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZp8O3xI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZp8O3xI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47fe89fb333so514995f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Aug 2026 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787844268; x=1788449068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTh0rnqQk3El8Bu4a5ISnvU8jQ6KkdLOSk98JRd6Qjg=;
        b=UZp8O3xIZH1B5TUTHlcJto6c1u3gvesgG3Oql9RKd3CeP9ReCGgl4wWLHP+mzfJDQ2
         rWmPBlS9/uMrP0HX9Q8a5wKEjJcoEUpUJO2aoAQAlFziAkQg0b8nTW5Y8U1J6M1lfw6I
         p9HLxok1k12NQ4XK9SxqaYRkCwmNnJCacxEc/wlssiC/FEoE/YotPbMFWL9Y3bTe93XL
         ERAMpxF3onYsgcAU3a9qqes/LJvEuksgdkveEiPJEI5G94Es+fo7DljU+wnATnDaKQyZ
         S9OgdmOw75p0A9OhxyfGAe+4IUHktg5F1dlOtqPrYePESGCNd0g/bvJSeB8XtfO7e5sa
         0NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787844268; x=1788449068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTh0rnqQk3El8Bu4a5ISnvU8jQ6KkdLOSk98JRd6Qjg=;
        b=ZngP/bOrAegDc+yrhzawYPqJTDzbpsXQDxn5GQaYRDO7xa8StGRQU+RKxST0V2/n+R
         SGUR9NNClCrLPa5a0zmheExuDUmCL2+TmPl/iTT5E8BPsZvD+QYf96dPlJTbjvCETkJK
         wb9jmCMRLD4qGIiUn8rdGA0TURbMv+rFybzO+rwkttfirZ400vb1oFJVDph7F9Wd9/EW
         TQeIs+KL/I/iuH9845dUzEVb+pm1AZRnk1HVK1O1QEL3Un6+fcv69vLDTOthk+bYuxzu
         CLOoiSdWwY6cSzYXvb5/Q45NjBcvZ3UQDpjwf1/DIbBZJ8X5DsTPHWuuXB9yrFJXOmnU
         jweA==
X-Gm-Message-State: AFuF++luBVluUmzz8oWZupUzZZYrqzcQuA1s5DXU9oTT3aC+2oieolhg
	ShzZEjh2mldtz6i+LHlbHfzw95/ovo+ljHtMOcZ6bOFTF+UYWH7vWXhy
X-Gm-Gg: AR+sD11tB/iXc0RSK8W+6TUeKvCdpOvBq33gz6X+FblzSrgCtPzvCwcyzFhl+ZLSKOw
	Gm8Syc6/Y6Mo/BN+Y+x3ypa+WF/DHIv5ZgU6lOnhDhBdifb5VPuGm7IStKTfVPDinV93vz/6yZS
	n1CId8RdBCkCt/Er36ArZF7WZhXoRXkscvMO7Dx7A8iANgKh1waFlKpxxdOlhr0bxEUo/AnTJ2l
	KRZe7QwbbuWsHwmLYM0dK67ZyjTWK/ac7oBcJVxCfefcteWM53GNRMuTWi2sJhI8KroQYnNoW8I
	yVA2gjLT/EqK052O4PDvgYkU8KAm7GcMR9CSI9sRFpO+tha5kU/a/q7VNAF4TRLhqJAaa7oZNBh
	uz4t4RmTQGN+ROROiic4U+NvEKR0zsUZbFki9coVpc7rXodl5xA/VgbVxTVEL3F/977sKnx+6vX
	Mj3V1ZjjZUVGS87l9SuVDJIYoKSJa2kP4XoB0FuUQ3hbw1zOEa+EtpDRJ8J0IgKHoOX28A3ZZq8
	j/ZwzqdoksqJ/RZg+XFV/Y=
X-Received: by 2002:a05:600c:a43:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-499dc717e27mr174885955e9.9.1787844268027;
        Thu, 27 Aug 2026 08:24:28 -0700 (PDT)
Received: from amwld-tmagires1.us.drwholdings.com ([149.14.21.6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e27ab1f3sm10257371f8f.11.2026.08.27.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 08:24:27 -0700 (PDT)
From: Tudor-Stefan Magirescu <tudor.magirescu@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tudor.magirescu@gmail.com
Subject: [RFC PATCH v2 1/1] perf scripts flamegraph: Add --asm option
Date: Thu, 27 Aug 2026 17:23:54 +0200
Message-ID: <20260827152354.1513813-2-tudor.magirescu@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827152354.1513813-1-tudor.magirescu@gmail.com>
References: <20260821090555.1B6DC1F000E9@smtp.kernel.org>
 <20260827152354.1513813-1-tudor.magirescu@gmail.com>
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
 tools/perf/scripts/python/flamegraph.py | 161 ++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/tools/perf/scripts/python/flamegraph.py b/tools/perf/scripts/python/flamegraph.py
index ad735990c5be..60ace98e73ad 100755
--- a/tools/perf/scripts/python/flamegraph.py
+++ b/tools/perf/scripts/python/flamegraph.py
@@ -19,14 +19,18 @@
 # pylint: disable=missing-function-docstring
 
 import argparse
+from dataclasses import dataclass
 import hashlib
 import io
 import json
 import os
+import re
 import subprocess
 import sys
 from typing import Dict, Optional, Union
 import urllib.request
+from perf_trace_context import perf_config_get
+
 
 MINIMAL_HTML = """<head>
   <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/d3-flame-graph@4.1.3/dist/d3-flamegraph.css">
@@ -67,10 +71,146 @@ class Node:
         }
 
 
+@dataclass
+class Symbol:
+    start: int
+    size: int
+
+
+@dataclass
+class ResolvedDso:
+    symtab_file: Optional[str]
+    code_file:   Optional[str]
+
+
+class Instructions:
+    def __init__(self):
+        self.symbols:       dict[str, dict[str, Symbol]] = {}
+        self.instructions:  dict[tuple[str, str], dict[int, str]] = {}
+        self.resolved_dsos: dict[str, ResolvedDso] = {}
+        self.disasm_re:     re.Pattern = re.compile(r"^\s+([0-9a-f]+):\s+(.*)")
+        self.symtab_re:     re.Pattern = re.compile(
+            r"^([0-9a-f]+) (.{7})\s+\S+\s+([0-9a-f]+)\s+(.*)$")
+        self.objdump:       Optional[str] = self.default_objdump()
+
+    @staticmethod
+    def resolve_dso(dso_bid: str, filenames: tuple[str, str]) -> Optional[str]:
+        buildid_dir = os.environ.get('PERF_BUILDID_DIR',
+                                     os.path.expanduser('~/.debug'))
+        for filename in filenames:
+            path = (f"{buildid_dir}/.build-id/"
+                    f"{dso_bid[:2]}/{dso_bid[2:]}/{filename}")
+            if os.path.isfile(path):
+                return path
+        return None
+
+    @staticmethod
+    def default_objdump() -> Optional[str]:
+        config = perf_config_get("annotate.objdump")
+        cmd = config if config else "objdump"
+        try:
+            subprocess.run([cmd, "--version"], capture_output=True, check=False)
+        except FileNotFoundError as err:
+            print(f"Error running objdump: {err}; "
+                  "instruction annotations will be skipped", file=sys.stderr)
+            return None
+        return cmd
+
+    def load_symbols(self, resolved_dso: str) -> dict[str, Symbol]:
+        result = subprocess.run(
+            [self.objdump, "--demangle", "-t", resolved_dso],
+            capture_output=True, text=True, check=False
+        )
+
+        if result.returncode != 0:
+            return {}
+
+        symbols: dict[str, Symbol] = {}
+
+        for line in result.stdout.splitlines():
+            match = self.symtab_re.match(line)
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
+    def load_instructions(self, resolved_dso: str, sym: Symbol) -> dict[int, str]:
+        result = subprocess.run(
+            [
+                self.objdump, "-d",
+                "--no-show-raw-insn",
+                f"--start-address=0x{sym.start:x}",
+                f"--stop-address=0x{sym.start + sym.size:x}",
+                resolved_dso,
+            ],
+            capture_output=True, text=True, check=False
+        )
+
+        instructions: dict[int, str] = {}
+
+        for line in result.stdout.splitlines():
+            match = self.disasm_re.match(line)
+            if not match:
+                continue
+            addr = int(match.group(1), 16)
+            instruction = match.group(2).strip()
+            instructions[addr] = instruction
+
+        return instructions
+
+    def lookup_instruction(self, dso: str, dso_bid: str, func: str,
+                           off: int) -> Optional[tuple[int, Optional[str]]]:
+        if self.objdump is None:
+            return None
+
+        if dso not in self.resolved_dsos:
+            self.resolved_dsos[dso] = ResolvedDso(
+                symtab_file=self.resolve_dso(dso_bid, ('debug', 'elf')),
+                code_file=self.resolve_dso(dso_bid, ('elf', 'debug')),
+            )
+
+        resolved_dso = self.resolved_dsos[dso]
+        if resolved_dso.symtab_file is None or resolved_dso.code_file is None:
+            return None
+
+        if (dso, func) in self.instructions:
+            addr = self.symbols[dso][func].start + off
+            return (addr, self.instructions[(dso, func)].get(addr))
+
+        if dso not in self.symbols:
+            self.symbols[dso] = self.load_symbols(resolved_dso.symtab_file)
+
+        sym = self.symbols[dso].get(func)
+        if sym is None:
+            return None
+
+        self.instructions[(dso, func)] = self.load_instructions(resolved_dso.code_file, sym)
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
@@ -119,6 +259,23 @@ class FlameGraphCLI:
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
+            dso_bid  = event.get("dso_bid")
+
+            if sym_name and sym_off is not None and dso and dso_bid:
+                found = self.instructions.lookup_instruction(dso, dso_bid, sym_name, sym_off)
+                if found is not None:
+                    addr, instruction = found
+                    name = f"{instruction} [0x{addr:x}]" if instruction else f"[0x{addr:x}]"
+                    libtype = self.get_libtype_from_dso(dso)
+                    node = self.find_or_create_node(node, name, libtype)
         node.value += 1
 
     def get_report_header(self) -> str:
@@ -259,6 +416,10 @@ if __name__ == "__main__":
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

