Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D8D1E7C2E
	for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769193629; cv=pass; b=bseJ527eriB7QI793+smVIr6ZmgFIOLAyAo8SGVzww1DZgmIFt8mB3jscQLDJrQVfIrg7WT4BF+hScXHPVfsp/ZviMireatyPDA9vSdyfK/N82B8EfR0WdQ5br98cOpbeMBwciBMnmEk2B0n2neP/n6IGQDAq2JtNsDyqoEsuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769193629; c=relaxed/simple;
	bh=9q4mimbXORirokos5L1QLvxfE3Z5VpoFjEUFamGhitQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+fuWrkHjn2K4kbqWM60Fx1qrIh/Wzp+VvI3pd+vpYyO/XAwBOpnF/J4klwjvTApVaZv6M/CYyb243FyS5N/HCjfMiYQ1b4c1XnZcXNKXu2EsvHC4F8ryYNP2GiCdUHdwAB1OF3WI5ooonR2rt6bVhZf/7H172A/lKHgK+ODuYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG55c+zS; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG55c+zS"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29f2676bb21so27376265ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 23 Jan 2026 10:40:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769193627; cv=none;
        d=google.com; s=arc-20240605;
        b=RROFyTZtqmlZS8cuGuff2VB+0LthE4hMioGdZELZ41m/hNFz6rRlOlF/RKZiBc37jv
         VSB+qwXksBWiDkXcDvLS+o0baS+saixFuaiXaQtr5eZ4EdJ883i/1QVjTw3CVdl8Wfrf
         sbspUkIT+ekPHpAQP6YuKPaN45mXBi/6+Nq5zIzWQtEozRzp8kmDCgKdcOYYR8o4LYNB
         P1MB0CMAVg40A3gzTQGyaijMjEtaKObYPj34J7WzPy8FtWobfe1grJoZ5LCxJUSl9yqY
         hE6c18RlwZtCECZ4yDOWDkykRQah46L2jE2Q55hPL3R23iiOFHXuZJb+4gUFHKzU+JkS
         312g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        fh=6fGP9FjFOjVsKClSvCrOrAPKHcQcc/h7Lye/O6SJAq0=;
        b=HWbF52sJXy7K+UoIWWIGVCFBV1JRpG2wylU7LdnN94abjFSPXzI1m48OWqqZS7/wr9
         J3uEFlnHHf3BDn46s9jFE6/UbHcoczTQiCdjgA28Px0cN98ETSs1SQzsakk/2P1Uatr1
         aZNOxnb1UXLsnGEyUyl+O88Dmc8fApl5u1MY8rbPciXCaexVYWHquSl39Ic530QGTcH2
         QcRar4DJQU+UwAnWB95ikwPo0XHB8awcpKLpZ95rM0rwyEIvujyc9B+5j3jBzWsYxHFl
         n+tgb+gJuFQ7VgpzflBX8vD+5JbD47ohGua8pBYiCzaBB/fjEiLrQABAyYrtJ7EuEeZg
         TMWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769193627; x=1769798427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        b=OG55c+zSVibs3dIx63zT4a0sIURj+Lwzg+p/q635/1h12EzSxO0dB5u6UvrygfhKQU
         fCcyiUzpsIDiR4cJn5b9N34JeMlQDnHzLSNB8NgX7F9a/dBsabljTGjUSCa/uIn4zlzI
         NR2FTEBG5qpdvmJ91Jh3hGRZMVEgxaYg+pbf6UIHXIj49HrGxtX8tk9HMaVzg6fMbwdb
         W5bkM70yqu5l6k0lxGS58eRVLBvjWo2XWRPazfpKSfxCU1q1yJ7Ke0fjgM2o06dZjRsM
         oLKjqaMfxlheLnCVfvFu9bdTSAFxQjk62Fu1CxYvULGMrVjvEoWdFSlusKrUrjgJRJQS
         bvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769193627; x=1769798427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=40SwQh/No31of3qGMee9ATI15Dgrf8z7NoPIMLwQa5c=;
        b=skKIl+0aB7E/P//rp0SOvtrPVje6RToUf5qnLILMnG7tmfsb4202AvGuc9PhidEoIT
         2v9r8jdyiGhs4HUR0QaWYzq/EKbVWiFmCkBiyYR9i2OC+iuoIvCuaGE8hEmQAOFRtZtg
         p6/n1Wl/jvOUKh6fmgwNVo2/cJ5DZq6D8wiU04Zc34ERBLPr8uWyW+pV3PqA4fEsM8DG
         Zgrvry50wRokwDOpUSdwtitEdVB6iaL1iRyJVYfk63u52Hrlz+h+djqMj6gTYtPFWY/R
         maZBxQeUyEEIQG/TfOJw4X7lk6ZiSm0Ki70Hh2dWfjCQ4SLQywM2d2OVNykPYv2jzhq8
         djwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4Y82UqCxV/mF5BKQhEbinD9iGbY9eKvyZRLhjFogUZxPJH7eXNuytmtn9UwZ/y3onhNTbUnNEvk58WLp01Fk8@vger.kernel.org
X-Gm-Message-State: AOJu0YyihGn49pa+LSC2l2Y4QJyL/tq7A7o+yRftF7kf7hH/RmxOWoMz
	DKv4LgQuh0NjESTfe+Ks5spjMqFSUzk/iMW6297Ieg4O80tMcSfDtG78XbMrnJ/u23K3yNvv/MW
	xqgI5IaZynfs4vTtECGKxVO14BeiZpzI=
X-Gm-Gg: AZuq6aLGRYAYDO6ls1fOkIXhBInZcxCCX9jUAslZ446Vnt870yZreChAXvYZLpXAlP9
	WjvY6cmgM1xtuQeJd9OioQyjipB3fUG0wQgDRg4km3+Fdw455wTcKp7fzZeP/3Bj1s56ZmiIJx3
	4xreblfS+ERQf7DRTnSC+1ygiQWFk/w6Hgd2JkeIA5Q24wduZCpoYIQBjyhNMPKKtrr4Zwc4YhA
	BsATs1wfnfw6RNTMXiP4SdfJgLrmIhCmIG/Bo5+JRufYbmi9IYYpHQGgmTYn0526jIc6+nYhUQV
	YLwzM4jyWgs=
X-Received: by 2002:a17:902:e851:b0:29f:1bf:642a with SMTP id
 d9443c01a7336-2a7fe43ee93mr33047475ad.12.1769193627283; Fri, 23 Jan 2026
 10:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
 <20251217093326.1745307-3-chen.dylane@linux.dev> <CAEf4BzYEsKQxT--=oQELZ7g402FWpEuDEmxcovZXkck+k2U8HQ@mail.gmail.com>
 <a65cd17e-75a2-4fd3-ae10-bd5b3fe06c4d@linux.dev>
In-Reply-To: <a65cd17e-75a2-4fd3-ae10-bd5b3fe06c4d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jan 2026 10:40:15 -0800
X-Gm-Features: AZwV_QjioUl3t9zLV82uK8h0iCWY7fqLt9ZS76N4bgcC4L1WKapxN0cX_Kd2Sm8
Message-ID: <CAEf4BzbbxpDmvJrV6s3dupP4Ysx+vVaHYBk+KNZtthag5OvosQ@mail.gmail.com>
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

On Thu, Jan 22, 2026 at 9:42=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/1/23 08:38, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Wed, Dec 17, 2025 at 1:34=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> As Alexei noted, get_perf_callchain() return values may be reused
> >> if a task is preempted after the BPF program enters migrate disable
> >> mode. The perf_callchain_entres has a small stack of entries, and
> >> we can reuse it as follows:
> >>
> >> 1. get the perf callchain entry
> >> 2. BPF use...
> >> 3. put the perf callchain entry
> >>
> >> And Peter suggested that get_recursion_context used with preemption
> >> disabled, so we should disable preemption at BPF side.
> >>
> >> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++------=
--
> >>   1 file changed, 56 insertions(+), 12 deletions(-)
> >>
> >
> > I took a bit closer look at these changes and I'm a fan of the
> > particular implementation, tbh. It's a bit of a maze how all these
> > different call chain cases are handled, so I might be missing
> > something, but I'd address this a bit differently.
> >
> > First, instead of manipulating this obscure rctx as part of interface,
> > I'd record rctx inside the perf_callchain_entry itself, and make sure
> > that get_callchain_entry does have any output arguments.
> > put_callchain_entry() would then accept perf_callchain_entry reference
> > and just fetch rctx from inside it.
> >
>
> Hi Andrri,
>
> Try to implement this briefly with code, is my understanding correct?
>
> struct perf_callchain_entry *get_callchain_entry(void)
> {
>          int cpu;
>          int rctx;
>          struct perf_callchain_entry *entry;
>          struct callchain_cpus_entries *entries;
>
>          rctx =3D get_recursion_context(this_cpu_ptr(callchain_recursion)=
);
>          if (rctx =3D=3D -1)
>                  return NULL;
>
>          entries =3D rcu_dereference(callchain_cpus_entries);
>          if (!entries) {
>
> put_recursion_context(this_cpu_ptr(callchain_recursion), *rctx);
>                  return NULL;
>          }
>
>          cpu =3D smp_processor_id();
>
>          entry =3D ((void *)entries->cpu_entries[cpu]) +
>                  (rctx * perf_callchain_entry__sizeof());
>          entry->rctx =3D rctx;
>
>          return entry;
> }
>
> void
> put_callchain_entry(struct perf_callchain_entry *entry)
> {
>          put_recursion_context(this_cpu_ptr(callchain_recursion),
> entry->rctx);
> }
>
> And then no need rtcx in bpf_get_perf_callchain.

yes, exactly

>
> bpf_get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                         int max_stack, bool crosstask)
>
> Functionally, this seems fine. The only concern is whether the perf
> maintainer will approve it after all, this change involves modifying
> their core interfaces.
>
> Peter, Yonghong, can we do this?
>
> > Then instead of open-coding get_perf_callchain by exposing
> > __init_perf_callchain_ctx, __get_perf_callchain_kernel, and
> > __get_perf_callchain_user, can't we have __get_perf_callchain() which
> > will accept perf_callchain_entry as an input and won't do get/put
> > internally. And then existing get_perf_callchain() will just do get +
> > __get_perf_callchain + put, while BPF-side code will do it's own get
> > (with preemption temporarily disabled), will fetch callstack in one of
> > a few possible ways, and then put it (unless callchain_entry is coming
> > from outside, that trace_in thing).
> >
>
> Exposing only __get_perf_callchain will make it much easier for BPF
> callers to understand and use. And following Peter's suggestion, we can
> mark _init_perf_callchain_ctx, __get_perf_callchain_kernel, and
> __get_perf_callchain_user as static, then have __get_perf_callchain
> encapsulate the logic of _init_perf_callchain_ctx,
> __get_perf_callchain_kernel, and __get_perf_callchain_user. What do you
> think=EF=BC=9F

That's exactly what I proposed. Except I don't think we even need to
have __get_perf_callchain_user and __get_perf_callchain_kernel, keep
__get_perf_callchain almost identical to current get_perf_callchain(),
except for getting/putting callchain entry

>
> > It's close to what you are doing, but I don't think anyone likes those
> > exposed __init_perf_callchain_ctx + __get_perf_callchain_kernel +
> > __get_perf_callchain_user. Can't we avoid that? (and also not sure we
> > need add_mark inside the ctx itself, do we?)
> >
> > pw-bot: cr
> >
> >
> >

[please trim irrelevant parts]
