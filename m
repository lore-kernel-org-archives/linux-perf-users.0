Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE31A6807
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645202; cv=none; b=orIrieJRL0iABc1RYYjQni29l1f45r8J4edvpc/2Mpk1BWG6Rm0JvQJzfzG0KtzdS0MYymN/OyzGEyImER3a4jvxotpJTV8NR4QyQNTDP+uTAvKTfsdgaOCWxlyHPNCinMaE7ZrwP3Jx4O9semosfGXWvTzeRH96FeAGNy5+ZpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645202; c=relaxed/simple;
	bh=CDFkACnvZz+tuPfkzXw7NdDoed3+PFRT2St9aQMS/O0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MYdaC5vyMWSmnjnCQYo879J3L3pLfIOVfwqvEDeclUPU+2DOakh/Uo8rer/HKJiti3Gri1un/8pt+q2Gf0iCg7MevdJ2X2ey42ICBNUL2Fv4AbmGlVPZcBtb3GF9R5/9+v43rsTEY1C5/2k9ZJfIBBqiQWEKlmJlhB0gK+gSS6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaEk+GoN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaEk+GoN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA5DC2BCAF;
	Mon, 20 Apr 2026 00:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645202;
	bh=CDFkACnvZz+tuPfkzXw7NdDoed3+PFRT2St9aQMS/O0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RaEk+GoNcT7/WQHFA5LFhMG2HnVquy7Q0c2dU2q1KzdjssvsEsHB/lBttimsKj8qP
	 DoQXyUp6BWNTAC+CKcjy0Eaap0WiA15D3SFaMbnvRBabVCF0fdmBPvt512aO/+yH/r
	 IUi+qn1axWQm4FWpNnlSGYL2SUFO/GRRBC+6nk5lVXVXETIcB29zFUFfhybXlA6UOy
	 mFL5ZoSw4BWnvn8wgQSl7ktLZVE1bGghYkdqXhd/67QEwE/X6x3ZFPAZ3yOPL/G+aH
	 J1i7IpnevqVoUGeqi41pT12mzJhB+eBkz1+UZV8UAfEX2xv10KRIDQhrgv1cP1CDX2
	 DJTTpJRo7+dIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 22/58] perf python: Add perf.pyi stubs file
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-23-irogers@google.com>
References: <20260419235911.2186050-23-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:33:21 +0000
Message-Id: <20260420003321.DFA5DC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Medium] The `perf.pyi` type stub provides incorrect attribute names that=
 will cause runtime crashes.
- [Medium] The `perf.pyi` stub file is not installed by the build system.
- [Medium] The `perf.pyi` type stubs omit several functions and classes exp=
orted by the C extension.
--

commit a3e3e83a491ec2415a1bdbbfc8f84367197595fd
Author: Ian Rogers <irogers@google.com>

perf python: Add perf.pyi stubs file

This commit adds Python type stubs (perf.pyi) for the perf module to
improve editor support and static analysis. It includes docstrings for
classes, methods, and constants derived from the python extension.

> diff --git a/tools/perf/python/perf.pyi b/tools/perf/python/perf.pyi
> new file mode 100644
> index 0000000000000..0aa897f453153
> --- /dev/null
> +++ b/tools/perf/python/perf.pyi

Looking at tools/perf/util/setup.py and tools/perf/Makefile.perf,
it appears only .py files are copied during installation.

Is this a regression where the build system leaves the .pyi file
behind in the source tree, making it inaccessible to the user's
Python environment?

[ ... ]

> +def parse_events(
> +    event_string: str,
> +    cpus: Optional[cpu_map] =3D None,
> +    threads: Optional[Any] =3D None
> +) -> 'evlist':

Functions like parse_metrics, pmus, and tracepoint appear to be absent
from these stubs.

Could this regression cause static analyzers to flag valid uses of the
interface because module-level functions exported by the python
extension are missing?

[ ... ]

> +class evsel:
> +    """Event selector, represents a single event being monitored."""
> +    def __str__(self) -> str:

Instantiable classes like evsel and evlist appear to be missing their
constructors in the stubs.

Is it a regression that this class does not include its __init__ method?

[ ... ]

> +class sample_event:
> +    """Represents a sample event from perf."""
> +    evsel: evsel
> +    sample_cpu: int
> +    sample_time: int
> +    sample_pid: int
> +    sample_comm: str

Looking at pyrf_sample_event__members in tools/perf/util/python.c,
sample_comm does not appear to be exported.

Could this regression pass static analysis but fail with an
AttributeError at runtime if developers use event.sample_comm?

[ ... ]

> +class branch_entry:
> +    """Represents a branch entry in the branch stack.
> +
> +    Attributes:
> +        from_: Source address of the branch (corresponds to 'from' keywo=
rd).
> +        to: Destination address of the branch.

[ ... ]

> +    from_: int
> +    to: int

The python extension explicitly exports this branch entry attribute as
"from" via pyrf_branch_entry__getset.

Since "from" is a Python keyword, it is typically accessed via
getattr(entry, 'from').

Would defining it as from_ be a regression that leads to an
AttributeError at runtime?

[ ... ]

> +class evlist:
> +    def open(self) -> None:
> +        """Open the events in the list."""
> +        ...

The stubs omit several event classes entirely, such as mmap_event,
lost_event, comm_event, task_event, throttle_event, read_event, and
switch_event.

Is it a regression that methods like get_pollfd and add are also missing
from evlist?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D22
