Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B2C433B4
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B3E61209
	for <linux-perf-users@archiver.kernel.org>; Tue, 18 May 2021 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349923AbhEROUG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 18 May 2021 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349887AbhEROUG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 18 May 2021 10:20:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C309CC06175F
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 07:18:47 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id j12so7114705pgh.7
        for <linux-perf-users@vger.kernel.org>; Tue, 18 May 2021 07:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2wHtbqb3GnAkd/ansGxvRdnUMlv0tAjngpS3Ut55DkQ=;
        b=tbeuPzZnBOpl63n8aH9z2+hPT0CUbUKmFMJxONu+ajzNEzkNViKKe24Mp/e0akqIGP
         wyX6ekmCjXlPVXD6ytjv97k+OBlcqnTYv/OfRf79VQ0LyktdZjjptmy3c1tJj2KDhEgR
         5enKSg4dXKDBjqWvdg6vrTrEFLMj5aej6Qc6baVPEiZCgeSuLbcy4Me6/n9B6q7M1P0A
         JPjLk3D96lhFb1mSPuVqOrCR8sBJq9z0fs3DFCwrh2Dqzv1sFNwIzvoBnVZfH55oJEvT
         ScJcZX3lqkUf5Y8w3eMcFFJmBdtFku8Gv8Jyv/TjhCP68ZldW7Zlk+rSgy16d4ZlPByT
         oQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wHtbqb3GnAkd/ansGxvRdnUMlv0tAjngpS3Ut55DkQ=;
        b=ffu3nIUwQItCz0RzXWG4S8WKUic+/XG7hTwVsp5B6oxwIg7Ebzb4yo2hKfOTcjs+5o
         NDlxj+/DIkF1PkzpMjLUzzXOt5LP12CwBWpkqOnRm37/3HQLaGH2bP0L1woXnmbSrGTA
         DRjaFRgt4EMcOGjrAH8DBL6dSjnC9PiyZHHIYnquU7J9fw7q+IduvqNszT3Mx6YJnFxc
         Z549kK4srnd0P9XGRwY8tZ+qABcLtMx4ebpjS92gCkxFaGtTcjQANC7E8MTV2tE7wM2s
         pt1Jo9p2ai6824KYAq+G9rGvoCZ1KZ/+mQH9/Tl8FNp6vRmgtfHECoZDJdWdOmzXxNFb
         LjbQ==
X-Gm-Message-State: AOAM530iZWldXxBeTvnKUHV488lfrkzc+1d45+ksqk+7KahMm4cQSAU8
        6aiXi4CnYy6ZUGz0Nue8cigBdg==
X-Google-Smtp-Source: ABdhPJzDDQ8ejjsWVSxOzgQvCZ3RWejOeyiYH4g3nog3oIPnbA6KKNUqZSrFXBSClnMw06sEf8VjNQ==
X-Received: by 2002:a63:b10:: with SMTP id 16mr5372439pgl.90.1621347527263;
        Tue, 18 May 2021 07:18:47 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id d3sm12665925pfn.141.2021.05.18.07.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:18:46 -0700 (PDT)
Date:   Tue, 18 May 2021 22:18:37 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
Message-ID: <20210518141837.GE942578@leoy-ThinkPad-X240s>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
 <20210512152330.GA121227@leoy-ThinkPad-X240s>
 <YKO46nX17/GjqJjV@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKO46nX17/GjqJjV@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, May 18, 2021 at 09:54:02AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > Will follow your suggestion to respin the patch (and refine the code)
> > to remove the redundant condition checking for "opts->full_auxtrace".
> 
> Ok, so please collect his Tested-by and Reviewed-by and I'll wait for v2
> then,

Sure, will send the patches in tomorrow, sorry for some delay.

And thanks for reminding!
