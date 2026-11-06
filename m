Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939992;
	b=3bsv9QfwC4lSA2jptBZwbOwP/wSkRGT2D0z+Wgwrfata8whWBew6x1XyQlPo5u36qPoV
	 ilTzqpmPIhh3mf5H6kT/pAuR5dj2I1Ege7rxuR4AoQh6H1yLM0efzR6xIr3vfYy/Qi27j
	 ikSv42HMpT6LfKk3Wjdl9O4zGNNkIx4mSWrOcHK1llJhX1860WG0X/0gPaj5dIjx0gj0R
	 Q1SOXsOLj/aIy86uECev3zXrrqRznccKIrV6/UEe62UURXFFoCedLRCj8UPbkE6PDlVZ7
	 I3aVtZL+AAoAUxG8ex9misBdCTfKSw36vQoY9vb/tsmlJPF61cIn1QH/Gx6JL+ypV2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939992;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U/Wi977Ysi2ECGBIy/Z+NJVhAV3nu6XdPLmQqc6pq8o=;
	b=HqcHrHHyOleAUvKbPT9iaGzFh1rjlG06DQVhKaa6bS/Uq9t0HaapOEoGu/676FqLzzOz
	 rszDKF7X13GyJyyBOAUxHnX5bUeZud8yIVOIWZrX/I5N8ztfqVEYPYMkixA014bZqTmfd
	 4gfdz31CvlCDOCf85lccfCES1nQ4PrNYE4fA905DYb5pPThMACoBHsIVWGEAe+BrQq6Y0
	 JoS5Z9LF7zzXowkJX5wCqjJIl8nmtCKS5YO8oSjyCdNGOIAg09omcJJlWU1N8CuJVGfkm
	 n77McZ59zWxY6qnlq7NO+/s/BOy2PVCVJn5jy+RaL5DEWPDsfSSglvejmWV+nU4tRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxjuamxu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64844606A328;
	Fri,  6 Nov 2026 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxjuamxu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A11F0089F;
	Fri,  6 Nov 2026 04:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793939992;
	bh=U/Wi977Ysi2ECGBIy/Z+NJVhAV3nu6XdPLmQqc6pq8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxjuamxu/BbzGrRfbGhqNBDVjq1VdeXNrwVIyWnGtqby/pUmgz8iy+Qepl3eTKx1X
	 aLLlGpdoN87lppcd03u/AWjkwIw42vRTXXgqeO6+OrCcfYolkQmsqQ1M/+jtKXeGEH
	 lW0q5m5vTeZv3K0C1659IQROqq6LWOZ2GshLgMcl1wH857IkA+VAyOpPvUhCHuN5h1
	 s46Rhsq1bEtsBlpFxDYqUfkWxllcjvhOAo8jD7QHt+yfEwtuhVr+0DVaZMgrNSkBk1
	 UTcuOIx/916ppRqXwVhvsF/Xlh/Xi5zNME1djz98vDCbbzgCfUpsAda8tnCTYg/5Nh
	 DxK617GsBp6yw==
Date: Thu, 5 Nov 2026 20:39:49 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jakub Brnak <jbrnak@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] perf test probe_vfs_getname: Fix missing debuginfo
 detection
Message-ID: <au1aFaHCvXgRWMbJ@google.com>
References: <20261105-james-perf-test-fixes-v1-0-0b279bee5830@linaro.org>
 <20261105-james-perf-test-fixes-v1-3-0b279bee5830@linaro.org>
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
In-Reply-To: <20261105-james-perf-test-fixes-v1-3-0b279bee5830@linaro.org>

On Thu, Nov 05, 2026 at 03:49:05PM +0000, James Clark wrote:
> skip_if_no_debuginfo() looks for the errors that 'perf probe' prints when
> there is no debuginfo in the output of add_probe_vfs_getname(). But since
> commit 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable
> line detected"), add_probe_vfs_getname() returns early without adding a
> probe if 'perf probe -L' doesn't find the line, which is also what
> happens when there is no debuginfo. The error from 'perf probe -L' is
> discarded, so the debuginfo errors are never found.
> 
> This causes the debuginfo dependent subtests of the
> "perftool-testsuite_probe" test to fail instead of being skipped on
> kernels without debuginfo, because test_adding_kernel.sh calls
> skip_if_no_debuginfo() unconditionally. The other users only call it
> when add_probe_vfs_getname() returns 1, so they aren't affected.
> 
> Fix it by doing a dry run of a probe that needs debuginfo instead. This
> works without libdw too, where 'perf probe -L' isn't available, and also
> avoids adding a real probe just to check for debuginfo. This fixes the
> "perftool-testsuite_probe" test:
> 
>   $ sudo perf test -vvv "perftool-testsuite_probe"
>   ...
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l (output regexp parsing)
>   ...
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: wildcard adding support (command exitcode + output regexp parsing)
>   ...
>   -- [ FAIL ] -- perf_probe :: test_adding_kernel :: non-existing variable (output regexp parsing)
>   ...
>   ## [ FAIL ] ## perf_probe :: test_adding_kernel SUMMARY :: 3 failures found
>   ...
>   189: perftool-testsuite_probe : FAILED!
> 
> Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 57a59ae7d4ae..1c3af5771bcf 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -64,7 +64,8 @@ add_probe_vfs_getname() {
>  }
>  
>  skip_if_no_debuginfo() {
> -	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
> +	# Dry run a probe that needs debuginfo.
> +	perf probe -n -v 'getname_flags $params' 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2

Nit: can we break the long line like this?

	perf probe -nv 'getname_flags $params' 2>&1 | grep -q \
		-e "Failed to find the path for the kernel" \
		-e "Debuginfo-analysis is not supported" \
		-e "file has no debug information" && return 2

Thanks,
Namhyung


>  	return 1
>  }
>  
> 
> -- 
> 2.43.0
> 
