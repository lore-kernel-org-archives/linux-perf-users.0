Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EAE47B408
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760355; cv=none; b=PZvBy/yS1Cexfmin6J48vYkd9lkvNwTWRKqTg+nhVapoS/K2JLQW4STTMCsI07MQbTf19tbXoq9QHrigCKZO8a4hEv1cfT8Gi2BluZUWjB07ShRMJirGjzQy+WpUEqXCXTd7wVbf9trMwGx8GD8PLctNzU/VYJ+MMKuwshb8m8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760355; c=relaxed/simple;
	bh=RwKPplzEA9O92nBIpnN0M7vEx65XebjmJJnt4CLsWEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZC7er0mQZ1F0XDW0u5DkxyNlcakr6lF/NiY7jAIIf03ATAdDfDrMNkOMI4jAi587akNQroHQc7hDb4564q9lHchDdVHk2oNO64v2ECBKFcdrUV/liqOQao0L8D4zBP6CjawXrhfSpC1rebKGokTPN/cAnyZu1AXYDaH9V82cALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyax9bcm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyax9bcm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819B61F00893;
	Wed, 30 Sep 2026 09:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790760353;
	bh=Z2gucyO8eIsAWhS/g+94Yz5GEGmF66YQLxNCf7oWXmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oyax9bcmaG8SgB9+hGrlmChPt/tRtr7bmALAEw6sELbPlZ/K1ExWHrUcOPkgsZK8J
	 qYFTtdqWuZ4tAjMIPhTn10WRrYGcldes25nknVWRE1z8gGcgMLXZIEFNSSm2absk7e
	 mTgnog8qNcWDFliDs0WzEJ4ba7dxFwdO5TT1Fs5lccx2Czu2GFsOBJqiphicxaMMVY
	 H5T/8jr70j8txKRGNA+1ONFK3HmZMpFJsRS5X0DQIsCIhNBOR2PUsw2szwiMc5hXy3
	 kTX3WKk5GN6smlLP5hCMInunv1gc7a7feUOFRRwo6sZgO5CRw4Uz//t/bdKSWuye/m
	 js+vpTB4hdMSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf bench: Add atomic CAS benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changbin Du" <changbin.du@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260930091617.4189736-1-changbin.du@gmail.com>
References: <20260930091617.4189736-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 09:25:53 +0000
Message-Id: <20260930092553.819B61F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf bench: 32-bit integer overflow computing runtime in worker()
- [Low] perf bench: missing stdbool.h inclusion for false in worker()
--

commit 37bbeabb11e8b0698696e276ba97886862aa6887
Author: Changbin Du <changbin.du@intel.com>

perf bench: Add atomic CAS benchmark

This commit introduces a new atomic collection to perf bench for measuring
the performance of compare-and-swap (CAS) operations. It evaluates
multi-threaded contention to help identify latency and scalability patterns.

> diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> new file mode 100644
> index 0000000000000..ce97025018ab3
> --- /dev/null
> +++ b/tools/perf/bench/atomic.c

[ ... ]

> +static void *worker(void *arg)
> +{
> +	struct worker_stats *ws =3D (struct worker_stats *)arg;
> +	struct timespec tstart, tend;
> +	u64 i;
> +
> +	pthread_barrier_wait(&start_barrier);
> +
> +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> +	for (i =3D 0; i < iterations; i++) {
> +		u64 old_val, new_val;
> +
> +		do {
> +			old_val =3D __atomic_load_n(&shared_counter,
> +						  __ATOMIC_RELAXED);
> +			new_val =3D old_val + 1;
> +		} while (!__atomic_compare_exchange_n(&shared_counter,
> +						      &old_val, new_val,
> +						      false,

[Severity: Low]
Does this file need to explicitly include <stdbool.h>?

The POSIX guidelines for perf tool compatibility with musl require files us=
ing
POSIX constants like false to directly include the headers where they are
declared. Relying on implicit inclusion from other headers can cause
compilation failures.

> +						      __ATOMIC_RELAXED,
> +						      __ATOMIC_RELAXED));
> +	}
> +	clock_gettime(CLOCK_MONOTONIC, &tend);
> +
> +	ws->runtime_ns	=3D (tend.tv_sec - tstart.tv_sec) * NSEC_PER_SEC +

[Severity: Medium]
Can this runtime calculation overflow on 32-bit architectures?

When compiling for 32-bit platforms where time_t is a 32-bit signed integer,
tv_sec is also a 32-bit signed integer. Since NSEC_PER_SEC is defined as
1000000000L (which is 32-bit signed on 32-bit platforms), the multiplication
is performed as a 32-bit signed integer operation.

If the time difference exceeds 2.14 seconds, the result wraps around before
being converted and assigned to the u64 runtime_ns field. Given the default
iterations take around 7.3 seconds based on the commit message, wouldn't th=
is
guarantee an overflow during a native 32-bit run, leading to incorrect
benchmark results?

> +			  (tend.tv_nsec - tstart.tv_nsec);
> +
> +	return NULL;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930091617.4189=
736-1-changbin.du@gmail.com?part=3D1
