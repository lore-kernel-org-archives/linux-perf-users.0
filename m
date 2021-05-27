Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3B0C47089
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E072A613C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 May 2021 03:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhE0Dw3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 May 2021 23:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbhE0Dw2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 May 2021 23:52:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7570C061574;
        Wed, 26 May 2021 20:50:56 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j12so2679177pgh.7;
        Wed, 26 May 2021 20:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYI299XEFIsol2OXh3weOrnSRFxV3puLyyVk9BQ8SdE=;
        b=BMTba/gwToFKar+iGq6ZiegHVGnHyc5LzE1bZHkJwpGW/NiBWBBGjurXnliUTRNxPI
         ymiw5mW1JhC9xoKQajNxqc1a8hpcrH+QMk7WusD6Xcw1IU1S4NdW4uyp7kfionD4WCl4
         y3lZvxUptcAPjzvRp+CWLM7ooT0g+gjl2Rx6er62rUymzJhXc1o732Ftlr+0Eug+Py5f
         3u7FpBnm5/Twsy/qCs+JbepWF6NYUGNl0btcOnViWiV3EVkJyKgLZbR01uzj2qyQD3y8
         DiEQI51NE+u9fj6jBCFVAFWXn841GmGDtfB+xe/Ffz+XszyS1Lr8tC4xN309XOV4oHJQ
         QF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYI299XEFIsol2OXh3weOrnSRFxV3puLyyVk9BQ8SdE=;
        b=YiphtGB4IAsiPNbvPhT8DjTxkQTSPLVY0Q0cEMEr06TLOWJ2m351CVnUxVYt2yZtWe
         +Ib2yqVNjSEnFh7rOboaLv0718w9L+HCiAtrxDThwbsDzEnE0uNUEJy7Y5r0OstJ177e
         bC8VGGIT7vF4GF6Ae/U3FvT+oCRky6CkUS09GsrXxnhuiLAt2xFlzjQ4+uxMAYELWJp8
         dZ5iyxyJkPrCVHulFFtYLjmmrBrSJAoWc2aFTycN1V+hp+nd5ubHmI9SWkmyBcA6F0CV
         EPvHc68YI6uv1oq20AjXdm5st2nElKfPT75iGDrXK8C4HEVeOn3MXK7OXguHoYq754GG
         IqkA==
X-Gm-Message-State: AOAM531nyHflmfspdpkPKkRTG/L3e9ckmvmpkL27JGmLKpr4WrUQdsOI
        K6Ye5mEN5x2g6udBmoiyLw0=
X-Google-Smtp-Source: ABdhPJyhhWiVII5BEppJnt8s4RvjmVbu6inOUvlx96JpvLtTOBJ/9XNNyKcBfG0S+rivoPsQIvOAUw==
X-Received: by 2002:a63:581c:: with SMTP id m28mr1759791pgb.353.1622087456128;
        Wed, 26 May 2021 20:50:56 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id 25sm552196pfh.39.2021.05.26.20.50.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 20:50:55 -0700 (PDT)
From:   Haocheng Xie <xiehaocheng.cn@gmail.com>
To:     peterz@infradead.org
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        xiehaocheng.cn@gmail.com
Subject: Re: [PATCH 1/3] perf core:  Make local function perf_pmu_snapshot_aux() static
Date:   Thu, 27 May 2021 11:50:41 +0800
Message-Id: <20210527035041.10965-1-xiehaocheng.cn@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <YK45TSGv+DeuR8+X@hirez.programming.kicks-ass.net>
References: <YK45TSGv+DeuR8+X@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 26, 2021 at 07:52:18PM +0800, Haocheng Xie wrote:
> > Fixes the following W=1 kernel build warning:
> >   kernel/events/core.c:6670:6: warning: no previous prototype for 'perf_pmu_snapshot_aux' [-Wmissing-prototypes]
> >
> > Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
> > ---
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 6fee4a7..0d98d6a 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6667,7 +6667,7 @@ static unsigned long perf_prepare_sample_aux(struct perf_event *event,
> >       return data->aux_size;
> >  }
> >
> > -long perf_pmu_snapshot_aux(struct perf_buffer *rb,
> > +static long perf_pmu_snapshot_aux(struct perf_buffer *rb,
> >                          struct perf_event *event,
> >                          struct perf_output_handle *handle,
> >                          unsigned long size)
>
> Your $subject is broken (superfluous whitespace) and you've wrecked
> alignment of the arguments in the core.

Hi, Peter:
  Sorry for bothering you for these simple mistakes.
  I will optimize my patch series and send a "v2" version after that.

Thanks,

Haocheng Xie
