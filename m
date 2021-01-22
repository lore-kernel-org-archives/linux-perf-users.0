Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB3C433DB
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0BB239D1
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 14:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbhAVObs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbhAVObk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 09:31:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33EC06174A
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2021 06:31:00 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id p15so3759578pjv.3
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2021 06:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16Oq6hPfzYZOD2QSyxynAI/FEQLP+ZGXA1M3xH+bIqU=;
        b=uM5MCnfMgg3zSLWTyrtzBr/G3pvddXBY97152WnUTtXPdz2WvCDHVjBSQZvAlc7H/8
         A2EdlJPisiWHWYhBim2xikw+7GHCESkDCxg2gazoSN99GkH5+nGCYU9ESeFpC8uFzxPT
         M2U/awVJYzK9D1KoB7nHqP0NUiHRlFAAPj3+12yed0wdY2PjnAO8IClM/5F0p+I3h+4i
         8joO3UVEJGBAeiMJb/6kujZzegz94gPbNAjyBefjChsnLzhlujqEfDrwH7nH0tbbhmNb
         U/Wu3vkVeRbDIJJmQtCky7xg/4EfVYNMig3taFxyA8PyFYBp4MscsomhUB7FDhTHYlmO
         TB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16Oq6hPfzYZOD2QSyxynAI/FEQLP+ZGXA1M3xH+bIqU=;
        b=eSFSfJY52lwIsJ4J9nwvgpJ0p4DczEoCyGgNoMCWmJgKMa3oELTH0oMogRaB6k8vqe
         K00gOlLafUOHqC8ZMRuluO2J9luXd9TNwoj5fVslX4pc5mqHljs1sEybpmpFhQxRmBSz
         Yv+OkXZj0kgx0AwdyEs+QqmbPawJupmgQdqqx4JdQ6scjcoWwEzuXe4OjnSemtdXXVDc
         gTDmyWebNCyoAvYSyxpo7pSuJQNW+MSrwgnIuYB/103K4LfInwv25kwyfMcR65Jq/MrU
         v1RHKtLAVkUFuWRTNoKBoEHBgBS92zz265bUxut2gqMBMAueTEWrQlIImFnBWvctUeFI
         RBCg==
X-Gm-Message-State: AOAM532VisnD7N8EykfGxqCP8ApaLsCEpLK2CajwagpNk5ZtKnSDp3rf
        5a33Fl6RN/4bBDjJXOv7m0t5Ag==
X-Google-Smtp-Source: ABdhPJy992uyk/UUaI8AYSj1lvx5f7pPzprAAT6xcNbEGxC7l7N+halNfhBizULxbJbvCfQhIHYjWw==
X-Received: by 2002:a17:90a:6809:: with SMTP id p9mr5591523pjj.112.1611325859427;
        Fri, 22 Jan 2021 06:30:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([64.120.119.108])
        by smtp.gmail.com with ESMTPSA id kr9sm9836616pjb.0.2021.01.22.06.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:30:58 -0800 (PST)
Date:   Fri, 22 Jan 2021 22:30:52 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/8] perf arm-spe: Enable sample type PERF_SAMPLE_DATA_SRC
Message-ID: <20210122143052.GD4976@leoy-ThinkPad-X240s>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210122125157.GG356537@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122125157.GG356537@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Fri, Jan 22, 2021 at 09:51:57AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 19, 2021 at 04:46:51PM +0200, James Clark escreveu:
> > From: Leo Yan <leo.yan@linaro.org>
> > 
> > This patch is to enable sample type PERF_SAMPLE_DATA_SRC for Arm SPE in
> > the perf data, when output the tracing data, it tells tools that it
> > contains data source in the memory event.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> I see two Signed-off-by, ok, any Reviewed-by?

I had no confidence for some changes in the patch series, since James
is more easier to reach out hardware persons, so James kindly took over
and refined the patches (Thanks a lot!).

I hope Al could take a look for the patches, and myself also will give
a review and test for this series.

P.s. @James, I think some patches have been refactored, so it's good
to add "Co-developed-by:" tag or changing the author name for you.
Will comment on this when I review patches.

Thanks,
Leo
