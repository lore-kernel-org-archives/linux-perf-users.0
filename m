Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8633B2B9BC;
	Fri, 24 Jan 2025 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737761512; cv=none; b=LubLqhX18xLpOWcOOesS01w6/IZbkpdp3lz4v3PeUv1he52CeKsAOGmG8zW3Gn8obs9GEn7wC3lRNBtUC19P2uJI+mr4TrOJeFI98d8nJeSQ20/RawT2D/jRJsJ/oR9HWm0b9qctwo8WkqW5o2k5ckJPwzRcwcCLqGwMytyTkW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737761512; c=relaxed/simple;
	bh=U0/yVGdE/375A68YA55chO0x7gza88tk//MIHm8minA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7YwsMh0rCn+l7yCfHEXpg4BYTG3vzu+PNbWXGluNFppvDTwair57EDTOG7zlO5AfhauJmAxsQhq2Bnm/nz9nUNSaQ6NnKjFIfGaTeGzsQ19CgnL+iKR0q+DSiRRAiUaukHZCxXLHAzESsBcGdpC9nh3mabmEoW1NVHvKsReACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2fX8BgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2fX8BgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DBEC4CED2;
	Fri, 24 Jan 2025 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737761512;
	bh=U0/yVGdE/375A68YA55chO0x7gza88tk//MIHm8minA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2fX8BgI71HkO3zl4pVEyN1LaGHgAZRDFr0WNVKpqoQWQGq6LdNFibdx+oqkLuWiS
	 i1+5opICsSi3jTwPaDXW2wKMtfAY13Q/dzmIQXFRyDTCASe6PceJ7qh7eRzQ+8BMSa
	 zxdXpwoz1MllR1eJNIdub6T/6AK4MRR7j+il/kjjBYa8EfSTc3ss6GQpojL3tbPnMi
	 SaDf9uSBvLEwnEYu6pxr+5500hP7UBHjfi53VSFDM8rEIK0KO2Gca6P3t5iPMxPjaZ
	 pqyWEIxWxq4lTtcuh5VQjV/NbIoLuv9TljzceI6biyfgv/ycY/Fk3MnTEUKyFagw53
	 z3pjdO6B+gW4Q==
Date: Fri, 24 Jan 2025 15:31:50 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/6] tools/build: Don't pass test log files to linker
Message-ID: <Z5Qi5olV2yy2-TJ8@google.com>
References: <20241025172303.77538-1-irogers@google.com>
 <20241025172303.77538-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025172303.77538-2-irogers@google.com>

On Fri, Oct 25, 2024 at 10:22:58AM -0700, Ian Rogers wrote:
> Separate test log files from object files. Depend on test log output
> but don't pass to the linker.

I don't know why $(obj-y) contains log files in the first place.  It's
supposed to have .o files only, right?

Thanks,
Namhyung

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/build/Makefile.build | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 5fb3fb3d97e0..ffe988867703 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -149,6 +149,10 @@ objprefix    := $(subst ./,,$(OUTPUT)$(dir)/)
>  obj-y        := $(addprefix $(objprefix),$(obj-y))
>  subdir-obj-y := $(addprefix $(objprefix),$(subdir-obj-y))
>  
> +# Separate out test log files from real build objects.
> +test-y       := $(filter %_log, $(obj-y))
> +obj-y        := $(filter-out %_log, $(obj-y))
> +
>  # Final '$(obj)-in.o' object
>  in-target := $(objprefix)$(obj)-in.o
>  
> @@ -159,7 +163,7 @@ $(subdir-y):
>  
>  $(sort $(subdir-obj-y)): $(subdir-y) ;
>  
> -$(in-target): $(obj-y) FORCE
> +$(in-target): $(obj-y) $(test-y) FORCE
>  	$(call rule_mkdir)
>  	$(call if_changed,$(host)ld_multi)
>  
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 
