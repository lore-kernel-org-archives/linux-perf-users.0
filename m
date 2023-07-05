Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C061EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jul 2023 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjGEVKH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jul 2023 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjGEVKG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jul 2023 17:10:06 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C911700;
        Wed,  5 Jul 2023 14:10:04 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-c01e1c0402cso6788017276.0;
        Wed, 05 Jul 2023 14:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688591404; x=1691183404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWtXhDCoK/I7OHGS5PfaOc/0LhSpupgzLxe4u1hFXTA=;
        b=SIoeopIkFWjI9H9Vvd2khhIsRPMry7pvCGmdE1Ek5o6wj8vBPb0W+MVLRh3nS5kP9N
         pCj1sd38iTDZNmpRRuRTHhI2riwEdTggu7eRLWFKCc3xxQkHjc3Zt3RSQk0+fscd4eRa
         fIIQacZwA4JoAb4mrbAWtq/qJi1jLM92qCU0dsKWKy+LitkqnNYBV967U19p1W48+5qG
         Dyd4fWGtkLIb0Mjuj6lkpHcD3soFxBrcjeVClpsFyve7t8NjgwIQlgsL4bM5V+WnWZOp
         4s5FyX+r74oGajwYRa0IEWsoJ5sjK9ukfnewbCSPnX5rQyZewFsNsRujl7nCsZruvGGK
         5Wkw==
X-Gm-Message-State: ABy/qLYiY1va5BvlzPhJ7EQCKpkpkAYZ2lKxR4YLslvDAFByR3+/FvVH
        laEdudzgE6QZdpGdjAJBDDbkt1xjJX4cO9TDDe0=
X-Google-Smtp-Source: APBJJlFbBnIN+wL7GBA4RpZ1/TVSc0T17YSRvriaD3HHreoNPmsWzJOIbegbX0O7Sdj+QCHkCg4zXtqYPJV1q6eXm4U=
X-Received: by 2002:a25:ac92:0:b0:bc6:8015:1dc8 with SMTP id
 x18-20020a25ac92000000b00bc680151dc8mr63372ybi.33.1688591403802; Wed, 05 Jul
 2023 14:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074217.240939-1-yangjihong1@huawei.com> <20230704074217.240939-4-yangjihong1@huawei.com>
In-Reply-To: <20230704074217.240939-4-yangjihong1@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 5 Jul 2023 14:09:52 -0700
Message-ID: <CAM9d7cjSTqE+rEJiSkAwmg5+XSxrgFFZC3B94fo4rbA9MH9dQg@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf record: Tracking side-band events for all CPUs
 when tracing selected CPUs
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 4, 2023 at 12:44 AM Yang Jihong <yangjihong1@huawei.com> wrote:
>
> User space tasks can migrate between CPUs, we need to track side-band
> events for all CPUs.
>
> The specific scenarios are as follows:
>
>          CPU0                                 CPU1
>   perf record -C 0 start
>                               taskA starts to be created and executed
>                                 -> PERF_RECORD_COMM and PERF_RECORD_MMAP
>                                    events only deliver to CPU1
>                               ......
>                                 |
>                           migrate to CPU0
>                                 |
>   Running on CPU0    <----------/
>   ...
>
>   perf record -C 0 stop

But I'm curious why you don't limit the task to run on the
specified CPUs only (using taskset).

Also, as you may know, you don't need to specify -C if you
want to profile specific tasks only.  It'll open per-cpu, per-task
events and they will have all necessary info.

>
> Now perf samples the PC of taskA. However, perf does not record the
> PERF_RECORD_COMM and PERF_RECORD_COMM events of taskA.

_COMM and _MMAP right?

Thanks,
Namhyung


> Therefore, the comm and symbols of taskA cannot be parsed.
>
> The sys_perf_event_open invoked is as follows:
>
>   # perf --debug verbose=3 record -e cpu-clock -C 1 true
>   <SNIP>
>   Opening: cpu-clock
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>     read_format                      ID|LOST
>     disabled                         1
>     inherit                          1
>     freq                             1
>     sample_id_all                    1
>     exclude_guest                    1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 5
>   Opening: dummy:HG
>   ------------------------------------------------------------
>   perf_event_attr:
>     type                             1
>     size                             136
>     config                           0x9
>     { sample_period, sample_freq }   4000
>     sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>     read_format                      ID|LOST
>     inherit                          1
>     mmap                             1
>     comm                             1
>     freq                             1
>     task                             1
>     sample_id_all                    1
>     mmap2                            1
>     comm_exec                        1
>     ksymbol                          1
>     bpf_event                        1
>   ------------------------------------------------------------
>   sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 6
>   sys_perf_event_open: pid -1  cpu 1  group_fd -1  flags 0x8 = 7
>   sys_perf_event_open: pid -1  cpu 2  group_fd -1  flags 0x8 = 9
>   sys_perf_event_open: pid -1  cpu 3  group_fd -1  flags 0x8 = 10
>   sys_perf_event_open: pid -1  cpu 4  group_fd -1  flags 0x8 = 11
>   sys_perf_event_open: pid -1  cpu 5  group_fd -1  flags 0x8 = 12
>   sys_perf_event_open: pid -1  cpu 6  group_fd -1  flags 0x8 = 13
>   sys_perf_event_open: pid -1  cpu 7  group_fd -1  flags 0x8 = 14
>   <SNIP>
>
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> ---
>  tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 8872cd037f2c..69e0d8c75aab 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -908,6 +908,31 @@ static int record__config_off_cpu(struct record *rec)
>         return off_cpu_prepare(rec->evlist, &rec->opts.target, &rec->opts);
>  }
>
> +static int record__config_tracking_events(struct record *rec)
> +{
> +       struct evsel *evsel;
> +       struct evlist *evlist = rec->evlist;
> +       struct record_opts *opts = &rec->opts;
> +
> +       /*
> +        * User space tasks can migrate between CPUs, so when tracing
> +        * selected CPUs, sideband for all CPUs is still needed.
> +        */
> +       if (opts->target.cpu_list) {
> +               evsel = evlist__findnew_tracking_event(evlist);
> +               if (!evsel)
> +                       return -ENOMEM;
> +
> +               if (!evsel->core.system_wide) {
> +                       evsel->core.system_wide = true;
> +                       evsel__set_sample_bit(evsel, TIME);
> +                       perf_evlist__propagate_maps(&evlist->core, &evsel->core);
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static bool record__kcore_readable(struct machine *machine)
>  {
>         char kcore[PATH_MAX];
> @@ -4235,6 +4260,12 @@ int cmd_record(int argc, const char **argv)
>                 goto out;
>         }
>
> +       err = record__config_tracking_events(rec);
> +       if (err) {
> +               pr_err("record__config_tracking_events failed, error %d\n", err);
> +               goto out;
> +       }
> +
>         err = record__init_thread_masks(rec);
>         if (err) {
>                 pr_err("Failed to initialize parallel data streaming masks\n");
> --
> 2.30.GIT
>
