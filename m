Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7F3FA373F
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJXTai (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiJXT2m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:28:42 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64180303CE
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t4so6998806wmj.5
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rq4LmojLbcxp/5HVAG4AMK3Qx1p6rp18L2XqoY3yjqk=;
        b=QFBkGG/eOnEFT2BxX8o5iEmIfNTM/zapl+rEUcxifKBNrdoBULWd9Weo1GXX9N9ori
         4ni8xwEDXt4s9D8TsLVlH6qLlsd3H8PAvFc9XqiuDMu8B9IBxfCG5BLpPIDlsK6PhgVg
         jkFIkguR3lk87K06Odeb0Gp1NMuAktUQdqQB+ksFtwpnpjgBiPekOMpVuEBYN7eJA0Gs
         ewIxDgFMUmLuuj7wsEpG8u2jYnreuTIJYZtH/502J6aBV4tmPvmCIWLWaw/jh1ip8nZY
         rHG+HQrlLofdsuotnpV94jE+/Z7c8JjfWGhLsI/F/oELeZiSaopNJZMDAyz4D0DwNdn+
         Owag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rq4LmojLbcxp/5HVAG4AMK3Qx1p6rp18L2XqoY3yjqk=;
        b=yPH8mrKx3FdsHXrrQMMUyuIN3jNNrd8JXFKZjcaeZEgYJxfuVsVuFDzO0u9ZpV4LKY
         Gr+gOiil8cEzIJWRnFiwp+9UDFMwCyCPRB4twXGIVbbPVsQDgg6eEeTjAmKHszSV0nY4
         5xBm8qCN37jeV7d66+WWEdyMGcu/2DpVeuAp0oMa73BGrFuNeoO9Djxf0NP84ibKul0Q
         5rN6BFFy1h2FUsVPr1hc5nlzN8VhpIr0n1icg/XeY24Q4mB4BJ7Kp4ZFUlLMJICxz3Oc
         E/MuGbq4mk2+0ltXPEexHHWaE7kU0dYnqiqDwkd1mEq9YFytRjZv4MD/O84GNsMP4SGC
         dS3g==
X-Gm-Message-State: ACrzQf2PA0/9Ppq4H7PA0yUvndogjS9Q9R8WghUCWf2bKq9HJmyh2bMb
        XD4RhsOlm7f52lCUisUT0x+pym5Y8KZrZYX7xF6TiQ==
X-Google-Smtp-Source: AMsMyM6r4Yar8+wf9FBgx3rWmEhKwMDbYX+XOOz3rIMGGFJaiI+SsUfHFdy/D38b1/sUZ3g//DtzUO1kdFt2XDTXsPk=
X-Received: by 2002:a05:600c:19cc:b0:3c6:fbb9:caab with SMTP id
 u12-20020a05600c19cc00b003c6fbb9caabmr24904004wmq.182.1666634356029; Mon, 24
 Oct 2022 10:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com> <Y1bQlxxABicj4k3+@kernel.org>
In-Reply-To: <Y1bQlxxABicj4k3+@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 24 Oct 2022 10:59:03 -0700
Message-ID: <CAP-5=fWPdmHPXc9D2LP6TVmhuNf93gZCnogWXCVGytkhuqi2uQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] Update to C11, fix signal undefined behavior
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 24, 2022 at 10:51 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Oct 24, 2022 at 10:35:15AM -0700, Ian Rogers escreveu:
> > The use of C11 is mainstream in the kernel [1]. There was some
> > confusion on volatile and signal handlers in [2]. Switch to using
> > stdatomic.h (requires C11) and sig_atomic_t as per [3]. Thanks to Leo
> > Yan <leo.yan@linaro.org> for the suggestions.
> >
> > [1] https://lore.kernel.org/lkml/CAHk-=whWbENRz-vLY6vpESDLj6kGUTKO3khGtVfipHqwewh2HQ@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/20221024011024.462518-1-irogers@google.com/
> > [3] https://wiki.sei.cmu.edu/confluence/display/c/SIG31-C.+Do+not+access+shared+objects+in+signal+handlers
>
> I think I'll apply this to perf/core, i.e. for 6.3, ok?

Sounds good to me. 6.3 or 6.2? I suspect there is more cleanup like
this and to the iterators (from C11) that can be done.

Thanks,
Ian

> - Arnaldo
>
> >
> > Ian Rogers (8):
> >   perf build: Update to C standard to gnu11
> >   perf record: Use sig_atomic_t for signal handlers
> >   perf daemon: Use sig_atomic_t to avoid UB
> >   perf ftrace: Use sig_atomic_t to avoid UB
> >   perf session: Change type to avoid UB
> >   perf stat: Use sig_atomic_t to avoid UB
> >   perf top: Use sig_atomic_t to avoid UB
> >   perf trace: Use sig_atomic_t to avoid UB
> >
> >  tools/perf/Makefile.config  | 2 +-
> >  tools/perf/builtin-daemon.c | 3 ++-
> >  tools/perf/builtin-ftrace.c | 4 ++--
> >  tools/perf/builtin-record.c | 9 +++++----
> >  tools/perf/builtin-stat.c   | 9 +++++----
> >  tools/perf/builtin-top.c    | 4 ++--
> >  tools/perf/builtin-trace.c  | 4 ++--
> >  tools/perf/util/session.c   | 3 ++-
> >  8 files changed, 21 insertions(+), 17 deletions(-)
> >
> > --
> > 2.38.0.135.g90850a2211-goog
>
> --
>
> - Arnaldo
