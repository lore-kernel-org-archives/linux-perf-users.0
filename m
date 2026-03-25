Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49EB3F0764
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774451294; cv=pass; b=Q1YOOZvJzefFpk0dGubrNfmErQD9nKYdEv6g72fxtcoEs0iLi4K2GSwgwJeeyItzIFx4Aua+p8CCB0ZBrDXGrRsUkLXvnPl19HCf8oHxkjHqMxNR4DjBJlITRSVErSsqFQxOU4SMeJFl1pv4NzpKGEHJrolHuppbMoJp973IJoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774451294; c=relaxed/simple;
	bh=QXNtPM9v/gYK2WPvl0X1uZr1Jx5+vXu4GgXl8B7CVxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeoQwRzrGjQQYY3B8LP+2H2w5OOr6pfyV/d0X8xYPI2r1I0+bJPaK6TmorysF1t7S/nP0yAhudNe9A/rUCefzhLEfGDXK82TnUoZbmvyXG4anC5j3on/fnd5W+M/Y6g5xYhzDUB0rllUJDP/zH1H18LcAjI34ai2qGAu6ye86+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sW6dzNVX; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sW6dzNVX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aeab6ff148so82725ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 08:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774451292; cv=none;
        d=google.com; s=arc-20240605;
        b=GJGwtSXbca+Z8+D5cPBRAIEIcRnclgJsM6cRNeBXpeK1+npVyq+8EYaH4Iqlzu6oHx
         DY2t/fKPTgQXibSYr/cYYNlu4WJqBteg7bO6A4eP/vo5Vdoj8xYtu9Fp2Rks3LqCrKcc
         +LEoLL504GKdq25ju0r8JJpDO9u2/dyPJkA1IlzAsRHbTMIrgGEjRDgAIvJdeGo5jgJP
         f16413lAANeyejQ8UeryXXVWijyBWp5RBUVb9qhJflKAFZeYY9gjK6d26aaMq8F5kLo5
         AnLBzbUww0+7TM4Z2c08UY3Gf40wI7uihJOXQEAZBbnfCqyqQRD8Ke7N6yRAgR4ru2sB
         bNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PZ3n2lSjBUHI8XA3sxpWr0dwW+BQ++RM8y9bJI00dNU=;
        fh=BaZQ/ol4/E3OHjKRgz2NWjzLwcEo+skEZpaBalifh4g=;
        b=T5CEie8uBvauQmLItbUB2gPK79tLiQaWQvOzO830f5SqI5mmIhL9E0xR0aHyNPlyNI
         5RxLagk6Hbm7EaZSTu1SMp0+drXMCY9A+1/s8TuUb4hHbXLpuyh/AVSYe3HZ3aKsy0o5
         MSTBonU3mazxZ64IbxrhQE7nycFB/dpCi33h0YTnL8kPQaj8dW2KtGRHuTT8D6TT47JS
         6y0aR9yIBw9N6aG7VXc+Y+8M8vLAQwStIjT/2GXBP9yIIO+KOYGjL7PPSg7SWF91+YU5
         R2itB9WWlCOQ7W8sXkcPEYe7Ni3S+6WkhmXOvFR48Ozz20hesgoi5K8h3/7C0nT7mMSN
         Pkfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774451292; x=1775056092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZ3n2lSjBUHI8XA3sxpWr0dwW+BQ++RM8y9bJI00dNU=;
        b=sW6dzNVXkOIpAfCk9r5SWVDsbQ20CImgOO9ZqlKG9P1cuhRhvXCtlY2Z+AlZsT4CD9
         UbBn3Dkgd0u+TlmI/wgMieWGGKqaWWeRg4bM6k6LO+vrZKjvtQUWC4h09uyan/Yt2+xL
         ZETxF5BDWCq19Zxcv+Bfl/VjSU2zFjbWo6k1BmP3xltlwJ6u7QLTVvKizxBKiRmTiCZf
         dfz+vlIPEYODV4vNgocX3zmWbrsRh79L2rgzbUNDluX8C7eAsMTlGyVdoLr6QVdU5AhS
         MXKmvSvhmYZp5Cpxbwk91nr2h9R4aXh/lZ1umzNS19Oeeroat8FhLaU7ixa0ne0DCzBN
         1uZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774451292; x=1775056092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PZ3n2lSjBUHI8XA3sxpWr0dwW+BQ++RM8y9bJI00dNU=;
        b=EwieYmjusPI10YQLEESsJ3gCRtMNSG2ae/jkd3eqpW8rjghEJaARxL5TxubTz8x6um
         jHP99ym2VE1h3jnxKAFXQxoVWlhd3qCwcKPTo7k7hGL4atqj5dK9mc9ltqmxm7NpPghg
         Z8o+XR/WIGiRJzOnkZ6ZvreuM1jrIaE/HlsM8uLLEkcvR+otac9lCt2jxV9eumlY0SdF
         h7K6vUHHrEu9Mr70iz09SFV3s4TlnepGJtltp6wn7lfXzs4uuRNYRAd/F+rCvdyrzw0A
         h4st071CvwwJ41vnVekbC4qKSapccAA8m5t0nQyocOAmh3xZJUDN2KqbzdMlZCN9HXt/
         VemA==
X-Forwarded-Encrypted: i=1; AJvYcCWA+9rimXSP8U+Kojajl5PnKf6IgHD7TW0HQaZ6ewI5OhOT1c2Pgt5fOUFrbB0OiT15G8I7yQJprwHXDXZQbExa@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3P6XQINAyL9Y+rKOHo1b8ZUQzeehkoii/e+NGHpHY4UlqeSgB
	7wxy7liYIbO4nZTUVZd86KXzrfOFOuZfoOs83E2e5uInXcl23kQQAJ0OnZ02FUKfut8WB541G96
	fWSWYJcXUjPbBITIZ1JjXDMtx7DDXIGlX7yQjZg0P
X-Gm-Gg: ATEYQzxj+0VtJcST4kR0novhsGIzOss8inZUBDjBSjhsWGmWZdrSM3MZbHKsWDUIW87
	PwOKHTnATP1okYQetEwaP1RXiDq81gojiwWbtuBRVuQMzzX5yE/KYugls1ertdGMRaV3YBM1wM5
	q0VqapKCNT0Q7jsS6KhW9nVdvjaQk6wpZAaGaXov1deT8QlOrwRTXuv9AY6xPd4mK5+vom7MUTj
	dP1IP3p2rJqice8TH6vdqdQIPU/0ziXOdOHHhpPKIwohfx8+xn8J8ttgu9/HUtIEJJZaOFDbxJ+
	LZyA+5j5mmVoi/BcaE5gen8BtlyxEQOo6wDQLA==
X-Received: by 2002:a17:902:ccc7:b0:2a7:d266:d84a with SMTP id
 d9443c01a7336-2b0b2a6c418mr174195ad.17.1774451291428; Wed, 25 Mar 2026
 08:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
 <20260325102053.1401-1-yuhaocheng035@gmail.com>
In-Reply-To: <20260325102053.1401-1-yuhaocheng035@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Mar 2026 08:08:00 -0700
X-Gm-Features: AaiRm50kII7vVc0rUwG_4qLpRbTa_GeDHYthvBi81fYP_igpvEvsxOLR_Cog7pI
Message-ID: <CAP-5=fUwzdnVris8pLB2nA8Y9dtjfdANDztnN=rP268cZuX5MA@mail.gmail.com>
Subject: Re: [PATCH v3] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: yuhaocheng035@gmail.com
Cc: wangqing7171@gmail.com, peterz@infradead.org, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 3:21=E2=80=AFAM <yuhaocheng035@gmail.com> wrote:
>
> From: Haocheng Yu <yuhaocheng035@gmail.com>
>
> Syzkaller reported a refcount_t: addition on 0; use-after-free warning
> in perf_mmap.
>
> The issue is caused by a race condition between a failing mmap() setup
> and a concurrent mmap() on a dependent event (e.g., using output
> redirection).
>
> In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
> event->rb with the mmap_mutex held. The mutex is then released to
> perform map_range().
>
> If map_range() fails, perf_mmap_close() is called to clean up.
> However, since the mutex was dropped, another thread attaching to
> this event (via inherited events or output redirection) can acquire
> the mutex, observe the valid event->rb pointer, and attempt to
> increment its reference count. If the cleanup path has already
> dropped the reference count to zero, this results in a
> use-after-free or refcount saturation warning.
>
> Fix this by extending the scope of mmap_mutex to cover the
> map_range() call. This ensures that the ring buffer initialization
> and mapping (or cleanup on failure) happens atomically effectively,
> preventing other threads from accessing a half-initialized or
> dying ring buffer.
>
> v2:
> Because expanding the guarded region would cause the event->mmap_mutex
> to be acquired repeatedly in the perf_mmap_close function, potentially
> leading to a self deadlock, the original logic of perf_mmap_close was
> retained, and the mutex-holding logic was modified to obtain the
> perf_mmap_close_locked function.
>
> v3:
> The fix is made smaller by passing the parameter "holds_event_mmap_mutex"
> to perf_mmap_close.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@i=
ntel.com/
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c | 78 +++++++++++++++++++++++++++-----------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2c35acc2722b..a3228c587de1 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event=
 *event);
>   * the buffer here, where we still have a VM context. This means we need
>   * to detach all events redirecting to us.
>   */
> -static void perf_mmap_close(struct vm_area_struct *vma)
> +static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_ev=
ent *event,
> +                             bool holds_event_mmap_lock)
>  {
> -       struct perf_event *event =3D vma->vm_file->private_data;
> +       struct perf_event *iter_event;
>         mapped_f unmapped =3D get_mapped(event, event_unmapped);
>         struct perf_buffer *rb =3D ring_buffer_get(event);
>         struct user_struct *mmap_user =3D rb->mmap_user;
> @@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct=
 *vma)
>         if (refcount_dec_and_test(&rb->mmap_count))
>                 detach_rest =3D true;
>
> -       if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap=
_mutex))
> +       if ((!holds_event_mmap_lock &&
> +            !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mma=
p_mutex)) ||
> +           (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap=
_count)))
>                 goto out_put;
>
>         ring_buffer_attach(event, NULL);
> -       mutex_unlock(&event->mmap_mutex);
> +       if (!holds_event_mmap_lock)
> +               mutex_unlock(&event->mmap_mutex);
>
>         /* If there's still other mmap()s of this buffer, we're done. */
>         if (!detach_rest)
> @@ -6789,8 +6793,8 @@ static void perf_mmap_close(struct vm_area_struct *=
vma)
>          */
>  again:
>         rcu_read_lock();
> -       list_for_each_entry_rcu(event, &rb->event_list, rb_entry) {
> -               if (!atomic_long_inc_not_zero(&event->refcount)) {
> +       list_for_each_entry_rcu(iter_event, &rb->event_list, rb_entry) {
> +               if (!atomic_long_inc_not_zero(&iter_event->refcount)) {
>                         /*
>                          * This event is en-route to free_event() which w=
ill
>                          * detach it and remove it from the list.
> @@ -6799,7 +6803,8 @@ static void perf_mmap_close(struct vm_area_struct *=
vma)
>                 }
>                 rcu_read_unlock();
>
> -               mutex_lock(&event->mmap_mutex);
> +               if (!holds_event_mmap_lock)
> +                       mutex_lock(&iter_event->mmap_mutex);
>                 /*
>                  * Check we didn't race with perf_event_set_output() whic=
h can
>                  * swizzle the rb from under us while we were waiting to
> @@ -6810,11 +6815,12 @@ static void perf_mmap_close(struct vm_area_struct=
 *vma)
>                  * still restart the iteration to make sure we're not now
>                  * iterating the wrong list.
>                  */
> -               if (event->rb =3D=3D rb)
> -                       ring_buffer_attach(event, NULL);
> +               if (iter_event->rb =3D=3D rb)
> +                       ring_buffer_attach(iter_event, NULL);
>
> -               mutex_unlock(&event->mmap_mutex);
> -               put_event(event);
> +               if (!holds_event_mmap_lock)
> +                       mutex_unlock(&iter_event->mmap_mutex);
> +               put_event(iter_event);
>
>                 /*
>                  * Restart the iteration; either we're on the wrong list =
or
> @@ -6842,6 +6848,18 @@ static void perf_mmap_close(struct vm_area_struct =
*vma)
>         ring_buffer_put(rb); /* could be last */
>  }
>
> +static void perf_mmap_close(struct vm_area_struct *vma)
> +{
> +       struct perf_event *event =3D vma->vm_file->private_data;
> +
> +       __perf_mmap_close(vma, event, false);
> +}
> +
> +static void perf_mmap_close_locked(struct vm_area_struct *vma, struct pe=
rf_event *event)
> +{
> +       __perf_mmap_close(vma, event, true);
> +}
> +
>  static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
>  {
>         /* The first page is the user control page, others are read-only.=
 */
> @@ -7167,28 +7185,28 @@ static int perf_mmap(struct file *file, struct vm=
_area_struct *vma)
>                         ret =3D perf_mmap_aux(vma, event, nr_pages);
>                 if (ret)
>                         return ret;
> -       }
>
> -       /*
> -        * Since pinned accounting is per vm we cannot allow fork() to co=
py our
> -        * vma.
> -        */
> -       vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> -       vma->vm_ops =3D &perf_mmap_vmops;
> +               /*
> +                * Since pinned accounting is per vm we cannot allow fork=
() to copy our
> +                * vma.
> +                */
> +               vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDU=
MP);
> +               vma->vm_ops =3D &perf_mmap_vmops;
>
> -       mapped =3D get_mapped(event, event_mapped);
> -       if (mapped)
> -               mapped(event, vma->vm_mm);
> +               mapped =3D get_mapped(event, event_mapped);
> +               if (mapped)
> +                       mapped(event, vma->vm_mm);
>
> -       /*
> -        * Try to map it into the page table. On fail, invoke
> -        * perf_mmap_close() to undo the above, as the callsite expects
> -        * full cleanup in this case and therefore does not invoke
> -        * vmops::close().
> -        */
> -       ret =3D map_range(event->rb, vma);
> -       if (ret)
> -               perf_mmap_close(vma);
> +               /*
> +                * Try to map it into the page table. On fail, invoke
> +                * perf_mmap_close() to undo the above, as the callsite e=
xpects
> +                * full cleanup in this case and therefore does not invok=
e
> +                * vmops::close().
> +                */
> +               ret =3D map_range(event->rb, vma);
> +               if (ret)
> +                       perf_mmap_close_locked(vma, event);
> +       }
>
>         return ret;
>  }
>
> base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
> --
> 2.51.0
>
