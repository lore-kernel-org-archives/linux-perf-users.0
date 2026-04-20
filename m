Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1844946C
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645145; cv=none; b=SV75MiuehoLW214eeSAXuvPGOgUdcH09LAc8ICXtDIdRaRhrKQKBL6TelLByyNJMA5amdTklp48hhVbEfbbijGowz65UG8sIIvT/KnHmnawRBQozZL8UTaswQ6KJc1EEy7pKAkhCC+6CWaLIm4GIpfEvmgZxog1J0zymfNZYNdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645145; c=relaxed/simple;
	bh=M5bZNpFnWGBtaMYudINTXoNTvYErFntuDVvqL4Vuw8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XqDpTJxthzvn1Rxt9w2H+TVo9G1KSlqLyFR3h2kgoM9tTrRLaOwd93OKl83Xzzb+BJYd+ViCqGgOjyINMA6P9Rk3UrhPrxjNBjfgrwrFwbWai4xuXczsw6hbxvdBIyXLVmGpaIWQrGxOTNq54rEIaNnSiadLx5bVeAW+rR9UXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaQj3inH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaQj3inH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAF7C2BCAF;
	Mon, 20 Apr 2026 00:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645145;
	bh=M5bZNpFnWGBtaMYudINTXoNTvYErFntuDVvqL4Vuw8U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TaQj3inHLttlyc2c/weUO6UDW3ppLLNIg3ZbRAJ9OnlbQ+FSFcscvNfLkuC/Y0lwX
	 GdDV0c4IRgR3bk464YkUWcfqGnxyXtxB3TIIkJ0l8kcCxkzEcQ1o4y2Agt9rgTsRYb
	 5fPdIhVSkc/4RKBtEy5dev8/SvP2s82c39xEbKeFdkOKc1XygY7NqMdY36E9CmiEBK
	 KoFW8USddKvBgjijU6uMHxTcC475ty501xFDx2Y7qtTH1jmaIxVyeLPLtycBgjFCYE
	 Jq/g9AnnXIfn1zqOxvgVXTJ11QUdkbK+G+3wp8OcLZ8Y3bx6sQYdmkMFAfaM+xg3/q
	 jJT0AKOIUPxaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 39/58] perf intel-pt-events: Port
 intel-pt-events/libxed to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-40-irogers@google.com>
References: <20260419235911.2186050-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:32:24 +0000
Message-Id: <20260420003225.3FAF7C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 8 potential issue(s):
- [High] Accessing fields like `sample.cpu`, `sample.time`, `sample.pid`, a=
nd `sample.ip` will immediately crash the script with an `AttributeError`.
- [High] Event-type conditionals will always evaluate to `False` due to inc=
orrectly extracting the event name via `str(sample.evsel)`.
- [High] The thread command name (`comm`) logic is broken and will silently=
 fall back to `"Unknown"` for all events.
- [High] Instruction bytes containing NUL characters (`\x00`) will be silen=
tly truncated before disassembly.
- [High] Extracting the decoded instruction length relies on a hardcoded in=
ternal offset in `libxed.py`, leading to potential out-of-bounds array read=
s.
- [High] Missing length checks before `struct.unpack_from` leads to out-of-=
bounds reads and script termination on unvalidated payload buffers.
- [Medium] Untrusted payload data is used as a mathematical divisor without=
 being checked for zero.
- [Medium] The exception handler designed to suppress `BrokenPipeError` tra=
ceback output contains a bug that triggers an uncatchable exception during =
interpreter shutdown.
--

commit 5f2caf09eb634efff61968a9fb75db89cffff164
Author: Ian Rogers <irogers@google.com>

perf intel-pt-events: Port intel-pt-events/libxed to use python module

This commit ports the intel-pt-events and libxed scripts to use a class
structure and a standalone python module. It removes Python 2 compatibility
and renames methods in libxed.py to snake case.

> diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/int=
el-pt-events.py
> new file mode 100755
> index 0000000000000..cb730d1009f45
> --- /dev/null
> +++ b/tools/perf/python/intel-pt-events.py

[ ... ]

> +    def print_cbr(self, raw_buf: bytes) -> None:
> +        """Print CBR data."""
> +        data =3D struct.unpack_from("<BBBBII", raw_buf)
> +        cbr =3D data[0]
> +        f =3D (data[4] + 500) // 1000
> +        p =3D ((cbr * 1000 // data[2]) + 5) // 10

Can struct.unpack_from() raise an exception if raw_buf is empty or smaller
than the requested format?

Is it possible for data[2] to be zero, triggering a ZeroDivisionError during
this calculation?

[ ... ]

> +    def print_evt(self, raw_buf: bytes) -> None:

[ ... ]

> +        data =3D struct.unpack_from("<BBH", raw_buf)
> +        typ =3D data[0] & 0x1f
> +        ip_flag =3D (data[0] & 0x80) >> 7
> +        vector =3D data[1]
> +        evd_cnt =3D data[2]

[ ... ]

> +        pos =3D 4
> +        for _ in range(evd_cnt):
> +            data =3D struct.unpack_from("<QQ", raw_buf, pos)

Are there missing length checks on raw_buf? If evd_cnt is larger than the
remaining buffer size, wouldn't struct.unpack_from() raise a struct.error
and terminate the session?

[ ... ]

> +    def disassem(self, insn: bytes, ip: int) -> tuple[int, str]:
> +        """Disassemble instruction using LibXED."""
> +        inst =3D self.disassembler.instruction()
> +        self.disassembler.set_mode(inst, 0)  # Assume 64-bit
> +        buf =3D create_string_buffer(64)
> +        buf.value =3D insn

Doesn't assigning insn to buf.value treat it as a null-terminated C string?
Since x86 machine code can contain \x00 bytes, won't this prematurely trunc=
ate
the instruction stream before disassembly? Would assigning to buf.raw be
safer?

[ ... ]

> +    def print_common_ip(self, sample: perf.sample_event, symbol: str, ds=
o: str) -> None:
> +        """Print IP and symbol info."""
> +        ip =3D sample.ip

Do these sample attributes exist on the new perf.sample_event C extension
object? Looking at the sample_member_def macro in tools/perf/util/python.c,
it seems the properties are exposed with a sample_ prefix, such as
sample_ip, sample_cpu, and sample_time. Will accessing sample.ip raise an
AttributeError?

[ ... ]

> +    def do_process_event(self, sample: perf.sample_event) -> None:
> +        """Process event and print info."""
> +        comm =3D getattr(sample, "comm", "Unknown")
> +        name =3D str(sample.evsel)

Does the perf.sample_event object expose a comm property? Without the legacy
environment manually injecting it into the event dictionary, will this
unconditionally fall back to Unknown? Would calling
session.process(sample.sample_pid).comm() be required to retrieve the
thread name?

Also, doesn't str(sample.evsel) return a formatted string like
evsel(instructions) rather than just instructions?

[ ... ]

> +        if name.startswith("instructions"):

If name contains evsel(instructions), will this startswith() check, as well
as the exact matches like name =3D=3D "ptwrite" below, always evaluate to f=
alse?

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Wrapper to handle interleaving and exceptions."""
> +        try:
> +            if self.args.interleave:
> +                self.interleave_events(sample)
> +            else:
> +                self.do_process_event(sample)
> +        except BrokenPipeError:
> +            # Stop python printing broken pipe errors and traceback
> +            with open(os.devnull, 'w', encoding=3D'utf-8') as f:
> +                sys.stdout =3D f
> +            sys.exit(1)

When the with block ends, f is closed, but sys.stdout still points to it.
When sys.exit(1) triggers interpreter shutdown, will it attempt to flush the
closed sys.stdout and raise a secondary ValueError, defeating the purpose of
suppressing the traceback?

> diff --git a/tools/perf/python/libxed.py b/tools/perf/python/libxed.py
> new file mode 100755
> index 0000000000000..486987c6ec6de
> --- /dev/null
> +++ b/tools/perf/python/libxed.py

[ ... ]

> +    def disassemble_one(self, inst, bytes_ptr, bytes_cnt, ip):
> +        """Disassemble one instruction."""

[ ... ]

> +        result =3D inst.buffer.value.decode('utf-8')
> +        # Return instruction length and the disassembled instruction text
> +        # For now, assume the length is in byte 166
> +        return inst.xedd[166], result

Is it safe to rely on this hardcoded internal struct offset? If the layout =
of
xed_decoded_inst_t changes across libxed versions and byte 166 contains a
garbage value larger than bytes_cnt, will the calling loop in
print_common_ip() perform an out-of-bounds read and crash? Should this use
the official libxed API function to get the instruction length?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D39
