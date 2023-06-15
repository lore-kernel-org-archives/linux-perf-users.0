Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5AEEB64D8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jun 2023 01:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjFOB05 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjFOB0x (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jun 2023 21:26:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3609026A4
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 18:26:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666729f9093so962573b3a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Jun 2023 18:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686792411; x=1689384411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1wdQ4hMB3hMS0E+Dw9a/ZO6zl9PRKqCaZb3GUi1TdKI=;
        b=PrHKGOCHbRXNdSaYeoH7o9qGme3TbtaEHWITt0X7F8NfAApQQkmc1dIPrkq6NfG0Do
         YUKBoHm8rn0MpLQjL/QyQpzHhpthqRr50d0N7JBFTRL1jYIOrFckNy7CokvsdHdTyBSk
         Jtud8z1dw9FV4rCJCF5fb0jaH4B7io+0Idw+MJ4wcsxxiLgtl7ewcUxpwUx1tAPccDci
         Tk0dYm7I/Eg/SGeqjX7iKBx77LhcaFMkACA8MmEX+bLg+en2mZJiRuCHRF+5bU1o+TId
         CanL0F+nDfR4nWlv8VhQAjSNm1PHtWJodEaLUyJ8lfxHubWQM1U8waxhjQn+YRahWKj1
         GIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686792411; x=1689384411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wdQ4hMB3hMS0E+Dw9a/ZO6zl9PRKqCaZb3GUi1TdKI=;
        b=ipyee3lRsMAX2x+zAXIpxR7bkSB7i0Cbf4YVQYdjzyevGAIVX9uXXYBkmBmYEi6i0M
         M/miXisG3rHo389at/2GI8hM6CUgcQgoSAdw2PcU8T7ZrNBOOvh8MaDVoKy48Q1bCA15
         OnGTXbzYTScQB4oxehEMJfbcZZkaFNTRlfgelZ+al+LqDJAhWNVuz/2QX1XGnbQ0WBrn
         preCA+qebbJnuJDkG5U/1rBOQIr4LnIEU8MSa5KlEPdTqonpai2Nd6GIKKyDy/6PNvlZ
         My4Kj7VkH889pAddFVYSopi/7El5fVcbBAC7mlzBLeAVxviJccYo63YwjdOkeEyihs7h
         YZkA==
X-Gm-Message-State: AC+VfDwuIlNZ395bEA4V1ADD01w2pNcfzAjyq/HANEJ9f+0x2w5zrJEO
        WjPOIsUwt0M8piLgY4aOCbHH7w==
X-Google-Smtp-Source: ACHHUZ6X2rgbf5Oc9PcPxODJMLRh5TJDx7TL5LoTuVoB7Bt9V0A+4kfk+/VHsYVQFMPVY+tASAE7XQ==
X-Received: by 2002:a05:6a21:6811:b0:118:b2e1:9adb with SMTP id wr17-20020a056a21681100b00118b2e19adbmr3114281pzb.61.1686792411552;
        Wed, 14 Jun 2023 18:26:51 -0700 (PDT)
Received: from leoy-huanghe.lan ([39.144.43.103])
        by smtp.gmail.com with ESMTPSA id h25-20020aa786d9000000b0065055ad5754sm415054pfo.64.2023.06.14.18.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 18:26:51 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:26:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        Aishwarya.TCV@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf tools: Add a place to put kernel config
 fragments for test runs
Message-ID: <20230615012546.GN217089@leoy-huanghe.lan>
References: <20230614140219.2335639-1-james.clark@arm.com>
 <ZInLBt9q2F99gTg8@kernel.org>
 <d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d02cce4a-47b1-a776-0d3a-a6a7c9a4d8fd@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 14, 2023 at 03:19:12PM +0100, James Clark wrote:
> On 14/06/2023 15:13, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Jun 14, 2023 at 03:02:19PM +0100, James Clark escreveu:
> >> We are currently keeping something like this in our CI because defconfig
> >> doesn't give full coverage. It's not complete yet, but is a starting
> >> point as a place to add to when a specific test needs something extra to
> >> run.
> >>
> >> The RFC is for discussion on folder placement and file naming etc.

I am wandering if we can put these configurations into kselftest (the
folder tools/testing/selftests/).  You could see now kernel build has
already provided option to merge kernel configurations for kselftests.

> > Would be interesting to add the Kconfig maintainer to see if they have
> > an opinion, Masahiro?

Yeah, looking forward suggestions from Masahiro.

> > - Arnaldo
> >  
> 
> One concern I have is that uname -m gives a different result to the
> ARCH= option for a kernel build (ARCH=arm64). Probably the build time
> version is more useful to us so maybe that should be the file name.

If we want to fit into kernel's build system, I'd like to use "arm64"
rather than "aarch64" as the folder name.

Seems to me, it is a legacy issue for using "arm64" as ARCH variable in
Makefile, given we cannot change this, then the folder name 'arm64' would
be easier for us to extend kernel's Makefile for building kernel of perf
testing?

> Not sure what the x86 version is or if anyone is actually doing cross x86
> builds...

I don't understand this question and not sure if you are asking cross
builds for kernel or perf.  Maybe a good reference for arch naming is
the file scripts/subarch.include.

Thanks,
Leo

> >> Signed-off-by: James Clark <james.clark@arm.com>
> >> ---
> >>  tools/perf/tests/config-fragments/README  |  7 +++++++
> >>  tools/perf/tests/config-fragments/aarch64 |  1 +
> >>  tools/perf/tests/config-fragments/config  | 11 +++++++++++
> >>  3 files changed, 19 insertions(+)
> >>  create mode 100644 tools/perf/tests/config-fragments/README
> >>  create mode 100644 tools/perf/tests/config-fragments/aarch64
> >>  create mode 100644 tools/perf/tests/config-fragments/config
> >>
> >> diff --git a/tools/perf/tests/config-fragments/README b/tools/perf/tests/config-fragments/README
> >> new file mode 100644
> >> index 000000000000..e816cfb1b96d
> >> --- /dev/null
> >> +++ b/tools/perf/tests/config-fragments/README
> >> @@ -0,0 +1,7 @@
> >> +This folder is for kernel config fragments that can be merged with
> >> +defconfig to give full test coverage of a perf test run. This is only
> >> +an optimistic set as some features require hardware support in order to
> >> +pass and not skip.
> >> +
> >> +'config' is shared across all platforms, and for arch specific files,
> >> +the file name should match that returned by 'uname -m'.
> >> diff --git a/tools/perf/tests/config-fragments/aarch64 b/tools/perf/tests/config-fragments/aarch64
> >> new file mode 100644
> >> index 000000000000..64c4ab17cd58
> >> --- /dev/null
> >> +++ b/tools/perf/tests/config-fragments/aarch64
> >> @@ -0,0 +1 @@
> >> +CONFIG_CORESIGHT_SOURCE_ETM4X=y
> >> diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
> >> new file mode 100644
> >> index 000000000000..c340b3195fca
> >> --- /dev/null
> >> +++ b/tools/perf/tests/config-fragments/config
> >> @@ -0,0 +1,11 @@
> >> +CONFIG_TRACEPOINTS=y
> >> +CONFIG_STACKTRACE=y
> >> +CONFIG_NOP_TRACER=y
> >> +CONFIG_RING_BUFFER=y
> >> +CONFIG_EVENT_TRACING=y
> >> +CONFIG_CONTEXT_SWITCH_TRACER=y
> >> +CONFIG_TRACING=y
> >> +CONFIG_GENERIC_TRACER=y
> >> +CONFIG_FTRACE=y
> >> +CONFIG_FTRACE_SYSCALLS=y
> >> +CONFIG_BRANCH_PROFILE_NONE=y
> >> -- 
> >> 2.34.1
> >>
> > 
