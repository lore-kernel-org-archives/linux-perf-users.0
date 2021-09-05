Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD12DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 19:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9216D60FBF
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 19:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhIET2K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 15:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhIET2J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 15:28:09 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E5EC061757
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 12:27:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id w4so7491429ljh.13
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GB7YhVw4I1lPBw5iEYwKcJSJkJXzzk2ALEpsWj50AQ=;
        b=d4ueszfQ1ChFjZO2aea6b+E01wkxIgHE+pSGmW46ZDORJ+bEbGdJ/41SX0ogREEFtP
         CM8M9osKCmWe3C9S+idgR1EmTVczhP/XXxe3d3l6Ni2gUB4zKM57dpE3XGbNnxKKyfol
         G7zFB2dH6nDWpOnyLRqs0z7A89oxk1GDTRSEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GB7YhVw4I1lPBw5iEYwKcJSJkJXzzk2ALEpsWj50AQ=;
        b=PwI7CJGt0PAUNdzUlBKg83HQnqwzBqeizeeaFEXUxWw7nu1HN5sSKEfA+kUCRPMCTE
         3YYeFL4PLV0QMI5+BLK2pXMZ/+oP6udNJiNk1/iCyOZf4T6epg605lMqPdm6Tk2xqDLS
         DMhMhdVnvNtiIBA7qG2zltgm/srQeAMO6QraKjaaMl1c8Az/8sA9HmTqRwqeDGAoCFUs
         m0lZxTwFNRMfeP89zSp5jFa5fuwzjOZx5xoOIBosYwWvtNDKfKHOTfnYjznMyBvbKuQ8
         EQprbTkuzF+8cTIX9+Bd8MTYyXtzEr76Pz2jN/Yed7cRfiCox0REQZySSYT/e3KPup/3
         geSQ==
X-Gm-Message-State: AOAM532dIYyulSr3eJ5swOgX9MobNK56WHWzhtAkPRLlMuqe/Aha5ORM
        ctXx8qUszV5QfW7rJIlioEwAKvofTeVNFjRcJ0A=
X-Google-Smtp-Source: ABdhPJxU1f9DTMZzjv3UmEbiUmBObMm1C//va8d/+1vLZtTL9N3M95xPDx2J5OwDs2ufiCaLUHcaxg==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr7868783ljn.517.1630870023813;
        Sun, 05 Sep 2021 12:27:03 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id i5sm399178ljg.53.2021.09.05.12.27.01
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:27:02 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id k13so9096401lfv.2
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 12:27:01 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr7080170lfv.655.1630870021592;
 Sun, 05 Sep 2021 12:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210904184924.16279-1-acme@kernel.org>
In-Reply-To: <20210904184924.16279-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 12:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=9gNaQpZ3ChKfW-=9in7yGwP-sg5M75GVdSmMPEJC9Q@mail.gmail.com>
Message-ID: <CAHk-=wj=9gNaQpZ3ChKfW-=9in7yGwP-sg5M75GVdSmMPEJC9Q@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.15
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alyssa Ross <hi@alyssa.is>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Colin King <colin.king@canonical.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Eirik Fuller <efuller@redhat.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Joshua Martinez <joshuamart@google.com>,
        Leo Yan <leo.yan@linaro.org>, Li Huafei <lihuafei1@huawei.com>,
        Nghia Le <nghialm78@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Sep 4, 2021 at 11:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-04

Hmm. I don't usually build the perf tools except after a pull, and I
might have missed this before, so it's not necessarily new..

But the perf build leaves this stale file around:

        tools/perf/Documentation/doc.dep

which should either be ignored, or it should be renamed to one of the
names we already do ignore (make it a dot-file?)

              Linus
