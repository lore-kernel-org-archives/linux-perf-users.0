Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E5DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 19:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22FB2610A3
	for <linux-perf-users@archiver.kernel.org>; Sat, 11 Sep 2021 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhIKTIj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 15:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhIKTIf (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Sep 2021 15:08:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1F9866108B;
        Sat, 11 Sep 2021 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631387242;
        bh=5nVQt2QNXqPh7MVcqRqQ67dyG+RrTN8xmcuN/fCTJYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J5ucZf38apxUFudcaEz8Ds4Am8vy5rsHpLvHxDR5bHSVMMtcWNbuJiOaQeXGUtNOa
         GhXGSuPCPBMz7BCel9oGdkjJtKFs48BJ1u+3IBC+En3hEGpWNgTBEexdnEFVOO3x3e
         xSuaLPQiAE1PwJ/Jd6NmL+mxHoLDCqRQqle/g981G5ACi+eil1fJYXxlM4gUDSKxlw
         MJ5AjNwgj7/KojsUiWhqg9za93H4UTimBh4jd4Cq8P7cFYYOhMPHmeNJHtT/we162S
         gypFf2k55e1864ske4C6UlUN7EeCD2qAYNNjtIX+vZDcsIK6/ZLv7sQs9hQkxKM8xV
         1v0O7CIhUKwOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 697BF4038F; Sat, 11 Sep 2021 16:07:19 -0300 (-03)
Date:   Sat, 11 Sep 2021 16:07:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>
Subject: Re: [PATCH] perf tools: Add an option to build without libbfd
Message-ID: <YTz+Z4K0CR3tghNr@kernel.org>
References: <20210910225756.729087-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910225756.729087-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Sep 10, 2021 at 03:57:56PM -0700, Ian Rogers escreveu:
> Some distributions, like debian, don't link perf with libbfd. Add a
> build flag to make this configuration buildable and testable.
> This was inspired by:
> https://lore.kernel.org/linux-perf-users/20210910102307.2055484-1-tonyg@leastfixedpoint.com/T/#u

Looks ok, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.config | 47 ++++++++++++++++++++------------------
>  1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index b66cf128cbc7..446180401e26 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -827,33 +827,36 @@ else
>    endif
>  endif
>  
> -ifeq ($(feature-libbfd), 1)
> -  EXTLIBS += -lbfd -lopcodes
> -else
> -  # we are on a system that requires -liberty and (maybe) -lz
> -  # to link against -lbfd; test each case individually here
> -
> -  # call all detections now so we get correct
> -  # status in VF output
> -  $(call feature_check,libbfd-liberty)
> -  $(call feature_check,libbfd-liberty-z)
>  
> -  ifeq ($(feature-libbfd-liberty), 1)
> -    EXTLIBS += -lbfd -lopcodes -liberty
> -    FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
> +ifndef NO_LIBBFD
> +  ifeq ($(feature-libbfd), 1)
> +    EXTLIBS += -lbfd -lopcodes
>    else
> -    ifeq ($(feature-libbfd-liberty-z), 1)
> -      EXTLIBS += -lbfd -lopcodes -liberty -lz
> -      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
> +    # we are on a system that requires -liberty and (maybe) -lz
> +    # to link against -lbfd; test each case individually here
> +
> +    # call all detections now so we get correct
> +    # status in VF output
> +    $(call feature_check,libbfd-liberty)
> +    $(call feature_check,libbfd-liberty-z)
> +
> +    ifeq ($(feature-libbfd-liberty), 1)
> +      EXTLIBS += -lbfd -lopcodes -liberty
> +      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
> +    else
> +      ifeq ($(feature-libbfd-liberty-z), 1)
> +        EXTLIBS += -lbfd -lopcodes -liberty -lz
> +        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
> +      endif
>      endif
> +    $(call feature_check,disassembler-four-args)
>    endif
> -  $(call feature_check,disassembler-four-args)
> -endif
>  
> -ifeq ($(feature-libbfd-buildid), 1)
> -  CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
> -else
> -  msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
> +  ifeq ($(feature-libbfd-buildid), 1)
> +    CFLAGS += -DHAVE_LIBBFD_BUILDID_SUPPORT
> +  else
> +    msg := $(warning Old version of libbfd/binutils things like PE executable profiling will not be available);
> +  endif
>  endif
>  
>  ifdef NO_DEMANGLE
> -- 
> 2.33.0.309.g3052b89438-goog

-- 

- Arnaldo
