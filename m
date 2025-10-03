Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C80C29405;
	Fri,  3 Oct 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759520887; cv=none; b=RrusUVl5DTW6SpyhIS2J9Sol8h1FdWuDpRWweEcB3mWKutLB+5l2cmsmw6UnBF7GJkiWx/3zgypSCk3FbgC3E+AqxUq53a4fz8+GdnHIpQq7Stvr9Zr2q8miuLA7G5r+4CKEGm4p7nakZlwQ1wzEFuLi6LYWawuMQNs3Fb90Hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759520887; c=relaxed/simple;
	bh=XespbJmbr9h/tE+EY6P0TWlgNfeNfgvN51LKlVZ+UHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VavTEnK4k2DDh7U2RpqrnAchxJAzDtIpzdAhVtmzi6HyUXzDdu0q+ubsweZH1RnwgCc1/+ioKDZPjZjFeOeoX+dL2/v0U24JP0BUxmq3LGb5iouetwJAif7XNif/qby15bmoi4gaL3Lne1293YrD/yohQoH1WLZ+O356XNIElgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1qSKVeW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1qSKVeW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E97C4CEF5;
	Fri,  3 Oct 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759520887;
	bh=XespbJmbr9h/tE+EY6P0TWlgNfeNfgvN51LKlVZ+UHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1qSKVeWOCu5oqjFB5lakDhnVjXNQV8JyTdSrY/E25Qc139EpD8Szp8V00L2mUl7M
	 q6CEW7XeD0y/JNLqLs087dy5XzHsDMnYUmXKtm37I9hS7vw/TMPdgRXaclJvB3SGhm
	 iXQzj/jDF9F6vJRsFXdJHUfGzoEXZkj453VHLHgrryQjitRQB5vN/FUdySmoKtM1Zv
	 Xqpqz2YkI2PyKEe26gZe5yRb4V7r1aE4PTcff3uH3IArVy4DKC87Uzmaf1ElAD/PBY
	 /SxpjJc/EfwOhSbQBOvn/+ORfRCiyh6BKUyTJ1E+nYBGJ3x6gCB2RS5XNfAr0Ts6Uv
	 lWvnx9+1rwenw==
Date: Fri, 3 Oct 2025 16:48:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tools build: Remove get_current_dir_name
Message-ID: <aOAoc0-Oy99l3iQG@x1>
References: <20251003175613.2512296-1-irogers@google.com>
 <20251003175613.2512296-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251003175613.2512296-2-irogers@google.com>

On Fri, Oct 03, 2025 at 10:56:13AM -0700, Ian Rogers wrote:
> As perf no longer tests for this feature, and it was the only user,
> remove the feature test.

You forgot to remove this:

⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 71ba7001dc25c6bb..8a354b81417c6fcc 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -151,7 +151,6 @@ int main(int argc, char *argv[])
        main_test_libpython();
        main_test_hello();
        main_test_libelf();
-       main_test_get_current_dir_name();
        main_test_gettid();
        main_test_glibc();
        main_test_libdw();
⬢ [acme@toolbx perf-tools-next]$ 

That results, when building with this alias:

alias m='rm -rf ~/libexec/perf-core/ ; make CORESIGHT=1 -k O=/tmp/build/$(basename $PWD)/ -C tools/perf install-bin && perf test python && cat /tmp/build/$(basename $PWD)/feature/test-all.make.output'

that needs to be on the makefiles somewhere, shows that test-all.bin is
failing to build:

make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
 88: 'import perf' in python                                         : FAILED!
test-all.c: In function ‘main’:
test-all.c:154:9: error: implicit declaration of function ‘main_test_get_current_dir_name’; did you mean ‘get_current_dir_name’? [-Wimplicit-function-declaration]
  154 |         main_test_get_current_dir_name();
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |         get_current_dir_name
⬢ [acme@toolbx perf-tools-next]$ 

I fixed this up already,

Thanks,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/Makefile.feature                    |  1 -
>  tools/build/feature/Makefile                    |  4 ----
>  tools/build/feature/test-all.c                  |  4 ----
>  tools/build/feature/test-get_current_dir_name.c | 11 -----------
>  4 files changed, 20 deletions(-)
>  delete mode 100644 tools/build/feature/test-get_current_dir_name.c
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 9c1a69d26f51..9399f591bd69 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -68,7 +68,6 @@ FEATURE_TESTS_BASIC :=                  \
>          libdw                           \
>          eventfd                         \
>          fortify-source                  \
> -        get_current_dir_name            \
>          gettid				\
>          glibc                           \
>          libbfd                          \
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index b41a42818d8a..d13d2a1f44fe 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -8,7 +8,6 @@ FILES=                                          \
>           test-libdw.bin                         \
>           test-eventfd.bin                       \
>           test-fortify-source.bin                \
> -         test-get_current_dir_name.bin          \
>           test-glibc.bin                         \
>           test-gtk2.bin                          \
>           test-gtk2-infobar.bin                  \
> @@ -147,9 +146,6 @@ $(OUTPUT)test-libelf.bin:
>  $(OUTPUT)test-eventfd.bin:
>  	$(BUILD)
>  
> -$(OUTPUT)test-get_current_dir_name.bin:
> -	$(BUILD)
> -
>  $(OUTPUT)test-glibc.bin:
>  	$(BUILD)
>  
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> index e1847db6f8e6..778883a32afb 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -22,10 +22,6 @@
>  # include "test-libelf.c"
>  #undef main
>  
> -#define main main_test_get_current_dir_name
> -# include "test-get_current_dir_name.c"
> -#undef main
> -
>  #define main main_test_gettid
>  # include "test-gettid.c"
>  #undef main
> diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
> deleted file mode 100644
> index c3c201691b4f..000000000000
> --- a/tools/build/feature/test-get_current_dir_name.c
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#define _GNU_SOURCE
> -#include <unistd.h>
> -#include <stdlib.h>
> -
> -int main(void)
> -{
> -	free(get_current_dir_name());
> -	return 0;
> -}
> -#undef _GNU_SOURCE
> -- 
> 2.51.0.618.g983fd99d29-goog
