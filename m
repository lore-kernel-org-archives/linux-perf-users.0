Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45984EB64DA
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jun 2023 23:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjFVXZa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jun 2023 19:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjFVXZ3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jun 2023 19:25:29 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68DC1739
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 16:25:27 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-be49ca27e1fso26200276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 16:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687476327; x=1690068327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9D6B66keXspOwOyeSzVdCMdoaD18gxGOjW8uCE3irU=;
        b=aFAriXcPOf7V7mv8j5fHtX+5WWIEQ4niX/xtFgvcHVprZnwIV4N1eqQCd7xHwQ0NI9
         NhM+RkH3uIXCSF+JgXcA8QrBVhVF6/Bcz8o60Vc4Dq6qdObwGc1bE1uecqlTfr3QANaR
         2DA1xKU+Md6KC1VnwQPOmQBOz2QFDyZJTXIOD+YKctcHdPu97q4sxbKDIdcAhl0vV7uz
         uy3VSQAwQY50LBooQQwVFv1OIEYoArYKRvifvsUhPPBPOVisntaV8rUONsrWpgCQkCsN
         2N/M122SAOxnMY5W2peSp0rVrmPmCdurh+IrzWM3CdB1ngrEC0fjPX3tro8DM00vCQ6s
         HmYw==
X-Gm-Message-State: AC+VfDx4pEHltYZm0LFqfD5pYzbXnV8QcqKttUb/+cFcki30xm5U2lIv
        LeM4Riz7535jIQDhJtZQeMP3vuQNPBobkidhbiKGsa56feE=
X-Google-Smtp-Source: ACHHUZ6ow45EkSIu6x2UiZKABNGioITYXlqZL321AvKNL3uQdrkqXktRyCwCb9+t4InlJhT0T+mWcfd32Q/+yl/jJXU=
X-Received: by 2002:a25:2693:0:b0:bcd:9e0d:168b with SMTP id
 m141-20020a252693000000b00bcd9e0d168bmr16144564ybm.31.1687476326755; Thu, 22
 Jun 2023 16:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230613164145.50488-1-atrajeev@linux.vnet.ibm.com>
 <20230613164145.50488-16-atrajeev@linux.vnet.ibm.com> <ZIjMWUk/axKfMCM4@kernel.org>
 <CAM9d7cjrpaNk0UC22ntBSP+LzQwT2YAHwQ2o3z1aayAZNQ329g@mail.gmail.com>
 <5ab5cc25-03b0-ef7f-3dc0-be1b59a4147d@linux.ibm.com> <CAM9d7cgcETpnNgvgJ8a966bwc0phQuVMwABHzA8APk6Z9Er=OQ@mail.gmail.com>
 <ee0bd9de-c2c7-010f-5a4d-40e07ded8a3e@linux.ibm.com> <CAM9d7cgopOAyL0QgHs+x_O9A6v020Jyaju+EOv8ymS_cg1Sarg@mail.gmail.com>
In-Reply-To: <CAM9d7cgopOAyL0QgHs+x_O9A6v020Jyaju+EOv8ymS_cg1Sarg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 22 Jun 2023 16:25:15 -0700
Message-ID: <CAM9d7cgUXf6ew8_jK5P83QMCcQw5EVOUbHq561==qzUrf9tujQ@mail.gmail.com>
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

Ok, I found two problems.

On Thu, Jun 22, 2023 at 2:33 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello Aditya,
>
> On Wed, Jun 21, 2023 at 11:43 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
> >
> > Hello Namhyung,
> >
> > On 21/06/23 20:53, Namhyung Kim wrote:
> > > Hello Aditya,
> > >
> > > On Wed, Jun 21, 2023 at 3:05 AM Aditya Gupta <adityag@linux.ibm.com> wrote:
> > >> Hello Namhyung,
> > >>
> > >> On 21/06/23 06:18, Namhyung Kim wrote:
> > >>> ...
> > >>>
> > >>> $ sudo ./perf test -v task
> > >>> 114: perf script task-analyzer tests                                 :
> > >>> --- start ---
> > >>> test child forked, pid 1771042
> > >>> Please specify a valid report script(see 'perf script -l' for listing)

The first one is related to this message.  It couldn't find the script
(task-analyzer.py) because PERF_EXEC_PATH is not set.
Running with --exec-path=$PWD was ok, but I got a segfault.

The other problem is in set_regs_in_dict().  It tries to capture
register values in the sample and save them to a dictionary.
The sample doesn't have registers so it should have no problem.
But the 'bf' was not initialized properly when size is 0, and it led
PyUnicode_FromString() returning NULL.

After the changes, it ran ok:

$ sudo ./perf test -v task
116: perf script task-analyzer tests                                 :
--- start ---
test child forked, pid 204088
PASS: "test_basic"
PASS: "test_ns_rename"
PASS: "test_ms_filtertasks_highlight"
PASS: "test_extended_times_timelimit_limittasks"
PASS: "test_summary"
PASS: "test_summaryextended"
PASS: "test_summaryonly"
PASS: "test_extended_times_summary_ns"
PASS: "test_extended_times_summary_ns"
PASS: "test_csv"
PASS: "test_csvsummary"
PASS: "test_csv_extended_times"
PASS: "test_csvsummary_extended"
test child finished with 0
---- end ----
perf script task-analyzer tests: Ok

I'll send the fixes soon.

Thanks,
Namhyung


> > >>> FAIL: "invocation of perf command failed" Error message: ""
> > >>> FAIL: "test_basic" Error message: "Failed to find required string:'Comm'."
> > >>> Please specify a valid report script(see 'perf script -l' for listing)
> > >>> FAIL: "invocation of perf command failed" Error message: ""
> > >>> FAIL: "test_ns_rename" Error message: "Failed to find required string:'Comm'."
> > >>> ...
> > >>> test child finished with -1
> > >>> ---- end ----
> > >>> perf script task-analyzer tests: FAILED!
> > >> Can you please check if your environment has libtraceevent devel
> > >> libraries (or did you compile with `make NO_LIBTRACEEVENT=1`) ? When
> > >> libtraceevent support is not there, perf record fails and so perf.data
> > >> doesn't contain the strings it's searching for and hence those errors
> > >>
> > >> The error you mentioned has been mentioned and fixed in patch 17/17 of
> > >> this series.
> > > Thanks for your reply but It has libtraceevent.  Also, shouldn't it
> > > skip if it's not?
> > >
> > > Thanks,
> > > Namhyung
> >
> > The skipping is handled in the 17th patch in this series, and
> > considering that patch has also been applied, it will skip the tests if
> > perf wasn't built with proper libtraceevent support.
>
> Right, I tested it with the whole series applied.
> It skipped to run when I disable libtraceevent build.
>
> >
> > Back to the error, Sorry but I tested again on my system and am unable to reproduce the issue you are seeing when built with libtraceevent support.
> >
> > This is what I did:
> >
> > 0. git clone --depth=1 https://github.com/torvalds/linux
> > 0. cd linux/tools/perf
> > 0. git am patch_15/17.patch
> >
> > > I applied ONLY this patch (15/17) of this series, to a fresh linux tree
> >
> > 1. dnf install libtraceevent-devel
> > 2. make clean && make
> > 3. sudo ./perf test -v "perf script task-analyzer tests"       # Working fine, tests passed
> >
> > 4. dnf remove libtraceevent-devel
> > 5. make clean && make                                          # There will also be a warning during build: "libtraceevent is missing limiting functionality"
> > 6. sudo ./perf test -v "perf script task-analyzer tests"       # Fails with the error you posted, which was the case till now, it's skipped when the 17th patch is also applied and perf built without libtraceevent support
> >
> > The error in the second case (without proper libtraceevent support) is expected, as it was the case till now, that is fixed by the 17th patch, try applying that also and build perf with `make NO_LIBTRACEEVENT=1`, it will skip then.
> >
> > Can you guide me with the steps to reproduce the error ?
>
> You can try the perf-tools-next branch in the perf/perft-tools-next.git repo.
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
>
>   $ make clean all
>   $ sudo ./perf test -v task
>
> >
> > Sidenote: Just in case, please ensure you are running the perf as root here as `perf record -e sched:sched_switch -a -- sleep 1` requires root, which has been used in `prepare_perf_data`
>
> Sure, I ran the perf test as root.
>
> Thanks,
> Namhyung
