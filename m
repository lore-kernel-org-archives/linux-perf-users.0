Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38F81FC0
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791952086; cv=none; b=c+aUw7Gg2DAAMNxP+7EAJ/aJvdvJkyBv7+3lkJD3TrYhOAZ//HrEHUAP7WCcFe+McYMydqn6MLc9qjXu6Xjqn1D/6uBecJ6MUFjLpwQkxlA1xRsOC7ceI2u4F2UepnM9ibRClZmiL9Hb0dRFHPOUEcX3E4j+V9q3US0+tu1n4iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791952086; c=relaxed/simple;
	bh=m1q+UiK3aB6ZzWLnANhgQaZdzThJny53Pxi6SfQju84=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HFEgJ3VHpQx+OvgAc1XH87Xoch1c9QvS6BFe9GMYqboHhurklVCiECXMIfvZv/7lhx9+tkz+CvEVV+0oODbVGzcF/Lwc/JaCEVNRoFGcQ9v8P6dGyEFoaPwwHsW3HuBIhXrKcekjpTRX8eI/KsyvToNRsrjmh6C4B+NavYl/Roc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ae3SRiAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ae3SRiAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A221F000FF;
	Wed, 14 Oct 2026 04:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791952085;
	bh=HJEi1pz/cSWMKSykrOUgimj3arLXx5r7FDIiGQugf/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ae3SRiAN1+FoPYZf1NK/bF15rap6rIgt7UlkhcLSIpNjls6b+e2r+lM9OCJjQwKBx
	 oB71YaBXH3GUwj8pjviK3kQ/VR8uB9IHTUVazpPJ1equ4Z5FhUFpxiNIjtE4+Rt7us
	 bzpuvIPTEimEdZaVySrd16jaI41zjmGxt1mPwp5FDyCLYdKcXNELu8TBtwU79T0X8P
	 o7K9LRwAFcw3+MizFicEVlNh+3ux5ZX/0DfQDd43l37sOGjb3HC0yaQK76d3RpwoiQ
	 hzrBuBxwoXmwRUEcnSS6kJ/f+q1jSgqe0x/HK/hMFiBjKbezsyq1+amTE+Ejq3q6yz
	 a16NsCQKDa41w==
Message-ID: <sashiko-outbox-170827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261014042249.2379829-3-irogers@google.com>
References: <asDHqdVt4CKq_EoL@x2>
 <20261014042249.2379829-1-irogers@google.com>
 <20261014042249.2379829-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 04:28:04 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf/tests: test hang due to missing FakeRecorder cleanup on err=
or paths
--

commit 160f73df934f65800928fbfdebb9b1aabb7e4e95
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf test: Test perf timechart --live

This commit extends test_ttimechart_python.sh to validate the --live option.
It exercises LiveRecorder's perf record subprocess, control pipe, output fi=
le,
and introduces a synthetic live UI test for checking the rolling window,
pruning, and zoom tracking features.

> diff --git a/tools/perf/tests/shell/test_ttimechart_python.sh b/tools/per=
f/tests/shell/test_ttimechart_python.sh
> index 87b91ed8fc167..495060586cfc2 100755
> --- a/tools/perf/tests/shell/test_ttimechart_python.sh
> +++ b/tools/perf/tests/shell/test_ttimechart_python.sh

[ ... ]

> +test_live_synthetic() {
> +	echo "ttimechart live UI test (synthetic)"
> +	# Exercise live mode's rolling window, pruning, pause/resume and
> +	# following with a fake recorder, which doesn't need tracepoint
> +	# permissions.
> +	if ! "$PYTHON" - > "${output}" 2>&1 <<'EOF'
> +import asyncio
> +import threading

[ ... ]

> +        cur =3D 0
> +        while not rec.stopped.is_set() and not rec.finish:
> +            now =3D monotonic_ns()
> +            if rec.paused:
> +                time.sleep(0.01)
> +                continue

[ ... ]

> +    tc.read_events =3D fake_read
> +    app =3D tc.TimechartApp("live", False, False, [], live=3Drec, window=
=3D1.0)
> +    async with app.run_test(size=3D(120, 40)) as pilot:
> +        for _ in range(300):
> +            with app.data.lock:
> +                if app.data.pruned_to > rec.origin + 3000:
> +                    break
> +            await pilot.pause(0.05)
> +        with app.data.lock:
> +            if app.data.pruned_to <=3D rec.origin + 3000 or 300 in app.d=
ata.tasks:
> +                raise RuntimeError("Task outside the window was not prun=
ed")

[Severity: Medium]
Will this cause the test suite to hang if an exception is raised here?

Because fake_read runs in a background thread and its loop relies on
rec.stopped.is_set() or rec.finish, an exception (like RuntimeError
on a failed assertion) will abort the test logic without executing
rec.finish =3D True or calling rec.stop().

This lack of cleanup leaves the background thread looping indefinitely and
prevents the Python interpreter from exiting. Other tests introduced in this
patch like test_no_events and test_live_record use try...finally blocks
to ensure rec.stop() is always called.=20

Should a similar pattern be applied here to guarantee termination?

> +            starts =3D [t.segs.starts[0] for t in app.data.tasks.values(=
) if len(t.segs)]
> +            if not starts or min(starts) < app.data.pruned_to:
> +                raise RuntimeError(f"Unpruned segments: {starts} < {app.=
data.pruned_to}")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014042249.2379=
829-1-irogers@google.com?part=3D2
