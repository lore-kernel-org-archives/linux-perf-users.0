Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B9F364949
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140291; cv=none; b=X7FX2HC/5unon0XZrpOceFDeQdb5CIDfFjInpl/0VRUYtjHASqc10uKnGnH7ImahqqdqyQfPVjcpFOU12rSMtGE0W9WnW8rJ0SOVtNXzaIIiubuKeY37G/zwYl7oeW6Nu3ZbrlN2vt65DBQIWpqfpxjofk0/jZ4fYPUFoY4mF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140291; c=relaxed/simple;
	bh=4U28WVw1ZZqZdb1s8ZDPrFs3AhvfNYej0/KRtXvMPS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0QSjFrihlCfNOWuxN/vKSCXDlktAmBLBV0RiwGo9mfZPC3Ukx46Bv5q+5nZvHsrBCsb0FKNWBlKv5LkA/rLgyGHYQdZKwh0PLSEvF8n+KDOy7IupX49mfewiG186NM1msUw4rEqXEOMuHjhfx+XDfC5dNZh7WbSwqMRYoXaihk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJ5TWNrD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJ5TWNrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076BEC2BCB0;
	Sat, 25 Apr 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140291;
	bh=4U28WVw1ZZqZdb1s8ZDPrFs3AhvfNYej0/KRtXvMPS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=BJ5TWNrDsiTTo1OUaV0ICz0DTTtH9jgjmGUkznKbk/lx0daw0ganaPShu4xunjO6y
	 w/riNeV3Ns2rypfHdRT4q/o7WvkoW1eRdzPqhKWsdIawJiXnJ97/tIIMQGpAtvN12R
	 TpOIRVFrG+VEe4h19JEn0L5/VyDdcdCSS7Bnxjv0U6Se44d9skWYxmPwUrzB1xaQSj
	 U6WiiHc4hyzqJd7+BigU0j217b7eBSeT4PAhU/YYdaLBLY1+zKsZq+bY6jXj4BrFeY
	 P0bIFmhU72TL0qV+VbH7X/VPEK/jpcrM6C9hy9nzXBn4z2WYDDId5iZPaGK+rLQ7mQ
	 S3l1XbBkoJZ8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 27/59] perf syscall-counts: Port syscall-counts to
 use python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-28-irogers@google.com>
References: <20260425174858.3922152-28-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:04:50 +0000
Message-Id: <20260425180451.076BEC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] The exact string equality check for `raw_syscalls:sys_enter` fails=
 if users specify event modifiers.
- [High] Thread comm resolution is broken for child threads, causing fallba=
ck to "unknown" or the main thread's comm.
--

commit 7ef8c21a813aa3c3340c9d87ff09125dadf987ed
Author: Ian Rogers <irogers@google.com>

perf syscall-counts: Port syscall-counts to use python module

This commit rewrites the syscall-counts Python script to use the perf
python module directly. This avoids overhead from perf script execution,
providing a performance improvement.

> diff --git a/tools/perf/python/syscall-counts.py b/tools/perf/python/sysc=
all-counts.py
> new file mode 100755
> index 000000000000..ef2bd8c7b24c
> --- /dev/null
> +++ b/tools/perf/python/syscall-counts.py

[ ... ]

> +def process_event(sample):
> +    """Process a single sample event."""
> +    event_name =3D str(sample.evsel)
> +    if event_name =3D=3D "evsel(raw_syscalls:sys_enter)":

Will this strict equality fail if the user specifies event modifiers?

If a user records with modifiers like perf record -e raw_syscalls:sys_enter=
:u,
the string conversion will return "evsel(raw_syscalls:sys_enter:u)". This
would cause the check to fail and silently drop the events.

> +        sc_id =3D getattr(sample, "id", -1)
> +    elif event_name.startswith("evsel(syscalls:sys_enter_"):

[ ... ]

> +    comm =3D "unknown"
> +    try:
> +        if session:
> +            proc =3D session.find_thread(sample.sample_pid)

Does using sample.sample_pid here break comm resolution for child threads?

The Python extension for session.find_thread maps to
machine__find_thread(machine, pid, pid). Since child threads have a TID
that differs from their PID, they might fail to resolve or misattribute
to the main thread.

The old script received the common_comm argument directly from perf, which
avoided this issue.

> +            if proc:
> +                comm =3D proc.comm()
> +    except (TypeError, AttributeError):
> +        pass

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D27
