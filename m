Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692A2C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468A761206
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Jun 2021 14:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhFNO6z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Jun 2021 10:58:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232869AbhFNO6w (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Jun 2021 10:58:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1D396100A;
        Mon, 14 Jun 2021 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623682610;
        bh=wwsEr6bp93L7CQlqKTWMpSzbfOD6urfHaP/eGF1ZhoE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q5DMRde1kJv39YAGLcKsyghlbFadWjtimpp0bS2dZxeOjD2Iau6PtbpNdFFKO+3Np
         tgdaoTLJioR1eWMe1ELg5I8+KvAYZvuz09iXWxqcxOkiivk+T9H+9fUi38rAkfJF9x
         rWdWi/brflCkpzNCXC6XXNB6h4bBgVWRO0lklXXHklrEm99+GEJTdZxN48+CUlzunK
         jsgFFbIbVErdyfEDlzTil+udR52hdZDDS9NylqTUbx0jR/jGeMYIQOc8ixQ+dC3Tnc
         yko9pw+TSnstkqB9w7uVlkS25r7lzuFfvfwgm4GMKSCPF5J65f3i1qI35+RcFHWvnG
         be6Yw+M4YnwZA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5858D40B1A; Mon, 14 Jun 2021 11:56:47 -0300 (-03)
Date:   Mon, 14 Jun 2021 11:56:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] perf metricgroup: Return error code from
 metricgroup__add_metric_sys_event_iter()
Message-ID: <YMduL3nCJ9NU8Va2@kernel.org>
References: <1623335580-187317-1-git-send-email-john.garry@huawei.com>
 <1623335580-187317-3-git-send-email-john.garry@huawei.com>
 <CAP-5=fV3L5HoJrXry5fvjedJG1dksJ7JJfy54YOQcgfPQMn4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fV3L5HoJrXry5fvjedJG1dksJ7JJfy54YOQcgfPQMn4Og@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jun 10, 2021 at 11:45:17AM -0700, Ian Rogers escreveu:
> On Thu, Jun 10, 2021 at 7:37 AM John Garry <john.garry@huawei.com> wrote:
> >
> > The error code is not set at all in the sys event iter function.
> >
> > This may lead to an uninitialized value of "ret" in
> > metricgroup__add_metric() when no CPU metric is added.
> >
> > Fix by properly setting the error code.
> >
> > It is not necessary to init "ret" to 0 in metricgroup__add_metric(), as
> > if we have no CPU or sys event metric matching, then "has_match" should
> > be 0 and "ret" is set to -EINVAL.
> >
> > However gcc cannot detect that it may not have been set after the
> > map_for_each_metric() loop for CPU metrics, which is strange.
> >
> > Fixes: be335ec28efa8 ("perf metricgroup: Support adding metrics for system PMUs")
> > Signed-off-by: John Garry <john.garry@huawei.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Do your Acked-by applies to both patches? Or just 2/2?  I reproduced the
problem fixed by 1/2 on a Thinkpad T450S (broadwell) and after applying
the patch it doesn't segfaults.

Please clarify,

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/metricgroup.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index c456fdeae06a..d3cf2dee36c8 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1073,16 +1073,18 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
> >
> >         ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
> >         if (ret)
> > -               return ret;
> > +               goto out;
> >
> >         ret = resolve_metric(d->metric_no_group,
> >                                      d->metric_list, NULL, d->ids);
> >         if (ret)
> > -               return ret;
> > +               goto out;
> >
> >         *(d->has_match) = true;
> >
> > -       return *d->ret;
> > +out:
> > +       *(d->ret) = ret;
> > +       return ret;
> >  }
> >
> >  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> > --
> > 2.26.2
> >

-- 

- Arnaldo
