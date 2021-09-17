Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67268C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4307C61263
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhIQTTd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbhIQTTd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 15:19:33 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01117C061574
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:18:11 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x2so11348897ila.11
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=otIPOBKTALgDqmbdP0BjYHgFoa0MRSeqshKC5h3969Y=;
        b=Hd+4Aiyrp4nfBdHIyKtNFxYpomaky9COpAb7rrFjoWuG4rB/wWrvTmL6TAhi7IArtC
         PC0cFHKY+VI6OpfeMlWG/3BsFRpp9WFfLanu+/ZjpuWArtPopTIbU00NbvByamDDJfvf
         hRyvOupEj5JXm1Tr20b8zVMDofKS+ifaomP6UgeueedB3XYMeC+Pq72m6a/EnsKTJ23s
         cKin76OAiwd8BBf04fFBbwlbEs4mHsKU9RTAMT/9EXQmy3atgD8I1I+c52VvGOcMinyr
         C0FnfVZMvNt74O7DqLAIpoZe4PPOadicE8I7j3QtTimUsr5qr7mFe4NSMkeX7O3uH8MX
         SaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=otIPOBKTALgDqmbdP0BjYHgFoa0MRSeqshKC5h3969Y=;
        b=QCmY9OMcUoIK52iIwKPGsSPR1VuJ8xBDgjZj8ix4hD/pWntxftVzVmqNLy95yuuoUw
         eI5bdYOv4WOzeTV3ElaBYblqLjLP1B3GONlpY32mHTl1SFn/N5d+RJM7PMlv10ujHWZ0
         4QLPYN1QpyB4FWN3ar0O7Y5LfmJVyfeQeAN0JDWpgw5yJ87Fe6grXHUEKT2HuVPdUK16
         fExqEFtC7bvZC8lsjFPKR7kM16bcIgcE4Nu0w6ZBo+prPqvqP9CEOjJ2CQKGUSqekj1V
         zFeo84Z1wFeGtHE6LDelejbcovP59UOO4RVdlsUC5QG0zV/hxxqaEP55aWFoubNE/fG0
         wC2g==
X-Gm-Message-State: AOAM533Y0/GqiPMy5NrwrbsYybudIYo/G+ZgfJw4ym0tw359qQ9hRHVp
        /cf57Uo9+UqOQK+n6yxFOKjVbq1tMglsn+THdCpKTg==
X-Google-Smtp-Source: ABdhPJwO4lTQDkRkbVTyTpduTA26sQmiR/zfjwYcA3bV1lVvYfzxRbHv09r71vTkttCg1LhVkWw72RbaIAIZz2wEAn0=
X-Received: by 2002:a92:440c:: with SMTP id r12mr9077114ila.174.1631906290176;
 Fri, 17 Sep 2021 12:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210916060525.1890638-1-irogers@google.com> <20210916120434.GA4498@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
In-Reply-To: <20210916120434.GA4498@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Sep 2021 12:17:58 -0700
Message-ID: <CAP-5=fV63VtSgfjVn=uSWqBq1LuFA4fBnjyFtKR+5qdg9+w9yw@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     "Paul A. Clarke" <pc@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 5:04 AM Paul A. Clarke <pc@us.ibm.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:05:25PM -0700, Ian Rogers wrote:
> > Test every metric and metricgroup with 'true' as a workload.
>
> Good idea!  (However...)
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat_all_metricgroups.sh | 12 ++++++++++++
> >  tools/perf/tests/shell/stat_all_metrics.sh      | 16 ++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
> >  create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
> >
> > diff --git a/tools/perf/tests/shell/stat_all_metricgroups.sh b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > new file mode 100755
> > index 000000000000..de24d374ce24
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat_all_metricgroups.sh
> > @@ -0,0 +1,12 @@
> > +#!/bin/sh
> > +# perf all metricgroups test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +for m in $(perf list --raw-dump metricgroups); do
> > +  echo "Testing $m"
> > +  perf stat -M "$m" true
> > +done
> > +
> > +exit 0
>
> This always succeeds. Is that what you want?
> Maybe check the return code from "perf", at least?

The "set -e" above means that if the perf command fails then the test exits.

> > diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/tests/shell/stat_all_metrics.sh
> > new file mode 100755
> > index 000000000000..81b19ba27e68
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> > @@ -0,0 +1,16 @@
> > +#!/bin/sh
> > +# perf all metrics test
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +for m in `perf list --raw-dump metrics`; do
> > +  echo "Testing $m"
> > +  result=$(perf stat -M "$m" true)
>
> I don't think this is doing what you want it to do, as it just captures the
> output of "true", which is always empty.
>
> > +  if [[ "$result" =~ "$m" ]]; then
>
> So this always fails to match, and you'll never fail here, either. :-)

Doh! Thanks for catching this!

> > +    echo "Metric not printed: $m"
> > +    exit 1
> > +  fi
> > +done
> > +
> > +exit 0
>
> You may want to redirect the output of the "perf" command to a temporary file,
> then grep within that.  And, you'll need to remove the file before running the
> perf command, because if it fails, it will leave any existing file untouched.

I fixed it by redirecting stderr.

Thanks!
Ian

> Thanks! :-)
>
> PC
