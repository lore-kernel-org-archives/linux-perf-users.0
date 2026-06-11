Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2422FFFBE;
	Thu, 11 Jun 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190542; cv=none; b=cwHg6zmIS6kVgcHcSJdoGvBaZMtyqzmbtYMUkBKR7RjBKq7JH2o5M7dqkgDrJFq0tFgi/X054+fuZG5u9GSvE5CPRpulPGWICyqn3eiMWRraUS78LUq/cxvuaVlOdRklMc0E+k8pYynLJv7rLgrR1cPQRylOAS4DaI0oVLFWxj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190542; c=relaxed/simple;
	bh=u8Z1HwVQ6gNZfFbrHvWxvraaKsKvFg1yRaKyVTFkyd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cnOcLe4T5Pqp9Ix0jNWmtKnbYeY7o0x95TmTDpQp7/ixbBHJV1jKzdnZ4ETFRpp1P4zcrcRn8lxMAgyNgG2aqnGhoE8m+Vt6u0Xfg21GPK4hZ5Nkq7Cd+syxfLKxGg8qBrW5JdmF+dOi0dfK6icxXfiE41G4mJhytpZEy7av8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5FSZVvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5FSZVvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2C91F00899;
	Thu, 11 Jun 2026 15:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781190541;
	bh=0uRLPyI0GfrqF0p32ngwFu1PHDAcTSIvRXBHRBkO/M8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=b5FSZVvrzfSoSkhd43JnNH9Cw0vj4H5/nANqbIs3pzPcAwkdKmWVfaYoyRIM7gGVm
	 Q8NzYCyXX25Y//naJrf72k7zruYA6BxItvzYO7utF4hv+2yRqlLEpuuWxhuVVMwNGQ
	 6q1v5onmVgNbJKFerODwmrNHlEorUSkB4Z9Yh27tkX8pxbKbUXN44Li9NVVrvwe3wW
	 7VS8L8nqCaGyTB7WPg9X8CKZs/NxqLkzNG/zbQAsSc8IWyF9fivxWYIYyYumZrjExu
	 qtT471kIMBDNfSIhwxHyKrKYp2QZaUbPjTfCp9LkyKuZfq17VPDamg2GWdGDiM+AzA
	 c9r0Cz3pSxd8Q==
Date: Thu, 11 Jun 2026 12:08:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Compile named_threads workload with -O0
Message-ID: <airPimFmTCute2PT@x1>
References: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-james-cs-unformatted-per-thread-fix-followup-v1-1-3c855d93dba8@linaro.org>

On Thu, Jun 11, 2026 at 12:13:46PM +0100, James Clark wrote:
> The work loop relies on the compiler not optimizing it away, although
> named_threads_work is not static for that reason, the compiler could
> still do it.
> 
> Fix it by compiling without optimization. Also add -fno-inline for
> consistency and in case anyone wants to look at callstacks.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> One trailing Sashiko fix from the "perf cs-etm: Queue context packets
> for frontend" patch series that has been applied already.

I'll add a Fixes tag pointing to that cset, also a reported-by sashiko
and a closes, for completeness.

Thanks, applying.

- Arnaldo

> ---
>  tools/perf/tests/workloads/Build | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
> index 75b377934a0e..7bb4b9829ba2 100644
> --- a/tools/perf/tests/workloads/Build
> +++ b/tools/perf/tests/workloads/Build
> @@ -26,3 +26,4 @@ CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_traploop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
>  CFLAGS_inlineloop.o       = -g -O2
>  CFLAGS_deterministic.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> +CFLAGS_named_threads.o    = -g -O0 -fno-inline -U_FORTIFY_SOURCE
> 
> ---
> base-commit: 7336514f41e75d44782fee7e0990d4195a3d3161
> change-id: 20260611-james-cs-unformatted-per-thread-fix-followup-babf28a4e640
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
