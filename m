Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D170FC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 23:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJKXdL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 19:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJKXdL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 19:33:11 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0688A344F;
        Tue, 11 Oct 2022 16:33:10 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1321a1e94b3so17780307fac.1;
        Tue, 11 Oct 2022 16:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i00Mjx5UPOf64nXnM7PPfFdX40HdBRwvXpSo63eHc6I=;
        b=Iv6x7loIYLaAEfiT+r0UCkeu1pQE9qd/6bFC6bIOcF2JnxDxs5TBrmV7sjfvF6eXRS
         WGcSWIjgHugnGX95V+T4GKDJh0wFbN3iDrJWgfqTGKOAL9Z/hV9+K6tybSAt5mDvw/D3
         IrPyHrnAiFnusD2cy27n7KbS8lPAQchRk8vkMP5ncL9cnl0EBmT6qp2d0gNodNF7n57r
         TtfbOKMVclE1Q20CqORbPYyEjNY441KOLfJi/0A941ShNuDfAr3gFUBXQ56XJH+Uroh4
         0Xh48DfIwWnnUu7OMHPt6MSPgwCWiN+KEKsydsihwmvWCJ00brWzaLh75lffp/oTKdjD
         gL8g==
X-Gm-Message-State: ACrzQf3h+wqPCDhOQV8rOUu2EleVonnfPiyDr1xK6jjIIXQNi5ImxpYS
        6v18FOe6npwVsQdxYoSkqRoZQcLcXI8FdT4vA0w=
X-Google-Smtp-Source: AMsMyM73epZgrR0Tord5Uu16fo3N2awQemOMe+URL8pwAGJviTBiEiF0Rud3wrsjMPNfUfafwcl2eV1XquVO7godByQ=
X-Received: by 2002:a05:6870:4184:b0:136:5e73:b40e with SMTP id
 y4-20020a056870418400b001365e73b40emr869068oac.209.1665531189975; Tue, 11 Oct
 2022 16:33:09 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-7-namhyung@kernel.org>
 <CAP-5=fWe5sgNJTYyLf26jmF6whHVGth5Ss+0TE_JNOJ_gEs76g@mail.gmail.com>
In-Reply-To: <CAP-5=fWe5sgNJTYyLf26jmF6whHVGth5Ss+0TE_JNOJ_gEs76g@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 11 Oct 2022 16:32:58 -0700
Message-ID: <CAM9d7ciWeQss6JkBr41gfD2FxmQprhfHsSK5ZWasJofvyVrGoA@mail.gmail.com>
Subject: Re: [PATCH 06/19] perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 10, 2022 at 3:53 PM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > In case of no aggregation, it needs to keep the original (cpu) ordering
> > in the aggr_map so that it can be in sync with the cpu map.  This will
> > make the code easier to handle AGGR_NONE similar to others.
> >
>
> The CPU map is sorted and so sorting the aggr_map should be fine. If
> the data is already sorted then it is O(n) to sort. I think this is
> preferable to having additional complexity around whether the aggr_map
> is sorted.

The problem is that aggr_cpu_id__cmp() only checks socket, die and core
so it will have CPUs in the same core together - like 0, 4, 1, 5, 2, 6, 3, 7.

Thanks,
Namhyung
