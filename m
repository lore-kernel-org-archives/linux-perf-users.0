Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7AC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF5D660F70
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Sep 2021 18:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344626AbhIXS7D (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 14:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344443AbhIXS7C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Sep 2021 14:59:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1981760D07;
        Fri, 24 Sep 2021 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632509849;
        bh=LlpHW03U0YmN05wPrOIk/YYMzF21XuR4WEXiqq7ZvYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urInHIhBPMhlY/fikeuG1UmuYttvcViUvqwWQVQZZRnu9HdelbmK1KbyDssj8O0lh
         brEG3fSbOtEjXRqkjpHJsHuVDR2AXgQzd76y2Pz6v6LpVBImrrz8DO6uJwnjT9RSS+
         qf7/+HeNDk4aXO2Z5sUEJiQrihotmexrowVkiIQwYtabJUDClds061+QucJYM34w9H
         7p9s8M7jmYyz6lChJZWRse3ZlovwZkWaTjwuv/MlVbTnEU8fvZ3MGjY5VyLrbQQ2hA
         au7//VL7MQWbJMOFcxVBo59+sIsfa+OdMQemTJycqfAvz5atQVrTdyw2EelxHLAsdM
         XhEuk9TFldrLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E063D410A1; Fri, 24 Sep 2021 15:57:26 -0300 (-03)
Date:   Fri, 24 Sep 2021 15:57:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Colin King <colin.king@canonical.com>, Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf vendor events: Fix spelling mistake "icach" ->
 "icache"
Message-ID: <YU4fli+fSiZYYyS3@kernel.org>
References: <20210916081314.41751-1-colin.king@canonical.com>
 <CAP-5=fXC9kb_6Xsfw17SHp1TeFJSi_uCotAtBSFRqCSWOZpk7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXC9kb_6Xsfw17SHp1TeFJSi_uCotAtBSFRqCSWOZpk7A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Sep 18, 2021 at 12:46:16PM -0700, Ian Rogers escreveu:
> On Thu, Sep 16, 2021 at 1:13 AM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > There is a spelling mistake in the description text, fix it.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/pmu-events/arch/powerpc/power8/other.json | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power8/other.json b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> > index 84a0cedf1fd9..f1f2965f6775 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power8/other.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power8/other.json
> > @@ -1046,7 +1046,7 @@
> >    {
> >      "EventCode": "0x4e010",
> >      "EventName": "PM_GCT_NOSLOT_IC_L3MISS",
> > -    "BriefDescription": "Gct empty for this thread due to icach l3 miss",
> > +    "BriefDescription": "Gct empty for this thread due to icache l3 miss",
> >      "PublicDescription": ""
> >    },
> >    {
> > --
> > 2.32.0
> >

-- 

- Arnaldo
