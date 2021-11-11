Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049DDC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39CE6124D
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhKKHor (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhKKHor (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 02:44:47 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89393C061767
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 23:41:58 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id gt5so3568921pjb.1
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 23:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+rhcaTkRqGXrksV1KrkQX+/11lKGB4rSNkw6aZ3feU=;
        b=SFc7ApfTJo/1Id/bilYOpJHvAHSAz+s6B9HqcfeVfrUUYRyPpZj3qLLCnjaKTTzNEf
         aAd2HHp1mzE7IF1jFQGe8Jd95Azk6whOGcCJOmO/r0r4iMZIPfueKo4WVfhf54d4CPX+
         tBx0Q/MZ3mdh8hyh6Ii7VHTG8ZGIUa0FFYMLlbGh3wFxQCFeGxIABy8CKYnU64kiMAXu
         3+CjW+VOO72eBF77NBigzUUFlFC0AfzrCYLKA/ewLifK5ZZYFldJK5ZFB/CO7nhCUBzQ
         AkZHHKAH3WscI2iClltVcCb4H3whL1CI9Pn74WxlOTFJS5d9TwHcLm/0jJFzwFEI81JY
         eChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+rhcaTkRqGXrksV1KrkQX+/11lKGB4rSNkw6aZ3feU=;
        b=ie7RSedCAwt735p517byjI6N+cCwQUr6Ed3Udgm06mLW/aBucjSBpOTF00ewhytqja
         K7fQFk7RO8jvM34q/G45HUpEb7eKbDamh8iV5pl0owGNw4xCcAqnR0BAVkhI6Pvu0gmy
         /iOvTNGYiK2PsgG1WfbEoOsU6DYdHrRDES0+jp5T3nzA/9xr99FbYvEL2zV5sh0LfTtP
         VWqWxwU3lDeZUvBn1A1uQQracPAK3rBXRLwfNcM6RDNltJ1tc87sNTlRmmyXY/ehSn0/
         1DLL+ytvn26Lc1bSqs9WZtU2mcawQ3oweKaev4ls0Mxa/rkga6dz4GkZy2WYIWh5kaPp
         j2iQ==
X-Gm-Message-State: AOAM530CIuqN/yiOfp7nzPz56fEilOJff6/4TZX0IM+0IkvuV9Up/QOb
        z1brlJUkD2rePbU12D5x7olRyA==
X-Google-Smtp-Source: ABdhPJzuIlU+W1onfg7eZyNcx6d89upVYkvhKNj1FnFYAvaogiPWidlW0uXk6SFKaA431owxhypBbQ==
X-Received: by 2002:a17:90b:1b4b:: with SMTP id nv11mr24510817pjb.131.1636616517931;
        Wed, 10 Nov 2021 23:41:57 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id u11sm2014209pfk.152.2021.11.10.23.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 23:41:57 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:41:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
Message-ID: <20211111074148.GC102075@leoy-ThinkPad-X240s>
References: <20211109115020.31623-1-german.gomez@arm.com>
 <20211109115020.31623-5-german.gomez@arm.com>
 <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 11:28:48PM -0800, Namhyung Kim wrote:

[...]

> > +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> > +                                   struct auxtrace_queue *queue)
> > +{
> > +       struct arm_spe_queue *speq = queue->priv;
> > +       pid_t tid;
> > +
> > +       tid = machine__get_current_tid(spe->machine, speq->cpu);
> > +       if (tid != -1) {
> > +               speq->tid = tid;
> > +               thread__zput(speq->thread);
> > +       } else
> > +               speq->tid = queue->tid;
> > +
> > +       if ((!speq->thread) && (speq->tid != -1)) {
> > +               speq->thread = machine__find_thread(spe->machine, -1,
> > +                                                   speq->tid);
> > +       }
> > +
> > +       if (speq->thread) {
> > +               speq->pid = speq->thread->pid_;
> > +               if (queue->cpu == -1)
> > +                       speq->cpu = speq->thread->cpu;
> > +       }
> > +}
> > +
> > +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> > +{
> > +       struct arm_spe *spe = speq->spe;
> > +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> 
> I think we should pass -1 as pid as we don't know the real pid.

AFAICT, I observe one case for machine__set_current_tid() returning error
is 'speq->cpu' is -1 (this is the case for per-thread tracing).  In
this case, if pass '-1' for pid/tid, it still will return failure.

So here should return the error as it is.  Am I missing anything?

Thanks,
Leo
