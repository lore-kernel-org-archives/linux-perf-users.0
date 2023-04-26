Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CD4C7618E
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Apr 2023 12:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbjDZMGu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 08:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjDZMGr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Apr 2023 08:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B0DF3
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 05:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682510764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFDSH4WwHCXG1GZOi2Gdi1eMYEtRupeUCnIDZyXD4QU=;
        b=f0zyf71BiSgyDSzVtW1oqysJFAeb2ThgHaCmdFnOCWig0ObYDzcAP2PkSwyYQT8vwmq2Ug
        KGT4NV5cbUNc/zyIAb5ZrnGZHpetjQJb55P69mCdZoaFNfwLgQFadcdiuShjWpLQczA67l
        vnDPTxvs1xanmEHMbn4mrb4f/ax1Yao=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-9lkehW4-N6Skd8RmUFTwSQ-1; Wed, 26 Apr 2023 08:06:03 -0400
X-MC-Unique: 9lkehW4-N6Skd8RmUFTwSQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f17afcf99cso25802675e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Apr 2023 05:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682510761; x=1685102761;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFDSH4WwHCXG1GZOi2Gdi1eMYEtRupeUCnIDZyXD4QU=;
        b=azxY4gLpdXoZWSgbg1WPDDlE6wGhcDC9xyU/+LnGzJw0tsLUVuXAPXN0jjh2+VN+Je
         x67ySt5f81iwF6xFEr+61OsywV/Vp8O0GBjrXmf0WJ2b5XqrQAbtIuEEUrAiYsCWdyUp
         pN9r1IBrhYMcoRHH8R3E6WUbsGfiGX3wGpexX82/VImO9RdGWYhKrXHgk/7aB14ynXIm
         ecGGd+sLcL7DmtA6zPCUqAxevA2iqZHq4V42WX1twtjOhjC2mACiMc63Cs8nXMrGE6to
         Wam0fuqWF2qwZ7AWdK6SDDygKqM5LCs1m55hPg7qQUrhXnsUmomF2OVMl7D+/OcANXH8
         toMQ==
X-Gm-Message-State: AAQBX9fj0XZqj6gneuPiBcbhSMSw4nTBGaXVnHrNlah50YD7ydw5PItY
        b75TwitnjEFCFsb+Y5u/yte2DDWSWTc7a/BtOtL7kixH/M+GH35U4v+c6glykZKS2uo67V6QhGa
        d+NQPL9Ipt/sdF7GoJBnqVTz4fJsFftOhdCyfAZPvgihwFVZWawDgpM0tyDd2K+CzTFQ36gSs4j
        DwfgfHy/XlPeWfjw==
X-Received: by 2002:a1c:4b05:0:b0:3f0:3d47:2cc5 with SMTP id y5-20020a1c4b05000000b003f03d472cc5mr12547174wma.10.1682510761453;
        Wed, 26 Apr 2023 05:06:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZsW7afX9U8TokFcMXHHOCb5VbUOoq4RrK+iCDSXz+T2Nzq9KLP7DhOBkxolgKVvGBQwhoFzg==
X-Received: by 2002:a1c:4b05:0:b0:3f0:3d47:2cc5 with SMTP id y5-20020a1c4b05000000b003f03d472cc5mr12547127wma.10.1682510761116;
        Wed, 26 Apr 2023 05:06:01 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b002cff06039d7sm15603734wrx.39.2023.04.26.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 05:06:00 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v7 0/3] Introduce put_task_struct_atomic_sleep()
In-Reply-To: <20230425114307.36889-1-wander@redhat.com>
References: <20230425114307.36889-1-wander@redhat.com>
Date:   Wed, 26 Apr 2023 13:05:59 +0100
Message-ID: <xhsmhr0s6kfvc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/04/23 08:43, Wander Lairson Costa wrote:
> The put_task_struct() function reduces a usage counter and invokes
> __put_task_struct() when the counter reaches zero.
>
> In the case of __put_task_struct(), it indirectly acquires a spinlock,
> which operates as a sleeping lock under the PREEMPT_RT configuration.
> As a result, invoking put_task_struct() within an atomic context is
> not feasible for real-time (RT) kernels.
>
> One practical example is a splat inside inactive_task_timer(), which is
> called in a interrupt context:
>
> CPU: 1 PID: 2848 Comm: life Kdump: loaded Tainted: G W ---------
> Hardware name: HP ProLiant DL388p Gen8, BIOS P70 07/15/2012
> Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  mark_lock_irq.cold+0x33/0xba
>  ? stack_trace_save+0x4b/0x70
>  ? save_trace+0x55/0x150
>  mark_lock+0x1e7/0x400
>  mark_usage+0x11d/0x140
>  __lock_acquire+0x30d/0x930
>  lock_acquire.part.0+0x9c/0x210
>  ? refill_obj_stock+0x3d/0x3a0
>  ? rcu_read_lock_sched_held+0x3f/0x70
>  ? trace_lock_acquire+0x38/0x140
>  ? lock_acquire+0x30/0x80
>  ? refill_obj_stock+0x3d/0x3a0
>  rt_spin_lock+0x27/0xe0
>  ? refill_obj_stock+0x3d/0x3a0
>  refill_obj_stock+0x3d/0x3a0
>  ? inactive_task_timer+0x1ad/0x340
>  kmem_cache_free+0x357/0x560
>  inactive_task_timer+0x1ad/0x340
>  ? switched_from_dl+0x2d0/0x2d0
>  __run_hrtimer+0x8a/0x1a0
>  __hrtimer_run_queues+0x91/0x130
>  hrtimer_interrupt+0x10f/0x220
>  __sysvec_apic_timer_interrupt+0x7b/0xd0
>  sysvec_apic_timer_interrupt+0x4f/0xd0
>  ? asm_sysvec_apic_timer_interrupt+0xa/0x20
>  asm_sysvec_apic_timer_interrupt+0x12/0x20
> RIP: 0033:0x7fff196bf6f5
>
> To address this issue, this patch series introduces a new function
> called put_task_struct_atomic_safe(). When compiled with the
> PREEMPT_RT configuration, this function defers the call to
> __put_task_struct() to a process context.
>
> Additionally, the patch series rectifies known problematic call sites
> to ensure smooth functioning.
>

It took me a bit of time to grok the put_task_struct_rcu_user() vs
delayed_free_task() vs put_task_struct_atomic_safe() situation, but other
than that the patches LGTM.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

