Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A19C6FA82
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Sep 2022 17:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIURzp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Sep 2022 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIURzm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Sep 2022 13:55:42 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5A67172;
        Wed, 21 Sep 2022 10:55:41 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id v130so9064953oie.2;
        Wed, 21 Sep 2022 10:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s9Q7cMJmdDRuuKdvp/pPqxKTaGT8PpSzhsxZsiJHZAg=;
        b=Rpx+JsUS3m8fSxhUTW3aynhFaglPGsjpU07zwxJg92xxYfOrl8A1NIaKkxi48ynQj8
         x0pa7E1sTHOYxPGM7JAsdaHTTjDrztLxQEPF/b6Ri7IY/yZiASsLJLd5tf/wQAn6VrVW
         rr8WLt1a9lM5DEFMaL9XW/Ozc2xaIeSq9zJ+1Es9n5Cz5ZrnHWajz6dkds/+N/S/KYed
         6ejTlqWdo1cjzTiGvusXPUjWYqlYrgtJZ4aI+FDjqbfrfL3sWtsEpKb4d3ut1CmOA8qL
         vVpo5HFSegBDP/HygLlUleFNBazTwAikH8nK9zzgGRWqKk+lONo9idEcxrDS/kew+ePc
         6l+g==
X-Gm-Message-State: ACrzQf3WSqokHaoio7nRoMMAzwGifE6gKyoeFGgg8d5SSiU4x8cC+45v
        /mbLKNW6mFR9q0/tFGwSo98Pck4g4S7itDg7bF4=
X-Google-Smtp-Source: AMsMyM4cxoDxNdK8h/8vZTRhLxdDxVS/ML2la3aE5ty3U1DouzESL3gdgqD1T9sPePYIJREl8XghjM9tCxqLfxvogzQ=
X-Received: by 2002:a05:6808:1a09:b0:350:107b:f89a with SMTP id
 bk9-20020a0568081a0900b00350107bf89amr4486494oib.218.1663782940697; Wed, 21
 Sep 2022 10:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220920222822.2171056-1-namhyung@kernel.org> <20220920222822.2171056-2-namhyung@kernel.org>
 <YysWn/W3+dXlZnYG@kernel.org>
In-Reply-To: <YysWn/W3+dXlZnYG@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 21 Sep 2022 10:55:31 -0700
Message-ID: <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] perf record: Save DSO build-ID for synthesizing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 21, 2022 at 6:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 20, 2022 at 03:28:22PM -0700, Namhyung Kim escreveu:
> > When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> > it has no idea if it's done already.  Maintain a dsos to check that and skip
> > the file access if possible.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> > v2 change)
> >  * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)
>
> Will wait till I merge perf/urgent into perf/core so that this applies.

Sounds good, thanks!
Namhyung
