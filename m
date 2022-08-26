Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82492ECAAD6
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 Aug 2022 20:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiHZUw3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 Aug 2022 16:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344328AbiHZUw0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 Aug 2022 16:52:26 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF30DD4EA
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 13:52:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so387531wrm.8
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Aug 2022 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/FKV8NfeABOB5rtbgWYmbTPwp8Mt3Wy5s1mzFHehzCI=;
        b=iGdU9mei9DSZLuS7uHMIilQd2lkoyJdSwxMI0mReZhtN5gkUjZ/wrXKT6lcyVWfI9/
         tSFEDjKo7eNzCSM30CeVaMzrZNaxDUnrPRphbe/K9PkwnBBazL4zX7PI3/+oGgwh5Q7L
         3AKr1t8J/rXzDnfuOfT7+4CTJJ1LAPtw04XEl6tR5l3+D4KBpg52ot7ATUaTg8NZUb3k
         or4JQYq+nMk1Gs+Q2/BmuTpabwasj/n4rO+JuYwI5336KrkHtYygVkgHP5DTbK8WQ4/N
         d1tPQHY3ycYE50AtVpwKar6L2Df6EgDYGz2wDtXA7euueSCPx5CC1D0PpALlrwPPqOhh
         ysmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/FKV8NfeABOB5rtbgWYmbTPwp8Mt3Wy5s1mzFHehzCI=;
        b=jvJbHMVjh3WRmKS7eZm99TVckVObERmzJu2lVGlHaWXfTTE5bCuGpSIUimBVgd6xOR
         KNtaXSRwPAIN7bbu2HQRv8aVn/pLCfC/XHG/vcteepywHEfCEqi/iRiPc61olNspf5x7
         D/LUfIwz0rdlRn3tfImVeMhRKSyfyIsp7/tcMA3ahRTZ9tjBB3K0h5F3InK12haCHt8H
         UlN1K+1waeDKT3b3t0ZYnkkSHmjCojlm+9M6653EfdXIkyVAC8DNP8do7xQDEQ6NczzK
         q6dZFNXPWHy+RVO3qR1l5HhklqNFL+9RkigTtaJ6OPAE2h0rBNtFKdvx6x4nfKVkVvQv
         5U3w==
X-Gm-Message-State: ACgBeo12wtivK54OnzyoKpmA/pcBVOvHkTf3o3ydRmzOjVGDpfs59mMV
        9+EarAGotyKFJBcb0n/0IuEfDrQ15phX+Qdc1PmWdA==
X-Google-Smtp-Source: AA6agR6ZX12RvsXCpQ9Cff+4vP0t6K9e1t4KciZ/ugNMY7xpQnsmru7piccWOa5mOvIGJPe4W+8t0gQU5sT8viOyTYU=
X-Received: by 2002:a05:6000:1ac9:b0:220:7f40:49e3 with SMTP id
 i9-20020a0560001ac900b002207f4049e3mr738777wry.40.1661547139826; Fri, 26 Aug
 2022 13:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220824153901.488576-1-irogers@google.com> <20220824153901.488576-10-irogers@google.com>
 <2cf6edac-6e41-b43c-2bc1-f49cb739201a@intel.com> <CAP-5=fVVWx=LZAzXsxfuktPHwki1gYbV4mcmvJp_9GTDS6KJcQ@mail.gmail.com>
 <a9b4f79d-cdea-821e-0e57-cd4854de6cf4@intel.com> <CAP-5=fW7t9tcJpyUbv8JAo-BFna-KS6FC+HkbuGx6S=h+nBMqw@mail.gmail.com>
 <43540a3d-e64e-ec08-e12e-aebb236a2efe@intel.com> <CAM9d7chBnZtrKe6b8k+VYk1Nmz8YnNWSMmyLydH6+Otvw4xGeA@mail.gmail.com>
 <b0f86189-be17-d1e7-d23c-692eeee2b5ec@intel.com> <CAM9d7ciroc1XzRL+W34D5G7kCp4KCzRxjyRqnO2OXj=-ZaMTLQ@mail.gmail.com>
In-Reply-To: <CAM9d7ciroc1XzRL+W34D5G7kCp4KCzRxjyRqnO2OXj=-ZaMTLQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 Aug 2022 13:52:07 -0700
Message-ID: <CAP-5=fWvf66snfmUfaTQ6BZ9EmsmBs0PUT8PAfehW74bnEE5nQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/18] perf ui: Update use of pthread mutex
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 26, 2022 at 1:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Aug 26, 2022 at 12:21 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 26/08/22 22:00, Namhyung Kim wrote:
> > > On Fri, Aug 26, 2022 at 11:53 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > >> Below seems adequate for now, at least logically, but maybe it
> > >> would confuse clang thread-safety analysis?
> > >
> > > I think it's not just about locks, the exit_browser should bail out early
> > > if the setup code was not called.
> >
> > In those cases, use_browser is 0 or -1 unless someone has inserted
> > an invalid perf config like "tui.script=on" or "gtk.script=on".
> > So currently, in cases where exit_browser() is called without
> > setup_browser(), it does nothing.  Which means it is only the
> > unconditional mutex_destroy() that needs to be conditional.
>
> Yeah there's a possibility that it can be called with > 0 use_browser
> on some broken config or something.  So I think it's safer and better
> for future changes.

I'd thought about a:
static bool ui__lock_initialized;
but the issue is shouldn't it be atomic? Maybe we should guard it with
a lock? Then we are back where we started. Having a clean init/exit
invariant would be best but such a change has the potential to be
large and out of scope here.

Thanks,
Ian

> Thanks,
> Namhyung
