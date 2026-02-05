Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A32F0678
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770312890; cv=pass; b=MfjE8rDG0Lym/bwcoruAWXBDgs9B07bun9ndYeU3ygZnXjX4fA+5LAvII5z9fFrzlg7RBQAxuFV6ZpMydE3xlUMqdNR8xlJbGlCAeD9hevr2DDCejYd6jCoI3TlAhMrf4MvugAc4jNPYg3B029PQBE8oB5PI5WcrJs5eRKDCI70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770312890; c=relaxed/simple;
	bh=tiPBdJU8rqA5vz1AM2s+q8CIEl6BnwyA+J7QRWGMVtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW6LwZkPBkVgfckkLRjIqZheJN9XJTd2gNjhAhkxJ9OkxITc/hDgAfGA5mU1NygxMJevuOiIlyrkdEgiBh66xM2XoEj7zxJjBxWwOWaSWaDE/GtCwXvYJzIOpDeXQTY8kZQKTJJD1Cv0m0fdytMptTzssdGd6oTNqdzCa3+/SLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ocg/bHhn; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocg/bHhn"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f39438187so930700b3a.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 09:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770312889; cv=none;
        d=google.com; s=arc-20240605;
        b=IqNs4s/eUBpz4MF8vxowcRYKCyMGuoG2dPw306H7Oqvt3iJ1iqcALaX2IiVIzTm7xV
         jMppIY/6r2oZ4h7Dy4NiXnVJgUAedgN/x6AHqalPpoPmXvdZZINYdimKQ3q15DiVx8Tp
         PrBQomFcN5/fJpYVLDW5sfDltNcZumq0lva2j+3I2+elsVQUHTzb+WHdXcQCFzujZ84Q
         S7vEu43oGu6wes6a5NceHyr0JS9cndSUpQ0MnNowte7BHsSkiAIdZa7ZppUI+T9xv1+G
         CCBZkIMRob3QZT0DybTOIxbWltEqedSnPDT76TK+Kpd8lgdpNdirGiVCZBKYyPsBqd0+
         2PBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        fh=dAcXKjovvjNNEJA34k8gWhoDNnnUkzvvFxU/gaY7IDw=;
        b=geSkg3Zs9nXfwEe4aUFI7brC2ZStgBMU1///nPk1X186RbF0jQ4VFfVl4p3qVCTh7j
         PZeLWh3cUgAiRGHTJ3CQcQoByNBSmc5H3EIRGTjnXLs55ZNNgYVvhHk4/tW9Ze1TJPaR
         DH/u06bNwfaK+upqTzbHN/VLqnBPqalPwL+0Bh9K8SxTDevdw3GYkaZnCO0+ZVdjNJn+
         9pDM3fBDFjLPJSN+Ecv09Ld7V0IaGht80OQZtyWP4skcSJ/bleWUG9HQa+Tzoa6VYcnR
         Ax05VL7fXHTYi/6x5M6cI0VSTa2wQKNYowzF5DneUDxAlSLczh7B5tZuYoRMEdQLCFvB
         ggBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770312889; x=1770917689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        b=Ocg/bHhnoKTo4P3gVzeFf69ZOhmtx+AXD3Iwqfsk37JgRt84jBKdelAR9lbysPj6e6
         ALrneHaD64/fXASv0+DvapeaMEFC5sPDNf7C7O65XqPOJrrSLiBJNaCei1WrdeEFVPyI
         rQg69M4CJjt8Xd4M57u4p/cGXvh/tAERcBjoiznAWWlqJDWX3PZGH83H/NsG+TuASsd2
         qsA37caEOvkjmJ+uou9sB73EeSr+GkSap4JY8E8y2CRgEKoYLH2AJl22v5PXcqpIgYip
         I9gQQkeX6pM8xs+9wStwQo5tPthh9SruPoJrdgGH8jcpe21TyEf0aiTA9VJzgXzgHSXn
         wK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770312889; x=1770917689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tUGmD83/1M22wWiyFrGsa2SWt3EM/PQmAOxBE61Ssdw=;
        b=Kij3J48/6yMp2s6oQnHurATwzwmc1zxeu8isOztIxRsKbBCHwjAeUM0h3QRoOBWkcJ
         hDn/ZFFv6b9trnQHyxuA9tq0ZcJKTPfijQXuAc25WQacvGd2ixsli0ABSPa7SHkieNED
         jJPl1LKcFnCsCTHR6mT7jAzEWMRXOhIeIgoLePX03NVPZbIsTbMyW1HWyo9tqYCHsOP9
         aJQtxu2EjT81ucf9RPvLlSNEAfnVCBei4OT/HNFTX/HiDWJOoI2xXYpnIz5fvp3Awvfh
         WvLy8ciVE7UCTWmOL/hH4bDOAEOOyUQ4RWhpVwwaWhYo16fyQ81okIyQ7v74bs4w3i77
         Pb4g==
X-Forwarded-Encrypted: i=1; AJvYcCVc6vyW9yxRa+NFkO6c8zdMj1JAyIqir9EW71Qu9SkDTvaJZMnV86FioNPEzVOzH1MMMRxjXGFuDX1QdN/e2eNw@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp5W6ilUOP6dTzpJKbfs27xSq40h3Q2wBvpds9v6pvg4bVRBYt
	r3u1MiTNAWUx2/80ZfNgYsclR97DZucFr9D6NS97/o3QyL0cYe6BlNFMdbGLmdHW1uN9Zw5Jr7I
	GXddVc3/ITfeFLgVF4ttQkY8jYT26M2Q=
X-Gm-Gg: AZuq6aJbh5A+iG0q5VW9r1yN73WsqhSSwtTZc3WUwGkW8LDHEUHXu9BqcKCAp8dUs2O
	KW23iq/apuMQcajEyF7wlBHJqE3b2ko4jmqIOCrBxcXDHze2gYjzMiNUc17djgDk1P1X5O4TV1u
	8BdcrDlYdDIrFYVHeJmDYl2RP1K3X9TF7vRDpSm9ugbP+c2bpOj+Htb4kGl+9jjp+fGjE+oXyiW
	aH4nbsKpud5alJRwkfRQfU/dY615c6BVM6ke1uTeA1Ptx6SLmrlwuAOhHrLiefcZAcQf6kmWgx/
	kNTd0wTdgo4=
X-Received: by 2002:a05:6a20:ce47:b0:366:14af:9bbb with SMTP id
 adf61e73a8af0-393ad3a3e2cmr116924637.69.1770312889503; Thu, 05 Feb 2026
 09:34:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126074331.815684-1-chen.dylane@linux.dev>
 <20260126074331.815684-3-chen.dylane@linux.dev> <CAEf4BzYMJfQN+0SwzBM-DhREHwZ54TwA6GUtFv9=xret9pzXrQ@mail.gmail.com>
 <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
In-Reply-To: <bb62bd4f-199e-4907-817f-bc820c9198c9@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 09:34:35 -0800
X-Gm-Features: AZwV_Qj3jY8w4GJmu6lbjxat_AMSsnStGDk7UPuuWob8Qge5D8J9zZs3xeUra9A
Message-ID: <CAEf4BzZun3amXMpYdBPEy=qZwrY3ZjrKf_qc6tG-b4NJ=-AC7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/3] perf: Refactor get_perf_callchain
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

On Wed, Feb 4, 2026 at 10:16=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2026/2/4 09:08, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Sun, Jan 25, 2026 at 11:45=E2=80=AFPM Tao Chen <chen.dylane@linux.de=
v> wrote:
> >>
> >>  From BPF stack map, we want to ensure that the callchain buffer
> >> will not be overwritten by other preemptive tasks and we also aim
> >> to reduce the preempt disable interval, Based on the suggestions from =
Peter
> >> and Andrrii, export new API __get_perf_callchain and the usage scenari=
os
> >> are as follows from BPF side:
> >>
> >> preempt_disable()
> >> entry =3D get_callchain_entry()
> >> preempt_enable()
> >> __get_perf_callchain(entry)
> >> put_callchain_entry(entry)
> >>
> >> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   include/linux/perf_event.h |  5 +++++
> >>   kernel/events/callchain.c  | 34 ++++++++++++++++++++++------------
> >>   2 files changed, 27 insertions(+), 12 deletions(-)
> >>
> >
> > Looking at the whole __bpf_get_stack() logic again, why didn't we just
> > do something like this:
> >
> > diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> > index da3d328f5c15..80364561611c 100644
> > --- a/kernel/bpf/stackmap.c
> > +++ b/kernel/bpf/stackmap.c
> > @@ -460,8 +460,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >
> >          max_depth =3D stack_map_calculate_max_depth(size, elem_size, f=
lags);
> >
> > -       if (may_fault)
> > -               rcu_read_lock(); /* need RCU for perf's callchain below=
 */
> > +       if (!trace_in)
> > +               preempt_disable();
> >
> >          if (trace_in) {
> >                  trace =3D trace_in;
> > @@ -474,8 +474,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >          }
> >
> >          if (unlikely(!trace) || trace->nr < skip) {
> > -               if (may_fault)
> > -                       rcu_read_unlock();
> > +               if (!trace_in)
> > +                       preempt_enable();
> >                  goto err_fault;
> >          }
> >
> > @@ -494,8 +494,8 @@ static long __bpf_get_stack(struct pt_regs *regs,
> > struct task_struct *task,
> >          }
> >
> >          /* trace/ips should not be dereferenced after this point */
> > -       if (may_fault)
> > -               rcu_read_unlock();
> > +       if (!trace_in)
> > +               preempt_enable();
> >
> >          if (user_build_id)
> >                  stack_map_get_build_id_offset(buf, trace_nr, user, may=
_fault);
> >
> >
> > ?
> >
> > Build ID parsing is happening after we copied data from perf's
> > callchain_entry into user-provided memory, so raw callchain retrieval
> > can be done with preemption disabled, as it's supposed to be brief.
> > Build ID parsing part which indeed might fault and be much slower will
> > be done well after that (we even have a comment there saying that
> > trace/ips should not be touched).
> >
> > Am I missing something?
>
> Yes it looks good for bpf_get_stack, and I also proposed a similar
> change previously. But Alexei suggested that we should reduce the
> preemption-disabled section protected in bpf_get_stackid if we do like
> bpf_get_stack. Maybe we can change it first for bpf_get_stack?
>
> https://lore.kernel.org/bpf/20250922075333.1452803-1-chen.dylane@linux.de=
v/

This is broken because we are still using trace after you re-enabled
preemption. We need to keep preemption disabled until we copy captured
stack trace data from ips into our own memory.

>
> >
> > [...]
>
>
> --
> Best Regards
> Tao Chen
