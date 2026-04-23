Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224F377543
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917480; cv=none; b=BEqZvuvncUeWhAhyJsKLhqA3PuwQE5D4xj6krLnqKL5BmbuNLXO5EsPR0n9dv3q72xkgALJjt/urf12a8VPDKLwALk/RCWmEsvQj4qiXgg5x/FzS0LxocLziQF2SBqr62JKysP9lkDjQ4J5tzZr9B0nvGVuDUnR7S61ArfckX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917480; c=relaxed/simple;
	bh=vJZEZhywyqexIvircDfDCH9xgYHgKH2SKgR+WoNhY4Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q287gcXxAAbeUEY237ncx1uyaSr7S6NZc9DCGiMEql4V5gUhVm+h4v2SYg8BGEOZuYXK8gaCtJfAZBI+NbhqdSspTB5l8w2PEVDKfmSnAtG+M9aWPXQquvxrYGj7SDH06rprAiAu0gumZOgBOPPPsWVTcbdpbzEmQBxXSYwRQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uwa47Nmd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwa47Nmd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC41C2BCB2;
	Thu, 23 Apr 2026 04:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917480;
	bh=vJZEZhywyqexIvircDfDCH9xgYHgKH2SKgR+WoNhY4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Uwa47NmdXLJdRtA36GNP2gvpAjWyQ5ULsRE728fEnefeCKNOVrgPSedQPCmx07sUD
	 f+hpfbUMUs6qyy6nrkNy5YiugJ53NseCGrsHHt2OxFx/p7Y2NZKVEJ0EncTS0j2I2m
	 3fU1GJ5XtKKmJ7ROYnOExPuPbKtK80USX3Wv+v1cv7Mqh6eFvKGpsanhSUWmjYr2HX
	 6tdjgVUjlD5jXI+tiS/20DKTxue4n9Psku1Cho1gZwupZ3Cs2z6lWqD4eetfuTTRfv
	 IA/mxsf/q7D7mGtICDa/EUnu7sCwG3raPFm5oRRd1h2rgAj1yfUp+HxxA1nkvYrF9G
	 HSZ4/9g5afLuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 39/58] perf intel-pt-events: Port
 intel-pt-events/libxed to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-40-irogers@google.com>
References: <20260423035526.1537178-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:11:19 +0000
Message-Id: <20260423041120.0AC41C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Invalid Python f-string integer format code (`u`) will cause a Val=
ueError.
- [High] Invalid Python f-string string alignment specifier (`-`) will caus=
e a ValueError.
- [Medium] Unhandled `struct.error` due to lack of `raw_buf` length validat=
ion.
- [Medium] Context switch event tracking has been dropped, resulting in dea=
d code.
--

commit a17b74084afffdae113ced9a1063e6977c2a9358
Author: Ian Rogers <irogers@google.com>

perf intel-pt-events: Port intel-pt-events/libxed to use python module

Ported from tools/perf/scripts/python/.
- Refactored intel-pt-events.py to use a class structure to eliminate
  global state and improve maintainability.
- Removed Python 2 compatibility checks.
- Renamed methods in libxed.py to snake_case (Instruction ->
  instruction, SetMode -> set_mode, DisassembleOne -> disassemble_one)
  to comply with pylint.

> diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/int=
el-pt-events.py
> new file mode 100755
> index 0000000000000..682bf80becfee
> --- /dev/null
> +++ b/tools/perf/python/intel-pt-events.py
[ ... ]
> +    def print_ptwrite(self, raw_buf: bytes) -> None:
> +        """Print PTWRITE data."""
> +        data =3D struct.unpack_from("<IQ", raw_buf)

If raw_buf is empty or smaller than the format size (which can happen if
sample.raw_buf falls back to an empty byte string later in the code), won't
this raise an unhandled struct.error and crash the script?

[ ... ]
> +    def common_start_str(self, comm: str, sample: perf.sample_event) -> =
str:
> +        """Return common start string for display."""
> +        ts =3D sample.sample_time
> +        cpu =3D sample.sample_cpu
> +        pid =3D sample.sample_pid
> +        tid =3D sample.tid
> +        machine_pid =3D getattr(sample, "machine_pid", 0)
> +        if machine_pid:
> +            vcpu =3D getattr(sample, "vcpu", -1)
> +            return (f"VM:{machine_pid:5d} VCPU:{vcpu:03d} {comm:>16s} {p=
id:5u}/{tid:<5u} "
> +                    f"[{cpu:03u}] {ts // 1000000000:9u}.{ts % 1000000000=
:09u}  ")
> +        return (f"{comm:>16s} {pid:5u}/{tid:<5u} [{cpu:03u}] "
> +                f"{ts // 1000000000:9u}.{ts % 1000000000:09u}  ")

Does Python 3 support the "u" format specifier for integers in f-strings?

It appears that "u" is a valid format code in C-style formatting, but Python
f-strings use "d" for integers. This might raise a ValueError on the first
sample.

[ ... ]
> +    def print_common_ip(self, sample: perf.sample_event, symbol: str, ds=
o: str) -> None:
> +        """Print IP and symbol info."""
> +        ip =3D sample.sample_ip
[ ... ]
> +        if self.insn and self.disassembler is not None:
> +            try:
> +                insn =3D sample.insn()
> +            except AttributeError:
> +                insn =3D None
> +            if insn:
> +                cnt, text =3D self.disassem(insn, ip)
> +                byte_str =3D (f"{ip:x}").rjust(16)
> +                for k in range(cnt):
> +                    byte_str +=3D f" {insn[k]:02x}"
> +                print(f"{byte_str:-40s}  {text:-30s}", end=3D' ')

Is the "-" character allowed as a string alignment specifier in Python
f-strings?

Applying it to a string format type might raise a ValueError. Would using "=
<"
for left-alignment work instead?

[ ... ]
> +    def do_process_event(self, sample: perf.sample_event) -> None:
> +        """Process event and print info."""
> +        comm =3D "Unknown"
[ ... ]
> +        cpu =3D sample.sample_cpu
> +        if cpu in self.switch_str:
> +            print(self.switch_str[cpu])
> +            del self.switch_str[cpu]

Are switch events being tracked correctly here?

It looks like self.switch_str is never populated anywhere in the code. Along
with the --all-switch-events argparse flag seemingly not being used, was the
context switch event logic dropped during the refactoring?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D39
