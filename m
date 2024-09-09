Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F4D18030;
	Mon,  9 Sep 2024 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725920164; cv=none; b=YepWBC3DXLHUp1eOz0BZLUFSsz+r09h2JXNehNiYZH7tprpYuMOSqMu+q6F2axZCA9iU22J0Xsv8/F0PkLj4JZc7Goi9ePM5Sn8h7PhJK4+EU6U/aJlgFzLrzKtVlBl1ED20VvPCTVgWE7KYiR2i1M6Upk7XCjhGWbT0b8RdEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725920164; c=relaxed/simple;
	bh=X+jgeBAYm9JbACaaekTA0tZUdHG6GFvSeLrPb/xGFvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY/VPYOUssmHhjTIKXG7Eka0Ly9R2LQuJeCBNH2CMcz/hsCQsRX+EKcAuw3NH3wh0rTJfgXvEySh0GhaazUczTCA0IdTOhLP9tZVsjwZmM0yUurtFoN2zlte0EHYU0O2g4n38qwLgQJmCQ6i3zbtVFZ5GBNroEkzy22Wa7cxdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiMCLUSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiMCLUSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13AE5C4CEC5;
	Mon,  9 Sep 2024 22:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725920163;
	bh=X+jgeBAYm9JbACaaekTA0tZUdHG6GFvSeLrPb/xGFvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiMCLUSw+0JdYC4hUBMMBvl5/AMQD9PiDrwNvFOYWZFhG2wT1eHiRWv7vcrkNSHq0
	 hGok2AJN1+/tKH+z/qdBxaL/SjyIKMU7AsuE0yLDtKi1qWKx4N/tunZzyNZhBp6Vmo
	 DnXJVhDN2vxqMbIIjUAPe6L/sn8tJWmhYJkvd/RJE2OMhxAgrenhZOdVtI85mLiroZ
	 rrAc+sNGVIoiDTuGvlD3Q/Z+HOHrKtlTTBghUBxBCnJ8rObb/n4evTqgRnX46YtnOh
	 vi2551vY/b7jogpQwBpWvY+YCFviaZJywID10ougeN9HtvDzHAMjbSrOqJdNDiZh56
	 ppIz/bYNofhAQ==
Date: Mon, 9 Sep 2024 15:16:01 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Sam James <sam@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tools: drop nonsensical -O6
Message-ID: <Zt9zoVFkFaCDwJ36@google.com>
References: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>

Hello,

On Sun, Sep 08, 2024 at 07:46:41PM +0100, Sam James wrote:
> -O6 is very much not-a-thing. Really, this should've been dropped
> entirely in 49b3cd306e60b9d889c775cb2ebb709f80dd8ae9 instead of just
> passing it for not-Clang.
> 
> Just collapse it down to -O3, instead of "-O6 unless Clang, in which case
> -O3".
> 
> GCC interprets > -O3 as -O3. It doesn't even interpret > -O3 as -Ofast,
> which is a good thing, given -Ofast has specific (non-)requirements for
> code built using it. So, this does nothing except look a bit daft.
> 
> Remove the silliness and also save a few lines in the Makefiles accordingly.
> 
> Signed-off-by: Sam James <sam@gentoo.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
> I promise I'm not completely humourless, but given it's caused
> actual workarounds to be added for Clang, I don't think this is worth keeping.
> 
> Plus it sort of propagates a silly myth that -O6 does anything.
> 
>  tools/lib/api/Makefile     | 4 ----
>  tools/lib/subcmd/Makefile  | 4 +---
>  tools/lib/symbol/Makefile  | 4 ----
>  tools/perf/Makefile.config | 6 +-----
>  4 files changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
> index 044860ac1ed1c..7f6396087b467 100644
> --- a/tools/lib/api/Makefile
> +++ b/tools/lib/api/Makefile
> @@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
>  
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
> -else
> -  CFLAGS += -O6
> -endif
>  endif
>  
>  ifeq ($(DEBUG),0)
> diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
> index b87213263a5e0..6717b82fc5876 100644
> --- a/tools/lib/subcmd/Makefile
> +++ b/tools/lib/subcmd/Makefile
> @@ -38,10 +38,8 @@ endif
>  
>  ifeq ($(DEBUG),1)
>    CFLAGS += -O0
> -else ifeq ($(CC_NO_CLANG), 0)
> -  CFLAGS += -O3
>  else
> -  CFLAGS += -O6
> +  CFLAGS += -O3
>  endif
>  
>  # Treat warnings as errors unless directed not to
> diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
> index 13d43c6f92b4a..426b845edfacc 100644
> --- a/tools/lib/symbol/Makefile
> +++ b/tools/lib/symbol/Makefile
> @@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
>  CFLAGS += -ggdb3 -Wall -Wextra -std=gnu11 -U_FORTIFY_SOURCE -fPIC
>  
>  ifeq ($(DEBUG),0)
> -ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -O3
> -else
> -  CFLAGS += -O6
> -endif
>  endif
>  
>  ifeq ($(DEBUG),0)
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index fa679db61f622..5d6b08a896150 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -238,11 +238,7 @@ endif
>  
>  ifeq ($(DEBUG),0)
>  CORE_CFLAGS += -DNDEBUG=1
> -ifeq ($(CC_NO_CLANG), 0)
> -  CORE_CFLAGS += -O3
> -else
> -  CORE_CFLAGS += -O6
> -endif
> +CORE_CFLAGS += -O3
>  else
>    CORE_CFLAGS += -g
>    CXXFLAGS += -g
> -- 
> 2.46.0
> 
