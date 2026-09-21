Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1F33546D7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969084; cv=none; b=ZZxOd+JBi+lggL37nnakrd3WEUYpoJ1++VruGW6Y96eu2FDTscvMWZoEnKyUeAy+bHq45wY87YYcTg2T4M+rCo7ilrJzwUn4iKwdcGGDpn3bMIUzWiBCkwcML9IdQ85c4q6kzYF/ySv76jDk/Zc70HJQEqvzSEDxorX8VFXVt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969084; c=relaxed/simple;
	bh=WWRVw4lELaRBFu6MRNWwfAyA+ZPOyYkXM5iH+tJYYPs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NxQyiwBg+gjk+CHKHP4HMlmhn6T/761tfz+/8tSZ/B9MLwOBG/s//XLAtl8arGqXmw8S3nO/pzDjS32I4wK7V4ULkJntaZ8oENNq3wz5qUoyi3iiQZFzhYh5h666jwRqCh/KksmQsqnSCzBPoZMkn1PU2NoPMBFgd5onEEsJwcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxTcTIl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxTcTIl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21C41F0089E;
	Mon, 21 Sep 2026 05:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969083;
	bh=T0bYJn/LZKbF8A5xwBorHlZ0XUK9W8htElzehjc7a4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GxTcTIl8YHPWA/WMVwAJQDyO4bSyMc8/zqcuth418DKAKfoSU7qWo+ZOlaH0r4ihW
	 M+/t79q+cY8nC+pHHPkVelvBv3HDS2J58oPz4s0KKWwpIBm6ozrZIOJd+qT4KYrq7B
	 YUe3F55wWUymg7hvT3ac2dxZVOJrQJ15WRmCzZLey9WcNkRzc+UL2Gm9oDN4W0ne4U
	 F/HXiRYQLeo9rLBPOY/f5VRrTevsdJLcF64sdumT35TrqNVP0LxeIdwfR7x/LemM57
	 4QGXfJf5RKgRgr/JFZbOMSeIKxqp2N0+vXpvAOlnNpPEX2PbTodZE/HN+4LeqXmYKl
	 f4oLu4ess7Irg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 24/49] perf python: Port failed-syscalls-by-pid to
 perf module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <72106f17ecaeaf9a5c000c284c18b58f6988a8ba.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <72106f17ecaeaf9a5c000c284c18b58f6988a8ba.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:38:02 +0000
Message-Id: <20260921053802.D21C41F0089E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf python: strerror() bypasses generic errnos for _ARCH_ERRNO_=
TABLES targets
- [Medium] perf tests: test script silently masks comm/pid filter failures
--

commit c03d620ae52c4572d4e7598d33712bda57f18571
Author: Ian Rogers <irogers@google.com>

perf python: Port failed-syscalls-by-pid to perf module

Port failed-syscalls-by-pid.py to a standalone script in tools/perf/python/
using the perf module.

> diff --git a/tools/perf/python/failed-syscalls-by-pid.py b/tools/perf/pyt=
hon/failed-syscalls-by-pid.py
> new file mode 100755
> index 0000000000000..30332062f89a4
> --- /dev/null
> +++ b/tools/perf/python/failed-syscalls-by-pid.py
[ ... ]
> +def strerror(nr: int, e_machine: int =3D 0) -> str:
> +    """Return error string for a given errno, accounting for target e_ma=
chine."""
> +    err_num =3D abs(nr)
> +    if e_machine in _ARCH_ERRNO_TABLES:
> +        if err_num in _ARCH_ERRNO_TABLES[e_machine]:
> +            return _ARCH_ERRNO_TABLES[e_machine][err_num]
> +    elif e_machine !=3D 0 and err_num in _GENERIC_ERRNO_OVERRIDES:
> +        return _GENERIC_ERRNO_OVERRIDES[err_num]

[Severity: Medium]
In strerror(), does this code bypass the generic errno overrides for
architectures listed in _ARCH_ERRNO_TABLES?=20

Because the elif is attached to the outer if, if the architecture is present
in the table but the specific errno is not mapped in that arch's dictionary,
it will skip the elif entirely. This will cause it to fall back to the host=
's
errno.errorcode instead of trying _GENERIC_ERRNO_OVERRIDES first.=20

Should this be an independent if statement instead?

> +    try:
> +        return errno.errorcode[err_num]
> +    except KeyError:
> +        return f"Unknown {nr} errno"
[ ... ]
> diff --git a/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh=
 b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
> new file mode 100755
> index 0000000000000..d5fab922b8a9c
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
[ ... ]
> +	# Run the script and check output
> +	if ! "$PYTHON" "$script_path" -i "${temp_data}" > "${temp_out}"; then
> +		echo "failed-syscalls-by-pid test failed."
> +		err=3D1
> +	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "ls" >/dev/null; then
> +		echo "failed-syscalls-by-pid comm filter test failed."
> +		err=3D1
> +	elif ! "$PYTHON" "$script_path" -i "${temp_data}" "$$" >/dev/null; then

[Severity: Medium]
When running test_file_mode(), will redirecting the output to /dev/null and
only checking the exit status mask failures in the comm and PID filtering
logic?

Because failed-syscalls-by-pid.py will exit with a 0 status even when no
events match the filter (it just prints an empty table header), checking the
exit code won't detect if the filtering actually matched any events.

Should the output be captured and inspected instead?

> +		echo "failed-syscalls-by-pid PID filter test failed."
> +		err=3D1
> +	else
> +		if ! grep -n -q "err =3D ENOENT" "${temp_out}"; then
> +			echo "Failed to find expected failed syscalls"
> +			cat "${temp_out}"
> +			err=3D1
> +		else
> +			echo "failed-syscalls-by-pid test passed."
> +		fi
> +	fi
> +	rm -f "${temp_out}"
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D24
