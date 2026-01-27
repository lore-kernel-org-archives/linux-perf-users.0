Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81711DE887
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769549750; cv=pass; b=V+KLAFWtuWlyRQioUl4fq8o0GFoZ77bISymjbm01aFPdAzEgihQIhhbmmpv0mcW2ersbPLiFHvRT9OHG6H/HHig7cI4jJ3aYf/8RbkkuITb7Kc3eYEpVHfH4qEfrvrT36BbyX2LaXhXPWDGp+fZmQI9eXQqaQ454xrDje2q388Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769549750; c=relaxed/simple;
	bh=C97C3q1f2+9ANaJScwvxdbsdk/KxVo+LBXn35SlkaQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVUEUBHAPbDu8sQ5R1Bp/3HPsb+SaDjdYutt9GUta8R1MSGMoKJckqZnS4feW+/ZEPm2xzt1AOOfk9Bs2fRNaWtVIG5qHJnrU4G8+MfW2dxfil1ExxhvEORRg4XShXQou3OFpYYMQbC0hIElh57tm6um9iqfjaJC/c6Bq3UmbD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewnjjSZ4; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewnjjSZ4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a12ebe4b74so59884475ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 13:35:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769549748; cv=none;
        d=google.com; s=arc-20240605;
        b=Pjrr7SMY7e9ArqQ/LQ/ZvDLyg2cBVzhi+QJ/Kxl9svImsQygWIVrjlORFers9k2qXk
         8QI/FLkSsTKS/OqbcgXU0Fn2aVfTIauAlvb6h5x4RIxtoDRw7BpNnhKovY7Iizx7Cbt6
         0xpq/cYT3Fl7Prq1U/BBt3Vwng2kx5qNc5N0WtfdCQTX2QaQMsgaROuzfTZ5WZHE7mw1
         0jt+9Fpjf6owlm8SNAtaWanO+m7TB5TM3Si3nXEE58RoIxB0h6R2Al87FIWChCPt22rh
         Axe7KMtuYhN8gr+R/NrIvsuqd6CcWkXlsVxzoNapBwGjGFdFZIqQAbXkh7AsfZDQPZLY
         fv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        fh=lisl8/vRkn+Il/IQ/x+cpxdvDBOVjsjcmn/4Ib15uRc=;
        b=H42HfOkvoTxNnZUlc1vD6dD/n4wi1fDKCsCwWjadOwD/hcGJeIsabSLMT4rwBWWZbm
         dkkyDMPTs2riRbhrHs6iiuWfdkzOdRauoSg1OpRvupcLiQRPQHRrl4ngI860SQBneQ+7
         AgG5dOrSPzHwTif04tzfODo5MzR3rF/w3/uG9zHI8xBaeER4QoIGm9ee/j4KO1UjywL6
         m6cSR0alQb26F1QyXeLUhSIofBsfjH3Naq3gG2IT/Tor9REP/AGOlQTytNCBfWlDiaC+
         teNl0N4cpNBqzBZW3LRWEoxK3/z3ReAhXpsHreJGD7a4mMWwRK7F0tvJyg3t4MoNNHZG
         uFHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769549748; x=1770154548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        b=ewnjjSZ4ygb9/D8aheg2EQwKCLg3wMzg73q0728GCAmev0w2WvMXSx0BQ/KXVLxKq6
         vyBjuW0/sB/C+MSM+f5SljrIivyAtSnbBaIxCsK+kSntQ1c884Zc32l+Tlk+5ykpS5Fi
         f4hKElhygaalZrcS2hmnJxPjkdiP7ExkkAwRBDi7sZv+/Ux6cxcIpej2uf0D2LUiSmp5
         +GxbuXS1j42cUXgduRUd/DtWVbFRfYimg+yYiCBj8j3TMlBpi9LUZsmXzUoEkczMUx/X
         kK+QwZgQAvZrsw+rroDugiUrD8vf0T06ibZhNxGM4rzr3769iAdA7PBh5dVbBwyDo18Y
         pVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769549748; x=1770154548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsrB0WKEEM0I9Fpgpuk4REg1XhpPCR9Gqn9MJNXWOek=;
        b=p9enCeakJ7OOAKfG/gc3dZZ3Cd9Fcdx+dylYp2yzCibEQP+yvcKHh1KIyE2eO34B03
         DdqKw7HveYyrx9WpGtj28sfLBFKka3WX0FYBe/JeSn5pkA8TYDw8E+Nll3W3IzO0RVP2
         gB4RmKjEQahmBNQmQkx4a2S0BdJMGYqXDEt0gXDOs4T83Msc5BM1MDG+HemQ/XMwE9ZI
         SGdtv0uabQ3LUA8UhUywsJ5RgdfwUmJXxhUbkVrWrFZiWm1qM1QrCdGPPoXYZq5Di3uq
         3YYQWGBrSXqSHBATT5ZFV6BJyV7iJjl4lN9vxL+y9RYCS79sUWzH1AlDAimCd+JNNGHc
         TyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXugp1UxQwLGdVtbfFiicHAqAjbWESTBZxKcH5FUoDEkLVDBHAM2jaF45omXP298Q53RgZ399+wzR1HBCJuHnyD@vger.kernel.org
X-Gm-Message-State: AOJu0YzuChkS45jwTZwy0b4gp+naTqsoHejjmDd+38FwBxRz74MpJXiw
	wJarRyhL3zhi7zSKhfMj7s2MB4ULtOwJCzcURh3f6q9s1XGcuOvxq6x0RzdPBCbcLzKlVFjPj/S
	ezzw6dgYtO/gPP0/w61A++ho2Z08XbvJ7BpuZ
X-Gm-Gg: AZuq6aJdwX3/f1+UubdzJovP9evFYDwTB0SuMOJhs1prbxXG4ygiIQtm+m14rOLlq3O
	sbyGm6wGBUJLTGD6C2m3VhDh/kXACrxJJ2tSCWF/fT3/2/P3jCTzM5pTHyinX9WlP1RKO8jiq/V
	kZXqdeC2qz17P4gs7fD8KN57b843sjdfeDSGSitxoIJgv05YNnzAM/g4XuvOQ7xQWC4DVq3qYSB
	am/puRY154QENhj5A0iK8P0deW/wPFYwIsq8VPzx7knemokqGe1rnbbodkLIkzUTIWF8sTMt2rr
	cG4X1TQla44=
X-Received: by 2002:a17:903:2301:b0:295:5da6:600c with SMTP id
 d9443c01a7336-2a870d7afc2mr28445175ad.2.1769549748390; Tue, 27 Jan 2026
 13:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev> <20260126074331.815684-4-chen.dylane@linux.dev>
In-Reply-To: <20260126074331.815684-4-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Jan 2026 13:35:35 -0800
X-Gm-Features: AZwV_Qjnaggx7ZAyA5kZjLjV3t-88OZe0RDLvJcWlk19LJ0-lrbY8LafvDvgWuA
Message-ID: <CAEf4BzbubXxLHsO_2aVBG_oYE1Sc9iafLyvcX-PEjcQ7EXWCqA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/3] bpf: Hold ther perf callchain entry until
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

On Sun, Jan 25, 2026 at 11:46=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> w=
rote:
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
>  kernel/bpf/stackmap.c | 55 ++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e77dcdc2164..6bdee6cc05f 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -215,7 +215,9 @@ get_callchain_entry_for_task(struct task_struct *task=
, u32 max_depth)
>  #ifdef CONFIG_STACKTRACE
>         struct perf_callchain_entry *entry;
>
> +       preempt_disable();
>         entry =3D get_callchain_entry();
> +       preempt_enable();

pass perf_callchain_entry as input argument, to keep similar approach
to __get_perf_callchain, see below

>
>         if (!entry)
>                 return NULL;
> @@ -237,14 +239,40 @@ get_callchain_entry_for_task(struct task_struct *ta=
sk, u32 max_depth)
>                         to[i] =3D (u64)(from[i]);
>         }
>
> -       put_callchain_entry(entry);
> -
>         return entry;
>  #else /* CONFIG_STACKTRACE */
>         return NULL;
>  #endif
>  }
>
> +static struct perf_callchain_entry *
> +bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user, int=
 max_stack,
> +                      bool crosstask)
> +{

I don't really like having this wrapper, it feels like the flow will
be cleaner and easier to follow if we modify the code as suggested
below

> +       struct perf_callchain_entry *entry;
> +       int ret;
> +
> +       preempt_disable();
> +       entry =3D get_callchain_entry();
> +       preempt_enable();

I'd actually consider having __get_callchain_entry() that does what
get_callchain_entry() does right now under assumption that
preemption/migration is disabled, and then make get_callchain_entry do
preempt_disable + fetch entry + preevent_enable + return entry dance.

This will simplify the flow here to just with no explicit
preempt_{disable,enable} visible. Either way all of this has
assumption that we are staying on the same CPU throughout (so at the
very least we need to have migration disabled)

entry =3D get_callchain_entry();
__get_perf_callchain(entry, ...);
put_callchain_entry();


BTW, is there a way to assert that either preemption or migration is
currently disabled? I think both get_callchain_entry and
put_callchain_entry would benefit from that

pw-bot: cr


> +
> +       if (unlikely(!entry))
> +               return NULL;
> +
> +       ret =3D __get_perf_callchain(entry, regs, kernel, user, max_stack=
, crosstask, false, 0);
> +       if (ret) {
> +               put_callchain_entry(entry);
> +               return NULL;
> +       }
> +
> +       return entry;
> +}
> +
> +static void bpf_put_perf_callchain(struct perf_callchain_entry *entry)
> +{
> +       put_callchain_entry(entry);
> +}
> +
>  static long __bpf_get_stackid(struct bpf_map *map,
>                               struct perf_callchain_entry *trace, u64 fla=
gs)
>  {
> @@ -327,20 +355,23 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs,=
 struct bpf_map *, map,
>         struct perf_callchain_entry *trace;
>         bool kernel =3D !user;
>         u32 max_depth;
> +       int ret;
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
> +       trace =3D bpf_get_perf_callchain(regs, kernel, user, max_depth, f=
alse);
>
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
>                 return -EFAULT;
>
> -       return __bpf_get_stackid(map, trace, flags);
> +       ret =3D __bpf_get_stackid(map, trace, flags);
> +       bpf_put_perf_callchain(trace);

Just as above, I think get_callchain_entry + __get_perf_callchain +
put_callchain_entry is better, IMO

> +
> +       return ret;
>  }
>
>  const struct bpf_func_proto bpf_get_stackid_proto =3D {
> @@ -468,13 +499,19 @@ static long __bpf_get_stack(struct pt_regs *regs, s=
truct task_struct *task,
>         } else if (kernel && task) {
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         } else {
> -               trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          crosstask, false, 0);
> +               trace =3D bpf_get_perf_callchain(regs, kernel, user, max_=
depth, crosstask);
>         }

with the above suggestions this will be a pretty streamlined:

trace =3D trace_in ?: get_callchain_entry();
if (!trace)
    goto err_fault;

if (trace_in) {
    trace->nr =3D ...
    err =3D 0
} else if (kernel && task) {
    err =3D get_callchain_entry_for_task(trace, ...);
} else {
    err =3D __get_perf_callchain(trace, ...);
}
if (err)
    goto clear;

... proceed as before, we have our stack trace inside trace ...

for successful and failed paths (you'll have to duplicate this logic):

if (trace !=3D trace_in)
    put_callchain_entry(trace);

>
> -       if (unlikely(!trace) || trace->nr < skip) {
> +       if (unlikely(!trace)) {

this condition cannot happen: we either get trace_in !=3D NULL or we get
it using __get_callchain_entry and then validate it's not NULL
earlier, so drop this condition

> +               if (may_fault)
> +                       rcu_read_unlock();
> +               goto err_fault;
> +       }
> +       if (trace->nr < skip) {
>                 if (may_fault)
>                         rcu_read_unlock();
> +               if (!trace_in)
> +                       bpf_put_perf_callchain(trace);

do this clean up in one place, behind the new goto label? it's a bit
too easy to miss this, IMO

>                 goto err_fault;
>         }
>
> @@ -495,6 +532,8 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>         /* trace/ips should not be dereferenced after this point */
>         if (may_fault)
>                 rcu_read_unlock();

now that I looked at this code, I feel like we don't really need this
rcu_read_{lock,unlock}() dance (even though I added it in the first
place). I this RCU was supposed to be need to keep
perf_callchain_entry alive long enough, but for BPF this is guaranteed
because either BPF stack map will keep them alive by delaying
put_callchain_buffer() until freeing time (after RCU Tasks Trace + RCU
grace periods), or for bpf_get_stack/bpf_get_task_stack, BPF program
itself will hold these buffers alive again, until freeing time which
is delayed until after RCU Tasks Trace + RCU grace period.

Please send this clean up as the first patch in the series so we can
review and ack this separately. Thanks!

> +       if (!trace_in)
> +               bpf_put_perf_callchain(trace);
>
>         if (user_build_id)
>                 stack_map_get_build_id_offset(buf, trace_nr, user, may_fa=
ult);
> --
> 2.48.1
>
