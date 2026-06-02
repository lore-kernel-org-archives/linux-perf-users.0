Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC1E3B813E
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393536; cv=none; b=SqIULO2fH8O4bLz4+VsVXq5/fsY4oaeE+onEuWB03Oj3HbG092ozFwRx9iQPhFFofbDXomNh/8l1v+DtA6wy0w7nFZvRP7bc3y0p1XW9SXM9C6Zj1OrDmpwmbxogfJtiFFv1JFtX/xSlcD28KhqmLkjaViOcmXanCSIHw3lIftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393536; c=relaxed/simple;
	bh=gBHOm8EXJUfPUcPY0GR5+ju26RFpGJRN3mcb68cOxOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=byOqqHl1k5k5Nk48ZA6IxP5l/UJtNBVHpXO6gl7DLBBA/P0mycqrzXOZO4Kr0f5uGO6CXXQnDS1WdW34U6vLfoQdDSmr369nQR/9TUhZeo5HgIff9suLhOfZh9LuoGIA7ie1uxDQ4qGMOulPTaprz7oZc7OuNEDqG2ZV+lPq7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYETECwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYETECwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B17D1F00893;
	Tue,  2 Jun 2026 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780393534;
	bh=OXPxC0aaBVrQDKBQJsqDhkpTWst+Codx338ERtJc6/U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TYETECwnjQ5qGNgUc9LU7AzBv8PxPEIX68AwkhHpEQkEWoBcs9ifD4fPfACGy2KXY
	 k2zz24JuldK1EAUSZGuijie9I8KBffsvQGpu9u/71APrAS4cKvsw9Sjaw9LQNvvXe1
	 bZLZo44gCri0Krq3YWFx+xLuEccVTKHiQ6p5bFxWoj3OJhqQ5jZpVeG3KH7iH8rrWz
	 d6HW28M7yXiU13DBJl8dcCScF5eQu0vB5W00gPO52jcvRGtaLbiC0/NnOYfk4Tr9Vt
	 JwxRRqS4Zr1SWONUhn3hE0M+/th29yIbuQOaRTZJoQkkOfIjp6LSqO4bTe5sxdaGrS
	 8CMTVFadV9vOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] perf test: Add shell test to validate JUnit XML
 reporting output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260602073132.2653307-16-irogers@google.com>
References: <20260602073132.2653307-16-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 09:45:33 +0000
Message-Id: <20260602094533.8B17D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The shell test unconditionally fails because it relies on an uni=
mplemented `-j`/`--junit` option in `perf test`.
--

commit 31f6e510d9bd4b022fd2d85031ceb012fba13be3
Author: Ian Rogers <irogers@google.com>

perf test: Add shell test to validate JUnit XML reporting output

This commit adds a shell test script to execute perf test with the
-j/--junit option. It then uses Python's ElementTree parser to validate
that the generated report complies with standard XML formatting.

> diff --git a/tools/perf/tests/shell/test_test_junit_output.sh b/tools/per=
f/tests/shell/test_test_junit_output.sh
> new file mode 100755
> index 0000000000000..5104ac1e1e6de
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_test_junit_output.sh

[ ... ]

> +test_junit_output()
> +{
> +	echo "Testing perf test JUnit XML output command"
> +	perf test -v -j"$result" util || true
> +	if [ -s "$result" ] ; then

[Severity: Medium]
Is the -j/--junit option currently implemented in perf test?

Looking at cmd_test() in tools/perf/tests/builtin-test.c, it appears
the -j option is missing from the option parser:

tools/perf/tests/builtin-test.c:cmd_test() {
        const struct option test_options[] =3D {
        OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
        ...
}

If perf test fails to parse the argument, the command exits early and leaves
the temporary $result file empty. The size check will evaluate to false,
and the subsequent Python XML parsing step will fail.

Does this test rely on a separate patch in the series to add the -j option?

> +		echo "perf test JUnit XML output command [SUCCESS]"
> +	else
> +		echo "perf test JUnit XML output command [FAILED]"
> +		err=3D1
> +	fi
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602073132.2653=
307-16-irogers@google.com?part=3D1
