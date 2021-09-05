Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27BC4332F
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0660E52
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhIEVZv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238273AbhIEVZu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FAFC061796
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so3452202wmq.0
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E4YpvGUOv+fAgJ5K+5ei4WUi6BOg1OIJGekXtN39xjs=;
        b=dXVMRi3zMhjmJvVW0ztKYFLIH9hwW71q3rSoiBhuX2JAew7WG/mNKSlPSH44skCBxp
         vBjN0SR0fACkQVr2RnkwK3jnJw+sHwzaPJt5brAEpo1EUz0q8j2fv3x7QXq+GJ1wGZbJ
         I+fqR0tk/CWzgIdAzTi0fnfenkSlFORyRAxecmJnCp0Qu3ICJvCYQm/nxBDtXa+Tmo/+
         qIw0dYcsow9BgDsFoqWEcsErz9rCYXoHIslSrBgiM7OJg1RWHq4nw90H9fCVBd9EX11X
         zm2RwN4olK5YUFB+zEmUczZsdNp9l8ced7oQ5MheNOfCViey1uOJZUi0vSPIJERMZh75
         7JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E4YpvGUOv+fAgJ5K+5ei4WUi6BOg1OIJGekXtN39xjs=;
        b=qFgp/YxPwZvZKc8AZQMUO9RwTG3q+SOBG0nt+JCiX7JuFvIIJ3RmUDr9LaZn/CQT13
         bfMU1em3/b2/inmf5VtfwppBE/rGZVhvk2SotToLC1ggCJ+VhRDkBzBBf2J0Fs9x6NS9
         wNWygUzic86pAG+bEALRjeWdC1xyht+VIy8/tEAMTcSzxNyeZfZ8wNY6cklMhGtL5kax
         fPAuEKUWIBSN2u6uqqG+vQQPj9VumrP74uUClr6H1o3i5oA4Hkk133R0WfBfiae88YRs
         SS2NQ03WK608izTUM6+QJwc07UdTLXcLjIrxx3Xe0+2RyZ+LPU5cMb7FGlbeB3Xs+lSW
         fLoQ==
X-Gm-Message-State: AOAM533ujJRO2zej/k6ahDAjcqHzrY8JBoJ59OrQORRYsLX6PmnSTWKp
        C/dAlqPOB0R/4otkqjhkWbtyt2HEhKzdrwhEZuSIDA==
X-Google-Smtp-Source: ABdhPJxQpNtJ2bb0D/m2IMW40sK7zBgzK/0MOUJ/OwkKrz2JETDgarpa+KQ2ucuqANQYhBp2nt4/XW3KC3r6Ivzr1Jc=
X-Received: by 2002:a1c:1bc7:: with SMTP id b190mr8648358wmb.57.1630877083849;
 Sun, 05 Sep 2021 14:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-6-james.clark@arm.com>
 <5679e1e1-b5c4-b763-2fe7-7dd8b7ef1a9d@arm.com>
In-Reply-To: <5679e1e1-b5c4-b763-2fe7-7dd8b7ef1a9d@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:33 +0100
Message-ID: <CAJ9a7ViotCWg4r+XgTtpmEpUJ2Gq4y7wpL7HCvcFWnToj=h8Cw@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] perf cs-etm: Fix typo
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 10:09, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 06/08/2021 14:41, James Clark wrote:
> > TRCIRD2 should be TRCIDR2
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
>
> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
