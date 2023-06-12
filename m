Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B3AC88CB2
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 17:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbjFLRoY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 13:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236160AbjFLRoT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 13:44:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBEF192
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 10:44:17 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f61d79b0f2so5686340e87.3
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686591856; x=1689183856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFrxTaZ+omQeBxjp+PSzN1QlslHiKSQMtm5xmMsMGf8=;
        b=gzsg1gE+12Xn34z46ONugADYicVTX4jbjp1lFJSI5DtPKn/6k/rFPer/mj045wqlI5
         Pv1+ip9F2rj9LU/6AvmfdGoLN4JzH2gUBcG7O67iIQCeLwhZiEx6e175yx0LvzvMkKxp
         bRulPXkxeLPi6UvSbNP9WiJ7AVqcJ92sa/sN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686591856; x=1689183856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFrxTaZ+omQeBxjp+PSzN1QlslHiKSQMtm5xmMsMGf8=;
        b=BtZ4/SUNFBaC3ULW7kAM3R0L9bInkhfgZyVReT3vmLpZHIMW4xi4wdBbGvAuzLouK6
         aePPeb6jdC/OS2T5Odu+yNmgF7RT5Y9ABuvDzuSYq+7a4JvctjwA2r9HTVF2YeqQ6VPT
         +Aiw/Sfc/7dKIKKfrxdNb5PKUGY/H8TfBaNk6E+GQrw3mydZUYmeIDv37TXb0xwZfVFu
         2oudn44qdJPnwCn9/ZszJDs2MQFa48iq1ORyqTSSfoRWbEG1O6vWsLVULVXBUdQ/sgvk
         wF5WV0VzIUWaP6RrxkKGvA2k3RwJ0CWRSXoyLxLKyejego3H6Dus6fL4bkkLB4t+Sh9S
         SJNA==
X-Gm-Message-State: AC+VfDw1hM0pX/r6NENNM+afUigRFD8n2VOihDZS+caT6Tx+1bu/SVCR
        rF1dCXxHXKWyJZ0xlm2fjukETSouoq7QNNeahEP73r84
X-Google-Smtp-Source: ACHHUZ7NPmAovGBtj9nbpconsRQow8LC9G/iecWODNBnUA6Ur31EYFFs1nqnfR4g/lXkGcBIp1fRgw==
X-Received: by 2002:a19:4316:0:b0:4f3:ab4b:4d99 with SMTP id q22-20020a194316000000b004f3ab4b4d99mr4041599lfa.19.1686591856176;
        Mon, 12 Jun 2023 10:44:16 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id o14-20020a056512050e00b004f517c21ef0sm1509944lfb.82.2023.06.12.10.44.15
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 10:44:16 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5684697e87.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 10:44:15 -0700 (PDT)
X-Received: by 2002:a05:6402:399:b0:516:afe9:f6f9 with SMTP id
 o25-20020a056402039900b00516afe9f6f9mr5415434edv.35.1686591835245; Mon, 12
 Jun 2023 10:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
 <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com> <ZIdR18xG1jy8WdEp@google.com>
In-Reply-To: <ZIdR18xG1jy8WdEp@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 10:43:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGypJwDLvTVbYENicw85n0gbxO7JXjiv9_a+95Br+UTg@mail.gmail.com>
Message-ID: <CAHk-=wjGypJwDLvTVbYENicw85n0gbxO7JXjiv9_a+95Br+UTg@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        masahiroy@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        nicolas@fjasle.eu, catalin.marinas@arm.com, will@kernel.org,
        vkoul@kernel.org, trix@redhat.com, ojeda@kernel.org,
        mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        dennis@kernel.org, tj@kernel.org, cl@linux.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
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

On Mon, Jun 12, 2023 at 10:12=E2=80=AFAM Sean Christopherson <seanjc@google=
.com> wrote:
>
> What if we require that all guarded sections have explicit scoping?  E.g.=
 drop
> the current version of guard() and rename scoped_guard() =3D> guard().  A=
nd then
> figure out macro magic to guard an entire function?

Hmm. I didn't love the excessive scoping, but most of the cases I was
thinking about were for the freeing part, not the locking part.

I agree that explicit scoping might be a good idea for locks as a
rule, but that "entire function" case _is_ a special case, and I don't
see how to do it sanely with a scoping guard.

Unless you accept ugly syntax like

    int fn(..)
    { scoped_guard(rcu)() {
         ...
    }}

which is just a violation of our usual scoping indentation rules.

Of course, at that point, the "scoped" part doesn't actually buy us
anything either, so you'd probably just be better off listing all the
guarding locks, and make it be

    int fn(..)
    { guard(rcu)(); guard(mutex)(&mymutex); {
         ...
    }}

or whatever.

Ugly, ugly.

End result: I think the non-explicitly scoped syntax is pretty much
required for sane use. The scoped version just causes too much
indentation (or forces us to have the above kind of special "we don't
indent this" rules).

> IIUC, function scopes like that will be possible once
> -Wdeclaration-after-statement goes away.

Well, "-Wdeclaration-after-statement" already went away early in
Peter's series, because without that you can't sanely do the normal
"__free()" cleanup thng.

But no, it doesn't help the C syntax case.

If you were to wrap a whole function with a macro, you need to do some
rather ugly things. They are ugly things that we already do: see our
whole "SYSCALL_DEFINEx()" set of macros, so it's not *impossible*, but
it's not possible with normal C syntax (and the normal C
preprocessor).

Of course, one way to do the "whole function scope" is to just do it
in the caller, and not using the cleanup attribute at all.

IOW, we could have things like

   #define WRAP(a,b,c) \
        ({ __typeof__(b) __ret; a; __ret =3D (b); c; __ret; })

and then you can do things like

   #define guard_fn_mutex(mutex, fn) \
        WRAP(mutex_lock(mutex), fn, mutex_unlock(mutex))

or

   #define rcu_read_action(x) WRAP(rcu_read_lock(), x, rcu_read_unlock())

and now you can easily guard the call-site (or any simple expression
that doesn't include any non-local control flow). Nothing new and
fancy required.

But when you don't want to do the wrapping in the caller, you do want
to have a non-scoping guard at the top of the function, I suspect.

                 Linus
