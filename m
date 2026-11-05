Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887258;
	b=ld4U7kEBCwbPoH+vjP47oEj5yNX6QPBJJ1hf9a1ryKfWlxPh39qoYcuX7WKbJgNntVdC
	 3HjQzPiDbIq7ODuORQinlyz58ceiJiB7/yoMSGlmt/W9e19lYEaPQpfx9PLY30r/9Izyt
	 ey4phqs+O24wixEvCzRtlt6c+GIgXklbFOSDhVDhPd5HvS1ArOdXU10aw4nIT4gKIp/dJ
	 vXlMCO+f4+kONI88PUMjXOkUiiuXv9VKsVWpTO312f1mteScalBKfiPuGNGsAnTH6ItHt
	 etIYowJY8MolD1dcSDlUFdXU1cf5cOg+6wk/bShcR9LyZEqB8u6S8/eAb9akPs7pn4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AFtSFdARdPPcS/3x5aoTggQamZAfQpvrV/meaUApL+I=;
	b=eIFrmMgPEo6lyF46h0In9k6pQi0iTfaBViCGj7Q/Kkl4VAM3fJnjvqJK65tvSPxiRang
	 Jy25s4QdADu7ZsmGlEmEr2FUuTxdzRP+WniVcfz0bgB990cAGPtvzXfu73NS851RudOc6
	 wiAGHeXZ4FsWUcMIEBfBt7ibTFnX7Ej6QraozsDMjBguXQ7zXVPYP68jzg+qNkVsF67CZ
	 zTTae6batNHHcp7vK17f3Pkg43qKPHU6/FCaWBKin7l2l/UesKT5e+TnyVqrPXmAr6UXB
	 me4++19FfZeP4UvnSKw8V+qCDulmR6HHIY7VBbY9F57/UbpYv9Ed4niodBzC+XMsJ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6ckcMcO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29309606A326
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a6ckcMcO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8679A1F00919;
	Thu,  5 Nov 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793887257;
	bh=AFtSFdARdPPcS/3x5aoTggQamZAfQpvrV/meaUApL+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a6ckcMcO7cTLhekhAL7LjcDwjkUvAszaKeuZspgrYEyzV/Jh3Acug6DjBoebhlqT8
	 Qr6rzXOuTwZb5a8Ypz4S0k0SHImyPDoShneRMh4lEw6JjK9X72I5Mre9AhfGo/96bK
	 Q/Zo8te32+ru+kkRuoezZpgQneCM3TGk0gGh2nAfwgh66F7neqjFZOtev0RHRDlhM2
	 PqtAPFPCKN6OegMIoyfTvbJG8biA0n1hchKEuIT9+5r14IHBxmVU8UsPkjoXDi2G1v
	 oFMiXiJq3wRxk4+XeWbPIXNGIcKU01JRJoz80x7g9k4/kOB8UKJ4UHudn3niH8c538
	 yTTbD2ju4Xjtg==
Message-ID: <sashiko-outbox-199183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/19] perf test: cs-etm: Test multiple per-thread
 threads
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261105-james-cs-unformatted-per-thread-fix-v4-18-7759e0ce2449@linaro.org>
References: <20261105-james-cs-unformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org>
 <20261105-james-cs-unformatted-per-thread-fix-v4-18-7759e0ce2449@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:00:57 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf test: cs-etm: unguarded kill in cleanup_files() aborts unde=
r set -e
- [Medium] perf test: cs-etm: unsynchronized perf record startup and thread=
 wait loop
--

commit a1c04dea71b5f9bb657ac0b302a38c803f86b131
Author: James Clark <james.clark@linaro.org>

perf test: cs-etm: Test multiple per-thread threads

This commit adds a shell test for CoreSight per-thread tracing across
multiple child threads on systems with TRBE sinks. It spawns the
named_threads workload, attaches perf record in --per-thread mode, and
checks that perf script output includes samples from all child threads.

> diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools=
/perf/tests/shell/coresight/per-thread-multi.sh
> new file mode 100755
> index 0000000000000..bace76cb6a510
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/per-thread-multi.sh
> @@ -0,0 +1,76 @@
> +#!/bin/bash -e
> +# CoreSight per-thread multiple threads (exclusive)
> +
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# If CoreSight is not available, skip the test
> +perf list pmu | grep -q cs_etm || exit 2
> +
> +if ! tmpdir=3D$(mktemp -d /tmp/perf-cs-per-thread-multi-test.XXXXXX); th=
en
> +	echo "mktemp failed"
> +	exit 1
> +fi
> +
> +cleanup_files()
> +{
> +	if [[ $parent ]]; then
> +		kill -9 $parent
> +		wait $parent || true
> +	fi
> +	if [[ $perf ]]; then
> +		kill -9 $perf
> +		wait $perf || true
> +	fi
> +	rm -rf "$tmpdir"
> +	trap - EXIT TERM INT
> +}

[Severity: Medium]
As reported by Sashiko on v3 [1], because the script runs under
#!/bin/bash -e, errexit remains active inside cleanup_files(). Later in
the script:

    kill $parent
    wait $parent || true
    unset parent
    wait $perf
    unset perf

If the background perf record process fails and exits with a non-zero
status, wait $perf reaps the process and triggers an immediate shell exit
before unset perf runs, invoking cleanup_files() via the EXIT trap while
$perf is still set. Inside cleanup_files(), kill -9 $perf fails with ESRCH
because $perf has already exited and been reaped, aborting cleanup_files()
before rm -rf "$tmpdir" can remove /tmp/perf-cs-per-thread-multi-test.XXXXX=
X.

Similarly, if $parent exits unexpectedly before unset parent runs, kill
$parent fails and cleanup_files() aborts at kill -9 $parent before killing
$perf or removing $tmpdir.

Should kill -9 $parent and kill -9 $perf in cleanup_files() be guarded with
2>/dev/null || true?

[ ... ]

> +# Launch 2 threads to run indefinitely
> +nthreads=3D2
> +perf test -w named_threads $nthreads 0 &
> +parent=3D$!
> +
> +# While parent still exists, wait for the 2 children to spawn
> +while kill -0 "$parent" 2>/dev/null; do
> +  threads=3D(/proc/"$parent"/task/*)
> +
> +  if (( ${#threads[@]} >=3D $(($nthreads + 1)))); then
> +    break
> +  fi
> +
> +  sleep 0.1
> +done
> +
> +echo "Recording..."
> +perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,128K --pi=
d $parent > /dev/null 2>&1 &
> +perf=3D$!
> +
> +sleep 1
> +
> +kill $parent

[Severity: Medium]
As reported by Sashiko on v3 [2], could this startup and thread wait sequen=
ce
cause flaky failures or hangs on loaded systems?

When perf record --pid $parent is started in the background, sleep 1 runs
immediately in parallel with perf record initialization. In
tools/perf/builtin-record.c, __cmd_record() opens cs_etm//u and dummy:u in
the disabled state in record__open(), performs synthesis in
record__synthesize() (including CoreSight sysfs reads, BPF synthesis, and
/proc task and mmap synthesis), and only enables the events at
evlist__enable(). If initialization takes most of or longer than the 1
second sleep window, kill $parent terminates the workload before
evlist__enable() or before both threads are sampled, causing the grep check
on "$tmpdir/script" to fail.

Additionally, the /proc/"$parent"/task/* polling loop has no timeout if the
children fail to spawn, and breaks as soon as clone() creates the task
directories, before the child threads have necessarily called
pthread_setname_np() in tools/perf/tests/workloads/named_threads.c. If
pthread_setname_np() runs after __machine__synthesize_threads() reads
/proc/$parent/task/$tid/status but before evlist__enable() enables dummy:u,
the PERF_RECORD_COMM event can be missed.

Would it be more reliable to use wait_for_threads() and
wait_for_perf_to_start() from tools/perf/tests/shell/lib/waiting.sh, or pass
sleep 1 as the perf record child workload so evlist__start_workload() runs
it only after evlist__enable()?

[1] https://lore.kernel.org/r/20261102-james-cs-unformatted-per-thread-fix-=
v3-18-dbcb0c281b9b@linaro.org
[2] https://lore.kernel.org/r/20261102-james-cs-unformatted-per-thread-fix-=
v3-18-dbcb0c281b9b@linaro.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-james-cs-u=
nformatted-per-thread-fix-v4-0-7759e0ce2449@linaro.org?part=3D18
