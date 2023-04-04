Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB2C761A6
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 17:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbjDDRgI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 13:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbjDDRgG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 13:36:06 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B435259
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 10:35:42 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3e0965f70ecso147071cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680629741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcdTIvf1ol3LOKzrQoRhCMtc6+U0OZw7eVy/3P4JBok=;
        b=HpHCjIi2abLI3b7CjtQLNY3/4JDrR8/bMlkvvpuCp3TS/Bd671GsM4/z4LppQsdhHz
         Lb+tsYVM2v7Q9EubDqOK3jLJCRPNbVVKIhUgP/1U9RjGgffd9uud/llg3NTQgQBY4lD6
         1MKPUOaQjieI1pqInfYb3evmz64Hgt19Q9juC03REmYu0dwF7aKoRd/I6rMAhyY2PSN3
         PmQLI/H29tI7I+h90M3X30hdrhVX7fv00DlycG1PT51nN0gfAxeSwL3Ri1v7VZts08JJ
         c4SLSVdHNGy7N/O+p22ixzorAsEhuz95AOa3cqxWDhjo058Aw+ozSIkAvfaFe5RsHuhP
         sgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680629741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcdTIvf1ol3LOKzrQoRhCMtc6+U0OZw7eVy/3P4JBok=;
        b=rnbHozHGzFjxQQhRETfITxS7ct2+otE7KmMNNBzZBVj7/8sufToLwid2JWpWB/oP6Y
         Yf/IEFpvl/0KloURtJNuGXF2XEcNCgjrDSBi0iCU17kvsxMykr3Uw+StkoRg+yHJt9JP
         ZoMV6q6urjSmrxBN6eyKpCG+/PXFuJydyukjv9Eorp1G067c2BA9aI3xJbX8SjWo2LRv
         31bJ7fqb8gd20hELcno41hyNUmZC7TFPiBqNbL5YA+mq0ayZavsjg9BtI2SgTzpuIcqt
         RC216dctiHNXA1tDdeRTjTxtEiSu7xy25KILhnyFKuMtXTQosX8ztCD40bPS3lzWmYlP
         Tz5Q==
X-Gm-Message-State: AAQBX9cha9U+RKRUhXhnuPmpoAknhu6mVBL3ztZyM+4kwsNiJEEqDy1s
        QBvaRwtGd/i4B4dvTYYfTZNYY5iAAoR6K6Q8n/byXg==
X-Google-Smtp-Source: AKy350YCvemBsrW0G/0og46bba+S5pe6mMWOlg/kbyy3/gd2ZKrX0ESS7v+XyJsScmMXcOhYhiZ3/vxbPTyTxcUAn5w=
X-Received: by 2002:a05:622a:1a8e:b0:3d3:3cc:6f70 with SMTP id
 s14-20020a05622a1a8e00b003d303cc6f70mr400595qtc.17.1680629740578; Tue, 04 Apr
 2023 10:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com> <CAP-5=fX4=pUmcFpRZ5xFds1awSr7HSo1F9rH4=D7NJXW9OXXVQ@mail.gmail.com>
 <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
In-Reply-To: <7443d427-783b-44b6-85e6-5e667bb83a94@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 4 Apr 2023 10:35:27 -0700
Message-ID: <CAP-5=fUvCYHLaecCKMnFwMEcbqj=UcfgHSKAtmYEtk+sJT26nQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] Reference count checker and related fixes
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
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Apr 4, 2023 at 10:26=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 4/04/23 18:58, Ian Rogers wrote:
> > Ping. It would be nice to have this landed or at least the first 10
> > patches that refactor the map API and are the bulk of the
> > lines-of-code changed. Having those landed would make it easier to
> > rebase in the future, but I also think the whole series is ready to
> > go.
>
> I was wondering if the handling of dynamic data like struct map makes
> any sense at present.  Perhaps someone can reassure me.
>
> A struct map can be updated when an MMAP event is processed.  So it
> seems like anything racing with event processing is already broken, and
> reference counting / locking cannot help - unless there is also
> copy-on-write (which there isn't at present)?
>
> For struct maps, referencing it while simultaneously processing
> events seems to make even less sense?

Agreed. The point of this work isn't to reimplement the maps/map APIs
but to add a layer of reference count checking. A refactor to change
the implementation without reference counts can delete the reference
count checking and I think that is great! I'm trying to get the code
base, in its current shape, to be more correct guided by sanitizers.
Unfortunately the sanitizers come from a C++ RAII world where
maintaining reference counts is somewhat trivial, we have to work
harder as done here.

A similar thing to refactoring maps is changing symbol. The rb_node
there accounts for 3*8 bytes of pointer, but is just to sort the
symbol by address. A sorted array would suffice as well complexity
wise, freeing 16-bytes per symbol, and is already done for symbols
sorted by name.

Thanks,
Ian
