Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFE7329E79
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643255; cv=none; b=dIyXn3G4G/5N4kVAkLk+qfl921j/Tx8MOFc5DjbPW7ImHA1twrcrDetPMXmJitQdBuK7hjL25yP7bpSRJ4SdHLIVBuNzVDoaXdGuezHrp5ugxxzy98JfZl7xTrc2QvLUvAZO+OJRGYONLLeKdia4GOP7T8gcvZHiAhEBZg9Jwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643255; c=relaxed/simple;
	bh=NKNtwCd6bxmbPngy0S2cgFQPX5y0Fv7TGaO7C4uSu2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=heO7+7iOwsFB+0+9Ofc4X8mDBEoB8xpGnr4og7Zv7FLsmmKIafQZD6DgHB5xCFYKK+dVI8CoL60wKlzs3CQ0oUr7inBrbUH0r23cVht7MGwF0uy3sFIH9oQrxV7lwIzZDcKRoz2fBYgvUcSEVk0XW0JfUczurypRxHKpfGvGIy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=guLCTo34; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="guLCTo34"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c35f2c09dso2819301c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Apr 2026 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776643252; x=1777248052; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nGUaG7am42RrvKOl/vi58NRsQO9BbG01MiXQZGR47s=;
        b=guLCTo34cT/3Ez0Hp+yspI44z0yB/Uh+o7pvH9ZLxj183hCbPslfJxuA/O7OczP/PS
         WGw+CHkA/rhF/7j9kju59vZmByMfqhrWX6SWKpogZHNERQztkkTQQnbrFUoW8zntGUuQ
         Cr5RMMjFa7+eUmUKMdL+3RaP/CcvYft80AE2sxJzhzA/fRRHZlzcgyjK1W6m4kgVafnl
         OMGrL7S930xFfbW11OlbHN5/4gYOxV8MXCVmrv0O85Mf9d6GvBKkH04upqRrcAHRJqDx
         OIQg5QEDOmVz6Koot5u5i1MuwCSImDaeVHdAaiB1PZNWxEpe3Wvv4k5vEGZi/MmjNyQt
         5zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776643252; x=1777248052;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nGUaG7am42RrvKOl/vi58NRsQO9BbG01MiXQZGR47s=;
        b=LJb+zaCkPK6Bq7NBKgQ0RIIEgjHTd6b06wRAstaaidNm1181AQTx7L0SSrFmnn4fD2
         NyPvb7Nplxvap4qgNiJpvPpuMLb44RlFHAXWZ9uJPbG9gXDPheUnctOdFzAJRG8I6PJI
         vBOzq/8wdDKJEFSFqrHzaK30QvG4+J6YPv0WuV4JQqUHkPZf06sTR8yCMKCWe+JhVNoL
         jLCv+c+ZcL6R7eY0PLLvuODD5c+bCAEWqKrChrr0IO5YmjyOXg/BiS6oty3oJIRrOTo4
         XufZD2WJrgEnVPmwsOAExpeKARGTT2MnSmZc4O/ZkY9ViUIfOZhtrMfbg2my5Svvgufu
         nn6w==
X-Forwarded-Encrypted: i=1; AFNElJ/Lz4Y4oqm6yE9WGMNuYCPsO2kpa1cKs7CUTiE+d6RNfeiOx6CdFs2DUMgWYDHAd0EUpduDSTcrf+CjRS+R5tap@vger.kernel.org
X-Gm-Message-State: AOJu0YxOJ25houTnQzk1sYUSGa9c1z5CRFxFVsNRUV8d6FEykj557Mxk
	rbTZimAacHdlOanScmCNEoFLeYEszWU1/3vkcKpEjVkffBD6/KMKXZX9SFe04Vud2y10NmRYRMM
	DmyXy2LO3lA==
X-Received: from dlbqc1.prod.google.com ([2002:a05:7023:a81:b0:12c:87ba:191d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2602:b0:128:d23d:81a2
 with SMTP id a92af1059eb24-12c73f9ae5cmr5323274c88.29.1776643251715; Sun, 19
 Apr 2026 17:00:51 -0700 (PDT)
Date: Sun, 19 Apr 2026 16:58:51 -0700
In-Reply-To: <20260419235911.2186050-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260419235911.2186050-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260419235911.2186050-40-irogers@google.com>
Subject: [PATCH v1 39/58] perf intel-pt-events: Port intel-pt-events/libxed to
 use python module
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Alice Rogers <alice.mei.rogers@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@arm.com>, John Garry <john.g.garry@oracle.com>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Alexandre Chartre <alexandre.chartre@oracle.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Blake Jones <blakejones@google.com>, Changbin Du <changbin.du@huawei.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Wangyang Guo <wangyang.guo@intel.com>, 
	Pan Deng <pan.deng@intel.com>, Zhiguo Zhou <zhiguo.zhou@intel.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Zecheng Li <zli94@ncsu.edu>, tanze <tanze@kylinos.cn>, 
	Thomas Richter <tmricht@linux.ibm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	"Tycho Andersen (AMD)" <tycho@kernel.org>, Howard Chu <howardchu95@gmail.com>, 
	Sun Jian <sun.jian.kdev@gmail.com>, Derek Foreman <derek.foreman@collabora.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, Qinxin Xia <xiaqinxin@huawei.com>, 
	Aditya Bodkhe <adityab1@linux.ibm.com>, Chun-Tse Shao <ctshao@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Chen Ni <nichen@iscas.ac.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Ported from tools/perf/scripts/python/.
- Refactored intel-pt-events.py to use a class structure to eliminate
  global state and improve maintainability.
- Removed Python 2 compatibility checks.
- Renamed methods in libxed.py to snake_case (Instruction ->
  instruction, SetMode -> set_mode, DisassembleOne -> disassemble_one)
  to comply with pylint.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/python/intel-pt-events.py | 421 +++++++++++++++++++++++++++
 tools/perf/python/libxed.py          | 119 ++++++++
 2 files changed, 540 insertions(+)
 create mode 100755 tools/perf/python/intel-pt-events.py
 create mode 100755 tools/perf/python/libxed.py

diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/intel-pt-events.py
new file mode 100755
index 000000000000..cb730d1009f4
--- /dev/null
+++ b/tools/perf/python/intel-pt-events.py
@@ -0,0 +1,421 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Print Intel PT Events including Power Events and PTWRITE.
+Ported from tools/perf/scripts/python/intel-pt-events.py
+"""
+
+import argparse
+import contextlib
+from ctypes import addressof, create_string_buffer
+import io
+import os
+import struct
+import sys
+from typing import Any, Optional
+import perf
+
+# Try to import LibXED from legacy directory if available in PYTHONPATH
+try:
+    from libxed import LibXED  # type: ignore
+except ImportError:
+    LibXED = None
+
+
+class IntelPTAnalyzer:
+    """Analyzes Intel PT events and prints details."""
+
+    def __init__(self, cfg: argparse.Namespace):
+        self.args = cfg
+        self.insn = False
+        self.src = False
+        self.source_file_name: Optional[str] = None
+        self.line_number: int = 0
+        self.dso: Optional[str] = None
+        self.stash_dict: dict[int, list[str]] = {}
+        self.output: Any = None
+        self.output_pos: int = 0
+        self.cpu: int = -1
+        self.time: int = 0
+        self.switch_str: dict[int, str] = {}
+
+        if cfg.insn_trace:
+            print("Intel PT Instruction Trace")
+            self.insn = True
+        elif cfg.src_trace:
+            print("Intel PT Source Trace")
+            self.insn = True
+            self.src = True
+        else:
+            print("Intel PT Branch Trace, Power Events, Event Trace and PTWRITE")
+
+        self.disassembler: Any = None
+        if self.insn and LibXED is not None:
+            try:
+                self.disassembler = LibXED()
+            except Exception as e:
+                print(f"Failed to initialize LibXED: {e}")
+                self.disassembler = None
+
+    def print_ptwrite(self, raw_buf: bytes) -> None:
+        """Print PTWRITE data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        flags = data[0]
+        payload = data[1]
+        exact_ip = flags & 1
+        try:
+            s = payload.to_bytes(8, "little").decode("ascii").rstrip("\x00")
+            if not s.isprintable():
+                s = ""
+        except (UnicodeDecodeError, ValueError):
+            s = ""
+        print(f"IP: {exact_ip} payload: {payload:#x} {s}", end=' ')
+
+    def print_cbr(self, raw_buf: bytes) -> None:
+        """Print CBR data."""
+        data = struct.unpack_from("<BBBBII", raw_buf)
+        cbr = data[0]
+        f = (data[4] + 500) // 1000
+        p = ((cbr * 1000 // data[2]) + 5) // 10
+        print(f"{cbr:3u}  freq: {f:4u} MHz  ({p:3u}%)", end=' ')
+
+    def print_mwait(self, raw_buf: bytes) -> None:
+        """Print MWAIT data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        hints = payload & 0xff
+        extensions = (payload >> 32) & 0x3
+        print(f"hints: {hints:#x} extensions: {extensions:#x}", end=' ')
+
+    def print_pwre(self, raw_buf: bytes) -> None:
+        """Print PWRE data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        hw = (payload >> 7) & 1
+        cstate = (payload >> 12) & 0xf
+        subcstate = (payload >> 8) & 0xf
+        print(f"hw: {hw} cstate: {cstate} sub-cstate: {subcstate}", end=' ')
+
+    def print_exstop(self, raw_buf: bytes) -> None:
+        """Print EXSTOP data."""
+        data = struct.unpack_from("<I", raw_buf)
+        flags = data[0]
+        exact_ip = flags & 1
+        print(f"IP: {exact_ip}", end=' ')
+
+    def print_pwrx(self, raw_buf: bytes) -> None:
+        """Print PWRX data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        payload = data[1]
+        deepest_cstate = payload & 0xf
+        last_cstate = (payload >> 4) & 0xf
+        wake_reason = (payload >> 8) & 0xf
+        print(f"deepest cstate: {deepest_cstate} last cstate: {last_cstate} "
+              f"wake reason: {wake_reason:#x}", end=' ')
+
+    def print_psb(self, raw_buf: bytes) -> None:
+        """Print PSB data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        offset = data[1]
+        print(f"offset: {offset:#x}", end=' ')
+
+    def print_evt(self, raw_buf: bytes) -> None:
+        """Print EVT data."""
+        glb_cfe = ["", "INTR", "IRET", "SMI", "RSM", "SIPI", "INIT", "VMENTRY", "VMEXIT",
+                   "VMEXIT_INTR", "SHUTDOWN", "", "UINT", "UIRET"] + [""] * 18
+        glb_evd = ["", "PFA", "VMXQ", "VMXR"] + [""] * 60
+
+        data = struct.unpack_from("<BBH", raw_buf)
+        typ = data[0] & 0x1f
+        ip_flag = (data[0] & 0x80) >> 7
+        vector = data[1]
+        evd_cnt = data[2]
+        s = glb_cfe[typ]
+        if s:
+            print(f" cfe: {s} IP: {ip_flag} vector: {vector}", end=' ')
+        else:
+            print(f" cfe: {typ} IP: {ip_flag} vector: {vector}", end=' ')
+        pos = 4
+        for _ in range(evd_cnt):
+            data = struct.unpack_from("<QQ", raw_buf, pos)
+            et = data[0] & 0x3f
+            s = glb_evd[et]
+            if s:
+                print(f"{s}: {data[1]:#x}", end=' ')
+            else:
+                print(f"EVD_{et}: {data[1]:#x}", end=' ')
+            pos += 16
+
+    def print_iflag(self, raw_buf: bytes) -> None:
+        """Print IFLAG data."""
+        data = struct.unpack_from("<IQ", raw_buf)
+        iflag = data[0] & 1
+        old_iflag = iflag ^ 1
+        via_branch = data[0] & 2
+        s = "via" if via_branch else "non"
+        print(f"IFLAG: {old_iflag}->{iflag} {s} branch", end=' ')
+
+    def common_start_str(self, comm: str, sample: perf.sample_event) -> str:
+        """Return common start string for display."""
+        ts = sample.time
+        cpu = sample.cpu
+        pid = sample.pid
+        tid = sample.tid
+        machine_pid = getattr(sample, "machine_pid", 0)
+        if machine_pid:
+            vcpu = getattr(sample, "vcpu", -1)
+            return (f"VM:{machine_pid:5d} VCPU:{vcpu:03d} {comm:>16s} {pid:5u}/{tid:<5u} "
+                    f"[{cpu:03u}] {ts // 1000000000:9u}.{ts % 1000000000:09u}  ")
+        return (f"{comm:>16s} {pid:5u}/{tid:<5u} [{cpu:03u}] "
+                f"{ts // 1000000000:9u}.{ts % 1000000000:09u}  ")
+
+    def print_common_start(self, comm: str, sample: perf.sample_event, name: str) -> None:
+        """Print common start info."""
+        flags_disp = getattr(sample, "flags_disp", "")
+        print(self.common_start_str(comm, sample) + f"{name:>8s}  {flags_disp:>21s}", end=' ')
+
+    def print_instructions_start(self, comm: str, sample: perf.sample_event) -> None:
+        """Print instructions start info."""
+        flags = getattr(sample, "flags_disp", "")
+        if "x" in flags:
+            print(self.common_start_str(comm, sample) + "x", end=' ')
+        else:
+            print(self.common_start_str(comm, sample), end='  ')
+
+    def disassem(self, insn: bytes, ip: int) -> tuple[int, str]:
+        """Disassemble instruction using LibXED."""
+        inst = self.disassembler.instruction()
+        self.disassembler.set_mode(inst, 0)  # Assume 64-bit
+        buf = create_string_buffer(64)
+        buf.value = insn
+        return self.disassembler.disassemble_one(inst, addressof(buf), len(insn), ip)
+
+    def print_common_ip(self, sample: perf.sample_event, symbol: str, dso: str) -> None:
+        """Print IP and symbol info."""
+        ip = sample.ip
+        offs = f"+{sample.symoff:#x}" if hasattr(sample, "symoff") else ""
+        cyc_cnt = getattr(sample, "cyc_cnt", 0)
+        if cyc_cnt:
+            insn_cnt = getattr(sample, "insn_cnt", 0)
+            ipc_str = f"  IPC: {insn_cnt / cyc_cnt:#.2f} ({insn_cnt}/{cyc_cnt})"
+        else:
+            ipc_str = ""
+
+        if self.insn and self.disassembler is not None:
+            try:
+                insn = sample.insn()
+            except AttributeError:
+                insn = None
+            if insn:
+                cnt, text = self.disassem(insn, ip)
+                byte_str = (f"{ip:x}").rjust(16)
+                for k in range(cnt):
+                    byte_str += f" {insn[k]:02x}"
+                print(f"{byte_str:-40s}  {text:-30s}", end=' ')
+            print(f"{symbol}{offs} ({dso})", end=' ')
+        else:
+            print(f"{ip:16x} {symbol}{offs} ({dso})", end=' ')
+
+        addr_correlates_sym = getattr(sample, "addr_correlates_sym", False)
+        if addr_correlates_sym:
+            addr = sample.addr
+            addr_dso = getattr(sample, "addr_dso", "[unknown]")
+            addr_symbol = getattr(sample, "addr_symbol", "[unknown]")
+            addr_offs = f"+{sample.addr_symoff:#x}" if hasattr(sample, "addr_symoff") else ""
+            print(f"=> {addr:x} {addr_symbol}{addr_offs} ({addr_dso}){ipc_str}")
+        else:
+            print(ipc_str)
+
+    def print_srccode(self, comm: str, sample: perf.sample_event,
+                      symbol: str, dso: str, with_insn: bool) -> None:
+        """Print source code info."""
+        ip = sample.ip
+        if symbol == "[unknown]":
+            start_str = self.common_start_str(comm, sample) + (f"{ip:x}").rjust(16).ljust(40)
+        else:
+            offs = f"+{sample.symoff:#x}" if hasattr(sample, "symoff") else ""
+            start_str = self.common_start_str(comm, sample) + (symbol + offs).ljust(40)
+
+        if with_insn and self.insn and self.disassembler is not None:
+            try:
+                insn = sample.insn()
+            except AttributeError:
+                insn = None
+            if insn:
+                _, text = self.disassem(insn, ip)
+                start_str += text.ljust(30)
+
+        try:
+            source_file_name, line_number, source_line = sample.srccode()
+        except (AttributeError, ValueError):
+            source_file_name, line_number, source_line = None, 0, None
+
+        if source_file_name:
+            if self.line_number == line_number and self.source_file_name == source_file_name:
+                src_str = ""
+            else:
+                if len(source_file_name) > 40:
+                    src_file = ("..." + source_file_name[-37:]) + " "
+                else:
+                    src_file = source_file_name.ljust(41)
+                if source_line is None:
+                    src_str = src_file + str(line_number).rjust(4) + " <source not found>"
+                else:
+                    src_str = src_file + str(line_number).rjust(4) + " " + source_line
+            self.dso = None
+        elif dso == self.dso:
+            src_str = ""
+        else:
+            src_str = dso
+            self.dso = dso
+
+        self.line_number = line_number
+        self.source_file_name = source_file_name
+
+        print(start_str, src_str)
+
+    def do_process_event(self, sample: perf.sample_event) -> None:
+        """Process event and print info."""
+        comm = getattr(sample, "comm", "Unknown")
+        name = str(sample.evsel)
+        dso = getattr(sample, "dso", "[unknown]")
+        symbol = getattr(sample, "symbol", "[unknown]")
+
+        cpu = sample.cpu
+        if cpu in self.switch_str:
+            print(self.switch_str[cpu])
+            del self.switch_str[cpu]
+
+        try:
+            raw_buf = sample.raw_buf
+        except AttributeError:
+            raw_buf = b""
+
+        if name.startswith("instructions"):
+            if self.src:
+                self.print_srccode(comm, sample, symbol, dso, True)
+            else:
+                self.print_instructions_start(comm, sample)
+                self.print_common_ip(sample, symbol, dso)
+        elif name.startswith("branches"):
+            if self.src:
+                self.print_srccode(comm, sample, symbol, dso, False)
+            else:
+                self.print_common_start(comm, sample, name)
+                self.print_common_ip(sample, symbol, dso)
+        elif name == "ptwrite":
+            self.print_common_start(comm, sample, name)
+            self.print_ptwrite(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "cbr":
+            self.print_common_start(comm, sample, name)
+            self.print_cbr(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "mwait":
+            self.print_common_start(comm, sample, name)
+            self.print_mwait(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "pwre":
+            self.print_common_start(comm, sample, name)
+            self.print_pwre(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "exstop":
+            self.print_common_start(comm, sample, name)
+            self.print_exstop(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "pwrx":
+            self.print_common_start(comm, sample, name)
+            self.print_pwrx(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "psb":
+            self.print_common_start(comm, sample, name)
+            self.print_psb(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "evt":
+            self.print_common_start(comm, sample, name)
+            self.print_evt(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        elif name == "iflag":
+            self.print_common_start(comm, sample, name)
+            self.print_iflag(raw_buf)
+            self.print_common_ip(sample, symbol, dso)
+        else:
+            self.print_common_start(comm, sample, name)
+            self.print_common_ip(sample, symbol, dso)
+
+    def interleave_events(self, sample: perf.sample_event) -> None:
+        """Interleave output to avoid garbled lines from different CPUs."""
+        self.cpu = sample.cpu
+        ts = sample.time
+
+        if self.time != ts:
+            self.time = ts
+            self.flush_stashed_output()
+
+        self.output_pos = 0
+        with contextlib.redirect_stdout(io.StringIO()) as self.output:
+            self.do_process_event(sample)
+
+        self.stash_output()
+
+    def stash_output(self) -> None:
+        """Stash output for later flushing."""
+        output_str = self.output.getvalue()[self.output_pos:]
+        n = len(output_str)
+        if n:
+            self.output_pos += n
+            if self.cpu not in self.stash_dict:
+                self.stash_dict[self.cpu] = []
+            self.stash_dict[self.cpu].append(output_str)
+
+    def flush_stashed_output(self) -> None:
+        """Flush stashed output."""
+        while self.stash_dict:
+            cpus = list(self.stash_dict.keys())
+            for cpu in cpus:
+                items = self.stash_dict[cpu]
+                countdown = self.args.interleave
+                while len(items) and countdown:
+                    sys.stdout.write(items[0])
+                    del items[0]
+                    countdown -= 1
+                if not items:
+                    del self.stash_dict[cpu]
+
+    def process_event(self, sample: perf.sample_event) -> None:
+        """Wrapper to handle interleaving and exceptions."""
+        try:
+            if self.args.interleave:
+                self.interleave_events(sample)
+            else:
+                self.do_process_event(sample)
+        except BrokenPipeError:
+            # Stop python printing broken pipe errors and traceback
+            with open(os.devnull, 'w', encoding='utf-8') as f:
+                sys.stdout = f
+            sys.exit(1)
+
+
+if __name__ == "__main__":
+    ap = argparse.ArgumentParser()
+    ap.add_argument("-i", "--input", default="perf.data", help="Input file name")
+    ap.add_argument("--insn-trace", action='store_true')
+    ap.add_argument("--src-trace", action='store_true')
+    ap.add_argument("--all-switch-events", action='store_true')
+    ap.add_argument("--interleave", type=int, nargs='?', const=4, default=0)
+    args = ap.parse_args()
+
+    analyzer = IntelPTAnalyzer(args)
+
+    try:
+        session = perf.session(perf.data(args.input), sample=analyzer.process_event)
+        session.process_events()
+        if args.interleave:
+            analyzer.flush_stashed_output()
+        print("End")
+    except KeyboardInterrupt:
+        if args.interleave:
+            analyzer.flush_stashed_output()
+        print("End")
+    except Exception as e:
+        print(f"Error processing events: {e}")
diff --git a/tools/perf/python/libxed.py b/tools/perf/python/libxed.py
new file mode 100755
index 000000000000..486987c6ec6d
--- /dev/null
+++ b/tools/perf/python/libxed.py
@@ -0,0 +1,119 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Python wrapper for libxed.so
+Ported from tools/perf/scripts/python/libxed.py
+"""
+
+from ctypes import CDLL, Structure, create_string_buffer, addressof, sizeof, \
+                   c_void_p, c_byte, c_int, c_uint, c_ulonglong
+
+# To use Intel XED, libxed.so must be present. To build and install
+# libxed.so:
+#            git clone https://github.com/intelxed/mbuild.git mbuild
+#            git clone https://github.com/intelxed/xed
+#            cd xed
+#            ./mfile.py --share
+#            sudo ./mfile.py --prefix=/usr/local install
+#            sudo ldconfig
+#
+
+
+class XedStateT(Structure):
+    """xed_state_t structure."""
+    _fields_ = [
+        ("mode", c_int),
+        ("width", c_int)
+    ]
+
+
+class XEDInstruction():
+    """Represents a decoded instruction."""
+
+    def __init__(self, libxed):
+        # Current xed_decoded_inst_t structure is 192 bytes. Use 512 to allow for future expansion
+        xedd_t = c_byte * 512
+        self.xedd = xedd_t()
+        self.xedp = addressof(self.xedd)
+        libxed.xed_decoded_inst_zero(self.xedp)
+        self.state = XedStateT()
+        self.statep = addressof(self.state)
+        # Buffer for disassembled instruction text
+        self.buffer = create_string_buffer(256)
+        self.bufferp = addressof(self.buffer)
+
+
+class LibXED():
+    """Wrapper for libxed.so."""
+
+    def __init__(self):
+        try:
+            self.libxed = CDLL("libxed.so")
+        except OSError:
+            self.libxed = None
+        if not self.libxed:
+            try:
+                self.libxed = CDLL("/usr/local/lib/libxed.so")
+            except OSError:
+                self.libxed = None
+
+        if not self.libxed:
+            raise ImportError("libxed.so not found. Please install Intel XED.")
+
+        self.xed_tables_init = self.libxed.xed_tables_init
+        self.xed_tables_init.restype = None
+        self.xed_tables_init.argtypes = []
+
+        self.xed_decoded_inst_zero = self.libxed.xed_decoded_inst_zero
+        self.xed_decoded_inst_zero.restype = None
+        self.xed_decoded_inst_zero.argtypes = [c_void_p]
+
+        self.xed_operand_values_set_mode = self.libxed.xed_operand_values_set_mode
+        self.xed_operand_values_set_mode.restype = None
+        self.xed_operand_values_set_mode.argtypes = [c_void_p, c_void_p]
+
+        self.xed_decoded_inst_zero_keep_mode = self.libxed.xed_decoded_inst_zero_keep_mode
+        self.xed_decoded_inst_zero_keep_mode.restype = None
+        self.xed_decoded_inst_zero_keep_mode.argtypes = [c_void_p]
+
+        self.xed_decode = self.libxed.xed_decode
+        self.xed_decode.restype = c_int
+        self.xed_decode.argtypes = [c_void_p, c_void_p, c_uint]
+
+        self.xed_format_context = self.libxed.xed_format_context
+        self.xed_format_context.restype = c_uint
+        self.xed_format_context.argtypes = [
+            c_int, c_void_p, c_void_p, c_int, c_ulonglong, c_void_p, c_void_p
+        ]
+
+        self.xed_tables_init()
+
+    def instruction(self):
+        """Create a new XEDInstruction."""
+        return XEDInstruction(self)
+
+    def set_mode(self, inst, mode):
+        """Set 32-bit or 64-bit mode."""
+        if mode:
+            inst.state.mode = 4  # 32-bit
+            inst.state.width = 4  # 4 bytes
+        else:
+            inst.state.mode = 1  # 64-bit
+            inst.state.width = 8  # 8 bytes
+        self.xed_operand_values_set_mode(inst.xedp, inst.statep)
+
+    def disassemble_one(self, inst, bytes_ptr, bytes_cnt, ip):
+        """Disassemble one instruction."""
+        self.xed_decoded_inst_zero_keep_mode(inst.xedp)
+        err = self.xed_decode(inst.xedp, bytes_ptr, bytes_cnt)
+        if err:
+            return 0, ""
+        # Use AT&T mode (2), alternative is Intel (3)
+        ok = self.xed_format_context(2, inst.xedp, inst.bufferp, sizeof(inst.buffer), ip, 0, 0)
+        if not ok:
+            return 0, ""
+
+        result = inst.buffer.value.decode('utf-8')
+        # Return instruction length and the disassembled instruction text
+        # For now, assume the length is in byte 166
+        return inst.xedd[166], result
-- 
2.54.0.rc1.513.gad8abe7a5a-goog

