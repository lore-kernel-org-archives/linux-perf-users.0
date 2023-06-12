Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8032C7EE2F
	for <linux-perf-users@archiver.kernel.org>; Mon, 12 Jun 2023 16:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbjFLQ0E (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFLQ0D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 12 Jun 2023 12:26:03 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E660E41
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:26:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977c89c47bdso826841566b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587159; x=1689179159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=AxRA6Yxp369A0lwdynqhAvhnCemrwfUQo4lHxkUSaO9vRP0wcKGNWNIQwNV55Op7Ca
         JmL/zx+BHpRcomQuEEwvC6MSQkrhnT1gRZulUwxyLcqNo/iPaRB4+lnwi+ZWpb0pHPZ9
         fYKEO9U31VSTj6BjJc1RWhmE53/4OZK23Kp5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587159; x=1689179159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=dwUw5fIsGhGGlTp4c0BVzGRG/uCTnUzeCVBHFCkyX2dyx6ULvjQG8izeVcbIfFQEKu
         2aLBmZNSQE5+s4TMpF2xElXx7L8bl/hygwYh5tk3uYINg19Zz+44LZKAukrN5uLu9DX4
         3RGMVWZOiK7nI3MFkukbCmg5iqSEKQoRI6HV8ccoReNtcygx3qi/ps6usViApiSXzfdF
         8T3VLTA0srJN8MGnoGAz7g/OhwBEuOhguoAaUxsqQJraNhNLJRXQQRePgLYW6K/OcOC0
         2sEsGMaF5XcyjJQkQkjQ7R5h5iLxwipleDUByaV38MPMwM0uRFuQ3lX76cjTUJYwQ5Rb
         Sl5g==
X-Gm-Message-State: AC+VfDwRfUMYgwH3XTRfiQ2T/5TRmyO0a75dWGKVmhG2zDh8PcHdqfrQ
        kg+K+Dqu4xRXXzw+SnHvbl7sRMRfMf74O1xrk8PLuHqn
X-Google-Smtp-Source: ACHHUZ7bSOm3gq2TZ0EOTtihaZP/SgaJi+/px5M69Jsktdi8+ySmGbKqS38UPxY5a9QsMe1yetHBFA==
X-Received: by 2002:a17:907:705:b0:96f:cde5:5f5e with SMTP id xb5-20020a170907070500b0096fcde55f5emr9540532ejb.29.1686587159604;
        Mon, 12 Jun 2023 09:25:59 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id r23-20020a1709064d1700b009658475919csm5356598eju.188.2023.06.12.09.25.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:25:59 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-977d6aa3758so828021966b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Jun 2023 09:25:59 -0700 (PDT)
X-Received: by 2002:aa7:d14e:0:b0:50b:c3f0:fb9d with SMTP id
 r14-20020aa7d14e000000b0050bc3f0fb9dmr5534541edo.41.1686586776585; Mon, 12
 Jun 2023 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
In-Reply-To: <20230612093541.598260416@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:19:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
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

This patch looks completely broken to me.

You now do

                if (err =3D=3D -EAGAIN)
                        goto restart;

*within* the RCU-guarded section, and the "goto restart" will guard it agai=
n.

So no. Sending out a series of 57 patches that can have these kinds of
bugs in it is not ok. By patch 56 (which just happened to come in
fairly early for me), all sane peoples eyes have glazed over and they
don't react to this kind of breakage any more.

                Linus

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7977,7 +7977,8 @@ static void perf_pmu_output_stop(struct
>         int err, cpu;
>
>  restart:
> -       rcu_read_lock();
> +       /* cannot have a label in front of a decl */;
> +       guard(rcu)();
>         list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {
>                 /*
>                  * For per-CPU events, we need to make sure that neither =
they
> @@ -7993,12 +7994,9 @@ static void perf_pmu_output_stop(struct
>                         continue;
>
>                 err =3D cpu_function_call(cpu, __perf_pmu_output_stop, ev=
ent);
> -               if (err =3D=3D -EAGAIN) {
> -                       rcu_read_unlock();
> +               if (err =3D=3D -EAGAIN)
>                         goto restart;
> -               }
>         }
> -       rcu_read_unlock();
>  }
