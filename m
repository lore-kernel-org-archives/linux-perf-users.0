Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DC6C32793
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 Aug 2022 15:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiHXPFK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 Aug 2022 11:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiHXPFJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Aug 2022 11:05:09 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4FD82767
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:05:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h1so8912690wmd.3
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Aug 2022 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hGnu2y59OBtorqhLwIUK+o18oWZXjlL2FYRhWhdiwO0=;
        b=A6qlhecpQzmKJXTAJ7hZpGEQ0tMojsLooAjp0kAbavqDICMZpjH1pwvI1G8L0tjCWi
         ycOKn2MiSSesS42WM/CAowwbPcvQVWoC98UuZQI5M90uIIcUvi3+w44rEi3XmpI4VAnq
         8nzhyoAINFfyiULvZZsFG+mKujIQxjBQrXR2C0v8VSzUgqAhmHTA4eBN5w6ge2fTdMCD
         hngOOap17HTbtL22wpij4w8HdbNW4lzpLQD+wsR3s02n7ivLZgO8n2gFqr8lNrd/G69M
         kQZPrzjC+uWt/BWrQBe+8q88lVJ8a8imDUDxpnAUSpX2N1B2bgFXxM1EUyHZOVbXS4hW
         LjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hGnu2y59OBtorqhLwIUK+o18oWZXjlL2FYRhWhdiwO0=;
        b=eriV65IMZoBJYcF6yjvUfAI2vLOBObL3lVOMyBmM8VgwcYfZ0bifMuQSjJkpLRE44R
         Bv3ZbO6kyGZjpadQHXv6Go+ZroxuYGAgba2Rs5ikNiEXD+XaXy2aFBSZrSoY6q0H6AEZ
         3QUsWWiUOBEZ+23dCAh3prTJePOOrj3r47dwn9TH+rReGXmzc4yh5bcBt/ZsvWKHunit
         rZ55ggYSgrD20XXzVULXKA9/7ZQ9H0zaUvthAgjSqIQ9+rcKV3XVTuYZZzlqhzumfNQp
         r0E96nLGRIlsKRGyDVz/22Dpcbdrt1lRjLzs61cSbYoLUj+P1dsMJUwk3vRxmG5SJYi2
         F3ew==
X-Gm-Message-State: ACgBeo0atDsSe1tkDuccAJlx0vo2U7YlKAlHTfKrEqsfCT4Ts7WrGF0z
        VnPIW08DqsQT3yOGMr27Zx0XtuvDucpC7V/4yl68gg==
X-Google-Smtp-Source: AA6agR499WDzKJBSZv898v0PqTQOgUe7hv6qsT+KpXp2Cc1g39NpRfCYua8LxewTzPevm6USVRlixpygLB9iau6ycVw=
X-Received: by 2002:a05:600c:25ce:b0:3a5:a3b7:bbfe with SMTP id
 14-20020a05600c25ce00b003a5a3b7bbfemr5784783wml.115.1661353504851; Wed, 24
 Aug 2022 08:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220823220922.256001-1-irogers@google.com> <20220823220922.256001-8-irogers@google.com>
 <02152f40-1dc5-7f1b-ad88-61ecb146a3da@intel.com>
In-Reply-To: <02152f40-1dc5-7f1b-ad88-61ecb146a3da@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 24 Aug 2022 08:04:53 -0700
Message-ID: <CAP-5=fWZaN94M1OS2xRYo6M012mi-cRP_boeBi=p6VPnhbOS7g@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] perf record: Update use of pthread mutex
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Weiguo Li <liwg06@foxmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 24, 2022 at 3:15 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/08/22 01:09, Ian Rogers wrote:
> > Switch to the use of mutex wrappers that provide better error checking
> > for synth_lock.
>
> It would be better to distinguish patches that make drop-in
> replacements from patches like this that change logic.

The only change here is PTHREAD_MUTEX_INITIALIZER to mutex_init
because PTHREAD_MUTEX_INITIALIZER doesn't have error checking. The two
are morally equivalent and so no logic change is intended - although
one may inadvertently happen by the moving initialization from compile
time to runtime.

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 4713f0f3a6cf..02eb85677e99 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -21,6 +21,7 @@
> >  #include "util/evsel.h"
> >  #include "util/debug.h"
> >  #include "util/mmap.h"
> > +#include "util/mutex.h"
> >  #include "util/target.h"
> >  #include "util/session.h"
> >  #include "util/tool.h"
> > @@ -608,17 +609,18 @@ static int process_synthesized_event(struct perf_tool *tool,
> >       return record__write(rec, NULL, event, event->header.size);
> >  }
> >
> > +static struct mutex synth_lock;
> > +
> >  static int process_locked_synthesized_event(struct perf_tool *tool,
> >                                    union perf_event *event,
> >                                    struct perf_sample *sample __maybe_unused,
> >                                    struct machine *machine __maybe_unused)
> >  {
> > -     static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> >       int ret;
> >
> > -     pthread_mutex_lock(&synth_lock);
> > +     mutex_lock(&synth_lock);
> >       ret = process_synthesized_event(tool, event, sample, machine);
> > -     pthread_mutex_unlock(&synth_lock);
> > +     mutex_unlock(&synth_lock);
> >       return ret;
> >  }
> >
> > @@ -1917,6 +1919,7 @@ static int record__synthesize(struct record *rec, bool tail)
> >       }
> >
> >       if (rec->opts.nr_threads_synthesize > 1) {
> > +             mutex_init(&synth_lock, /*pshared=*/false);
>
> It would be better to have mutex_init() and mutex_init_shared()
> since /*pshared=*/true is rarely used.

Will change in v3.

Thanks,
Ian

> >               perf_set_multithreaded();
> >               f = process_locked_synthesized_event;
> >       }
> > @@ -1930,8 +1933,10 @@ static int record__synthesize(struct record *rec, bool tail)
> >                                                   rec->opts.nr_threads_synthesize);
> >       }
> >
> > -     if (rec->opts.nr_threads_synthesize > 1)
> > +     if (rec->opts.nr_threads_synthesize > 1) {
> >               perf_set_singlethreaded();
> > +             mutex_destroy(&synth_lock);
> > +     }
> >
> >  out:
> >       return err;
>
