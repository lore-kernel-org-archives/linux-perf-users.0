Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC1C11F68
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 07:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E04613F3
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 07:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGBHXl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 2 Jul 2021 03:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhGBHXk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 2 Jul 2021 03:23:40 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD1EC061762
        for <linux-perf-users@vger.kernel.org>; Fri,  2 Jul 2021 00:21:09 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id h9so10314689oih.4
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Jul 2021 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irzywLWlswN5yWOuh85DPqMNyXrjycgbBXoyqQ4WPFg=;
        b=JC7b7TxAUyZbowqRZZujuFRQ4jMvxzVzW5L18cOjNIWPYWOoRv5VxYWXCyqAACj0I2
         S78j2TDcTg0MVmGQdnUnfdCT/QWofJjHmNSJZDeAFOGNWS+iLKUmlit0N6Wymj3GCK1e
         GhKBkdsdL9uGbxPWrKaWNV9lPPJX5Z/KovNiydJIpFa08zhcUZ6utUFwaoc03DI8A0FS
         5Sek3lMDaaZeViIJujC3baLCO9LrHsZpj5rVWPx7sYuhSQXvgu2rv1hl9tdfhyFFfA4C
         S/+/wogEltIR1Iuveius1Ov2nCc007UXrmTOSiPFEDXAXjvXZL79ngn6KW4E2hIDBY9z
         IaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irzywLWlswN5yWOuh85DPqMNyXrjycgbBXoyqQ4WPFg=;
        b=caFhMtGIJnt8G1Z9wZdPT3D1oUFoKPNHCU9cE/DFGVGFwPGMr/jwEvVaZSwLkUPZP6
         OhhtX54Ye9Z9Qz0oHoleSDOz0C7ft7shgHBHriH8+K1CzA4QnUp067XXJkGkWoZvC59y
         v1ffp2pBHlXI2KMobi6vmv8xxQ7KrclMdEsgsDYGEKDuGFq9CvPQDIo2TQ2p9739/D8L
         MVBX6sxBoPxIjqlt5EJfYu0f7+L0tPx7jkhlqQsdhURjvphFITlR53xaq/XS3nJmkw5B
         l33LPr88Ud8eKT1Hu48SAzUUDdPFrJO/p2v9iyw8qAW7YyehM1vCLp8GQ4kHC5wyubfw
         Lh5g==
X-Gm-Message-State: AOAM5325XJeYEENcIY7cGlHe9BFMx+Jv7EjULEWrw2SOILFaDhukSxnW
        oGnAxJiocsU8PwKTFdPdfa0YxfyZkxVy3CX6lgqaVg==
X-Google-Smtp-Source: ABdhPJzx9YkOfmdJBiDYcvhF1GSrrKeq0URo76Fdf7LELK6PY7vxwExXdGkmvivC7wAMZ8sNCkOZvRut+96K0jF6SJo=
X-Received: by 2002:a05:6808:210e:: with SMTP id r14mr2100654oiw.172.1625210468059;
 Fri, 02 Jul 2021 00:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210701083842.580466-1-elver@google.com> <87h7hdn24k.fsf@disp2133>
In-Reply-To: <87h7hdn24k.fsf@disp2133>
From:   Marco Elver <elver@google.com>
Date:   Fri, 2 Jul 2021 09:20:56 +0200
Message-ID: <CANpmjNMtK53SiZwm0N9VuwGJthY0unZ_1_mZ=gXdMH0_LAFr5A@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Require CAP_KILL if sigtrap is requested
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        omosnace@redhat.com, serge@hallyn.com,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 1 Jul 2021 at 23:41, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Marco Elver <elver@google.com> writes:
>
> > If perf_event_open() is called with another task as target and
> > perf_event_attr::sigtrap is set, and the target task's user does not
> > match the calling user, also require the CAP_KILL capability.
> >
> > Otherwise, with the CAP_PERFMON capability alone it would be possible
> > for a user to send SIGTRAP signals via perf events to another user's
> > tasks. This could potentially result in those tasks being terminated if
> > they cannot handle SIGTRAP signals.
> >
> > Note: The check complements the existing capability check, but is not
> > supposed to supersede the ptrace_may_access() check. At a high level we
> > now have:
> >
> >       capable of CAP_PERFMON and (CAP_KILL if sigtrap)
> >               OR
> >       ptrace_may_access() // also checks for same thread-group and uid
>
> Is there anyway we could have a comment that makes the required
> capability checks clear?
>
> Basically I see an inlined version of kill_ok_by_cred being implemented
> without the comments on why the various pieces make sense.

I'll add more comments. It probably also makes sense to factor the
code here into its own helper.

> Certainly ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS) should not
> be a check to allow writing/changing a task.  It needs to be
> PTRACE_MODE_ATTACH_REALCREDS, like /proc/self/mem uses.

So if attr.sigtrap the checked ptrace mode needs to switch to
PTRACE_MODE_ATTACH_REALCREDS. Otherwise, it is possible to send a
signal if only read-ptrace permissions are granted.

Is my assumption here correct?

> Now in practice I think your patch probably has the proper checks in
> place for sending a signal but it is far from clear.

Thanks,
-- Marco
