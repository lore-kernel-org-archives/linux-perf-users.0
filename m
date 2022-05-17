Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C47C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 03:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbiEQDL3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 23:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiEQDL1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 23:11:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC6917AA6
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 20:11:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j25so21828123wrc.9
        for <linux-perf-users@vger.kernel.org>; Mon, 16 May 2022 20:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMh76iAC9YB/sb6ygJH2Vie34czdyQCqLma1106KOhU=;
        b=fwgypfnjBUPStUq3qUibeKOm3vSgp+Uiz0JSOinYycCjr/N/gEtCip87733ZfgMb0o
         DDilvtrOJbjXE0nTAIeO6BD5+YmyMC6NNysWpV2jQa1jXF80xmoLoZtDcgr+P8X74oRg
         jBLNe5fFxVJ9dhV6RujJ/SW9cxCyMfk9Ubc8p3vNM7TxQwJbVpBK7snTbW3ed//avZNy
         BoCh7Cyii0qkZuCnvxKJELgd9PD2JdQVv8C7+dpopOow8fg2wazvcz1SXpvg3zKv4iPA
         WGY63mtQHcHeWpMGCw1DTQw3uVm/zqS6RQPwU9wORepCf04eW58iRmkNFCthRadPumrN
         gakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMh76iAC9YB/sb6ygJH2Vie34czdyQCqLma1106KOhU=;
        b=fvxKIAterBJVjUoEdUPeD99wML/zQ/LQPM4BCaR5WqzvP/lGANQ3rG0BucrcYzQKzv
         411hDPGxuD1WPzChqMpJbVRyTsoECK+t218NhdoWfzJOUl8gmHJtgWSp00QPW9Dkkufo
         g0LEt+y/OdNerBl24SPoxWlW1APPMZSMZYFdw85ITDcaRhzLqK3moyAZBrArkRTOXmw7
         i2uIrZx63ti4makuAmkK3rTdta1KSSTtgsH/ImsGCPxkN+zU0N4YQIO34QtvI/xZWKYz
         5osDuwkVvryCkalaoYx5B56zHU6B+yWxZfoyhNdCvKV+jJMZhwhsaZIb3kKa0x795Gp8
         xG5A==
X-Gm-Message-State: AOAM531NXgvVAz90eo36Xk1eUAWv7VRfgLfoSejTEc+ap8eOaUSLz7Oa
        ++naoPVG3x7ordwYrIR6T20+jEQYgwYkmeZkW1YoZw==
X-Google-Smtp-Source: ABdhPJwxyB7THXGUrXSj3fPuvTpuwBfaL/Rfsom2JZMVxvWWAQgFvoZnZLqpOAN4YrrGninfpOP1PZ4bhssvppzaMBo=
X-Received: by 2002:a5d:674c:0:b0:20d:87e:8d6f with SMTP id
 l12-20020a5d674c000000b0020d087e8d6fmr6668508wrw.40.1652757084847; Mon, 16
 May 2022 20:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220516152436.1104757-1-kan.liang@linux.intel.com> <20220516152436.1104757-3-kan.liang@linux.intel.com>
In-Reply-To: <20220516152436.1104757-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 16 May 2022 20:11:11 -0700
Message-ID: <CAP-5=fUpUtWAME1wCmEycONzSwEe5m76b4jB14M8+B6Ptks3jQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] perf stat: Always keep perf metrics topdown events
 in a group
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, peterz@infradead.org,
        zhengjun.xing@linux.intel.com, adrian.hunter@intel.com,
        ak@linux.intel.com, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, May 16, 2022 at 8:25 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> If any member in a group has a different cpu mask than the other
> members, the current perf stat disables group. when the perf metrics
> topdown events are part of the group, the below <not supported> error
> will be triggered.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        141,465,174      slots
>    <not supported>      topdown-retiring
>      1,605,330,334      uncore_imc_free_running_0/dclk/
>
> The perf metrics topdown events must always be grouped with a slots
> event as leader.
>
> Factor out evsel__remove_from_group() to only remove the regular events
> from the group.
>
> Remove evsel__must_be_in_group(), since no one use it anymore.
>
> With the patch, the topdown events aren't broken from the group for the
> splitting.
>
> $ perf stat -e "{slots,topdown-retiring,uncore_imc_free_running_0/dclk/}" -a sleep 1
> WARNING: grouped events cpus do not match, disabling group:
>   anon group { slots, topdown-retiring, uncore_imc_free_running_0/dclk/ }
>
>  Performance counter stats for 'system wide':
>
>        346,110,588      slots
>        124,608,256      topdown-retiring
>      1,606,869,976      uncore_imc_free_running_0/dclk/
>
>        1.003877592 seconds time elapsed
>
> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c |  7 +++----
>  tools/perf/util/evlist.c  |  6 +-----
>  tools/perf/util/evsel.c   | 13 +++++++++++--
>  tools/perf/util/evsel.h   |  2 +-
>  4 files changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..75c88c7939b1 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -271,10 +271,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>                         pr_warning("     %s: %s\n", evsel->name, buf);
>                 }
>
> -               for_each_group_evsel(pos, leader) {
> -                       evsel__set_leader(pos, pos);
> -                       pos->core.nr_members = 0;
> -               }
> +               for_each_group_evsel(pos, leader)
> +                       evsel__remove_from_group(pos, leader);
> +
>                 evsel->core.leader->nr_members = 0;

This shouldn't be necessary now.

>         }
>  }
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dfa65a383502..7fc544330fea 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1795,11 +1795,7 @@ struct evsel *evlist__reset_weak_group(struct evlist *evsel_list, struct evsel *
>                          * them. Some events, like Intel topdown, require being
>                          * in a group and so keep these in the group.
>                          */
> -                       if (!evsel__must_be_in_group(c2) && c2 != leader) {
> -                               evsel__set_leader(c2, c2);
> -                               c2->core.nr_members = 0;
> -                               leader->core.nr_members--;
> -                       }
> +                       evsel__remove_from_group(c2, leader);
>
>                         /*
>                          * Set this for all former members of the group
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index b98882cbb286..deb428ee5e50 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3083,7 +3083,16 @@ bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe_unuse
>         return false;
>  }
>
> -bool evsel__must_be_in_group(const struct evsel *evsel)
> +/*
> + * Remove an event from a given group (leader).
> + * Some events, e.g., perf metrics Topdown events,
> + * must always be grouped. Ignore the events.
> + */
> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader)
>  {
> -       return arch_evsel__must_be_in_group(evsel);
> +       if (!arch_evsel__must_be_in_group(evsel) && evsel != leader) {
> +               evsel__set_leader(evsel, evsel);
> +               evsel->core.nr_members = 0;
> +               leader->core.nr_members--;
> +       }

Should we also have:

if (leader->core.nr_members == 1)
     leader->core.nr_members = 0;

Other wise say:

{instructions,cycles}

with a remove of cycles becomes:

{instructions}, cycles

rather than the previous:

instructions,cycles

Actually, looking at:
https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/

+ /* Reset the leader count if all entries were removed. */
+ if (leader->core.nr_members)
+ leader->core.nr_members = 0;

is wrong and should be:

+ /* Reset the leader count if all entries were removed. */
+ if (leader->core.nr_members == 1)
+ leader->core.nr_members = 0;

I'll fix and re-send.

Thanks,
Ian

>  }
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index a36172ed4cf6..47f65f8e7c74 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -483,7 +483,7 @@ bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
>  bool evsel__is_leader(struct evsel *evsel);
>  void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
>  int evsel__source_count(const struct evsel *evsel);
> -bool evsel__must_be_in_group(const struct evsel *evsel);
> +void evsel__remove_from_group(struct evsel *evsel, struct evsel *leader);
>
>  bool arch_evsel__must_be_in_group(const struct evsel *evsel);
>
> --
> 2.35.1
>
