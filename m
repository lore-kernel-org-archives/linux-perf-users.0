Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4242D839C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 18:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167154; cv=pass; b=qRIO1W9+GU0r7asAzxZ+oIyUqbWvA8OXR0MbKYCLiVT2WVESjiL0LUWq3O4gaYSdVEFANujhf8+RJeQBDW0G2ItaPLEx3UwIdl5Wy8FhKU+wydNwOThHMhQKdYrPrf0RYJLkDFrrS9oVqq+SE2cFsq0EhAUniT9Sz2NUYkxjWLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167154; c=relaxed/simple;
	bh=lq1W6N3CE73ip7fItJz9wqIEpB4aBHP21Fa7FZhesbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bi/anAb6d+Bv+lVLZcW8sHg1Pf1KQKFN/Vwgx5ga+6DERJa9cHDHORhIRH/0v0RYkvQJPmIpQ1amcu4hn89tMcBRpBHt1XaBxP/zeNT2dmqU/0OQZ7fb0NhTbW62b+qx+sQWB8tn/wq2+XaPRGLmXH5MA+eH6aK6NBmjQORu8SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAxAa1T/; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAxAa1T/"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ae49120e97so14655ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 11:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773167152; cv=none;
        d=google.com; s=arc-20240605;
        b=NweskzfBAVfEdUhGSQgFRDiIFdhQJVOAqOF8wIU4k/Og7bxJsBNrjDg+LpeSR0zPij
         1P7ywzgUMZ2Wxscn06dzeFAd0RhEA2bTMn7jtG8xASKitwDmDNs7dPAcWUqoMG10d9/R
         x0XSwHbMSlGuE/zM5iWrzTzoPzJq24eKPTFN120V9kAKNdrA1fTefjszXK3STKBbwXTC
         j0BX3ZuumfQknYeeZUJFsbQDPcRLVPVlHFhdsyuLDBofWYkbf+ZIHeoktXZERXAJuowy
         lcivWsmAul0JEMFDBsjHPaXWlOipCz3T7Jx9POZ170AhIXv62FWkOqUQJa1y88FYPl5F
         6rTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCb2XCJ+sz2vfx9EN2nF6LBW0Cd/CfePcqph3Fclofk=;
        fh=Q69gz8nqVYcgFjaD8TSosjj2psMTfP/oqvvb5K5w2C0=;
        b=T4PWWqEAlhGMB9PIHYd3EqzyJ+jxQ6g6A5ZL9TespEXhhN8hmFAjEJ+X2lGqU9bSs4
         MrQAy1jFMYvC/5gDWVhz3qJqLpHUYZh8PVt84CpxzhdKVV7ib4grS29S++Tiik8mA2F7
         Z8LRBEvxw+gG3mKNd5glnOTaI9kMFalKssDumvcd93AjIhGyt0BKW5zyDXPJE1AJw21t
         PrmDr+xTo2pIGgYYLQ850dLR57H73YDP9FVHmrrKuowVxrcGjjqRzQ4uuWk2zn7cEzbA
         wtdNwmnPEJlZoB9jvh+04zfBoOOBNb1I+mW6iFLQpN9o0BHMsgWD5C6EX7Be/QJHR36X
         IRjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773167152; x=1773771952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCb2XCJ+sz2vfx9EN2nF6LBW0Cd/CfePcqph3Fclofk=;
        b=JAxAa1T/us0Lnb/x/6MiS4Gx4KILFioKRiJ6pS0VhUPWda5mPsnYLHA5LGDeYykcNT
         KhmaQFl4qo9yWhTncTVkgqc6FV3kF/+xol9JZrgI3CmQvSCxbXdU/W7RT4/Mb+O9mDZf
         P33ETtsa99n8o+kN7yjLAYbKbYI3OwT+YkuyvqqBkcYk7u5wgo2FQ49XcqUVY3HHYI9c
         D5P4HxEYb+muoMRVdySj4WyI+kqXBKhiKOzvpotBx1ACThdstkI1olG9Q4a4V1hLnSy8
         vK2RMtz95AN8IDEmrYyqcSlaONFImudh35bcPQG6PLVx7Y5v7dzouw7HV18QcvCvH18L
         LEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167152; x=1773771952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCb2XCJ+sz2vfx9EN2nF6LBW0Cd/CfePcqph3Fclofk=;
        b=L3nysGgRdIeNz6znhKfj9d4vaBG2m4CoBQ4egHu45UPMGw6hys33duEK9NEpdlU9pp
         cB0o+y+VKTmhH+UpF2kgobCvMjIUY6PscK0y/o60qdkejDRoOvZ2dXeNYZs8FZbLolLp
         tK7eTu2vxhecvv2jtfzWJz3H1i9VOycO+BoQmM3AbjZFV/FvywOILiLv0ZiLaLnMePme
         152TMyCiVLf8XyREvH/oEUlfD0dpaisPrLkxS/pSIN4rxKHhecbEHFAuXHTlQzHGpz1W
         LkKAGwY1UEXY/J8EvpLB1tTnOxAYCu3ToTiAI3vadgsCw+oKHUl+CJN/3zF3XxUNR17o
         O5Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV3Ugugw4ziNsyfIINpfvBRvm7NAbHomYFwNh9CzzpdMxRgy8MZ5N8QfsSJMFzazWFVhXM9xuDApZ7W8ON0aoxR@vger.kernel.org
X-Gm-Message-State: AOJu0YxDWxoFWEmoSGHwCdyXCroO14AcJU8aa9eWzjfk0DDi1Dr+bk0q
	mP7UemjYpR7PtmhwpNIBOVl8adVd4noVnk/dQ9cL1wdosWY6ZsA/UTxVzJB19gbAXHt8w+C6BVd
	113/FZP0oHc08zNNVnkPgOzCcxn9E5pBO+vo+3d/qP6d1mkkJ58hRd60TkIiYdg==
X-Gm-Gg: ATEYQzxkMCUh1iC0QlIKC6jAyNnjaa7CfbOuvHs5A/192ErGKkPCpmPOYNJ0kX7O1ba
	OJnY1PyEScmNt36ofOHlbUKPAa9HrIsl1gNmHt3j1NLUGhXmOkrsdL0iQeYst1rdb8kEXlxPEMy
	WKydcBDU+u/dqMZuTeL2eLAhEjQ5Fy6L1VSX42Xbuwa6FRZzC8ZpIniVLKUEpOPa0lxWKPjAo2v
	CeTMEo47qEkjQvB5A5pa+xAfTMCexD9l9S2ERmqp9lMTxls5/fj+/gz+WKPZ80M+83b5j51JLZt
	26sbiYeHp+qnpgmoivWZUpphv6xOAwvQnkTm4Q==
X-Received: by 2002:a17:902:dacd:b0:2a8:fe50:2933 with SMTP id
 d9443c01a7336-2aead183662mr496235ad.0.1773167151710; Tue, 10 Mar 2026
 11:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024170543.11201-1-thaumy.love@gmail.com> <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org> <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
In-Reply-To: <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
From: Ian Rogers <irogers@google.com>
Date: Tue, 10 Mar 2026 11:25:40 -0700
X-Gm-Features: AaiRm52nf6LKzSNGncOX1bGYrru1gxessPEXGqqnr9cND5JuXffygRI7grBR1t8
Message-ID: <CAP-5=fX5-fAA8exsxusktUPkvVUfzBqHyAFQMAuc7xg7_ZUJLw@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task exit
To: Peter Zijlstra <peterz@infradead.org>
Cc: James Clark <james.clark@linaro.org>, Thaumy Cheng <thaumy.love@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>, 
	Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 6:29=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> I suppose the easiest fix is this, but urgh...
>
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 03ced7aad309..c38acf1e2f43 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3664,6 +3664,9 @@ static int context_equiv(struct perf_event_context =
*ctx1,
>         if (ctx1->pin_count || ctx2->pin_count)
>                 return 0;
>
> +       if (ctx1->nr_stat || ctx2->nr_stat)
> +               return 0;
> +

So, just for fun, I ran the original patch, James's bug description
and this proposed fix through an AI using Chris Mason's kernel review
prompts. I'm sharing the output as the do_exit comments seem
legitimate given the stack trace in James' report.

Does this introduce a significant performance regression for multithreaded
workloads? By forcing a full sched_out and sched_in of the PMU on every
thread switch instead of just swapping context pointers, it removes the
performance benefits of context_equiv() for inherited stats.

Furthermore, does this patch actually address the concurrent ring buffer
corruption reported in the bug?

The corruption occurs because perf_event_exit_event() (called during do_exi=
t)
invokes perf_output_begin() on the parent's ring buffer from the exiting ch=
ild's
CPU. Because ring buffers use local_t operations which are not SMP-safe,
concurrent child exits corrupt the rb->nest tracking.

Since context_equiv() is only used during context switch
(perf_event_context_sched_out) and not during task exit, modifying it does
not prevent the concurrent ring buffer writes during do_exit.

Thanks,
Ian

>         /* If ctx1 is the parent of ctx2 */
>         if (ctx1 =3D=3D ctx2->parent_ctx && ctx1->generation =3D=3D ctx2-=
>parent_gen)
>                 return 1;
> @@ -3677,76 +3680,13 @@ static int context_equiv(struct perf_event_contex=
t *ctx1,
>          * hierarchy, see perf_event_init_context().
>          */
>         if (ctx1->parent_ctx && ctx1->parent_ctx =3D=3D ctx2->parent_ctx =
&&
> -                       ctx1->parent_gen =3D=3D ctx2->parent_gen)
> +           ctx1->parent_gen =3D=3D ctx2->parent_gen)
>                 return 1;
>
>         /* Unmatched */
>         return 0;
>  }
>
> -static void __perf_event_sync_stat(struct perf_event *event,
> -                                    struct perf_event *next_event)
> -{
> -       u64 value;
> -
> -       if (!event->attr.inherit_stat)
> -               return;
> -
> -       /*
> -        * Update the event value, we cannot use perf_event_read()
> -        * because we're in the middle of a context switch and have IRQs
> -        * disabled, which upsets smp_call_function_single(), however
> -        * we know the event must be on the current CPU, therefore we
> -        * don't need to use it.
> -        */
> -       perf_pmu_read(event);
> -
> -       perf_event_update_time(event);
> -
> -       /*
> -        * In order to keep per-task stats reliable we need to flip the e=
vent
> -        * values when we flip the contexts.
> -        */
> -       value =3D local64_read(&next_event->count);
> -       value =3D local64_xchg(&event->count, value);
> -       local64_set(&next_event->count, value);
> -
> -       swap(event->total_time_enabled, next_event->total_time_enabled);
> -       swap(event->total_time_running, next_event->total_time_running);
> -
> -       /*
> -        * Since we swizzled the values, update the user visible data too=
.
> -        */
> -       perf_event_update_userpage(event);
> -       perf_event_update_userpage(next_event);
> -}
> -
> -static void perf_event_sync_stat(struct perf_event_context *ctx,
> -                                  struct perf_event_context *next_ctx)
> -{
> -       struct perf_event *event, *next_event;
> -
> -       if (!ctx->nr_stat)
> -               return;
> -
> -       update_context_time(ctx);
> -
> -       event =3D list_first_entry(&ctx->event_list,
> -                                  struct perf_event, event_entry);
> -
> -       next_event =3D list_first_entry(&next_ctx->event_list,
> -                                       struct perf_event, event_entry);
> -
> -       while (&event->event_entry !=3D &ctx->event_list &&
> -              &next_event->event_entry !=3D &next_ctx->event_list) {
> -
> -               __perf_event_sync_stat(event, next_event);
> -
> -               event =3D list_next_entry(event, event_entry);
> -               next_event =3D list_next_entry(next_event, event_entry);
> -       }
> -}
> -
>  static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
>                                    struct task_struct *task, bool sched_i=
n)
>  {
> @@ -3835,8 +3775,6 @@ perf_event_context_sched_out(struct task_struct *ta=
sk, struct task_struct *next)
>                         RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
>
>                         do_switch =3D 0;
> -
> -                       perf_event_sync_stat(ctx, next_ctx);
>                 }
>                 raw_spin_unlock(&next_ctx->lock);
>                 raw_spin_unlock(&ctx->lock);
