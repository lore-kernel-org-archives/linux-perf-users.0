Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503E6EEC0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140606; cv=none; b=K1N347ur12T03Vp89Oc49qe2whcsECZeOwGCpetcRXVUIm9vJlp1TQhFhr0h7jWEYxDSP2cFJRIzXV0Fdu0jqjKgDVdyyeAngVqkfhWYemEnc1WLxXkI7ezSPN9wHMQlWAsqIFSDlq4mkV6dF2IMpNDd23poktlnQShA283Hb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140606; c=relaxed/simple;
	bh=bkYiMeVQ/BpSHvgePDADJs05pW2erpxDyekiT0YGohY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3A88+GhqRHswQypBZeZWqWtVL6EeMurp4L8rE7UYLc9yOVxPSpY0103f1LbKu0DA4jH+FjKP+syZjtIbRyq50qdy6lUfgp9ndGpCxBM2p7rF8qOoEZFXpwwqXvd4fzaScKoYCma8nFbWszrn8L/5npIdzqLqjTvYJW+6iNhjC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEjugTOA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEjugTOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B24C2BCB0;
	Sat, 25 Apr 2026 18:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140605;
	bh=bkYiMeVQ/BpSHvgePDADJs05pW2erpxDyekiT0YGohY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=pEjugTOAs3VAIicb/GLa+91GiwfYkK1rELYUAzFf/opvcn8/4B7SEuh7L7Y4ojLCl
	 jxns787R92HDGlndtcSJPgcjSWoObOHbb10508T4HYyMdXvkl0xZvEJ/WJp5PwJzGi
	 WyFsLWI+vQuTO3LAzVb2jExhstfOLmuQEutWjlaksEc4vaesC36CMFt++BYnSm6aSJ
	 jE3QVxbERMbECDk2rYlyORn/E5hdDFG7jm7yWbrbzH7dCFa4SLFb3cbIE2aEmOLFse
	 z8epfdmGjPTM/t6IDAaY0xPmBqLaThtZ41GguQ+wG2niamza362JlKiNKZVRipD4d8
	 2clV5Bc8VNMQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 39/59] perf intel-pt-events: Port
 intel-pt-events/libxed to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-40-irogers@google.com>
References: <20260425174858.3922152-40-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:10:05 +0000
Message-Id: <20260425181005.C9B24C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Critical] Immediate crash due to AttributeError when accessing thread ID.
- [High] Unhandled TypeError crashing the parser when symbol resolution fai=
ls.
- [High] Silently dropped IPC metrics and missing fields due to API mismatc=
h.
- [High] Missing bounds check leading to struct.error crashes on undersized=
 buffers.
- [Medium] Context switch trace is dead code and non-functional.
--

commit 81d0ab603e985e90ebd28a2436d0f5d74d75f30f
Author: Ian Rogers <irogers@google.com>

perf intel-pt-events: Port intel-pt-events/libxed to use python module

This commit ports the intel-pt-events.py script to use the newer perf Python
module, refactoring it into a class-based structure. It eliminates global
state, drops Python 2 compatibility checks, and updates libxed.py methods to
snake_case.

diff --git a/tools/perf/python/intel-pt-events.py b/tools/perf/python/intel=
-pt-events.py
new file mode 100755
index 000000000000..19a0faec8f5f
--- /dev/null
+++ b/tools/perf/python/intel-pt-events.py
[ ... ]
> +    def print_ptwrite(self, raw_buf: bytes) -> None:
> +        """Print PTWRITE data."""
> +        data =3D struct.unpack_from("<IQ", raw_buf)

Will this code raise an unhandled struct.error exception and abort the
processing loop if a malformed perf.data trace provides a raw_buf smaller t=
han
12 bytes, or an empty byte string? This pattern also appears in print_mwait,
print_pwrx, and other similar functions.

[ ... ]
> +    def common_start_str(self, comm: str, sample: perf.sample_event) -> =
str:
> +        """Return common start string for display."""
> +        ts =3D sample.sample_time
> +        cpu =3D sample.sample_cpu
> +        pid =3D sample.sample_pid
> +        tid =3D sample.tid

Does the perf.sample_event C extension expose this property as sample_tid
rather than tid? If so, will accessing sample.tid raise an AttributeError on
the first event and crash the script?

[ ... ]
> +    def print_common_ip(self, sample: perf.sample_event, symbol: str, ds=
o: str) -> None:
> +        """Print IP and symbol info."""
> +        ip =3D sample.sample_ip
> +        offs =3D f"+{sample.symoff:#x}" if hasattr(sample, "symoff") els=
e ""
> +        cyc_cnt =3D getattr(sample, "cyc_cnt", 0)
> +        if cyc_cnt:
> +            insn_cnt =3D getattr(sample, "insn_cnt", 0)
> +            ipc_str =3D f"  IPC: {insn_cnt / cyc_cnt:#.2f} ({insn_cnt}/{=
cyc_cnt})"

Have these legacy metric fields been renamed in the new perf Python module =
API?
If the module exports them as sample_cyc_count and sample_insn_count instead
of cyc_cnt and insn_cnt, getattr will always return 0 and silently bypass t=
he
IPC string generation. Other legacy fields like symoff and flags_disp might
also be missing from the new API.

[ ... ]
> +    def print_srccode(self, comm: str, sample: perf.sample_event,
> +                      symbol: str, dso: str, with_insn: bool) -> None:
> +        """Print source code info."""
> +        ip =3D sample.sample_ip
> +        if symbol =3D=3D "[unknown]":
> +            start_str =3D self.common_start_str(comm, sample) + (f"{ip:x=
}").rjust(16).ljust(40)
> +        else:
> +            offs =3D f"+{sample.symoff:#x}" if hasattr(sample, "symoff")=
 else ""
> +            start_str =3D self.common_start_str(comm, sample) + (symbol =
+ offs).ljust(40)

If symbol resolution fails in the C extension and
pyrf_sample_event__get_symbol returns None instead of "[unknown]", will
the comparison symbol =3D=3D "[unknown]" evaluate to False? This would caus=
e the
else branch to execute, attempting to concatenate None with a string (offs),
which would raise a TypeError.

[ ... ]
> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser()
> +    ap.add_argument("-i", "--input", default=3D"perf.data", help=3D"Inpu=
t file name")
> +    ap.add_argument("--insn-trace", action=3D'store_true')
> +    ap.add_argument("--src-trace", action=3D'store_true')
> +    ap.add_argument("--all-switch-events", action=3D'store_true')
> +    ap.add_argument("--interleave", type=3Dint, nargs=3D'?', const=3D4, =
default=3D0)
> +    args =3D ap.parse_args()
> +
> +    analyzer =3D IntelPTAnalyzer(args)
> +
> +    try:
> +        session =3D perf.session(perf.data(args.input), sample=3Danalyze=
r.process_event)
> +        analyzer.session =3D session
> +        session.process_events()

Are context switch events functional with this configuration? The script ac=
cepts
the --all-switch-events argument and checks the self.switch_str dictionary =
when
processing samples, but the perf.session setup only registers the sample
callback. Is there a missing callback registration needed to populate the
dictionary with context switch events?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D39
