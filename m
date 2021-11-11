Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92290C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B30360FE3
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 07:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbhKKHbu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 02:31:50 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:42758 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhKKHbt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 11 Nov 2021 02:31:49 -0500
Received: by mail-lj1-f179.google.com with SMTP id z8so10165859ljz.9;
        Wed, 10 Nov 2021 23:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvKLDKiLaxvEHRt4X5eALe08O4bJNdEFh/L/Ug15Ah0=;
        b=dMtETGd0+ggl4/CyUZD8nPWzZxF2KHdmOEtnTaWMhZOgQo6Wxj0MlMBBltJSrrRwnc
         z6f1YUvj+8zENdiZQdvqKFYQZ0OJYOlphpezWGgFIN6l5FOGttCfQ/B+gmmUlpVQ1Pg6
         zs0iHQyam5OhBMXQ/vmaUfbucOuDJ5+wgx845yG3uHXAGzcQF7Z1+lgGfnZR0fylLp95
         bAeIGUNEzF1IVuVhlEJzrljtrTAv6hLTIouCwHsA1MzgQVHARirTHHaTGgmTlVyqN1Ur
         lpnfjiOheI8XuraM+clKwfoDrL7lzNZq85L5sVlc5RbIDv8SzPhO7chZ7ZJ9qZW4KMKt
         8CSg==
X-Gm-Message-State: AOAM531jn0DUGydntkHbjEIwMu9vqeVoUlCnwwDZhc279Spg4VPUZ41X
        knTJVJ64+1R3QnaXnm5/i99h/8pmzkQRP2/DkOk=
X-Google-Smtp-Source: ABdhPJzUd/LZ0kiH90kqC8WmPHvyWDEyELeyPwpNaBRwqt8stq2Qd5ft24FBXCVCui4+0io5Pb+uK/oAqhVrGgvfsKg=
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr4929201ljp.204.1636615739944;
 Wed, 10 Nov 2021 23:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109115020.31623-1-german.gomez@arm.com> <20211109115020.31623-5-german.gomez@arm.com>
In-Reply-To: <20211109115020.31623-5-german.gomez@arm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 10 Nov 2021 23:28:48 -0800
Message-ID: <CAM9d7cg7Lp49xOc3BOhM4O9fqs7i+v6cNd=eaKWjDbREiE3Pvg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] perf arm-spe: Support hardware-based PID tracing
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 9, 2021 at 3:50 AM German Gomez <german.gomez@arm.com> wrote:
>
> If Arm SPE traces contain CONTEXT packets with TID info, use these
> values for tracking tid of samples. Otherwise fall back to using context
> switch events and display a message warning the user of possible timing
> inaccuracies [1].
>
> [1] https://lore.kernel.org/lkml/f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com/
>
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
>  tools/perf/util/arm-spe.c | 99 +++++++++++++++++++++++++++------------
>  1 file changed, 70 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 230bc7ab2..30b8bb48a 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -71,6 +71,7 @@ struct arm_spe {
>         u64                             kernel_start;
>
>         unsigned long                   num_events;
> +       u8                              use_ctx_pkt_for_pid;
>  };
>
>  struct arm_spe_queue {
> @@ -226,6 +227,44 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
>                 PERF_RECORD_MISC_USER;
>  }
>
> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> +                                   struct auxtrace_queue *queue)
> +{
> +       struct arm_spe_queue *speq = queue->priv;
> +       pid_t tid;
> +
> +       tid = machine__get_current_tid(spe->machine, speq->cpu);
> +       if (tid != -1) {
> +               speq->tid = tid;
> +               thread__zput(speq->thread);
> +       } else
> +               speq->tid = queue->tid;
> +
> +       if ((!speq->thread) && (speq->tid != -1)) {
> +               speq->thread = machine__find_thread(spe->machine, -1,
> +                                                   speq->tid);
> +       }
> +
> +       if (speq->thread) {
> +               speq->pid = speq->thread->pid_;
> +               if (queue->cpu == -1)
> +                       speq->cpu = speq->thread->cpu;
> +       }
> +}
> +
> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> +{
> +       struct arm_spe *spe = speq->spe;
> +       int err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);

I think we should pass -1 as pid as we don't know the real pid.

Thanks,
Namhyung


> +
> +       if (err)
> +               return err;
> +
> +       arm_spe_set_pid_tid_cpu(spe, &spe->queues.queue_array[speq->queue_nr]);
> +
> +       return 0;
> +}
> +
