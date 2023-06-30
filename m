Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849DEEB64DA
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jun 2023 21:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjF3VIB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Jun 2023 17:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3VIA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Jun 2023 17:08:00 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC23AB2;
        Fri, 30 Jun 2023 14:07:57 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-bfee66a5db6so2184796276.0;
        Fri, 30 Jun 2023 14:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688159277; x=1690751277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/CO/oCABqzFmq54OHALLtN32UzLowehqvMtAzumrCU=;
        b=QG4NM5hxG3NfQ+HmEoH+xDSBBF/UORMx1XyYNjCftI9IC+IQ5n4J1Gbp2su3t1Km8z
         F/A09axtQ9CMGGkePivD91i1XA2U/tmwerd47LzpJI8zgvT3wMZGXBJD67K0ZcG2CBhP
         aiYhMo8LvK7k/MYPl3bvrVkxxmazbaBq8mGOvmm60KHGmxYFK4EWZDVTrSLKBEvSsWHV
         kYBQqnkeHL4RW1YtT7WAvzZ9DTzqIwfYTOwhtELvy8/DT79HhErwa0W8mzdcqOBBGr6H
         o51h14ky8RUUF7oUc6j7pCibF2nlonZ+1EHXvzKqvck3M+Jgrau+BfB6vdhTJFfXBPsq
         7gfA==
X-Gm-Message-State: ABy/qLYWxYQzK4OCHTFhgn/APSnxDiAs6chDgg6Vq9Y2UHprWkS+5HPi
        rgwtb1vneWsxQt13KYfGoc/spQtNBk/r3b318PU=
X-Google-Smtp-Source: APBJJlHfQHqDUVj0jpVaP1NJ+yZ3Kh1WAyDJSbwftGcT9k7GZYd6dMeWyamYz9UcWOcyRiIIa17yKlFok6efS9MY7Jw=
X-Received: by 2002:a25:734f:0:b0:bcd:73a2:d2cc with SMTP id
 o76-20020a25734f000000b00bcd73a2d2ccmr3754774ybc.59.1688159276776; Fri, 30
 Jun 2023 14:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <CAM9d7ciBWjNHOfouNKSFy2q88Cs4-6F8EjGqGpFdwb6QTShaew@mail.gmail.com> <9aef5f82-fa76-dbb5-59a0-47f2e85f8bda@oracle.com>
In-Reply-To: <9aef5f82-fa76-dbb5-59a0-47f2e85f8bda@oracle.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 30 Jun 2023 14:07:44 -0700
Message-ID: <CAM9d7chwaDPRnrAFreD=1eKia2f1iL1ZgF87dJCWcL_6dGAexQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/9] perf tool: sys event metric support re-write
To:     John Garry <john.g.garry@oracle.com>
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 30, 2023 at 2:35 AM John Garry <john.g.garry@oracle.com> wrote:
>
>
> >>
> >> Based on 82fe2e45cdb0 (acme/tmp.perf/core, acme/tmp.perf-tools-next, acme/perf/core, acme/perf-tools-next) perf pmus: Check if we can encode the PMU number in perf_event_attr.type
> >
> > We moved to new repos from acme to perf/perf-tools and perf/perf-tools-next.
> > You'd better rebase the series onto perf-tools-next (branch name is the same).
>
> Is that in the MAINTAINERS file? I could not see it.

No it's not.  But it seems acme/perf is not there either.
Probably we need to add one and split the tooling part.

>
> And I was hoping that Ian could first have a look, since this is just an
> RFC.

Ok, makes sense.

Thanks,
Namhyung
