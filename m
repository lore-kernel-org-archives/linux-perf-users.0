Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A787C4743D
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 01:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7503561182
	for <linux-perf-users@archiver.kernel.org>; Wed,  9 Jun 2021 01:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhFIBmX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 21:42:23 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:34720 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhFIBmV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Jun 2021 21:42:21 -0400
Received: by mail-pj1-f53.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2730092pjx.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Jun 2021 18:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/d3k4uICSgLjCjjIICNIctgXwaLJ2Iz2BJO+iXE+CTE=;
        b=Ce1GhVArmiYuuqT3j94UWVmFQjeZPH3AVVC2vYIteA7rQdnD0WFRDvMmtGayLw+riE
         Sp6so76C+tLWPyEOllGZzFeMuO3ooazJwBFesKhcWXaWAfwVPx1hmzILRlRt1Kbf648j
         ZhCkC7sb07qz2RjQcnXgzD11+7EvDvyxfJaFQeZNDo5K9zLTfAIRovvm9SqucfB8y8Pg
         aZ0mEqBWkPv4puVReUYxXzc49m9jaEUKPj2DAUr4oe/hRbmaeBMeyHQZ7yAx9kaHGeFh
         1CBxvjDOrMiKF6MaC0CW4475LMcDvZp2k0ew8w/rkX0KgiJgmb916EC+3X1yjlMAPRfu
         h3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/d3k4uICSgLjCjjIICNIctgXwaLJ2Iz2BJO+iXE+CTE=;
        b=GJetSkgywzOdUTb7yvdMy/hODPEk6H7ot4Z2ZX05qjF8rlUdffV2lThY6BYXZ05pj7
         xSTLXw0mnmNoPrzoWYk+0uryPwzVtOrdbd5adGC4ugC4JcEMaP1MjUM7A7rdlwMOrYs6
         8tkKf26683z3n5gavdDG+Lv9agL4CFkngxJUyEORpYov7PZVx8XyYXfMqt/joaQ3ifoJ
         yGegScJn1HRwIvLZfDanMzIPfUAFCPVJW+Tc14bqJs5bcNnHlLIwXWjsLzQJt8p0sDyo
         5XVjfnVc/3waes8smu6Er9OS4AI+055LJYGUJisMvyGUfHxaDOXlmwpKWe4viKLipRly
         4/kA==
X-Gm-Message-State: AOAM532trFOWb827V8YE5FJy81lJ0F5+nXsrhnwIZnXX1ZkCSa5QVH0V
        q3wsZh/UHixUwDRFielhERnTxQ==
X-Google-Smtp-Source: ABdhPJy0fGqUCQQPXLN28cPcP97FKbCAmwU7xD+S4UOlHjhmhegG8QJK9GpXyIrEx+rq3flbIZuqvg==
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr238868pjp.1.1623202755591;
        Tue, 08 Jun 2021 18:39:15 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id f17sm12272157pgm.37.2021.06.08.18.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:39:15 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:39:09 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
Message-ID: <20210609013909.GE4640@leoy-ThinkPad-X240s>
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
 <20210608214149.GA331611@p14s>
 <20210609013555.GD4640@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609013555.GD4640@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 09, 2021 at 09:35:55AM +0800, Leo Yan wrote:

[...]

> > The problem with this approach is that if the AUX buffer is 4MB and the CS
> > buffer is 1MB then we only record 1MB, but because of N:1 topologies we may not
> > be able to do better.  I haven't looked at the code yet, something I will do
> > tomorrow.
> 
> Yes, the fixing in this patch copies the trace data is limited by the
> CoreSight bounce buffer length.  So if CoreSight buffer length is
> 1MiB, then we have no chance to allocate 4MiB for AUX buffer.

Sorry for typo, just correct:

if CoreSight buffer length is 1MiB, then we have no chance to *copy*
4MiB trace data for AUX buffer.
