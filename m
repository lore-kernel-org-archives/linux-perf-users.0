Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D454C4167B
	for <linux-perf-users@archiver.kernel.org>; Sat, 17 Dec 2022 20:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLQTzv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 17 Dec 2022 14:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiLQTzt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 17 Dec 2022 14:55:49 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DAF10F7
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Dec 2022 11:55:45 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id pp21so3887632qvb.5
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Dec 2022 11:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hEYc0QE7ZD1TAxxoapZp+W9lHOSvsVlKejfIzQTWxVE=;
        b=ZPZZfrznc83pjOzvWQt4ilzCrQNAwVEj92xcbWzsjnssjnmIgxbAEz367jD784kfSa
         OpMrkmPrgFZKsiNPD2Hu6r/qDj9CIg6GNPS1wJVcjxHEqNIlPrwf51FA/fdp5uWRwGY0
         QGo3J7TSXFHIUSJgiZx34DqmYlDI3JDBT/ATk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEYc0QE7ZD1TAxxoapZp+W9lHOSvsVlKejfIzQTWxVE=;
        b=kQ+AASn601jcJ94VV22D0afL/PcCPzCYRKMyUB1nzP3wcVEJuXSBjfdKwFNJ/gJl/b
         yAskFrUdYJpWTyt2wynfdtkVHq87EmOszvEkuFbBh16lwUCmt7QnY80cA3oe/v7gcFWq
         bFJVT2QJVhhTnd/sXnsputPB3lkLiDBznW7LhNat59yNWp7lhpU2hTmJC+OoBHQfWbkb
         7CdWA+6awR3s5VVloUPEYuFnIDQLPrWzt3Es9XqwgNTEz7leJhUW2VhNrzgxVRZ7F+0w
         xfLOslIrYw99LXlv8IgfcGgzgp/wRo58ihSzFTPY68ajZSuh1l0UIoZs82FjFMxahfko
         rV1g==
X-Gm-Message-State: ANoB5plsSqUUZWLH8ET88iRbp1o5smpoBtNHNvgWWzpnO1mQQI09miwM
        3z7glGKwyB24CdsfoLW0T9Yfvb7bwC6KAK7e
X-Google-Smtp-Source: AA0mqf6/bxktl8fuU34lSHPswgla/7pzxFVoZvHS5zkiIc46Lwa2bt/fE9SXGA1G6ztx0AdWJcna3w==
X-Received: by 2002:ad4:5103:0:b0:4c7:9386:bb2d with SMTP id g3-20020ad45103000000b004c79386bb2dmr16237314qvp.14.1671306943919;
        Sat, 17 Dec 2022 11:55:43 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id do14-20020a05620a2b0e00b006fcc3858044sm4001198qkb.86.2022.12.17.11.55.42
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 11:55:42 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id c14so3913551qvq.0
        for <linux-perf-users@vger.kernel.org>; Sat, 17 Dec 2022 11:55:42 -0800 (PST)
X-Received: by 2002:a05:6214:390c:b0:4c7:7282:5817 with SMTP id
 nh12-20020a056214390c00b004c772825817mr15407004qvb.94.1671306941737; Sat, 17
 Dec 2022 11:55:41 -0800 (PST)
MIME-Version: 1.0
References: <20221216143609.186415-1-acme@kernel.org> <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
 <Y53XHw3rlsaaUgOs@kernel.org>
In-Reply-To: <Y53XHw3rlsaaUgOs@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Dec 2022 13:55:25 -0600
X-Gmail-Original-Message-ID: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
Message-ID: <CAHk-=wjpO5LBx-mVD8+GBj3u7iNJHXn5y4OreKxsoRGi+4vMCQ@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v6.2: 1st batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kautuk Consul <kconsul@ventanamicro.com>,
        Leo Yan <leo.yan@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nikita Shubin <n.shubin@yadro.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Dec 17, 2022 at 8:50 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> The python3-setuptools package is needed to build the python binding, so
> that one can use things like:

So this fixes the error, but there's some other reason for it.

I have

  Package python3-setuptools-59.6.0-3.fc36.noarch is already installed.

and with that patch the 'perf' build now works for me, but it says:

    Makefile.config:898: Missing python setuptools, the python binding
won't be built, please install python3-setuptools or equivalent

and then (pre-existing)

    Makefile.config:921: Python interpreter too old (older than 3.6)
disabling jevent generation

but I have

    python3-3.10.8-3.fc36.x86_64

Now, for some reason I *also* have python2 installed, but that one is
called "python2".

[ Me trying to figure things out ]

Ok, so if I uninstall my old python2 install, I now get

  Makefile.config:880: No python interpreter was found: disables
Python support - please install python-devel/python-dev
  Makefile.config:915: No python interpreter disabling jevent generation

ok, so I didn't have 'python3-devel' installed. Installing that fixes
some things, but then I get

  Makefile.config:889: No 'Python.h' (for Python 2.x support) was
found: disables Python support - please install
python-devel/python-dev

so apparently perf really wants *both* python2 and python3 installed.
Isn't that a bit excessive?

Anyway, it's clearly something about the install on this laptop, but
the error messages and the "this package is missing" things are
clearly not entirely right.

Whatever. It does build cleanly now for me, and I'll ignore that "No
'Python.h' (for Python 2.x support)" thing.

              Linus
