Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8AD40DFCE
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776645876; cv=none; b=PtwB+63V6EcEbMBmtZban6Hpd2KYspu9J8iIo3Ghce80J0T376ckfeB+5/gRTpd+F9uUfLvNBd0tPNTzNA15eV+wtgYEM4P/dgE5neS342kk+f78V5sHjROfWDWD39rIdFRDBagW2pfI76+ZZNlEpGd22cR2QVfWMN5hpL3x9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776645876; c=relaxed/simple;
	bh=K9jIFMxz7W7movcsnZGX7eV8LLwNSs19h6kKMb6be+M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SUTFt9h5QQQNrPkiEAywED41ZLYqlIifSGx+M3mfMwcHzFIB2p1099nY3kq6YVMbD6oOk6wWtn3bsCzGT3C8EXkot4U3mA4Pxbj/s+j3eWXhywipF6nK+W8ZRponrGdk+/MNxiTG+gFq06GeSJ7hodv7B1KgFxrjqUWGlTV7jDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeSJBkRw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeSJBkRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BCFC2BCAF;
	Mon, 20 Apr 2026 00:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776645876;
	bh=K9jIFMxz7W7movcsnZGX7eV8LLwNSs19h6kKMb6be+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OeSJBkRwaVVS8bS1DXmqx2Epo7oiUJYhxWBB2V2jSV7MLquMMLtmhWzjSjhZuceae
	 UGHgKlKtZ1gYcxUAqiV3cmXppa4TE4HPxYmOO5+oW60OO0gMqx9uUSlzSFzhUARcGR
	 N35JLvVGwVcShAMSgTW5GeAqwVaBfpQC8rLl0YDcPBNII2eI0q5yCWT1nek1lI/rMb
	 V40mGCX6txheWV6iV0GOI8lw6LKLZMWLRe5MoT6suJqB2UxmRUHzwnUk5Rmbts9h9X
	 0ybFZ8W7LH2+hqGu1uoNP+P+N5ut8CquIBnbf0xvvSu5z+fL74Upqd8WIvJKavf+bA
	 FgfA7+BD6962g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 49/58] perf rw-by-pid: Port rw-by-pid to use python
 module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260419235911.2186050-50-irogers@google.com>
References: <20260419235911.2186050-50-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Apr 2026 00:44:35 +0000
Message-Id: <20260420004435.D5BCFC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] Loose substring matching for event names incorrectly aggregates =
unrelated read/write syscalls and corrupts accounting.
--

commit 11d4a0a058cda83b6e59be1ddd0bbfaf213c589c
Author: Ian Rogers <irogers@google.com>

perf rw-by-pid: Port rw-by-pid to use python module

This commit ports the legacy Perl script rw-by-pid.pl to a Python script
using the perf module. It tracks read and write activity by PID for all
processes, aggregating bytes requested, bytes read, total reads, and errors.

> diff --git a/tools/perf/python/rw-by-pid.py b/tools/perf/python/rw-by-pid=
.py
> new file mode 100755
> index 0000000000000..7bb51d15eb8dc
> --- /dev/null
> +++ b/tools/perf/python/rw-by-pid.py

[ ... ]

> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events."""
> +        event_name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +
> +        assert self.session is not None
> +        try:
> +            comm =3D self.session.process(pid).comm()
> +        except Exception:  # pylint: disable=3Dbroad-except
> +            comm =3D "unknown"
> +
> +        if "sys_enter_read" in event_name:

Does this loose substring matching incorrectly aggregate unrelated syscalls?

If the event name is syscalls:sys_enter_readv, syscalls:sys_enter_readlink,=
 or
syscalls:sys_enter_readahead, it appears they will match this condition. The
original Perl script bound callbacks to exact function names.

This could cause statistical inaccuracies when analyzing traces with other
syscall events:

1. sys_enter_readv lacks a count field, so sample.count raises an
AttributeError which is silently ignored. However, sys_exit_readv does have=
 a
ret field, so its return value is added to bytes_read without updating
bytes_requested.

2. sys_enter_readahead has a count field, so bytes_requested is inflated. B=
ut
sys_exit_readahead returns 0 on success, which the exit handler treats as an
error, falsely registering every successful readahead as a read error with
code 0.

Would exact event name matching, such as checking if the event name ends wi=
th
:sys_enter_read, prevent these inaccuracies?

> +            self._handle_sys_enter_read(sample, pid, comm)
> +        elif "sys_exit_read" in event_name:
> +            self._handle_sys_exit_read(sample, pid)
> +        elif "sys_enter_write" in event_name:

Are there similar issues here for write and related tracepoints like writev?

> +            self._handle_sys_enter_write(sample, pid, comm)
> +        elif "sys_exit_write" in event_name:
> +            self._handle_sys_exit_write(sample, pid)
> +        else:
> +            self.unhandled[event_name] +=3D 1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260419235911.2186=
050-1-irogers@google.com?part=3D49
