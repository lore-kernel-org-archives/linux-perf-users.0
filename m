Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9334329E4B;
	Sat, 19 Sep 2026 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789800153; cv=none; b=EnZzqUrEU4EMn3ilIVt1eJRDjKWR1dexSId/Jfo5LQJ/MLA1EU1YrnEFjwcsD3usxTxtZR97edkL7Oxhwp6WoDHNUdSdrCSBpbukNPcMnLHHjPkFAWxeVAerIiSnqKP7c6+zqelXrjjsod3RoPolmmJTGahFB8ULpnZ/jB75nP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789800153; c=relaxed/simple;
	bh=grUfh+N9i6XVVgR2tx8O23QpDD99GqngmDZuW6QUy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq/gucrXluYC9DAd+avxxShM2FS+AyLcmtY2oG0yqaTRaNkA6x5TSBMq3W09AdMwQ85v6tBEgEPPh2ol4bxgJX737wKWNTbHPdQjZ2GJC5zSkDK8wOpj+lFW+wE/Wx55/fpOSj1Xrnzy4sxjk+vzdiokxlQSRmL+vK4nVj6iM/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X11pfEdU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X11pfEdU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2521F000FF;
	Sat, 19 Sep 2026 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789800152;
	bh=VfYJsMSoAKRH/eVcbkljeQ6nL6EuLHQzGZ2zjmvn0Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X11pfEdUhgeM7oLmgOP5a3xjKtoEJCJ4XbBmIL7PppPeks9KdLPU72Tcn6GLkXLFG
	 bO8FCChPkRS5JZX3b82fnBKhtOTAZaS47K7EmkF4jpw+i2v3iGi4SfUdYmFX+ITH6k
	 mWbcvn10sI8nBODcFmN6eDJZ3jvn2CnvKijIo6hdjZ31Z1IzjWo6cFH0l6ZQssKO+N
	 OxghpvciH34WHxh+6VMy9QNLEwU//NehHw5yoUV1m2LiakbUzPWSuWTyZvoPwnfB26
	 iV+RPCMqNqx6LJScXwv4losEvR22V5jnxIGod/BI9rdjdy6QKWQDYScj0NmUrKil/M
	 dUvfBM4UyJerQ==
Date: Fri, 18 Sep 2026 23:42:30 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v1] tools include: Add missing stdarg.h include
Message-ID: <aq4u1lMOBF61XJFu@z2>
References: <20260917040454.32916-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917040454.32916-1-irogers@google.com>

On Wed, Sep 16, 2026 at 09:04:54PM -0700, Ian Rogers wrote:
> Header file makes use of varargs but doesn't directly include stdarg.h.
> 
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-perf-users/20260916062233.192271F000FF@smtp.kernel.org/
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  tools/include/tools/dis-asm-compat.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
> index 70f331e23ed3..1e0586d8451b 100644
> --- a/tools/include/tools/dis-asm-compat.h
> +++ b/tools/include/tools/dis-asm-compat.h
> @@ -2,6 +2,7 @@
>  #ifndef _TOOLS_DIS_ASM_COMPAT_H
>  #define _TOOLS_DIS_ASM_COMPAT_H
>  
> +#include <stdarg.h>
>  #include <stdio.h>
>  #include <dis-asm.h>
>  
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
