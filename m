Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792735262;
	b=heEK7TyS/S2pwHXf/k+smrMoVQabQhz3I349fk/NWwHsfh/+d0CU5uytxeqan5ca89+F
	 W2hgBjICC4B2k3yBu6N7opDs1tObjSz+moUxWrEuFztttAU4G0PIIqIEL1vTiAIxxvsW5
	 qDvzD+3xxWGwNC3AIGciPsCqfvuctqxDC8RBMFRhuwOvA5pj52R8H8Dn3G5RokcfQctkf
	 TUET1D+27aQqCGBuHIv54DjZAM3COW/sQXAvZE/ehHJi+NZvV4yd0HUSCbHINT3S3jch/
	 1GN2RCCkaIoAy8DsfVy38vvr27UUEe1nQ1yVHbhEbNASz4GwawSkTa+jiTuV+03o4EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792735262;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wTuI00BBLubFkushCOqbi8y9KzW8cNkrnRo/6w3c2Vw=;
	b=OZYhRmtER9qKz6bf5/IfacJTHLE4DV0LM4qOTJ3X3IuzgXWG1KAhHha8+MNRCZrpZgHo
	 xe0x39yEF5+HBGbKBP1KsdfgP8+HhVVdJulwSrsmWpqY11lj0u9o8MQ5V3eqiMfca3+XM
	 3SSC86h/L6cOPjktWdeySnjLt5U7EaO/ozjQhxMKggvSIZLijIr/f+xiSegUWgCvH0wl6
	 hZo2J+3bcBageUibHWWmnEeRFA651hWHJJh2h5NKZjYRgXRHLy/Ve4olTPoLbzkBytr+k
	 ysbplmR3LT5VIKWxFeILUPm+lWjgT6n/Lifs76MswzmQs9mbakWtkYO0oiatO+CjVfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5i+RWJg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C9606A31A
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Oct 2026 06:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n5i+RWJg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419291F01825;
	Fri, 23 Oct 2026 06:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792735261;
	bh=wTuI00BBLubFkushCOqbi8y9KzW8cNkrnRo/6w3c2Vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n5i+RWJgpelq+X7CRYKvwCMK2JOKDD4o62O3Qlmxvyw+QnWVUCLa52H5IyX4zbFZM
	 ixArlpGJcsJi687bFwse7SGp4qblqWqrzmIwZbzE2/hgMoNyS/LxA2SYHHCggER92G
	 Ucrk54Uz47wlc7jsYZlBgs3d8GMQrSBxjk9pGTOvkXArHcUS0A3bFNGbyin0ElSWVG
	 6Fgb2auUp1ttvGkVjvuHe371Bc3iVgYaYQwwZ6zmhErQJYKBrmRGn9BIbiZFW/QUEK
	 AO2WYHnPxJUKAVJXVUPPqZ7Q6ciu9eUtsNjzS9F4r7fn7wBzVA95bdxROXOCkL+01X
	 iTsprWHTrpIhg==
Message-ID: <sashiko-outbox-182336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] perf test: Test perf timechart --live
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261023054952.2503540-3-irogers@google.com>
References: <20261023050207.2449976-1-irogers@google.com>
 <20261023054952.2503540-1-irogers@google.com>
 <20261023054952.2503540-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 06:01:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf test: unprivileged failure in test_no_events() due to syste=
m-wide -a
--

commit a678a998e849226efd51ba949028c49bad18c75e
Author: Alice Rogers <alice.mei.rogers@gmail.com>

perf test: Test perf timechart --live

This commit extends test_ttimechart_python.sh to test --live option
validation, LiveRecorder's perf record subprocess, synthetic live UI
behavior, and live workload recording.

> diff --git a/tools/perf/tests/shell/test_ttimechart_python.sh b/tools/per=
f/tests/shell/test_ttimechart_python.sh
> index 87b91ed8fc167..c03e71b68991c 100755
> --- a/tools/perf/tests/shell/test_ttimechart_python.sh
> +++ b/tools/perf/tests/shell/test_ttimechart_python.sh

[ ... ]

> @@ -115,6 +145,43 @@ test_no_events() {
>  		err=3D1
>  		return
>  	fi
> +	# Exercise LiveRecorder's perf record subprocess, control pipe and
> +	# -o output file using task-clock when tracepoints may be unavailable.
> +	rm -f "${clockdata}"
> +	if ! "$PYTHON" - "${PERF_BIN:-perf}" "${clockdata}" \
> +		"$(declare -f workload); workload" > "${output}" 2>&1 <<'EOF'
> +import asyncio
> +import os
> +import sys
> +import ttimechart as tc
> +
> +async def run() -> None:
> +    rec =3D tc.LiveRecorder(sys.argv[1], False, False, ["bash", "-c", sy=
s.argv[3]], sys.argv[2])
> +    rec.events =3D lambda: ["task-clock"]
> +    rec.start()
> +    app =3D tc.TimechartApp("live", False, False, [], live=3Drec, window=
=3D5.0)
> +    try:
> +        async with app.run_test(size=3D(120, 40)) as pilot:
> +            await pilot.press("space")
> +            await pilot.pause(0.1)
> +            await pilot.press("space")
> +            for _ in range(300):
> +                if app.return_code is not None:
> +                    break
> +                await pilot.pause(0.05)
> +    finally:
> +        rec.stop()
> +    if app.return_code !=3D 1 or not app.data.nr_samples or not os.path.=
getsize(sys.argv[2]):
> +        raise RuntimeError(f"Unexpected result: rc=3D{app.return_code} s=
amples=3D{app.data.nr_samples}")
> +
> +asyncio.run(run())
> +EOF
> +	then
> +		echo "ttimechart no events test [Failed: LiveRecorder task-clock test]"
> +		cat "${output}"
> +		err=3D1
> +		return
> +	fi

[Severity: Medium]
Can this cause test_no_events() to fail instead of skip when run by an
unprivileged user on a machine with the default kernel.perf_event_paranoid
setting of 1 or 2?

At the start of test_no_events(), the permission check runs a per-task
recording without -a:

tools/perf/tests/shell/test_ttimechart_python.sh:test_no_events() {
	if ! perf record -e task-clock -o "${clockdata}" -- true > /dev/null 2>&1;=
 then
		echo "ttimechart no events test [Skipped: perf record failed]"
		return
	fi
    ...
}

Because that check opens a per-task software event, it succeeds for
unprivileged users under kernel.perf_event_paranoid =3D 1 or 2.

However, LiveRecorder.start() unconditionally passes -a for system-wide
recording:

tools/perf/python/ttimechart.py:LiveRecorder.start() {
    ...
            cmd.append("-a")
            if self.workload:
                cmd +=3D ["--", *self.workload]
    ...
}

When kernel.perf_event_paranoid > 0 and the user lacks CAP_PERFMON,
system-wide perf record -a -e task-clock fails with EACCES via
find_get_context() -> perf_allow_cpu(). That leaves app.data.nr_samples
and the output file empty, raising RuntimeError and setting err=3D1, which
causes the script to exit with 1 (failure) rather than 2 (skip) when
record() subsequently skips.

Should the LiveRecorder task-clock subtest check whether perf record -a -e
task-clock is permitted before running, or only run when system-wide
recording is available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023054952.2503=
540-1-irogers@google.com?part=3D2
