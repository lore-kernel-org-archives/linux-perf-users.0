Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA740E8DB;
	Fri,  5 Jun 2026 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667633; cv=none; b=L9g1ozr+F6GHSLT0EACBvm600eiq9EZgVgJwgKFbfA9i1VDcTmTYb+zCUDNSgnB73VqWfndWHML69tQ+Z+LEOpTHHUBDmZwd/yQJUlXWeIMMoUjAdSh3Ib+NAbJ6Ol+SZ112H0fsxxtd19LVpRaKcBCDhpF7KaaFAK0Bbwemj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667633; c=relaxed/simple;
	bh=dv7w7V243Ir0z2lVM+UUtdm7LPvO4BCpPqes1rH4Faw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbeK39PLi7m4sk7F0mY8ANUTQrhtLEfKsICZRSIvXB59UbJR2tNItKydpnAFYfwuCzHzBltIiyQg7rmS1CtrtKuYhTRVKS5FPhd2iBcIeuY6AkpoVzS1+yJIYfmyhnYXAySWPyQpvcgxd4gGdi9aEK3fr2Q219LmjBE5VaC7zEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9St+RvV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9St+RvV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE71F00898;
	Fri,  5 Jun 2026 13:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667632;
	bh=J0R4eBG2pFYNvoAv6aArk0OSJ05uyndW9ZEtAs++bJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A9St+RvVrzyZl1ZMltNKutIQ4v56AK9zs+Vr6o/Gw9W8YZzAgleY83Gj5tnrWqydv
	 AdT056a/FPR/9138v3+ImH4wqZtMbBAYNqbYRQPuIe9Tt4Q8tsPXSyqMYCwyrd4RMv
	 A77jBow2Hfw7i08PjR8ogFZQ9YU3f7fvI7U+y+5KYtTh6fESF/Ezz9WCfT+21oizXA
	 5vS0IiejhSADD+AjeTi1nsCORC1GBX2JrZy+nrPEcfktzLtTj85ZM7HuO9kxmfAgeO
	 abA/pREttTxluz8Ydipn9WHLOzoipIwUI1hZwuS7laf3zAoMttwO/y/Z0OatWqDVf9
	 sc9zAKaZVrkOQ==
Date: Fri, 5 Jun 2026 08:53:51 -0500
From: Rob Herring <robh@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Shuah Khan <shuah@kernel.org>, Breno Leitao <leitao@debian.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/4] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <20260605135351.GA3587043-robh@kernel.org>
References: <20260527121207.2312181-1-puranjay@kernel.org>
 <20260527121207.2312181-4-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527121207.2312181-4-puranjay@kernel.org>

On Wed, May 27, 2026 at 05:11:59AM -0700, Puranjay Mohan wrote:
> Enable bpf_get_branch_snapshot() on ARM64 by implementing the
> perf_snapshot_branch_stack static call for BRBE.
> 
> BRBE is paused before masking exceptions to avoid branch buffer
> pollution from trace_hardirqs_off(). Exceptions are then masked with
> local_daif_save() to prevent PMU overflow pseudo-NMIs from interfering.
> If an overflow between pause and DAIF save re-enables BRBE, the snapshot
> detects this via BRBFCR_EL1.PAUSED and bails out.
> 
> Branch records are read using perf_entry_from_brbe_regset() with a NULL
> event pointer to bypass event-specific filtering. The buffer is
> invalidated after reading.
> 
> Introduce a for_each_brbe_entry() iterator to deduplicate bank
> iteration between brbe_read_filtered_entries() and the snapshot.
> 
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  drivers/perf/arm_brbe.c  | 127 ++++++++++++++++++++++++++++++++-------
>  drivers/perf/arm_brbe.h  |   9 +++
>  drivers/perf/arm_pmuv3.c |   5 +-
>  3 files changed, 119 insertions(+), 22 deletions(-)

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
