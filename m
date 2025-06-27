Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148B1CEACB;
	Fri, 27 Jun 2025 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751042319; cv=none; b=jmLj0Ry+eL0m5R/kYk3eB00e3ptc1SoNwlQmonR1seCo78tagUsNHX49U9sD+5xBReCSzEjLLrPcs6FRjeJG883ySv6zwHD80VMBOn6tXfM0SWYXeC5CDZEQOzd9Qkro9HRC0eL/H55QdoGsQkVRt9hYcCkW1HELVeizvinuo/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751042319; c=relaxed/simple;
	bh=coqZ9AH1Xr1um42/coQFhzI7vkhc87lz2XE5hH6j06E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlR2KvWTMwERv0aq9O301H/vNeziAM8XaPkvdPAnJ614y37XZ8UFjqdZDPMWIGMrFiG56FRwBYU4LlSPlVHzjcbtD23uiRVZJg3xWTM3Y5jDr6RW9Stz7oNAy282lxnjIM0GhfxzRuSXbe/8yV0BoQR3078t7jQNj8+oHKinNjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhPfEbY2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhPfEbY2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0634AC4CEE3;
	Fri, 27 Jun 2025 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751042318;
	bh=coqZ9AH1Xr1um42/coQFhzI7vkhc87lz2XE5hH6j06E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IhPfEbY2+HwqyBANIIHVqgsNnv3Dt3vs/UmkZ1zL9GaWbeB1CsBKmLf1el5oVs8XB
	 /s0+EHW0upWhq00JieL0lJZ09vHA0Kp4kESHLHYFuONBarUpO8G1SHAznlII33rJeG
	 hTkeb3BlwMgl1hmti3OSVywYrN3bCqE/RxfOA/8WscD2ABXA3Gx6pv7EFFyOEes66b
	 bAOA7PDZMaghkgDifyjEklqQbeNE5tnWvwTFZe6YPIvZM0q5CY6I5q8xICnnCCl8pT
	 eNG3n9m49HR5cS8I/63Vlh48zn+IDq5IHfM7azUItXVQOrTlKQ9Q2hSuR99Z6PBqqr
	 GrC5lwV/jFLpA==
Date: Fri, 27 Jun 2025 09:38:35 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: Re: [PATCH v3 1/4] perf build: enable -fno-strict-aliasing
Message-ID: <aF7JC8zkG5-_-nY_@google.com>
References: <20250625202311.23244-1-ebiggers@kernel.org>
 <20250625202311.23244-2-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625202311.23244-2-ebiggers@kernel.org>

On Wed, Jun 25, 2025 at 01:23:08PM -0700, Eric Biggers wrote:
> perf pulls in code from kernel headers that assumes it is being built
> with -fno-strict-aliasing, namely put_unaligned_*() from
> <linux/unaligned.h> which write the data using packed structs that lack
> the may_alias attribute.  Enable -fno-strict-aliasing to prevent
> miscompilations in sha1.c which would otherwise occur due to this issue.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  tools/perf/Makefile.config | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 24736b0bbb302..70a3e771c7c08 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -17,10 +17,14 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
>  detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>  
>  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>  
> +# This is required because the kernel is built with this and some of the code
> +# borrowed from kernel headers depends on it, e.g. put_unaligned_*().
> +CFLAGS += -fno-strict-aliasing

This makes a build error with REFCNT_CHECKING=1.

  In file included from util/symbol.c:27:
  In function ‘dso__set_symbol_names_len’,
      inlined from ‘dso__sort_by_name’ at util/symbol.c:638:4:
  util/dso.h:654:46: error: ‘len’ may be used uninitialized [-Werror=maybe-uninitialized]
    654 |         RC_CHK_ACCESS(dso)->symbol_names_len = len;
        |                                              ^
  util/symbol.c: In function ‘dso__sort_by_name’:
  util/symbol.c:634:24: note: ‘len’ was declared here
    634 |                 size_t len;
        |                        ^~~

I'll simply add this to work around it:

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8b30c6f16a9eeac1..73dab94fab74e829 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -631,7 +631,7 @@ void dso__sort_by_name(struct dso *dso)
 {
        mutex_lock(dso__lock(dso));
        if (!dso__sorted_by_name(dso)) {
-               size_t len;
+               size_t len = 0;
 
                dso__set_symbol_names(dso, symbols__sort_by_name(dso__symbols(dso), &len));
                if (dso__symbol_names(dso)) {

Thanks,
Namhyung

> +
>  # Enabled Wthread-safety analysis for clang builds.
>  ifeq ($(CC_NO_CLANG), 0)
>    CFLAGS += -Wthread-safety
>  endif
>  
> -- 
> 2.50.0
> 
