Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944A833F5B2
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Apr 2026 17:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052624; cv=none; b=bruXokpzVfTIU3ulZD/6pWjsstPk9dQer0ZkvR1JkLUeUl6oX70xsnnD0FXbaDytDqVzVpFOKrOt15N9jfEU6fVwKz2htF7dx39EkA/U0DRddX8ZcKdXavCjRXSGDzRUAeNN6W81e5WKUBj99PUwtHZBvfphVqd/6Zo60p3KCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052624; c=relaxed/simple;
	bh=kb6t/1ITgBmCCxPnk6Rbn1rdIIKM2XZz4Yused/CUZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o7q7v12QmkKHW+bYvwwpzPIARhQPmiW1OL8gu2fsS31TVlDtYIw3wjbu/zJ/TvOjiFI2TsO+JG9pq+KG6KIdciEPWlQKSPaWJofScUWukgwQm69liZolkKPbR/Pni4XvYN7yu/ddUoueL2uASs/GZ3vr7xihxm4zvDVlL+kUAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7TvgkvA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7TvgkvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE565C19425;
	Fri, 24 Apr 2026 17:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052624;
	bh=kb6t/1ITgBmCCxPnk6Rbn1rdIIKM2XZz4Yused/CUZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=K7TvgkvAWFy26x0tApxOt7xOMrqoLlUz+g0kvnT/rrT+76Qb34G5kNAVgJPWeBMp6
	 M9OSyxaswSFRmy9Eeddxa7RKjb3PpR8DD5vRLgqcspGMFoRP6j3ninLS2DBgLnKunH
	 yhkKhvyYA+XIr2MfuJDhQ1lPfYIN3sVP2Yclq4JHDvtNujloztPDYjlmILtmVGFkzL
	 AiigFzJs5fDBPw1HVSH+lwyQ5c+HDqGMnGAqMY+UrrPO7okKokhrp7WBZjUPGSfbmZ
	 uMx/wpliPQVTFTN9xC/SmMYdLlgDWlnggb0HdaM6KGHA/3SWHedE9b+//TZrOnFJy9
	 AxI9mDiJ2DBBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 48/58] perf rw-by-file: Port rw-by-file to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260424164721.2229025-49-irogers@google.com>
References: <20260424164721.2229025-49-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 17:43:43 +0000
Message-Id: <20260424174343.CE565C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Accessing `sample.evsel.name` will crash the script with an `Att=
ributeError` because the `perf.evsel` Python bindings do not expose a `.nam=
e` attribute.
- [Medium] The exact string matching logic uses hallucinated `raw_syscalls`=
 tracepoint names and fails to account for the `evsel(...)` string wrapper,=
 rendering the script's core logic dead code.
--

commit af92ee162d990773930e7729d2feccb34f3958b1
Author: Ian Rogers <irogers@google.com>

perf rw-by-file: Port rw-by-file to use python module

This commit ports the legacy Perl script rw-by-file.pl to a python script
using the perf module in tools/perf/python. It tracks read and write
activity by file descriptor for a given program name.

> diff --git a/tools/perf/python/rw-by-file.py b/tools/perf/python/rw-by-fi=
le.py
> new file mode 100755
> index 00000000000000..f71e0b21f64ecd
> --- /dev/null
> +++ b/tools/perf/python/rw-by-file.py
[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D sample.evsel.name  # type: ignore

Does sample.evsel have a name attribute in the Python bindings?

The C-Python extension for the perf module in tools/perf/util/python.c does
not appear to define a name property for evsel objects. Because the evsel
object uses PyObject_GenericGetAttr, this looks like it will raise an
AttributeError and crash the process_events loop.

Can sample.evsel also be None here?

> +
> +        pid =3D sample.sample_pid
> +        assert self.session is not None
> +        try:
> +            comm =3D self.session.process(pid).comm()
> +        except Exception: # pylint: disable=3Dbroad-except
> +            comm =3D "unknown"
> +
> +        if comm !=3D self.for_comm:
> +            return
> +
> +        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_e=
nter_read"):

If event_name is eventually retrieved using str(sample.evsel) instead, the
pyrf_evsel__str C implementation returns a string wrapped in evsel(...)
such as evsel(syscalls:sys_enter_read). Will this exact string match fail
because it does not account for the wrapper?

Additionally, do the raw_syscalls:sys_enter_read and
raw_syscalls:sys_enter_write tracepoints exist? The raw_syscalls subsystem
typically only provides generic sys_enter and sys_exit events.

Could this cause valid events to fail the match and fall through to the
unhandled bucket, rendering the read and write tracking logic unreachable?

> +            try:
> +                fd =3D sample.fd
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260424164721.2229=
025-1-irogers@google.com?part=3D48
