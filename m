Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98635C19F2A
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Aug 2022 05:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbiHGFZx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Aug 2022 01:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGFZw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Aug 2022 01:25:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E169DFD0
        for <linux-perf-users@vger.kernel.org>; Sat,  6 Aug 2022 22:25:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t22-20020a17090a449600b001f617f2bf3eso2988131pjg.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Aug 2022 22:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elx3tlR1SPQEOpAX6pa/qEPgTPewsMAdzIedzE8gNBY=;
        b=KSAmVz7/p0LQMqXbhAbmsdTh7Y354s9j+26eC3tHR9D085FNZlYl3ZA9BUJ2TgD7mN
         rKVXnc4ee6RjbE6NLHh7CedZtMmJkyL0uvIkG8d/Qb0cpaX45WZmmPdl/HbJWOr/hPtg
         7uUCrEkadwdtwcA3Dm/zNGuaXSn/yX5bKnxQxDYXVIUs43VFKfDS1UoU0pRoPg7pu7z8
         1+HvAEIJsJkZLz+HvLceUNV3yTWar9n4XHKpXFAUAEcYAKmbBtGIJM1jvwsEYJX+09kS
         8iXlFoTkaCuBmd4uEfuWDywvIzI5Sx6CCJz22HEKMuY054ZSOrBCuY+WNs5lLBZkprG+
         TZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elx3tlR1SPQEOpAX6pa/qEPgTPewsMAdzIedzE8gNBY=;
        b=mRQ1U4GXdfQ8K7CuNd9ZLfkK5SPlcSlgscKqIz+a6yn/aPZUjdmJIrmt28udb3DTSr
         VFxCS3L8qGhnzUF/9YLhh2tJy5UxvC9+slxigFNb8LjT4Rd3UDfHjx5ENQAH+5LhTA/0
         pSZAIYOeQvSbDKyH0Tk31lPdIdE0DKlLvF8EupdYMIenRdYssXPBCc6+jr1Bf4v7kvrd
         mq/HJ0dUM/hKD2sqgZZJh9VLODQoqL6wamHmyX+GZxlpnCKUO3vdd+M+svcb7V4QPknc
         eaoGRpmoz8RV/mGPOcY9fx+wgrzXD4EgsRR1KFbT2meDVEmng1CSyVQmxqpesWrEaokG
         Pg5Q==
X-Gm-Message-State: ACgBeo1yoCHopKmL+gW9uJ6iJEWwVo002eoFVHs/z0NRKcB4Hh7XbSDz
        bntaRt5+On5d2NCA0jfGq1lYlg==
X-Google-Smtp-Source: AA6agR4dMh81huEgB2PK+6BfqbAmVthoWiD6yUjsQYbGQII147WERV1Sl0eyD8vffN2CQe4fE9SlHA==
X-Received: by 2002:a17:902:8b88:b0:16d:2a70:26d9 with SMTP id ay8-20020a1709028b8800b0016d2a7026d9mr13807918plb.84.1659849950907;
        Sat, 06 Aug 2022 22:25:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.104.16clouds.com. [173.242.120.104])
        by smtp.gmail.com with ESMTPSA id b10-20020aa78eca000000b0052dce4edceesm5874337pfr.169.2022.08.06.22.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 22:25:50 -0700 (PDT)
Date:   Sun, 7 Aug 2022 13:25:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     carsten.haitzler@foss.arm.com
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH v5 11/14] perf test: Add unroll thread test tool
Message-ID: <20220807052546.GI34254@leoy-ThinkPad-X240s>
References: <20220728145256.2985298-1-carsten.haitzler@foss.arm.com>
 <20220728145256.2985298-12-carsten.haitzler@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728145256.2985298-12-carsten.haitzler@foss.arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jul 28, 2022 at 03:52:53PM +0100, carsten.haitzler@foss.arm.com wrote:
> From: "Carsten Haitzler (Rasterman)" <raster@rasterman.com>
> 
> Add test tool to be driven by further test scripts. This is a simple C
> based test that is for arm64 with some inline ASM to manually unroll a
> lot of code to have a very long sequence of commands.
> 
> Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>
> ---
>  tools/perf/tests/shell/coresight/Makefile     |  3 +-
>  .../coresight/unroll_loop_thread/.gitignore   |  1 +
>  .../coresight/unroll_loop_thread/Makefile     | 33 +++++++++
>  .../unroll_loop_thread/unroll_loop_thread.c   | 74 +++++++++++++++++++
>  4 files changed, 110 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
>  create mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> 
> diff --git a/tools/perf/tests/shell/coresight/Makefile b/tools/perf/tests/shell/coresight/Makefile
> index 004974a71fb8..3b2b876cd9e2 100644
> --- a/tools/perf/tests/shell/coresight/Makefile
> +++ b/tools/perf/tests/shell/coresight/Makefile
> @@ -7,7 +7,8 @@ include ../../../../../tools/scripts/utilities.mak
>  SUBDIRS = \
>  	asm_pure_loop \
>  	memcpy_thread \
> -	thread_loop
> +	thread_loop \
> +	unroll_loop_thread
>  
>  all: $(SUBDIRS)
>  $(SUBDIRS):
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
> new file mode 100644
> index 000000000000..2cb4e996dbf3
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
> @@ -0,0 +1 @@
> +unroll_loop_thread
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
> new file mode 100644
> index 000000000000..6264c4e3abd1
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +include ../Makefile.miniconfig
> +
> +# Binary to produce
> +BIN=unroll_loop_thread
> +# Any linking/libraries needed for the binary - empty if none needed
> +LIB=-pthread
> +
> +all: $(BIN)
> +
> +$(BIN): $(BIN).c
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +# Build line
> +	$(Q)$(CC) $(BIN).c -o $(BIN) $(LIB)
> +endif
> +endif
> +
> +install-tests: all
> +ifdef CORESIGHT
> +ifeq ($(ARCH),arm64)
> +# Install the test tool in the right place
> +	$(call QUIET_INSTALL, tests) \
> +		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)'; \
> +		$(INSTALL) $(BIN) '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/$(INSTDIR_SUB)/$(BIN)/$(BIN)'
> +endif
> +endif
> +
> +clean:
> +	$(Q)$(RM) -f $(BIN)
> +
> +.PHONY: all clean install-tests
> diff --git a/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> new file mode 100644
> index 000000000000..cb9d22c7dfb9
> --- /dev/null
> +++ b/tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Carsten Haitzler <carsten.haitzler@arm.com>, 2021
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <pthread.h>
> +
> +struct args {
> +	pthread_t th;
> +	unsigned int in, out;

nitpick: "out" field is not used, drop it?

With this minor fixing, the patch LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +	void *ret;
> +};
> +
> +static void *thrfn(void *arg)
> +{
> +	struct args *a = arg;
> +	unsigned int i, in = a->in;
> +
> +	for (i = 0; i < 10000; i++) {
> +		asm volatile (
> +// force an unroll of thia add instruction so we can test long runs of code
> +#define SNIP1 "add %[in], %[in], #1\n"
> +// 10
> +#define SNIP2 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1 SNIP1
> +// 100
> +#define SNIP3 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2 SNIP2
> +// 1000
> +#define SNIP4 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3 SNIP3
> +// 10000
> +#define SNIP5 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4 SNIP4
> +// 100000
> +			SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5 SNIP5
> +			: /* out */
> +			: /* in */ [in] "r" (in)
> +			: /* clobber */
> +		);
> +	}
> +}
> +
> +static pthread_t new_thr(void *(*fn) (void *arg), void *arg)
> +{
> +	pthread_t t;
> +	pthread_attr_t attr;
> +
> +	pthread_attr_init(&attr);
> +	pthread_create(&t, &attr, fn, arg);
> +	return t;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned int i, thr;
> +	pthread_t threads[256];
> +	struct args args[256];
> +
> +	if (argc < 2) {
> +		printf("ERR: %s [numthreads]\n", argv[0]);
> +		exit(1);
> +	}
> +
> +	thr = atoi(argv[1]);
> +	if ((thr > 256) || (thr < 1)) {
> +		printf("ERR: threads 1-256\n");
> +		exit(1);
> +	}
> +	for (i = 0; i < thr; i++) {
> +		args[i].in = rand();
> +		args[i].th = new_thr(thrfn, &(args[i]));
> +	}
> +	for (i = 0; i < thr; i++)
> +		pthread_join(args[i].th, &(args[i].ret));
> +	return 0;
> +}
> -- 
> 2.32.0
> 
