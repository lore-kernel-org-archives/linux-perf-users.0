Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24173C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Dec 2021 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbhLFKS3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 6 Dec 2021 05:18:29 -0500
Received: from foss.arm.com ([217.140.110.172]:53002 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233768AbhLFKS3 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 6 Dec 2021 05:18:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB01C152F;
        Mon,  6 Dec 2021 02:15:00 -0800 (PST)
Received: from [10.57.34.109] (unknown [10.57.34.109])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5061B3F73D;
        Mon,  6 Dec 2021 02:14:59 -0800 (PST)
Subject: Re: [PATCH v2] perf: Drop requirement for libstdc++.so for libopencsd
 check
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Adrian Bunk <bunk@debian.org>
References: <20211203210544.1137935-1-uwe@kleine-koenig.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <2d97dd02-fd30-005e-5578-065706986a0c@arm.com>
Date:   Mon, 6 Dec 2021 10:14:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211203210544.1137935-1-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 03/12/2021 21:05, Uwe Kleine-König wrote:
> It's possible to link against libopencsd_c_api without having
> libstdc++.so available, only libstdc++.so.6.0.28 (or whatever version is
> in use) needs to be available. The same holds true for libopencsd.so.
> When -lstdc++ (or -lopencsd) is explicitly passed to the linker however
> the .so file must be available.
> 
> So wrap adding the dependencies into a check for static linking that
> actually requires adding them all. The same construct is already used
> for some other tests in the same file to reduce dependencies in the
> dynamic linking case.
> 
> Fixes: 573cf5c9a152 ("perf build: Add missing -lstdc++ when linking with libopencsd")
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>

Reviewed-by: James Clark <james.clark@arm.com>

Thanks!
> ---
>  tools/perf/Makefile.config | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index afd144725a0b..3311fa321754 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -143,7 +143,10 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
>  ifdef CSINCLUDES
>    LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
>  endif
> -OPENCSDLIBS := -lopencsd_c_api -lopencsd -lstdc++
> +OPENCSDLIBS := -lopencsd_c_api
> +ifeq ($(findstring -static,${LDFLAGS}),-static)
> +  OPENCSDLIBS += -lopencsd -lstdc++
> +endif
>  ifdef CSLIBS
>    LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
>  endif
> 
