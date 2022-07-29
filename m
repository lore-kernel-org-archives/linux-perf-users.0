Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555C3C00144
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 14:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiG2Ojb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiG2Oja (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 10:39:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316367E000
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 07:39:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l4so6242547wrm.13
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccyQEp70PgUTExpVZ+kylw0PAR4mA5YvPy+or/e3ado=;
        b=pYb7soAL2U25017/5t6iFxmWqARIP39Py1vHsfQp+rQTGn5GwApCdx4/v7N5CBMJqR
         n/wXxr8NQBMg9bhOrilxKSQtHkWSVLX98YEMMLVG8o2Qlh7hauM4BK6s5UAZBxoqzdtO
         wlmBiz26vaLcgZNbyNHO3Aj14ZvK5/Z1kdUQ1R1Rev9j54KJ0afJbD+JOy0ZaYHYjdk1
         rLV+t2dIMwSLm3EAPcp5M/WqqWong7KzXBwXL6cD5qgwfTKz13X4omBmD9qg0OqNcAVD
         YkKomrjx2mcfP4wtuAbADyVUdwRUPsc85tees66PJd4xuG+2qgmcBQNYx8jRAYRblEQ3
         9r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccyQEp70PgUTExpVZ+kylw0PAR4mA5YvPy+or/e3ado=;
        b=obP9oQj2s1KaJUG7DA4WZ0MUfEHbEzxaJmGn3hCwhnjP7erMkMKNJLaxNM5OLFY4GU
         Q2sNB0kO+him1w71Dfjiflc02xWVCk8QUNZbuzS1McvRg0BjT6Rk2Cu/dyLLvu+ACCE3
         eID0+mb+XLDdzHmCluqAYYrXv6sCvK1FMTOJQjOfljxhLofj7WJedR3pgkNQfyzYkuGV
         c+mlzVdSX5cSePpe9lJ/Spuw4PV5uyte/Ch6wH6bP//O5ZfIU3z74Jyk5azLavB/kGvr
         607fY8sYdXGBs6HwHSDbZZYgtmvSf6vK0d45kM7Oi+vXmvNlTl9czPnHhLjHOEW4vgD1
         dPuA==
X-Gm-Message-State: ACgBeo1x9Kb1AUc1HaSNu6uLarePCPExTzt8roJwpl3Qm2sqhzIol8+w
        nq+L/YHOG7ehoqi7sM7OOWv1plP2HtnUeOrqAidgJQ==
X-Google-Smtp-Source: AA6agR6azsiUOCd6hqvIYIcu93cG1wUj06gQB5edVSSZxI53u6BuJLo2aLac7oDdvR39BuhQX82KIEhxTpsQYQa83nc=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr2521559wri.343.1659105566496; Fri, 29
 Jul 2022 07:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220707191209.273065-1-irogers@google.com> <YuPIIgJabRkPLvvn@krava>
In-Reply-To: <YuPIIgJabRkPLvvn@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 07:39:14 -0700
Message-ID: <CAP-5=fUyzrahbkBj5_WN1=pB8E=5YitOn=RvBjZE-zcsnmuLmg@mail.gmail.com>
Subject: Re: [PATCH v2] perf parse-events: Break out tracepoint and printing.
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 29, 2022 at 4:44 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Jul 07, 2022 at 12:12:09PM -0700, Ian Rogers wrote:
> > Move print_*_events functions out of parse-events.c into a new
> > print-events.c. Move tracepoint code into tracepoint.c or
> > trace-event-info.c (sole user). This reduces the dependencies of
>
> it seems like it'd be better to have those changes in separated
> patches, at least for review

Agreed. I'll follow up with a v3.

Thanks,
Ian

> jirka
>
> > parse-events.c and makes it more amenable to being a library in the
> > future.
> > Remove some unnecessary definitions from parse-events.h. Fix a
> > checkpatch.pl warning on using unsigned rather than unsigned int.
> > Fix some line length warnings too.
> >
> > v2. Rebase in particular after hybrid PMU changes.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> SNIP
