Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60F27F01B
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128718; cv=pass; b=Og86mMyYI1PNwfs8XbmQ9DTQYZPrfPyKKV7Qet+KHyoBeJtZ8htAUdS8sO50Oq1wVCvKevav2HHlS69UJdyIUe7oLAkjDgS1E/mbDE2IkY5onD9lSOn+QtLIYydBVallW0lqpo1ztSW74RaT+kfJPNm4S+zTcbt1zPRaknyRt+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128718; c=relaxed/simple;
	bh=EQN+iIM8+dm37iZHB7GD4DOloPZVK3vMmDu9SRdIhIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVHdiPkQVf6z4FuH348+dZ6g9cjyS9mjGIlBfkgKQhHPWDxyVC+NC13eqG8GKV5fd0NByzs0baxZRb8nE59r6EL94JaTjyr768Ko9+XHzWRVk8r6IEdLKPlIdDJYrxWA+9MjpAHZ5v+wcMmxcoiGZk//il4DLdUJxXO3lXsf8JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fofY/QnG; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fofY/QnG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c634bb5bd8eso267211a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 16:38:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769128709; cv=none;
        d=google.com; s=arc-20240605;
        b=GyF5FrgTGOBMlb5mTy7oCHwjvjiMl8aDYtEeF2vkyfwhaE/WwqssoyNmeISA0mUyju
         Zprl2MeJPHeqWo/nQFHFjLQxpwk2pXuvNWZRTgiCA1QErOzyHtNP+xNfPC+R2pcMzoiI
         lt5oVS+fIQBr+JagLA4lmcSVN6VFQNpeYbKY66IOGnjxdQoKN3+rgSnWFtpQbbfvqJBD
         sh9t2TUJEGfvhuA5ZBzx5g0H3u2hmOsGcG+YNRrjAhelqnni7tnKkvqQ70kCSYb5LjcA
         MEtgJe+RG1CRxv15hiL6+ctdWSy4Z+irTxJwnB05l3d/A9pgu92cHpfQEFjXz5v+n053
         5JXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        fh=rbRQF6HESQmpiSJzrQ1k0w8C6aGWJ3Eqrnt56AYvwhk=;
        b=YWYGRsqcInfND2tAHWhxKRyFJQCPNp3e8bt2JReXgCFmG2V9KhBhVj8DmOh4QIN5aY
         skm1S/YPEtgxs/y4bYGi4U4ljmJFYj1awipiPS9KDm5Vx9xu7KmEjhEGJmu8k7Ux1fZd
         r7h23f+4hs7350NA4wfVe+oBdyefvK8X/ZQIwTbh3kh2IKNQtGDeegu1jJBXg8cJ4RdW
         E2e3c96+DfDPIn1nFMAwG1Uc3BJk13Xdov6zm5jGq7CEz1gUO6HeS8/rMo8ldAlCp6/j
         GQjld5X0X8ZmPI4HKPpps/BotmxcW4iAbNGjln1J2QXwrXMkcpLFqU5IgYQPiLlpEZfZ
         J41A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769128709; x=1769733509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        b=fofY/QnGXNsqtldx8i0PKqpGn0kWgvRy7lQ2ypKQQidxYauRWp5ma/aQD3iftcf0ub
         iXTKggjUQP6ht4pXkJEYmNXM7Y5sSjGtSjyL5sJGukZxUPy86m4gOHhocThbyOEHoeP4
         02RJKDbC9Z43VhUL779lFZcNiUGfwHfrrTdovZQh3a6EwhZcRU6fKAT7uHMQaeCBzU/X
         p31cyGfi+x0NeuOj4Z7qR9aUpHBmuchRrirg+BduRKZ3m1tgAoXS/QyZFjp7aJ8usT7t
         CYfgc8grDgnbGV0rMZP4YDBdiSEjvX8zwQynRhoyyY39ed8ISduwQ4lwyvn4ZdMX1Lu2
         2Zbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769128709; x=1769733509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rnmdPKuoPhsIINyfYoC1nWb1eqqRXOyPg3w53hnHIow=;
        b=JrHD4tj4uyTbmnln/qpQcQgAemgi8nnPhPfLe8qSHMx8/kHZ8xS0mYpTzy5SSL/jeF
         /jM3Lzo3x/6fCmhGWBws9u4E9zxYDHrtIxCbHqarZ0nVxlNr0Y3KDQx7E+Jrbebvh7dw
         gybSlyMCcY5s1DjrJK+pyROikxFOMNnw1y1uO7E/ETH7LJ8RgRSxch0ztpXKXVO2uju4
         90hAC22ZSN1URWAD67f7uO40ZXsjjhYNxpd1facEw9vPGQPo9DwlaWzGydDMpS6/0uLd
         Jpa2i4xg9JLI1ros+J9ny5IWQbguwCTzIOErUUzj3pc+bDWuSAej5upOzvQNR/XyQL6V
         Rb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjcoh/+xhFi/FRDAN+qtfoKJrzmHxSLOUFCGb2V+vA0G+X2ubuRazv5Bafpwf2cD+saFvJGmOV/+eyQdYCF/aR@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRe/13oKW6kULVMOOVP1YrmRlWPXV+H9Yuc5WmrvHn67+Efp8
	w3RWU14Pb0L7qa9BFZLwqvJfK52WL0j6QU8jr4a+K+QuFIezlcsmWHaxFZxC6L/AFLJGNKGw+4L
	RLxOKddi5cSa9hQtVe3l4oEJHWRA7V9E=
X-Gm-Gg: AZuq6aLaYvR4d+D4gkWTD04w7V/lrs4Qb9kdtYoU1mdQ6flnHDs1uwOvplTrQfCTO2r
	sn2jw67TChnXRx99ggiZlM6wgv31SvfOfu+e3t4BmNs9k2D8hQs0UU10yMuJPy93sJt5wTvrW+p
	1a4MA+RFB9g0wMJZfJ6xnk5dEKw87vdNbNUu8hbnEMuOvc+Djxlo5OpNfbCfpLZaEwpNUKK1ivo
	cZ0XaZQ1006IpRBt39UKj0gOU5Xbh2v+rzGZilqK1ZtiCXBbPi/u4Hc2iLUElgpFs+ka8dFq3Tb
	c0dDHOeD+HY=
X-Received: by 2002:a05:6a20:9d94:b0:35e:3d4b:4cfe with SMTP id
 adf61e73a8af0-38e6f7be6ccmr1138557637.39.1769128708578; Thu, 22 Jan 2026
 16:38:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093326.1745307-1-chen.dylane@linux.dev> <20251217093326.1745307-3-chen.dylane@linux.dev>
In-Reply-To: <20251217093326.1745307-3-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 16:38:15 -0800
X-Gm-Features: AZwV_QifoUzy0XFoMYGDQsg9TBiqXuPA6VKirh7287oD12DKmY7OOfbENLMadiI
Message-ID: <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until
 used completely
To: Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, song@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:34=E2=80=AFAM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> As Alexei noted, get_perf_callchain() return values may be reused
> if a task is preempted after the BPF program enters migrate disable
> mode. The perf_callchain_entres has a small stack of entries, and
> we can reuse it as follows:
>
> 1. get the perf callchain entry
> 2. BPF use...
> 3. put the perf callchain entry
>
> And Peter suggested that get_recursion_context used with preemption
> disabled, so we should disable preemption at BPF side.
>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 12 deletions(-)
>

I took a bit closer look at these changes and I'm a fan of the
particular implementation, tbh. It's a bit of a maze how all these
different call chain cases are handled, so I might be missing
something, but I'd address this a bit differently.

First, instead of manipulating this obscure rctx as part of interface,
I'd record rctx inside the perf_callchain_entry itself, and make sure
that get_callchain_entry does have any output arguments.
put_callchain_entry() would then accept perf_callchain_entry reference
and just fetch rctx from inside it.

Then instead of open-coding get_perf_callchain by exposing
__init_perf_callchain_ctx, __get_perf_callchain_kernel, and
__get_perf_callchain_user, can't we have __get_perf_callchain() which
will accept perf_callchain_entry as an input and won't do get/put
internally. And then existing get_perf_callchain() will just do get +
__get_perf_callchain + put, while BPF-side code will do it's own get
(with preemption temporarily disabled), will fetch callstack in one of
a few possible ways, and then put it (unless callchain_entry is coming
from outside, that trace_in thing).

It's close to what you are doing, but I don't think anyone likes those
exposed __init_perf_callchain_ctx + __get_perf_callchain_kernel +
__get_perf_callchain_user. Can't we avoid that? (and also not sure we
need add_mark inside the ctx itself, do we?)

pw-bot: cr



> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c1..3bdd99a630d 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct bp=
f_stack_build_id *id_offs,
>  }
>
>  static struct perf_callchain_entry *
> -get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
> +get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 ma=
x_depth)
>  {
>  #ifdef CONFIG_STACKTRACE
>         struct perf_callchain_entry *entry;
> -       int rctx;
>
> -       entry =3D get_callchain_entry(&rctx);
> +       preempt_disable();
> +       entry =3D get_callchain_entry(rctx);
> +       preempt_enable();
>
>         if (!entry)
>                 return NULL;
> @@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct *task=
, u32 max_depth)
>                         to[i] =3D (u64)(from[i]);
>         }
>
> -       put_callchain_entry(rctx);
> -
>         return entry;
>  #else /* CONFIG_STACKTRACE */
>         return NULL;
> @@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map,
>         return id;
>  }
>
> +static struct perf_callchain_entry *
> +bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, boo=
l user,
> +                      int max_stack, bool crosstask)
> +{
> +       struct perf_callchain_entry_ctx ctx;
> +       struct perf_callchain_entry *entry;
> +
> +       preempt_disable();
> +       entry =3D get_callchain_entry(rctx);
> +       preempt_enable();
> +
> +       if (unlikely(!entry))
> +               return NULL;
> +
> +       __init_perf_callchain_ctx(&ctx, entry, max_stack, false);
> +       if (kernel)
> +               __get_perf_callchain_kernel(&ctx, regs);
> +       if (user && !crosstask)
> +               __get_perf_callchain_user(&ctx, regs, 0);
> +
> +       return entry;
> +}
> +
> +static void bpf_put_perf_callchain(int rctx)
> +{
> +       put_callchain_entry(rctx);
> +}
> +
>  BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, ma=
p,
>            u64, flags)
>  {
> @@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
>         u32 max_depth;
> +       int rctx, ret;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID=
)))
>                 return -EINVAL;
>
>         max_depth =3D stack_map_calculate_max_depth(map->value_size, elem=
_size, flags);
> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth,
> -                                  false, false, 0);
> +
> +       trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, user, max_d=
epth,
> +                                      false);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
>                 return -EFAULT;
>
> -       return __bpf_get_stackid(map, trace, flags);
> +       ret =3D __bpf_get_stackid(map, trace, flags);
> +       bpf_put_perf_callchain(rctx);
> +
> +       return ret;
>  }
>
>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> @@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         bool kernel =3D !user;
>         int err =3D -EINVAL;
>         u64 *ips;
> +       int rctx;
>
>         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
>                                BPF_F_USER_BUILD_ID)))
> @@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>                 trace =3D trace_in;
>                 trace->nr =3D min_t(u32, trace->nr, max_depth);
>         } else if (kernel && task) {
> -               trace =3D get_callchain_entry_for_task(task, max_depth);
> +               trace =3D get_callchain_entry_for_task(&rctx, task, max_d=
epth);
>         } else {
> -               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          crosstask, false, 0);
> +               trace =3D bpf_get_perf_callchain(&rctx, regs, kernel, use=
r, max_depth,
> +                                              crosstask);
>         }
>
> -       if (unlikely(!trace) || trace->nr < skip) {
> +       if (unlikely(!trace)) {
>                 if (may_fault)
>                         rcu_read_unlock();
>                 goto err_fault;
>         }
>
> +       if (trace->nr < skip) {
> +               if (may_fault)
> +                       rcu_read_unlock();
> +               if (!trace_in)
> +                       bpf_put_perf_callchain(rctx);
> +               goto err_fault;
> +       }
> +
>         trace_nr =3D trace->nr - skip;
>         copy_len =3D trace_nr * elem_size;
>
> @@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         if (may_fault)
>                 rcu_read_unlock();
>
> +       if (!trace_in)
> +               bpf_put_perf_callchain(rctx);
> +
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
>
> --
> 2.48.1
>
