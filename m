Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD8C83F2F
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjHaSmH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbjHaSmG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 14:42:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4769E64
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 11:42:03 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so48491cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693507323; x=1694112123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4feh4x9tPVvkEXLj6eZMjNnNSFlhOTihQ2j4idVY+Y=;
        b=X4Qgg7//QoHuoEmxhXUVeFJAYKDV2N7nye61dGBgk4H8wbIhhZeiXvR0JXJXUyd5kr
         Azg6okNFFZ18lCyB4INKQQWacaWXpm0CWGGiKnytDPhUmcULsfaxuHORlzbZbUPpC+Uu
         hjdX1hr/zHRZzx6cRZ9YcgM/hCaMgvdEUZ70PGw3PJp+DzX2J6a5H+GFybmfXFUBwmYu
         9qJeD44ojytXAJkuPQsiiJgJhFvJM+EFHfLpBstCJ+7O3AuD/P5/tJgw90gNqbOzM1PK
         xwYWHk4EpXaqWO3Lj/rmlB6ceKXal+Fae914AcaXrd6TCxve7ky4MDeAImDtl080WTt9
         CjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693507323; x=1694112123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4feh4x9tPVvkEXLj6eZMjNnNSFlhOTihQ2j4idVY+Y=;
        b=Bvx0BK1A6hmz2Oa/0IC9KMaLdjxqD5g2pDbUqyd1XF5338JNPRZQYh06K4l+7sBZ/m
         nFVhc7GCRsXlyqpsJP0cX7RRJWRlUYRVCrtMzO8ZxdDRgkv0RaKTPNRujTy6wGjwPfcT
         ATdiOMOy2PalMNN/qM4C/gij9cUxvKdXdyHq+q1iGP8+Zey5YDyQ2VD5T4CD38e9LoV6
         B0dK++9XfM+m3i0HQOizu9F9IXDONe1FlqNzuwHaMUmUG18lQn9tYKP7WUQoTW1erI5W
         zSytg626WEbed0vR1BTHMIZD+Vsaep2kuHJpGp/AlzWu4U/3in/HpQfsRK00FI+zS/VT
         k8mQ==
X-Gm-Message-State: AOJu0YwS2YtoKWPerLOqHKIt6QUSsM7E5wiA53bmN/1xbuTRMGnsJwCZ
        Gc/pbKwTWZ9bC9IMoJuXFiACKJ250H6SjDheb7yYuw==
X-Google-Smtp-Source: AGHT+IHJb0qPPBvoEHY3Cc9MLqEJF0TK82p0deucPj+88LsYtYD5P0Ig91TrPhf9HWbjnpX+GbhljvdkMbi0CpMPkVc=
X-Received: by 2002:ac8:51cd:0:b0:40d:eb06:d3cc with SMTP id
 d13-20020ac851cd000000b0040deb06d3ccmr32739qtn.7.1693507322812; Thu, 31 Aug
 2023 11:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230831071421.2201358-1-irogers@google.com> <c2affcc9-468f-bf4c-a080-65b31e05a83f@linux.intel.com>
In-Reply-To: <c2affcc9-468f-bf4c-a080-65b31e05a83f@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 31 Aug 2023 11:41:51 -0700
Message-ID: <CAP-5=fWdH_1or1yhH3pqFymnK=-w=OTzx63mVgknFNgqxf6T+A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] perf list/debug output fixes
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh@kernel.org>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 31, 2023 at 11:28=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2023-08-31 3:14 a.m., Ian Rogers wrote:
> > Fix a long standing parse_events_term cloning bug so that the bad
> > display of terms can be fixed and the code somewhat more intuitive:
> > https://lore.kernel.org/lkml/20230830070753.1821629-2-irogers@google.co=
m/
> >
>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks Kan!
Ian

> Thanks,
> Kan
>
> > Fix a bug caused by the rename of 'cpu' to 'default_core' in perf list.
> >
> > Add more documentation, increase type safety and fix some related bugs
> > where terms weren't initialized properly.
> >
> > Ian Rogers (3):
> >   perf list: Don't print Unit for default_core
> >   perf parse-events: Name the two term enums
> >   perf parse-events: Fix propagation of term's no_value when cloning
> >
> >  tools/perf/builtin-list.c      |   2 +-
> >  tools/perf/util/parse-events.c | 203 +++++++++++++++++++++++----------
> >  tools/perf/util/parse-events.h |  60 +++++++---
> >  tools/perf/util/parse-events.l |   2 +-
> >  tools/perf/util/parse-events.y |  27 +++--
> >  tools/perf/util/pmu.c          |   2 +-
> >  6 files changed, 207 insertions(+), 89 deletions(-)
> >
