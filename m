Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823124137BF
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790151384; cv=none; b=Y7uM9eTJyiOS4oe7Jo830L96CdEjlbTydOU9aw36zipY8B6c/29oZZ8xosglUAomT9rMLkEBjqdWqdX1/1d1duUw4mmJEuwJTyMU/tfFpgM6cN+IcOtJYm5fXI48Kuw+yzIPiNHp5GJvBYJyFXDmGYF13WBOdY9iTi5SQXX6N7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790151384; c=relaxed/simple;
	bh=TD8aoLd2/Dhpb761SBQvxNiJjRFVqLXTRzX/SkEvpms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gOkUNtoXZXBkF45v2o2eaHNoAKBtV7+xF01vqs5KPPJ6wyUx21qVk+4N0YMOnbmloOMBD9WTVpAuu/F4t6Z7WasD/lJwg0phdOcxzgH1umqs01h44UlZqdqjR2s0OAqywdMBsqylHzbQCgQcs/WFqH087LH3BNQSfJKOJcjyUg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f8NtceKN; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f8NtceKN"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aab226e7c8so1177174a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 01:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790151379; x=1790756179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8eAM1LNzWCJpxJuZHLJDRoAxSp2dTJJnVis9TF2H7I=;
        b=f8NtceKNftlKV/lCzqDRjxz971h5MrmvQfvTHQ09hIOVDaflzrEU6lhtB+M4C0tKCr
         jjqPF4hsqC/Co1hQbEc1zE1aJUy1qMsiQo9ruQthWeqRTeS2iSdSA+cvixethU4gOlIY
         KBAChZH2ij2D2/uQPWMfGpcR92dqvG4QBjtbRieni2g+GrvjH+rkNfTBoNvmXIBsfF8k
         iV51IP3l1WK4aevslHw6M4/h0GaEIliqQGYjfLkvkvOW9UG3cAnzb4nboqYvwLZBizBp
         kPa9YO1UTwPrpGA6Eqni7CoKKX3z4a8ptqpL8rYP5qcxbajAaY1/VRi1TsCNB4bRpbIO
         U+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790151379; x=1790756179;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+8eAM1LNzWCJpxJuZHLJDRoAxSp2dTJJnVis9TF2H7I=;
        b=y2O5goLVREkyBv14xP9FLv8XOQ9PHjgRi8VlA+sW7pZD1grNJc+kxan61sQLfwGkyd
         HzNqH3v8WTDK73ehBpm/ltfcsFmqpihQWSP4lWKXuACRUim1mU7yYmbn8tAxLiaMzAbj
         jdddbl4wmrndRGOnIW0zwiOOwMbTBbDuwpS9OJo+6YM0sKe6CYNRNoq11urZPREhfaUN
         Xu394HjoVK/3Ci2ScdW7771w0Hq0MTMadqeCBsOJxjakjHcj099hO2ii/pk8+4nIEni/
         W+GoTISKeaM9kdhAeyafiNXJWd3Ygw7mxYejEmLYcPpyvJgoBKh/AWz6YLrDv5CdwB73
         aTsg==
X-Forwarded-Encrypted: i=1; AKwUvBxfwZXWqS1ESAOxq8H6+1p2qDaQGEfaExFZmV4/W+GcTb9ElBBqSBjlMfAISxIH8g9q4Kr7eo3D7mRay59ED/li@vger.kernel.org
X-Gm-Message-State: AFuF++mPS+9pT+DCEVU6l6y4Aaun6h9GdtpnwK+PkHuQQaLKJoXnqdvr
	dyJTj46ejPFjv4yQYSSgjWsGNoNEOw8BpCKtl7C713/4STGfwv944lCnTEZad7lf8LI=
X-Gm-Gg: AYBFou0rF9+j2Byx5Uz1fiHZ5rAoVNmQa3Un/5o9IdsdmC8uMuo9jr1WUzy+JslTuaQ
	10IJCjZv1GRPhVHHB/4smOXeGeVdyUieukT5JDBciZTP9jdG/b14u+rkamLf+Wlcl1+g8iRoR9P
	Z+oPl4RgulAh/XNgWbLCrThj4dMP2z3+vzqRCTFcpLyEvxdlK4aFdj5Q4gILF8H+kmAoaRgA4yZ
	vaDvHqUdsTZGY8TqukzVW8LzECADWhCxXuWUIo4QAd4lU6u+p/HWD1guRIE1+Sjgqjk9UwEm6zK
	jcBvtjZhIWIPwI5y8CV8gRKpdoKsUheIIvOItb0/o8iA9dpcu31lXeKKVzSgzgPP6a+unYdu2Of
	kHk2ovW56Qaalb9yjPjbGSADNWDCVox84lytZ9Gil97tTu5vz2VMBM32VUEpX31QhPObFfzXf82
	KiiS10cRRhd3a+KTUl44RKxD9mBI4JYquCcAQxs681xqfl7qX9Xvpe1a0XqCk1DYfyrFwgJ+2D8
	83X
X-Received: by 2002:a17:907:1907:b0:c26:19e3:e98e with SMTP id a640c23a62f3a-c2aae37b22emr121088866b.46.1790151379357;
        Wed, 23 Sep 2026 01:16:19 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60e4c8sm66710966b.26.2026.09.23.01.16.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 01:16:18 -0700 (PDT)
Message-ID: <c7d189ad-8cd9-45b3-9cdd-72923aa5d5d9@linaro.org>
Date: Wed, 23 Sep 2026 09:16:17 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 38/49] perf python: Port arm-cs-trace-disasm to perf
 module
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, leo.yan@linux.dev,
 linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 tmricht@linux.ibm.com, acme@kernel.org, alice.mei.rogers@gmail.com,
 linux-perf-users@vger.kernel.org, namhyung@kernel.org
References: <cover.1789966896.git.irogers@google.com>
 <f724b653476e2733c18b02268c57baaaa54870ba.1789966896.git.irogers@google.com>
 <967f2941-2f7c-464e-8a8e-eb0a78f586d6@linaro.org>
 <CAP-5=fXz5S-Va1BdvQjvDqcKovToyoODC-T1gVV46pLPEbiVvQ@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXz5S-Va1BdvQjvDqcKovToyoODC-T1gVV46pLPEbiVvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/09/2026 06:23, Ian Rogers wrote:
> On Tue, Sep 22, 2026 at 6:12 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 21/09/2026 06:06, Ian Rogers wrote:
>>> Port arm-cs-trace-disasm.py to a standalone script in tools/perf/python/
>>> using the perf module directly.
>>>
>>> Improvements compared to the legacy script:
>>> - Encapsulate trace disassembly state in a TraceDisasm class
>>> - Automatically search standard kernel debug paths (find_vmlinux())
>>>     when -k/--vmlinux is not specified, and query
>>>     perf.config_get("annotate.objdump") for the default objdump binary.
>>> - Bound DISASM_CACHE memory consumption by evicting the cache at 1024
>>>     entries and skipping caching of oversized (> 512 lines) objdump
>>>     outputs.
>>> - Use sample.srccode() from the perf extension module to annotate
>>>     disassembly output with source filenames, line numbers, and source
>>>     lines.
>>>
>>> Update the ARM CoreSight disassembly shell test
>>> (test_arm_coresight_disasm.sh) to invoke the standalone script.
>>>
>>> Assisted-by: Antigravity:gemini-3.1-pro
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>> ---
>>>    tools/perf/python/arm-cs-trace-disasm.py      | 356 ++++++++++++++++++
>>>    .../coresight/test_arm_coresight_disasm.sh    |  24 +-
>>>    tools/perf/tests/shell/lib/setup_python.sh    |   4 +
>>>    3 files changed, 378 insertions(+), 6 deletions(-)
>>>    create mode 100755 tools/perf/python/arm-cs-trace-disasm.py
>>>
>>> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python/arm-cs-trace-disasm.py
>>> new file mode 100755
>>> index 000000000000..1a9d9a01d1e4
>>> --- /dev/null
>>> +++ b/tools/perf/python/arm-cs-trace-disasm.py
>>> @@ -0,0 +1,356 @@
>>> +#!/usr/bin/env python3
>>> +# SPDX-License-Identifier: GPL-2.0
>>> +"""
>>> +arm-cs-trace-disasm.py: ARM CoreSight Trace Dump With Disassember using perf python module
>>> +"""
>>> +from __future__ import annotations
>>> +
>>> +import os
>>> +from os import path
>>> +import re
>>> +from subprocess import CalledProcessError, check_output
>>> +import argparse
>>> +import platform
>>> +import sys
>>> +from typing import Dict, List, Optional
>>> +
>>> +import perf
>>> +
>>> +# Initialize global dicts and regular expression
>>> +DISASM_CACHE: Dict[str, List[str]] = {}
>>> +CPU_DATA: Dict[str, int] = {}
>>> +DISASM_RE = re.compile(r"^\s*([0-9a-fA-F]+):")
>>> +DISASM_FUNC_RE = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
>>> +CACHE_SIZE = 1024
>>> +class _State:
>>> +    sample_idx: int = -1
>>> +    source_file_name: Optional[str] = None
>>> +    line_number: Optional[int] = None
>>> +    dso: Optional[str] = None
>>> +
>>> +_STATE = _State()
>>> +
>>> +KVER = platform.release()
>>> +VMLINUX_PATHS = [
>>> +    f"/usr/lib/debug/boot/vmlinux-{KVER}.debug",
>>> +    f"/usr/lib/debug/lib/modules/{KVER}/vmlinux",
>>> +    f"/lib/modules/{KVER}/build/vmlinux",
>>> +    f"/usr/lib/debug/boot/vmlinux-{KVER}",
>>> +    f"/boot/vmlinux-{KVER}",
>>> +    "/boot/vmlinux",
>>> +    "vmlinux"
>>> +]
>>> +
>>> +def default_objdump() -> str:
>>> +    """Return the default objdump path from perf config or 'objdump'."""
>>> +    try:
>>> +        config = perf.config_get("annotate.objdump")
>>> +        return str(config) if config else "objdump"
>>> +    except (AttributeError, TypeError):
>>> +        return "objdump"
>>> +
>>> +def find_vmlinux() -> Optional[str]:
>>> +    """Find the vmlinux file in standard paths."""
>>> +    if hasattr(find_vmlinux, "path"):
>>> +        return getattr(find_vmlinux, "path")
>>> +
>>> +    for v in VMLINUX_PATHS:
>>> +        if os.access(v, os.R_OK):
>>> +            setattr(find_vmlinux, "path", v)
>>> +            return v
>>> +    setattr(find_vmlinux, "path", None)
>>> +    return None
>>> +
>>> +def get_dso_file_path(dso_name: str, dso_build_id: str, vmlinux: Optional[str]) -> str:
>>> +    """Return the path to the DSO file."""
>>> +    buildid_dir = os.environ.get('PERF_BUILDID_DIR')
>>> +    if not buildid_dir:
>>> +        buildid_dir = os.path.join(os.environ.get('HOME', ''), '.debug')
>>> +
>>> +    if dso_name in ("[kernel.kallsyms]", "vmlinux"):
>>> +        if vmlinux:
>>> +            return vmlinux
>>> +        if dso_build_id:
>>> +            for kname in (dso_name, "vmlinux", "[kernel.kallsyms]"):
>>> +                candidate = os.path.join(buildid_dir, kname, dso_build_id, "elf")
>>> +                if os.access(candidate, os.R_OK):
>>> +                    return candidate
>>> +        return find_vmlinux() or dso_name
>>> +
>>> +    if dso_name == "[vdso]":
>>> +        append = "/vdso"
>>> +    else:
>>> +        append = "/elf"
>>> +
>>> +    dso_path = buildid_dir + "/" + dso_name + "/" + dso_build_id + append
>>> +    # Replace duplicate slash chars to single slash char
>>> +    dso_path = dso_path.replace('//', '/', 1)
>>> +    return dso_path
>>> +
>>> +def read_disam(dso_fname: str, dso_start: int, start_addr: int,
>>> +               stop_addr: int, objdump: str) -> List[str]:
>>> +    """Read disassembly from a DSO file using objdump."""
>>> +    addr_range = f"{start_addr}:{stop_addr}:{dso_start}:{dso_fname}"
>>> +
>>> +    # Don't let the cache get too big, clear it when it hits max size
>>> +    if len(DISASM_CACHE) > CACHE_SIZE:
>>> +        DISASM_CACHE.clear()
>>> +
>>> +    if addr_range in DISASM_CACHE:
>>> +        disasm_output = DISASM_CACHE[addr_range]
>>> +    else:
>>> +        start_addr = start_addr - dso_start
>>> +        stop_addr = stop_addr - dso_start
>>> +        disasm = [objdump, "-d", "-z",
>>> +                  f"--start-address={start_addr:#x}",
>>> +                  f"--stop-address={stop_addr:#x}"]
>>> +        disasm += [dso_fname]
>>> +        try:
>>> +            disasm_output = check_output(disasm).decode('utf-8', errors='replace').split('\n')
>>> +        except (CalledProcessError, OSError):
>>> +            return []
>>> +        if len(disasm_output) <= 512:
>>> +            DISASM_CACHE[addr_range] = disasm_output
>>> +
>>> +    return disasm_output
>>> +
>>> +def print_disam(dso_fname: str, dso_start: int, start_addr: int,
>>> +                stop_addr: int, objdump: str) -> None:
>>> +    """Print disassembly for a given address range."""
>>> +    for line in read_disam(dso_fname, dso_start, start_addr, stop_addr, objdump):
>>> +        m = DISASM_FUNC_RE.search(line)
>>> +        if m is None:
>>> +            m = DISASM_RE.search(line)
>>> +            if m is None:
>>> +                continue
>>> +        print(f"\t{line}")
>>> +
>>> +def print_sample(sample: perf.sample_event) -> None:
>>> +    """Print sample details."""
>>> +    print(f"Sample = {{ cpu: {sample.sample_cpu:04d} addr: {sample.sample_addr:016x} "
>>> +          f"phys_addr: {sample.sample_phys_addr:016x} ip: {sample.sample_ip:016x} "
>>> +          f"pid: {sample.sample_pid} tid: {sample.sample_tid} period: {sample.sample_period} "
>>> +          f"time: {sample.sample_time} index: {_STATE.sample_idx}}}")
>>> +
>>> +def common_start_str(comm: str, sample: perf.sample_event) -> str:
>>> +    """Return common start string for sample output."""
>>> +    sec = int(sample.sample_time / 1000000000)
>>> +    ns = sample.sample_time % 1000000000
>>> +    cpu = sample.sample_cpu
>>> +    pid = sample.sample_pid
>>> +    tid = sample.sample_tid
>>> +    return f"{comm:>16s} {pid:5d}/{tid:<5d} [{cpu:04d}] {sec:9d}.{ns:09d}  "
>>> +
>>> +def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso: str) -> None:
>>> +    """Print source code and symbols for a sample."""
>>> +    ip = sample.sample_ip
>>> +    if symbol == "[unknown]":
>>> +        start_str = common_start_str(comm, sample) + f"{ip:x}".rjust(16).ljust(40)
>>> +    else:
>>> +        symoff = 0
>>> +        symoff = getattr(sample, 'sym_offset', 0) or 0
>>> +        offs = f"+{symoff:#x}" if symoff != 0 else ""
>>> +        start_str = common_start_str(comm, sample) + (symbol + offs).ljust(40)
>>> +
>>> +    source_file_name, line_number, source_line = sample.srccode() or (None, 0, None)
>>> +    if source_file_name:
>>> +        if _STATE.line_number == line_number and _STATE.source_file_name == source_file_name:
>>> +            src_str = ""
>>> +        else:
>>> +            if len(source_file_name) > 40:
>>> +                src_file = f"...{source_file_name[-37:]} "
>>> +            else:
>>> +                src_file = source_file_name.ljust(41)
>>> +
>>> +            if source_line is None:
>>> +                src_str = f"{src_file}{line_number:>4d} <source not found>"
>>> +            else:
>>> +                src_str = f"{src_file}{line_number:>4d} {source_line}"
>>> +        _STATE.dso = None
>>> +    elif dso == _STATE.dso:
>>> +        src_str = ""
>>> +    else:
>>> +        src_str = dso
>>> +        _STATE.dso = dso
>>> +
>>> +    _STATE.line_number = line_number
>>> +    _STATE.source_file_name = source_file_name
>>> +
>>> +    print(start_str, src_str)
>>> +
>>> +class TraceDisasm:
>>> +    """Class to handle trace disassembly."""
>>> +    def __init__(self, cli_options: argparse.Namespace):
>>> +        self.options = cli_options
>>> +        self.sample_idx = -1
>>> +        self.session: Optional[perf.session] = None
>>> +
>>> +    def process_event(self, sample: perf.sample_event) -> None:
>>> +        """Process a single perf event."""
>>> +        self.sample_idx += 1
>>> +        _STATE.sample_idx = self.sample_idx
>>> +
>>> +        if self.options.start_time is not None and sample.sample_time < self.options.start_time:
>>> +            return
>>> +        if self.options.stop_time is not None and sample.sample_time > self.options.stop_time:
>>> +            sys.exit(0)
>>> +        if self.options.start_sample is not None and self.sample_idx < self.options.start_sample:
>>> +            return
>>> +        if self.options.stop_sample is not None and self.sample_idx > self.options.stop_sample:
>>> +            sys.exit(0)
>>> +
>>> +        ev_name = str(sample.evsel)
>>> +        if self.options.verbose:
>>> +            print(f"Event type: {ev_name}")
>>> +            print_sample(sample)
>>> +
>>> +        dso = sample.dso or '[unknown]'
>>> +        symbol = sample.symbol or '[unknown]'
>>> +        dso_bid = (sample.dso_bid.decode('utf-8')
>>> +                   if isinstance(sample.dso_bid, bytes)
>>> +                   else str(sample.dso_bid or '[unknown]'))
>>> +        dso_start = sample.map_start
>>> +        dso_end = sample.map_end
>>> +        map_pgoff = sample.map_pgoff or 0
>>> +
>>> +        comm = "[unknown]"
>>> +        try:
>>> +            if self.session:
>>> +                thread_info = self.session.find_thread(sample.sample_tid)
>>> +                if thread_info:
>>> +                    comm = thread_info.comm() or "[unknown]"
>>> +        except (TypeError, AttributeError):
>>> +            pass
>>> +
>>> +        if dso == '[unknown]':
>>> +            return
>>> +
>>> +        if dso_start is None or dso_end is None:
>>> +            print(f"Failed to find valid dso map for dso {dso}")
>>> +            return
>>> +
>>> +        if "instructions" in ev_name:
>>> +            print_srccode(comm, sample, symbol, dso)
>>> +            return
>>> +
>>> +        if "branches" not in ev_name:
>>> +            return
>>> +
>>> +        self._process_branch(sample, comm, symbol, dso, dso_bid, dso_start, dso_end, map_pgoff)
>>> +
>>> +    def _process_branch(self, sample: perf.sample_event, comm: str, symbol: str, dso: str,
>>> +                        dso_bid: str, dso_start: int, dso_end: int, map_pgoff: int) -> None:
>>> +        """Helper to process branch events."""
>>> +        cpu = sample.sample_cpu
>>> +        ip = sample.sample_ip
>>> +        addr = sample.sample_addr
>>> +
>>> +        if CPU_DATA.get(str(cpu) + 'addr') is None:
>>> +            CPU_DATA[str(cpu) + 'addr'] = addr
>>> +            return
>>> +
>>> +        start_addr = CPU_DATA[str(cpu) + 'addr']
>>> +        stop_addr  = ip + 4
>>> +
>>> +        # Record for previous sample packet
>>> +        CPU_DATA[str(cpu) + 'addr'] = addr
>>> +
>>> +        # Filter out zero start_address. Optionally identify CS_ETM_TRACE_ON packet
>>> +        if start_addr == 0:
>>> +            if stop_addr == 4 and self.options.verbose:
>>> +                print(f"CPU{cpu}: CS_ETM_TRACE_ON packet is inserted")
>>> +            return
>>> +
>>> +        if start_addr < dso_start or start_addr > dso_end:
>>> +            print(f"Start address {start_addr:#x} is out of range [ {dso_start:#x} .. "
>>> +                  f"{dso_end:#x} ] for dso {dso}")
>>> +            return
>>> +
>>> +        if stop_addr < dso_start or stop_addr > dso_end:
>>> +            print(f"Stop address {stop_addr:#x} is out of range [ {dso_start:#x} .. "
>>> +                  f"{dso_end:#x} ] for dso {dso}")
>>> +            return
>>> +
>>> +        if self.options.objdump is not None:
>>> +            if dso == "[kernel.kallsyms]":
>>> +                dso_vm_start = 0
>>> +                map_pgoff_local = 0
>>> +            elif dso_start == 0x400000:
>>> +                dso_vm_start = 0
>>> +                map_pgoff_local = 0
>>> +            else:
>>> +                dso_vm_start = dso_start
>>> +                map_pgoff_local = map_pgoff
>>> +
>>> +            dso_fname = get_dso_file_path(dso, dso_bid, self.options.vmlinux)
>>> +            if path.exists(dso_fname):
>>> +                print_disam(dso_fname, dso_vm_start, start_addr + map_pgoff_local,
>>> +                            stop_addr + map_pgoff_local, self.options.objdump)
>>> +            else:
>>> +                print(f"Failed to find dso {dso} for address range [ "
>>> +                      f"{start_addr + map_pgoff_local:#x} .. {stop_addr + map_pgoff_local:#x} ]")
>>> +
>>> +        print_srccode(comm, sample, symbol, dso)
>>> +
>>> +    def run(self) -> None:
>>> +        """Run the trace disassembly session."""
>>> +        input_file = self.options.input or "perf.data"
>>> +        if input_file != "-" and not os.path.exists(input_file):
>>> +            print(f"Error: {input_file} not found.", file=sys.stderr)
>>> +            sys.exit(1)
>>> +
>>> +        print('ARM CoreSight Trace Data Assembler Dump')
>>> +        try:
>>> +            self.session = perf.session(
>>> +                perf.data(input_file),
>>> +                sample=self.process_event,
>>> +                itrace=self.options.itrace
>>> +            )
>>> +        except (OSError, ValueError, KeyError, RuntimeError, TypeError, AttributeError) as e:
>>> +            print(f"Error opening session: {e}", file=sys.stderr)
>>> +            sys.exit(1)
>>> +
>>> +        try:
>>> +            self.session.process_events()
>>> +        finally:
>>> +            self.session = None
>>> +        print('End')
>>> +
>>> +if __name__ == "__main__":
>>> +    def int_arg(v: str) -> int:
>>> +        """Helper for integer command line arguments."""
>>> +        val = int(v)
>>> +        if val < 0:
>>> +            raise argparse.ArgumentTypeError("Argument must be a positive integer")
>>> +        return val
>>> +
>>> +    arg_parser = argparse.ArgumentParser(description="ARM CoreSight Trace Dump With Disassembler")
>>> +    arg_parser.add_argument("-i", "--input", help="input perf.data file")
>>> +    arg_parser.add_argument("-k", "--vmlinux",
>>> +                            help="Set path to vmlinux file. Omit to autodetect")
>>> +    arg_parser.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
>>> +                            help="Show disassembly. Can also be used to change the objdump path")
>>> +    arg_parser.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
>>> +    arg_parser.add_argument("--start-time", type=int_arg,
>>> +                            help="Monotonic clock time of sample to start from.")
>>> +    arg_parser.add_argument("--stop-time", type=int_arg,
>>> +                            help="Monotonic clock time of sample to stop at.")
>>> +    arg_parser.add_argument("--itrace", default="b",
>>> +                            help="Instruction tracing options.")
>>> +    arg_parser.add_argument("--start-sample", type=int_arg,
>>> +                            help="Index of sample to start from.")
>>> +    arg_parser.add_argument("--stop-sample", type=int_arg,
>>> +                            help="Index of sample to stop at.")
>>> +
>>> +    parsed_options = arg_parser.parse_args()
>>> +    if (parsed_options.start_time is not None and parsed_options.stop_time is not None and
>>> +            parsed_options.start_time >= parsed_options.stop_time):
>>> +        print("--start-time must less than --stop-time")
>>> +        sys.exit(2)
>>> +    if (parsed_options.start_sample is not None and parsed_options.stop_sample is not None and
>>> +            parsed_options.start_sample >= parsed_options.stop_sample):
>>> +        print("--start-sample must less than --stop-sample")
>>> +        sys.exit(2)
>>> +
>>> +    td = TraceDisasm(parsed_options)
>>> +    td.run()
>>> diff --git a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
>>> index f3ebad596378..51bcbd78f460 100755
>>> --- a/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
>>> +++ b/tools/perf/tests/shell/coresight/test_arm_coresight_disasm.sh
>>> @@ -1,6 +1,6 @@
>>>    #!/bin/bash
>>> -# Check Arm CoreSight disassembly script completes without errors (exclusive)
>>>    # SPDX-License-Identifier: GPL-2.0
>>> +# Check Arm CoreSight disassembly script completes without errors (exclusive)
>>>
>>>    # The disassembly script reconstructs ranges of instructions and gives these to objdump to
>>>    # decode. objdump doesn't like ranges that go backwards, but these are a good indication
>>> @@ -22,9 +22,21 @@ glb_err=1
>>>
>>>    perfdata_dir=$(mktemp -d /tmp/__perf_test.perf.data.XXXXX)
>>>    perfdata=${perfdata_dir}/perf.data
>>> +perfdata2=${perfdata_dir}/perf2.data
>>>    file=$(mktemp /tmp/temporary_file.XXXXX)
>>>    # Relative path works whether it's installed or running from repo
>>> -script_path=$(dirname "$0")/../../../scripts/python/arm-cs-trace-disasm.py
>>> +if [ -n "$PERF_EXEC_PATH" ] && [ -e "$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py" ]; then
>>> +     script_path="$PERF_EXEC_PATH/python/arm-cs-trace-disasm.py"
>>> +else
>>> +     script_path=$(dirname "$0")/../../../python/arm-cs-trace-disasm.py
>>> +fi
>>> +
>>> +# shellcheck source=lib/setup_python.sh
>>> +. "$(dirname "$0")"/../lib/setup_python.sh
>>> +$PYTHON -c "import perf" 2>/dev/null || {
>>> +     echo "Skipping test, perf python module not found"
>>> +     exit 2
>>> +}
>>>
>>>    cleanup_files()
>>>    {
>>> @@ -44,8 +56,8 @@ branch_search='[[:space:]](bl|b(\.(eq|ne|cs|cc|mi|pl|vs|vc|hi|ls|ge|lt|gt|le|al)
>>>    if [ "$(id -u)" == 0 ] && [ -e /proc/kcore ]; then
>>>        echo "Testing kernel disassembly"
>>>        perf record -o ${perfdata} -e cs_etm//k --kcore -Se -m,64K -- touch $file > /dev/null 2>&1
>>> -     perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
>>> -             -d --stop-sample=2 -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
>>> +     $PYTHON ${script_path} -i ${perfdata} --itrace=b -d --stop-sample=2 \
>>> +             -k ${perfdata}/kcore_dir/kcore 2> /dev/null > ${file}
>>>        grep -q -E ${branch_search} ${file}
>>>        echo "Found kernel branches"
>>>    else
>>> @@ -56,8 +68,8 @@ fi
>>>    ## Test user ##
>>>    echo "Testing userspace disassembly"
>>>    perf record -o ${perfdata} -e cs_etm//u -Se -m,64K -- touch $file > /dev/null 2>&1
>>> -perf script -i ${perfdata} --itrace=b -s python:${script_path} -- \
>>> -     -d --stop-sample=2 2> /dev/null > ${file}
>>> +perf inject --itrace=b -i ${perfdata} -o ${perfdata2}
>>> +$PYTHON ${script_path} -i ${perfdata2} -d --stop-sample=2 2> /dev/null > ${file}
>>>    grep -q -E ${branch_search} ${file}
>>>    echo "Found userspace branches"
>>>
>>> diff --git a/tools/perf/tests/shell/lib/setup_python.sh b/tools/perf/tests/shell/lib/setup_python.sh
>>> index 2173215a0517..220d9663f81a 100644
>>> --- a/tools/perf/tests/shell/lib/setup_python.sh
>>> +++ b/tools/perf/tests/shell/lib/setup_python.sh
>>> @@ -18,6 +18,10 @@ fi
>>>    # Set PYTHONPATH to find the in-tree built perf.so first, avoiding system-wide perf.so
>>>    if [ -n "$PERF_EXEC_PATH" ] && [ -d "$PERF_EXEC_PATH/python" ]; then
>>>      PYTHONPATH_DIR="$PERF_EXEC_PATH/python"
>>> +elif [ -n "${BASH_SOURCE[0]}" ] && [ -d "$(dirname "${BASH_SOURCE[0]}")/../../../python" ]; then
>>> +  PYTHONPATH_DIR="$(dirname "${BASH_SOURCE[0]}")/../../../python"
>>> +elif [ -d "$(dirname "$0")/../../../python" ]; then
>>> +  PYTHONPATH_DIR="$(dirname "$0")/../../../python"
>>>    elif [ -d "$(dirname "$0")/../../python" ]; then
>>>      PYTHONPATH_DIR="$(dirname "$0")/../../python"
>>>    elif [ -d "$(dirname "$0")/../python" ]; then
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Thanks! v3 has some Sashiko related nits cleaned up in this code, but
> I'll keep the reviewed-by tag. I hope that's okay.
> 
> Thanks,
> Ian

Yep sure.
