Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C559C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Oct 2022 17:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiJERuV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 13:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJERuO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 13:50:14 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F21EE20;
        Wed,  5 Oct 2022 10:50:13 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so11326720ooo.8;
        Wed, 05 Oct 2022 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT6lx5ZDRpxgW+xAGllB8Ira6Ynt7/Xp9qu0pEh/gYc=;
        b=DylDZ6bEfb3HIE11eFU1xtxy57xByujX3fS721pcWxmU1Wxo9hcvuJ01QYy0OU0OCw
         ORQV5MIySWvb6nCE93Scmt7t3A8ipWk+87kmBLMTSMZSaK2hl4hlYQXNtzXP6h+b7G62
         Bxrx9rGXaIvJSbleJqhZBTXo6wlBpln3cs5Lg7PgNGjnjcv4/u36aazLFH2sveDceJX4
         PGAwKhzAAs14yaFmbORrals9mafiWGTvnExMZXLVYKcxWyxUGF5jbkhSC7CDa9pycMyj
         Mo4ueLGtnD8PiyZXc6a9il35fho1qfOxDRECcIcYY6nEWpO0K0yyM/YN+lS6zYbkfg0X
         /ZMg==
X-Gm-Message-State: ACrzQf00lzUZ8TQoLWSN9y8bBFMAbnuWEi0nmnf6gI6tenfndEvccOeI
        S0nXyLRH3PM4+7jQVG+7avi9yRzsVVapsIcafLP2VZnr
X-Google-Smtp-Source: AMsMyM4xN9VF9TvWdOefI/ak40ugxy598G2NtbLoEgPQYArnwPKN2STkdSNU+9QCQmReUfS8td8u2eg3ZGo9BLq44kQ=
X-Received: by 2002:a4a:b4cd:0:b0:476:8f72:5b60 with SMTP id
 g13-20020a4ab4cd000000b004768f725b60mr257862ooo.58.1664992212787; Wed, 05 Oct
 2022 10:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220920222822.2171056-1-namhyung@kernel.org> <20220920222822.2171056-2-namhyung@kernel.org>
 <YysWn/W3+dXlZnYG@kernel.org> <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
In-Reply-To: <CAM9d7cjtrVsccWUOCAtz1LbHoYxx7uV4SCaBMLdME-pdZjmjfw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Oct 2022 10:50:01 -0700
Message-ID: <CAM9d7ch1GG2xjOpPwMf0q88CWtX2DdSiRXDJX6vevTk_1g+USw@mail.gmail.com>
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

Hi Arnaldo,

On Wed, Sep 21, 2022 at 10:55 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 6:50 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Sep 20, 2022 at 03:28:22PM -0700, Namhyung Kim escreveu:
> > > When synthesizing MMAP2 with build-id, it'd read the same file repeatedly as
> > > it has no idea if it's done already.  Maintain a dsos to check that and skip
> > > the file access if possible.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > > v2 change)
> > >  * Remove perf_event__synthesize_{start,stop} and use machine->dsos  (Adrian)
> >
> > Will wait till I merge perf/urgent into perf/core so that this applies.

I think it's doable now :)

Thanks,
Namhyung
