Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0635C1B6
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140265; cv=none; b=qoLGtI5IuzXnwk453eaYuazz0RjFlJ+aN3UNpwiJaXRAsFFHrYSkzi0gglPyT2xdrO3kVNmqU8OUPIo9az5JCnZCASD3vc49sWJHgNSYtBilFm8MSP8/zWAyf+n7jfpPQH6PxQJFDhDtnFHeiRio9vXDXgSAqJy4UfCxQEgqMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140265; c=relaxed/simple;
	bh=wNGuXISx8cH0Zfs9UWXzIL3/YdgUJVWJwpCSVjC2bLQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XN1vBBxSYPZxSWEWzMZTaNDm/z94s2xHQpJwHMwuhr9TyItwz3h09AA+n4DtHACvwtrF7ubvvVJDA/oTtxdG181hj7S2damYDhfkXpiICdKrZ8XnucLXor5Ih3TCMsULy7hLJSvSwOtgTr39aM+UYFtFu22hQhJ7AXQUiVbXrqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNN0hvi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNN0hvi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02142C2BCB0;
	Sat, 25 Apr 2026 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140265;
	bh=wNGuXISx8cH0Zfs9UWXzIL3/YdgUJVWJwpCSVjC2bLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=DNN0hvi3PpQKhMENM6Hmfb7d+g/i1smHZzemkoB1gKQn1jPeiEDjhm+ekJUkZ3Nmw
	 7hqpwhdGEE7u/1zXqE2uOJQqcVO28JrNoFtDXuqJ3l57w4kr5XdITFhT9Z5v6X89d2
	 4JyjJfAxinn/sqiPzM1f2wpXXKjSF4ykDMy4X0ZFJVtbmCR0fm5t4YMuakzGQxDpcY
	 yyqoQ6xD+N4catLgSEKDY6kO9LRbSKAD0Uih2WTVrEoGi59sePFV7yvVZ8ZjbuThUY
	 lhEFmfyQvhXARI8ZeEeuajfn0JLgeKzJkPBXnLuN/8eaOeMfoOxA1GSe6DLpkcWfWL
	 RGaD2k6kJ1J7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 49/59] perf rw-by-pid: Port rw-by-pid to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-50-irogers@google.com>
References: <20260425174858.3922152-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:04:24 +0000
Message-Id: <20260425180425.02142C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] Commit message and code implementation contradiction regarding p=
ylint refactoring.
- [Low] Dead code due to checking for non-existent raw_syscalls tracepoints.
--

commit d6f88a3734fa748dc053090f49ee9eef6f7204bf
Author: Ian Rogers <irogers@google.com>

perf rw-by-pid: Port rw-by-pid to use python module

This commit ports the legacy Perl script rw-by-pid.pl to a python script
using the perf module in tools/perf/python. It tracks read and write
activity by PID for all processes.

> Complications:
> - Refactored process_event to extract helper methods
>   (_handle_sys_enter_read, etc.) to reduce the number of branches and
>   satisfy pylint.

Is this description accurate?

The commit message mentions extracting helper methods like
_handle_sys_enter_read to satisfy pylint. However, the implementation
keeps all event processing logic within a single process_event method and
bypasses the linter with a disable comment instead.

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

Are there raw_syscalls tracepoints with the syscall name appended?

The raw_syscalls subsystem typically provides generic sys_enter and sys_exit
tracepoints without the syscall name. Do these specific string checks for
raw_syscalls:sys_enter_read (and the similar exit and write variants) match
any real kernel tracepoints, or does this result in dead code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D49
