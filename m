Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D704FC07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 13:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD45A613BF
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 13:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhGNOCo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 10:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhGNOCo (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 10:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E646115B;
        Wed, 14 Jul 2021 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626271192;
        bh=ciqWDtVYgONNOfm9E/ppqgHeRpjIs0YIgjGKThSyD/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BIFb143TO2MsQ7gb5N0STowb9BJ4LR0vFpix2VsaRlvZaWI1/CbThYB7wJK78IhL7
         lQGfRCJJMBYgHb2o0w78yhG4r7ySBJvwiRv+lgJlQUO6r4fSeJbrD2V7MSt5UzGD82
         8RVvJuU9e5Nf9LjT8TboXwKC8yBhtWB5w5nCXt1h/8s+HDeZqAz1vMG/zT/9jXCL1C
         MbMrk8Y7OfoTVB15cgRmgFIaNgVlpLYfvYKsbrvrakAKtFe4rDQBeuU3IVSuCNd2Si
         AIvmwBtjowMbU2iaLezN61H8GmeCUimTyx2DnbmtcsfhQccLPd1545itkHJgyPBd7y
         hfipU7hIznWig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4A6B7403F2; Wed, 14 Jul 2021 10:59:49 -0300 (-03)
Date:   Wed, 14 Jul 2021 10:59:49 -0300
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
Message-ID: <YO7t1UTrPh4TsiI9@kernel.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
 <YOyGi9Zdrio7OmBX@kernel.org>
 <20210713150953.GC748506@leoy-ThinkPad-X240s>
 <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 05:31:03PM +0000, Hunter, Adrian escreveu:
> > On Mon, Jul 12, 2021 at 03:14:35PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Sun, Jul 11, 2021 at 06:41:04PM +0800, Leo Yan escreveu:
> > > > +++ b/tools/perf/util/env.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <stdlib.h>
> > > >  #include <string.h>

> > > > +int kernel_is_64_bit;
> > > >  struct perf_env perf_env;

> > > Why can't this be in 'struct perf_env'?

> > Good question.  I considered to add it in struct perf_env but finally I used this
> > way; the reason is this variable "kernel_is_64_bit" is only used during
> > recording phase for AUX ring buffer, and don't use it for report.  So seems to
> > me it's over complexity to add a new field and just wander if it's necessary to
> > save this field as new feature in the perf header.

> I think we store the arch, so if the "kernel_is_64_bit" calculation depends only on arch
> then I guess we don't need a new feature at the moment.

So, I wasn't suggesting to add this info to the perf.data file header,
just to the in-memory 'struct perf_env'.

And also we should avoid unconditionally initializing things that we may
never need, please structure it as:

static void perf_env__init_kernel_mode(struct perf_env *env)
{
       const char *arch = perf_env__raw_arch(env);

       if (!strncmp(arch, "x86_64", 6)   || !strncmp(arch, "aarch64", 7) ||
           !strncmp(arch, "arm64", 5)    || !strncmp(arch, "mips64", 6) ||
           !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
           !strncmp(arch, "s390x", 5)    || !strncmp(arch, "sparc64", 7))
               kernel_is_64_bit = 1;
       else
               kernel_is_64_bit = 0;
}


void perf_env__init(struct perf_env *env)
{
	...
	env->kernel_is_64_bit = -1;
	...
}

bool perf_env__kernel_is_64_bit(struct perf_env *env)
{
	if (env->kernel_is_64_bit == -1)
		perf_env__init_kernel_mode(env);

	return env->kernel_is_64_bit;
}

One thing in my TODO is to crack down on the tons of initializations
perf does unconditionally, last time I looked there are lots :-\

- Arnaldo
 
> > Combining the comment from Adrian in another email, I think it's good to add
> > a new field "compat_mode" in the struct perf_env, and this field will be
> > initialized in build-record.c.  Currently we don't need to save this value into
> > the perf file, if later we need to use this value for decoding phase, then we
> > can add a new feature item to save "compat_mode"
> > into the perf file's header.

> > If you have any different idea, please let me know.  Thanks!
