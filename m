Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF898208A8;
	Thu, 16 May 2024 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715834100; cv=none; b=m2gya8eFfRtpBNsARhmTHON1ZwfekD26kQ8kn+qJ38qz5Q8EPM9f2WrgSkeXSGt4qQ21MC6gDcA4xL8257roD3SvpT/BikZQTAbH36HjitlAPiTNZOiwDsSBlS62TzZB+2T/ccLPKHxCCj1zlxftEEat1v1s4bOtxoSJWfjQO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715834100; c=relaxed/simple;
	bh=pZYNF4rE7QtTO092Rcuu7tJaH9xaf3reE8YCScETk0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tsXA5WhGB9R3F+t27ksLXjKGyskrS4NPos8Sej/PTgz9myKZY+KdMncx42a5STA9RjVQPE1YMA/hRSFr7WDpp/hBlDVOqFL3l9b8u5/kV1onHzNQqJh/Yu034kGqqAHYKvx3OsdYsOO+DKkmW22f4/+N1oO1kDid2HDVWuGwquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60908DA7;
	Wed, 15 May 2024 21:35:21 -0700 (PDT)
Received: from [10.163.39.35] (unknown [10.163.39.35])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 737943F762;
	Wed, 15 May 2024 21:34:50 -0700 (PDT)
Message-ID: <e92a8423-9172-4aec-acbf-c9f136e6884f@arm.com>
Date: Thu, 16 May 2024 10:05:01 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: perf: arm64: Catch all Arm files and folders
Content-Language: en-US
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
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240515151221.204163-1-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/24 20:42, James Clark wrote:
> Catch all files and folders with Arm in the name in tools/perf/ up to
> two levels deep. There currently no false positives.
> 
> This catches lots of missing items like these and more:
> 
>   * util/arm-spe-decoder/
>     (The existing util/arm-spe* entry only matched files not folders)
>   * util/perf-regs-arch/perf_regs_arm.c
>   * scripts/python/arm-cs-trace-disasm.py
>   * tests/shell/test_arm_spe.sh

Agreed.

> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  MAINTAINERS | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec0284125e8f..c5d0256d32dd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17318,9 +17318,10 @@ R:	Leo Yan <leo.yan@linux.dev>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Supported
>  F:	tools/build/feature/test-libopencsd.c
> -F:	tools/perf/arch/arm*/
> -F:	tools/perf/pmu-events/arch/arm64/
> -F:	tools/perf/util/arm-spe*
> +F:	tools/perf/*/*/*arm*
> +F:	tools/perf/*/*/*arm*/
> +F:	tools/perf/*/*arm*
> +F:	tools/perf/*/*arm*/
>  F:	tools/perf/util/cs-etm*

Very minor nit, these regular expressions should be arranged as per
the increasing directory depth levels, just to make it apparent in
terms of which files are being covered here ?

F:	tools/perf/*/*arm*
F:	tools/perf/*/*arm*/
F:	tools/perf/*/*/*arm*
F:	tools/perf/*/*/*arm*/

But regardless, with or without the above changes

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

>  
>  PERSONALITY HANDLING
