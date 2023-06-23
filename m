Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E2EB64DD
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 23:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjFWXLZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 19:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjFWXLY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 19:11:24 -0400
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04187EA
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:11:23 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bd77424c886so1140914276.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jun 2023 16:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687561882; x=1690153882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YwmigcEEESvOYD+x372yFpLKh6lHO297GOtcjzBMVLY=;
        b=VUHZ3u4DJK8l1nSNYzrOTPv+0q1mEW3VBZfWuukdTypv+C1DgERjY/mycT+2f7DiuE
         sFK7BGBh8Sjq31KwR0LVPvcbtZaGBGsq8mPMCqxNzJGY8N7zkgqsjioI1hHjTpq1D7iQ
         uJdVBuZLyPbRaxkom/INzDl4siWn1FyPIRubrk6Iw3wsRESUx5JZucPpWj37RsOxQ0S5
         14N4AUMj4DJx/fqZSAFsgMYAQIYgU+54SMQYsT43v6L6HqkXycq+KfPgqo2g0o9QZk3T
         kkvmzkQ2HqWN0JtSXe7DeYWhn/ZQHsYt2Gj6KKMlImYlBJBsbw+KSHaZSDOu5+eZga+T
         k1gw==
X-Gm-Message-State: AC+VfDz1VkuddtaFdfgwbBwZNAdsxaOohqyEFc2aW4EkMwt9llxduqD2
        VyMgvW0BJckHwWSJoLtIY/QgjSm032a4HREPz/0=
X-Google-Smtp-Source: ACHHUZ5t8GihsmR3Ov20If3Bon5OlbqGAkJKblrWwfE1YAH6V6f+YIni54il9aoP0qvOo5B1b/MJXPyzZVbmN4Niv9k=
X-Received: by 2002:a25:ef12:0:b0:bec:9efe:100e with SMTP id
 g18-20020a25ef12000000b00bec9efe100emr20772059ybd.14.1687561882002; Fri, 23
 Jun 2023 16:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com> <ZIjMWUk/axKfMCM4@kernel.org>
 <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
 <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com> <CAM9d7cgcETpnNgvgJ8a966bwc0phQuVMwABHzA8APk6Z9Er=OQ@mail.gmail.com>
 <ee0bd9de-c2c7-010f-5a4d-40e07ded8a3e@linux.ibm.com> <CAM9d7cgopOAyL0QgHs+x_O9A6v020Jyaju+EOv8ymS_cg1Sarg@mail.gmail.com>
 <CAM9d7cgUXf6ew8_jK5P83QMCcQw5EVOUbHq561==qzUrf9tujQ@mail.gmail.com> <89f3889b-7d1e-0b04-34a0-f6eb8d9309c8@linux.ibm.com>
In-Reply-To: <89f3889b-7d1e-0b04-34a0-f6eb8d9309c8@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 16:11:10 -0700
Message-ID: <CAM9d7cjL0ddXSNej2KWuPBqCbgGP8kjLwzt9yX9CnA05jsfBtQ@mail.gmail.com>
Subject: Re: [PATCH 15/17] perf tests task_analyzer: fix bad substitution ${$1}
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     irogers@google.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        john.g.garry@oracle.com, kjain@linux.ibm.com,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, ravi.bangoria@amd.com,
        maddy@linux.ibm.com, jolsa@kernel.org,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        disgoel@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Aditya,

On Fri, Jun 23, 2023 at 11:19 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> Hello, Namhyung,
>
> On 23/06/23 04:55, Namhyung Kim wrote:
> > Ok, I found two problems.
> >
> > ...
> >
> > The first one is related to this message.  It couldn't find the script
> > (task-analyzer.py) because PERF_EXEC_PATH is not set.
> > Running with --exec-path=$PWD was ok, but I got a segfault.
> >
> > The other problem is in set_regs_in_dict().  It tries to capture
> > register values in the sample and save them to a dictionary.
> > The sample doesn't have registers so it should have no problem.
> > But the 'bf' was not initialized properly when size is 0, and it led
> > PyUnicode_FromString() returning NULL.
> >
> > After the changes, it ran ok:
> >
> > $ sudo ./perf test -v task
> > 116: perf script task-analyzer tests                                 :
> > --- start ---
> > test child forked, pid 204088
> > PASS: "test_basic"
> > PASS: "test_ns_rename"
> > PASS: "test_ms_filtertasks_highlight"
> > PASS: "test_extended_times_timelimit_limittasks"
> > PASS: "test_summary"
> > PASS: "test_summaryextended"
> > PASS: "test_summaryonly"
> > PASS: "test_extended_times_summary_ns"
> > PASS: "test_extended_times_summary_ns"
> > PASS: "test_csv"
> > PASS: "test_csvsummary"
> > PASS: "test_csv_extended_times"
> > PASS: "test_csvsummary_extended"
> > test child finished with 0
> > ---- end ----
> > perf script task-analyzer tests: Ok
> This is interesting. I did not encounter these earlier.
>
> > I'll send the fixes soon.
> >
> Thanks for fixing it.

No problem.

> >>> You can try the perf-tools-next branch in the perf/perft-tools-next.git repo.
> >>>
> >>>    git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> >>>
> >>>    $ make clean all
> >>>    $ sudo ./perf test -v task
> >>>
>
> I tested with the steps provided, i.e.. clone, /*apply patch 15 (added
> this step myself)*/, clean, make, ./perf test -v test. But still- test
> passed:
>
> '''
> ~/temp_clones/perf-tools-next/tools/perf git:(master) sudo ./perf test
> -v test
>
> ...
>
> --- start ---
> test child forked, pid 75261
> PASS: "test_basic"
> PASS: "test_ns_rename"
> PASS: "test_ms_filtertasks_highlight"
> PASS: "test_extended_times_timelimit_limittasks"
> PASS: "test_summary"
> PASS: "test_summaryextended"
> PASS: "test_summaryonly"
> PASS: "test_extended_times_summary_ns"
> PASS: "test_extended_times_summary_ns"
> PASS: "test_csv"
> PASS: "test_csvsummary"
> PASS: "test_csv_extended_times"
> PASS: "test_csvsummary_extended"
> test child finished with 0
> ---- end ----
> '''
>
> Maybe my environment had that other things set in a way that, I did not
> face any issue (I don't recall doing any special thing with my
> environment though, and these patches have been tested multiple times by
> more people also).
> But thanks for your efforts to debug and fix the issue.

I don't know but you might either set PERF_EXEC_PATH env or
install the scripts somewhere that can be found by default.

Thanks,
Namhyung
