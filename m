Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DBEB64DC
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjFVVdU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjFVVdT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 17:33:19 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936791FF6
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 14:33:14 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bb3a77abd7bso7383867276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 14:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687469593; x=1690061593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNlPBraAb0ddYlZ5jLanYEj5hG5ppMWiPaAkJlDVGoo=;
        b=Q77f4DmhqYZ9ziUAl3VV3hsm1LwDCl6r9NEhcQxWo//4K43nqAuUkmjFBt7EWXZHf3
         wvdfRar72Y/J4aUYBZA4rPhS6bniiC7UhkTuy0zrw1ggf+iDK+WwKig3P7Jnr6r+3Wve
         DKmeLJ/stiOquJRcy8EttCx7YQsVgUZCf7d2YblhLNDRjoa1p4ifOgjTpGGClPCtMZqP
         3A8ZaA8h936o/FFErDXvb0uBtE1xZh5bHz/VTMOV05pBbUVr+aph+pSc97dN3kM6ciZ0
         +TDtaPoDQ+ZHF1kS1w3lhcpX7/7f1w6v/VxSPtg7WvMHyiEg7OUY+VJLCNDbaiHlVebd
         JrSQ==
X-Gm-Message-State: AC+VfDzZC2OGXxshrjFh322MtBb+tCZYiFkRVb+vULSr9i9Y1LslKa1Y
        t7vuu9lNrdI4ZqGlBfNnbFjhMyaGuADZXOuyrtA=
X-Google-Smtp-Source: ACHHUZ7ahP08mnJ+Pi0ywwdKgRpTuottvev/vWGMxKQ6Mn3ROdJWIjWu36O2obVi65pWifmkIbtWlVGZ96tjwWogEjk=
X-Received: by 2002:a0d:d485:0:b0:56d:541b:a02e with SMTP id
 w127-20020a0dd485000000b0056d541ba02emr19452926ywd.1.1687469593617; Thu, 22
 Jun 2023 14:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com> <ZIjMWUk/axKfMCM4@kernel.org>
 <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
 <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com> <CAM9d7cgcETpnNgvgJ8a966bwc0phQuVMwABHzA8APk6Z9Er=OQ@mail.gmail.com>
 <ee0bd9de-c2c7-010f-5a4d-40e07ded8a3e@linux.ibm.com>
In-Reply-To: <ee0bd9de-c2c7-010f-5a4d-40e07ded8a3e@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 14:33:01 -0700
Message-ID: <CAM9d7cgopOAyL0QgHs+x_O9A6v020Jyaju+EOv8ymS_cg1Sarg@mail.gmail.com>
Subject: Re: [PATCH 15/17] perf tests task_analyzer: fix bad substitution ${$1}
To:     Aditya Gupta <adityag@linux.ibm.com>
Cc:     Hagen Paul Pfeifer <hagen@jauu.net>,
        Petar Gligoric <petar.gligoric@rohde-schwarz.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>, jolsa@kernel.org,
        irogers@google.com, ravi.bangoria@amd.com, john.g.garry@oracle.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Aditya,

On Wed, Jun 21, 2023 at 11:43 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
>
> Hello Namhyung,
>
> On 21/06/23 20:53, Namhyung Kim wrote:
> > Hello Aditya,
> >
> > On Wed, Jun 21, 2023 at 3:05 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >> Hello Namhyung,
> >>
> >> On 21/06/23 06:18, Namhyung Kim wrote:
> >>> ...
> >>>
> >>> $ sudo ./perf test -v task
> >>> 114: perf script task-analyzer tests                                 :
> >>> --- start ---
> >>> test child forked, pid 1771042
> >>> Please specify a valid report script(see 'perf script -l' for listing)
> >>> FAIL: "invocation of perf command failed" Error message: ""
> >>> FAIL: "test_basic" Error message: "Failed to find required string:'Comm'."
> >>> Please specify a valid report script(see 'perf script -l' for listing)
> >>> FAIL: "invocation of perf command failed" Error message: ""
> >>> FAIL: "test_ns_rename" Error message: "Failed to find required string:'Comm'."
> >>> ...
> >>> test child finished with -1
> >>> ---- end ----
> >>> perf script task-analyzer tests: FAILED!
> >> Can you please check if your environment has libtraceevent devel
> >> libraries (or did you compile with `make NO_LIBTRACEEVENT=1`) ? When
> >> libtraceevent support is not there, perf record fails and so perf.data
> >> doesn't contain the strings it's searching for and hence those errors
> >>
> >> The error you mentioned has been mentioned and fixed in patch 17/17 of
> >> this series.
> > Thanks for your reply but It has libtraceevent.  Also, shouldn't it
> > skip if it's not?
> >
> > Thanks,
> > Namhyung
>
> The skipping is handled in the 17th patch in this series, and
> considering that patch has also been applied, it will skip the tests if
> perf wasn't built with proper libtraceevent support.

Right, I tested it with the whole series applied.
It skipped to run when I disable libtraceevent build.

>
> Back to the error, Sorry but I tested again on my system and am unable to reproduce the issue you are seeing when built with libtraceevent support.
>
> This is what I did:
>
> 0. git clone --depth=1 https://github.com/torvalds/linux
> 0. cd linux/tools/perf
> 0. git am patch_15/17.patch
>
> > I applied ONLY this patch (15/17) of this series, to a fresh linux tree
>
> 1. dnf install libtraceevent-devel
> 2. make clean && make
> 3. sudo ./perf test -v "perf script task-analyzer tests"       # Working fine, tests passed
>
> 4. dnf remove libtraceevent-devel
> 5. make clean && make                                          # There will also be a warning during build: "libtraceevent is missing limiting functionality"
> 6. sudo ./perf test -v "perf script task-analyzer tests"       # Fails with the error you posted, which was the case till now, it's skipped when the 17th patch is also applied and perf built without libtraceevent support
>
> The error in the second case (without proper libtraceevent support) is expected, as it was the case till now, that is fixed by the 17th patch, try applying that also and build perf with `make NO_LIBTRACEEVENT=1`, it will skip then.
>
> Can you guide me with the steps to reproduce the error ?

You can try the perf-tools-next branch in the perf/perft-tools-next.git repo.

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

  $ make clean all
  $ sudo ./perf test -v task

>
> Sidenote: Just in case, please ensure you are running the perf as root here as `perf record -e sched:sched_switch -a -- sleep 1` requires root, which has been used in `prepare_perf_data`

Sure, I ran the perf test as root.

Thanks,
Namhyung
