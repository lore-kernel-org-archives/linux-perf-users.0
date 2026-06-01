Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578E78F4A
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780273386; cv=none; b=baWkXA8DRMR80V9OE2LzerITdUISChwp2AzCconUloCkusLA4jJ6gZlSG5amEaGLxLZ0H02Hyg4weu39z2qyHu5ONYBDN3Ei/jUeHmqIfuRooeV5aVOT27KLhFcwXbBHhzl/1Puis/LdPxtv2QuPA6GAOB47o8lSSNG1fEY6wrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780273386; c=relaxed/simple;
	bh=E5Xm13ICh1F/qD1OrGalar6/eyYXl7BDSjyxWDi2oV0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVkTfUtEXzYr0cxvK247AOOLfUivjmNL94d0XTcwPNf52YgbPRxjGB/CZxl9BBdfrZlYVHPkfVRm4el8y/3D71V0d8bjSBwfVzjubR0x0AWkcdGQhYO8M1ax7GsZEukYfPuf09Hg/9BiaVkzrWjRwjD31cxxZq82z3YaQAi41AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dal4FIDY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dal4FIDY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B310A1F00893;
	Mon,  1 Jun 2026 00:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780273384;
	bh=YtVU6qII4gU+azclz4TgDipJZ/Yk7HCSJCriPzEY9Ds=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dal4FIDYtJ+06yFeMSSSWYwFuLlppDjtbFqpGihtENhtsOGTiXLRbbqsrlEN/2QXR
	 Te538aOVNNUn3e1u3hohih70cCFjujdAP5Ti7fmDRIWLRJ+gA5Hpbg6LsGpZB93woF
	 VdOwbajUZKI564WeJ3+qRDpbHdEr0dLYh61syHv38Sd+MFIJxNHPjYCzquJeLaxr1U
	 OsGr5A39RedJ0odeCo3hS4I0Fcty5wamrjD1c246mUbl2APeJeFOYbV8LBatsufd5v
	 4JXv8d5nXwQ6Yt/V3nL9c50vmtBDXbDOHb17f8SuHLXZS4JtEpwyey5a3FvtXklK86
	 QhY5g38vwogCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/15] perf test: Add -j/--junit option for JUnit XML
 test reports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601000548.1195604-14-irogers@google.com>
References: <20260601000548.1195604-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 00:23:04 +0000
Message-Id: <20260601002304.B310A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] When start_command() fails to spawn a child process, its failure=
 propagates to __cmd_test's err_out path, which unconditionally invokes fin=
ish_test() on the failed child_test object. This causes wait_or_whine() to =
execute waitpid(-1), inadvertently reaping unrelated parallel test child pr=
ocesses and causing their exit statuses to be lost.
--

commit 9f0a55afca8eec136a897a87513faf7cbd01d8ce
Author: Ian Rogers <irogers@google.com>

perf test: Add -j/--junit option for JUnit XML test reports

This commit adds a -j/--junit option to perf test to generate standard
JUnit XML format test reports. The XML report captures test execution
latency alongside escaped failure logs and skip reasons, while preserving
the concurrency of parallel test execution.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 4c0caa8d0b27e..1c1e77e19a0a2 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -963,6 +1043,7 @@ static int start_test(struct test_suite *test, int c=
urr_suite, int curr_test_cas
>  		(*child)->process.err =3D -1;
>  	}
>  	(*child)->process.no_exec_cmd =3D run_test_child;
> +	clock_gettime(CLOCK_MONOTONIC, &(*child)->start_time);
>  	if (sequential || pass =3D=3D 2) {
>  		err =3D start_command(&(*child)->process);
>  		if (err)

[Severity: Medium]
This is a pre-existing issue, but what happens when start_command() fails to
spawn a child process?

If start_command() fails (e.g., due to fork or pipe failure under parallel
load), it returns an error and child->process.pid is left as -1. The caller
__cmd_test() then catches this error and jumps to its err_out path:

tools/perf/tests/builtin-test.c:__cmd_test() {
    ...
err_out:
    signal(SIGINT, SIG_DFL);
    signal(SIGTERM, SIG_DFL);
    if (err) {
        pr_err("Internal test harness failure. Completing any started tests=
:\n:");
        for (size_t x =3D 0; x < num_tests; x++)
            finish_test(child_tests, x, num_tests, width);
    }
    ...
}

This unconditionally invokes finish_test() on the failed child_test object.
When finish_test() subsequently calls finish_command(), it reaches
wait_or_whine() where cmd->pid is still -1:

tools/lib/subcmd/run-command.c:wait_or_whine() {
    ...
    pid_t waiting =3D waitpid(cmd->pid, &status, block ? 0 : WNOHANG);
    ...
}

Because cmd->pid is -1, waitpid(-1) will inadvertently block and reap any
running parallel test child process, rather than the specific test that fai=
led.

Could this corrupt the test harness state and cause unrelated parallel tests
to lose their exit statuses?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601000548.1195=
604-1-irogers@google.com?part=3D13
