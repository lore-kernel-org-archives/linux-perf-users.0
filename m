Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1802C4332F
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Dec 2022 19:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLPTlp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Dec 2022 14:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiLPTlo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Dec 2022 14:41:44 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0468BE18
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Dec 2022 11:41:43 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id cg5so3492659qtb.12
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Dec 2022 11:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l9Luy/wNHt1Hg1pZl82RzrJodI7FyVTRjaZqUGskFzU=;
        b=MSzZWLgJ53XwhZtIq0MTi70LPyjmXvp7FhdpKITVjpS0Vfz4wNGU7XZzECwIubnFFw
         6F67UPDh5GsGAfGSFLtda6gl7J3V5/GBD92Q0ILDjGerrenKTCkpjjD+qvvNZPQnuQas
         S+Z8qwSJ1k8EJgC8m/Gx01Y/e5IvFUwotMVA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9Luy/wNHt1Hg1pZl82RzrJodI7FyVTRjaZqUGskFzU=;
        b=o8UxiMKleSr3b7shJUSD1emAdu2w60rkJSdYFqFZac8kZwiBt634nD+BZZnAwLc3XI
         4Aa9CAeeTZ7nroYAWlmS+eYTsAkP824h38IOfrNXscyLk3zf89ySKJyWdXkK99YwprYP
         wYXhLr44XsS4kGU46YjOrdLnCwSb2f7nKRzge+oUxR2J4b21WvHmersvZBLfNAu7rpCf
         cV5FGvHYfD/kEDXs2Q8azO+Sa8HMpZv8PFAbjL5OxbKl0AunHPXqK4bDI55fVicdbQuL
         JFoDhszGdoetJOSLLO+4q+i82r2sNukyKNSKEVpiWMHd5hX7OKgDjLAiIjOCSMQCVBoX
         bRSw==
X-Gm-Message-State: AFqh2kpLWE0vM3rDM6tlwljhphaZ5ynPsiXTbOAWVaX5ljTO/8e9FlYP
        VKQrtnB9VEu9NBpgxXyUgAXITpg5VsXbpOGi
X-Google-Smtp-Source: AMrXdXt8mXBLK72/WxnaujxvFs8rArWBZKjSYFeX/lkHxuOAZ3+o5dSpLlK7x5mP6HXARdcAz8RV0w==
X-Received: by 2002:a05:622a:4118:b0:3a9:756b:3db9 with SMTP id cc24-20020a05622a411800b003a9756b3db9mr5150818qtb.45.1671219702489;
        Fri, 16 Dec 2022 11:41:42 -0800 (PST)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id p12-20020ac8460c000000b003a7ef7a758dsm1809324qtn.59.2022.12.16.11.41.40
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 11:41:40 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id jr11so3518299qtb.7
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Dec 2022 11:41:40 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8036938qtq.436.1671219699886; Fri, 16
 Dec 2022 11:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20221216143609.186415-1-acme@kernel.org>
In-Reply-To: <20221216143609.186415-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 13:41:24 -0600
X-Gmail-Original-Message-ID: <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
Message-ID: <CAHk-=wj+FNSnspKwVWAatD+DHz3Uy4eHxQryrfoZz6=4D=1X1w@mail.gmail.com>
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

On Fri, Dec 16, 2022 at 8:36 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>         This time there is a trivial resolution of a merge conflict
> related to commit c302378bc157f6a7 ("libbpf: Hashmap interface update to
> allow both long and void* keys/values"), that touched tools/perf/ files.

Normally I'd ask you very sternly to please not resolve merge
conflicts for me, but since I just screwed up another merge due to
being on the road and not having done a full build test, I guess I
will just be quiet this time.

So the real reason for this email is that I get an error like this on
my laptop when trying to build the perf tools:

    INSTALL libbpf_headers
  Traceback (most recent call last):
    File "util/setup.py", line 31, in <module>
      from setuptools import setup, Extension
  ImportError: No module named setuptools
  cp: cannot stat 'python_ext_build/lib/perf*.so': No such file or directory
  make[2]: *** [Makefile.perf:651: python/perf] Error 1
  make[2]: *** Waiting for unfinished jobs....
  make[1]: *** [Makefile.perf:236: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2

and it's not new to this pull - I've seen it before and it's something
stupid I've done.

I think it's a missing package dependency that this laptop then hits.
But considering my previous merge failure, I'm not super-happy about
traveling with a laptop that then can't do this build test.

It would be lovely to have that package dependency - whatever it may
be - tested for explicitly. Hint hint.

           Linus
