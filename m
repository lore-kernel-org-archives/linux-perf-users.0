Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFCF3A5E94
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 22:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777157484; cv=none; b=u/cTWhrFOpqti5H6UI/Nt7+R3fi4pG2+Mi/fQOVDnV2KHqfnePi+enZ7/KtdZ59UIEvxyQAx3zgMvMxk3lqk3Ti5ITXxrR8zk2cT35ZQObjs3dJS5IRnnQZJ258+FJVibClMmk0B4eIISjo+CiSt1jLa/W1q5bcAdvAqObn1y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777157484; c=relaxed/simple;
	bh=85dZ9aAayO9i8dMzyv7DpEJFQ7DTaIYbs+d/4v5mn1g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iEcPY1glXJ+lIHPRTjOYmQjmyFJdbo4EH7n8mTdW7B4WMV0D4RvocrrbTXsurn9WeTJpIn93EgkuYapiJvwEfjTBIFbwiNxDwrRoCgfhis1pWS+k1CKQxgBt6Ayxb9gWImQb74tsibbbHT5oP5ZXhjFw0M6HoDotQa/c91olA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDPhT+XE; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDPhT+XE"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so13691896eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777157480; x=1777762280; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=itAjjttTC6ExRFqiT4XahID1dD5ZJo1i7yacdRBRaZI=;
        b=DDPhT+XE6OCg/ZcdiAU0TWVwP3fBNkRuo7NesuvEVhtgMUgihnpjxklkAAJbB1bXw1
         dyVTbxKuCKFTItsptJkGpa4cIZRbPL2hxF/x9ZYUbzqZ49bcZ8YBw+2v9hmNPXd/i+mh
         l5B/IzVd1nH/3wXSTKanrvEM4D9fyNOKYY8t0vuo9cWOU8eQNUZLcWe3oPIBG04RmHEa
         G7Dd+0v77a+x+XA4e8MbuJ7Hyy7F4RJnHxZaD3oNbmz+PuPNUXgHah7OIDH5pLrAa8a4
         6z0IVb/e5zRwUIn+X/QnGGw9P5wanZh8Wr1NcwYmVcHXZnTsPcoMqjuRQ9bEgPrtbApk
         FBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777157480; x=1777762280;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=itAjjttTC6ExRFqiT4XahID1dD5ZJo1i7yacdRBRaZI=;
        b=ojcxtSZhzlClFX8Nsjc7gVkYnK1ZUIb5jW0RZ+8ELb/zPgkXhiL6qJfDlxAaxvxRCQ
         VcLdd5qLFFxplPp070x4UobymE8sczznucnWSfAannmbZ+u/C5tQCkUJvmAACl8pGlEM
         w9SD/vQ1231dRpHvValwqvn4T2nELVb4s/BDPFKVTPKUgKNw21cF81aTR5K0qe9nxhT4
         5Mls1TdpNx+Gu93YIX8a2CL33pmIHfjGXwLXebU5aApC0YmlEYYE2lDkH7kYVHiczbRM
         RraDtC/HzCZpSFf1l1tJLGdm+MxNDFpweXHBILodNTykU2bhOalnVG7AVf+RSPL7pCbg
         YTRw==
X-Forwarded-Encrypted: i=1; AFNElJ/+3meo1sWLo7WCTyXbF38KodpqeQ5BRWh/bEIsLCVplo0koHtGjH6trkpM1I53FRusZEAiE0ERoEH+iZUZRi+W@vger.kernel.org
X-Gm-Message-State: AOJu0YwSoTV2Ep4dkumP8s8dWdASpVvk+VQWus0W4WERAfH4zYfD0jYw
	u32cOY2HwPpZt1Kc16PtdxQYuw/ZFnaJvrS0rxGjcHU5gYS5tHa9csvesWRHqbAv/kh7Pd8rd0T
	sJTkvCSSipQ==
X-Received: from dlbpu6.prod.google.com ([2002:a05:7022:e886:b0:12c:8eb0:61d9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:50d:b0:12a:747e:5b5c
 with SMTP id a92af1059eb24-12c73fa3af3mr19374737c88.24.1777157479499; Sat, 25
 Apr 2026 15:51:19 -0700 (PDT)
Date: Sat, 25 Apr 2026 15:49:24 -0700
In-Reply-To: <20260425224951.174663-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260425174858.3922152-1-irogers@google.com> <20260425224951.174663-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260425224951.174663-33-irogers@google.com>
Subject: [PATCH v7 32/59] perf arm-cs-trace-disasm: Port arm-cs-trace-disasm
 to use python module
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	leo.yan@linux.dev, namhyung@kernel.org, tmricht@linux.ibm.com
Cc: alice.mei.rogers@gmail.com, dapeng1.mi@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a port of the arm-cs-trace-disasm script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields. Update the testing to use the ported script.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:

1. Added Missing Import: Added import perf at the top of
   arm-cs-trace-disasm.py .

2. Fixed Unpacking Error: Updated the call to sample.srccode() to
   expect a 3-tuple instead of a 4-tuple, matching the return type in
   the C extension.

3. Fixed Termination Logic: Replaced return with sys.exit(0) when the
  stop_time or stop_sample limits are reached to properly terminate
  the processing loop.

4. Fixed Test Path: Updated script_path in
   test_arm_coresight_disasm.sh to point to
   ../../python/arm-cs-trace-disasm.py instead of the old legacy path.
---
 tools/perf/python/arm-cs-trace-disasm.py      | 338 ++++++++++++++++++
 .../tests/shell/test_arm_coresight_disasm.sh  |  12 +-
 2 files changed, 345 insertions(+), 5 deletions(-)
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py

diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
new file mode 100755
index 000000000000..92c97cca6f66
--- /dev/null
+++ b/tools/perf/python/arm-cs-trace-disasm.py
@@ -0,0 +1,338 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember using perf python module
+"""
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
+CACHE_SIZE = 64*1024
+SAMPLE_IDX = -1
+
+GLB_SOURCE_FILE_NAME: Optional[str] = None
+GLB_LINE_NUMBER: Optional[int] = None
+GLB_DSO: Optional[str] = None
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
+    if dso_name in ("[kernel.kallsyms]", "vmlinux"):
+        if vmlinux:
+            return vmlinux
+        return find_vmlinux() or dso_name
+
+    if dso_name == "[vdso]":
+        append = "/vdso"
+    else:
+        append = "/elf"
+
+    buildid_dir = os.environ.get('PERF_BUILDID_DIR')
+    if not buildid_dir:
+        buildid_dir = os.path.join(os.environ.get('HOME', ''), '.debug')
+
+    dso_path = buildid_dir + "/" + dso_name + "/" + dso_build_id + append
+    # Replace duplicate slash chars to single slash char
+    dso_path = dso_path.replace('//', '/', 1)
+    return dso_path
+
+def read_disam(dso_fname: str, dso_start: int, start_addr: int,
+               stop_addr: int, objdump: str) -> List[str]:
+    """Read disassembly from a DSO file using objdump."""
+    addr_range = f"{start_addr}:{stop_addr}:{dso_fname}"
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
+        DISASM_CACHE[addr_range] = disasm_output
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
+          f"time: {sample.sample_time} index: {SAMPLE_IDX}}}")
+
+def common_start_str(comm: str, sample: perf.sample_event) -> str:
+    """Return common start string for sample output."""
+    sec = int(sample.sample_time / 1000000000)
+    ns = sample.sample_time % 1000000000
+    cpu = sample.sample_cpu
+    pid = sample.sample_pid
+    tid = sample.sample_tid
+    return f"{comm:>16s} {pid:5u}/{tid:<5u} [{cpu:04d}] {sec:9d}.{ns:09d}  "
+
+def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso: str) -> None:
+    """Print source code and symbols for a sample."""
+    ip = sample.sample_ip
+    if symbol == "[unknown]":
+        start_str = common_start_str(comm, sample) + f"{ip:x}".rjust(16).ljust(40)
+    else:
+        symoff = 0
+        sym_start = sample.sym_start
+        if sym_start is not None:
+            symoff = ip - sym_start
+        offs = f"+{symoff:#x}" if symoff != 0 else ""
+        start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
+
+    global GLB_SOURCE_FILE_NAME, GLB_LINE_NUMBER, GLB_DSO
+
+    source_file_name, line_number, source_line = sample.srccode()
+    if source_file_name:
+        if GLB_LINE_NUMBER == line_number and GLB_SOURCE_FILE_NAME == source_file_name:
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
+        GLB_DSO = None
+    elif dso == GLB_DSO:
+        src_str = ""
+    else:
+        src_str = dso
+        GLB_DSO = dso
+
+    GLB_LINE_NUMBER = line_number
+    GLB_SOURCE_FILE_NAME = source_file_name
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
+        global SAMPLE_IDX
+        SAMPLE_IDX = self.sample_idx
+
+        if self.options.start_time and sample.sample_time < self.options.start_time:
+            return
+        if self.options.stop_time and sample.sample_time > self.options.stop_time:
+            sys.exit(0)
+        if self.options.start_sample and self.sample_idx < self.options.start_sample:
+            return
+        if self.options.stop_sample and self.sample_idx > self.options.stop_sample:
+            sys.exit(0)
+
+        ev_name = str(sample.evsel)
+        if self.options.verbose:
+            print(f"Event type: {ev_name}")
+            print_sample(sample)
+
+        dso = sample.dso or '[unknown]'
+        symbol = sample.symbol or '[unknown]'
+        dso_bid = sample.dso_bid or '[unknown]'
+        dso_start = sample.map_start
+        dso_end = sample.map_end
+        map_pgoff = sample.map_pgoff or 0
+
+        comm = "[unknown]"
+        try:
+            if self.session:
+                thread_info = self.session.find_thread(sample.sample_tid)
+                if thread_info:
+                    comm = thread_info.comm()
+        except (TypeError, AttributeError):
+            pass
+
+        cpu = sample.sample_cpu
+        addr = sample.sample_addr
+
+        if CPU_DATA.get(str(cpu) + 'addr') is None:
+            CPU_DATA[str(cpu) + 'addr'] = addr
+            return
+
+        if dso == '[unknown]':
+            return
+
+        if dso_start is None or dso_end is None:
+            print(f"Failed to find valid dso map for dso {dso}")
+            return
+
+        if ev_name.startswith("instructions"):
+            print_srccode(comm, sample, symbol, dso)
+            return
+
+        if not ev_name.startswith("branches"):
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
+            if dso == "[kernel.kallsyms]" or dso_start == 0x400000:
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
+        if not os.path.exists(input_file):
+            print(f"Error: {input_file} not found.", file=sys.stderr)
+            sys.exit(1)
+
+        print('ARM CoreSight Trace Data Assembler Dump')
+        try:
+            self.session = perf.session(perf.data(input_file), sample=self.process_event)
+        except Exception as e:
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
+    arg_parser.add_argument("--start-sample", type=int_arg,
+                            help="Index of sample to start from.")
+    arg_parser.add_argument("--stop-sample", type=int_arg,
+                            help="Index of sample to stop at.")
+
+    parsed_options = arg_parser.parse_args()
+    if (parsed_options.start_time and parsed_options.stop_time and \
+       parsed_options.start_time >= parsed_options.stop_time):
+        print("--start-time must less than --stop-time")
+        sys.exit(2)
+    if (parsed_options.start_sample and parsed_options.stop_sample and \
+       parsed_options.start_sample >= parsed_options.stop_sample):
+        print("--start-sample must less than --stop-sample")
+        sys.exit(2)
+
+    td = TraceDisasm(parsed_options)
+    td.run()
diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
index 0dfb4fadf531..c15cd60e1c24 100755
--- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
+++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
@@ -24,7 +24,7 @@ perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
 perfdata=${perfdata_dir}/perf.data
 file=$(mktemp /tmp/temporary_file.XXXXX)
 # Relative path works whether it's installed or running from repo
-script_path=$(dirname "$0")/../../scripts/python/arm-cs-trace-disasm.py
+script_path=$(dirname "$0")/../../python/arm-cs-trace-disasm.py
 
 cleanup_files()
 {
@@ -45,8 +45,9 @@ branch_search="\sbl${sep}b${sep}b.ne${sep}b.eq${sep}cbz\s"
 if [ -e /proc/kcore ]; then
 	echo "Testing kernel disassembly"
 	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/null 2>&1
-	perf script -i ${perfdata} -s python:${script_path} -- \
-		-d --stop-sample=30 2> /dev/null > ${file}
+	# shellcheck source=lib/setup_python.sh
+	. "$(dirname "$0")"/lib/setup_python.sh
+	$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=30 2> /dev/null > ${file}
 	grep -q -e ${branch_search} ${file}
 	echo "Found kernel branches"
 else
@@ -57,8 +58,9 @@ fi
 ## Test user ##
 echo "Testing userspace disassembly"
 perf record -o ${perfdata} -e cs_etm//u -- touch $file > /dev/null 2>&1
-perf script -i ${perfdata} -s python:${script_path} -- \
-	-d --stop-sample=30 2> /dev/null > ${file}
+# shellcheck source=lib/setup_python.sh
+. "$(dirname "$0")"/lib/setup_python.sh
+$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=30 2> /dev/null > ${file}
 grep -q -e ${branch_search} ${file}
 echo "Found userspace branches"
 
-- 
2.54.0.545.g6539524ca2-goog

