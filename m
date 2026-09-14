Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE57C46C821;
	Mon, 14 Sep 2026 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396213; cv=none; b=O5ErLaSDabp2izhF41s5plxN1r3UNeNfq4KTM9st9ek1809OEvFQXdVakihuhZ84gcBzOvIEzftZ4eWlbiJlptzzQztKAY0F6mRyBmf2S2zHCfYJCFzaYP9hOu0AdMJSfyBz0VbfHYj27Mmc9k1u4200uWR96IKl5QGjXUWB1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396213; c=relaxed/simple;
	bh=9rBDqKuA6wN0JyoV9fX+KDGjV/1hpIlVePYB/jalYWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h4+znQUwS195NUByF+7u6EeJx0ldiBo/FppEVm5np6Ln3OihuI70xDTy/sAtSqu9fl3WnFetETopktRd0RDljr9+YT+6WIKqP/riSxTxdp1dqUPXfzSirqutW2/12QxA9gA4vtO+V+kJTMqO3CARoarURs8Dh4DIFlYRQmHIuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MN12vLHx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MN12vLHx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BA81F000FF;
	Mon, 14 Sep 2026 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789396211;
	bh=udja4IwLHxopqZNGMzVzjJ7xxtersr50zEL1HZYxt7U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MN12vLHxh6g6sARgGIcKQUYaMo1A4soIWDHew9Sde3ECBxdoGkNgtIBqX/onYGMwD
	 KTfVphgqRjao7nyuKaz79Jw/htZa8oIkjLkIehTAMwEVPuYENcaXj3SfOKY6FDgjHs
	 PBGMveUp52rZSm5L97NMSqR7ayxMQvI6eL5dniZTwWbyzWxyKGd7MPOSwWiirSw1vV
	 9IRmwx/2smI2ABmxsbucPK7yiIkm7a6Ul/yqj6le6rdfUisE/rvzmcQrDUCX+nhD5u
	 RAzsDHYTaNOdxYs5JGT9rKTWWAFbqnQG1tq1LK9ElmzoDNySJxEgjBGjIzWNEiOEfJ
	 IlJc1YrVeiyDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 08/13] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178939027201.94750.11818590613347692117.stgit@devnote2>
References: <178939017565.94750.9431053336761330458.stgit@devnote2>
 <178939027201.94750.11818590613347692117.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:30:11 +0000
Message-Id: <20260914143011.81BA81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unhandled error from `echo 1 > enable` causes false test failure=
 under `set -e` when hardware watchpoints are unsupported.
--

commit 70eb02867fbc0203498e0161a5c4b437b562d025
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

selftests: tracing: Add a basic testcase for wprobe

Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
tests adding and removing operations of the wprobe event.

> diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wp=
robe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.=
tc
> new file mode 100644
> index 0000000000000..647c37d5e4c84
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_wprobe.tc

[ ... ]

> +if [ ! -d events/wprobes/my_wprobe ]; then
> +    echo "Failed to create wprobe event directory"
> +    exit_fail
> +fi
> +
> +echo 1 > events/wprobes/my_wprobe/enable

[Severity: Medium]
Will this script falsely report a failure if hardware watchpoints are
exhausted or unsupported on the platform?

Writing to the enable file triggers enable_trace_wprobe() and eventually
register_wide_hw_breakpoint(), which allocates physical hardware debug
registers. If this allocation fails (e.g., returning -ENOSPC or -EOPNOTSUPP=
),
the echo command will return a non-zero exit status.

Because ftracetest runs test scripts with 'set -e' (errexit) active, this
error will abort the script immediately and fail the test instead of safely
skipping it.

Should this write be guarded with something like "|| exit_unsupported" to
handle expected hardware limitations?

> +
> +# Check if the event is enabled
> +if ! grep -q 1 events/wprobes/my_wprobe/enable; then
> +    echo "Failed to enable wprobe event"
> +    exit_fail
> +fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178939017565.94750.=
9431053336761330458.stgit@devnote2?part=3D8
