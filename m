Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5163C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 May 2022 17:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiE2R2r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 May 2022 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiE2R2q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 May 2022 13:28:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC344A3F
        for <linux-perf-users@vger.kernel.org>; Sun, 29 May 2022 10:28:44 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y13so17045256eje.2
        for <linux-perf-users@vger.kernel.org>; Sun, 29 May 2022 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVcAJe5XVONjb8dc+ZXXSeKNhHu55YRYBkoQBm1t6ho=;
        b=fKu1bXFx8iKiBoFGT/CRrwehq4ecxQRl35kagL7wTgZp4/TNJJt30w7ChV4K5RzaKN
         fwEniKrOL1xkwMWf18Qkbjo7wi4P1DYO6QH0UTpXDrSBzpL2/jyMq5ltVo+zS70YoFfk
         8isqt1hzaQ9ByI7itzLo6Jb4W0NvYlf9D8+E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVcAJe5XVONjb8dc+ZXXSeKNhHu55YRYBkoQBm1t6ho=;
        b=4RyxfMUqv/SoTyMgm9GvJAUt+SdcKo3UWxzKhfg3CGQPKQzY7aW8MBLeb8nAtBoA6N
         s6DAlQuxBPlArCylDOzkPkuwDa6gj+t6J/wXsC1n5YbS7mGX90gUgYogZZ5Plzk9yPgJ
         drYI+vIvI7JfXDy2X1xZZoCP08R3jLNwZ2Oe19Whn8G3Gyo9yOKy2spU9ebf6pz/hjmV
         TR/AKjIPqvlvSXJGwvB3h9wn/7beGw4UxmVRXzMNBKiVoW8maxEQNe4Eo/z+9o+5Umj7
         Z+YaGs/hkS0pvEMFnBeNOnHYNQrkI6OAXcBbHx5ypmOmtEJl/b38kdUbFoe+1/VXVtlM
         SiUg==
X-Gm-Message-State: AOAM531a9tmdJ3MmUtuxIGgPE3eauK8zHpb+zjeQN4CPz9NLn9rZGqsH
        yKUUwXg55FznL2yJtXRqaIeJckuKCp3dqI3rMVE=
X-Google-Smtp-Source: ABdhPJxd8SyVpnRyWGvCzgfHyerpTyidXtj7XmzObCsj3XhvvFf2P+svM8gnX8kZqfunTigXQMOt3A==
X-Received: by 2002:a17:907:6ea5:b0:6fa:967d:6d57 with SMTP id sh37-20020a1709076ea500b006fa967d6d57mr46013493ejc.276.1653845323270;
        Sun, 29 May 2022 10:28:43 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id i23-20020a508717000000b0042dc6336684sm1972258edb.73.2022.05.29.10.28.42
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 10:28:43 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h5so3824757wrb.0
        for <linux-perf-users@vger.kernel.org>; Sun, 29 May 2022 10:28:42 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr2361937wrz.281.1653845322509; Sun, 29
 May 2022 10:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220529154535.371758-1-acme@kernel.org>
In-Reply-To: <20220529154535.371758-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 May 2022 10:28:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
Message-ID: <CAHk-=wj1+W6VXeRG7XXO7zSsTe3mACdrPY4PccMNPhC3seLELg@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.19: 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Claire Jensen <cjense@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Eric Lin <eric.lin@sifive.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, May 29, 2022 at 8:45 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> - Add BPF based off-CPU profiling.

I suspect this could have come with a bit more explanation of what
"off-CPU profiling" means.

It seems to be "account time when process was scheduled away to
caller", but I had to go look at the commits to figure that out.

Partly unrelated side note: I've occasionally looked for "useful perf
recipes". Not from kernel developers, but from people who solved real
performance problems using perf, giving useful examples.

                  Linus
