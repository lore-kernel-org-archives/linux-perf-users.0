Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EDCC11F69
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 12:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EAB6141C
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 12:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhGBNB1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230271AbhGBNB1 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 09:01:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 473EC611F1;
        Fri,  2 Jul 2021 12:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625230735;
        bh=msVXYLCeYmCe0xCh6LpEk6Eun3bB4RWaev+e9O2lpvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiDDpq15JSCneK+IG880HEEZDToCVmR/uxaSukpOBA3feiDQy7ELU4ezTO9Xq1jQ+
         2nJICb1TVydn54+Q13cryx/mn9IhM/wLGOXcWqrSWZNieItwc9sJjFiUvelgAD47zC
         HyoQWyWfx/9un2eWsaWAgjiKh14ElqiMDY8zzBNeE1mqhAz1K1e9dihKdUTdwk9EH+
         EDixqbyRosx1pngfM4PjiMIl5GTIVDQuzP1fhswiPCYLNNGtuwFNJqS2LlVTL8t8z1
         zXY8PYzhnA1wT42QLPig7XB55zA2KujznRo98hIEJEv9q3qGII32CjTBYj4ZmfNPH7
         2rSRkrvKHuKZg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FCDB40B1A; Fri,  2 Jul 2021 09:58:52 -0300 (-03)
Date:   Fri, 2 Jul 2021 09:58:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     gushengxian <gushengxian507419@gmail.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: Re: [PATCH] perf: tests: fix some mmemory leak issues
Message-ID: <YN8NjJLHoB+wzLXa@kernel.org>
References: <20210702040955.631618-1-gushengxian507419@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702040955.631618-1-gushengxian507419@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 01, 2021 at 09:09:55PM -0700, gushengxian escreveu:
> From: gushengxian <gushengxian@yulong.com>
> 
> Some memory leak issues should be fixed by free().
> Reported by cppcheck.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: gushengxian <gushengxian@yulong.com>
> ---
>  tools/perf/arch/arm/tests/dwarf-unwind.c     | 1 +
>  tools/perf/arch/arm64/tests/dwarf-unwind.c   | 1 +
>  tools/perf/arch/powerpc/tests/dwarf-unwind.c | 1 +
>  tools/perf/arch/x86/tests/dwarf-unwind.c     | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/tools/perf/arch/arm/tests/dwarf-unwind.c b/tools/perf/arch/arm/tests/dwarf-unwind.c
> index ccfa87055c4a..f2541d1dbb02 100644
> --- a/tools/perf/arch/arm/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm/tests/dwarf-unwind.c
> @@ -39,6 +39,7 @@ static int sample_ustack(struct perf_sample *sample,
>  	memcpy(buf, (void *) sp, stack_size);
>  	stack->data = (char *) buf;
>  	stack->size = stack_size;
> +	free(buf);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/arch/arm64/tests/dwarf-unwind.c b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> index 46147a483049..ecd25c77a71f 100644
> --- a/tools/perf/arch/arm64/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/arm64/tests/dwarf-unwind.c
> @@ -39,6 +39,7 @@ static int sample_ustack(struct perf_sample *sample,
>  	memcpy(buf, (void *) sp, stack_size);
>  	stack->data = (char *) buf;
>  	stack->size = stack_size;
> +	free(buf);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> index 8efd9ed9e9db..e57a8ca52ce7 100644
> --- a/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
> @@ -40,6 +40,7 @@ static int sample_ustack(struct perf_sample *sample,
>  	memcpy(buf, (void *) sp, stack_size);
>  	stack->data = (char *) buf;
>  	stack->size = stack_size;
> +	free(buf);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
> index 478078fb0f22..da90b33a1e28 100644
> --- a/tools/perf/arch/x86/tests/dwarf-unwind.c
> +++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
> @@ -47,6 +47,7 @@ static int sample_ustack(struct perf_sample *sample,
>  #endif
>  	stack->data = (char *) buf;
>  	stack->size = stack_size;
> +	free(buf);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
