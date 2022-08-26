Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85419ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 16:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiHZQUg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 12:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbiHZQUf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 12:20:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372DDDB07F
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:20:34 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e20so2357683wri.13
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=zzUl8oGEgJMTlOJPy7VJibE5hKJrOS3klLzu+K6mIGI=;
        b=AUXpZ8o3OzsJFe3HFNnQVRYKL+5Z2LIyptjGTfOIPlrPcqx0kUV9ZrF3HDoPmmvjRK
         U4hDGe4LP/tZwofzgFGa3f8D6BE2Nogk8L1rW1OqW3SQQV3K71U2YlnZbOUG1Ji99JKN
         5sZQogZHUiUhbbWAoBQee4Az/ov84ugpEq52Sy2SfEp2b1Mq3J/humyf7lO4IOQtSkhT
         BKRAfYtaW48wuzb8YgNJoL21kqihA+w4YdhQvWVjQ3NWvUVmHSf5zymQhVFz5wvHZnuG
         4qeleKj2qJMIW+W88sGPnSbnkeRtdA98Q0Ne2J8ho3EEHhYe6Bxi5O3Rg4cFPv7HNt6g
         2Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=zzUl8oGEgJMTlOJPy7VJibE5hKJrOS3klLzu+K6mIGI=;
        b=sv/omkMBJvGn1c+kuboAU0lSTBVNnsmY/2UY1RCRsB8Zh2rCPyVk0kGqP0J8YTOSM9
         t06rqdLt46Q8vSaIbzCm0Fz7mwKoPniCT0+omJi/jOPWo/jqrmsrlNSIByHnL31PL1F3
         FWumHkZ6wljxFpM8Eo5A+YRKPl0jeUeCun0/lGflfKGUtnDN/9+n2kqjcPI9kmfhVbmh
         /KR2y+LC4c1dfxx/nX7ApbAY5ncR34cWdZs9C9Hl8dc+yvYbNVCB11Yl8zs3G+5OGN7k
         b18R0mVJ8Y53hE7ShwVgcXY8yVO5DeNZEQ6j9C+LocXVOn7Fws50Q8dXMOTDmoL8SUE0
         0Sew==
X-Gm-Message-State: ACgBeo0/TBCuF42sFXgMy+VKgBgS4XaD9PgtF5gqGUkxvI3W+KcjcOqw
        lKLs/fyxYi7UBprC+UISgM8s777A5T36FUWcOhjxkQ==
X-Google-Smtp-Source: AA6agR4OxdnySTgDZkCtUgd+3IgyOo9ffBzPm5djKnBcX8tHzsP4orSo0vbogLgM8gN8HZo17s2VIyi8qY6Xiyfc7Aw=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr226802wrx.375.1661530832589; Fri, 26 Aug
 2022 09:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220614143353.1559597-1-irogers@google.com> <20220614143353.1559597-5-irogers@google.com>
 <YwjDLl8QXQzaCYaS@tuxmaker.boeblingen.de.ibm.com>
In-Reply-To: <YwjDLl8QXQzaCYaS@tuxmaker.boeblingen.de.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 09:20:20 -0700
Message-ID: <CAP-5=fWTP+_6oLhTYowvpvGrn05784rHkzJgBZcoqZobE1M_Tg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event encoding
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 26, 2022 at 5:57 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> On Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers wrote:
>
> Hi Ian,
>
> Although it is committed, still have a question.
>
> > index e7758707cadd..d2d32589758a 100644
> > --- a/tools/lib/perf/include/perf/event.h
> > +++ b/tools/lib/perf/include/perf/event.h
> > @@ -6,6 +6,7 @@
> >  #include <linux/types.h>
> >  #include <linux/limits.h>
> >  #include <linux/bpf.h>
> > +#include <linux/compiler.h>
>
> Is it correct approach to include it into user-exposed headers?
> AFAICT headers_install.sh strips #include <linux/compiler.h> and
> compiler*.h itself do not get installed with make headers_install.
>
> [...]
>
> > +struct __packed perf_record_cpu_map_data {
>
> And it is only needed to pull __packed macro, right?
>
> Thanks!

Hi Alexander,

I can see your point about compiler.h, it is true that it is just
being used for the __packed definition. Why don't you write your
proposed change as a patch and send it to LKML? libperf is more of an
experimental library than a stable API. We don't currently have any
build tests for things outside of the kernel tree.

Thanks,
Ian
