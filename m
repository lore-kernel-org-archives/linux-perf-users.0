Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDF19E819
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614747; cv=pass; b=oICEfTmiNEV60KH3H7gReZmYgaRncMTyvllv6tcVdFqOLJNnbRZmh7abzpDRPO8mcCNle5hzPRq+7q8uEwNJbQnoLhI7kPfCsH2R7hcHr5HOutIX2ayl/fGqgaPFo0aMlDZhn8h7FWAh8v7x41NggCPX+yYsoAmV70TXsUz8nTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614747; c=relaxed/simple;
	bh=6y/xMAburGfbScfis39HP3HyYixsL4ULjd8gGonpz2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqpALOC1EVZI/g68so2TB2onpsAS07lefEmDQ6t338Q46AP1Jq+Cy54O6Hhu6WsbylAYazkxc+wCa//FGf/BUpqJ3SVSJpJHmkf3WhTeQjrHzPBsHlPX3i8nv11/DVLKgw37r25YX0Ucw6MnAAGI2g6YmhZeufAYfRJDALA/ZbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO2p57MQ; arc=pass smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO2p57MQ"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35c206f0481so1742344a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 05:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774614745; cv=none;
        d=google.com; s=arc-20240605;
        b=lOA5aPTkCEAqVQQ07u2XJ2l1kgRzAn85gcnxsBGdFRo8hibTJ0MXmL7TLta54kFbPa
         sb4kL5MDnfdbdrRjAiaGlQ2tuYdlQERAqMwUSb2e7BWqQ90oDXDPzGV0cVQAmvfIHb07
         YuCQpOimeF/qQ6yHS0IXyGqKJ1y5oBZsLRdnO+l53+IQGQOcxJ/82RkHC3ZhloT1YvMy
         +j2pTHfzyq2n/Pup0Gi2rsWdve+JTAiJFQazM6HzkE6eOWNDgo/8cB0BJ1g3XSuvx8nc
         OPM5due/VJ45xrLhZc/5IwCNQ+OiDptl9h86L+cRcR6civBEJi3Hv6nhiIZrMYUvWy31
         4dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RoIbDSj5GhoUKkw89SmpUNVAX8OgfzQcv7wgkOnfQMQ=;
        fh=D35WzRq2WCsby6LCwJWqPx8KGDbOOZVCHr0sj7F9Qcs=;
        b=IV5rGGcal4bmgULt3hQJC3uEz/WWDcXpYU6i7MvNfDqzmojnhHCE7EUzwolXXFEcIx
         MF2ydSSwMwnVW6T6mgyQAptAxLIWzsllZIaOwaeBLfCRIk5U029K3v9oiSzQaUO3biOW
         HCKQU+yuE38z9O03umlWIlU56tLjEMs+/faHE/TdKUOQEITnNKie+rl1+Kp6pboC4SaG
         dvoTiH3DWEv96uJ3FOM4OpeAhjoaGpPWkqjQUYCf3r7tOFvS9iPhNAWl04+49cpdPFwu
         LFSh+S/AyFY3SVTipS5icY7bjXgAs4CADx7zwGeOSwASGT0Nv/Uu6OjgOmManldZ0U4v
         /s3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774614745; x=1775219545; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RoIbDSj5GhoUKkw89SmpUNVAX8OgfzQcv7wgkOnfQMQ=;
        b=RO2p57MQge9L3il9ZYPIh3HdZk4bUxOurk9yIDy1Z50TsdfS1IX3aG60tOu5FWGoKM
         XJeAe6odemNXVYlzlW/j1em5ueE0kbqPK0h7DyvNehgpK84AjPjl/nbddeYlVN/Zm8J0
         Sj/nIqd+I2J9crqU1X7fbQR7xDQ3/pok3ULYxyQfo8KKfe2GWzMAALx0jZIrQIxxVwx8
         1RBURO0ufxOGGShkF6VtAJS4y9cqRCzJK+JPNxwIEHPOlTfld29auyrP8OF/X5FLAvYP
         YhnVcpLdpm1uH4XbjJZeIW9Ri87PpnoKzsHXpPqTwLiXcR9eBDyO3GH5pwN1oBfNrg9f
         MG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774614745; x=1775219545;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoIbDSj5GhoUKkw89SmpUNVAX8OgfzQcv7wgkOnfQMQ=;
        b=Gsf64z5Zl0jjQvXOm+0hPra/CnGC82MSLyMZoDvKPwjysCEjUqAEtc96oAi5ZlxM0j
         7TfbQtts4CwtKbAhGd8ou7EueHanC7zB8zEsihrQGCJLzeaYOYeh1HOsNEYOBttKe+CZ
         jMghZKoxjbW8oIVwdyBncJDKnAc8ZXN59fxNkIlidmTUwg2ufdgswCc/31Aja+C3LqJy
         IamWHZ6JdgzvDWIPRcSotd7S/A40Bwa9+QZsKrt4heUPJo4DJQdk+mlnZ/TyVJ6atxU0
         pMcWdQ8rDHePbUuqZuPxPj/eRoh11eB9Cn5DRTcE59RZ/d/PmdZodb/sdxhkGY0E3eNO
         ohhA==
X-Forwarded-Encrypted: i=1; AJvYcCUaX87UDNgvMIpREPRkyRJV8sCd/PkcZKA6hj6E0b+KW5nDaAU2RdQmpcOZ1vR/kdDSCcNiIjLNI/PB53/Yky4X@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9YrgQsOmcxnmCpsRsfyIXwZZ9GX24Q09vzwpj7Fz4ot8OZsi
	IYUBOnLIPgU1BJwbTX+YYOPoHcDcechEJV4KNyXHnAogV5vxfHSjrcI8ZmW8LpP+me3jy44Yx5N
	wBYnXmB3/waS9C6rH+m4T0+u1WC/+jlwoAR72+AFLhzDv
X-Gm-Gg: ATEYQzwMWoz6xpjK0VIuX1gKyz4v81aFUY7cx0yCU6/zE7YoBM+/3umUgp4g5HAPyeF
	xkResT75tAZTSUFASx02wtfCIqr475s3k1iDdnVlxzlgNjsETqJv0cGT9iZvTz67m5bZV82qcAk
	oLDY7z99qbiy9HU2jqJuKjeZTH+9SmynOMJsAbP8NTapvt2PfWzmo7teGz4CxxDcboZ5kXRy4js
	buu/hTmqD+QRlnGmJ2DrOKHJINGnbPdnd51YL9iBzJpRGlj6cf+ziIXbXupveWB720d8S/Auroi
	LhowSw==
X-Received: by 2002:a05:6123:2e5:b0:56c:ce8a:b07a with SMTP id
 71dfb90a1353d-56d4a51cef0mr793285e0c.7.1774614718755; Fri, 27 Mar 2026
 05:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326112821.GK3738786@noisy.programming.kicks-ass.net> <20260327122953.64466-1-yuhaocheng035@gmail.com>
In-Reply-To: <20260327122953.64466-1-yuhaocheng035@gmail.com>
From: Haocheng Yu <yuhaocheng035@gmail.com>
Date: Fri, 27 Mar 2026 20:31:39 +0800
X-Gm-Features: AQROBzA6GtylVN3qYlX3vC13vf6kvVGJGYFCgeMm0RbC9_u9QNz28I1RIcCN_68
Message-ID: <CAAoXzSouFTNDHs0ZwoWV9iVLj+fHHf2hKEi5AS83b=w75PbMBQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf/core: Fix refcount bug and potential UAF in perf_mmap
To: Peter Zijlstra <peterz@infradead.org>, Qing Wang <wangqing7171@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Your solution looks much better.

I tried to incorporate it and submit a patch v4. If you are already
handling it, please ignore my patch.

Thanks,
Haocheng

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
> v4:
> This problem is solved in a smarter way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
> ---
>  kernel/events/core.c        | 59 +++++++++++++++++++++++++++++--------
>  kernel/events/internal.h    |  1 +
>  kernel/events/ring_buffer.c |  2 ++
>  3 files changed, 49 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 22a0f405585b..d3f978402b1e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7010,7 +7010,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
>  }
>
>  static void perf_pmu_output_stop(struct perf_event *event);
> -
> +static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
>  /*
>   * A buffer can be mmap()ed multiple times; either directly through the same
>   * event, or through other events by use of perf_event_set_output().
> @@ -7025,8 +7025,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>         mapped_f unmapped = get_mapped(event, event_unmapped);
>         struct perf_buffer *rb = ring_buffer_get(event);
>         struct user_struct *mmap_user = rb->mmap_user;
> -       int mmap_locked = rb->mmap_locked;
> -       unsigned long size = perf_data_size(rb);
>         bool detach_rest = false;
>
>         /* FIXIES vs perf_pmu_unregister() */
> @@ -7121,11 +7119,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
>          * Aside from that, this buffer is 'fully' detached and unmapped,
>          * undo the VM accounting.
>          */
> -
> -       atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
> -                       &mmap_user->locked_vm);
> -       atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
> -       free_uid(mmap_user);
> +       perf_mmap_unaccount(vma, rb);
>
>  out_put:
>         ring_buffer_put(rb); /* could be last */
> @@ -7265,6 +7259,15 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
>         atomic64_add(extra, &vma->vm_mm->pinned_vm);
>  }
>
> +static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb)
> +{
> +       struct user_struct *user = rb->mmap_user;
> +
> +       atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
> +                       &user->locked_vm);
> +       atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
> +}
> +
>  static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
>                         unsigned long nr_pages)
>  {
> @@ -7327,8 +7330,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
>         if (!rb)
>                 return -ENOMEM;
>
> -       refcount_set(&rb->mmap_count, 1);
> -       rb->mmap_user = get_current_user();
>         rb->mmap_locked = extra;
>
>         ring_buffer_attach(event, rb);
> @@ -7484,10 +7485,42 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>                  * vmops::close().
>                  */
>                 ret = map_range(event->rb, vma);
> -               if (ret)
> -                       perf_mmap_close(vma);
> -       }
> +               if (likely(!ret))
> +                       return 0;
> +
> +               /* Error path */
>
> +               /*
> +                * If this is the first mmap(), then event->mmap_count should
> +                * be stable at 1. It is only modified by:
> +                * perf_mmap_{open,close}() and perf_mmap().
> +                *
> +                * The former are not possible because this mmap() hasn't been
> +                * successful yet, and the latter is serialized by
> +                * event->mmap_mutex which we still hold (note that mmap_lock
> +                * is not strictly sufficient here, because the event fd can
> +                * be passed to another process through trivial means like
> +                * fork(), leading to concurrent mmap() from different mm).
> +                *
> +                * Make sure to remove event->rb before releasing
> +                * event->mmap_mutex, such that any concurrent mmap() will not
> +                * attempt use this failed buffer.
> +                */
> +               if (refcount_read(&event->mmap_count) == 1) {
> +                       /*
> +                        * Minimal perf_mmap_close(); there can't be AUX or
> +                        * other events on account of this being the first.
> +                        */
> +                       mapped = get_mapped(event, event_unmapped);
> +                       if (mapped)
> +                               mapped(event, vma->vm_mm);
> +                       perf_mmap_unaccount(vma, event->rb);
> +                       ring_buffer_attach(event, NULL);        /* drops last rb->refcount */
> +                       refcount_set(&event->mmap_count, 0);
> +                       return ret;
> +               }
> +       }
> +       perf_mmap_close(vma);
>         return ret;
>  }
>
> diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> index d9cc57083091..c03c4f2eea57 100644
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -67,6 +67,7 @@ static inline void rb_free_rcu(struct rcu_head *rcu_head)
>         struct perf_buffer *rb;
>
>         rb = container_of(rcu_head, struct perf_buffer, rcu_head);
> +       free_uid(rb->mmap_user);
>         rb_free(rb);
>  }
>
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 3e7de2661417..9fe92161715e 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -340,6 +340,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
>                 rb->paused = 1;
>
>         mutex_init(&rb->aux_mutex);
> +       rb->mmap_user = get_current_user();
> +       refcount_set(&rb->mmap_count, 1);
>  }
>
>  void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
>
> base-commit: 77de62ad3de3967818c3dbe656b7336ebee461d2
> --
> 2.51.0
>
