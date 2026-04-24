Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFA18CBE1
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052184; cv=none; b=l5sgYLBu4Uakoe7Pwew3yKjjSoODk3XxQAW65rl9hEHMiT0DnlXNadEWi0Vjb8kFAFWgkn5qwCdEMrh5a8Wd7TfCFyQk4HrefvbUnuTxDtuUjikLrLcJS3VyPzHH2OVFdPV2sqvFIwyJx158BQIY05NO7aQz4HBUKRcyxWdSlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052184; c=relaxed/simple;
	bh=yqAy8QTrUeWV2GB5/+Lwg/Kj5skKKDfX5nltKFAk3Jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GlLyrs7Be1wIZZIR8Tzbq4e7THc2mVLCxiyRypWfOBPR4ogcjWZNU04YPmoIGELBjBKKIOYgXaIwmXYxVvsmt+00O97ZxZB/y+CfJf25Vop2JuIeHkRQGuAb11y0vAMNZp9j+iOyC6/UWA/tPKADtPBHY5TTcd1asupcY4l+yWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGLVdQgP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGLVdQgP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2891C19425;
	Fri, 24 Apr 2026 17:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052183;
	bh=yqAy8QTrUeWV2GB5/+Lwg/Kj5skKKDfX5nltKFAk3Jg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=uGLVdQgPR6ndl/ChVqC5RhV99KtPwKY8ozzmvQfCHj6bJk2rQhUzaNwSPtPHEeEMu
	 F7XIyHMWQNbGC4RZKg1qKDET2cIpQg9seJu/dt01kvaucQhtBqk05Hvk1hR+mbIovw
	 OI8EwuPTrtQGxGWwH7sXo4Jzr9y6HAxBe5875z8OB7P12vn1axoRnbIylVFjSTYXwG
	 mR3wosmSYROjexW8GP6yiVShm36x0vL1SPbFYkme+z9y+Eyvr8dl4v6hmiS23HC8Ri
	 KhPCtD3LGDSFSTZe+2sQD8U1EvjR88KxrCC262UXbl+iTv8eT98Ff5M1thkS+sFSvr
	 dW3c+VfUd6sGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 32/58] perf arm-cs-trace-disasm: Port
 arm-cs-trace-disasm to use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-33-irogers@google.com>
References: <20260424164721.2229025-33-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:36:23 +0000
Message-Id: <20260424173623.B2891C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [High] Event names are incorrectly matched because `str(sample.evsel)` in=
cludes the `evsel(...)` wrapper.
- [Medium] Incorrect mathematical calculation of the symbol offset `symoff`=
 due to mixing absolute and map-relative addresses.
- [Medium] The updated shell test silently fails on out-of-tree builds beca=
use it lacks the necessary environment setup to locate the `perf` Python mo=
dule.
--

commit 33d6193e9a3497d76e5e326cbe424187e713bad0
Author: Ian Rogers <irogers@google.com>

perf arm-cs-trace-disasm: Port arm-cs-trace-disasm to use python module

Add a port of the arm-cs-trace-disasm script that uses the perf python
module directly. This approach is significantly faster than using perf
script callbacks as it avoids creating intermediate dictionaries for
all event fields. Update the testing to use the ported script.

> diff --git a/tools/perf/python/arm-cs-trace-disasm.py b/tools/perf/python=
/arm-cs-trace-disasm.py
> new file mode 100755
> index 00000000000000..d1227e809adf68
> --- /dev/null
> +++ b/tools/perf/python/arm-cs-trace-disasm.py
[ ... ]
> +def print_srccode(comm: str, sample: perf.sample_event, symbol: str, dso=
: str) -> None:
> +    """Print source code and symbols for a sample."""
> +    ip =3D sample.sample_ip
> +    if symbol =3D=3D "[unknown]":
> +        start_str =3D common_start_str(comm, sample) + f"{ip:x}".rjust(1=
6).ljust(40)
> +    else:
> +        symoff =3D 0
> +        sym_start =3D sample.sym_start
> +        if sym_start is not None:
> +            symoff =3D ip - sym_start

Does this calculate the correct offset for dynamically loaded libraries?
If sample.sample_ip is an absolute instruction pointer, and sample.sym_star=
t=20
is map-relative, won't subtracting them yield an incorrect offset?=20

The original C-side code avoided this by using the pre-computed offset
via al->addr - sym->start.

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process a single perf event."""
> +        self.sample_idx +=3D 1
> +        global SAMPLE_IDX
> +        SAMPLE_IDX =3D self.sample_idx
[ ... ]
> +        ev_name =3D str(sample.evsel)
[ ... ]
> +        if ev_name.startswith("instructions"):
> +            print_srccode(comm, sample, symbol, dso)
> +            return
> +
> +        if not ev_name.startswith("branches"):
> +            return

Will this correctly match the event names?
The __str__ representation of pyrf_evsel in tools/perf/util/python.c return=
s=20
the event name wrapped as "evsel(%s)".=20

Does this cause ev_name to be evaluated as strings like=20
"evsel(instructions:u)", which would fail both startswith() checks and=20
result in the script silently dropping all events?

> diff --git a/tools/perf/tests/shell/test_arm_coresight_disasm.sh b/tools/=
perf/tests/shell/test_arm_coresight_disasm.sh
> index 0dfb4fadf53177..c15cd60e1c2464 100755
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

Could this fail silently on out-of-tree builds?
If the perf python module is not installed globally, the script will fail to
import perf with a ModuleNotFoundError.=20

Because the PYTHONPATH is not exported and sys.path is not modified to poin=
t=20
to the built python extension directory, and errors are swallowed by=20
2> /dev/null, the output file ends up empty.

Would it be better to ensure PYTHONPATH includes the built extension direct=
ory
similar to how it is handled in python-use.sh?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D32
