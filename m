Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC05346A1E
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295321; cv=none; b=GLhyfhtW15b+tc7QRgVNAHowfNHWMcEUP0p39Or5fIMiGxj/h+Bx/vzkYye3FC00VYnIbep3tBSGllGZ6CFpuy18Y4vB3LmJVkveGfak98efPTvbI7hbGpEAk9DTazfhrvvUN3L1Kyk8EoGks5BCaq6Hg/ZjWjegP9ZN7u3+gY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295321; c=relaxed/simple;
	bh=a3Gul31FF1tz+19yShu9EGxL/F0a68mTisgOwr7K0Ik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJ1BrqcdYSin7CH/G+sxYcWpHSnZ5DjQIDx0GkGdiMFscYPEGQ46ge/GoimKbMKrs9ZXyv/4m5Hv3Pz0XRQPQCyQVOV2eXyBrshRJsYX6oFEQCHZvE2PKRx3XObSA0IMhuMBGSwHuMPiFVcxrbJrQG1Eku4FR2Wh0k+xEl/T1Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpURBVYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpURBVYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE951F00893;
	Mon,  1 Jun 2026 06:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780295320;
	bh=q3SUekYaORlkKbG+qggFI8f02X0MM/cgJxmqU69xpb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cpURBVYCXnvzDJplo0gNsSfYpdWiG5HHuxDura0IK5CNL6XbT0JUrS+jNyAX+dxNp
	 cjmVi6uQgW9cgEHMXXdmSqPQNhMCf9+N4gpCOilepsZFerb1ddrvZLS5Tw0cIcz+ur
	 LnE6vGWKIoWW8kKWqSXB5EWF5j5WCWE9ohx3TZqKlZsi1pONoz2uHw2Mv9C2hRC2gc
	 gGDcZFLiOQBxmfoJ4iCzh73H2iwwLztjVLAU4tlcIH4eRSgdsvws7kFeoQ+u0J6eNb
	 Yi4hmv6/5ybkVsmq1qCKhhrGP/g/jbVLnJqLCZUlWNwcd6ctMiMHyPTXWJ/e/x89TJ
	 55rPjJ02MwhMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/15] perf test: Refactor parallel poll loop to drain
 all pipes simultaneously
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260601061401.1541457-8-irogers@google.com>
References: <20260601061401.1541457-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Jun 2026 06:28:39 +0000
Message-Id: <20260601062839.9AE951F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Reaped child PID remains in the test tracking array and may be sig=
naled after reuse, potentially killing an unrelated process.
--

commit 50fe4cbf4a3441a4b15d1298d9f0e698e2a7adec
Author: Ian Rogers <irogers@google.com>

perf test: Refactor parallel poll loop to drain all pipes simultaneously

This commit addresses parallel test child output blocking by simultaneously
polling all child pipes and reaping them out of order as they finish, which
significantly reduces the execution time for the PMU events suite.

> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c

[ ... ]

> @@ -499,16 +507,233 @@ static void finish_test(struct child_test **child_=
tests, int running_test, int c

[ ... ]

> +		for (i =3D next_to_print; i < num_tests; i++) {
> +			struct child_test *child =3D child_tests[i];
> +
> +			if (!child || child->done)
> +				continue;
> +
> +			if (check_if_command_finished(&child->process)) {
> +				if (child->process.err > 0) {
> +					drain_child_process_err(child);
> +					close(child->process.err);
> +					child->process.err =3D -1;
> +				}
> +				child->result =3D finish_command(&child->process);
> +				child->done =3D true;
> +			}
> +		}

[Severity: High]
When a child finishes, this calls finish_command() which reaps the process
and releases its PID to the OS, but it doesn't clear child->process.pid.

If a user interrupts the test with a signal before this child is printed
and removed from the array, the error handler in __cmd_test() will loop
through child_tests and send a kill signal:

__cmd_test() {
    ...
    for (size_t x =3D 0; x < num_tests; x++) {
        struct child_test *child_test =3D child_tests[x];
       =20
        if (!child_test || child_test->process.pid <=3D 0)
            continue;
       =20
        kill(child_test->process.pid, err);
    }
    ...
}

Since the error handler in __cmd_test() doesn't check if the child is alrea=
dy
done, could this rogue kill() terminate an unrelated system process that
happened to reuse the PID?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260601061401.1541=
457-1-irogers@google.com?part=3D7
