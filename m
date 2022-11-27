Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D462C4332F
	for <linux-perf-users@archiver.kernel.org>; Sun, 27 Nov 2022 03:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiK0DOy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 26 Nov 2022 22:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiK0DOu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 26 Nov 2022 22:14:50 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8BAFCD0
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Nov 2022 19:14:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso8380577wmc.4
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Nov 2022 19:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B7jJJzGDAdvwTHY0/uqqYf6jkjFWmT8EU2xpYpvXkds=;
        b=cePTeChGShsKFQLKo60/NW160lCTvZ5UIrzkfSGokNE7LKlkvAKqCkVlqiSB10KNPE
         8q1EoBmxueU34vR0QFvwtcqicOHoxW0GRYY69d1JNRddcLHtP9oZuM2MWykXPrj076S9
         pm9oXtrQrft7qGK2r1rnDgk/jb89gR7RHXElUier3GlZ0Ga31EGMJVTpLwEKZr0zYGBe
         wDUazPxKe3j1G+BtMnZgHpxQhSYJd0JklCht9o6K3yi8A2xjl5AVBHpCGQi1EBV6MEb+
         br+SgLKyfvmqRCtYdT/jbChq25oqeXmu8pX3S88Ni+J07UAb9iRnPOHuejNro3S2w5W7
         kOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7jJJzGDAdvwTHY0/uqqYf6jkjFWmT8EU2xpYpvXkds=;
        b=WJ9G95RTdiZVr/fVNZ2JwnbRO6mm32Yj2xkbE9avW3CxaO98cZXNh4ldHanLb2VMwX
         tFpFCxtEZ8GBDXHlZqfPXnI62Jqjavq1XcGto3jjLIGl3lCBck5F71JphPxO71PIsIcu
         kvaOZvafUF+Nt0qr5H6Crrt95S69T8nIViQ6Oe9iuDiKrbFKnW4/H2dJ5dLkqJLFJXo6
         nEegxYWot19k048IvJ8yoU6pYb4ttCgGdC6NdDW+KC0t/55cgVzYQx4oRo+j2jlyo61R
         BIAt1P9gFtvjkO7MjrqqhVaBKQ0R+BaWL7DAejodXNydpCnkkKVlT6do16d7VyA9tz4V
         BLBA==
X-Gm-Message-State: ANoB5pl3egedWe67mtkIUWYgJ4c5Kk65dNlSldoog3Mg0geyZNk8j/CD
        eZSn1rUT1XIoX0OiL7+y1YzL5+6zxMJhugYQ/Ktkvg==
X-Google-Smtp-Source: AA0mqf7LMoOeXBa4COl0lx2SMWDgnnyYM5Gy2YzqMQ8ChhQoXhTAJ9MTq7YA84e8LtYvn1kbeaJlNtnNfZtC+SoXNpE=
X-Received: by 2002:a05:600c:540a:b0:3d0:50c4:432c with SMTP id
 he10-20020a05600c540a00b003d050c4432cmr3448681wmb.67.1669518883874; Sat, 26
 Nov 2022 19:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20221123180208.2068936-1-namhyung@kernel.org> <20221123180208.2068936-15-namhyung@kernel.org>
 <CAP-5=fVJjPXk2hmWc6xqDxe06Arq-nOB51CwihAuuVFAoaKJ4g@mail.gmail.com> <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
In-Reply-To: <CAM9d7ciARxBRKpwf-8eQr-x5kR8n0Wv3RmycVFdO4ikeYhDVwg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Sat, 26 Nov 2022 19:14:31 -0800
Message-ID: <CAP-5=fWF7ScB0kHKQsqePHmg3sJf22TOfvKcNeYQdMoD0p8Tbg@mail.gmail.com>
Subject: Re: [PATCH 14/15] perf stat: Rename "aggregate-number" to "cpu-count"
 in JSON
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 24, 2022 at 11:51 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Wed, Nov 23, 2022 at 3:31 PM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 23, 2022 at 10:02 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > As the JSON output has been broken for a little while, I guess there are
> > > not many users.  Let's rename the field to more intuitive one. :)
> >
> > I'm not sure cpu-count is accurate. For example, an uncore counter in
> > a dual socket machine may have a CPU mask of "0, 36", ie one event per
> > socket. The aggregate-number in this case I believe is 2.
>
> You're right.  In case of uncore events, it can be confusing.  But in some
> sense it could be thought as cpu count as well since it aggregates the
> result from two cpus anyway. :)
>
> Note that the aggregate-number (or cpu-count) is only printed if users
> requested one of aggregation options like --per-socket or --per-core.
> In your example, then it could print 1 for each socket.
>
> But I think uncore events are different from core events, and hopefully
> they have separate instances for different sockets or something already.
> That means it doesn't need to use those aggregation options for them.
>
> Also the CSV output uses "cpus" for the same information.  It'd be nice
> we could have consistency.

So in the original patch from Claire she'd passed the name "number"
through to the json from the stat code. Having an integer called
"number" isn't exactly intention revealing - thank you for your clean
up work! :-) I switched "number" to be "aggregate number" as the
number comes from the "data" aggregated and the code refers to it as
aggregate data. I think aggregate-number is more consistent with the
code, and cpu-count would look strange in the uncore case above where
the number of CPUs (really hyperthreads) is 72. Perhaps we should also
be outputting the aggregation mode with the number. Anyway, I think
for the patch series I'd prefer we skipped this one and kept the rest.

Thanks,
Ian
> Namhyung
