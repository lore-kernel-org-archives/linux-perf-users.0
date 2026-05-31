Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A431D74B
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205855; cv=none; b=lp7ixTRWSFW+MAtGv5LxY1sbYmXvuP9C/Hjut3ITrHMjevl9x6M48yix/Sy2+gFAN8kfxl66cQz7gH6NhmUt8jCJ44YoFpOvOh1WxdbifClSTQ56vI/4pekxM5qm4fG3Zt8jdOEKRM5mz848+D2we3ioUzE6kxCY7JavEgC9m8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205855; c=relaxed/simple;
	bh=rgrcwlh4FMvnKQZFdxTXlnM7CjcFIzCxedo+KmaOAlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQPdYn3fAzQgRdeu8bO65R+rIQVMU7eLqZq6ZrXxIHtE1AxmGZ2m3HtCbS8xmAsJtPkEq2nPgkqzNrf/sLyTwNnALaxF4BHrFP2M3WCEfTID0O4EkPwu6ZDLojJj3nwWL+O1ovr8VmEo/GkLevDffUsTwNpAzpOePiHhunjqQEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfhRCPmy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfhRCPmy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DDB1F00893;
	Sun, 31 May 2026 05:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780205853;
	bh=VlKHWkj52syg8Uy07o1MqjgAFPUylfXZfwV37C9QYxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfhRCPmyuRBBzPWhqmiZ9XRv6WzjdIv8I2JdCNVO8GlUM4C/lb8VqWTdEEuUiRAsh
	 v0zUqchxh5sd1qcInV+gLDiK2j+NhGC5Z7vvoxJUZMYqMbSe5WDpaGcFABL5AWh8YA
	 McSO4YZ4DjW8SCmSAoGBLFI/OgGcRyyoqMZr25VHVlk1s7H4IK8dwPv/dEYDLwjkua
	 RmIlEZGRAOO1LX4FFxSnlW1D8tGiPDdpJFD2qi0ZXT6kGOlu3TN+SzSI/V/wKbes9V
	 Uk3aATeSjOn725ZUfNSvjKbf3zssGKdU88OTs5kYQUe0eU0VyELb52I4lqMgGDzPCy
	 q3E6bNnetk0zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/14] perf test: Drain pipe after child finishes to
 avoid losing output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260531052740.796087-4-irogers@google.com>
References: <20260531052740.796087-4-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 05:37:33 +0000
Message-Id: <20260531053733.91DDB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The test polling loop can enter a 100% CPU busy-spin if a child te=
st process closes its stderr but continues running.
- [High] If `start_command()` fails (e.g., `fork()` fails), it cleans up it=
s pipes but leaves `cmd->err` holding a closed file descriptor and `cmd->pi=
d` as `-1`, leading to a use-after-close and arbitrary process reaping.
--

commit ff71835e6d5c12aa0bbf542fae6fb8f2f4bce66f
Author: Ian Rogers <irogers@google.com>

perf test: Drain pipe after child finishes to avoid losing output

When running tests in parallel, the parent process reads output from
the child's pipe. This commit drains the pipe after the main loop in
finish_test to avoid missing data that arrived just after the last poll.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index f2c135891477c..7946878195b7d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -483,6 +483,16 @@ static void finish_test(struct child_test **child_te=
sts, int running_test, int c
>  		if (err_done)
>  			err_done =3D check_if_command_finished(&child_test->process);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but could this loop enter a 100%=
=20
CPU busy-spin?

Inside finish_test(), poll() waits on the child's stderr (err).

If the child closes its stderr while continuing to execute, poll() immediat=
ely
returns POLLHUP and read() returns 0.

The loop sets err_done =3D true initially, but then check_if_command_finish=
ed()
returns false since the child is still running, resetting err_done to false.

Because err > 0, does the loop repeat without any delay, causing an infinite
busy-spin until the child finally exits?

> +	/* Drain any remaining data from the pipe. */
> +	if (err > 0) {
> +		char buf[512];
> +		ssize_t len;
> +
> +		while ((len =3D read(err, buf, sizeof(buf) - 1)) > 0) {

[Severity: High]
This is a pre-existing issue, but does this newly added drain loop risk
operating on a reassigned file descriptor if start_command() fails?

In start_command(), if fork() fails, close_pair(fderr) closes the newly
created pipe. However, cmd->err was already assigned to fderr[0] and is
not reset to -1, nor is cmd->pid reset from -1.

When the error propagates, __cmd_test() calls finish_test() on the failed t=
est.

Since finish_test() extracts the closed FD, could this new while loop
inappropriately drain an unrelated file descriptor if another thread reused
it, potentially corrupting data?

Additionally, finish_test() will then call close(err) on the reused FD, and
finish_command() will call waitpid(-1, ...), which erroneously reaps an
arbitrary parallel test child.

> +			buf[len] =3D '\0';
> +			strbuf_addstr(&err_output, buf);
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531052740.7960=
87-1-irogers@google.com?part=3D3
