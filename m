Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1689AC433E9
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9AC23B6E
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Jan 2021 22:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbhAVWBA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730880AbhAVWAO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Jan 2021 17:00:14 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18201C061793
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2021 13:59:23 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id f17so8219883ljg.12
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2021 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10zR+Da5IgJKyDEut9vatyUY62coO2MZOjRWuHR4NQc=;
        b=K/sIrGKNua7CS+pDc7Rg25lUeBFZxVGGXFVYonO67VjHPv/Fwmv2LfKFRuBm2NLtnt
         VAUJBiLqDkkkfM52N6mhXyEMKvN/4FY+3WM2M00S3QVcQNPRUHfGBueqqYxTckOHyPnO
         Z+lnjbz8naGv67+FX9YkAiYk7H8qBgUgCl7Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10zR+Da5IgJKyDEut9vatyUY62coO2MZOjRWuHR4NQc=;
        b=F9aAbMRvbEbOWb5ko+ThyzbE51QRngyqZXOUdsvKKtn4QLHNBO8Abhos8ZHBgSWCyS
         yQvgaldZ/cRXdUR/bIZ2b2BM7gFC4qIj7coDZQBCaBWRj1u1eKqRx4V2+SeH4l0Kqfnw
         ZFoFtP+wIWKeLea/WMMrQ2TVvBA3N898/4WrCNJpfpIJP22RTkwkUzGJ8ZMR7TQT4urE
         V02Zvtomnq01iIuj3hmnoc05q8yo5ar2jw7znddwgBvHuWzsdCz+78stvZu0zyBg84Ii
         x7j6PdKIURxKudVkIJqJNADeR/BrmuEyHbxdyRFbYZoRHBCFTtEwlXAP67jyji9QwJHl
         GB2w==
X-Gm-Message-State: AOAM5330sigxU5zkivJQT/CjhyWLLbhIkFC2ab3e5cNoNNX5x443HhDD
        ap2LvbZ4ZfZqk8+tsBu5w3K6JxgFwL7nJQ==
X-Google-Smtp-Source: ABdhPJxatCGmKctjydoyngMeAnjAhC+MGHiiUhXqp4EEcz3TsvSkYQ7eXJLfxwMZFu1RsTyRC0T1WA==
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr634703ljh.219.1611352760811;
        Fri, 22 Jan 2021 13:59:20 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id x18sm1020017lfe.36.2021.01.22.13.59.19
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 13:59:19 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id o17so9624951lfg.4
        for <linux-perf-users@vger.kernel.org>; Fri, 22 Jan 2021 13:59:19 -0800 (PST)
X-Received: by 2002:ac2:420a:: with SMTP id y10mr3048221lfh.377.1611352758767;
 Fri, 22 Jan 2021 13:59:18 -0800 (PST)
MIME-Version: 1.0
References: <20210122135156.608434-1-acme@kernel.org>
In-Reply-To: <20210122135156.608434-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jan 2021 13:59:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
Message-ID: <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.11, 2nd batch
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jan 22, 2021 at 5:52 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Test results in the signed tag at:

Side note: I'd actually prefer if you didn't do this. These big things
end up being (a hidden) part of the merge commit (and that's how the
tag verification works after-the-fact: ie I don't just verify the tag
when I pull, you can also do the verification later), and it really
makes zero sense to add 28kB of data to each merge just because you
hid them in the signed tag.

It would actually be better to have it just in the email at the end,
not in the tag.

Please?

              Linus
