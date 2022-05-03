Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E543CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 19:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbiECTvN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 15:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiECTvM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 15:51:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FEA39687
        for <linux-perf-users@vger.kernel.org>; Tue,  3 May 2022 12:47:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m2-20020a1ca302000000b003943bc63f98so1834379wme.4
        for <linux-perf-users@vger.kernel.org>; Tue, 03 May 2022 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EJuEir8WaQdx+AmMhItnX2XU1VcFLfAnu7382m6sqak=;
        b=XvH6ljkdXQ4W7AQb7m3MjxmpuHDXFZ1lpOtEaWkjtqTp+CytnkJ+EMas3DQqX5wGtV
         w4pJXR3Bkhif1hyXU3lqDyjv4ln2JNNHZmzEZKC/v3nfa840DIzNPIkcdguaE4it37+u
         tH1jTnGE1qTgSVyZOxjsIvnbtfsfS5n/HJheyvn5p3/rH0syRc08/39w0DdA+dKWhD7+
         CnmjsHTmcxlDXmwkanmhmKJWUGWhfkIJiREdQ+Sd6ZB2o5kLnfezQklB/P+TOssbMFcm
         NskgceFG7WVb0Ea+9MZzYk9BT+YlyPePg2RLOpDlXhlrwEPu+FFTFdw2dn6S1VifQTZp
         smFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EJuEir8WaQdx+AmMhItnX2XU1VcFLfAnu7382m6sqak=;
        b=uHF8gCyltKC2K1bClLcLG5sYl+AuA43qdEULfj7sld7wbb23ilJ7P6d06j0mlYjcTi
         UkvYNQvYrpjl2i91PpmmsmefB9cK7tqEfbPdK4IsEAuCZXppSjZJBBd0asfH9lvGVfKy
         OJZYFWlZkCR7uIaRBwQHIr0e7d2r2TCkA3HcG69iJBdSDOOIUTr0ZSP/w/r1P6QwSvjn
         9MQfZEQLOAnIG6YDs1MJ9ed/0VXHy2tERcXmi661VlUwWpnx4/qYxPRIcjCKUZoosmUb
         lHZlBce4FOeo2Lx69U0Wr5Zss35susu4HYf18oos2c1haDULSa7fVCxKJwQKqtM9GW8c
         lmrw==
X-Gm-Message-State: AOAM531HKp3M7d5DugQUzcEzVapXheIBU12T7Z6HbXEWH/CG8mEe80h5
        huKj4vYaSWHTMhdxd6JoTflDI4N8pU+fS1CkGaN/ABqbkZMjWw==
X-Google-Smtp-Source: ABdhPJxy7nFk3Qg/rRk0SS+7UUm+WSXA/XPDIfZ+TT3+yvbWOaCGNaMpBJGdibzONyW75MJqG4tZ9y/qBFWqh+M/Al4=
X-Received: by 2002:a05:600c:27c6:b0:394:783:2077 with SMTP id
 l6-20020a05600c27c600b0039407832077mr4756853wmb.182.1651607257693; Tue, 03
 May 2022 12:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220428075730.797727-1-irogers@google.com> <96b5c9f4-f0a0-0019-8059-3e833c95b011@linux.intel.com>
 <YmqXGCMbBOLcd261@kernel.org>
In-Reply-To: <YmqXGCMbBOLcd261@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 12:47:25 -0700
Message-ID: <CAP-5=fWQMVVFZ=4WLWJkojZARHnmYp+AgTOodG_W=qqNZFw6iA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf vendor events intel: Update CLX events to v1.15
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        James Clark <james.clark@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Apr 28, 2022 at 6:31 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Apr 28, 2022 at 09:12:26AM -0400, Liang, Kan escreveu:
> >
> >
> > On 4/28/2022 3:57 AM, Ian Rogers wrote:
> > > Events are generated for CascadeLake Server v1.15 with
> > > events from:
> > > https://download.01.org/perfmon/CLX/
> > >
> > > Using the scripts at:
> > > https://github.com/intel/event-converter-for-linux-perf/
> > >
> > > This change updates descriptions, adds INST_DECODED.DECODERS and
> > > corrects a counter mask in UOPS_RETIRED.TOTAL_CYCLES.
> > >
> > > Signed-off-by: Ian Rogers<irogers@google.com>
> >
> > Thanks Ian. For the whole series,
> >
> > Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>
> Thanks, applied.
>
> - Arnaldo

Thanks Arnaldo, it looks like CLX was accidentally skipped.

Ian
