Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78099C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 07:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E10360ED7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jul 2021 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhGWGbf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbhGWGbe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jul 2021 02:31:34 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19228C061757
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jul 2021 00:12:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so2362626plm.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jul 2021 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B4pG5X92n/pg5azzZDZyLdDsyeHis75paHHHy3/0sK4=;
        b=hDXynN/MXkoVdK5vfUN2Uq+JsGwfyDkLpdp9vKKyIZm1j7wl6RFjzSJ/U1poKmWBHd
         ZYHPH/xXHmDteW3YISF2z7Mgt74TEiTPFNcJZRszGwUaTphtOpNPQLKsGrF8GTM/t0bS
         pUOfFK8dvYQb2CcA0htsXpnXHt3FANpN663kNeyiXFEjhQfffDzCB14WfhLNDskhUghH
         qSnQ4yYZnKfVntehKgfLOb715qs+npc+DvHBgHcBO3AlneM6E712OA2q/YRaUxdyOLuc
         5zpSXpaH9aGM6yQ+imbqvzevn8Y+CJxMhDCpqKLM/w7QIgBWSuXNrE7V3GnRAkRoyo0P
         IiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4pG5X92n/pg5azzZDZyLdDsyeHis75paHHHy3/0sK4=;
        b=Zgh52gAGJzhECh3F/szvp9EHSaLz8uWjX5LDXYMvc6VspdrtRXmUhlLE7X0EAKsDMI
         u9GOhzNDau50vudpxrt0yF7CkzM4F0plPC1Nd2eOnndcVGoESawAbXa9L/xaPsAYQ2dD
         Yen5iPTM+uSySz0gcBTbrHEYAZ3BvXmPpzg92zcULz+5uoCjnPQilGx3kTsTbytzEDXr
         e/IcgaWuixJXSoZqVYX/R8U5r86iq5Qwt+eU91Rh01eInuf8VA0B/C51hAOLPAvQm9g3
         n2grknHpmy67cse6P5v71IKKGI7EcKmt3iwI/JQfDzirzJDkK/sC0jSCUEAa3th27SfJ
         ihKg==
X-Gm-Message-State: AOAM532sEFGc90ZvGGOGhD17PloaydC0dgiCNMLQW08M28D3+bfEuQI9
        z69Y7hqr+qC4qEfAn/Hq4Fl1ag==
X-Google-Smtp-Source: ABdhPJzltA+1/fGBVtRfH6ySuIQYPXO1zU/U8FHD4pWJ4597K4g8VMOR4HZ+7M//ZFE+V+jEBXf2Bg==
X-Received: by 2002:aa7:95a4:0:b029:332:f4e1:1dac with SMTP id a4-20020aa795a40000b0290332f4e11dacmr3154708pfk.34.1627024327574;
        Fri, 23 Jul 2021 00:12:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id z24sm4971018pju.55.2021.07.23.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:12:06 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:11:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
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
Message-ID: <20210723071159.GF179035@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
 <YOyGi9Zdrio7OmBX@kernel.org>
 <20210713150953.GC748506@leoy-ThinkPad-X240s>
 <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
 <YO7t1UTrPh4TsiI9@kernel.org>
 <YO7uDIQYB9wduMd6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO7uDIQYB9wduMd6@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, Jul 14, 2021 at 11:00:44AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > So, I wasn't suggesting to add this info to the perf.data file header,
> > just to the in-memory 'struct perf_env'.
> > 
> > And also we should avoid unconditionally initializing things that we may
> > never need, please structure it as:
> 
> Oops, forgot these:
>  
> > static void perf_env__init_kernel_mode(struct perf_env *env)
> > {
> >        const char *arch = perf_env__raw_arch(env);
> > 
> >        if (!strncmp(arch, "x86_64", 6)   || !strncmp(arch, "aarch64", 7) ||
> >            !strncmp(arch, "arm64", 5)    || !strncmp(arch, "mips64", 6) ||
> >            !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> >            !strncmp(arch, "s390x", 5)    || !strncmp(arch, "sparc64", 7))
> >                kernel_is_64_bit = 1;
>                  env->kernel_is_64_bit = 1;
> >        else
> >                kernel_is_64_bit = 0;
>                  env->kernel_is_64_bit = 0;
> > }
> > 
> > 
> > void perf_env__init(struct perf_env *env)
> > {
> > 	...
> > 	env->kernel_is_64_bit = -1;
> > 	...
> > }
> > 
> > bool perf_env__kernel_is_64_bit(struct perf_env *env)
> > {
> > 	if (env->kernel_is_64_bit == -1)
> > 		perf_env__init_kernel_mode(env);
> > 
> > 	return env->kernel_is_64_bit;
> > }

Thanks a lot for the suggestion; this is much clear for me, will spin
new patch set by following it.

Sorry for slow response due to my bandwidth was occupied by a task in
hand.

Thanks,
Leo
