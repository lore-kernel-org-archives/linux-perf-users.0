Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93BC433ED
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 May 2021 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA5C61260
	for <linux-perf-users@archiver.kernel.org>; Sat,  8 May 2021 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbhEHOZs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 May 2021 10:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhEHOZs (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 May 2021 10:25:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A4EF61152;
        Sat,  8 May 2021 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620483887;
        bh=8PNUi3u1sNjGhQpreLLWjaaXpzUEGjI9S77UbGL/xoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+4wIOzUZ1E6nPQF7zk9L/b2q0DET3en9a0CTWuZ+m3UbEXLF+TywTwibFFMMW5Vk
         bc4a5R47Jqv7NWmr2x8t4rb7FuKvMS3574C0IEak1ttu+R83/W6S4Dt8R2UrvpxRG1
         eYc5DYRx0LueoCm72TA4OgbMHJvPS6nA7ro9s6hGIceXz4S0FK1KiOeUR0zfpu5sIP
         vZ7uzfqcSPU2RSjgLEXUJpzbNmBXiF1A8jc1JKFlUSfffyxsmtdeTBoNjqqQGswqaI
         SE2WZscLr48Z8JhSVhZyxCQFUpqsbAocVgZSphvAydghXq397fZTAVuH+stjT+xE31
         SEV9r0e3/LnZQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 106144034C; Sat,  8 May 2021 11:24:44 -0300 (-03)
Date:   Sat, 8 May 2021 11:24:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf jevents: Silence warning for ArchStd files
Message-ID: <YJafLNqrrP3RHx+v@kernel.org>
References: <20210506225640.1461000-1-irogers@google.com>
 <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
 <CAP-5=fUGRU+vi5NfYLBV9dXgZcG0WY45srsi3Q75T7pPLBLnMQ@mail.gmail.com>
 <946c888e-7918-3692-ecdd-9f4706cbc764@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946c888e-7918-3692-ecdd-9f4706cbc764@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, May 07, 2021 at 05:29:06PM +0100, John Garry escreveu:
> On 07/05/2021 16:46, Ian Rogers wrote:
> > On Fri, May 7, 2021 at 2:00 AM John Garry<john.garry@huawei.com>  wrote:
> > > On 06/05/2021 23:56, Ian Rogers wrote:
> > > > json files in the level 1 directory are used for ArchStd events (see
> > > > preprocess_arch_std_files), as such they shouldn't be warned about.
> > > > 
> > > > Signed-off-by: Ian Rogers<irogers@google.com>
> > > > ---
> > > >    tools/perf/pmu-events/jevents.c | 6 ++++--
> > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > > > index ed4f0bd72e5a..7422b0ea8790 100644
> > > > --- a/tools/perf/pmu-events/jevents.c
> > > > +++ b/tools/perf/pmu-events/jevents.c
> > > > @@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
> > > >                        mapfile = strdup(fpath);
> > > >                        return 0;
> > > >                }
> > > > -
> > > > -             pr_info("%s: Ignoring file %s\n", prog, fpath);
> > > > +             if (is_json_file(bname))
> > > > +                     pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath)
> > > We could get more elaborate and add the same first debug print in
> > > process_one_file() to preprocess_arch_std_file() to give the allusion
> > > that they are preprocessed, and change the logic not print that for arch
> > > std files (in process_one_file()). But not sure it's worth it.
> > > 
> > > Or else we could also just omit any print here for archstd files here.
> > I thought about just dropping the print in the json case but then a
> > comment would be nice, the pr_debug is a comment and is somewhat
> > intention revealing. If you think it is overkill then it is ok to
> > change.
> 
> I don't think it's a big deal either way.
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

