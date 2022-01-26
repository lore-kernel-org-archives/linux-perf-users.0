Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A8BC28CF5
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Jan 2022 12:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbiAZMLQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Jan 2022 07:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241091AbiAZMLQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Jan 2022 07:11:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B96AC06161C
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Jan 2022 04:11:16 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:11:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643199074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYlJiJ25c/QA7xQmiE5SIKynCcctd3exB3VeR+bHWkE=;
        b=YmirkN8N19TOAQdLbf1Kn8RrtjfFOTdLStzfARQh2mCLfnsNkq1sjbcmO7nKqGD66mrH5e
        kK3f3qPVmL8WVE6w34yNL+q/lY1H/oAoYuOvn/fYQX/FyIeJRnq4ZOGoiQ3JvUljyGgZoi
        e7e3G1M48dCjEbflUSlmyvHg7mxsfM9YqTrNY2i5k6LHivaR3P3CdQi6oKGjQiDaDpl9jj
        vycMebY+4E4vPQomzw997eiDxIWwryB0TSuOA3sOz3Nd/Yt5w9rskLZZfRkMvNZYVj++VU
        6OBqA2zfjH1FyssOqYnogAMAfwXgniMDYuDmTdup2OR3P22zs+Vq+UTejiwRnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643199074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NYlJiJ25c/QA7xQmiE5SIKynCcctd3exB3VeR+bHWkE=;
        b=6jYrdC0ZHOlCQVeGTiucSuUmMRZ5TGLxUqTXZ+QPBfE7OapeOu05mcoWOewwx+7X+/vA9s
        YfRr9LzvAfZBkqCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [bug report] irq_work: Allow irq_work_sync() to sleep if
 irq_work() no IRQ support.
Message-ID: <YfE6YV7V2s89A55f@linutronix.de>
References: <20220119133729.GA14183@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119133729.GA14183@kili>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

+peterz, tglx

On 2022-01-19 16:37:29 [+0300], Dan Carpenter wrote:
> Hello Sebastian Andrzej Siewior,
> 
> The patch 810979682ccc: "irq_work: Allow irq_work_sync() to sleep if
> irq_work() no IRQ support." from Oct 6, 2021, leads to the following
> Smatch static checker warning:
> 
> 	kernel/events/core.c:4955 _free_event()
> 	warn: sleeping in atomic context
> 
> There are two potential call trees where preemption is disabled.
> 
> perf_remove_from_context() <- disables preempt
 raw_spin_lock_irq(&ctx->lock)

> __perf_event_exit_context() <- disables preempt
don't see additional one.

> -> __perf_remove_from_context()
>    -> perf_group_detach()
>       -> perf_put_aux_event()
>          -> put_event()
>             -> _free_event()
> 
> _free_event() calls irq_work_sync() which can now sleep.

That is true. There is also 
|	if (event->rb) 
|		mutex_lock(&event->mmap_mutex);

Can we somehow delay the whole thing? There are also kfree() and
spinlock_t usage which are not very RT compatible with disabled
preemption.

> regards,
> dan carpenter

Sebastian
