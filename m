Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D55830BF6F
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158794; cv=none; b=PmH0JbfvVcLiFkOt2/XQ1l854izQpfJJDMN0BBFtnid0DpGsljITQvik2KJ+j4Sz9aTUv+1ya00YegSqCgeXYYYGpCqPok+FUE/l4PDYiu3cWPbRNtDoGVXABBn0XAnEWmtY+8wZjznb+vA3olQahsmGL/tBuljFsL0SPiW18wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158794; c=relaxed/simple;
	bh=uSHTvunt7+yupitw9E7Nerb08d0QtJDApFcDl0OxBD8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AD6EKcdi58gPXiQdFrK+UcYqoReLKz6Tlxbp6gunculkBtqpybR8TB7AkHR3jMflKggTj8PoJoWNnq+ed243O7izoy+A9BrRtWeKdTI/Trh7/2WXsBSiOfoJTMCSbSjr1s5DkllxQ1xBVDip2yMahl/r3O8yvFvaN50JYoYCaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac4FVvFh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac4FVvFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4E5C2BCB0;
	Sat, 25 Apr 2026 23:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158793;
	bh=uSHTvunt7+yupitw9E7Nerb08d0QtJDApFcDl0OxBD8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ac4FVvFhqmuZC8gpu9YyKMaIpxllGPiq37i+6V2nOTl4kKezTM0a+AKRtJMw+3vrf
	 tnJBEpKDzNT2Msazim9114kovk1yjSfHoQuAnqQevCKaM67vRzED7yUrqZ4s1SpQAQ
	 YwYyPeFLYF90G/apw/bVyJdtIZnNevtoFm2tAcOnmlPCF+ZyECWLMeqcrCeq2BohGs
	 yKYoipPcaRQpa9luVJmOnZX9KBA4PBLh2Vyys5Yx1r1Msurj+uaGPbkcMIYP0jKzWb
	 BOCyXqZgP6B+71j+Q6Fau2i+ij4+8h+FyLaO9wYkPYn59ffJqZuRj58z9rVmy3PnP7
	 sZffidBQ82jNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 39/59] perf intel-pt-events: Port
 intel-pt-events/libxed to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-40-irogers@google.com>
References: <20260425224951.174663-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:13:13 +0000
Message-Id: <20260425231313.AF4E5C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Renaming methods in `libxed.py` breaks `exported-sql-viewer.py`.
- [High] Invalid format specifiers in f-strings cause immediate runtime cra=
shes.
- [High] Unhandled `struct.error` exceptions due to missing `raw_buf` bound=
s checks.
- [High] Context switch feature regression and dead code.
--

commit 287f3427909d144b37c8690735624ae6bca74489
Author: Ian Rogers <irogers@google.com>

perf intel-pt-events: Port intel-pt-events/libxed to use python module

This commit refactors intel-pt-events.py to use a class structure and
removes Python 2 compatibility checks. It also renames methods in libxed.py
to snake_case to comply with pylint.

> - Renamed methods in libxed.py to snake_case (Instruction ->
>   instruction, SetMode -> set_mode, DisassembleOne -> disassemble_one)
>   to comply with pylint.

Does this renaming break tools/perf/python/exported-sql-viewer.py?

It appears that script also imports LibXED and might still be calling
the old CamelCase methods (Instruction, SetMode, DisassembleOne), which
could result in an AttributeError when disassembly is enabled.

[ ... ]

> diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/int=
el-pt-events.py
> new file mode 100755
> index 000000000000..19a0faec8f5f
> --- /dev/null
> +++ b/tools/perf/python/intel-pt-events.py
> @@ -0,0 +1,435 @@

[ ... ]

> +    def print_ptwrite(self, raw_buf: bytes) -> None:
> +        """Print PTWRITE data."""
> +        data =3D struct.unpack_from("<IQ", raw_buf)

If raw_buf is empty or undersized, will struct.unpack_from raise a
struct.error here?

Since the callbacks are called in do_process_event() where a missing raw_buf
is explicitly handled by setting raw_buf =3D b"", the exceptions wouldn't be
caught and might propagate up, aborting the trace analysis.

[ ... ]

> +    def print_cbr(self, raw_buf: bytes) -> None:
> +        """Print CBR data."""
> +        if len(raw_buf) < 12:
> +            return
> +        data =3D struct.unpack_from("<BBBBII", raw_buf)
> +        cbr =3D data[0]
> +        f =3D (data[4] + 500) // 1000
> +        if data[2] =3D=3D 0:
> +            return
> +        p =3D ((cbr * 1000 // data[2]) + 5) // 10
> +        print(f"{cbr:3u}  freq: {f:4u} MHz  ({p:3u}%)", end=3D' ')

Are these format codes valid in Python 3 f-strings?

It looks like the 'u' format code is not supported for integers. Evaluating
these might raise a ValueError and cause a runtime crash.

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

This also appears to use the unsupported 'u' format code for integers
in {pid:5u}, {tid:<5u}, and {cpu:03u}.

[ ... ]

> +    def print_common_ip(self, sample: perf.sample_event, symbol: str, ds=
o: str) -> None:

[ ... ]

> +            if insn:
> +                cnt, text =3D self.disassem(insn, ip)
> +                byte_str =3D (f"{ip:x}").rjust(16)
> +                for k in range(cnt):
> +                    byte_str +=3D f" {insn[k]:02x}"
> +                print(f"{byte_str:-40s}  {text:-30s}", end=3D' ')

Is the '-' character allowed for string alignment in f-strings?

It looks like the standard f-string format specification doesn't support
the '-' sign for string alignment, which might raise a ValueError when
evaluated.

[ ... ]

> +    def do_process_event(self, sample: perf.sample_event) -> None:
> +        """Process event and print info."""
> +        comm =3D "Unknown"

[ ... ]

> +        cpu =3D sample.sample_cpu
> +        if cpu in self.switch_str:
> +            print(self.switch_str[cpu])
> +            del self.switch_str[cpu]

Could this be a regression of the context switch feature?

It looks like self.switch_str is initialized and consumed here, but never
populated. Additionally, the underlying perf.session API doesn't seem to
expose a context_switch event callback to Python, leaving this as
unreachable code.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D39
