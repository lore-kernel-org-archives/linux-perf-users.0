Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6045CC433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3951B61001
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 15:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245605AbhDPPHi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 11:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbhDPPHi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 11:07:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D30C061756
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Apr 2021 08:07:12 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e2so9823269plh.8
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Apr 2021 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qvRPd9mJKRx11Shv+OyTN/o/Bvjy/gaC5xNSiISaZwo=;
        b=g08ANfEZT2d6VY2y52OdJOvS9/b1mZSA7c+Jo1sA2FPH8q9i+09GskgqqXvKUdkSOx
         iu+y+gK8WpaNyA1V6z0XT0TBhreeLBI7aJM7oeDrKwdaeWEZN6vY54tnEpTmqK/obSTe
         FaAi9VsJM5SHEqfam9+6cCvsCAwwlmwgC79oYHhb9WdD5i0K59EdQBXEXyodLndfRBpl
         NnCacMIFBKoZUTG0epfo1NbtUn19WXN8yAIuY6Ob1faQMb/6Tn3pYntUNub3bnIYMauj
         Qd1WSq8tp28qVml5F7HkyqUVX0qR89M3nUTMTlpCXCANmB2Z5DBKQDc5T/lLxCag8Nq2
         eE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qvRPd9mJKRx11Shv+OyTN/o/Bvjy/gaC5xNSiISaZwo=;
        b=DKc1kyMUo8kpZOuX4jTU0Mlpt2Io4XBC7bYNBAWc2LqgmTJk4fqOgyvgOR/CrBLJv0
         3HlgFsBnwu5skZvevkkN5Nt3WeJ/8iHS29as7DpPlNIqFiGhaHt2Nzob85o+eM5C9OZa
         fxQguQIbnhHvVtYG4fVREy0sbD4sGJvIOv5s/25G/5nLOWH9KuShIXd+hmNfw4nIk4EZ
         5iawi6RX6zXNYBTZCvOOZpc4GvpsZp3mNMj35Xji/57bsYIa/m9q5H07XdGyV2uJ4rcB
         qyDUf9tJqh8VkvVKi5QFAxJMPvwSen/HUX0R3ywDE22/rL6YoYl+oUGNVYKCcMP/kt17
         5svw==
X-Gm-Message-State: AOAM532zFy2ng9zt9fo6Nf22De99bPb57eKdyPR1FLYTT0ZpzYGEWvzA
        EZAygJ+jueS+CcrgzSg+tRNlsRufdhXnnQ==
X-Google-Smtp-Source: ABdhPJw/TvRlw4eu+nGgPjVquPv+r/N1Q8Ytb4wzK/E+5VbvXcS28/9OfbX37TdfIIoycQvIdJO+/Q==
X-Received: by 2002:a17:903:2310:b029:eb:73d5:3e4e with SMTP id d16-20020a1709032310b02900eb73d53e4emr9661606plh.66.1618585631641;
        Fri, 16 Apr 2021 08:07:11 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t184sm5196525pgt.32.2021.04.16.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:07:11 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:07:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210416150709.GA1046932@xps15>
References: <20210416105632.8771-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416105632.8771-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi James,

On Fri, Apr 16, 2021 at 01:56:30PM +0300, James Clark wrote:
> Changes since v1:
>  * Improved variable name from etm_timestamp -> cs_timestamp
>  * Fixed ordering of Signed-off-by
> 

You forgot to add the RB and AB you received.  Since Arnaldo is responsible for
the perf tools subsystem, please send another revision.

Thanks,
Mathieu

> James Clark (2):
>   perf cs-etm: Refactor timestamp variable names
>   perf cs-etm: Set time on synthesised samples to preserve ordering
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
>  tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 39 insertions(+), 35 deletions(-)
> 
> -- 
> 2.28.0
> 
