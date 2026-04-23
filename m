Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047B314A79
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918661; cv=none; b=ijIxFBjKIR/5pqCxjAyTi2iYiDVP8XZ91kMOZsVV97rkNZPWFpOVvblDdI2sm0SBvrhPZt+oIpIMS1FiUdjmkTDQgJSkwdXzfxnbBJo/LE4KHiJmXJmwGt9JeYA8PyKljVOPN+HR20y4QjtHUhdUHBFtqNBOVEb70AfjIz/jm9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918661; c=relaxed/simple;
	bh=QP/10bpffnFzT8IzQEniAorfYGAaPayOM+JOekPrfr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qcVmH5Dj6G58umP1z0gezk4gZR6XByzC2c/zS+fm5S2ISjKRoKokiEwYr0wpsrmedWf58+Sq/JSX7fDw+WSIH2Y6/tA6WSok6J8wEj65myTcZV0nCySgTqnLNTCK9PCZpyFhqKz7HHvQES4TXgkdY1RWTkENvSU/dfJTKTYTRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuRsNF4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuRsNF4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DE6C2BCB2;
	Thu, 23 Apr 2026 04:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918661;
	bh=QP/10bpffnFzT8IzQEniAorfYGAaPayOM+JOekPrfr0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HuRsNF4WMSWYNO38EKqw4IsbleQKW+ek6IOax/+TReS6e14d68Irhw9KzKatpZd/6
	 eQfFdYc19ELvKEo2LimRavVSobiErym18MkTXA2DmRnStBARogHTRk0O4lFYvOSUBp
	 40AOXllZxu/L34sTSfgnNoOMQsNvKmMUHuCt9nIyZ5Mvarv9PM0L6pVcURSzOaq4E/
	 t+VsGiQ7Z5MP339nNt1qH+kllLwXx4mFXayrfEBpbAjuhcln82YHS5hrWdbz7WS5FN
	 BUIpcNh8UxvguvMFUjYYQN+lj5CtpfE8J1H/g05xaF2VTNMb75BTGUVYG67vt1LQIW
	 CUrvf+u+SC+GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/58] perf arm-cs-trace-disasm: Port
 arm-cs-trace-disasm to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-33-irogers@google.com>
References: <20260423035526.1537178-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:31:00 +0000
Message-Id: <20260423043101.45DE6C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Event filtering completely fails because `str(sample.evsel)` retur=
ns a formatted string like 'evsel(instructions)', not the raw event name.
- [High] Path traversal in `get_dso_file_path` allows untrusted DSO names f=
rom mmap events to cause indefinite hangs via `objdump`.
- [High] Invalid format specifier 'u' in common_start_str causes an immedia=
te unhandled ValueError, crashing the script.
- [High] Unbounded growth of the CPU_DATA dictionary allows an attacker-con=
trolled perf.data to cause an Out-of-Memory (OOM) crash.
- [High] Unbounded memory buffering of objdump output via check_output can =
lead to memory and CPU exhaustion.
- [Medium] Using `sys.exit()` inside a callback invoked from a C extension =
turns a clean exit into a crash.
- [Medium] The standalone script will fail with a ModuleNotFoundError durin=
g 'perf test' from the source tree before installation, causing a spurious =
test failure.
- [Medium] Missing error handling around subprocess.check_output leads to a=
brupt crashes on invalid files or objdump execution failures.
--

commit 8401652e9d125b6d2f4f619222fc614a41372a4b
Author: Ian Rogers <irogers@google.com>

perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python module
   =20
Add a port of the arm-cs-trace-disasm script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields. Update the testing to use the ported script.

> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python=
/arm-cs-trace-disasm.py
> new file mode 100755
> index 0000000000000..d1227e809adf6
> --- /dev/null
> +++ b/tools/perf/python/arm-cs-trace-disasm.py
[ ... ]
> +def get_dso_file_path(dso_name: str, dso_build_id: str, vmlinux: Optiona=
l[str]) -> str:
[ ... ]
> +    dso_path =3D buildid_dir + "/" + dso_name + "/" + dso_build_id + app=
end
> +    # Replace duplicate slash chars to single slash char
> +    dso_path =3D dso_path.replace('//', '/', 1)
> +    return dso_path

Since dso_name can originate from untrusted mmap events in the perf.data
file, could this allow path traversal (e.g., "../../tmp/fifo")?

Calling objdump on a FIFO without O_NONBLOCK could cause it to hang
indefinitely, violating subsystem guidelines on safe file I/O for untrusted
paths.

[ ... ]
> +def read_disam(dso_fname: str, dso_start: int, start_addr: int,
> +               stop_addr: int, objdump: str) -> List[str]:
[ ... ]
> +    if addr_range in DISASM_CACHE:
> +        disasm_output =3D DISASM_CACHE[addr_range]
> +    else:
> +        start_addr =3D start_addr - dso_start
> +        stop_addr =3D stop_addr - dso_start
> +        disasm =3D [objdump, "-d", "-z",
> +                  f"--start-address=3D{start_addr:#x}",
> +                  f"--stop-address=3D{stop_addr:#x}"]
> +        disasm +=3D [dso_fname]
> +        disasm_output =3D check_output(disasm).decode('utf-8').split('\n=
')

If a malicious perf.data file crafts consecutive samples with massive addre=
ss
gaps, wouldn't this cause subprocess.check_output() to read gigantic amounts
of objdump output directly into memory, leading to severe memory and CPU
exhaustion?

Also, what happens if objdump fails to parse an invalid DSO file or outputs
non-UTF-8 bytes? Could the lack of error handling around check_output() lead
to abrupt crashes with subprocess.CalledProcessError or UnicodeDecodeError?

[ ... ]
> +def common_start_str(comm: str, sample: perf.sample_event) -> str:
> +    """Return common start string for sample output."""
> +    sec =3D int(sample.sample_time / 1000000000)
> +    ns =3D sample.sample_time % 1000000000
> +    cpu =3D sample.sample_cpu
> +    pid =3D sample.sample_pid
> +    tid =3D sample.sample_tid
> +    return f"{comm:>16s} {pid:5u}/{tid:<5u} [{cpu:04d}] {sec:9d}.{ns:09d=
}  "

Does Python support the 'u' format specifier for integers? Could this raise
a ValueError and crash the script when formatting the f-string?

[ ... ]
> +class TraceDisasm:
> +    """Class to handle trace disassembly."""
> +    def __init__(self, cli_options: argparse.Namespace):
> +        self.options =3D cli_options
> +        self.sample_idx =3D -1
> +        self.session: Optional[perf.session] =3D None
> +
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single perf event."""
> +        self.sample_idx +=3D 1
> +        global SAMPLE_IDX
> +        SAMPLE_IDX =3D self.sample_idx
> +
> +        if self.options.start_time and sample.sample_time < self.options=
.start_time:
> +            return
> +        if self.options.stop_time and sample.sample_time > self.options.=
stop_time:
> +            sys.exit(0)

If sys.exit(0) is called here, it raises a SystemExit exception in Python.

Since this is a callback invoked from the C extension
(pyrf_session_tool__sample), would the C code catch this exception, clear
it via PyErr_Print(), and return -1?

This could cause the main event loop perf_session__process_events() to
abort and return an error instead of cleanly terminating.

[ ... ]
> +        ev_name =3D str(sample.evsel)
> +        if self.options.verbose:
> +            print(f"Event type: {ev_name}")
> +            print_sample(sample)
[ ... ]
> +        if ev_name.startswith("instructions"):
> +            print_srccode(comm, sample, symbol, dso)
> +            return

Doesn't str(sample.evsel) return a formatted string like
'evsel(instructions)', rather than the raw event name?

If so, these startswith() checks will always evaluate to False, causing the
script to silently ignore all events and produce no disassembly output.

[ ... ]
> +        cpu =3D sample.sample_cpu
> +        addr =3D sample.sample_addr
> +
> +        if CPU_DATA.get(str(cpu) + 'addr') is None:
> +            CPU_DATA[str(cpu) + 'addr'] =3D addr
> +            return

Could an attacker-controlled perf.data file supply millions of events, each
with a unique sample_cpu identifier? Since this dictionary grows unboundedl=
y,
could this consume all available memory and cause an Out-of-Memory crash?

[ ... ]
> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index 0dfb4fadf5317..c15cd60e1c246 100755
> --- a/tools/perf/tests/shell/test_arm_coresight_disasm.sh
> +++ b/tools/perf/tests/shell/test_arm_coresight_disasm.sh
[ ... ]
> @@ -45,8 +45,9 @@ branch_search=3D"\sbl${sep}b${sep}b.ne${sep}b.eq${sep}c=
bz\s"
>  if [ -e /proc/kcore ]; then
>  	echo "Testing kernel disassembly"
>  	perf record -o ${perfdata} -e cs_etm//k --kcore -- touch $file > /dev/n=
ull 2>&1
> -	perf script -i ${perfdata} -s python:${script_path} -- \
> -		-d --stop-sample=3D30 2> /dev/null > ${file}
> +	# shellcheck source=3Dlib/setup_python.sh
> +	. "$(dirname "$0")"/lib/setup_python.sh
> +	$PYTHON ${script_path} -i ${perfdata} -d --stop-sample=3D30 2> /dev/nul=
l > ${file}

If this is run during 'perf test' from the source tree before installation,
would the script fail with a ModuleNotFoundError?

Since PYTHONPATH is not configured here, and the perf.so module resides in
python_ext_build/lib/ in a source tree build, the 'import perf' statement
could crash. Combined with 'set -e' in the shell test, this could lead to a
spurious test suite failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D32
