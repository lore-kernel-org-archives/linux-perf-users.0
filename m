Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E3FC77B73
	for <linux-perf-users@archiver.kernel.org>; Fri, 26 May 2023 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243927AbjEZPSA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 26 May 2023 11:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243804AbjEZPR7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 26 May 2023 11:17:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BACF7
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 08:17:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f606e111d3so53675e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 26 May 2023 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685114276; x=1687706276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waqV0kDOa+ddJeau0hKpduv9QqwA8k7WsskhKW4drm4=;
        b=57LUFJsF5X9QzGbqPgZDHnM5glSnZN/Ke5ANgoMYt/cKrEcKHnoO6AbCKfPrxeWn5l
         Hk9dIzZ12tYYRTpYKpIABvlEiS8y/d2z19eSWO1EocyNWo+MuzYLQY/nsYv4eaY/521n
         2Q4kl4BDLGqHq8AuLhRBNeBp5mmi5xf7aS/Zr48AMvfxyRqkEcqVL2lByrCgDd3S+1Gg
         gT+7SiIaw+kaTg7Ui4Ca/lv6hvXwi6zZm2iSkTDft4RZdJWE2sWsKMnK1wYInTktOEKa
         6AiTPTtNoo2xy27JrBiBcAbIdiwM+lRj6+lDLf+0XZEX+7qgcP9lQLlwiGYlfFG9Cau7
         LgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685114276; x=1687706276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waqV0kDOa+ddJeau0hKpduv9QqwA8k7WsskhKW4drm4=;
        b=VgQbpAPsfhdkPv8bnw8G/EE5AL5iV1L/UpKjaqNoYXj6MY4JGEf1/8eeVTfCggW3eo
         vmVcRRqCrhQjWulzsINg9LnDopKCzgFf8faJxlTK6S6DiNJybkUHZJBzMLh3NSFyu3YU
         U+OMteouRgEqZ5OiVmLOSonL9RFJm/B5jM/sNXGhF5N09nGk971Ga6sggaPMyYAYLKVu
         fQHl8cQdeASJ2lCZCIrwKmflBRYYyGczcnY2Z5njIKBssYtFlrRMEtw2Z7A3dAq79JkH
         7ak/TZfFYQUNK5/bj74MakkBsHfDKTwXF8p6AzaXgDtVymp2m/qHvkuozgv62i04RBjR
         pCXA==
X-Gm-Message-State: AC+VfDwx6u39PWwWC7zXP729X3vJYh5e7S0s8W55KJohplDNy2Oip4hk
        TZXqznfe5oMQ+H9NNujfQnn7r1hIly5+4Z4FXIk1e8O/w434heUvqHg+fg==
X-Google-Smtp-Source: ACHHUZ7S8337fC+4XGtM8No2QG+xwwTWU6s6uDW1VDIzJibso5sIV4Bej6AunSQzqAZzn2WkoPjckDJw0jBhWrfXWGs=
X-Received: by 2002:a05:600c:6016:b0:3f2:4fd2:e961 with SMTP id
 az22-20020a05600c601600b003f24fd2e961mr121822wmb.0.1685114276163; Fri, 26 May
 2023 08:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZG5kjDN63HqqMuJJ@yoga> <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
In-Reply-To: <CAM9d7ciUsJM1kZhGbhQUfdxq1rsvLig2C-mAki13a92EjW37kw@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 26 May 2023 08:17:44 -0700
Message-ID: <CAP-5=fVekEnC1s=xUG-jFeL20qM=EPNkPO8aw8bcg4cVM=m5wg@mail.gmail.com>
Subject: Re: [RFC] Adding Support for Firefox's Gecko Profile Format
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 25, 2023 at 1:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hi Anup,
>
> On Wed, May 24, 2023 at 12:25=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.=
com> wrote:
> >
> > Hello everyone,
> >
> > I'm happy to share that I'll be working on adding support for Firefox's=
 Gecko profile format.
> > This format is utilized by the Firefox profiler, which is a powerful to=
ol for performance analysis
> > and debugging. By enhancing the perf data command to generate perf.data=
 files in the Gecko
> > profile format, it will allow us to leverage the capabilities of the Fi=
refox profiler for visualizing
> > and analyzing the performance data.
> >
> > As a starter task, I have created a test for testing the perf data JSON=
 converter command.
> > I'm also looking for a few more starter tasks related to this project. =
I would greatly appreciate
> > your advice and guidance.
> >
> > In my effort to identify any existing bugs, I have enabled flags like '=
fsanitize=3Daddress' to detect
> > potential issues but have not found any :). Additionally, I am running =
perf data commands to ensure
> > that all use cases are handled properly.
>
> Great, good to know it works well with asan for the basic use cases at le=
ast.
>
> >
> > I have one question regarding the installation process. Typically, I na=
vigate to the perf directory,
> > run 'make', and then cp 'perf' to '/usr/bin'. However, I noticed that b=
y default, perf is installed in
> > the '~/bin/perf' directory. Could someone please clarify why this is th=
e case? Furthermore, I would
> > like to know how all of you compile the perf tree.
>
> I guess $HOME is the default prefix unless you set it to other, then
> make install will put
> the binary there.  You can make sure if your PATH contains the ~/bin and =
use it.
>
> But it's also possible you can run the perf without installing.  I
> have a symlink in
> my tmp directory to point to the recent build of the binary and use it
> always. :)
> To build, you can either 'cd tools/perf; make' or 'make -C tools/perf'
> in the top
> level linux source tree.  I also pass "BUILD_BPF_SKEL=3D1" to enable BPF.
>
> Thanks,
> Namhyung

I quite often test with address sanitizer, I do this by passing to make:
DEBUG=3D1 EXTRA_CFLAGS=3D"-O0 -g -fno-omit-frame- pointer
-fsanitize=3Daddress" NO_LIBTRACEEVENT=3D1

The libtraceevent exclusion is to avoid false address sanitizer
warnings in libtraceevent (it wasn't compiled with address sanitizer).
The other flags are to make the code easier to debug. A good place to
start for a description of the build flags is Makefile.perf:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/Makefile.perf?h=3Dperf-tools-next

There's also some description here:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/Documentation/Build.txt?h=3Dperf-tools-next

Perhaps you can suggest improvements :-)

Thanks,
Ian

> >
> > Thank you for your support and I'm looking forward to collaborating wit=
h you on this project!
