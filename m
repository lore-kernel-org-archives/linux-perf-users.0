Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D222126C
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158305; cv=none; b=JhQ3diEdbWaND2gmjQXdMWToSzFVFZlojmU1imuDi57FD1Bzjg8hMFDEjwDluLd24b5LnD8lPHYv7iGtq8NMmn0nNqBjc4EVidT6r9th14taFbTXBhnJ29PyLaLk4Jl+E7vk749cilfX3CfCGwX8aXMPi7b6FWk2GzTWe4Ui9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158305; c=relaxed/simple;
	bh=12YN18wil29IpqzFbNYBsorPQkKKazq95+oMMF+wLnY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bDY1oD/oS62VSy8YnH4IgKdyLR7d3oXaIRhMOXyIwkstmugUqr+bMmc6/dGSh0aXk0Jkpmstnaw5tgmVDNxV9sWTnBzcCbIjeQuPxHemos5Ya11gS3UG88RfI3b/6+JzDq4BY71IgMEpIdJNXSSiJnux4Sdz8PXzYKZQ/8pWDGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv/QLlf+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv/QLlf+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AAEC2BCB0;
	Sat, 25 Apr 2026 23:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158304;
	bh=12YN18wil29IpqzFbNYBsorPQkKKazq95+oMMF+wLnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Nv/QLlf+iLig+f84zPjLtZjykVjZBmf1TuJrVZJnjT9iguFs1C85+CV4gssalKcqN
	 O3/sK91nA4eJHnlyrbsEGjLTTnDMR8IOlVRmV57OpS83GrazhV6xrTOyJ+iviwE/7Z
	 KwFvdCn2MEJ0qjn1L49DR+NWCRhzN2dvvNEAj3a7iic7RihYVT9sGAfVfPsVBfsfxF
	 TtSOAZJN82zjBSs6QnprHPVgPiYffz8/frkgq1//6hhIkCzXq2VmLqsnrFVFRYvdAd
	 TDCLmhxtb0JZe3rLm6SPnbsDNCB3koB0B9i4T5SV99jovg9pBqPaot0rscYd1gNTaq
	 HX3TUIXz1xDlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 49/59] perf rw-by-pid: Port rw-by-pid to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-50-irogers@google.com>
References: <20260425224951.174663-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:05:03 +0000
Message-Id: <20260425230504.87AAEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [Medium] The commit message contradicts the submitted code regarding the =
refactoring of `process_event`.
- [Medium] The script incorrectly uses the requested byte count instead of =
the actual written byte count for write statistics.
- [Medium] Normal End-of-File (EOF) events are incorrectly classified as re=
ad errors.
- [Low] The script checks for non-existent kernel tracepoints like `raw_sys=
calls:sys_enter_read`.
- [Low] The script uses brittle string slicing to extract the event name fr=
om `evsel`.
--

commit 6e1fab645f59d71312fde69984db5baac1100297
Author: Ian Rogers <irogers@google.com>

perf rw-by-pid: Port rw-by-pid to use python module

This commit ports the legacy Perl rw-by-pid script to a Python script using
the perf module. It leverages the perf.session API to track read and write
activity by PID.

> Complications:
> - Refactored process_event to extract helper methods
>   (_handle_sys_enter_read, etc.) to reduce the number of branches and
>   satisfy pylint.

This isn't a bug, but the commit message states that helper methods were
extracted to satisfy pylint, whereas the submitted code provides a single
process_event method and uses a pylint disable comment instead. Could the
commit message be updated to reflect the final code?

> diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid=
.py
> new file mode 100755
> index 000000000000..b206d2a575cd
> --- /dev/null
> +++ b/tools/perf/python/rw-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:  # pylin=
t: disable=3Dtoo-many-branches
> +        """Process events."""
> +        event_name =3D str(sample.evsel)[6:-1]

Is this string slicing robust? If the internal string formatting convention
for evsel changes in the future, could this fail and silently drop events
into the unhandled category?

> +        pid =3D sample.sample_pid
> +
> +        assert self.session is not None
> +        try:
> +            comm =3D self.session.find_thread(pid).comm()
> +        except Exception:  # pylint: disable=3Dbroad-except
> +            comm =3D "unknown"
> +
> +        if event_name in ("syscalls:sys_enter_read", "raw_syscalls:sys_e=
nter_read"):

Are there tracepoints named raw_syscalls:sys_enter_read? The kernel provides
generic raw tracepoints like raw_syscalls:sys_enter and specific ones like
syscalls:sys_enter_read. Does checking for the raw_syscalls variation here
represent dead code?

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

Does this incorrectly classify an End-of-File as an error? For the read
system call, returning 0 indicates EOF, which is an expected condition.
Treating 0 as an error might artificially inflate the failed reads summary.

> +            except AttributeError:
> +                self.unhandled[event_name] +=3D 1
> +        elif event_name in ("syscalls:sys_enter_write", "raw_syscalls:sy=
s_enter_write"):
> +            try:
> +                count =3D sample.count
> +                self.writes[pid]["bytes_written"] +=3D count

Does this over-report the actual bytes written? Using the requested size
from sample.count might be inaccurate if there are partial or failed
writes. Should the actual bytes successfully written be accumulated from
sample.ret in sys_exit_write instead, similar to how reads are handled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D49
