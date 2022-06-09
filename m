Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E2C43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 13:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242294AbiFINF4 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 09:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiFINFz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 09:05:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241C72A274
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 06:05:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c2so18466275lfk.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 06:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xOQI9nYJjsWx7RUNIP4XR5dRmZHTAqrUHXmWvjF6nBY=;
        b=X7FFvILgfoQbhrO16Zdxh9SVLvxEy8XxHsClf1zUJteoAVjCcWwi/RF6y3u4H8+0Za
         DHpnXD3XLZWCkSwQbpXBQuWjcZs+yIeVMe/o8FcP4I4JeO5gvOU627r0k+g9afDZ6ix/
         1OxHn/GxfQ5hBL1SVgRI/msxQdAL2zBCOWjMRgPzbk2JC+M8drt0uevaSbVbi8y1jM2g
         DLcEKYb2VV4E95XAjOqt8+Sed/XY6Ou2af/ft2KCmmolakWr/jMd0CE4Z/9vm4z2B59u
         FW7KmqiYXblPyAIdl+FYoOBANpgcqMqQw7CzXhxATrZLUL0VrGGWg8vcNA+fFnoLlJ9M
         H42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xOQI9nYJjsWx7RUNIP4XR5dRmZHTAqrUHXmWvjF6nBY=;
        b=rc2WiqtGy0JWhegLiV1fyZjPAMWChXatBCUopdA5vxI8nYFSRrG8EN2XVJAG98+/Fr
         oarmiig5/rlBAkZ+9DvHXFl43+6jFq3H/PM93orF/GdcBLe40tFTrKgYpirhxQ6+yYdS
         Dgv5itqgWNx8LydLUP6bUdJ9EQlN903gogxYIPKRReneRkFgjQwgc/Xp9CIy+nF50klE
         t/Cjv/GDQVY7FRqAPN4aShYDmCLgQmxuDxbS7tlj/weEOr2Kd1aKoWzV9DGzim0cMgbL
         FFxJwhzmNwG9LkSRmeacX7nyVGUi5kSIoCOHW2WbZNkc8RgIbxWX+rhj2Udv02ShKcBP
         u7gg==
X-Gm-Message-State: AOAM532d30R5YosPZ/JBA4SOfXHb0zXO6AG+ehVLHIcolagorsZya0IG
        Rt6W60CGiImeOHNpsdxHULVWK28bFx3IPlLrF/XnXIlD5ZFR4A==
X-Google-Smtp-Source: ABdhPJxkLn5hvttF5zsF9zgm1UVZ5x24Zl1UOxfqmTsWE0EAiXcf3Tk1+ZeyugTCS9QDYWM3Dh9NWewl2HiF59iUyg8=
X-Received: by 2002:ac2:4f11:0:b0:479:3554:79d with SMTP id
 k17-20020ac24f11000000b004793554079dmr15389711lfr.417.1654779952199; Thu, 09
 Jun 2022 06:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+ZfjLCj=wvPFhyUQLwxmcOXuK9G_a53SB=-niySExQdew@mail.gmail.com> <YqHtLvdLvdM5Lmdh@elver.google.com>
In-Reply-To: <YqHtLvdLvdM5Lmdh@elver.google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 15:05:40 +0200
Message-ID: <CACT4Y+YWrzpdTnbcvhBb3GfZ-0GmCZuvErFZbh5abNHAV+7WZQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 9 Jun 2022 at 14:53, Marco Elver <elver@google.com> wrote:
>
> On Thu, Jun 09, 2022 at 02:30PM +0200, Dmitry Vyukov wrote:
> [...]
> > > +       rcu_read_lock();
> >
> > Why do we need rcu_read_lock() here?
> > The patch does not change anything with respect to locking, so all
> > accesses to the container should still be protected by nr_bp_mutex.
> > Similarly for the rcu variant of for_each below.
> [...]
> > > +       head = rhltable_lookup(&task_bps_ht, &bp->hw.target, task_bps_ht_params);
> > > +       if (!head)
> > > +               goto out;
> > > +
> > > +       rhl_for_each_entry_rcu(iter, pos, head, hw.bp_list) {
>
> It's part of rhashtable's interface requirements:
>
>         /**
>          * rhltable_lookup - search hash list table
>          * @hlt:        hash table
>          * @key:        the pointer to the key
>          * @params:     hash table parameters
>          *
>          * Computes the hash value for the key and traverses the bucket chain looking
>          * for a entry with an identical key.  All matching entries are returned
>          * in a list.
>          *
>          * This must only be called under the RCU read lock.
>          *
>          * Returns the list of entries that match the given key.
>          */
>
> Beyond that, even though there might not appear to be any concurrent
> rhashtable modifications, it'll be allowed in patch 6/8. Furthermore,
> rhashtable actually does concurrent background compactions since I
> selected 'automatic_shrinking = true' (so we don't leak tons of memory
> after starting and killing those 1000s of tasks) -- there's this
> call_rcu() in lib/rhashtable.c that looks like that's when it's used.
> This work is done in a deferred work by rht_deferred_worker().


I see. Thanks.

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
