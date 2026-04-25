Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63B8126F3B
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140951; cv=none; b=Qy2Qa+UaK8v/fSey72yqUUgKqGLbU21lZy7WmVtNmyC6r/E+wnw8nAZXShVHI67vmvBnRCSt7cf5+7vnJJitl/jxjHNZxD5oycdsN7Rn21HUCSZD6wfGKGzp6mrfJ+43dASlBcgF9/OL6OQR3rTca/AZNXwTBecEgRN7VZ2yzQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140951; c=relaxed/simple;
	bh=wikASkDN4aCdwrmkB7FiarUY15ZSrtCYOlErSXYf280=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J9VGzPEKgROAGQ+niuF1GwEZaD7Ee+pU84bf1gmuAQ6nMCG8chApMFWp0HgpZa8eqdD7ZTaa2qID19CMrLR2rqlJkVvOUcfPIMBBMy8WFnyacGytAW216EBzSEhSWUwY/zNQ/+fWCtr1330mZrrb/ccM66ktfoa6p9zWGscsH2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+SdG5nK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+SdG5nK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BB1C2BCB0;
	Sat, 25 Apr 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140951;
	bh=wikASkDN4aCdwrmkB7FiarUY15ZSrtCYOlErSXYf280=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=R+SdG5nKwqlt3m9/nYrmvLPTD9xhAvgNz26XXclSMbTerk6/PQj40HJLkn1NG1+CT
	 J+66PvauP2FKaUmWed1m5cnkKo7H3/YjKsvH1X33m4UA4S8flk45eNh1OO/XiYfobt
	 j+VvgVHRkn2UHbmosue6Rep59nBRiSFCTQ1GAEu7zUUc6G8HhnXry5yQls7oysEtKa
	 50K1nXlwWM+o75p30kWyYUF1ELsA1Kwnn3VlGHg0LKYSId1wygwhZzg5WA02QTUpJg
	 VPpBre0UE4t1P22ret7yv9y3uMwDDm6wWiRjuqhQuZXagdCmBC7gbXG4xMPFmzXI8e
	 JREN0XOPdSdeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 32/59] perf arm-cs-trace-disasm: Port
 arm-cs-trace-disasm to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-33-irogers@google.com>
References: <20260425174858.3922152-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:15:51 +0000
Message-Id: <20260425181551.A3BB1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [High] Fatal logic error in event filtering causes all trace samples to b=
e silently skipped.
- [High] Unhandled `None` return value from `sample.srccode()` causes fatal=
 `TypeError` crashes.
- [Medium] Test suite breakage due to missing PYTHONPATH configuration for =
standalone scripts.
- [Medium] Crash in subprocess execution when `annotate.objdump` contains c=
ommand-line arguments.
--

commit bc99b6e370e48912bcde848e1ee7f57535f0e3ed
Author: Ian Rogers <irogers@google.com>

perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python module

This commit adds a python port of the arm-cs-trace-disasm script that direc=
tly
uses the perf python module. It aims to speed up execution by avoiding
intermediate dictionary creation and updates the test suite to use the port=
ed
script.

> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python=
/arm-cs-trace-disasm.py
> new file mode 100755
> index 000000000000..92c97cca6f66
> --- /dev/null
> +++ b/tools/perf/python/arm-cs-trace-disasm.py
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

What happens if objdump contains command-line arguments (for example, if a
user configured annotate.objdump to "llvm-objdump --x86-asm-syntax=3Dintel"=
)?

Because check_output() is called with a list, won't it treat the entire
string as the executable name and raise a FileNotFoundError instead of
parsing the arguments?

[ ... ]
> +def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso=
: str) -> None:
[ ... ]
> +    global GLB_SOURCE_FILE_NAME, GLB_LINE_NUMBER, GLB_DSO
> +
> +    source_file_name, line_number, source_line =3D sample.srccode()

Is it possible for sample.srccode() to return None?

Looking at pyrf_sample_event__srccode in the C extension, it returns
Py_RETURN_NONE if pyrf_sample_event__resolve_al fails to resolve the sample
address.

If trace data contains unresolvable samples, will this unpack operation fail
with a TypeError?

[ ... ]
> +class TraceDisasm:
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
[ ... ]
> +        ev_name =3D str(sample.evsel)
[ ... ]
> +        if ev_name.startswith("instructions"):
> +            print_srccode(comm, sample, symbol, dso)
> +            return
> +
> +        if not ev_name.startswith("branches"):
> +            return

Are these startswith() checks working as intended?

The pyrf_evsel__str function in tools/perf/util/python.c formats the string
representation as evsel(<name>) (e.g., "evsel(instructions:u)").

Does this mean ev_name.startswith("instructions") will always evaluate to
False, causing the script to skip all trace samples?

[ ... ]
> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index 0dfb4fadf531..c15cd60e1c24 100755
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

Does this direct python invocation break the test suite in out-of-tree buil=
ds?

Unlike perf script which internally resolves the module, calling the python
interpreter directly without configuring PYTHONPATH or injecting the module
directory into sys.path might cause python to fall back to system paths and
fail to import the local perf module.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D32
