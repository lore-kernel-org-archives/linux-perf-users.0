Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD98C43334
	for <linux-perf-users@archiver.kernel.org>; Sun, 24 Jul 2022 02:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbiGXCix (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 23 Jul 2022 22:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiGXCiw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 23 Jul 2022 22:38:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B513DE2
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 19:38:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bp15so14783103ejb.6
        for <linux-perf-users@vger.kernel.org>; Sat, 23 Jul 2022 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9zI9fBZxwujK6HOrkcYBco4BzV/k8u6DXtuv9ktQciI=;
        b=Yp0tmsA0Qgu18B4cpMBdnP4DFvvoU787t3cqjpi4dITjh4U1HqUhLA7hcJRXDZ6Dxy
         KjhMC5//RVacmjTYad02NtptqI4ZsUK0vV+H/SsxmvAxDY4R18ZfzpG10MbU5cTZKOvZ
         2K1UDks1Bn/8UwLP6HdAVvTck5ByL8fY2FZiFH/lPU4S7HxjfYhxnB+zC7v5L6sziqGS
         Clut9fh2QPn0MG0lJ8TAF1dx40zs/O/5mxbiYAxUA4EOBjkYoadKiu0yKO8c2Sk/FkJD
         cbWFKb21rVQ447FfVxlIjh10mOnjaw7JbtpMMU7jEDPLQsEbmIfj5+5EnKn40LQXU/Ae
         wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9zI9fBZxwujK6HOrkcYBco4BzV/k8u6DXtuv9ktQciI=;
        b=dZ8dJTqk4ALk+kKi30afcT6N/NJNqN+vPn7Njl+8pWikjS+b7zxrx1mFkuSwF0WZba
         re3fJVaRuzpxFnUaQu1mPvSH8YTEqEWVC+GRjQdPknCBaV9T3HWJ7N1oX0RWwEih60XH
         oPv2Yv9uf0MAKL9cWJyxwHmWRMlWHlJpD7d2V0eeUe9yCagH17G+RzqA2Ugd7Gl7JAi5
         A2ig/OjsOnujMXgTkJSCRjOVOH7buSiJQucPJ+V9fUajY7Lfiud0FcOVroBV7fRbvLTO
         vTouU/U9axwI6DwAKL8LRfoP8vbjgvDpD7eJ/bGDIDCLzxsMM02xjA2CbGfsb7FrSZSA
         +RSw==
X-Gm-Message-State: AJIora9kycDYNMmw+YIy+e7OIUYzgTW4kbDmI5/DuRKfyq2VP85ipyJm
        WHYxj2R7/2iWHf52z7P7rDtW0A==
X-Google-Smtp-Source: AGRyM1sU/kaBPW9U0Le4UQnAgfrq9J1IHnM7bIODzZLJDJMqGlniJXVZSfTisN8/kFNKWxPqFHPaqQ==
X-Received: by 2002:a17:907:1623:b0:72b:64e3:878a with SMTP id hb35-20020a170907162300b0072b64e3878amr5289467ejc.185.1658630329495;
        Sat, 23 Jul 2022 19:38:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-144-7-244.us-west-1.compute.amazonaws.com. [18.144.7.244])
        by smtp.gmail.com with ESMTPSA id gr19-20020a170906e2d300b0072b2f95d5d1sm3733919ejb.170.2022.07.23.19.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 19:38:48 -0700 (PDT)
Date:   Sun, 24 Jul 2022 10:38:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chang Rui <changruinj@gmail.com>
Subject: Re: [RFC PATCH v1] perf symbol: Correct address for bss symbols
Message-ID: <20220724023840.GA82137@leoy-ThinkPad-X240s>
References: <20220710012204.2390293-1-leo.yan@linaro.org>
 <CAP-5=fX_fT7e9tqDBKXh_1CQ8w80iOXCGz2kJT_nHpY6wYWqmQ@mail.gmail.com>
 <20220711172706.rtfd6pp2pochmdre@google.com>
 <20220712040538.GB10379@leoy-ThinkPad-X240s>
 <CAFP8O3+dQi8b6C_f9bTb0TFpEmNjsroBv4agUpRKps2p3hpP+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3+dQi8b6C_f9bTb0TFpEmNjsroBv4agUpRKps2p3hpP+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Fangrui,

On Tue, Jul 12, 2022 at 08:29:52PM -0700, Fangrui Song wrote:

[...]

> > We need to create symbol info for not only .text section but also for
> > .data section and .bss sectionṡ.  So based on the data address, we can
> > know what's the symbol for the data access.
> >
> > But I need to correct the description for "st_value" [1]: In
> > executable and shared object files, st_value holds a virtual address.
> > To make these files' symbols more useful for the dynamic linker, the
> > section offset (file interpretation) gives way to a virtual address
> > (memory interpretation) for which the section number is irrelevant.
> >
> > So perf tool uses the formula "st_value - sh_addr + sh_offset" to
> > convert from the memory address to file address.  But it calculates
> > the wrong file address because "sh_offset" doesn't respect the
> > alignment.
> 
> Thanks for the explanation. I think st_value - p_vaddr + p_offset  may
> be a better formula where p_vaddr/p_offset is from the PT_LOAD program
> header.
> 
> For a SHT_NOBITS section, sh_offset may not be accurate, but PT_LOAD
> has precise information.

Thanks a lot for suggestion, it's very helpful and reasonable for me!

I struggled a bit for considering two things.  One is how to refactor
kernel symbol parsing with PT_LOAD program headers, because the kernel
symbol parsing is relative complex for both kernel symbols and module
symbols, this is why I didn't move furthermore for refactoring kernel
symbol parsing.

The second thing is I observe there have some spurious symbols with
'st_value' are zeros.  So there have an extra fixing for this case.

Welcome comments or suggestions for the new patch set:
https://lore.kernel.org/lkml/20220724022857.2621520-1-leo.yan@linaro.org/T/#t

Thanks,
Leo
