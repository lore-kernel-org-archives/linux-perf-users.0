Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC2CC433ED
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 15:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77636101B
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 15:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhEGPrg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhEGPrf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 11:47:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF55C061574
        for <linux-perf-users@vger.kernel.org>; Fri,  7 May 2021 08:46:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so5153995wmi.5
        for <linux-perf-users@vger.kernel.org>; Fri, 07 May 2021 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GDSU3NyJoM3TtAqkaOuxI+xXnlW2O+Y5nyMcEDmyIII=;
        b=VWcK243zBHE3fWspx93g1gW0jEYLon7Z/Nl3nhrux7Ec49y7Kvp2q/JilCCY296Yon
         U2ae3jMKwt+v4+fBLHu+brhc/wzRdeHwqY5ZuvKxDraa80ksEnaNnbYpcWJpkniRwcBC
         n0Q8zAei4osbO5QP7z7KnqjtYN0hx33s3gIx0Oc7DezgXKbYvLH7JaeRrOTmBstvfD1C
         JS5vnZvhTomexGMN3PwizYWp591mtjrhCKPMT+b5aMMHO0fXPvomKGfQS007GPG21Ex3
         oje0OdZojAWNpUmf0YBaVX0aoquiWfN4dpSYo5ywIiiJ7w6UDqDIQBpDUdZoywkUJd8H
         VNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GDSU3NyJoM3TtAqkaOuxI+xXnlW2O+Y5nyMcEDmyIII=;
        b=KRNxnIaDHdyVj4j6hSxInJcHSIr/3y9FxJlRBJR67Fd4b7dYC8sXJL+xWr2ttWhZ49
         Lf54ztKt6svuOdcu4SBDJLwPmCbmFpTSdDPiqeTO1+VIxgPo7UqyeIYZXHrdZxmn9znh
         fNyiU+EB/XbMbFU1URag9AIbVHRhA/1/jl3dj4XsX1ks8DCuK1DEFG/R7uSgCYtozcSN
         1qu096Xbw8+7htSgLqU0nsuem/d1mpvFSaqQqmDnkGy6/FltRXi3fEhGwZ+VfwMPPs+h
         PQFElnBxe8uxta5nbGRl5n9KHHolbjtalOEmwWv39+L7F9tuNvFF8gXygNPY4PWGYHfo
         PE8Q==
X-Gm-Message-State: AOAM531f42WEB2xp7GrLb3qfDyWo1l1d3Rt2w8amLdDYtRqI6m3DYWvw
        0h2n5ooO5iTcwG9nvUW9M9a6LMCIz/3RkJcHOo39Vg==
X-Google-Smtp-Source: ABdhPJzBJUihs1zaPpJGx1LNi2iFlYZvMYXnh2trzLY/iUEkQdrt67lkQR3hPtEv8K7xCbTJ5TsX27xrN3KqtINmACE=
X-Received: by 2002:a1c:cc0b:: with SMTP id h11mr21941857wmb.87.1620402392768;
 Fri, 07 May 2021 08:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210506225640.1461000-1-irogers@google.com> <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
In-Reply-To: <4f9a4f20-82ac-dd68-4aee-b560396755f2@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 7 May 2021 08:46:19 -0700
Message-ID: <CAP-5=fUGRU+vi5NfYLBV9dXgZcG0WY45srsi3Q75T7pPLBLnMQ@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Silence warning for ArchStd files
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 7, 2021 at 2:00 AM John Garry <john.garry@huawei.com> wrote:
>
> On 06/05/2021 23:56, Ian Rogers wrote:
> > json files in the level 1 directory are used for ArchStd events (see
> > preprocess_arch_std_files), as such they shouldn't be warned about.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/pmu-events/jevents.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> > index ed4f0bd72e5a..7422b0ea8790 100644
> > --- a/tools/perf/pmu-events/jevents.c
> > +++ b/tools/perf/pmu-events/jevents.c
> > @@ -1123,8 +1123,10 @@ static int process_one_file(const char *fpath, const struct stat *sb,
> >                       mapfile = strdup(fpath);
> >                       return 0;
> >               }
> > -
> > -             pr_info("%s: Ignoring file %s\n", prog, fpath);
> > +             if (is_json_file(bname))
> > +                     pr_debug("%s: ArchStd json is preprocessed %s\n", prog, fpath)
> We could get more elaborate and add the same first debug print in
> process_one_file() to preprocess_arch_std_file() to give the allusion
> that they are preprocessed, and change the logic not print that for arch
> std files (in process_one_file()). But not sure it's worth it.
>
> Or else we could also just omit any print here for archstd files here.

I thought about just dropping the print in the json case but then a
comment would be nice, the pr_debug is a comment and is somewhat
intention revealing. If you think it is overkill then it is ok to
change.

Thanks,
Ian

> But I suppose what you are doing is ok...
>
> Thanks,
> John
>
> > +             else
> > +                     pr_info("%s: Ignoring file %s\n", prog, fpath);
> >               return 0;
> >       }
> >
> >
>
