Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22842C19F28
	for <linux-perf-users@archiver.kernel.org>; Wed,  3 Aug 2022 15:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiHCPZm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbiHCPZf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 3 Aug 2022 11:25:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7534E65C1
        for <linux-perf-users@vger.kernel.org>; Wed,  3 Aug 2022 08:25:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so16754740pfb.7
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Aug 2022 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vY5Gs44ObcZqhnAkDw1pnGHq29Y4iUKBpPeypGL8C04=;
        b=lJgAtu/cwXyf8s1wIwQZ0CNNCCdmo3JMXJHH0lscHNOrNNBxXncxE/VrJgKSC2OmjC
         NOerG+8+aBL44+OZSHHph5NPJruytt71lzo8W8GEOnfS5lwOAUxXXIw2UcxyknUXR/1L
         lrVum/jmFqx0a1SppZUxYzDhGpaUJrzClIxxqSDWVBqc1ZjPa2kFfiJJMtWL/QhR5YOu
         /SaveEvW+ChdAin3Rtr7GwieqNMZCrxQJSNTs8AQckr40CoFwDoWcA9et803Nq9RtZ7J
         lrZ+le+z4NnubOJuVZXbTqF06axzexzf8tC/L2kW1P/kN1hk1pcSDjSyrqdoaXFeehIc
         6pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vY5Gs44ObcZqhnAkDw1pnGHq29Y4iUKBpPeypGL8C04=;
        b=iD3kZ/jTvFDcAf4Dqozecg9VZBi7op/R4Uvv63tLLEh7YOdSd6qAlN/amapQTjeu6t
         Ux+XvVzcw+bt6iEOLHpqeQ5ty4id50v5DHVi041ynCQfjtHHFaNfLDAjk+EkOGOic6Af
         9S8vSmgiMwiSn19lfcJgr+wwaVG5P3s/+FNujnBhUYJkkclSPOLWWDzhE+IAKGky/U4U
         Q57y8/gTxO+FDEMhByn6Y9t8AOmqNAlQygc+vjuY/p/aL4AQfgEZ6IQnQQW7XLaH2aSK
         AL98PvvSr0KAE/6X+LUYaxNaUPDuLurKb6witkp6OWF7ixwRWQpKPEI+PO6Zn1fxhjJN
         rXNg==
X-Gm-Message-State: AJIora+gqsRjgzdgF5W+U8/Aw88EB8Pk3XPISlDA/T6ftPIC+2/etAX+
        BcSyTQdjmrXTJsFBDn9tEn40zA==
X-Google-Smtp-Source: AGRyM1vmGDb1Z3T7ofJ95dzDpNMA/3hyYgDtd8/HkcsQWLW3sJTFg2aNQGuKVlVz5njqGZrL2NFrHg==
X-Received: by 2002:a05:6a00:1a0c:b0:528:6baa:a2e3 with SMTP id g12-20020a056a001a0c00b005286baaa2e3mr26609309pfv.27.1659540332794;
        Wed, 03 Aug 2022 08:25:32 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (173.242.120.83.16clouds.com. [173.242.120.83])
        by smtp.gmail.com with ESMTPSA id h23-20020a17090a055700b001f3162e4e55sm1756596pjf.35.2022.08.03.08.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 08:25:32 -0700 (PDT)
Date:   Wed, 3 Aug 2022 23:25:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf symbol: Fail to read phdr workaround
Message-ID: <20220803152527.GA133193@leoy-ThinkPad-X240s>
References: <20220731164923.691193-1-irogers@google.com>
 <20220801015259.GA101027@leoy-ThinkPad-X240s>
 <CAP-5=fVSjCQ4jeAeyP5THnQVyXDpKd6Ob33C7PDwFB_6+YSXuw@mail.gmail.com>
 <YufJP5YqeEBM51HL@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufJP5YqeEBM51HL@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo, Ian,

On Mon, Aug 01, 2022 at 09:38:23AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> I also think we could have something like a 'perf test' mode where, when
> asked to, it would enable tests that involve downloading such files to
> perform tests, such as this dacapo benchmark, and then would test if the
> output matches expectations.

I am working on testing script for java symbols, one of the steps shared by
Ian is:

  # /tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so \
    -jar dacapo-9.12-MR1-bach.jar -n 10 fop

The question is how we can specify the path for the lib
libperf-jvmti.so in the testing script?

If we can run the test case from the root folder of Linux kernel
source code, the lib libperf-jvmti.so can be found in the folder
$linux/tools/perf, but for the integration testing the lib should be
placed in an installed folder.  Any suggestion if we have exited
way to specify the path for libperf-jvmti.so, or need to introduce a
new shell envorinment variable for the lib path?

Thanks,
Leo
