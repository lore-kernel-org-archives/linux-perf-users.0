Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4C9C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676B261008
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 18:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbhHaSri (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 14:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33587 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239280AbhHaSri (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 14:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630435602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w/RxQVYmK+yNYBTCuOat/QUyeOlO0WxA8hvVfGxmPpM=;
        b=e8Xkqc5MJDUQ9715df7vDrq4IVOnjA5tyVighsXDvJ7FcFwplEZw9ujAFVAuMaDGShUHbT
        2PPZTpvwcL0plYnq8wz4jKJqj0CsSCX/DWqUzMUEriftsqUQjlz0PNmo0QYiQ+LhE3Vf3J
        CrWmsVDMbF/1PaTkHAofRPYEkuYlOc0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-Z-JfGAeZOuWFZ3UX61fSLQ-1; Tue, 31 Aug 2021 14:46:41 -0400
X-MC-Unique: Z-JfGAeZOuWFZ3UX61fSLQ-1
Received: by mail-ej1-f69.google.com with SMTP id yz13-20020a170906dc4d00b005c61ad936f0so175315ejb.12
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Aug 2021 11:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w/RxQVYmK+yNYBTCuOat/QUyeOlO0WxA8hvVfGxmPpM=;
        b=coH/bfbi2Oz1wLO3uPA/MMaUtgXQUg9NzM9lkG6HTbPj7dOfYseLoQkPfv6d5rPciy
         1KIlUGGZhRzo4RLXRmnzo7Dz6Lo/ERIFWGLhvNgaiUpS7FBWcgk7PodhGFa2axkpfCNT
         syfNGRx6C5GpCTqgiAK57y2gJ9SiSWzWa6/VxXPVMy2JeU/I/E5VCyXksgHqOCpDPD8Q
         cpb/p20cHVlabZe/X4ZsOnQcn+DQ/GMoVi+t3MlnglSiqLo3DRrOI5oCTRUM3rYlgJ4U
         l6TtAgem/HgmVpFI++o2M3oMmQQ/SsWhNWE2aE6LIGgPIqWX7MFc6wXrVE0C6zhvDH0k
         XWVw==
X-Gm-Message-State: AOAM530lNUedgnB9PaW+J+PludI4huioxDWQZv35GhOscJzfV6ygyct1
        Cs/aBTZL0kJ5MDO5fmzP/xXm9z0T/mYth7NyvF3kE3iddmIF3/irVzxTELfx1Z3WF5DAQCyLWXT
        ImwR+lJqzgUK2eDqdy8s/ODZpP4ZiBQ==
X-Received: by 2002:a50:fd02:: with SMTP id i2mr27374863eds.22.1630435600256;
        Tue, 31 Aug 2021 11:46:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAnAraI2EzWz6HoM1/oanveLpg3orBWapWG1Qzl7HEp7+G+nSYqOJAVduj6mVRAPtIDnQdrQ==
X-Received: by 2002:a50:fd02:: with SMTP id i2mr27374846eds.22.1630435600051;
        Tue, 31 Aug 2021 11:46:40 -0700 (PDT)
Received: from krava ([2a00:102a:4005:bb4:e4bf:9f13:dbe6:2d14])
        by smtp.gmail.com with ESMTPSA id i6sm8600992ejr.68.2021.08.31.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:46:39 -0700 (PDT)
Date:   Tue, 31 Aug 2021 20:46:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     =?utf-8?B?5Y+25r6E6ZSL?= <dg573847474@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, CAI Yuandao <ycaibb@cse.ust.hk>
Subject: Re: Possible deadlock errors in tools/perf/builtin-sched.c
Message-ID: <YS5uAwp8dGn4CK1V@krava>
References: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rXNLdgvAiT2-B8cWtLNPnWoGo9RWMW=8SPchzRgxJ4BhA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Aug 28, 2021 at 03:57:17PM +0800, 叶澄锋 wrote:
> Dear developers:
> 
> Thank you for your checking.
> 
> It seems there are two deadlock errors on the lock
> *sched->work_done_wait_mutex*and*sched->start_work_mutex.*
> 
> They are triggered due to one thread(A) runs function *run_one_test* locating
> in a loop and unreleasing the two locks in the*wait_for_tasks*function, and
> another thread(B) runs function *thread_func *acquiring the two locks.
> 
> Because the two locks are not properly released in thread A, there will be
> a  deadlock problem if thread B acquires the two locks.

hi,
do you have a way to reproduce this?

thanks,
jirka

> 
> The related codes are below:
> 
> Thread A:
> 
> static void create_tasks(struct perf_sched *sched)
> {
>      ...;
>   err = pthread_mutex_lock(&sched->start_work_mutex);
>     ...;
>  err = pthread_mutex_lock(&sched->work_done_wait_mutex);
>        ...;
> }
> static int perf_sched__replay(struct perf_sched *sched)
> {
>    ...;
> 
>         create_tasks(sched);
>      printf("------------------------------------------------------------\n");
>      for (i = 0; i < sched->replay_repeat; i++)
>           run_one_test(sched);   // multiple reacquisition on the lock
> sched->work_done_wait_mutex and sched->start_work_mutex
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
>        ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
>      ...;
>   pthread_mutex_unlock(&sched->start_work_mutex);
> 
>     ...;
> 
>  ret = pthread_mutex_lock(&sched->start_work_mutex);
>    ....;
> }
> 
> Thread B:
> 
> static void *thread_func(void *ctx)
> {
> 
> ...;
> ret = pthread_mutex_lock(&sched->start_work_mutex);
> ...;
> ret = pthread_mutex_unlock(&sched->start_work_mutex);
> 
> ...;
> 
> ret = pthread_mutex_lock(&sched->work_done_wait_mutex);
> ...;
> ret = pthread_mutex_unlock(&sched->work_done_wait_mutex);
> ..;
> 
> }
> 
> 
> Thanks,

