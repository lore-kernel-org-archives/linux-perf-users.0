Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A22F9C0;
	Fri,  8 May 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778199889; cv=none; b=nikyLUiyF5XdlF3egWHEIF4RzaI/invz669pgYsd3SY8eAsCRtfkmfC5AqjYdjsPNce2uG/Mt9nAHzE0VczvJPqWj46PxjbZkzd2TGih+zvnSGd1x0odAPXbrm530MTB+uwiTLuF8qeMboro4vaC0aYltHHSPbeYWbCJ9OK9CkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778199889; c=relaxed/simple;
	bh=3Od59pGEv2S+UErlUpnYc64iodju8317VpGTce8GI90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhnvBpV4MrSisd29sxth+8OkLL/rhL/Yv31eDx++2v815nvuirsgFTtMV2DROSuzJppQrIbo7c6ae38GtC1nh1h42vWYmp52dXlWmSrh987UO1HF0ODvtzUIm2ist68qqRPeIEWhkGiw5PnXgHKW6/yXBX+TtfD1zF7+VTFL3J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa637nlE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa637nlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6A7C2BCB2;
	Fri,  8 May 2026 00:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778199889;
	bh=3Od59pGEv2S+UErlUpnYc64iodju8317VpGTce8GI90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fa637nlER2aKJ57QLnQiprDti3mdgG7YsPzVIG+nZGREcO0vY079ZI2LJycIRxvOJ
	 BTBftQc5r/ReWnDiKsGuedTA+LWIfL7pnAl1Qnomcnu8/hQGWubR7ZX1mUHXnoQx2m
	 ac/i3fS1njr092bjawkG+LcFrPxUjfvRevvhwAPAgVwz++b6oVC3uP/h5kboECY9NU
	 vRx9WZlWkJ6QHYlVgmvHHQd6tgtKgPQl7YZaF2a0Pdipgwej7W8Q1YQgvQZHVwg9pg
	 xB4zko8INlJwRptHCP7PvEiNPIT4UivDEXq3e+sdOFJ1Y9qKprnZXDM1wKEpCwy7vq
	 nf+lPWbeGxr5A==
Date: Thu, 7 May 2026 17:24:47 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	James Clark <james.clark@linaro.org>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Manali Shukla <manali.shukla@amd.com>,
	Santosh Shukla <santosh.shukla@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	Sandipan Das <sandipan.das@amd.com>
Subject: Re: [PATCH v2 3/8] perf test ibs: Remove obsolete privilege test
Message-ID: <af0tTxZNLdtohH8A@google.com>
References: <20260430061115.10266-1-ravi.bangoria@amd.com>
 <20260430061115.10266-4-ravi.bangoria@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430061115.10266-4-ravi.bangoria@amd.com>

Hello,

On Thu, Apr 30, 2026 at 06:11:10AM +0000, Ravi Bangoria wrote:
> Older IBS implementations lacked a hardware privilege filter, so the
> kernel enabled swfilt=1. Newer AMD CPUs will provide privilege filtering
> via the RIP[63] bit, making swfilt redundant. Remove the perf unit test
> that assumes IBS has no hardware-assisted privilege filter.

Can you add a check for CPU model or capability for this?
Probably we want to keep this test for older models..

Thanks,
Namhyung

> 
> swfilt is ignored by kernel on platforms that support RIP[63] bit filter
> i.e. all amd-ibs-swfilt.sh tests will test hardware assisted privilege
> filter.
> 
> Without the patch:
> 
>   # ./perf test -vv 75
>   test child forked, pid 26029
>   check availability of IBS swfilt
>   run perf record with modifier and swfilt
>   [FAIL] IBS PMU should not accept exclude_kernel
>    75: AMD IBS software filtering                            : FAILED!
> 
> With the patch:
> 
>   # ./perf test -vv 75
>   check availability of IBS swfilt
>   run perf record with modifier and swfilt
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB /dev/null ]
>   check number of samples with swfilt
>   [ perf record: Woken up 5 times to write data ]
>   [ perf record: Captured and wrote 0.040 MB - ]
>   [ perf record: Woken up 3 times to write data ]
>   [ perf record: Captured and wrote 0.054 MB - ]
>    75: AMD IBS software filtering                            : Ok
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/perf/tests/shell/amd-ibs-swfilt.sh | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/amd-ibs-swfilt.sh b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> index e7f66df05c4b..92ef45bf3043 100755
> --- a/tools/perf/tests/shell/amd-ibs-swfilt.sh
> +++ b/tools/perf/tests/shell/amd-ibs-swfilt.sh
> @@ -22,13 +22,6 @@ fi
>  echo "run perf record with modifier and swfilt"
>  err=0
>  
> -# setting any modifiers should fail
> -perf record -B -e ibs_op//u -o /dev/null true 2> /dev/null
> -if [ $? -eq 0 ]; then
> -    echo "[FAIL] IBS PMU should not accept exclude_kernel"
> -    exit 1
> -fi
> -
>  # setting it with swfilt should be fine
>  perf record -B -e ibs_op/swfilt/u -o /dev/null true
>  if [ $? -ne 0 ]; then
> -- 
> 2.43.0
> 
