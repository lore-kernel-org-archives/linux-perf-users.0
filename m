Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8780ECAAA3
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 17:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240957AbiHZRqV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 13:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHZRqU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 13:46:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D99F9AFA3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 10:46:19 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e13so1717818wrm.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Uh5dFSwK4Zt6YSWyVYmlZi4W8FwEVSfgNxzBjpzWgRU=;
        b=ASsXRXxFXGbufFEF85lod6Fj6XovOs3tY/mYL2fNrOFrUZgxQQoyt0oFzOY+F91wk1
         GI8TIDJN/x2/q2Mim77qosgmD1MAx/eukjBGfiRDMM9OFzEwiOAMBkzp7UujOdrQ1bEm
         WNgeidlm+XQAzuGQ9jj3eQbJCevzgt+Xcob0pGxvdEokcJSegi1kYztOTJV/RwUjwIaG
         sTKYt5F6y/9P74lSxu3KkCeCFc8YHJjL9Bon5Hcnwo8uNM5aZL0YeoRe1SB44AxPQ/08
         9tvtaJXrw4+t0D2X4PU5z5whKre+zxyxztg9r8tH8Qled+Yp+DKkWwrMpgoOATkPHPr6
         2IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Uh5dFSwK4Zt6YSWyVYmlZi4W8FwEVSfgNxzBjpzWgRU=;
        b=yGXs2ib6OFwaHmotrua8tFsrtDW2nLCC1+tCC06hduLQuOu/y5xms5+grnNaKbuEwo
         MJRBfPmxWyE2nLwnXuk6cZpyKmnIHconuD1+mxqfgx5TlNIaZGcPOd9/WtaSoiV9hoNZ
         7uDmQSaTwTB1YVIrUNIbrAa4capHT/9GzDcvAsGmXEBewAXmhvtAB129YCkYYxnn2zKM
         Pl7nnU74aC0Lk67sC5afslEUGW3nlBXcy1+QxlTvF4iB+GBOuon7b6looNEEt7UP28cV
         oeYyxmfPlZ0ja9r2qaUg+8oqnwZ56rcl7pNViIKo/HsKHg7gBQ/s8Kz3OHnR+vxFQZlX
         9ahQ==
X-Gm-Message-State: ACgBeo0LMLV9+UDIW8P3rWz9IQYpqo13mU2A70Nosgsq845LhFw84y9s
        fOMkb/nlKedScWLT07ct5E1+ZYVG+8aEYfqZt8k4vQ==
X-Google-Smtp-Source: AA6agR6UXgkazQ9d8SSn07/lRGYnesHuQWNqOEjB0qqIsN2zrj0kJqBzDCcQs4/3b7t17h2xp4xpiFOoZZyMRKGAjGw=
X-Received: by 2002:a05:6000:1008:b0:225:58e0:223f with SMTP id
 a8-20020a056000100800b0022558e0223fmr419790wrx.375.1661535977496; Fri, 26 Aug
 2022 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-12-irogers@google.com>
 <12acbe02-bd73-07bb-d0e1-cb13dcd790c0@intel.com> <CAP-5=fWCpoqAhLzdMn1zHXfKpsYg0LQPMSz6Uy82+QL_MQpc8g@mail.gmail.com>
 <dc25fa1b-1c29-755a-2fc9-b30ec79eb2ac@intel.com>
In-Reply-To: <dc25fa1b-1c29-755a-2fc9-b30ec79eb2ac@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 10:46:05 -0700
Message-ID: <CAP-5=fVHi9h5mgW3GGkaO4b0aR=CQea3bNSY9ghHJV4KiGC=Nw@mail.gmail.com>
Subject: Re: [PATCH v3 11/18] perf dso: Update use of pthread mutex
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

On Fri, Aug 26, 2022 at 10:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 26/08/22 19:05, Ian Rogers wrote:
> > On Fri, Aug 26, 2022 at 3:37 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 24/08/22 18:38, Ian Rogers wrote:
> >>> Switch to the use of mutex wrappers that provide better error checking.
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/perf/util/dso.c    | 12 ++++++------
> >>
> >> Some not done yet
> >>
> >> $ grep -i pthread_mut tools/perf/util/dso.c
> >> static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         if (pthread_mutex_lock(&dso__data_open_lock) < 0)
> >>                 pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >>         pthread_mutex_lock(&dso__data_open_lock);
> >>         pthread_mutex_unlock(&dso__data_open_lock);
> >
> > Yes, these are all solely dso__data_open_lock that lacks any clear
> > init/exit code to place the initialization/destruction hooks onto. I
> > don't plan to alter these in this patch set.
>
> Perhaps that could be explained in the change log.
>
> But why not just add init / exit code.  Could be called out
> of main(), or maybe use __attribute__((constructor)) /
> __attribute__((destructor))

Because the lock is global and not part of the dso.

Thanks,
Ian
