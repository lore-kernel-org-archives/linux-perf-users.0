Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279C1C07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0350E613C3
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 14:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhGNODj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 10:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231765AbhGNODj (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 10:03:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E284613C5;
        Wed, 14 Jul 2021 14:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626271247;
        bh=xGY4cSgMPI+T6Zv4LZaM0MnuIapjyecxgtZFl42X6mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IM0MNWWv/4INkWFcLSgm0kg4IQ3zpcwuGpQ15LgAzwEAJluisAX97roEKU7yaX8rr
         vfBVIOKPOXJh8ulvMjeVGq0mvqDmATTHoqwqDvpl0hyVHDUDiDxUX2Pg5gF9H29Hbw
         k3p1lZxOmPTJBsa2bRZoBOCbD2tiEZskGjD8Gc3DOZR2S6y5bQnBh3yfSAIQh1SwDG
         UcaARyTFlZBDwISKBqjc1+QQMqtEZLA96QjUmr+obv3dxKFsXPow+zC/SWSEb/sizN
         7tFDCC9XhfTeqij+O8cgHPuVVeb5eFX1Q5dt076vmoSAf+k6hLNQJTqvxk9qS31rgz
         eRIszr9Q1hTNQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76DA2403F2; Wed, 14 Jul 2021 11:00:44 -0300 (-03)
Date:   Wed, 14 Jul 2021 11:00:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Hunter, Adrian" <adrian.hunter@intel.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Message-ID: <YO7uDIQYB9wduMd6@kernel.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
 <YOyGi9Zdrio7OmBX@kernel.org>
 <20210713150953.GC748506@leoy-ThinkPad-X240s>
 <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
 <YO7t1UTrPh4TsiI9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO7t1UTrPh4TsiI9@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Jul 14, 2021 at 10:59:49AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jul 13, 2021 at 05:31:03PM +0000, Hunter, Adrian escreveu:
> > > On Mon, Jul 12, 2021 at 03:14:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > Em Sun, Jul 11, 2021 at 06:41:04PM +0800, Leo Yan escreveu:
> > > > > +++ b/tools/perf/util/env.c
> > > > > @@ -11,6 +11,7 @@
> > > > >  #include <stdlib.h>
> > > > >  #include <string.h>
> 
> > > > > +int kernel_is_64_bit;
> > > > >  struct perf_env perf_env;
> 
> > > > Why can't this be in 'struct perf_env'?
> 
> > > Good question.  I considered to add it in struct perf_env but finally I used this
> > > way; the reason is this variable "kernel_is_64_bit" is only used during
> > > recording phase for AUX ring buffer, and don't use it for report.  So seems to
> > > me it's over complexity to add a new field and just wander if it's necessary to
> > > save this field as new feature in the perf header.
> 
> > I think we store the arch, so if the "kernel_is_64_bit" calculation depends only on arch
> > then I guess we don't need a new feature at the moment.
> 
> So, I wasn't suggesting to add this info to the perf.data file header,
> just to the in-memory 'struct perf_env'.
> 
> And also we should avoid unconditionally initializing things that we may
> never need, please structure it as:

Oops, forgot these:
 
> static void perf_env__init_kernel_mode(struct perf_env *env)
> {
>        const char *arch = perf_env__raw_arch(env);
> 
>        if (!strncmp(arch, "x86_64", 6)   || !strncmp(arch, "aarch64", 7) ||
>            !strncmp(arch, "arm64", 5)    || !strncmp(arch, "mips64", 6) ||
>            !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
>            !strncmp(arch, "s390x", 5)    || !strncmp(arch, "sparc64", 7))
>                kernel_is_64_bit = 1;
                 env->kernel_is_64_bit = 1;
>        else
>                kernel_is_64_bit = 0;
                 env->kernel_is_64_bit = 0;
> }
> 
> 
> void perf_env__init(struct perf_env *env)
> {
> 	...
> 	env->kernel_is_64_bit = -1;
> 	...
> }
> 
> bool perf_env__kernel_is_64_bit(struct perf_env *env)
> {
> 	if (env->kernel_is_64_bit == -1)
> 		perf_env__init_kernel_mode(env);
> 
> 	return env->kernel_is_64_bit;
> }
> 
> One thing in my TODO is to crack down on the tons of initializations
> perf does unconditionally, last time I looked there are lots :-\
> 
> - Arnaldo
>  
> > > Combining the comment from Adrian in another email, I think it's good to add
> > > a new field "compat_mode" in the struct perf_env, and this field will be
> > > initialized in build-record.c.  Currently we don't need to save this value into
> > > the perf file, if later we need to use this value for decoding phase, then we
> > > can add a new feature item to save "compat_mode"
> > > into the perf file's header.
> 
> > > If you have any different idea, please let me know.  Thanks!

-- 

- Arnaldo
