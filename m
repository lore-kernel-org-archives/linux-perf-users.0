Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9DC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Dec 2021 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbhLBPjl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:39:41 -0500
Received: from foss.arm.com ([217.140.110.172]:36680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347849AbhLBPji (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Dec 2021 10:39:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83C2D142F;
        Thu,  2 Dec 2021 07:36:15 -0800 (PST)
Received: from [10.57.35.237] (unknown [10.57.35.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D97173F73B;
        Thu,  2 Dec 2021 07:36:13 -0800 (PST)
Subject: Re: [PATCH] perf: Drop -lstdc++ from OPENCSDLIBS
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Branislav Rankov <Branislav.Rankov@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Diederik de Haas <didi.debian@cknow.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
From:   James Clark <james.clark@arm.com>
Message-ID: <8a5aead5-369d-5c0b-1ef7-362f777c5b9a@arm.com>
Date:   Thu, 2 Dec 2021 15:36:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202134337.1109300-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 02/12/2021 13:43, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <uwe@kleine-koenig.org>
> 
> When cross compiling on amd64 for arm64 the build failed on my machine with:
> 
> 	Makefile.config:493: *** Error: No libopencsd library found or the version is not up-to-date. Please install recent libopencsd to build with CORESIGHT=1.  Stop.
> 
> even though libopencsd was installed (for both amd64 and arm64). After
> some digging around I found the relevant error message in
> tools/perf/feature/test-libopencsd.make.output:
> 
> 	/usr/lib/gcc-cross/aarch64-linux-gnu/11/../../../../aarch64-linux-gnu/bin/ld: cannot find -lstdc++

Do you have this library installed for arm64? I know you said you had OpenCSD installed, but
maybe the arm64 stdc++ lib is missing?

> 
> Instead of fixing the error message to also include a request to install
> libstdc++, just drop -lstdc++. With this change the build completed.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> not sure this is a pure cross compilation problem. I think in general
> it's a bad idea to link against libstdc++ explicitly. Still more if
> there is no C++ involved.

This -lstdc++ was only just added a few months ago by Branislav so I'm
not sure if it should be removed. OpenCSD does use C++ so it is involved,
although I would have thought that stdc++ was a dependency of opencsd so
it would automatically get pulled in.

@Branislav, what was the build error that you were fixing with the recent
change? I checked the commit message but it's not listed.

James

> 
> Best regards
> Uwe
> 
>  tools/perf/Makefile.config | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index afd144725a0b..dc946b7a802e 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -143,7 +143,7 @@ FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
>  ifdef CSINCLUDES
>    LIBOPENCSD_CFLAGS := -I$(CSINCLUDES)
>  endif
> -OPENCSDLIBS := -lopencsd_c_api -lopencsd -lstdc++
> +OPENCSDLIBS := -lopencsd_c_api -lopencsd
>  ifdef CSLIBS
>    LIBOPENCSD_LDFLAGS := -L$(CSLIBS)
>  endif
> 
