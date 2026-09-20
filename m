Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DB03E51F8
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 05:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789881830; cv=none; b=NpV4ONCEVaLSaauBCvu+6qf3JEH6dMKbNZEzMCvbRTLpXf+uawoUEmcOjOWGoPzT3K0jjeWiXNqgNH21lzGQwOBpxhwokEquw2hiQf9g6/rPaJ27EueyZG7DLMH7jsbfdqMaWoX2k9gT5XxEpKlGDGrOEbRA8xTnWKHsaN/Qm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789881830; c=relaxed/simple;
	bh=nKQW47lxp/Dgw4Lwt/YaydZ+is5KdVRbjfyWdzeoGpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QcOfjxCVzpZHqXA1ygPbgicDDIMYitBAQEKJbyGjKe/fIad/WpXW55/oAa4F/RVb/xL1AEbXYuWrUcPTqz3qN/QkFxAz18VBhx42b0gWWDkw1fQ82Nd2sTgpKKsl8oSO1nDjbTeEoczTj7Rmv5Esxar4WOOQpKjvf2izJRZYlxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UjW3vkVu; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UjW3vkVu"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a0dc7f26cso3138476b3a.3
        for <linux-perf-users@vger.kernel.org>; Sat, 19 Sep 2026 22:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789881827; x=1790486627; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7aHrgyV77JwbUqX0lovVxaQarutyauJOue8Qd9W4AQ4=;
        b=UjW3vkVudyaSyxeUwcKL9bG9fz1KD9aShT98+tLhHpzYYMlFvIgB5ZZTDVVZXwMJRZ
         TLf2hhUZYuKfZBKNaSdMY/NffTDg5VBSkGAiRptndhTHtAk91YdyYd+DkstvCdYIu+I8
         lVpFV2oAH9chjeNARXZAFk6zM3vtzzV6FZqV4eYn8eYx2pDlJZZ4MgrwdxTzuuY8RA/J
         GRZuK5BMywIeNnDWFvUrQuNDg2gG01B+aoE9oCJdHL399FAM9iWQD9xGbJpHSbuIsKW2
         m8IMj2LLPjy7lca/GHHT5RzpoCIBVZRXsqUsO3V77OMcDMjLH8UNPpN2x0hltrbli6pK
         mLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789881827; x=1790486627;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7aHrgyV77JwbUqX0lovVxaQarutyauJOue8Qd9W4AQ4=;
        b=pkR18BRdB4peGhHHLmdcZTTFD6DmwRmsp3krCFj+XhxuAT7Jk4u6GAn6eM3UfoUK+j
         iMdd0vBRTrWG+kXA/okjiLiL/Qj7GIqIkRMCEtWu0G57nX4hGPHaxTGDvWbFPo8JFWfi
         CdItK2NIv5RJ03fFFDgm4kBvR3RXfWWChkEvU0+RtuvuXzgPNG7m9h+LcogPXEmV3F3b
         aiNA5oTdH3LEBS7jRgkan12hktuDEsO7BrmsJxqiEHoiBvDy+L67OUKODmn0l1XnGNj3
         FTWSQsxKiRohenOpQUde6lYBGN+ryXaWuXqiL+W5j/ZdtFsItGrgUKiwYnxk/BMgeEQG
         yalg==
X-Forwarded-Encrypted: i=1; AKwUvBxE3monJHbgawOP/blDXqIplFp0VQiOUr7XuHAZ0Qb+GaVbxLNUm3ivbq1m6/pgfYNoyJchQUBgTsPJ4QqQrhVs@vger.kernel.org
X-Gm-Message-State: AFuF++moM1GUcr1UgV4I1Ht6hiHV+NBcoofLU05l3FeoyEBEhSmrWf38
	+LUABOhK7K7ej8E+U+/55xQiw1FTs+x4RzM7VnNdSb+wkHzApL51NCwmKNtAbTdFFcBzEulpCvY
	I5ppcB00A8A==
X-Received: from dycnr23-n2.prod.google.com ([2002:a05:7300:e9d7:20b0:33c:32d4:3ed0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3949:b0:3c3:791e:5e18
 with SMTP id adf61e73a8af0-3dd8c2dd660mr12979472637.7.1789881827028; Sat, 19
 Sep 2026 22:23:47 -0700 (PDT)
Date: Sat, 19 Sep 2026 22:21:30 -0700
In-Reply-To: <cover.1789880842.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789880842.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <a87f87541e6b2caddc90232c2742f4a41076ce5c.1789880842.git.irogers@google.com>
Subject: [PATCH v1 38/49] perf python: Port arm-cs-trace-disasm to perf module
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	alice.mei.rogers@gmail.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python/
using the perf module directly.

Improvements compared to the legacy script:
- Encapsulate trace disassembly state in a TraceDisasm class and
  migrate CLI parsing from deprecated optparse to argparse.
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
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/arm-cs-trace-disasm.py      | 350 ++++++++++++++++++
 .../coresight/test_arm_coresight_disasm.sh    |  27 +-
 2 files changed, 371 insertions(+), 6 deletions(-)
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
new file mode 100755
index 000000000000..da5c5a5a3f3c
--- /dev/null
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -0,0 +1,350 @@
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
+from subprocess import check_output
+import argparse
+import platform
+import sys
+from typing import Dict, List, Optional
+
+import perf
+
+# Initialize global dicts and regular expression
+DISASM_CACHE: Dict[str, List[str]] = {}
+CPU_DATA: Dict[str, int] = {}
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
+    "vmlinux"
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
+    buildid_dir = os.environ.get('PERF_BUILDID_DIR')
+    if not buildid_dir:
+        buildid_dir = os.path.join(os.environ.get('HOME', ''), '.debug')
+
+    if dso_name in ("[kernel.kallsyms]", "vmlinux"):
+        if vmlinux:
+            return vmlinux
+        if dso_build_id:
+            for kname in (dso_name, "vmlinux", "[kernel.kallsyms]"):
+                candidate = os.path.join(buildid_dir, kname, dso_build_id, "elf")
+                if os.access(candidate, os.R_OK):
+                    return candidate
+        return find_vmlinux() or dso_name
+
+    if dso_name == "[vdso]":
+        append = "/vdso"
+    else:
+        append = "/elf"
+
+    dso_path = buildid_dir + "/" + dso_name + "/" + dso_build_id + append
+    # Replace duplicate slash chars to single slash char
+    dso_path = dso_path.replace('//', '/', 1)
+    return dso_path
+
+def read_disam(dso_fname: str, dso_start: int, start_addr: int,
+               stop_addr: int, objdump: str) -> List[str]:
+    """Read disassembly from a DSO file using objdump."""
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
+        disasm_output = check_output(disasm).decode('utf-8').split('\n')
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
+        dso = sample.dso or '[unknown]'
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
+                thread_info = self.session.find_thread(sample.sample_tid)
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
+        if CPU_DATA.get(str(cpu) + 'addr') is None:
+            CPU_DATA[str(cpu) + 'addr'] = addr
+            return
+
+        start_addr = CPU_DATA[str(cpu) + 'addr']
+        stop_addr  = ip + 4
+
+        # Record for previous sample packet
+        CPU_DATA[str(cpu) + 'addr'] = addr
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
+            if dso == "[kernel.kallsyms]":
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
+            self.session = perf.session(
+                perf.data(input_file),
+                sample=self.process_event,
+                itrace=self.options.itrace
+            )
+        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
+            print(f"Error opening session: {e}", file=sys.stderr)
+            sys.exit(1)
+
+        self.session.process_events()
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
+    arg_parser.add_argument("-k", "--vmlinux",
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
index f3ebad596378..96c6bdc13a17 100755
--- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
@@ -1,6 +1,6 @@
 #!/bin/bash
-# Check Arm CoreSight disassembly script completes without errors (exclusive)
 # SPDX-License-Identifier: GPL-2.0
+# Check Arm CoreSight disassembly script completes without errors (exclusive)
 
 # The disassembly script reconstructs ranges of instructions and gives these to objdump to
 # decode. objdump doesn't like ranges that go backwards, but these are a good indication
@@ -22,9 +22,10 @@ glb_err=1
 
 perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
 perfdata=${perfdata_dir}/perf.data
+perfdata2=${perfdata_dir}/perf2.data
 file=$(mktemp /tmp/temporary_file.XXXXX)
 # Relative path works whether it's installed or running from repo
-script_path=$(dirname "$0")/../../../scripts/python/arm-cs-trace-disasm.py
+script_path=$(dirname "$0")/../../../python/arm-cs-trace-disasm.py
 
 cleanup_files()
 {
@@ -44,8 +45,15 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
 if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
-	perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
-		-d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
+	# shellcheck source=lib/setup_python.sh
+	. "$(dirname "$0")"/../lib/setup_python.sh
+	$PYTHON -c "import perf" 2>/dev/null || {
+		echo "Skipping test, perf python module not found"
+		glb_err=2
+		exit 2
+	}
+	$PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
+		-k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
 	grep -q -E ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -56,8 +64,15 @@ fi
 ## Test user ##
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
-perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
-	-d --stop-sample=2 2> /dev/null > ${file}
+perf inject --itrace=b -i ${perfdata} -o ${perfdata2}
+# shellcheck source=lib/setup_python.sh
+. "$(dirname "$0")"/../lib/setup_python.sh
+$PYTHON -c "import perf" 2>/dev/null || {
+	echo "Skipping test, perf python module not found"
+	glb_err=2
+	exit 2
+}
+$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=2 2> /dev/null > ${file}
 grep -q -E ${branch_search} ${file}
 echo "Found userspace branches"
 
-- 
2.55.0.1082.g2b9226bbc0-goog

