Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794467967;
	b=WfXS3T0Jc7C2OfHGQaNJEnKT1ZgHqWp4PxdBDOgmj62p7t/V+O7TeVJeMfgWzhb86gpw
	 adJBODcyC2onG5CrLa3t1HOugij+95uVD/TsG828OdoASglVx8bEjG8MlHOSvzaRq/5ub
	 cJIapPOmnn4cdk0cg5ya95gv8LEz/PShLrxoGlOSQtZ7zl4KXTBo6a8M+dYbVuyzfvznc
	 eYcIrVhd7ud6PRZf3zQDfjtEJOzG7eM29lIVgXGXyg6LQ/GP4wXGGFiD/2N239FOo6ftK
	 zgXrbWQ+qefu1x8n/01K3ab57hiGrL4fP+0r+tz3QcC0xKlZJboPNCpse/k950qQInw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9vEwfFNJsQC0uguVeCiGQZL5IYwoymuj63dcnWgCJ+g=;
	b=QMY+RowEYhkuty8dvsyH7zlkIBvQpr0E30mDb+js+1HPol7zMdh3DUlJm7Bqi+zSVZc2
	 lB5jMUNidpci6Rys7BgndHWRMVDuztuFqSiH6UDoXz7GiZJAav0GdvPx4GhTt0YNJRwZR
	 S35ZRb5JU9sevT3DI81cHCdEGvhNJeJmJboBbKn3hLhKEBYhj3pr6Rj4+WQCe0XenRaGz
	 8ifU4iSGeVfj8/rt7nCo8CTV7adg3v3sReFIUvkEPOZ1TSCRyf46yeBRObY+e9EWzxwOG
	 tYVNTOs7OIC/cOpK3KMypcsrSYmln/OB9psz2s2Vr8YGqp3BgwOtow9TvIaaj8eyDXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enn33zGw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EF5606A8AE;
	Thu, 12 Nov 2026 07:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enn33zGw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4186A1F00A05;
	Thu, 12 Nov 2026 07:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794467966;
	bh=9vEwfFNJsQC0uguVeCiGQZL5IYwoymuj63dcnWgCJ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=enn33zGwSWs4juikjM58M5TOzQy8iWqVwJ9T4frJw8aqptfjK/FpSS5U86XVM+PHW
	 JLMKnoHtxaNfjpDqNvftr3XU+8K4802anqoyYbA2+HNCou12HjOMyNE4SYiQIIkhnp
	 bNEzZwyIxU/ibauEfU5+xOw3/nzT2dMH/VkS96JO0AoaoBLa5pLIK0/HsNKts8+MLR
	 SUsPnyXv0ixm2uH9gpW/daTQnf4KJqMgyQLW1OaPF4czIg+rK2SqLiKqVquzAm3jH5
	 jAF+2eiApCuBdmn4sPZ5zTWqRuTLon8w2nt/nHeBFk6nnKAke/oUBndFKYLYZkxGRB
	 50KRJNgiUs+eQ==
Date: Wed, 11 Nov 2026 23:19:23 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, bvanassche@acm.org,
	elver@google.com, james.clark@linaro.org, jolsa@kernel.org,
	justinstitt@google.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	mingo@redhat.com, morbo@google.com, nathan@kernel.org,
	ndesaulniers@google.com, peterz@infradead.org
Subject: Re: [PATCH v12 15/20] perf intel-tpebs: Fix race in tpebs_stop() and
 tpebs_cmd.out fd handling
Message-ID: <avVoe_hajXqJpfmq@google.com>
References: <20261111174213.3526604-1-irogers@google.com>
 <20261111174213.3526604-16-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111174213.3526604-16-irogers@google.com>

On Wed, Nov 11, 2026 at 09:42:07AM -0800, Ian Rogers wrote:
> In tpebs_stop(), read tpebs_reader_thread into a local variable before
> releasing tpebs_mtx to call pthread_join().
> 
> Transfer ownership of tpebs_cmd.out to __sample_reader() by passing it
> as the thread argument and setting tpebs_cmd.out = -1 in
> evsel__tpebs_open() so tpebs_stop() does not double-close the fd closed
> by perf_session__delete(). Also reset tpebs_cmd.pid = 0 and
> tpebs_cmd.out = -1 and return early if start_command() fails in
> evsel__tpebs_start_perf_record(), as start_command() closes the pipe
> internally and may leave cmd->pid = -1 on error.
> 
> Serialize tpebs_send_record_cmd() with teardown via tpebs_cmd_in_flight
> and tpebs_cmd_cond, newline-terminate control commands so consecutive
> writes cannot coalesce in evlist__ctlfd_recv(), check
> check_if_command_finished(&tpebs_cmd) under tpebs_mtx only when not
> stopping, ignore late samples in process_sample_event() once
> tpebs_stopping is set, and guard evsel__tpebs_open() against a
> concurrent tpebs_stop() with tpebs_gen, tpebs_enabled, and
> tpebs_stopping across closing the fds and finish_command().
> 
> Include <pthread.h>, <signal.h>, <stdint.h>, <stdlib.h>, <string.h>, and
> <unistd.h> explicitly.

I feel it's too verbose and not clear what's problem.  Please explain
the race and how it fixes the issue concisely.

Thanks,
Namhyung
