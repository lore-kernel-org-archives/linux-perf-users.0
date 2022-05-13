Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D72C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 16:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382370AbiEMQcv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 12:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382402AbiEMQct (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 12:32:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647127B16
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 09:32:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k2so12146252wrd.5
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 09:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImbON6V8wU257CZMiPPax7JLE068/EVToU8GSEhgawc=;
        b=O243YbdfW0Jg4H1gGwYCZGx0z3CmKLaaqmC5kZpdtydkh22CmMPPj1txC9sqebmXog
         cin6gCGiXkChH/iixFvUb0MCNs47y3VonDbYdhc19L/LntVohrthJLNcZ0TYAoN57Ckp
         o09thapGF2/jCB66jv+7j9EjLuOdvTPXyqhvdNYpuEQoQIOpAVzXI5jdfIDLyIia7+mf
         KGFzzvxHXd0K8fe9u3C4Wtx+1ldskL/AflYjdoxlOOPV6XFg+IHV+9M+FESsy3HQACha
         +/nR7lhC1a1BcaJO0Ot7JnHtIKzLg38WUO9rf3syo03P2e6aM9DRo3489EJEJmtRYzCf
         affw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImbON6V8wU257CZMiPPax7JLE068/EVToU8GSEhgawc=;
        b=SiXKw5K8nVUxxVXijMfZKcBab6BnUQ57hUUU8SK4Lbl7PgwQx58bVE6U4dxsJP+J/D
         ZPzqxlfrZrdhknMDnCk0StAK9KuKwCq0ndZaC9fWyT3co5wVshMy/g9mpT9N8CvpVq04
         02zR2MyGOlXCv8qm6O5q1YehNPVYxcJO+TNtX4NrrmJh2eMCKYnHE+KbQ5p1BJ2/G2gq
         33Vad7OL3iPMlMJS3k3x9xmVfVvdVqSg/mtogf1OkTM4MgY/wNtw1aTk/3uD2sR4YOql
         Wftffuuv2H082zSVniUTx8rw701JQKL+B37cUTBfSs1cHE5qAXo+GB6RrA5JhWDlwaYm
         J5Aw==
X-Gm-Message-State: AOAM532IMZbbdmHwduRcCckCez4yDhLxMsBWLzVQWe/zhIEFFbOAbUS8
        p3RGnzJP/kxVEpnQN0OocJpBzknVmzx0a7cDG3XTtA==
X-Google-Smtp-Source: ABdhPJzaSBuvg9v5enW5ednG0dsVQhfVdaVjCnZHVnrTU3q3IBGQB458BwmYH6gtv6/MhFwKY5nnfuzEH7IIezYWqZI=
X-Received: by 2002:a05:6000:1f1b:b0:20c:9ea8:b650 with SMTP id
 bv27-20020a0560001f1b00b0020c9ea8b650mr4752087wrb.300.1652459566460; Fri, 13
 May 2022 09:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220513151554.1054452-1-kan.liang@linux.intel.com> <20220513151554.1054452-3-kan.liang@linux.intel.com>
In-Reply-To: <20220513151554.1054452-3-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 09:32:33 -0700
Message-ID: <CAP-5=fVv-f2JpWxOrHUFa73P-6z8JAR-+dcmL8MfYgLhpxe4zA@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf stat: Always keep perf metrics topdown events in
 a group
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

On Fri, May 13, 2022 at 8:16 AM <kan.liang@linux.intel.com> wrote:
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

Nice! This is based on:
https://lore.kernel.org/lkml/20220512061308.1152233-2-irogers@google.com/
You may end up with a group with the leader having a group count of 1
(itself). I explicitly zeroed that in the change above, but this may
be unnecessary. Maybe we should move this code to helper functions for
sharing and consistency on what the leader count should be.

Thanks,
Ian

> Fixes: a9a1790247bd ("perf stat: Ensure group is defined on top of the same cpu mask")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a96f106dc93a..af2248868a4f 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -272,8 +272,11 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>                 }
>
>                 for_each_group_evsel(pos, leader) {
> -                       evsel__set_leader(pos, pos);
> -                       pos->core.nr_members = 0;
> +                       if (!evsel__must_be_in_group(pos) && pos != leader) {
> +                               evsel__set_leader(pos, pos);
> +                               pos->core.nr_members = 0;
> +                               leader->core.nr_members--;
> +                       }
>                 }
>                 evsel->core.leader->nr_members = 0;
>         }
> --
> 2.35.1
>
