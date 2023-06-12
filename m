Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A476DC88CB7
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbjFLQii (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjFLQih (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 12:38:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA448E47
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:38:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso5326944e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=QfRYTQECfsBgMvyANysDt2RqPFsfrwgoAKZdmqX3rGzWsJ3gsg3tWM3BfT3YO28z7i
         KO8y/9WDuNXKmWoTxT13cai/Wm7m4y6wPY83rl/OQK6dg+xMq3Nnii/t8HGOZfZRERRT
         1ocjt3a3ZtBIwhfj1NR06ypynKgvg6npBjc6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=CZ2RZD/RGDiblphrw46AbwkqSpRUhx68d9rg6ejG+lFnYIT1ZMJNUn26zSRIVW6Ug5
         KN00nSpXvYi6l0W+usLX/o68anBoRl8xFKMT3WWk91k5U3IV2L0t5t141i9WMLIFkXd2
         PGhYxdxxV1/HfO4FKz7vWBNqUHhI94eYJ2XJiQmWP1urpT7Kqmjj9lGcXQrkoACk9Boz
         NHlwGFb4+X4diU4Cw7BzhUsXT0eYFvNjLaIhHN8s8kj9PXEm8JZpejITnZj65jFK2aKF
         LDwboGnXi1zPG/Y4eZzkt1V4b4/7+VVUbpNWpQT0YTbre7Iq9J1VRCCTF01BXetLsekx
         zA1w==
X-Gm-Message-State: AC+VfDyocU9RXUtNfD7VfJnWCupXJXLaVvXTeLvnf45UUDQfjeIhkaa1
        f982fuFs0v3pfhFwP9XA/wnAXUAJUMPK/Swl4S01BuKh
X-Google-Smtp-Source: ACHHUZ6SWczAruR2lePn3cFKE/xeh1pLQDo0vHISY0XtAoYdAbBgCKfcnX4NUDHOkU/41AbEy1KxhQ==
X-Received: by 2002:a19:501e:0:b0:4ef:eeea:1b85 with SMTP id e30-20020a19501e000000b004efeeea1b85mr4707490lfb.18.1686587914038;
        Mon, 12 Jun 2023 09:38:34 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004f24e797c58sm1466831lfc.217.2023.06.12.09.38.33
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso5326908e87.1
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
X-Received: by 2002:a19:e30c:0:b0:4f6:1779:b1c1 with SMTP id
 a12-20020a19e30c000000b004f61779b1c1mr5015246lfh.48.1686587892415; Mon, 12
 Jun 2023 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org>
In-Reply-To: <20230612090713.652690195@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:37:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Subject: Re: [PATCH v3 00/57] Scope-based Resource Management
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> These are by no means 'complete' convertions, I've mostly focussed on fun=
ctions
> that had 'goto' in them. Since that's a large part of why I started on al=
l this.

So I found what looks like two patches being completely broken because
the conversion was fundamentally misguided.

And honestly, by the end of walking through the patches I was just
scanning so quickly that I might have missed some.

Let's make the rule be that

 - max 10 patches in the series so that I think they were actually
thought about, and people can actually review them

 - only clear "goto out of scope" conversions. When you see a
"continue" or a "goto repeat", you TAKE A BIG STEP BACK.

Because this is all clever, and I am now happy with the syntax, but I
am *not* happy with that 60-patch monster series with what looks like
horrible bugs.

             Linus
