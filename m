Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F342CC00140
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 15:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiHLPUY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 11:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiHLPUX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 11:20:23 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18783B26
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 08:20:21 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qn6so2545555ejc.11
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=rtQ2oj7YSn/gbh3jMKvBJQDThusJmtQ8+ZqWZmJSXcA=;
        b=aI3Lgtkys5nGO/IzF9hKpacnqblRSZ8BULX6iKtqVwXw96On7EY67hsUqnsnARm10O
         Qm+9INAzLurLw622ZfF469LHTkzda70y2lZJcjwLQnhd414+DYtIzAj1q6TreKowJVpv
         0eTf8DmRj6TinmoH6LyrFol8JN/VltD0DHeoQe+gCQKB/Us4iaVKIARt4CPPJYLUlgD+
         IboMJnrrITy4Fjyn73tjxDTO6nFsDz/Hvk9Yz8h9Hx3QbNZMX9fsLmKPYTZTKQgb039i
         0p44nD+lDO1yCaJrdRGjODCmxpaRookG4rUw/d7+ZzUTNop02aT2A46uF/eEVRlXkFBc
         s+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rtQ2oj7YSn/gbh3jMKvBJQDThusJmtQ8+ZqWZmJSXcA=;
        b=HcZy7lhMmu+rOw8DlceMcjzEQcCID8iM5+w6HhXISobQwWEUJo0nQwncr2UNVc6MRY
         fL5PmgVN0LcUkvIf2Zgp92aT5ajVv7iIOQXhghpsNlR48N7+N4CQZ3fdbu6UllrRjkma
         qXXawkp7PjKtSSKWrjeS++n/rpTwLoFiILQ2Mb2x5/4vJaTnVueLX6SP9sp08ic3n3SC
         hSrKXuUtZEQ6ohDh8wGy4H2XrocezOTewAgu24sTQBFdJ5p7pOBnV6K9AzRxfFdVMk/I
         8QzZYm8VPZkFEluOXtEoAIhevzY/zTAj7ZPLsin1wJEe6BdnM3ddH76yAvgROPF/mFxj
         OIkA==
X-Gm-Message-State: ACgBeo2Hia57QkHlgVSrhxlrHtxNkGyq69XgiXCHz1AApzTbFOMH2jWI
        leSkxNeIaOXxunTfzhdTOy8oqw==
X-Google-Smtp-Source: AA6agR63EJQsWA71K1V6fzcjfi7FR6X9gMKdVMyzigLyDpWASNPHDzfJrpwYA4KNxpl2dwBuNQXp+Q==
X-Received: by 2002:a17:907:75e7:b0:730:bc2f:b26a with SMTP id jz7-20020a17090775e700b00730bc2fb26amr2964073ejc.738.1660317619472;
        Fri, 12 Aug 2022 08:20:19 -0700 (PDT)
Received: from leoy-huanghe ([104.245.96.132])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090680c500b00734b2169222sm873749ejx.186.2022.08.12.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:20:19 -0700 (PDT)
Date:   Fri, 12 Aug 2022 23:20:10 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/17] perf c2c: Support data source and display for
 Arm64
Message-ID: <20220812152010.GA74978@leoy-huanghe>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
 <YvO0nAZ1znppjKjZ@kernel.org>
 <20220811064122.GA860078@leoy-huanghe.lan>
 <YvZK20NEoIQATSH/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvZK20NEoIQATSH/@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 12, 2022 at 09:43:07AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > One question: should I later continue to upstream the first patch for
> > syncing the kernel header perf_event.h after Peter.Z comes back?
> 
> yes, and we may have to backtrack and find some other way to implement
> this if he is opposed, as he in the past didn't like
> perf_event_attr.type namespace being used by userspace only records such
> as PERF_RECORD_FINISHED_ROUND, PERF_RECORD_COMPRESSED, etc.
> 
> In this case its different, I think its ok as we already have
> PERF_MEM_SNOOPX_FWD and PERF_MEM_SNOOPX_PEER probably will be emitted by
> the some of the architectures, from the kernel, right?

Yes, as I know x86 generates memory samples from kernel, and SNOOPX_PEER
can be a useful snooping flag for other archs.

As a last resort if SNOOPX_PEER is rejected, we can rollback to use
existed flag (like reusing PERF_MEM_SNOOPX_FWD), though this would be
ambiguous for expressing the memory operations on Arm64.

Thanks,
Leo
