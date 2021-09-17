Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E369C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8523D61152
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbhIQTSM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbhIQTSM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 15:18:12 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2BDC061574
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:16:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id b15so11360976ils.10
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0utUDHU5p18JMyukMfxcGrVkMwkedcIXc7VizY5R+P8=;
        b=W6l7KgDGXz2lMw4Pq3SmZRzZhi+sOvLppPrrQvcigEMP4RtEnMaBWKWGSBmHfBO3LC
         sFMYWN9TkCDCbG+M53RTNjf8/kcxMH0crDBaw2s7umnlF9bWLvJ+CQzy7B+npXaYQ0Sh
         PlTmeEXaTpa4DTUjI/bqyel6UpFNJC3MlxiS8wgzdPslzlK5FzvO6ye8fjRxMO23N5kL
         MzGq4hmppZQw9nqNHmzAE09XiSBh4AMYsKIkuZxUTGGi9vSJ09BodDje6ArBokAgyxl0
         +iL1Wkh4fq8/f7JfV6Fc5jcymST7wWHIPuCgfTpRylNpV/tLGqCVfYKETYH2UbbS0MuW
         28og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0utUDHU5p18JMyukMfxcGrVkMwkedcIXc7VizY5R+P8=;
        b=0SFApJDjpG8sp9lnc3Khvw26HxHfChVBOIWjPF2+ozjZTW0HF34Txz98FZRjywOjlj
         ff98jSrROz5q9oyrpUqVMVdsXJAjY53/CpFjIes0qKesnp/T9Mx1eZ4xad7EvTLrAg+G
         hTx0bs/0oFno8WtO6/Wh/pgALHNwlaPBGENNNAJeTQKzxqlBm+//ehuEYeXUOrTqasyG
         ZD33jUB1gds0kLl8bsnGNqFu7pwHrvKcDYZie7iCpR0yabuAthZFrK6hnPZEW7k+I8Vj
         y/B19BHljszFeiuMfguwJDlEHTeSjvd2TlALnX5rp++VYtwpimj6xroxl7heMR3s70e6
         Ekwg==
X-Gm-Message-State: AOAM5309Rv1pbHcPA1j8VCYoncjO3QeaT7ojLyxQKcZAJcHhTAKhHECH
        bSDQEIlPH6c+Q3TSCsyPBUuH8xEAaSr0CrsCzi8OEg==
X-Google-Smtp-Source: ABdhPJzLIBUHnD9ftwAcLNqrDK0tQV7kzf8ZkV8GyaORq4DC2PSMbOLz8sfI65gBqSyhioStYsBdCUul48YNGW+ZoQ4=
X-Received: by 2002:a92:c605:: with SMTP id p5mr8982501ilm.53.1631906208787;
 Fri, 17 Sep 2021 12:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210916060525.1890638-1-irogers@google.com> <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
In-Reply-To: <f7bbc59b-794f-2675-a044-1e3a58ad1495@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Sep 2021 12:16:37 -0700
Message-ID: <CAP-5=fUAxfHb8fNjpPKthztJhB7Q3yUZucLS-6kKZtq-iNOVoA@mail.gmail.com>
Subject: Re: [PATCH v2] perf test: Workload test of metric and metricgroups
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, Paul Clarke <pc@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 12:37 AM John Garry <john.garry@huawei.com> wrote:
>
> On 16/09/2021 07:05, Ian Rogers wrote:
> > Test every metric and metricgroup with 'true' as a workload.
> >
> > Signed-off-by: Ian Rogers<irogers@google.com>
>
> Reviewed-by: John Garry <john.garry@huawei.com>
>
> Note that I also had a local test for pmu events:
> for e in `$PERF list --raw-dump pmu`; do
>    echo "Testing $e"
>    result=$($PERF stat -v -e "$e" perf bench internals synthesize)
>    if [[ "$result" =~ "$e" ]]; then
>      echo "Event not printed: $e"
>      exit 1
>    fi
> done
>
> Is there any value in upstreaming this? I could not see same already
> there. Or else make your new script generic, so that it accepts an
> argument whether to test events or metrics or metricgroups

It is not easy to make a generic script with the current shell test
infrastructure. I made a variant of this test:
https://lore.kernel.org/linux-perf-users/20210917184240.2181186-2-irogers@google.com/T/#u
For skylake it ran for 1m15s and so it may be too slow. Perhaps we
need to add to the test infrastructure with some kind of speed flag.

Thanks,
Ian
