Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFB31E5714;
	Mon, 13 Jul 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964324; cv=none; b=HpcxnCHAq9V+Q5Z1HZSguoseXoiee0EbD5/sbH6FqbEWc453aGFUYkaQvLp2dvCYAxZ66wj3mlXwLo3EFszrZInQ9ui/FamqYf7HUDmcqX2Jl3rupwEdgZgDEaxOww9zJuNgBuyj1/1eUlQx00+m0eHFR2Ujfax/gkFlmd7hkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964324; c=relaxed/simple;
	bh=jN15X1VjOWv27GtSopfPrCngXVvHaI5TcJ97KK2lk5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAOB7XZTXaKH1vufs1N1OJxWqSuSwyV0nF6ItysA2Khc2dSrrAsCq0KGXneTqO4v/CrKrgF2bwIYzmpm3BCDitSPv8+JtIhNzmOUeBnUnO5dwlErXlhPRBKm26Eo+3lFTstI0gCdnuvSCOYCC/6LHmR/V8k9l+Z6iWBSNqZK8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKkJ4Y2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKkJ4Y2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273C71F000E9;
	Mon, 13 Jul 2026 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964323;
	bh=h3baWQBOm3fA8LbrKIbT9coknGq4LcfII7APNFf/aZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fKkJ4Y2dJvsug6grul1a0OaCiASLL+Bf3ilRvVXvPOqNSgkP8fUonXn4WckOvrM5/
	 4UEBYOn4jA0KVpwUd64b4V9TV4eMTfBdYNImPiWS/u5X0pIfLqzrkvO3tXaiLpbuEE
	 lDogbEHBBX80nOrtzr6bEnp0D8k/VTdKTDS7DdiSZjeJr8sIxgdzKXed7sZ77ixlli
	 XRDDRdymCUcBL+KMNu19rVFTHe5YiFLweYmN4aHrQKGr3nqccxgSdCZyNvbqpeWegD
	 1vyxud5zQHL24XVwzSHJgvy230o8674BIC0V6OC9Ho1uWUVPcm/JeVJyWbRqem5+Zz
	 GvrLjsLcONeYw==
Date: Mon, 13 Jul 2026 10:38:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Trevor Allison <tallison@redhat.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Fix static build of dlfilters
Message-ID: <alUioShYpMSzbmf2@google.com>
References: <20260713-perf_fix_static_build-v1-1-460be1f9e4d6@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713-perf_fix_static_build-v1-1-460be1f9e4d6@arm.com>

Hi Leo,

On Mon, Jul 13, 2026 at 11:23:01AM +0100, Leo Yan wrote:
> Commit e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
> passes LDFLAGS when linking dlfilter shared objects. That breaks static
> builds because LDFLAGS can contain -static, leading to an invalid link
> command.
> 
> dlfilters are always built as shared objects, even for a static perf
> binary. Filter out -static for the dlfilter .so link while preserving
> the rest of LDFLAGS.
> 
> Fixes: e1065ed188cf ("perf build: Add LDFLAGS to dlfilters .so link")
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Actually I posted the same patch.  Can I get your Tested-by?

https://lore.kernel.org/r/20260707000357.823509-1-namhyung@kernel.org

Thanks,
Namhyung

> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2b53d9e0c73b3382724b1f776880aaa8fa505f59..0031112c036e830e50711d5cb0b3867cba36e374 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -680,7 +680,7 @@ $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
>  .SECONDARY: $(DLFILTERS:.so=.o)
>  
>  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
> -	$(QUIET_LINK)$(CC) $(LDFLAGS) $(EXTRA_CFLAGS) -shared -o $@ $<
> +	$(QUIET_LINK)$(CC) $(filter-out -static,$(LDFLAGS)) $(EXTRA_CFLAGS) -shared -o $@ $<
>  
>  ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
> 
> ---
> base-commit: ef3af1df4f3372bd8ad47619452a283048b3bc8d
> change-id: 20260713-perf_fix_static_build-6db03942fee1
> 
> Best regards,
> -- 
> Leo Yan <leo.yan@arm.com>
> 
