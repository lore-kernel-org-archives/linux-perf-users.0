Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55F6EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 18:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjGESZw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbjGESZu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 14:25:50 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2610F1BD9
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Jul 2023 11:25:26 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-570877f7838so85040767b3.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Jul 2023 11:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688581502; x=1691173502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLQigBjvEsL4L4SEWiFAmw+5TP0gGuXu4MpzoGKUTGI=;
        b=OaxYhEmwjQnlYT+t+qNPqErOoysJQVhSgke3TKzum1lHXwZtEQacoHMJV5JcEAPBFg
         TTCQNFddAMHlLmU2Tp/EMWNcGFCa2hQZbiH4O9MFIvWuX3X4+xn3n3exwGo0RGCL1klm
         eGPQ9NnSL9y0GG0mmJQ1Esp41G/3k4pokItVvwonQvs0iD1nKwmtM4/OuRVoPPVFCURQ
         OuKhDh2ZmcMmuNzAnkosbQSEdXQgw1077KDM0jXHGh/OdPIvPm613Au78d5/+9kfV9ij
         H9K10PjqE6EPQ5Ti8G3Tb9mDeKj13Sm4Ou7WJfKdqQGJpopbR4NCQtsx7SpMyEx8nf9A
         RNCA==
X-Gm-Message-State: ABy/qLajzE7vtvCjUIo7mW+uqv7T2YMoonD5gyCYgV4sQjNwF9x1AVnB
        dgLsrl26/wOibXhtvEYggrXHyYFpGccgrmtRF00=
X-Google-Smtp-Source: APBJJlEZp5VBkE7EXQVipl0ZmJqRv4vOXxGE3w348J8DHFyeF3664343o6i3s30KMoEQytttMjfQzMfNYTRdNgFwUHQ=
X-Received: by 2002:a25:8b06:0:b0:c57:81fd:904d with SMTP id
 i6-20020a258b06000000b00c5781fd904dmr6698484ybl.10.1688581501864; Wed, 05 Jul
 2023 11:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230615073803.54481-1-atrajeev@linux.vnet.ibm.com> <AEE7B55C-BA6B-4E0E-A2E9-4E7EE09B4D50@linux.vnet.ibm.com>
In-Reply-To: <AEE7B55C-BA6B-4E0E-A2E9-4E7EE09B4D50@linux.vnet.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 11:24:50 -0700
Message-ID: <CAM9d7chEpdJkpWuxZD2-w89SFBm9CU28MpLA40LV+=GaLJXS1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/perf/tests: perf all metrics test fails when
 perf_event access is restricted
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>, jolsa@kernel.org,
        irogers@google.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 3, 2023 at 10:04 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 15-Jun-2023, at 1:08 PM, Athira Rajeev <atrajeev@linux.vnet.ibm.com> wrote:
> >
> > Perf all metrics test fails as below when perf_event access
> > is restricted.
> >
> >    ./perf test -v "perf all metrics test"
> >    Metric 'Memory_RD_BW_Chip' not printed in:
> >    Error:
> >    Access to performance monitoring and observability operations is limited.
> >    Enforced MAC policy settings (SELinux) can limit access to performance
> >    —
> >    access to performance monitoring and observability operations for processes
> >    without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> >    —
> >    test child finished with -1
> >    ---- end ----
> >    perf all metrics test: FAILED!

In my system, it fails like below:

  $ ./perf test -v 101
  101: perf all metrics test                                           :
  --- start ---
  test child forked, pid 398458
  Testing branch_misprediction_ratio
  Testing all_remote_links_outbound
  Metric 'all_remote_links_outbound' not printed in:
  Error:
  Invalid event (remote_outbound_data_controller_3:u) in per-thread
mode, enable system wide with '-a'.
  Testing nps1_die_to_dram
  ...

Thanks,
Namhyung

>
>
> Hi,
>
> Looking for review comments on this patch.
>
> Thanks
> >
> > The perf all metrics test picks the input events from
> > "perf list --raw-dump metrics" and runs "perf stat -M "$m""
> > for each of the metrics in the list. It fails here for some
> > of the metrics which needs access, since it collects system
> > wide resource details/statistics. Fix the testcase to skip
> > those metric events.
> >
> > Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> > ---
> > tools/perf/tests/shell/stat_all_metrics.sh | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> > index 54774525e18a..14b96484a359 100755
> > --- a/tools/perf/tests/shell/stat_all_metrics.sh
> > +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> > @@ -6,7 +6,9 @@ err=0
> > for m in $(perf list --raw-dump metrics); do
> >   echo "Testing $m"
> >   result=$(perf stat -M "$m" true 2>&1)
> > -  if [[ "$result" =~ ${m:0:50} ]] || [[ "$result" =~ "<not supported>" ]]
> > +  # Skip if there is no access to perf_events monitoring
> > +  # and observability operations
> > +  if [[ "$result" =~ ${m:0:50} ]] || [[ "$result" =~ "<not supported>" ]] || [[ "$result" =~ "Access to performance monitoring and observability operations is limited" ]]
> >   then
> >     continue
> >   fi
> > --
> > 2.31.1
> >
>
