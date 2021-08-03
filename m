Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C433C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 08:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039C760F11
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 08:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhHCIGo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbhHCIGo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 04:06:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD9C0613D5
        for <linux-perf-users@vger.kernel.org>; Tue,  3 Aug 2021 01:06:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id c16so24269030wrp.13
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Aug 2021 01:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPbQVJkJzSXcaXx9HbEOsAieS9ipsFl/K2G+c6GXkNI=;
        b=NLhiIT5ZqvIp6hesu5f82dogfMtWpOiJTml48Z7xZMQKMJIMqzXTFQNS+MfS0bsZBQ
         TKP2ykFdeWmIHne9ufVz2KNi8RnrbaCA5CbIunIFErf91SCM6IEkk4BxYXQQ5UKajW/8
         Mh/+SsI1O5U6acCO2Z/3Vzc4ABLCiAztlJ/wf/aXZ4h9BjAR8SuOT2QN/bbf1LZXCXsD
         Vy+Dq0PiXbIgxnONTTVSIXgXr+MngMY2BP/W4EoCVpWxse9shAdQT4P2+3Hb/70SHdOs
         ByTmigwGDH9nyJu0rHgC83ifszmgJHWUeYA7bioBHNYwS0hBgyxyc5fqQPC6j5LF3UHG
         7yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPbQVJkJzSXcaXx9HbEOsAieS9ipsFl/K2G+c6GXkNI=;
        b=stGjb3te5oxgr8U5/yP6l17TFYsvhqB6GAj9pNYycGaQQ+T04mG6u5WrWYW2lKT02M
         BRyheP3bka3QXr/4Y502Gq7S+IUNLP3yVmE77mmJT5KR2+VbQIDYt4PBwnLjzv4a4AD5
         BlyYm6p4yk5kf4xJ3pbpoYRl9/EFwEE7zCwBuhqTGQbaSEiyNmC/htvYIOYUFnaS0wzy
         T4jYUGvwJJnwAMiH+MIw047p5m2o/1zpJlk1wun1OdJ+vY7ZAEEVmQA5SQk7ngYslTrn
         mDvRbVSOxNOMh7vDeh5Ywrex7WlRvKGDV0m8ry5SZb0WJWjID7O0EJCBiyqLIfyPcnUN
         WJbg==
X-Gm-Message-State: AOAM53161jyu8trpKWa5K3wsE4B6tFhnPVcCHAAgB5XKltfw6BN/C1dX
        UXoc9lqQyCP47UMIXZHfE7+xcbQNTInZYQ5k4Kaaig==
X-Google-Smtp-Source: ABdhPJyN4PO+BxU1EjejPtiIX6WBg4h+HCVRraj7kpE7SS4FXwATcvwBaJlFjf7LHdc6rMAy6B3va9ZQhTFEcr8JpBY=
X-Received: by 2002:a5d:4a4f:: with SMTP id v15mr20967610wrs.178.1627977988620;
 Tue, 03 Aug 2021 01:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210729155805.2830-1-james.clark@arm.com> <20210729155805.2830-7-james.clark@arm.com>
 <YQgGjlWtbaNApkp6@kernel.org> <20210802170307.GA3050918@p14s>
In-Reply-To: <20210802170307.GA3050918@p14s>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 3 Aug 2021 09:06:17 +0100
Message-ID: <CAJ9a7VhLqgsEOVV3yksLiTJ2w2FOogNS92-gX5G4sgL8wiEwCA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

HI James,

On Mon, 2 Aug 2021 at 18:03, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>
> On Mon, Aug 02, 2021 at 11:51:58AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark escreveu:
> > > Currently decode will silently fail if no binary data is available for
> > > the decode. This is made worse if only partial data is available because
> > > the decode will appear to work, but any trace from that missing DSO will
> > > silently not be generated.
> > >

The decoder actually outputs a OCSD_GEN_TRC_ELEM_ADDR_NACC packet if
binary memory data is missing.
These packets are currently ignored by perf / cs-etm-decoder.c.

I think this per DSO warning is fine, but perhaps at some point add in
handling for OCSD_GEN_TRC_ELEM_ADDR_NACC - which perhaps is only
active when dumping trace packets.

Regards

Mike


> > > Add a UI popup once if there is any data missing, and then warn in the
> > > bottom left for each individual DSO that's missing.
> >
> > Looks ok to me (the last 3 patches in this series, the rest I applied
> > already), can I get some Acked-by/Reviewed-by from the CoreSight people?
> >
>
> I have a substantial backlog of patches to go through and I will be away for the
> next two weeks.  As such it will be some time before I get to review this set.
>
> Regards,
> Mathieu
>
> > Thanks,
> >
> > - Arnaldo
> >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >  tools/perf/util/cs-etm.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index 32ad92d3e454..e6851260d059 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> > > @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> > >
> > >     len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> > >
> > > -   if (len <= 0)
> > > +   if (len <= 0) {
> > > +           ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> > > +           if (!al.map->dso->auxtrace_warned) {
> > > +                   pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> > > +                               address,
> > > +                               al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> > > +                   al.map->dso->auxtrace_warned = true;
> > > +           }
> > >             return 0;
> > > +   }
> > >
> > >     return len;
> > >  }
> > > --
> > > 2.28.0
> > >
> >
> > --
> >
> > - Arnaldo



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
