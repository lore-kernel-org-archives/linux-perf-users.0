Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6081DC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D8460F45
	for <linux-perf-users@archiver.kernel.org>; Sun,  5 Sep 2021 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhIEVZh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhIEVZg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:36 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA04CC061575
        for <linux-perf-users@vger.kernel.org>; Sun,  5 Sep 2021 14:24:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m9so6830011wrb.1
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Sep 2021 14:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIHzJG4x/c4ord8UABpO4rbP8CYuI6K54GyJYQGHzAI=;
        b=agFpB5V2LHqzN/WezZ45hmFy4eBJHgY3DPmoBc44zGmhj33+AZZCgnrpKbPmJz4e11
         NBHmwMKDeExPU7oEMWbaVuy1aCHK9lhgc8gu+UYy9mjhSkO10zItI7ROzm5hkmbO642Z
         0efQFFVJ5Oj6zxG/lI2hWyi2EegTlN0Ot6uAmswavxPOMFRpL179Gxf2IxRsPqUV8A0P
         XF3cUKBUiOoFjn6e7r+oJ1NCG6Xyk/E7exg+mQN86kN6HHyhYHiiT7M5++SM5Ozr3cfM
         XnPvGrUtkEL9DI9Iqc5uCjhwTeS5YueFH8pnSNetCc8rvZW95MvLaY4N9QhxqdeQbIHm
         PwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIHzJG4x/c4ord8UABpO4rbP8CYuI6K54GyJYQGHzAI=;
        b=QkamuOlmvth+0ZcQWwghg2KUXtK1sQVFEblT70uScgzcFtPbPIPY4t8BH3GdeDmrUZ
         /2QxG5uPwKIgioIHGIqwMN29gS71hk3AkRbZ+9uOap4/3hrJac5qYRN6URnf4+Tuceif
         K/zLPJetCaFY4qXDL05ePZ+zTgIAfULzlgBIIjH42Nvhhif10VelAXClL4VWLj1Sa12K
         epYDzQdBROnCQ9/b6epSPIM0QbvEpsNfNfzESd4rk8mTrgRO1mQE3iM6syVEP5Iv+otp
         Xb9zFqH5Vw7JCNcGQn2b03lMYhw5jvOic8kiEgv2g3mWol2MXUdGiw8CsmPt566jU0Lu
         iaUA==
X-Gm-Message-State: AOAM531VVM1K6/XA33/yY6qA3MKfuM3oDa1QH2MjRoQhsl49wgfDjI35
        ybxjt5GlW4DCQsT7RnIaNV82ZHTC1RaAhGzyku0mJ4YFB6I=
X-Google-Smtp-Source: ABdhPJy3s/jbX+WLj0q9CVzf3rldsR+LVYL/ZwbCD1eARpWjluKyEpxWEa8hk9QBc1/qGZ/UDenX0U9L8fdkQV0rreE=
X-Received: by 2002:a5d:56c9:: with SMTP id m9mr9838565wrw.134.1630877069272;
 Sun, 05 Sep 2021 14:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-2-james.clark@arm.com>
 <ca0f3d7c-2420-fcab-0c48-57225ed15b00@arm.com> <YTIBYkU281/di+vD@kernel.org>
In-Reply-To: <YTIBYkU281/di+vD@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:18 +0100
Message-ID: <CAJ9a7Vix0zO_AG=zq5iqx+FaG_ZDaj_wZ6ZQ+==tYSXneO4_cg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] perf cs-etm: Refactor initialisation of decoder params.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
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


On Fri, 3 Sept 2021 at 12:05, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 09:52:14AM +0100, Suzuki K Poulose escreveu:
> > On 06/08/2021 14:41, James Clark wrote:
> > > The initialisation of the decoder params is duplicated between
> > > creation of the packet printer and packet decoder. Put them both
> > > into one function so that future changes only need to be made in one
> > > place.
> > >
> > > Reviewed-by: Leo Yan <leo.yan@linaro.org>
> > > Signed-off-by: James Clark <james.clark@arm.com>
> >
> > Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Thanks, collected the Acked-by.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
