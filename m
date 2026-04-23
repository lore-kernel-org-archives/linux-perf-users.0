Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D733B97F
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917685; cv=none; b=BUNDsCYPvKpf8csnEMNhld1P/uaQ52sSv1z1xAKYMY53cm40tEtxFKxQXQCbpG1KGqbLfcQ/WpZyMK3fwXzoVXZkgVpHX66bdGhyi4CG3olol7tzhdjwbHTxMeexSli0T8Yt8dQZSoNMVSDIXl5RqR1f3hUvf83iUUdgjwApK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917685; c=relaxed/simple;
	bh=SgZRqtlh+XXYo1pgyduur4nDIB42Efb+8F/6hP4AxeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qsRIaGegdoJK/HT8Hwn6IbOkLapXjAJcdV9RiZE2zajl00wG16O1lRvN7jJq75lvTT/vCmTPNmp7o43gUI6dSeADq8mqnXIk0g/MYq0COY054eyuyfCe0vE2MUrtP+81QWlAaF3pqQ7IEWOQOUgM1VNIG3kQgnp0n0uh4A66Mp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe5QWsr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe5QWsr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784DFC2BCB2;
	Thu, 23 Apr 2026 04:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917685;
	bh=SgZRqtlh+XXYo1pgyduur4nDIB42Efb+8F/6hP4AxeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oe5QWsr9MmH6ey7/RnHS5axykKwh9KwlmjBYI7ZkbAV22RuSDqVWngPbkvPwtMpKY
	 SysWYOEWBUcx7h7NigaNRZKYqEaXo2CzUZzTKM0GsMaw9qHAjYUF9OrRZPIuBVFlCE
	 W61Edz8hbT1dsJrZPN/UQmRwpj9HMQ90/tGbOoMJP345GSDT4OMmYSQzMVVSeshIwQ
	 4TTomKuz9x4D0C+XLAMBrZIIGPGNQsxU8GNSI3hQHTOA8nDMg+GCyPdv8c/cAldt53
	 K2q6be0NGXM9vx95tbs7kiji+ZS8RfWjzpuH00L/dfeoadNDzLg8Prj6MkrUo3jttq
	 dIivxEDZf7OjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 49/58] perf rw-by-pid: Port rw-by-pid to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-50-irogers@google.com>
References: <20260423035526.1537178-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:14:44 +0000
Message-Id: <20260423041445.784DFC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] The commit message describes a refactoring that is not present i=
n the code.
- [Medium] The script incorrectly tracks the requested write size instead o=
f the actual bytes written.
- [Medium] End-of-file (return value 0) is incorrectly classified as an err=
or for read operations.
- [Low] The script attempts to match non-existent event names for the `raw_=
syscalls` subsystem.
- [Low] Missing process name (`comm`) assignment for processes traced mid-s=
yscall.
--

commit 269ff8f6be4755e6b4df9288f0383a28e84f0fb9
Author: Ian Rogers <irogers@google.com>

perf rw-by-pid: Port rw-by-pid to use python module

This patch ports the legacy rw-by-pid Perl script to a Python script. It
uses a class-based architecture to track read and write activity by PID for
all processes.

> perf rw-by-pid: Port rw-by-pid to use python module
>=20
> Port the legacy Perl script rw-by-pid.pl to a python script using the
> perf module in tools/perf/python.
>=20
> The new script uses a class-based architecture and leverages the
> perf.session API for event processing.
>=20
> It tracks read and write activity by PID for all processes,
> aggregating bytes requested, bytes read, total reads, and errors.
>=20
> Complications:
> - Refactored process_event to extract helper methods
>   (_handle_sys_enter_read, etc.) to reduce the number of branches and
>   satisfy pylint.

Is this description accurate? Looking at the diff below, the process_event
function is a single large method that uses pylint: disable=3Dtoo-many-bran=
ches
and no helper methods were extracted.

[ ... ]

> diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid=
.py
> new file mode 100755
> index 0000000000000..53e16b373111a
> --- /dev/null
> +++ b/tools/perf/python/rw-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:  # pylin=
t: disable=3Dtoo-many-branches
> +        """Process events."""
> +        event_name =3D sample.evsel.name  # type: ignore
> +        pid =3D sample.sample_pid
> +
> +        assert self.session is not None
> +        try:
> +            comm =3D self.session.process(pid).comm()
> +        except Exception:  # pylint: disable=3Dbroad-except
> +            comm =3D "unknown"
> +
> +        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_e=
nter_read"):

Do event names like raw_syscalls:sys_enter_read exist? The raw_syscalls
subsystem typically provides generic tracepoints like raw_syscalls:sys_enter
rather than per-syscall tracepoints.

> +            try:
> +                count =3D sample.count
> +                self.reads[pid]["bytes_requested"] +=3D count
> +                self.reads[pid]["total_reads"] +=3D 1
> +                self.reads[pid]["comm"] =3D comm
> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_exit_read", "raw_syscalls:sys_=
exit_read"):
> +            try:
> +                ret =3D sample.ret
> +                if ret > 0:
> +                    self.reads[pid]["bytes_read"] +=3D ret
> +                else:
> +                    self.reads[pid]["errors"][ret] +=3D 1

Does this classify a return value of 0 as an error? A return value of 0 from
read operations indicates end-of-file.

Also, if tracing starts while a process is already inside a read syscall, is
the comm field left empty since it is only populated during the sys_enter_r=
ead
event?

> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sy=
s_enter_write"):
> +            try:
> +                count =3D sample.count
> +                self.writes[pid]["bytes_written"] +=3D count

Does this record the requested write size instead of the actual bytes writt=
en?

> +                self.writes[pid]["total_writes"] +=3D 1
> +                self.writes[pid]["comm"] =3D comm
> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_exit_write", "raw_syscalls:sys=
_exit_write"):
> +            try:
> +                ret =3D sample.ret
> +                if ret <=3D 0:
> +                    self.writes[pid]["errors"][ret] +=3D 1

Since successful writes where ret > 0 are ignored here, does this miss
recording the actual bytes written during the sys_exit_write event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D49
