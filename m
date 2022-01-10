Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CADC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jan 2022 17:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiAJRhE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jan 2022 12:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiAJRhD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jan 2022 12:37:03 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC40C061748
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 09:37:03 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id l3so18504959iol.10
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jan 2022 09:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VImuVeKyRKEKIzJHdDEJK8/BDOKoujNaHyjbgkuipso=;
        b=CdE7JZ2/5Ere61vOTLWnM5csvBvNZpoVLTe/f18kLT9JxyZ/oaWs+EGM3QoPDPdsot
         neGrENj/ANDKvii0964XyLQ52HMiUTIdQ71LhGsDyd2lg2KzZwTsVnXwHFvF9/eNKAsq
         23h/mr4FUUsi9uPO98CzTQ4JX27e7r66gk2FKlk8tG66paNmk+oqyEKcaFffO17tC7bj
         llHmFHiC4wiS19wmXXcY4Y1sxMZO9iFvJQu2XfUYgVCcw2TSDR6Ilbe6sS1AqXpigTJe
         ruIHEKACS7JiYEkpb1cre5TLkN4YPVKG6LrPNkompNKHASaXot+OaORd8sJhRIYD7a4R
         owBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VImuVeKyRKEKIzJHdDEJK8/BDOKoujNaHyjbgkuipso=;
        b=q6VGhOCm+R9Rq8iJcrZF83XSUuSBM+K4DnUwW/2HD8aXr9xV6CKlfwnrbmK287tKz8
         I99do+ha1Hk0vGjQc1vD9/ibNUMRgeguK55USM6eMbDDO9rfxtlGYQ6dI0DCU2J+n2a+
         fzqCkjmbDVjkRkleQ+t9O6k5+elDTIkLn5X5YCen2aedUkYmAfnzDZfKCKOxbc0sxUhZ
         n5hjqboWcHaypLr5bCb3KC09Ao+ILapl9Ryg88x3Ok6FJJjZ75/nSdF2Ylvc7KhLA97v
         ANvETYBSqssAaAlFzOCAXKCoE8J6BikvHygRMXjg2xnHt4dtBHXupms6DK/DGmzjz+mP
         gcaw==
X-Gm-Message-State: AOAM5311OEgaYm022CYBZ6JGrCWFnazfz7Nbq9ON9n/S+NMa+2dvUeBN
        fzjjlMMPtIRoeSNDB5T/Uo46HJbzPiYej2lAPWb9bQ==
X-Google-Smtp-Source: ABdhPJxg2hEa5KXe+r8QHR6UBQw+N6eJmP9azYBsNVCf8V7WsDYkQiX+5fZwdfHJ4PLbBwybl/oBmmZCFYqYFiYYopQ=
X-Received: by 2002:a05:6602:2b8b:: with SMTP id r11mr325003iov.97.1641836222188;
 Mon, 10 Jan 2022 09:37:02 -0800 (PST)
MIME-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com> <20220105061351.120843-3-irogers@google.com>
 <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
In-Reply-To: <57ab982e-ecc1-3f49-c580-0a251e29698b@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jan 2022 09:36:49 -0800
Message-ID: <CAP-5=fWT_19OfZTTjvLUcChV4nDwqc5Zq4VE93Gak6OO4NORsA@mail.gmail.com>
Subject: Re: [PATCH v4 02/48] perf stat: Add aggr creators that are passed a cpu.
To:     John Garry <john.garry@huawei.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 10, 2022 at 9:10 AM John Garry <john.garry@huawei.com> wrote:
>
> On 05/01/2022 06:13, Ian Rogers wrote:
> >
> > +struct aggr_cpu_id cpu_map__get_socket(struct perf_cpu_map *map, int idx,
> > +                                    void *data)
> > +{
> > +     if (idx < 0 || idx > map->nr)
> > +             return cpu_map__empty_aggr_cpu_id();
> > +
> > +     return cpu_map__get_socket_aggr_by_cpu(map->map[idx], data);
> > +}
> > +
>
>
> This is later deleted in the series. Can the series be reworked so that
> we don't add stuff and then later delete it? One reason for that
> approach is that we don't spend time reviewing something which will be
> deleted, especially in such a big series...

Hi John,

I think you are asking to squash:
https://lore.kernel.org/lkml/20220105061351.120843-8-irogers@google.com/
into this change. There are other  similar related changes that may
also be squashed. The changes are trying to introduce a new API and
then add changes to switch over to using it. This is with a view to
making bisection easier, have each change only do 1 thing and so on. I
believe the format of the patches is house style, but it is fine to
squash changes together too. Having sent patches to Arnaldo and having
had them split I'm reluctant to do a v5 with them squashed without him
expressing a preference.

Thanks,
Ian

> If it really makes sense to do it this way then fine.
>
> Thanks,
> John
