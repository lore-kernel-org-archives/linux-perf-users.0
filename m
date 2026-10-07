Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E353E7630;
	Wed,  7 Oct 2026 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408968; cv=none; b=CVWtbRQ/OutvSkncf8thJawRZLXHEcn6RvI0B41hDLeLG3QEh4wdR6Q/59XZy9JmGLMVtrsQKyfTiDsJ9yGIwXvfITTUsjO2zw5XFEAMIr5zCTtGWfFXUUHlfwJB074uyyDFWbEyoCGG2fX3YfwfAyHFd9DlKH/Q53tDXAbHmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408968; c=relaxed/simple;
	bh=7OWHUbbAreaRjReg+9z7u9jsBG/lB7rnLGWZYWpF/DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vohg+SCT344mgxPLDNC/sQvHYUvdyuUR+Vc0gFfWQA0Y28xIts0ZAwu4Yw5P3pSMshIHYkxChZN0/qnWuKIs64LgoCMkNhmbUemQS86wYbhzKUjXBANGpKsLqD+aoyPI2O4xI2zRxnjT7bVmYoGp+ufQ2AgR7MkvQDkQJxW0xUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txn1lf8D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txn1lf8D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DA91F000FF;
	Wed,  7 Oct 2026 21:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791408967;
	bh=I2goI4z8jpdm/ispOrWOToXtHmMgBHJXtJzdXoHYtTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Txn1lf8DgipUDwvr5zTQi6EeWR+l465Dn4m99+EYu7q4Hd+eIQNCEk34dhTOafC2C
	 V02DQLdIZQk9CCEWLoHmKLCumpqhAOPtovun7FwlOJEBvTv8wsArb8iEolADVFU38k
	 aEsXLTg733+QPIX3I9VkeHvci5BZf/upsio5gD8Da/VyKukWv6AWXgu468Fcfnp8nf
	 c3EjrFpwnzmz6TfyHSlu7bxLOZlo5RV8AWWj4OYLov8ERxuFEONFlMtGk6qFTmKdYA
	 n+yrgRCuuuIaqAPCyh8C5bhioZXG7/A8vM5B2HGEycZnvOrmxyHZACFo5SR0UiOMMG
	 Out3ARjJWk8qg==
Date: Wed, 7 Oct 2026 14:36:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Changbin Du <changbin.du@gmail.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf bench: Add atomic operations benchmark
Message-ID: <asa7RZ3NNwpogn8M@google.com>
References: <20261007053027.1738402-1-changbin.du@gmail.com>
 <sashiko-outbox-162645@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162645@kernel.org>

On Wed, Oct 07, 2026 at 05:39:22AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] perf: 64-bit atomic builtins on u64 cause link errors on 32-bit
> - [Low] perf: Missing explicit inclusion of <stdint.h> for UINT64_MAX
> --
> 
> commit 1f5903d48b4529edce94275c5756879218402332
> Author: Changbin Du <changbin.du@intel.com>
> 
> perf bench: Add atomic operations benchmark
> 
> Add a new atomic collection to perf bench for benchmarking atomic
> read-modify-write operations with multi-threaded contention testing.
> 
> > diff --git a/tools/perf/bench/atomic.c b/tools/perf/bench/atomic.c
> > new file mode 100644
> > index 0000000000000..08497910b563f
> > --- /dev/null
> > +++ b/tools/perf/bench/atomic.c
> [ ... ]
> > +static void *worker(void *arg)
> > +{
> > +	struct worker_stats *ws = (struct worker_stats *)arg;
> > +	struct timespec tstart, tend;
> > +	u64 i;
> > +
> > +	pthread_barrier_wait(&start_barrier);
> > +
> > +	clock_gettime(CLOCK_MONOTONIC, &tstart);
> > +	switch (bench_op) {
> > +	case OP_CAS:
> > +		for (i = 0; i < iterations; i++) {
> > +			u64 old_val, new_val;
> > +
> > +			old_val = __atomic_load_n(&shared_counter, __ATOMIC_RELAXED);
> 
> [Severity: High]
> Does the use of 64-bit atomic builtins on a u64 variable in worker() in
> tools/perf/bench/atomic.c break compilation on 32-bit architectures?
> 
> Without 32-bit fallback definitions or omitting 64-bit atomics entirely,
> calls like __atomic_load_n, __atomic_compare_exchange_n, and
> __atomic_fetch_add on the shared_counter might generate unresolved
> __atomic_*_8 library calls on 32-bit systems.

Probably it's ok to go with unsigned long.

Thanks,
Namhyung

> 
> > +			do {
> > +				new_val = old_val + 1;
> > +			} while (!__atomic_compare_exchange_n(&shared_counter,
> > +							      &old_val, new_val,
> > +							      false,
> > +							      __ATOMIC_RELAXED,
> > +							      __ATOMIC_RELAXED));
> > +		}
> > +		break;
> > +	case OP_INC:
> > +		for (i = 0; i < iterations; i++)
> > +			__atomic_fetch_add(&shared_counter, 1, __ATOMIC_RELAXED);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> [ ... ]
> > +static void print_default_format(struct worker_stats *wstats,
> > +				 struct stats *time_stats)
> > +{
> [ ... ]
> > +	/*
> > +	 * Per-thread statistics from the last measured repeat show
> > +	 * fairness / imbalance in CPU scheduling.
> > +	 */
> > +	if (threads > 1) {
> > +		u64 min_ns = UINT64_MAX, max_ns = 0, total_ns = 0;
> 
> [Severity: Low]
> Does the usage of UINT64_MAX in print_default_format() in
> tools/perf/bench/atomic.c require the explicit inclusion of <stdint.h>?
> 
> This might violate strict musl compatibility header guidelines, which require
> explicitly including <stdint.h> for this constant.
> 
> > +		double min_thru, max_thru, avg_thru;
> > +
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261007053027.1738402-1-changbin.du@gmail.com?part=1
