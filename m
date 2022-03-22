Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C32AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Mar 2022 16:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiCVQqh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiCVQqg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Mar 2022 12:46:36 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D546B867
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 09:45:09 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t33so27108967ybt.12
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Mar 2022 09:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEPKdfQLbwPTzKqThQDGwgj7kWss99Dn8po4pyO255s=;
        b=ddWplO2lvUqvqxO14GRhtJiIcIil6ImSCV0lQvOyB6RhwfseAeO/f3MbwjXg0gB2AI
         Y6wK6Z1zurAf8hSxxYyh5aO+O+vxAaoemeucwVmcGyYcyPCo1ko+7oQaiVttX2jLA/Gl
         uABWSRhRigugKLHpvjeYnO1NzwOnJZJmZabgbd9pBfOzTCWhBhUMXEkS8wkosbIx40wn
         7LaVEhfF7lNrRyEifBQcWvpUCYdPxhbyh0kHyJO/LVgH8nw7leDhZUbS8WB52AsELMI5
         P3YeBG8ZJY0h4acRiqBgl5+sR7snJPYaA8UFnAo131KEGnUFAPbVlyKVonkYIZI+09Ie
         Uqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEPKdfQLbwPTzKqThQDGwgj7kWss99Dn8po4pyO255s=;
        b=3sFVmTPpQgC9Ky1quWSW/4diW5tA4ajzA8sKH7datNReGDNcqRuZCgWusnmBOcSt0R
         bwRiEBVecvwsxejlWayn77yKB2296m1QLy9pSC1MjyXNXmm60458/uFaAC+hE1u1dRGb
         mKw8vDvZo5lMp9mSBAqRpIvbDvkqbXwAhNjJ3T2pY/Cb4/x9xHhQc4kNqtkeGA8kXLLe
         VyRa4JcWTGFMbum0hahyBrAjcsAAFxjP/G3f6UgmrplR3AYLLvotVF0rRVrO2FglyPCY
         /jgjY4Vz/WvoMs+3siHsThaza7TZPXuQBeQp4MbjeXpwzY0k2Rr82PRDW1Lso3lNLUuX
         7Ihw==
X-Gm-Message-State: AOAM530/n+qeqCNH9rMxYSDq2XKcO9yE5x8e9+TG4UK9ZfIKJT2YNr++
        6MkL6ycNgjij8cypvR/QYojgjnB7Rl5WYUAkJZmKBQ==
X-Google-Smtp-Source: ABdhPJwNeDSZQOjU+JcF3GBLS/i9yWqJD8C5YRvGxuEpEvBXt9pPTbr55XtMe5XOsWg/E58B8eckCMecpnUUt1ZNU5U=
X-Received: by 2002:a05:6902:203:b0:628:7b6f:2845 with SMTP id
 j3-20020a056902020300b006287b6f2845mr28163313ybs.533.1647967508132; Tue, 22
 Mar 2022 09:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <Yjmn/kVblV3TdoAq@elver.google.com> <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ee2uyr4z.fsf@email.froward.int.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Mar 2022 17:44:31 +0100
Message-ID: <CANpmjNN4UjUTB5x6-2T-+b7MY=oAYn37MKvQy-4jYh6JDeJuKg@mail.gmail.com>
Subject: Re: RFC: Use of user space handler vs. SIG_DFL on forced signals
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 22 Mar 2022 at 15:54, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Marco Elver <elver@google.com> writes:
>
> > Hello,
> >
> > Currently force_sig_info_to_task() will always unblock a blocked signal
> > but deliver the signal to SIG_DFL:
> >
> >       [...]
> >        * Note: If we unblock the signal, we always reset it to SIG_DFL,
> >        * since we do not want to have a signal handler that was blocked
> >        * be invoked when user space had explicitly blocked it.
> >       [...]
> >
> > Is this requirement part of the POSIX spec? Or is the intent simply to
> > attempt to do the least-bad thing?
>
> I have not found any POSIX language about this.
>
> The options are either we terminate the application, or the application
> spins forever re-triggering the trap.

Is this in case of things like SEGV? I think this doesn't quite apply
to us. The cause of the signal (perf event) is rather benign, and the
signal handler can deal with recursion.

[...]
> > For SIGTRAP on perf events we found this makes the situation worse,
> > since the cause of the signal wasn't an error condition, but explicitly
> > requested monitoring. In this case, we do in fact want delivery of the
> > signal to user space even if the signal is blocked, i.e.
> > force_sig_perf() should be an unblockable forced synchronous signal to
> > user space!
>
> Which is exactly what we have.  If you block it you get terminated.

Right, however, in this case we want to monitor/trace memory accesses
etc, and some 3rd party code such as a library being traced isn't
under our control.

What we can do instead is to intercept sigprocmask() and work around
the issue, but libc interception is brittle. :-/
We do just want to receive the signal, all the time.

[...]
> I think HANDLER_UNBLOCK is pretty much nonsense.
>
> A block signal very much means that userspace is not prepared to handle
> the signal.  So calling something that is not ready to be called can't
> work.  That is common sense, and I expect in POSIX as well.

The fundamental question is, if we have a valid signal handler, but
sigprocmask() is called, how do we still keep receiving signals for
SIGTRAP despite sigprocmask()?

Perhaps this is impossible without intercepting sigprocmask() in user
space, in which we'll need to find a different solution.

> I expect that either you are looking for something like what ptrace does
> with signal interruptions where another process is notified, and
> userspace does not need to be involved, or that this is a don't do that
> then.
>
> Or possibly you have some weird asynchronous signal thing happening and
> you are calling it synchronous.

Not quite. We need it to be synchronous, because we need to know the
precise instruction and potentially do some other stuff _before_
subsequent instructions.

A compromise might be to deliver synchronously normally, but when
blocked deliver asynchronously. But if the signal was delivered
asynchronously, we need to let the signal handler know delivery was
asynchronous, so that our tracing logic can recover and give up at
that point.

To do this indication if it was asynchronous, we probably need to
extend siginfo_t once more. Would that be reasonable?

Thanks,
-- Marco
