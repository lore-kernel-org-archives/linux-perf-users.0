Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD511CCA480
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 15:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbiGTPXr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbiGTPXq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A675E30E
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:23:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id a11so4942319wmq.3
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=slmyMPLStcdVZwVLrygegZI1kQWoRXJ3dHO76YDTpRY=;
        b=HIhV3Fd6zMou+mYxHrh3EwfKVqnGb8wEko3bWRabyZeaVFndg3i21gDTZYKU4QH+U+
         ceaCmAfpX1NMgjhfDGx4UySpyEinYNowzRP7cFJRtqspUSkZIR2zjdPU8Gn7M0H6VQWx
         B3ybGupwWxzX5e2wtNdoemR9WFi5dPRa9TeZSbSnHoLoeV/L688W4Kv11U68i6CaqIvn
         uiaRX7PjPvyU0C0H5C5GXfZss8yQw1k3hMQhZ9JXJzEisI+okjAVN2JnoxjGu3G4Es6Y
         +kY3oLBP7KynlFqDXyPzuq/rcV8M/Le1dOaWLGpb3ON+93C8x2JKUBBkSxJmL+fDzeAI
         q/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=slmyMPLStcdVZwVLrygegZI1kQWoRXJ3dHO76YDTpRY=;
        b=J5iCDELHEUE2FWh9Fiz6/PlbGdP7jCXj8dfuw6+t6ZnMNft3DzRvmCAnS5b5u0Lntw
         MHtrbVu2cyp+fN6nhFtK9NaNM8IgE0dQKW8Lt5JsA8az7DSW884vmDtc0XyRTFrAvHdQ
         POYPbHk/+c8f+An4IgvfvpiFbO6lQhcleKcxiCh+2IdHfGjQEUZhSf9/4/6TPbyr0hKo
         otoZLcsJbC+2QPSN1vTeINYc2PE7li9yrcgr+ojbf9yDm4TaHQt77rspXBvwXAKd+TPv
         b2i8d+292AgR175T7mquvrkCrQvL1PN8hRF7hGdeTHUmoJcULFEfJzOASSi5gt6l9pAt
         vb6Q==
X-Gm-Message-State: AJIora8VcdSqWIQBwsKZ0ENN0j3xhK1Ap/sZVFTOrZY3Hp94DwR6zQjn
        z16kIoYEiUM2leuZFIkGKiiFJnh3Z8l2d0CwjF+UMQ==
X-Google-Smtp-Source: AGRyM1vb0saAhlewKLRMkgo4BMvL28iEly+NJOS9mGiKUFwMGQzov9Fw2dnpVoeLMPQGJoQSPfnpkfZDFIn0qF4i0sU=
X-Received: by 2002:a05:600c:20e:b0:3a3:214c:7ffb with SMTP id
 14-20020a05600c020e00b003a3214c7ffbmr494719wmi.1.1658330623182; Wed, 20 Jul
 2022 08:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-4-elver@google.com>
In-Reply-To: <20220704150514.48816-4-elver@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:23:31 -0700
Message-ID: <CAP-5=fWWB7qnxn0WMwqGuiO=CXqfBdvjAWMc52BHSJciz04gCg@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] perf/hw_breakpoint: Clean up headers
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
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 4, 2022 at 8:06 AM Marco Elver <elver@google.com> wrote:
>
> Clean up headers:
>
>  - Remove unused <linux/kallsyms.h>
>
>  - Remove unused <linux/kprobes.h>
>
>  - Remove unused <linux/module.h>
>
>  - Remove unused <linux/smp.h>
>
>  - Add <linux/export.h> for EXPORT_SYMBOL_GPL().
>
>  - Add <linux/mutex.h> for mutex.
>
>  - Sort alphabetically.
>
>  - Move <linux/hw_breakpoint.h> to top to test it compiles on its own.
>
> Signed-off-by: Marco Elver <elver@google.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v2:
> * Move to start of series.
> ---
>  kernel/events/hw_breakpoint.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> index fd5cd1f9e7fc..6076c6346291 100644
> --- a/kernel/events/hw_breakpoint.c
> +++ b/kernel/events/hw_breakpoint.c
> @@ -17,23 +17,22 @@
>   * This file contains the arch-independent routines.
>   */
>
> +#include <linux/hw_breakpoint.h>
> +
> +#include <linux/bug.h>
> +#include <linux/cpu.h>
> +#include <linux/export.h>
> +#include <linux/init.h>
>  #include <linux/irqflags.h>
> -#include <linux/kallsyms.h>
> -#include <linux/notifier.h>
> -#include <linux/kprobes.h>
>  #include <linux/kdebug.h>
>  #include <linux/kernel.h>
> -#include <linux/module.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/notifier.h>
>  #include <linux/percpu.h>
>  #include <linux/sched.h>
> -#include <linux/init.h>
>  #include <linux/slab.h>
> -#include <linux/list.h>
> -#include <linux/cpu.h>
> -#include <linux/smp.h>
> -#include <linux/bug.h>
>
> -#include <linux/hw_breakpoint.h>
>  /*
>   * Constraints data
>   */
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
