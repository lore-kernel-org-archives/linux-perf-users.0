Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AAF1E9B1A
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790648752; cv=none; b=q+S9KTb83B85uqAtii+QlVfErzQ24rYE1ZxlsIle2uF6WxbIBdGv+8R4/e1jFzE1g08IVWOqg1nOsM+CCFaI+/OjfMRv8Au1mbM5v/Zi3KgMU61HfWeEqMtXOON5/gSojv5iX9mQje1JUOtD64N7QsjAk1o6unbTHK+6w/69x9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790648752; c=relaxed/simple;
	bh=RquPiu+KATmC9gk8La0F2glTkSUo6TS4mcItIwUQ7Yw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tJXgYysMLZOLpaJckiZLGjwWvTc1BnAmDlbuoMIhGxZUOin8M88OdC8TbRo40cVlSLJ0MPSED/CpHEmlKJzlwPdyMfp3hvKe6MoFuBO+nWhsnsvNDIckhCxvw32eNJeXq+qVTHOvGGLHCI84TXjgUmOmYT6/So4s7xVrkZGg2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FL9m1R5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FL9m1R5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B5811F000FF;
	Tue, 29 Sep 2026 02:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790648751;
	bh=hbdalJt341H10W55v/KfrIadmshWq4qaVoTfzEk6Vq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FL9m1R5Kr5ny5vlUv7xWraFszJWB3uxhalnjWnwSVq1aBRmsJeV6vAljKlqCvPfRx
	 i3HPjf88HaLJZxe3dZP/BqljA8PuZoOItxJxSk5frUIl3UcmKc3wo97mK+N7lTuUor
	 12dHzhAFAbAD7qUk/8dAFsYE5Dj87oBFtYRW6qhY9YIaEcdagTjHb7QL+X5UopVvSw
	 ORnM2/3G7hteO4m6CpYoS3V1f2ROBeJ+yAy3eyKIPuJlARn0o3bxhDHZ4OixHrvzts
	 HgjH66Qb0WahtxLE0eNR+644Ur1B7BxO+nw9S8cgQEhuj4rrJEY+setxhGwI3NbqRD
	 /7CjXge4wdpfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/9] perf test: Deflake failed-syscalls Python shell
 tests under load
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929021913.56010-6-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929021913.56010-6-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 02:25:50 +0000
Message-Id: <20260929022551.6B5811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf test: TOCTOU symlink vulnerability via rm in /tmp
--

commit 2edcd77bcabafd7550e8af4c57dda0ca7cfe9278
Author: Ian Rogers <irogers@google.com>

perf test: Deflake failed-syscalls Python shell tests under load

This commit updates the failed-syscalls python shell tests to handle
heavy system load by adding a bounded retry loop and short sleep intervals.
It also explicitly passes the no-bpf-event flags to perf record to
prevent early exits during BPF event synthesis.

> diff --git a/tools/perf/tests/shell/test_failed_syscalls_python.sh b/tool=
s/perf/tests/shell/test_failed_syscalls_python.sh
> index 861c2ba71c0a2..88a42e3de4f35 100755
> --- a/tools/perf/tests/shell/test_failed_syscalls_python.sh
> +++ b/tools/perf/tests/shell/test_failed_syscalls_python.sh

[ ... ]

> @@ -52,28 +54,38 @@ else
>  	EVENT=3D"raw_syscalls:sys_exit"
>  fi
> =20
> -# Run perf record with a command that fails a syscall (ls non-existent f=
ile).
> -# ls exits with non-zero, so perf record returns non-zero exit code of t=
he workload.
> -perf record -e "${EVENT}" -o "${temp_data}" \
> -	-- ls /nonexistent_file_for_test >/dev/null 2>&1 || true
> +# Run perf record with a command that fails a syscall (ls non-existent f=
ile),
> +# sleeping briefly in the subshell so ls's PERF_RECORD_COMM and sys_exit=
 events are flushed.
> +passed=3D0
> +for _ in 1 2 3 4 5; do
> +	rm -f "${temp_data}" "${temp_out}"

[Severity: High]
Does this rm command expose the script to a time-of-check to time-of-use
symlink vulnerability?

The files temp_data and temp_out are initially created securely in the
world-writable /tmp directory using mktemp. By explicitly deleting them
here in the retry loop, the filenames are freed.

During the window between this deletion and the subsequent shell
redirection, a local attacker observing /tmp could recreate these names
as symlinks. When the test redirects output or writes to them later, it
will follow the symlink and could overwrite arbitrary files on the
system. This could lead to local privilege escalation if the test is run
with elevated privileges.

> +	perf record -B -N --no-bpf-event -e "${EVENT}" -o "${temp_data}" \
> +		-- sh -c "ls /nonexistent_file_for_test 2>/dev/null; sleep 0.05 || tru=
e" \
> +		>/dev/null 2>&1 || true

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929021913.5601=
0-1-irogers@google.com?part=3D5
