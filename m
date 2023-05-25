Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6DC7EE29
	for <linux-perf-users@archiver.kernel.org>; Thu, 25 May 2023 11:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjEYLBY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 25 May 2023 07:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjEYLBP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 25 May 2023 07:01:15 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8AC5
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 04:01:13 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso932037a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 25 May 2023 04:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685012473; x=1687604473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H3s3eZRI7QHvVIXMBnOcIVhi2D8A5weHZjK0BaSR+nk=;
        b=cucLmxavBifaLssd4xQNhM2B/lvEYyfF8EURLo5UTEQ0Dgfz3ZkvQr2WA78X7IVGmk
         Rvflg4ubyvL7x96Tc7vzIh/xb3B0V3C617ZBJnnN3gTsYa6LqZ+hE1yEzdAaznO3VYbf
         YMKr3Vicip/93XHpe7Lt5xOYelBREDwvfSj0Uhh08941gUeCI+kNUFtDwdc6rRtTB8H4
         eXm1tX/g/vVJ5bSJWyEz0gzg4tSQUT9w6bmwOV1AzloqLkUDhWyXyNv2rBcHTUhZFf2J
         EdTSerQWRpbV9okH8OWuiSD5LVs025+NTGZjh2BIKOjPktA/BAKiSZKj2RIyTsOs9T2h
         SUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685012473; x=1687604473;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3s3eZRI7QHvVIXMBnOcIVhi2D8A5weHZjK0BaSR+nk=;
        b=cwgY38O6g0JEAQ9jBfg0KBNJuoIzOLchsvyoupGpSBiJEePJmQbVuIMJeLO+NJ1SHA
         75De5ldl2z07/00MqfnJuT/815jYxXp/duxICBOi2YY13UEHuaU/HLqtI9jGZEYSNAz/
         625KabcRPVSqt/1Bm/JcOCxkKt9Jd6Ve4x89wIV2AoiIIpBMa8hMVZ0TZmsDyZShSVzl
         VGc1bGrUc0rR00f7peeKeA6AYxVjU11FQ0gDSXXuNC/WgPsNKqFEhOk+7nuCpJX5Yzua
         GoHwVu+uazZMdIOwZtVDx5PxM9MdlaciVj+U24edDQEtR9P/DTa2xAyOr8ZoyO3rHqbQ
         96iQ==
X-Gm-Message-State: AC+VfDyEvovibpWpYQZn0P6nBxQNWD7l1Kx2akQmfwrHTtSkppgcTmaW
        cs3FRKptrk/FKC+dUpPbvMETzXXFfaKnFM487P+ojw==
X-Google-Smtp-Source: ACHHUZ6kF44+CWaj32VELKx1e7lWy8woMgKyL/bMvB0rDR+HM/+fLemxA5p/A7kDEdIeLRUhpj1oLqLDu4rUa39mqAI=
X-Received: by 2002:a17:90a:f691:b0:23a:ad68:25a7 with SMTP id
 cl17-20020a17090af69100b0023aad6825a7mr1381642pjb.2.1685012472914; Thu, 25
 May 2023 04:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230524131958.2139331-1-james.clark@arm.com> <20230524131958.2139331-3-james.clark@arm.com>
In-Reply-To: <20230524131958.2139331-3-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 25 May 2023 12:01:01 +0100
Message-ID: <CAJ9a7ViOL80O3f-hcqV7=fhG8OfJef+ZTSX9G2xN9ggZtQ1wZQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf cs-etm: Use previous thread for branch sample
 source IP
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, denik@chromium.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 24 May 2023 at 14:20, James Clark <james.clark@arm.com> wrote:
>
> Branch samples currently use the IP of the previous packet as the from
> IP, and the IP of the current packet as the to IP. But it incorrectly
> uses the current thread. In some cases like a jump into a different
> exception level this will attribute to the incorrect process.
>
> Fix it by tracking the previous thread in the same way the previous
> packet is tracked.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index ebffc9052561..a997fe79d458 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -86,6 +86,7 @@ struct cs_etm_traceid_queue {
>         size_t last_branch_pos;
>         union perf_event *event_buf;
>         struct thread *thread;
> +       struct thread *prev_thread;
>         struct branch_stack *last_branch;
>         struct branch_stack *last_branch_rb;
>         struct cs_etm_packet *prev_packet;
> @@ -480,6 +481,7 @@ static int cs_etm__init_traceid_queue(struct cs_etm_queue *etmq,
>         tidq->trace_chan_id = trace_chan_id;
>         tidq->thread = machine__findnew_thread(&etm->session->machines.host, -1,
>                                                queue->tid);
> +       tidq->prev_thread = machine__idle_thread(&etm->session->machines.host);
>
>         tidq->packet = zalloc(sizeof(struct cs_etm_packet));
>         if (!tidq->packet)
> @@ -616,6 +618,8 @@ static void cs_etm__packet_swap(struct cs_etm_auxtrace *etm,
>                 tmp = tidq->packet;
>                 tidq->packet = tidq->prev_packet;
>                 tidq->prev_packet = tmp;
> +               thread__put(tidq->prev_thread);
> +               tidq->prev_thread = thread__get(tidq->thread);
>         }
>  }
>
> @@ -791,6 +795,7 @@ static void cs_etm__free_traceid_queues(struct cs_etm_queue *etmq)
>                 /* Free this traceid_queue from the array */
>                 tidq = etmq->traceid_queues[idx];
>                 thread__zput(tidq->thread);
> +               thread__zput(tidq->prev_thread);
>                 zfree(&tidq->event_buf);
>                 zfree(&tidq->last_branch);
>                 zfree(&tidq->last_branch_rb);
> @@ -1450,8 +1455,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>         sample.time = cs_etm__resolve_sample_time(etmq, tidq);
>
>         sample.ip = ip;
> -       sample.pid = tidq->thread->pid_;
> -       sample.tid = tidq->thread->tid;
> +       sample.pid = tidq->prev_thread->pid_;
> +       sample.tid = tidq->prev_thread->tid;
>         sample.addr = cs_etm__first_executed_instr(tidq->packet);
>         sample.id = etmq->etm->branches_id;
>         sample.stream_id = etmq->etm->branches_id;
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
