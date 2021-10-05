Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3312C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 16:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D220261381
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 16:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhJEQiW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 12:38:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233896AbhJEQiW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 12:38:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4213961501;
        Tue,  5 Oct 2021 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633451791;
        bh=TE1byajMD4BEXyGVyWtNuptLh2myMAefZKocS/zdfIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g4ehtVhCpXI/h0RcaVu7/cmGWYbaHpAuz4q0prTAJg+q8HEnovvV2EKJNNs1dgUdw
         fe7/KOJYfcOc4Qmv1KAMvS9cPfrD6KCQFW/bZRIyr4NiwpCa8Zm1QhcIpzR1Sw/pB+
         01WkZQinTAkqj3rWOWI0O8jJTWkBePImbHJ6kQnxoDqPpvwfTKfygrliV68HD6os2C
         PNlCGgYqozgP8PCU59i9ocbqaHlwFE22+fFb+mKgMqqoiNsQsCiYpULRe2Cs9eemB9
         eAubFYgjPmAOPJBbf1AoAoz1B/m1T2FzfoejA8JPcnpBfO/83nE+c+WypdDXYj1M5q
         OSgWPcbkYFe2w==
Received: by mail-ed1-f45.google.com with SMTP id z1so1093478edb.8;
        Tue, 05 Oct 2021 09:36:31 -0700 (PDT)
X-Gm-Message-State: AOAM5300hjr+xHOKnsVtYs9QW/8dX4e9WbVmx6G4c83sfNLpi8peP5Y9
        0m5tcFCZkr9i5av330/jLTGYIS/E8A4+NGwZSw==
X-Google-Smtp-Source: ABdhPJzR0I+KymQcG3+ZDCX9WpcmJx2FX408lmStJiMaHFdL3t7vpRPyZ2jofy8Uel4WNW674wFpAqqn2UKbbV76JXM=
X-Received: by 2002:a50:a402:: with SMTP id u2mr6088428edb.164.1633451789787;
 Tue, 05 Oct 2021 09:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210922101627.3396398-1-nakamura.shun@fujitsu.com>
 <20210922101627.3396398-2-nakamura.shun@fujitsu.com> <YUuhe7e0J0PSea+b@krava> <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB4600A329F99490D206990EC0F7A89@OSBPR01MB4600.jpnprd01.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 5 Oct 2021 11:36:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLrHLmEM06mxJ8V304VTmKHYU8Pca5h=jMJQe1beoXbDw@mail.gmail.com>
Message-ID: <CAL_JsqLrHLmEM06mxJ8V304VTmKHYU8Pca5h=jMJQe1beoXbDw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libperf: Add processing to scale the counters
 obtained during the read() system call when multiplexing
To:     "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 28, 2021 at 7:41 AM nakamura.shun@fujitsu.com
<nakamura.shun@fujitsu.com> wrote:
>
> Hi Jirka
>
> > On Wed, Sep 22, 2021 at 07:16:26PM +0900, Shunsuke Nakamura wrote:
> > > From: nakamura shunsuke <nakamura.shun@fujitsu.com>
> > >
> > > perf_evsel__read() scales counters obtained by RDPMC during multiplexing, but
> > > does not scale counters obtained by read() system call.
> > >
> > > Add processing to perf_evsel__read() to scale the counters obtained during the
> > > read() system call when multiplexing.
> > >
> > >
> > > Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
> > > ---
> > >  tools/lib/perf/evsel.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > index 8441e3e1aaac..0ebd1d34436f 100644
> > > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > > @@ -18,6 +18,7 @@
> > >  #include <sys/ioctl.h>
> > >  #include <sys/mman.h>
> > >  #include <asm/bug.h>
> > > +#include <linux/math64.h>
> > >
> > >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
> > >                      int idx)
> > > @@ -321,6 +322,11 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > >        if (readn(*fd, count->values, size) <= 0)
> > >                return -errno;
> > >
> > > +     if (count->ena != count->run) {
> > > +             if (count->run != 0)
> > > +                     count->val = mul_u64_u64_div64(count->val, count->ena, count->run);
> > > +     }
> >
> > so I think perf stat expect raw values in there and does the
> > scaling by itself, please check following code:
> >
> > read_counters
> >   read_affinity_counters
> >     read_counter_cpu
> >       read_single_counter
> >         evsel__read_counter
> >
> >   perf_stat_process_counter
> >     process_counter_maps
> >       process_counter_values
> >         perf_counts_values__scale
> >
> >
> > perhaps we could export perf_counts_values__scale if it'd be any help
>
> Thank you for your comment.
>
> The purpose of this patch is to unify the counters obtained with
> perf_evsel__read() to scaled or unscaled values.
>
> perf_evsel__read() gets counter by perf_mmap__read_self() if RDPMC is
> available, else gets by readn(). In current implementation, caller
> gets scaled counter if goes through RDPMC path, otherwise gets unscaled
> counter via readn() path.
>
> However caller cannnot know which path were taken.
>
> If caller expects a raw value, I think the RDPMC path should also
> return an unscaled counter.
>
> diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> index c89dfa5..aaa4579 100644
> --- a/tools/lib/perf/mmap.c
> +++ b/tools/lib/perf/mmap.c
> @@ -353,8 +353,6 @@ int perf_mmap__read_self(struct perf_mmap *map, struct perf_counts_values *count
>                 count->ena += delta;
>                 if (idx)
>                         count->run += delta;
> -
> -               cnt = mul_u64_u64_div64(cnt, count->ena, count->run);
>         }
>
>         count->val = cnt;
>
> Rob, do you have any comments?

Submit a proper patch with the above.

Rob
