Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DCC1A841B;
	Wed,  8 Jan 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736368745; cv=none; b=N4IIeNRSEQY7PxIwcqyITtzxwUozHdu229rpq3GY9VxgO4Ip07sQtOpWovo4mUv8i6rlBBNT2c1cNk1lOeIfIb46p8l9zX6V5cx30+uLyuD1yuVZQoZfnk3o3DAJL4S5Ry/jRFXWYME+bm2iKKJiRQucsus9m7WcIiZtpWEMbGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736368745; c=relaxed/simple;
	bh=sL3Jz3jZmP6rP9OVsASeRIZmjNQBj7sl6XvGFOMPFWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ1w5UAv5jwOqQ7WLccmDRwiVJFF/BNX/cPqkB/58TdSdwHiKvhfCgOnZ3Ml30TSaNPlMy4zO1pjhoyFnN0n983o1CBXVwSsHtR1d8oaF388JB8fUdvHHPtNeff9kgjBiQ3NX2Ae1JLOyo7+fhEZpNVXpolyoIpMgFWiGm7iDAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLikCWXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLikCWXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76566C4CEDF;
	Wed,  8 Jan 2025 20:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736368745;
	bh=sL3Jz3jZmP6rP9OVsASeRIZmjNQBj7sl6XvGFOMPFWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLikCWXcx1BXufWitqNXKjbHUkPUWYifWnifRwV2PIrH5GnRflGrmi2o5XmcovDSr
	 A0bqOAlqtrVXUltBzpADGvkKBJxNWEP4K2G/zhWAXu0f7YoU3xOdsB9KIeYCB6YoG8
	 n+xEbF5Nkr8y2mRq3SdZk1eMcBoG/xIJ92XRqeg4wk7a8rHeFmV3AQuHA9UCJLIaHF
	 GOmttXptiEIK4ngH86V3dRUEkk7+RV9jsabA5N7y+58MqgyevzalETn2HRRmXZtGfz
	 Wv6MGtaKrNdrIgUTX4AK/8cqepcuNqmIPTOp0A8vI63Eug89+ON+LsoE1WbqZkqZOG
	 lHdTG+ltv9RHA==
Date: Wed, 8 Jan 2025 17:39:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: namhyung@kernel.org, irogers@google.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf llvm-add2line: Remove unused include
Message-ID: <Z37iZZm3Ev2UnDA-@x1>
References: <20250108070248.237943-1-dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108070248.237943-1-dvyukov@google.com>

On Wed, Jan 08, 2025 at 08:02:28AM +0100, Dmitry Vyukov wrote:
> Remove unused symbol_conf.h include.
> First, it's just unused. Second, it's problematic since this is a C++ file,
> and most perf headers don't compile as C++. So if any other includes are
> added to symbol_conf.h, it may break the build.

Thanks, applied to perf-tools-next,

- Arnaldo
 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  tools/perf/util/llvm-c-helpers.cpp | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-c-helpers.cpp
> index 663bcaba2041f..004081bd12c9c 100644
> --- a/tools/perf/util/llvm-c-helpers.cpp
> +++ b/tools/perf/util/llvm-c-helpers.cpp
> @@ -18,7 +18,6 @@
>  extern "C" {
>  #include <linux/zalloc.h>
>  }
> -#include "symbol_conf.h"
>  #include "llvm-c-helpers.h"
>  
>  extern "C"
> 
> base-commit: 09a0fa92e5b45e99cf435b2fbf5ebcf889cf8780
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
> 
