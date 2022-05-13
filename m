Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DDBC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378069AbiEMP7K (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379710AbiEMP7J (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 11:59:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96988635E
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 08:59:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a5so8217015wrp.7
        for <linux-perf-users@vger.kernel.org>; Fri, 13 May 2022 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVIh9eUIIgdyzs1SJoX3TvDbRmqHTPcaYX9J48VmEYo=;
        b=IQmFQSH6zEf3liWAIBbXa3+BpABH8zHRqbq5EmHGss2WP4aha9h4QusTMp8GdmpFmo
         eIjWfO+8HhWBxjUpCbdATyYTUkb4Kbm6bAYLp3jHFYtKynJZE7GU/LsCDDLE7Q1crXsf
         aXZloDGrz50qFWZ9TTC9Gary/NJKVnBoJEhBodfuJwOhxl8qkYGxcsMqYzpz7yG2G0fr
         7nF6rd4JHnXeVBsmgbvEzUE8nchVqjUhDVsnF2Uq7amSUJsXQaZQavJu2HkEtvBW4X16
         k74Mn7uuttFKeE//SDhJ6wolBER8dnxBP/igjqopDnTt9deehsXmLURVEmww8u1rcWyt
         +YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVIh9eUIIgdyzs1SJoX3TvDbRmqHTPcaYX9J48VmEYo=;
        b=Qe7TzCbbIRIUyzN2G4t9eO9ZXOFCQxP6ol7J33Nxf9CDYtcM/1toaz0KyLczkE4SOO
         j5JsX52h9pnDTUhHDThgCu/9F2nT1ijLcAxKJMIO7mEkhwA5AMMrD/ks+mq1dgWLGuyW
         lUpIrKg9/j7//Ca766notFS/2/J2QLu3iK+aRHZoTnZvM7wcc5aiIdC8YQb3PQvcxLa0
         WS9xdR949if9JMfbrny53rPSiMX7+FnpFu1uCUZoE2c6+8Y6Ja3rE13iRuvjc+LYwS1p
         Ldv9hdRdtCEDyDoHeMfcPg+lfQr+z8SgUfbUk1B74763cuByCwSSm3MD+4NssXle6V2P
         0leA==
X-Gm-Message-State: AOAM5331a/R4J+N7MFvf3aotQ+5ig9SyRnXUPFMFgbpCJxihB86YMNJ+
        A8LxaCXdCSPy7psBLAzxGsZihaGshPMCi56RkzLC8w==
X-Google-Smtp-Source: ABdhPJyEW25zPi9jxDioAowiOYE6ELCofv3DxxY7VYIznoDotAjDfPzyQPsLouRy9rYmqtC1q6GQ1NU+V6IAYLOZxOg=
X-Received: by 2002:adf:dd0e:0:b0:20a:c689:f44a with SMTP id
 a14-20020adfdd0e000000b0020ac689f44amr4596502wrm.40.1652457544970; Fri, 13
 May 2022 08:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220511211526.1021908-1-irogers@google.com> <20220511211526.1021908-7-irogers@google.com>
 <d08b3d43-b02a-5aeb-e05e-f2f91d6a8f7a@huawei.com>
In-Reply-To: <d08b3d43-b02a-5aeb-e05e-f2f91d6a8f7a@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 13 May 2022 08:58:52 -0700
Message-ID: <CAP-5=fUAXLL0CXrfrzYV2TT_31kouvJV-FWrZsipR27tT3i+uQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] perf jevents: Switch build to use jevents.py
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 13, 2022 at 8:38 AM John Garry <john.garry@huawei.com> wrote:
>
> On 11/05/2022 22:15, Ian Rogers wrote:
> >    # jevents.py uses os.scandir and type hints present in Python 3.5 released in Sept. 2015.
> > +    JEVENTS_PYTHON_GOOD := $(shell $(PYTHON) -c 'import sys;print("1" if(sys.version_info.major >= 3 and sys.version_info.minor >= 5) else "0")')
>
> I think that many - like me - will have python 2.7, so now will find no
> pmu-events generated any longer after missing this message in the build :(
>
> Maybe many will have python >= 3.5 - but I don't know...

So Python 2 has been end-of-life for over 2 years now:
https://www.python.org/doc/sunset-python-2/
There have been a number of LKML patches upgrading python to version 3.

Python 3.5 has some very nice features of os.scandir and type hints,
so if I set the bar lower than this it hurts the code quality. It is
also at least 6 years old at this point, and so hopefully not
unreasonable for a distribution to have picked it up :-) Looking at
the change to C11 thread:
https://lore.kernel.org/lkml/20220228103142.3301082-1-arnd@kernel.org/
It seems the motivation for picking a language version is the features
it provides and compatibility. If we choose pre-Python 3.5 we get more
compatibility but we lose language features.

My feeling is that we shouldn't need to support things that are no
longer maintained (like Python 2) but I'm less clear if Python 3.5 is
sufficiently compatible for everyone's needs. I kind of hope so, hence
making the patches this way.

>  > + ifneq ($(JEVENTS_PYTHON_GOOD), 1)
>  > + $(warning Python interpreter too old (older than 3.5) disabling
> jevent generation)
>  > + NO_JEVENTS := 1
>
> It is possible to flip NO_JEVENTS to be JEVENTS, i.e. no
> double-negatives, like NO_JEVENTS := 0

Agreed that double negatives are bad. The NO_... pattern is kind of
throughout the make files and build files. I preferred the NO_... for
consistency but if there's a consensus I'm happy to change.

Thanks,
Ian

>  > + endif
>
> Thanks,
> John
