Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EAAC432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Aug 2021 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC1B561058
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Aug 2021 08:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhH1IHg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 28 Aug 2021 04:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhH1IHg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 28 Aug 2021 04:07:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB91CC0613D9;
        Sat, 28 Aug 2021 01:06:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z2so19659901lft.1;
        Sat, 28 Aug 2021 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VV3OwnMmYtHsdtjbnEj4H2sv1uJ0Sm9kswbc7APspic=;
        b=BnG05y8O/9yTk/I6r7fwhcthX4+G0KoNRJ3KxEBC9fZLaL0tW9Ie9BBMzdFLmrf1OC
         /3TBsJgq7IDnDD207Mz9U9qjhSbMvHuQnhSyLgizPnkHXPvEwoKhwQL/xSN41GMPATOh
         nNCXSF2uRLLwD+5/uStLCdsJtzpR7fG9G1EOC7OigDo+ixhS+BuVhc6y3Z2/4h/82S6Z
         47TBxh6KQTrGoFETq8OwY+QiOE9PQF1Dy4Aujg6zS1UkNmBEGv3XQZMYRSTElzXZeVZW
         zsuirGVcWrfT9vTEbM0gfPAfH7H4jTPzhaDbZa9HyMqxK+WN7L6gu7zYu1lnek7ir8Qw
         TTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VV3OwnMmYtHsdtjbnEj4H2sv1uJ0Sm9kswbc7APspic=;
        b=NzwJ27/4a0XfCqPGMEN0EkKyCwKjLkm3RKy498cUhXYzdKwV123rN2d0jiq9cpYnlg
         1Ma351d3+qYhp51/LFGRnNJQdK/CbHvf+Pv3lzILzJfkecTluW21gGOeKzh5p/zecmAp
         WDVkCIOoHK6Xe3HQeGk/q3J1UmAL6v+3znnRQcBaiykVs0vw7SiMZteIgYYZfjZ60Nix
         anM98RBdgF/Jd7h1RyFBTn8eHbO3YrW2EaxyyqfbTXFAJLHIHHySE5GV/JjsVk6/R9KD
         7QEeswmerXRqHo3U4MsFopcywuctard6fuqA9tNWgmrJNy4/QTmBzviqBPr7qJr+lgUg
         r8dw==
X-Gm-Message-State: AOAM532X/6gLL054c5abyChWUXnZl8sI/4KtHT1i9innMf/KQrpEQzeL
        dlhZStqvS9CP2E1bQNG9l559Yl7rTFgGrxeES94=
X-Google-Smtp-Source: ABdhPJxOswsBNBZYDtsf9sm+49xTJAJsXz2fWoi1cjbZBgNXtALBPBNLpi4H4SbLnynCMyD657KfyoEg61zeUVqBI5E=
X-Received: by 2002:a05:6512:3187:: with SMTP id i7mr1022527lfe.104.1630138004056;
 Sat, 28 Aug 2021 01:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
In-Reply-To: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
From:   =?UTF-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Date:   Sat, 28 Aug 2021 16:06:33 +0800
Message-ID: <CAAo+4rVJg--eTqsMPDHtpD2dCnivgWs0xc4eCty3eW05BTJRhw@mail.gmail.com>
Subject: Re: Possible deadlock errors in tools/perf/builtin-sched.c
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        CAI Yuandao <ycaibb@cse.ust.hk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dear developers:

Thank you for your checking.

It seems there are two deadlock errors on the
locksched->work_done_wait_mutexandsched->start_work_mutex.

They are triggered due to one thread(A) runs function run_one_test
locating in a loop and unreleasing the two locks in
thewait_for_tasksfunction, and another thread(B) runs function
thread_func acquiring the two locks.

Because the two locks are not properly released in thread A, there
will be a  deadlock problem if thread B acquires the two locks.

The related codes are below:

Thread A:

static void create_tasks(struct perf_sched *sched)
{
     ...;
    err =3D pthread_mutex_lock(&sched->start_work_mutex);
    ...;
    err =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
    ...;
}

static int perf_sched__replay(struct perf_sched *sched)
{
   ...;
     create_tasks(sched);
     printf("------------------------------------------------------------\n=
");
     for (i =3D 0; i < sched->replay_repeat; i++)
          run_one_test(sched);   // multiple reacquisition on the lock
sched->work_done_wait_mutex and sched->start_work_mutex

   return 0;
}

static void run_one_test(struct perf_sched *sched)
{
        ...;
      wait_for_tasks(sched);
        ...;
}

static void wait_for_tasks(struct perf_sched *sched)
{
      ...;
     pthread_mutex_unlock(&sched->work_done_wait_mutex);
      ...;
     ret =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
     ...;
     pthread_mutex_unlock(&sched->start_work_mutex);
     ...;

    ret =3D pthread_mutex_lock(&sched->start_work_mutex);
    ....;
}

Thread B:
static void *thread_func(void *ctx)
{
...;
ret =3D pthread_mutex_lock(&sched->start_work_mutex);
...;
ret =3D pthread_mutex_unlock(&sched->start_work_mutex);

...;

ret =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
...;
ret =3D pthread_mutex_unlock(&sched->work_done_wait_mutex);
..;

}

PS: The previous email fails to reach the maillist, so I send it again.

Thanks,

=E5=8F=B6=E6=BE=84=E9=94=8B <dg573847474@gmail.com> =E4=BA=8E2021=E5=B9=B48=
=E6=9C=8828=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=883:57=E5=86=99=E9=
=81=93=EF=BC=9A
>
> Dear developers:
>
> Thank you for your checking.
>
> It seems there are two deadlock errors on the locksched->work_done_wait_m=
utexandsched->start_work_mutex.
>
> They are triggered due to one thread(A) runs function run_one_test locati=
ng in a loop and unreleasing the two locks in thewait_for_tasksfunction, an=
d another thread(B) runs function thread_func acquiring the two locks.
>
> Because the two locks are not properly released in thread A, there will b=
e a  deadlock problem if thread B acquires the two locks.
>
> The related codes are below:
>
> Thread A:
>
> static void create_tasks(struct perf_sched *sched)
> {
>      ...;
>   err =3D pthread_mutex_lock(&sched->start_work_mutex);
>     ...;
>  err =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
>        ...;
> }
> static int perf_sched__replay(struct perf_sched *sched)
> {
>    ...;
>
>         create_tasks(sched);
>      printf("------------------------------------------------------------=
\n");
>      for (i =3D 0; i < sched->replay_repeat; i++)
>           run_one_test(sched);   // multiple reacquisition on the lock sc=
hed->work_done_wait_mutex and sched->start_work_mutex
>
>    return 0;
> }
>
> static void run_one_test(struct perf_sched *sched)
> {
>  ...;
>       wait_for_tasks(sched);
>         ...;
> }
> static void wait_for_tasks(struct perf_sched *sched)
> {
>        ...;
>     pthread_mutex_unlock(&sched->work_done_wait_mutex);
>
>   ...;
>        ret =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
>      ...;
>   pthread_mutex_unlock(&sched->start_work_mutex);
>
>     ...;
>
>  ret =3D pthread_mutex_lock(&sched->start_work_mutex);
>    ....;
> }
>
> Thread B:
>
> static void *thread_func(void *ctx)
> {
>
> ...;
> ret =3D pthread_mutex_lock(&sched->start_work_mutex);
> ...;
> ret =3D pthread_mutex_unlock(&sched->start_work_mutex);
>
> ...;
>
> ret =3D pthread_mutex_lock(&sched->work_done_wait_mutex);
> ...;
> ret =3D pthread_mutex_unlock(&sched->work_done_wait_mutex);
> ..;
>
> }
>
>
> Thanks,
