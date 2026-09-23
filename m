Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605B74399F2
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790187310; cv=none; b=iYUFG/q0m5TB1TaUFOD6qOT1t51aocb34Dvm+bXuz53X81ui2D5zb+BrfH2YfiT4sZHJOAHKdSwRi9h5lea9Y7c+9u9lwX2LXLGKUi5KmBThkrpXDYHr660NT8EkuSKCTn2kZ5+OkGhQMU+DC32DjCkldbDqP32Kijx+YwiPric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790187310; c=relaxed/simple;
	bh=MbBp/oYb6i0abfuiUj6lJ5H8Q/A0P74CDCKrOns9fTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hznDouCuHLzd3eFGiNqG2j/zPURekoWvzrYhy/pfPveBLnn47Tom5atRm7JQkqSNd/WgW9F5boIYXeNiB0Qw5YM0SeBpIGGL0sMkQhXQSnXJOt59fTginkSYfkbcecv474GNNWcgSTJyVEHyTrWjT0jbBuhEz7E7rdi7PyzDnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H4E4o+wd; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H4E4o+wd"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso1742244eec.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 11:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790187298; x=1790792098; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+vlEIQL+fePrPO2NIgSLLycWAHjFZ7eHFEmjdF//SM=;
        b=H4E4o+wdtuYwiyURB7ER6ApRWCJr464TAMtStWf3U3QwiL1bWdT1RMU6dQiVJzNtrF
         DDn3mPz6FbJlxBicONzWByToIZFSsRFBdmycwcWEIWrLxPh/HJjKUJmcgFDwBGjmDpzY
         3LWHRvZK/tRwta3+bBBW9jcsdzkSIUhwXxDzZjIVAtfR+/3dD92cvIpBlNMUSVkSfB/L
         zdR3auSCbrZ/7OzmpeVtPKoMXbjkKjD4cA7i7pbnK0QFeGiM6M9jgpp9Zx4r1Tn/liZT
         oM5R99gfgHJiyazH/pWf0p+dPfd+cxK5Edc/R9lIC75lMuZR/Y3ADVtOnstxknztUC46
         4T8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790187298; x=1790792098;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b+vlEIQL+fePrPO2NIgSLLycWAHjFZ7eHFEmjdF//SM=;
        b=cELZ4mikiRrs2AemaYP/KCIDR1VXnvTGHpuyKV2cXINkpog6D5ZvfSH2+e/Y6ZdRWZ
         EgGI4ZBbC6bdgXLx5uW8+UBYqU5mQ/3dff7uFlQzvUZkzoHN13Ub6QgehYqIgiZfxRN5
         Xqzlc1LZAGAIw/a648lcHnlc4Wly/rLqH+pcZbjeMnyFzZkNNRLys2R/TEnXJgC51IWp
         B2wnYs9AN8Nd3GasUxV3JOUGRVmzxaxUfD+onWfLSjjc+1OhRnODsmoawiIrIrwxUX1g
         teM8V4Ng6OF3PBkx1JwxL+P3uT94DbTGAyDLcF30ZM3Wqw6bozQeucpAJPuHYkgoxRaR
         9dVQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeqDAJOM5pNQDPccC3pZ0AhKARspPnjW9kiUsSBQXEJcu+t/gNF+h4omTixtvmc59yRI/AO6oFC+4PoTBqtGUA@vger.kernel.org
X-Gm-Message-State: AFuF++k2ICeEfoLb7sXFpNVBhJJSQmjS4n28DOcjwZGKkk+gJlAcbt9E
	GZc5vlMaWz3SJ9XWpjAMBPNGQd3RwPEgj/mQ/qEijyilbQbo+ailRuY0/n9W/74XUd/qBK6MKIr
	Yn6lu8nT42Q==
X-Received: from dlbsj1.prod.google.com ([2002:a05:7022:f901:b0:144:f49f:4928])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2088:10b0:144:fa64:dada
 with SMTP id a92af1059eb24-144fa64dcfemr3026487c88.15.1790187297609; Wed, 23
 Sep 2026 11:14:57 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:12:01 -0700
In-Reply-To: <20260923181213.3032038-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789966896.git.irogers@google.com> <20260923181213.3032038-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Message-ID: <20260923181213.3032038-39-irogers@google.com>
Subject: [PATCH v3 38/49] perf python: Port arm-cs-trace-disasm to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, alice.mei.rogers@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python/
using the perf module directly.

Improvements compared to the legacy script:
- Encapsulate trace disassembly state in a TraceDisasm class
- Automatically search standard kernel debug paths (find_vmlinux())
  when -k/--vmlinux is not specified, and query
  perf.config_get("annotate.objdump") for the default objdump binary.
- Bound DISASM_CACHE memory consumption by evicting the cache at 1024
  entries and skipping caching of oversized (> 512 lines) objdump
  outputs.
- Use sample.srccode() from the perf extension module to annotate
  disassembly output with source filenames, line numbers, and source
  lines.

Update the ARM CoreSight disassembly shell test
(test_arm_coresight_disasm.sh) to invoke the standalone script.

Assisted-by: Antigravity:gemini-3.1-pro
Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/arm-cs-trace-disasm.py      | 389 ++++++++++++++++++
 .../coresight/test_arm_coresight_disasm.sh    |  25 +-
 2 files changed, 407 insertions(+), 7 deletions(-)
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
new file mode 100755
index 000000000000..0d95ef3604eb
--- /dev/null
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -0,0 +1,389 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember using perf python module
+"""
+from __future__ import annotations
+
+import os
+from os import path
+import re
+from subprocess import CalledProcessError, check_output
+import argparse
+import platform
+import sys
+from typing import Dict, List, Optional
+
+import perf
+
+# Initialize global dicts and regular expression
+DISASM_CACHE: Dict[str, List[str]] = {}
+DISASM_RE = re.compile(r"^\s*([0-9a-fA-F]+):")
+DISASM_FUNC_RE = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
+CACHE_SIZE = 1024
+class _State:
+    sample_idx: int = -1
+    source_file_name: Optional[str] = None
+    line_number: Optional[int] = None
+    dso: Optional[str] = None
+
+_STATE = _State()
+
+KVER = platform.release()
+VMLINUX_PATHS = [
+    f"/usr/lib/debug/boot/vmlinux-{KVER}.debug",
+    f"/usr/lib/debug/lib/modules/{KVER}/vmlinux",
+    f"/lib/modules/{KVER}/build/vmlinux",
+    f"/usr/lib/debug/boot/vmlinux-{KVER}",
+    f"/boot/vmlinux-{KVER}",
+    "/boot/vmlinux",
+    "vmlinux",
+]
+
+def default_objdump() -> str:
+    """Return the default objdump path from perf config or 'objdump'."""
+    try:
+        config = perf.config_get("annotate.objdump")
+        return str(config) if config else "objdump"
+    except (AttributeError, TypeError):
+        return "objdump"
+
+def find_vmlinux() -> Optional[str]:
+    """Find the vmlinux file in standard paths."""
+    if hasattr(find_vmlinux, "path"):
+        return getattr(find_vmlinux, "path")
+
+    for v in VMLINUX_PATHS:
+        if os.access(v, os.R_OK):
+            setattr(find_vmlinux, "path", v)
+            return v
+    setattr(find_vmlinux, "path", None)
+    return None
+
+def get_dso_file_path(dso_name: str, dso_build_id: str, vmlinux: Optional[str]) -> str:
+    """Return the path to the DSO file."""
+    # Locate DSO binaries in the perf build-id cache (~/.debug or PERF_BUILDID_DIR).
+    # Perf stores cached binaries under both <buildid_dir>/<dso_long_name>/<build_id>/elf
+    # and the canonical symlink/file layout <buildid_dir>/.build-id/<bid[:2]>/<bid[2:]>/elf.
+    buildid_dir = os.environ.get('PERF_BUILDID_DIR')
+    if not buildid_dir:
+        buildid_dir = os.path.join(os.environ.get('HOME', ''), '.debug')
+
+    if (dso_name in ("[kernel.kallsyms]", "vmlinux", "kcore")
+            or dso_name.endswith("/vmlinux") or dso_name.endswith("/kcore")):
+        if vmlinux:
+            return vmlinux
+        if dso_build_id and dso_build_id != "[unknown]" and len(dso_build_id) > 2:
+            bid_candidate = os.path.join(
+                buildid_dir, ".build-id", dso_build_id[:2], dso_build_id[2:], "elf"
+            )
+            if os.access(bid_candidate, os.R_OK):
+                return bid_candidate
+            for kname in (dso_name, "vmlinux", "[kernel.kallsyms]"):
+                candidate = os.path.join(buildid_dir, kname.lstrip("/"), dso_build_id, "elf")
+                if os.access(candidate, os.R_OK):
+                    return candidate
+        return find_vmlinux() or dso_name
+
+    if dso_name == "[vdso]":
+        append = "/vdso"
+    else:
+        append = "/elf"
+
+    if dso_build_id and dso_build_id != "[unknown]" and len(dso_build_id) > 2:
+        bid_path = (buildid_dir + "/.build-id/" + dso_build_id[:2] + "/"
+                    + dso_build_id[2:] + append).replace('//', '/')
+        if os.access(bid_path, os.R_OK):
+            return bid_path
+
+    dso_path = buildid_dir + "/" + dso_name + "/" + dso_build_id + append
+    # Replace duplicate slash chars to single slash char
+    dso_path = dso_path.replace('//', '/')
+    return dso_path
+
+def read_disam(dso_fname: str, dso_start: int, start_addr: int,
+               stop_addr: int, objdump: str) -> List[str]:
+    """Read disassembly from a DSO file using objdump."""
+    if stop_addr <= start_addr or (stop_addr - start_addr) > 0x100000:
+        return []
+    addr_range = f"{start_addr}:{stop_addr}:{dso_start}:{dso_fname}"
+
+    # Don't let the cache get too big, clear it when it hits max size
+    if len(DISASM_CACHE) > CACHE_SIZE:
+        DISASM_CACHE.clear()
+
+    if addr_range in DISASM_CACHE:
+        disasm_output = DISASM_CACHE[addr_range]
+    else:
+        start_addr = start_addr - dso_start
+        stop_addr = stop_addr - dso_start
+        disasm = [objdump, "-d", "-z",
+                  f"--start-address={start_addr:#x}",
+                  f"--stop-address={stop_addr:#x}"]
+        disasm += [dso_fname]
+        try:
+            disasm_output = check_output(disasm).decode('utf-8', errors='replace').split('\n')
+        except (CalledProcessError, OSError):
+            return []
+        if len(disasm_output) <= 512:
+            DISASM_CACHE[addr_range] = disasm_output
+
+    return disasm_output
+
+def print_disam(dso_fname: str, dso_start: int, start_addr: int,
+                stop_addr: int, objdump: str) -> None:
+    """Print disassembly for a given address range."""
+    for line in read_disam(dso_fname, dso_start, start_addr, stop_addr, objdump):
+        m = DISASM_FUNC_RE.search(line)
+        if m is None:
+            m = DISASM_RE.search(line)
+            if m is None:
+                continue
+        print(f"\t{line}")
+
+def print_sample(sample: perf.sample_event) -> None:
+    """Print sample details."""
+    print(f"Sample = {{ cpu: {sample.sample_cpu:04d} addr: {sample.sample_addr:016x} "
+          f"phys_addr: {sample.sample_phys_addr:016x} ip: {sample.sample_ip:016x} "
+          f"pid: {sample.sample_pid} tid: {sample.sample_tid} period: {sample.sample_period} "
+          f"time: {sample.sample_time} index: {_STATE.sample_idx}}}")
+
+def common_start_str(comm: str, sample: perf.sample_event) -> str:
+    """Return common start string for sample output."""
+    sec = int(sample.sample_time / 1000000000)
+    ns = sample.sample_time % 1000000000
+    cpu = sample.sample_cpu
+    pid = sample.sample_pid
+    tid = sample.sample_tid
+    return f"{comm:>16s} {pid:5d}/{tid:<5d} [{cpu:04d}] {sec:9d}.{ns:09d}  "
+
+def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso: str) -> None:
+    """Print source code and symbols for a sample."""
+    ip = sample.sample_ip
+    if symbol == "[unknown]":
+        start_str = common_start_str(comm, sample) + f"{ip:x}".rjust(16).ljust(40)
+    else:
+        symoff = 0
+        symoff = getattr(sample, 'sym_offset', 0) or 0
+        offs = f"+{symoff:#x}" if symoff != 0 else ""
+        start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
+
+    source_file_name, line_number, source_line = sample.srccode() or (None, 0, None)
+    if source_file_name:
+        if _STATE.line_number == line_number and _STATE.source_file_name == source_file_name:
+            src_str = ""
+        else:
+            if len(source_file_name) > 40:
+                src_file = f"...{source_file_name[-37:]} "
+            else:
+                src_file = source_file_name.ljust(41)
+
+            if source_line is None:
+                src_str = f"{src_file}{line_number:>4d} <source not found>"
+            else:
+                src_str = f"{src_file}{line_number:>4d} {source_line}"
+        _STATE.dso = None
+    elif dso == _STATE.dso:
+        src_str = ""
+    else:
+        src_str = dso
+        _STATE.dso = dso
+
+    _STATE.line_number = line_number
+    _STATE.source_file_name = source_file_name
+
+    print(start_str, src_str)
+
+class TraceDisasm:
+    """Class to handle trace disassembly."""
+    def __init__(self, cli_options: argparse.Namespace):
+        self.options = cli_options
+        self.sample_idx = -1
+        self.cpu_data: Dict[str, int] = {}
+        self.session: Optional[perf.session] = None
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Process a single perf event."""
+        self.sample_idx += 1
+        _STATE.sample_idx = self.sample_idx
+
+        if self.options.start_time is not None and sample.sample_time < self.options.start_time:
+            return
+        if self.options.stop_time is not None and sample.sample_time > self.options.stop_time:
+            sys.exit(0)
+        if self.options.start_sample is not None and self.sample_idx < self.options.start_sample:
+            return
+        if self.options.stop_sample is not None and self.sample_idx > self.options.stop_sample:
+            sys.exit(0)
+
+        ev_name = str(sample.evsel)
+        if self.options.verbose:
+            print(f"Event type: {ev_name}")
+            print_sample(sample)
+
+        dso = getattr(sample, 'dso_long_name', None) or sample.dso or '[unknown]'
+        symbol = sample.symbol or '[unknown]'
+        dso_bid = (sample.dso_bid.decode('utf-8')
+                   if isinstance(sample.dso_bid, bytes)
+                   else str(sample.dso_bid or '[unknown]'))
+        dso_start = sample.map_start
+        dso_end = sample.map_end
+        map_pgoff = sample.map_pgoff or 0
+
+        comm = "[unknown]"
+        try:
+            if self.session:
+                thread_info = self.session.find_thread(sample.sample_pid, sample.sample_tid)
+                if thread_info:
+                    comm = thread_info.comm() or "[unknown]"
+        except (TypeError, AttributeError):
+            pass
+
+        if dso == '[unknown]':
+            return
+
+        if dso_start is None or dso_end is None:
+            print(f"Failed to find valid dso map for dso {dso}")
+            return
+
+        if "instructions" in ev_name:
+            print_srccode(comm, sample, symbol, dso)
+            return
+
+        if "branches" not in ev_name:
+            return
+
+        self._process_branch(sample, comm, symbol, dso, dso_bid, dso_start, dso_end, map_pgoff)
+
+    def _process_branch(self, sample: perf.sample_event, comm: str, symbol: str, dso: str,
+                        dso_bid: str, dso_start: int, dso_end: int, map_pgoff: int) -> None:
+        """Helper to process branch events."""
+        cpu = sample.sample_cpu
+        ip = sample.sample_ip
+        addr = sample.sample_addr
+
+        if self.cpu_data.get(str(cpu) + 'addr') is None:
+            self.cpu_data[str(cpu) + 'addr'] = addr
+            return
+
+        start_addr = self.cpu_data[str(cpu) + 'addr']
+        stop_addr  = ip + 4
+
+        # Record for previous sample packet
+        self.cpu_data[str(cpu) + 'addr'] = addr
+
+        # Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
+        if start_addr == 0:
+            if stop_addr == 4 and self.options.verbose:
+                print(f"CPU{cpu}: CS_ETM_TRACE_ON packet is inserted")
+            return
+
+        if start_addr < dso_start or start_addr > dso_end:
+            print(f"Start address {start_addr:#x} is out of range [ {dso_start:#x} .. "
+                  f"{dso_end:#x} ] for dso {dso}")
+            return
+
+        if stop_addr < dso_start or stop_addr > dso_end:
+            print(f"Stop address {stop_addr:#x} is out of range [ {dso_start:#x} .. "
+                  f"{dso_end:#x} ] for dso {dso}")
+            return
+
+        if self.options.objdump is not None:
+            # Kernel images (vmlinux / kcore) and non-PIE executables linked at
+            # the default 0x400000 base already have their virtual load addresses
+            # baked into the ELF symbol/section headers read by objdump, so
+            # dso_vm_start and map_pgoff_local must be 0 to avoid subtracting
+            # map_start from virtual sample addresses.
+            if (dso in ("[kernel.kallsyms]", "vmlinux", "kcore")
+                    or dso.endswith("/vmlinux") or dso.endswith("/kcore")):
+                dso_vm_start = 0
+                map_pgoff_local = 0
+            elif dso_start == 0x400000:
+                dso_vm_start = 0
+                map_pgoff_local = 0
+            else:
+                dso_vm_start = dso_start
+                map_pgoff_local = map_pgoff
+
+            dso_fname = get_dso_file_path(dso, dso_bid, self.options.vmlinux)
+            if path.exists(dso_fname):
+                print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff_local,
+                            stop_addr + map_pgoff_local, self.options.objdump)
+            else:
+                print(f"Failed to find dso {dso} for address range [ "
+                      f"{start_addr + map_pgoff_local:#x} .. {stop_addr + map_pgoff_local:#x} ]")
+
+        print_srccode(comm, sample, symbol, dso)
+
+    def run(self) -> None:
+        """Run the trace disassembly session."""
+        input_file = self.options.input or "perf.data"
+        if input_file != "-" and not os.path.exists(input_file):
+            print(f"Error: {input_file} not found.", file=sys.stderr)
+            sys.exit(1)
+
+        print('ARM CoreSight Trace Data Assembler Dump')
+        try:
+            session_kwargs = {
+                "sample": self.process_event,
+                "itrace": self.options.itrace,
+            }
+            if self.options.vmlinux:
+                session_kwargs["vmlinux"] = self.options.vmlinux
+            try:
+                self.session = perf.session(perf.data(input_file), **session_kwargs)
+            except TypeError:
+                session_kwargs.pop("vmlinux", None)
+                self.session = perf.session(perf.data(input_file), **session_kwargs)
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        try:
+            self.session.process_events()
+        except (KeyboardInterrupt, SystemExit):
+            pass
+        finally:
+            # Break the reference cycle between self.session and the bound
+            # self.process_event callback so the C perf.session object is freed.
+            self.session = None
+        print('End')
+
+if __name__ == "__main__":
+    def int_arg(v: str) -> int:
+        """Helper for integer command line arguments."""
+        val = int(v)
+        if val < 0:
+            raise argparse.ArgumentTypeError("Argument must be a positive integer")
+        return val
+
+    arg_parser = argparse.ArgumentParser(description="ARM CoreSight Trace Dump With Disassembler")
+    arg_parser.add_argument("-i", "--input", help="input perf.data file")
+    arg_parser.add_argument("-k", "--vmlinux", default=os.environ.get("PERF_SYMBOL_VMLINUX"),
+                            help="Set path to vmlinux file. Omit to autodetect")
+    arg_parser.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
+                            help="Show disassembly. Can also be used to change the objdump path")
+    arg_parser.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+    arg_parser.add_argument("--start-time", type=int_arg,
+                            help="Monotonic clock time of sample to start from.")
+    arg_parser.add_argument("--stop-time", type=int_arg,
+                            help="Monotonic clock time of sample to stop at.")
+    arg_parser.add_argument("--itrace", default="b",
+                            help="Instruction tracing options.")
+    arg_parser.add_argument("--start-sample", type=int_arg,
+                            help="Index of sample to start from.")
+    arg_parser.add_argument("--stop-sample", type=int_arg,
+                            help="Index of sample to stop at.")
+
+    parsed_options = arg_parser.parse_args()
+    if (parsed_options.start_time is not None and parsed_options.stop_time is not None and
+            parsed_options.start_time >= parsed_options.stop_time):
+        print("--start-time must less than --stop-time")
+        sys.exit(2)
+    if (parsed_options.start_sample is not None and parsed_options.stop_sample is not None and
+            parsed_options.start_sample >= parsed_options.stop_sample):
+        print("--start-sample must less than --stop-sample")
+        sys.exit(2)
+
+    td = TraceDisasm(parsed_options)
+    td.run()
diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
index f3ebad596378..2c04249a3496 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# Check Arm CoreSight disassembly script completes without errors (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# Check Arm CoreSight disassembly script completes without errors (exclusive)
 
 # The disassembly script reconstructs ranges of instructions and gives these to objdump to
 # decode. objdump doesn't like ranges that go backwards, but these are a good indication
@@ -20,11 +20,23 @@ skip_if_no_cs_etm_event || exit 2
 set -e
 glb_err=1
 
+# Relative path works whether it's installed or running from repo
+if [ -n "$PERF_EXEC_PATH" ] && [ -e "$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py" ]; then
+	script_path="$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py"
+else
+	script_path=$(dirname "$0")/../../../python/arm-cs-trace-disasm.py
+fi
+
+# shellcheck source=lib/setup_python.sh
+. "$(dirname "$0")"/../lib/setup_python.sh
+$PYTHON -c "import perf" 2>/dev/null || {
+	echo "Skipping test, perf python module not found"
+	exit 2
+}
+
 perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
 perfdata=${perfdata_dir}/perf.data
 file=$(mktemp /tmp/temporary_file.XXXXX)
-# Relative path works whether it's installed or running from repo
-script_path=$(dirname "$0")/../../../scripts/python/arm-cs-trace-disasm.py
 
 cleanup_files()
 {
@@ -44,8 +56,8 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
 if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
-	perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
-		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
+	$PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
+		-k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -56,8 +68,7 @@ fi
 ## Test user ##
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
-perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
-	-d --stop-sample=2 2> /dev/null > ${file}
+$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=2 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
 
-- 
2.56.0.rc1.310.g51773c2048-goog

