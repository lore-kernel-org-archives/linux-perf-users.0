Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDAD143873;
	Thu, 16 May 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715853473; cv=none; b=MoUJe9cVXLkVWg3lTyG9HmM6ROxy9WydCTdvTz3Alo04RO2CKDxOqFa5PwhrMwoB3Gl7CyjS/YrBTWBe5Vh056btrOfGkbhut8v31R26S1m16EE5RUVddMOiqj724AcflzjWllaFO/CnUgctbUnRvcagEiaQkHevUkqKH07Smm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715853473; c=relaxed/simple;
	bh=aBfJcKENAy4d+hffQ+37XSbB85pRW1cn0L5TxjzJrq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGYsSPyU6Nwkgv6wHPSNXFK+/Vch6apRcosHYnA6q9r8FnSQGgGFSa6K2TMr4WOr+BZnyeaXtx2k1svVtX3qViB+TodqH1Y4G7ue2HTRZ6vCNTK5VuLVPkzXwW7IB19uc0E9nImPF27is98fAauyfr1eOTNZM/FLmONGBOn+6Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14A41DA7;
	Thu, 16 May 2024 02:58:10 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AAB2B3F762;
	Thu, 16 May 2024 02:57:43 -0700 (PDT)
Message-ID: <c3d59fb0-3910-4df3-9f2b-6d25dd798581@foss.arm.com>
Date: Thu, 16 May 2024 10:57:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: perf: arm64: Catch all Arm files and folders
To: James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org
Cc: gregkh@linuxfoundation.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240515151221.204163-1-james.clark@arm.com>
Content-Language: en-US
From: Leo Yan <niayan01@foss.arm.com>
In-Reply-To: <20240515151221.204163-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 16:12, James Clark wrote:
> Catch all files and folders with Arm in the name in tools/perf/ up to
> two levels deep. There currently no false positives.
> 
> This catches lots of missing items like these and more:
> 
>    * util/arm-spe-decoder/
>      (The existing util/arm-spe* entry only matched files not folders)
>    * util/perf-regs-arch/perf_regs_arm.c
>    * scripts/python/arm-cs-trace-disasm.py
>    * tests/shell/test_arm_spe.sh
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>   MAINTAINERS | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec0284125e8f..c5d0256d32dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17318,9 +17318,10 @@ R:	Leo Yan <leo.yan@linux.dev>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	tools/build/feature/test-libopencsd.c
> -F:	tools/perf/arch/arm*/
> -F:	tools/perf/pmu-events/arch/arm64/
> -F:	tools/perf/util/arm-spe*
> +F:	tools/perf/*/*/*arm*
> +F:	tools/perf/*/*/*arm*/
> +F:	tools/perf/*/*arm*
> +F:	tools/perf/*/*arm*/
>   F:	tools/perf/util/cs-etm*

Also looks good to me:

Reviewed-by: Leo Yan <leo.yan@arm.com>
