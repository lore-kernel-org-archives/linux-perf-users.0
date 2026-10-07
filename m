Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEE3347BD4
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Oct 2026 05:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791351564; cv=none; b=EvdMRgrDqTuJl9hGKCdfMJEKMtCjnbhyx5utfoIVeXwVB84vEWj7JThMYnjnI0fo89dBCo5T92Loar6RdqRwEJTVBMhhZbJ+/a32jCEowAI30h/774xXBgB2bS3fpJJOMoTMs8XSHOuqzxr3Jnsaq7pRYtvr5nKYyBmj6+TcJTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791351564; c=relaxed/simple;
	bh=5mE/0JTR3VQJK/BuK7WXqkhHALhtkg3MZGtmXtbQl04=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=CD8aaX67OZl4ZNGsx8tGRzUwUHgHNkJDnKLgsz+NAKALA/zpe5ZOsUdeOKb/x4AaFufR0RDLrLj2eUsQnRwi87Gv7QMavuR9kf8Jtkwvfzb8if29QysDn+f4wS5F5d8pihX8gJd/gul+wfDNJH+hmgqV8B/V+dt8IFsxycNovVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efMEapnD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efMEapnD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F42C1F0089B;
	Wed,  7 Oct 2026 05:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791351562;
	bh=ugmkdA8z2G33qQ2cyhRPyqmtgm0ZVZy17JFhD9JbYcI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efMEapnDpVMneRZztPjh07Zy1wQt7i3dN2JFSdI4IunBqKS87bDksGO1FqFd3Kis9
	 RgTViI4A/oMdNc1Edzk1F7D3aerPUDqyt9ZhuqvO4XPXc+CCiuuDR61GOxfi9qlazd
	 rB8cHi7GKZMzM0M9xj0D5HLZ+u4Xwvk8jnooQmV2N71Kw/uAnWaU+uTx3g/yOUmzDB
	 WEyw3bTyXReqCzrBJQNOtI08l7MVB/JKdu+Rq1bH1S4P47Pko4orNSZlRpzmuRrioa
	 21WombUxs+tNFzc/vIl0XbXVqhdZibOK3yxGAhMdJ6aXAsdP57NZrRJ1WdULLh1oll
	 bQWoKEJB01u/A==
Message-ID: <sashiko-outbox-162645@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf bench: Add atomic operations benchmark
Reply-To: sashiko-reviews@lists.linux.dev
To: "Changbin Du" <changbin.du@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261007053027.1738402-1-changbin.du@gmail.com>
References: <20261007053027.1738402-1-changbin.du@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:39:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf: 64-bit atomic builtins on u64 cause link errors on 32-bit
- [Low] perf: Missing explicit inclusion of <stdint.h> for UINT64_MAX
--

commit 1f5903d48b4529edce94275c5756879218402332
Author: Changbin Du <changbin.du@intel.com>

perf bench: Add atomic operations benchmark

Add a new atomic collection to perf bench for benchmarking atomic
read-modify-write operations with multi-threaded contention testing.

> diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> new file mode 100644
> index 0000000000000..08497910b563f
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
> +	switch (bench_op) {
> +	case OP_CAS:
> +		for (i =3D 0; i < iterations; i++) {
> +			u64 old_val, new_val;
> +
> +			old_val =3D __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);

[Severity: High]
Does the use of 64-bit atomic builtins on a u64 variable in worker() in
tools/perf/bench/atomic.c break compilation on 32-bit architectures?

Without 32-bit fallback definitions or omitting 64-bit atomics entirely,
calls like __atomic_load_n, __atomic_compare_exchange_n, and
__atomic_fetch_add on the shared_counter might generate unresolved
__atomic_*_8 library calls on 32-bit systems.

> +			do {
> +				new_val =3D old_val + 1;
> +			} while (!__atomic_compare_exchange_n(&shared_counter,
> +							      &old_val, new_val,
> +							      false,
> +							      __ATOMIC_RELAXED,
> +							      __ATOMIC_RELAXED));
> +		}
> +		break;
> +	case OP_INC:
> +		for (i =3D 0; i < iterations; i++)
> +			__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
> +		break;
> +	default:
> +		break;
> +	}
[ ... ]
> +static void print_default_format(struct worker_stats *wstats,
> +				 struct stats *time_stats)
> +{
[ ... ]
> +	/*
> +	 * Per-thread statistics from the last measured repeat show
> +	 * fairness / imbalance in CPU scheduling.
> +	 */
> +	if (threads > 1) {
> +		u64 min_ns =3D UINT64_MAX, max_ns =3D 0, total_ns =3D 0;

[Severity: Low]
Does the usage of UINT64_MAX in print_default_format() in
tools/perf/bench/atomic.c require the explicit inclusion of <stdint.h>?

This might violate strict musl compatibility header guidelines, which requi=
re
explicitly including <stdint.h> for this constant.

> +		double min_thru, max_thru, avg_thru;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053027.1738=
402-1-changbin.du@gmail.com?part=3D1
