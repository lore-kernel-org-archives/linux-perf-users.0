Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623259;
	b=jjkQl8dajS8NE4J+iO5+SMqz3KC20jsRSLi5IUyBMKWzhLBhtZhmjA7471CkqTemBdSl
	 p33MZa2hNeNg826mmgTo0BMpbXKDL0I+KOtiFaRM/4lQtlC2oe4LqNWjW9N7czNq43Pbf
	 iQ51sRJfnfmlWl3BoSXyouBogrndsdM9SFvC6H3uceZDSuFj9E3p4ZdmVkUwOuHGoXQvU
	 99sXdvjfYbqqFRnmXLB/tAiM6z8A5kAq+rRnqER/j4gPsa6quCYrUTwRiZYduRGmRLVPi
	 dghg2N99ITqAE1JD7edM+hajJngQ53/oWzUGqA6mKVEmATv/eRlMg6ZHMr8Yz3O1n7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623259;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yqWJ3K/q9a6DjSYaKg4T0oP6lH+uQTqzjcwFUtRNPuE=;
	b=wWfA2JofQp1bJRgvg3fL0kUraO7OFBoD2T5ZPxrkra4Ljq8o5/ug6ltAqnvsQo4s8ZuS
	 nquMtJiFp3YX4L513v5E0kuEX4FAOZUH4p0k/pRerCyqXPr5jtPy465uKoSW+jKU3pF1k
	 X7dolL0npocpVgjNIvABdYX6unffIsbAvS+u3m7OyiFdZRTPqDJkEp29N1M5AXHgz/mcp
	 vAvaVQNhtTlBK5v1soOfJLKIuX92OLtmuAfl9q1+7PKV0VQPrqzqiwlx9SzrNLUjZOpPQ
	 zPLkKvlRjLif5BPi9uEEuLdgI9uy1nt1FGNabR1islb2NRpPbNYp6vsDt56ktwX+Akw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2yYVd+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA7606A332
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 12:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A2yYVd+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3021F00A1B;
	Mon,  2 Nov 2026 12:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793623258;
	bh=yqWJ3K/q9a6DjSYaKg4T0oP6lH+uQTqzjcwFUtRNPuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2yYVd+FAOcJxm4XY/yhn+gJN3iZaPSkLPSXVtsQe+1RQGWiQBGUjERIlv1mBfi9j
	 +yQkTjKRhouu0lcXBfXf+cdVFsQ/ciWOncoYRWeLhgyf2cXMTQccIAZGrFv379C9Nj
	 QxoCGCBIodwabuD7VAboMlwPaM6TEfZEmbPTBzLLrsTCkXNs13D1O+FLF1FbGL07Zm
	 0Tlux9h//GLwe8LvQNI9LXJaU6/cmFpjLo0F2RTO8bes6+TbJvF7MjIhZ4ggdVTfCK
	 mWOI/uvtlxIqAEzY1WjoS6ga6d6f1Fq/u7d890BEOcjFMNDskwnp71zQujCosuqjQU
	 JeAxcKN2TpKuQ==
Message-ID: <sashiko-outbox-193438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/18] perf test: cs-etm: Test multiple per-thread
 threads
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-18-dbcb0c281b9b@linaro.org>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-18-dbcb0c281b9b@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:40:55 +0000
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
- [Medium] perf test: cs-etm: unsynchronized perf record startup and wait l=
oop
--

commit 6aa8bbe9530a4ed93f2099e972a4b1384053a19f
Author: James Clark <james.clark@linaro.org>

perf test: cs-etm: Test multiple per-thread threads

This commit adds a shell test for CoreSight ETM with TRBE sinks that records
a workload with multiple child threads in per-thread mode and checks that
samples from all child threads are present in the decoded trace.

> diff --git a/tools/perf/tests/shell/coresight/per-thread-multi.sh b/tools=
/perf/tests/shell/coresight/per-thread-multi.sh
> new file mode 100755
> index 0000000000000..c6bf1ff2e53d1
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
Can cleanup_files() abort before removing tmpdir or killing the remaining
process when the script runs under #!/bin/bash -e?

Later in per-thread-multi.sh:

    kill $parent
    wait $parent || true
    unset parent
    wait $perf
    unset perf

If the background perf record process exits with a non-zero status,
wait $perf reaps the process and triggers set -e exit before unset perf
runs. When the EXIT trap enters cleanup_files(), $perf is still set to the
already-reaped PID, so kill -9 $perf fails with ESRCH and aborts
cleanup_files() under set -e before rm -rf "$tmpdir" runs.

Similarly, if $parent exits early before unset parent runs, kill $parent
fails under set -e and cleanup_files() aborts on kill -9 $parent before
killing $perf or removing "$tmpdir".

Should kill -9 $parent and kill -9 $perf in cleanup_files() be guarded with
|| true (or 2>/dev/null || true), similar to wait?

> +
> +trap cleanup_files EXIT
> +trap 'cleanup_files; exit 1' TERM INT
> +
> +# Multiple --per-thread events are only supported with 1:1 sinks/sources
> +if ! ls /sys/bus/coresight/devices/trbe* > /dev/null 2>&1; then
> +	echo "No TRBE sinks, skipping"
> +	exit 2
> +fi
> +
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
> +perf record -o "$tmpdir/data" -e cs_etm//u --per-thread -Se -m,64K --pid=
 $parent > /dev/null 2>&1 &
> +perf=3D$!
> +
> +sleep 1
> +
> +kill $parent

[Severity: Medium]
Could starting perf record in the background and immediately running sleep 1
before killing $parent race with perf record initialization on slower or
loaded systems?

In tools/perf/builtin-record.c:__cmd_record(), events are opened disabled in
record__open(), followed by record__synthesize() (including BPF and auxtrace
synthesis), and only enabled afterward via evlist__enable(). If startup and
synthesis take most or all of the 1-second sleep window, kill $parent can
terminate the workload before evlist__enable() or before both threads are
sampled, causing perf script to miss thread1 or thread2.

Also, the /proc/"$parent"/task/* polling loop above has no timeout and brea=
ks
as soon as the task directories exist, which can happen before the child
threads call pthread_setname_np() in tools/perf/tests/workloads/named_threa=
ds.c.

Would it be more reliable to source tools/perf/tests/shell/lib/waiting.sh to
use wait_for_threads() and wait_for_perf_to_start(), or pass sleep 1 direct=
ly
as the perf record command workload so the 1-second window begins only after
events are enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-james-cs-u=
nformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org?part=3D18
