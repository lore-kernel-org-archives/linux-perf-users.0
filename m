Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF46116;
	Fri, 24 May 2024 01:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716514710; cv=none; b=bu0El1MXXP9zRpjTY8VJFpI1g3hvI7RnZGLAaMmJf0q5gy6+kHzXOY7DrltbOMYinbpWRvSxpvC5K/UAaqbQ7lSyTXh1DILLEDAJYtDMT8xHw7lPSZ/e2/4OuXcXaXpK7G2jB2vePNUkKTX1iJi5G117BvolZguAu/VF+n9NBYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716514710; c=relaxed/simple;
	bh=9+sxS94GMIIcyWc9owzePTjceCMRi2Qhi4bWvQEGpAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9PyyqWhU/qDqv97wrxZqD2jNZ/qScQD6VHiTBbSwKDmyMOdf5qCWc72MzfsEc8Nqo4g9oFCYO5cyborlMFlvl4oD5hovT7H2WfoSIGyQUJboizBkM6QIsI6/zz15RKC1buR0PmtSCaw0ZZlax4V5xmu12hBb/qJkAWYCdAsRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bdf11888a5so869671a91.0;
        Thu, 23 May 2024 18:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716514708; x=1717119508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cm0wyLN6ZzdaTX6nZptBzZW0mt9IjUaev3nT664fKWI=;
        b=KQfK2cl02JXprfaG74JGxZxHAvvG12XrilRLczKjhHeDOZJkfU+mTb8kgQmPEzl6Q5
         OLhrGbgsngk7Md7DxFSmHHVc8ZOH/tjoR3Ah0kpIyXgBHvdn0SGEUvmh154XVzJHQn9X
         AuVXLPy92bH3YJDVz6lU0GrSL7rE5PMaXHEDdtMeajcqaPoFbVC3de9P3aMAJVkhwpbm
         O0EBK0MoMhL3eKeDnqigdbeWA2tuDlr6UxS1dhkTWN2yJQro6+cenYj3VBsnP9MihJ3P
         DtzpWu61BU8YXlrzg84SN8IjGCOlf2XT42VUj1hzo59yNXifyIoZLFRNBBRUXpIl6aUE
         Ivww==
X-Forwarded-Encrypted: i=1; AJvYcCU650Ud9U9nT6yOAVJaPu424F96hWnPhk+nIkWVCmJUxeGJ0Wzw5uD609/OflHPYLh0LNQ8P4S5pF6Emk2tSQKsiMyK6ktohntUotek2IPuOJjaffHn8Cuv3ZGGki14VsUmfL7nz8XXF4fV8Kek1g==
X-Gm-Message-State: AOJu0Yx+IO0XgikhSl+OWdEYteAUXaxVyg7rVAqLKFWCoLAGCrg3/POQ
	kGWVEMA9J7kyjgPXHhNimg2zetsWLyYMwXdiN1rhLDSVZyJt0ldqFG+WAUY4FlMdOttwWByVdOQ
	YVsPsRWk5hwERjXtti5Qk4hdoi3U=
X-Google-Smtp-Source: AGHT+IE0G0PLQwFv4g0JqXxdnAyoNEm6ndomA5N3EIC+NW/HSipjBJsMSgH3SekFFVIa0yavzQ4w5VwggPWgTlkuUKU=
X-Received: by 2002:a17:90b:30c:b0:2b3:28df:92bb with SMTP id
 98e67ed59e1d1-2bf5e16cee1mr898443a91.13.1716514707327; Thu, 23 May 2024
 18:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521133029.83654-1-ben.gainey@arm.com> <20240521133029.83654-2-ben.gainey@arm.com>
In-Reply-To: <20240521133029.83654-2-ben.gainey@arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 23 May 2024 18:38:15 -0700
Message-ID: <CAM9d7cjBzEKZuGXTgA6CW7Tf7LcjdvwfJa+HCR2EE87DcA78BA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] perf: Support PERF_SAMPLE_READ with inherit
To: Ben Gainey <ben.gainey@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	james.clark@arm.com, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 21, 2024 at 6:30=E2=80=AFAM Ben Gainey <ben.gainey@arm.com> wro=
te:
>
> This change allows events to use PERF_SAMPLE READ with inherit
> so long as PERF_SAMPLE_TID is also set.
>
> In this configuration, an event will be inherited into any
> child processes / threads, allowing convenient profiling of a
> multiprocess or multithreaded application, whilst allowing
> profiling tools to collect per-thread samples, in particular
> of groups of counters.
>
> The read_format field of both PERF_RECORD_READ and PERF_RECORD_SAMPLE
> are changed by this new configuration, but calls to `read()` on the same
> event file descriptor are unaffected and continue to return the
> cumulative total.
>
> Signed-off-by: Ben Gainey <ben.gainey@arm.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  include/linux/perf_event.h |  1 +
>  kernel/events/core.c       | 78 ++++++++++++++++++++++++++++----------
>  2 files changed, 58 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d2a15c0c6f8a9..e7eed33c50f16 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -932,6 +932,7 @@ struct perf_event_context {
>
>         int                             nr_task_data;
>         int                             nr_stat;
> +       int                             nr_inherit_read;
>         int                             nr_freq;
>         int                             rotate_disable;
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 724e6d7e128f3..e7c847956ebff 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1767,6 +1767,14 @@ perf_event_groups_next(struct perf_event *event, s=
truct pmu *pmu)
>                 event =3D rb_entry_safe(rb_next(&event->group_node),     =
 \
>                                 typeof(*event), group_node))
>
> +/*
> + * Does the event attribute request inherit with PERF_SAMPLE_READ
> + */
> +static inline bool has_inherit_and_sample_read(struct perf_event_attr *a=
ttr)
> +{
> +       return attr->inherit && (attr->sample_type & PERF_SAMPLE_READ);
> +}
> +
>  /*
>   * Add an event from the lists for its context.
>   * Must be called with ctx->mutex and ctx->lock held.
> @@ -1797,6 +1805,8 @@ list_add_event(struct perf_event *event, struct per=
f_event_context *ctx)
>                 ctx->nr_user++;
>         if (event->attr.inherit_stat)
>                 ctx->nr_stat++;
> +       if (has_inherit_and_sample_read(&event->attr))
> +               ctx->nr_inherit_read++;
>
>         if (event->state > PERF_EVENT_STATE_OFF)
>                 perf_cgroup_event_enable(event, ctx);
> @@ -2021,6 +2031,8 @@ list_del_event(struct perf_event *event, struct per=
f_event_context *ctx)
>                 ctx->nr_user--;
>         if (event->attr.inherit_stat)
>                 ctx->nr_stat--;
> +       if (has_inherit_and_sample_read(&event->attr))
> +               ctx->nr_inherit_read--;
>
>         list_del_rcu(&event->event_entry);
>
> @@ -3529,11 +3541,18 @@ perf_event_context_sched_out(struct task_struct *=
task, struct task_struct *next)
>                         perf_ctx_disable(ctx, false);
>
>                         /* PMIs are disabled; ctx->nr_pending is stable. =
*/
> -                       if (local_read(&ctx->nr_pending) ||
> +                       if (ctx->nr_inherit_read ||
> +                           next_ctx->nr_inherit_read ||
> +                           local_read(&ctx->nr_pending) ||
>                             local_read(&next_ctx->nr_pending)) {
>                                 /*
>                                  * Must not swap out ctx when there's pen=
ding
>                                  * events that rely on the ctx->task rela=
tion.
> +                                *
> +                                * Likewise, when a context contains inhe=
rit +
> +                                * SAMPLE_READ events they should be swit=
ched
> +                                * out using the slow path so that they a=
re
> +                                * treated as if they were distinct conte=
xts.
>                                  */
>                                 raw_spin_unlock(&next_ctx->lock);
>                                 rcu_read_unlock();
> @@ -4533,11 +4552,19 @@ static void __perf_event_read(void *info)
>         raw_spin_unlock(&ctx->lock);
>  }
>
> -static inline u64 perf_event_count(struct perf_event *event)
> +static inline u64 perf_event_count_cumulative(struct perf_event *event)
>  {
>         return local64_read(&event->count) + atomic64_read(&event->child_=
count);
>  }
>
> +static inline u64 perf_event_count(struct perf_event *event, bool self_v=
alue_only)
> +{
> +       if (self_value_only && has_inherit_and_sample_read(&event->attr))
> +               return local64_read(&event->count);
> +
> +       return perf_event_count_cumulative(event);
> +}
> +
>  static void calc_timer_values(struct perf_event *event,
>                                 u64 *now,
>                                 u64 *enabled,
> @@ -5454,7 +5481,7 @@ static u64 __perf_event_read_value(struct perf_even=
t *event, u64 *enabled, u64 *
>         mutex_lock(&event->child_mutex);
>
>         (void)perf_event_read(event, false);
> -       total +=3D perf_event_count(event);
> +       total +=3D perf_event_count_cumulative(event);
>
>         *enabled +=3D event->total_time_enabled +
>                         atomic64_read(&event->child_total_time_enabled);
> @@ -5463,7 +5490,7 @@ static u64 __perf_event_read_value(struct perf_even=
t *event, u64 *enabled, u64 *
>
>         list_for_each_entry(child, &event->child_list, child_list) {
>                 (void)perf_event_read(child, false);
> -               total +=3D perf_event_count(child);
> +               total +=3D perf_event_count_cumulative(child);
>                 *enabled +=3D child->total_time_enabled;
>                 *running +=3D child->total_time_running;
>         }
> @@ -5545,14 +5572,14 @@ static int __perf_read_group_add(struct perf_even=
t *leader,
>         /*
>          * Write {count,id} tuples for every sibling.
>          */
> -       values[n++] +=3D perf_event_count(leader);
> +       values[n++] +=3D perf_event_count_cumulative(leader);
>         if (read_format & PERF_FORMAT_ID)
>                 values[n++] =3D primary_event_id(leader);
>         if (read_format & PERF_FORMAT_LOST)
>                 values[n++] =3D atomic64_read(&leader->lost_samples);
>
>         for_each_sibling_event(sub, leader) {
> -               values[n++] +=3D perf_event_count(sub);
> +               values[n++] +=3D perf_event_count_cumulative(sub);
>                 if (read_format & PERF_FORMAT_ID)
>                         values[n++] =3D primary_event_id(sub);
>                 if (read_format & PERF_FORMAT_LOST)
> @@ -6132,7 +6159,7 @@ void perf_event_update_userpage(struct perf_event *=
event)
>         ++userpg->lock;
>         barrier();
>         userpg->index =3D perf_event_index(event);
> -       userpg->offset =3D perf_event_count(event);
> +       userpg->offset =3D perf_event_count_cumulative(event);
>         if (userpg->index)
>                 userpg->offset -=3D local64_read(&event->hw.prev_count);
>
> @@ -7194,13 +7221,14 @@ void perf_event__output_id_sample(struct perf_eve=
nt *event,
>
>  static void perf_output_read_one(struct perf_output_handle *handle,
>                                  struct perf_event *event,
> -                                u64 enabled, u64 running)
> +                                u64 enabled, u64 running,
> +                                bool from_sample)
>  {
>         u64 read_format =3D event->attr.read_format;
>         u64 values[5];
>         int n =3D 0;
>
> -       values[n++] =3D perf_event_count(event);
> +       values[n++] =3D perf_event_count(event, from_sample);
>         if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
>                 values[n++] =3D enabled +
>                         atomic64_read(&event->child_total_time_enabled);
> @@ -7218,8 +7246,9 @@ static void perf_output_read_one(struct perf_output=
_handle *handle,
>  }
>
>  static void perf_output_read_group(struct perf_output_handle *handle,
> -                           struct perf_event *event,
> -                           u64 enabled, u64 running)
> +                                  struct perf_event *event,
> +                                  u64 enabled, u64 running,
> +                                  bool from_sample)
>  {
>         struct perf_event *leader =3D event->group_leader, *sub;
>         u64 read_format =3D event->attr.read_format;
> @@ -7245,7 +7274,7 @@ static void perf_output_read_group(struct perf_outp=
ut_handle *handle,
>             (leader->state =3D=3D PERF_EVENT_STATE_ACTIVE))
>                 leader->pmu->read(leader);
>
> -       values[n++] =3D perf_event_count(leader);
> +       values[n++] =3D perf_event_count(leader, from_sample);
>         if (read_format & PERF_FORMAT_ID)
>                 values[n++] =3D primary_event_id(leader);
>         if (read_format & PERF_FORMAT_LOST)
> @@ -7260,7 +7289,7 @@ static void perf_output_read_group(struct perf_outp=
ut_handle *handle,
>                     (sub->state =3D=3D PERF_EVENT_STATE_ACTIVE))
>                         sub->pmu->read(sub);
>
> -               values[n++] =3D perf_event_count(sub);
> +               values[n++] =3D perf_event_count(sub, from_sample);
>                 if (read_format & PERF_FORMAT_ID)
>                         values[n++] =3D primary_event_id(sub);
>                 if (read_format & PERF_FORMAT_LOST)
> @@ -7281,9 +7310,14 @@ static void perf_output_read_group(struct perf_out=
put_handle *handle,
>   * The problem is that its both hard and excessively expensive to iterat=
e the
>   * child list, not to mention that its impossible to IPI the children ru=
nning
>   * on another CPU, from interrupt/NMI context.
> + *
> + * Instead the combination of PERF_SAMPLE_READ and inherit will track pe=
r-thread
> + * counts rather than attempting to accumulate some value across all chi=
ldren on
> + * all cores.
>   */
>  static void perf_output_read(struct perf_output_handle *handle,
> -                            struct perf_event *event)
> +                            struct perf_event *event,
> +                            bool from_sample)
>  {
>         u64 enabled =3D 0, running =3D 0, now;
>         u64 read_format =3D event->attr.read_format;
> @@ -7301,9 +7335,9 @@ static void perf_output_read(struct perf_output_han=
dle *handle,
>                 calc_timer_values(event, &now, &enabled, &running);
>
>         if (event->attr.read_format & PERF_FORMAT_GROUP)
> -               perf_output_read_group(handle, event, enabled, running);
> +               perf_output_read_group(handle, event, enabled, running, f=
rom_sample);
>         else
> -               perf_output_read_one(handle, event, enabled, running);
> +               perf_output_read_one(handle, event, enabled, running, fro=
m_sample);
>  }
>
>  void perf_output_sample(struct perf_output_handle *handle,
> @@ -7343,7 +7377,7 @@ void perf_output_sample(struct perf_output_handle *=
handle,
>                 perf_output_put(handle, data->period);
>
>         if (sample_type & PERF_SAMPLE_READ)
> -               perf_output_read(handle, event);
> +               perf_output_read(handle, event, true);
>
>         if (sample_type & PERF_SAMPLE_CALLCHAIN) {
>                 int size =3D 1;
> @@ -7944,7 +7978,7 @@ perf_event_read_event(struct perf_event *event,
>                 return;
>
>         perf_output_put(&handle, read_event);
> -       perf_output_read(&handle, event);
> +       perf_output_read(&handle, event, false);
>         perf_event__output_id_sample(event, &handle, &sample);
>
>         perf_output_end(&handle);
> @@ -12006,10 +12040,12 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>         local64_set(&hwc->period_left, hwc->sample_period);
>
>         /*
> -        * We currently do not support PERF_SAMPLE_READ on inherited even=
ts.
> +        * We do not support PERF_SAMPLE_READ on inherited events unless
> +        * PERF_SAMPLE_TID is also selected, which allows inherited event=
s to
> +        * collect per-thread samples.
>          * See perf_output_read().
>          */
> -       if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
> +       if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PE=
RF_SAMPLE_TID))
>                 goto err_ns;
>
>         if (!has_branch_stack(event))
> @@ -13033,7 +13069,7 @@ static void sync_child_event(struct perf_event *c=
hild_event)
>                         perf_event_read_event(child_event, task);
>         }
>
> -       child_val =3D perf_event_count(child_event);
> +       child_val =3D perf_event_count_cumulative(child_event);
>
>         /*
>          * Add back the child's count to the parent's count:
> --
> 2.45.1
>
