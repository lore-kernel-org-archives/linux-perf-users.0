Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC44C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 20:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjHNU3V (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 16:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHNU3S (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 16:29:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E815110
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 13:29:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40a47e8e38dso12511cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 13:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044956; x=1692649756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPpwjZiRSzqAnt/ZX5lBGUhcJcIqAw9h6/NtoarKW4M=;
        b=Mm1tPHpn+3+4CzhnMyfk7T0RmB5SSGOaFhncft/6Wi/VxFJbPlPfT5F35enMAPyd6M
         43St86qqpTfnzG8umyWEZ7u/usQeg4UjqIraqejOjDtYu7Ot2RnCqPIE8rIhWYoS7cMW
         15biZRuKCm5Dwcpb9cZsKAUHITL72yIDWbDom6fTwTJCSH4PVarlr8JnXj7K/iT5/m4p
         hy3qF/+bBe3BuDZgLLhO93pxn2cNY07VABULPC+mpX5GzcJUbuiXBK9vtxcMk0GnYxVS
         OIvPIB4ikpVb8I/G2S7D9o9SqAGKOAo8MXoeu0B2x4Un2PVIjKY16OS849HK0uixvb8t
         oCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044956; x=1692649756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPpwjZiRSzqAnt/ZX5lBGUhcJcIqAw9h6/NtoarKW4M=;
        b=KEXq3NkYTRFq99qkHVyO/1X2vEhE0kCgAxU6mFEb8oQn1upXIuq4Cl9MceBzatT5v+
         m5YXBLO1gUXERenp03qv0stW2e0+sbXGzqCF6C9Y9FPxjbOS4XD7o4vxwcpyYdKY5xvx
         pXEcnDuGCG7UyaGo5Pj3oiCUMuUozEDTNwBdmMCTi1y2d5u6o0/hkvfySezVtSrOo9uY
         +zQ5mMiqDGmMks7YrqUgk8aDlv+XhnDGpWLBw84j8eKKwsDA1GZnRrw2C9cl5mMnXR+T
         4UdIZHZK+B1+yOzZrMKbzQXY6mVBA1Q/+B2mxmcOkh9WPCSoC0hbWkc+/JVwjj867M3B
         UTQw==
X-Gm-Message-State: AOJu0YxuiXhNuO1w6rXbMzXF1LpnLHKyESNEL9zDzG3e9ebhjJ8ElOQd
        T3jQ+ekMWee1xz9FxwVoBWUY2qA+2Za3DM5U6r4rBg==
X-Google-Smtp-Source: AGHT+IHinf2kRNaRLe2rUF+KCACsWjEotF76UqtzWdFQ2EJOCBb9NMc8LwPrPLWDjGRleO+BPQITJRtW2XfIiPVUnps=
X-Received: by 2002:ac8:580a:0:b0:403:ac17:c18a with SMTP id
 g10-20020ac8580a000000b00403ac17c18amr673114qtg.14.1692044955994; Mon, 14 Aug
 2023 13:29:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230804020741.99806-1-yangjihong1@huawei.com>
 <20230804020741.99806-4-yangjihong1@huawei.com> <b8741176-dc9c-1ddb-6bb5-85293f3c61f7@intel.com>
In-Reply-To: <b8741176-dc9c-1ddb-6bb5-85293f3c61f7@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 13:29:04 -0700
Message-ID: <CAP-5=fV2u+HwxwuCmz0uSo_dvbFAwwjvK_QvkorB+qbtMnwtZg@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] perf record: Move setting dummy tracking before record__init_thread_masks()
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@linux.intel.com,
        james.clark@arm.com, tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 3, 2023 at 11:58=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 4/08/23 05:07, Yang Jihong wrote:
> > When dummy tracking go system wide, the mmap cpu mask is changed.

As previously commented, can we improve the quality of the function
names and commit messages? This sentence is particularly difficult to
understand, I don't understand it.

Thanks,
Ian

> > Therefore, needs to be placed before record__init_thread_masks().
> > Dummy tracking has been set in record__open(), move it before
> > record__init_thread_masks() and add a helper for unified processing.
> >
> > The sys_perf_event_open invoked is as follows:
> >
> >   # perf --debug verbose=3D3 record -e cpu-clock -D 100 true
> >   <SNIP>
> >   Opening: cpu-clock
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1 (PERF_TYPE_SOFTWARE)
> >     size                             136
> >     config                           0 (PERF_COUNT_SW_CPU_CLOCK)
> >     { sample_period, sample_freq }   4000
> >     sample_type                      IP|TID|TIME|PERIOD|IDENTIFIER
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     freq                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 =3D 5
> >   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 =3D 6
> >   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 =3D 7
> >   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 =3D 9
> >   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 =3D 10
> >   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 =3D 11
> >   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 =3D 12
> >   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 =3D 13
> >   Opening: dummy:u
> >   ------------------------------------------------------------
> >   perf_event_attr:
> >     type                             1 (PERF_TYPE_SOFTWARE)
> >     size                             136
> >     config                           0x9 (PERF_COUNT_SW_DUMMY)
> >     { sample_period, sample_freq }   1
> >     sample_type                      IP|TID|TIME|IDENTIFIER
> >     read_format                      ID|LOST
> >     disabled                         1
> >     inherit                          1
> >     exclude_kernel                   1
> >     exclude_hv                       1
> >     mmap                             1
> >     comm                             1
> >     enable_on_exec                   1
> >     task                             1
> >     sample_id_all                    1
> >     exclude_guest                    1
> >     mmap2                            1
> >     comm_exec                        1
> >     ksymbol                          1
> >     bpf_event                        1
> >   ------------------------------------------------------------
> >   sys_perf_event_open: pid 10318  cpu 0  group_fd -1  flags 0x8 =3D 14
> >   sys_perf_event_open: pid 10318  cpu 1  group_fd -1  flags 0x8 =3D 15
> >   sys_perf_event_open: pid 10318  cpu 2  group_fd -1  flags 0x8 =3D 16
> >   sys_perf_event_open: pid 10318  cpu 3  group_fd -1  flags 0x8 =3D 17
> >   sys_perf_event_open: pid 10318  cpu 4  group_fd -1  flags 0x8 =3D 18
> >   sys_perf_event_open: pid 10318  cpu 5  group_fd -1  flags 0x8 =3D 19
> >   sys_perf_event_open: pid 10318  cpu 6  group_fd -1  flags 0x8 =3D 20
> >   sys_perf_event_open: pid 10318  cpu 7  group_fd -1  flags 0x8 =3D 21
> >   <SNIP>
> >
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >  tools/perf/builtin-record.c | 59 +++++++++++++++++++++++--------------
> >  1 file changed, 37 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ca83599cc50c..3ff9d972225e 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -908,6 +908,37 @@ static int record__config_off_cpu(struct record *r=
ec)
> >       return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts=
);
> >  }
> >
> > +static int record__config_tracking_events(struct record *rec)
> > +{
> > +     struct record_opts *opts =3D &rec->opts;
> > +     struct evlist *evlist =3D rec->evlist;
> > +     struct evsel *evsel;
> > +
> > +     /*
> > +      * For initial_delay, system wide or a hybrid system, we need to =
add a
> > +      * dummy event so that we can track PERF_RECORD_MMAP to cover the=
 delay
> > +      * of waiting or event synthesis.
> > +      */
> > +     if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> > +         perf_pmus__num_core_pmus() > 1) {
> > +             evsel =3D evlist__findnew_tracking_event(evlist, false);
> > +             if (!evsel)
> > +                     return -ENOMEM;
> > +
> > +             /*
> > +              * Enable the dummy event when the process is forked for
> > +              * initial_delay, immediately for system wide.
> > +              */
> > +             if (opts->target.initial_delay && !evsel->immediate &&
> > +                 !target__has_cpu(&opts->target))
> > +                     evsel->core.attr.enable_on_exec =3D 1;
> > +             else
> > +                     evsel->immediate =3D 1;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static bool record__kcore_readable(struct machine *machine)
> >  {
> >       char kcore[PATH_MAX];
> > @@ -1288,28 +1319,6 @@ static int record__open(struct record *rec)
> >       struct record_opts *opts =3D &rec->opts;
> >       int rc =3D 0;
> >
> > -     /*
> > -      * For initial_delay, system wide or a hybrid system, we need to =
add a
> > -      * dummy event so that we can track PERF_RECORD_MMAP to cover the=
 delay
> > -      * of waiting or event synthesis.
> > -      */
> > -     if (opts->target.initial_delay || target__has_cpu(&opts->target) =
||
> > -         perf_pmus__num_core_pmus() > 1) {
> > -             pos =3D evlist__findnew_tracking_event(evlist, false);
> > -             if (!pos)
> > -                     return -ENOMEM;
> > -
> > -             /*
> > -              * Enable the dummy event when the process is forked for
> > -              * initial_delay, immediately for system wide.
> > -              */
> > -             if (opts->target.initial_delay && !pos->immediate &&
> > -                 !target__has_cpu(&opts->target))
> > -                     pos->core.attr.enable_on_exec =3D 1;
> > -             else
> > -                     pos->immediate =3D 1;
> > -     }
> > -
> >       evlist__config(evlist, opts, &callchain_param);
> >
> >       evlist__for_each_entry(evlist, pos) {
> > @@ -4235,6 +4244,12 @@ int cmd_record(int argc, const char **argv)
> >               goto out;
> >       }
> >
> > +     err =3D record__config_tracking_events(rec);
> > +     if (err) {
> > +             pr_err("record__config_tracking_events failed, error %d\n=
", err);
> > +             goto out;
> > +     }
> > +
> >       err =3D record__init_thread_masks(rec);
> >       if (err) {
> >               pr_err("Failed to initialize parallel data streaming mask=
s\n");
>
