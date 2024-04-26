Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A9B66F
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714156929; cv=none; b=DMdVJU6p+fBlpiAzT5V8RX2bk5PdHfoX2RDkl86pgjTOZRw9ZylbtWtSPFqxlQ7j94l9M8LK3glweuwAX+mAObmJHT8TgXRIxou/xO1X5tgBeqfCL/ioL7nj/Q8TfBXQ+fx3to20+g9niEvh0vBLyetxBwnYJWHei/tMFeG6z/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714156929; c=relaxed/simple;
	bh=sG5qnkmZBjvBpmrrSPLxvh01XxVFW/9tWEixBSmePJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bq7dL0Gwxo0Ve8POJKRC+JHQY4lW53o4uLlC3t/tDbka0YhlslD0hn+rBNaIEmMEZWy/Nlu5e/Fvb2ViO38uTeIWvE2X0vD5sGiS88cjsB8bwrKQhzQkIRgSB+FGDkdX7zfPzHaLBk7aI5QbqXEpXlpA6o8Bxuau3bwXeJF97gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZkN3G+Pm; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZkN3G+Pm"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5883518135so287684566b.3
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Apr 2024 11:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714156926; x=1714761726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPC2khkcYxlGp6+nXgi+0cY0URl01okY5IdzxMnpV3s=;
        b=ZkN3G+PmlRtvCeQS4S4dvVoaFJMY78HA3sKx3IxaClLrihtigbaQv6IcSt2U88DSWe
         mDRwpruwfxSi62cKcfJ/VZKc4rnvWHa1vIFKhkX/LhAtP+1Mm3wPYRl63RJ0yDIF3zB7
         TpqIUx8o/H+wC+uLOc29infhJ9hwpluboVpeVglvbmrPNX8NccnWbzlj4EHKfKQ+0sGv
         Qx0eKDiG8Z48h3TuL4CFJawKaSChYxgFyc8V723W9opfsEkwWyj5FRX4H2ou/0Bhy/a5
         oeNiSYkfrOOzd+5RURZshpB7jQpt1BoKAYDfHVFwpseah6Nd1odHvJgr6d1U5ph3dRe2
         xZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714156926; x=1714761726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPC2khkcYxlGp6+nXgi+0cY0URl01okY5IdzxMnpV3s=;
        b=aK/B2k5GH3TtIfEtAa8Ab5TFvT/GavKn+Ly4fiusrhXLB2MfMfYop/tT36IFuHEHjM
         j0wIwu9+x0Z+2lXoJJMgc9pg3SDT6PE9OJaOY0z4mE5VWzVocSOjc7rIa9ZieBZoZwSx
         yEyw8BvwWskw1C/hJNXESYXOkHQQmdfaOKaYzv8RlXMfoG7Vsp1/FGL/o8J9MmecqKkj
         Ors+d+r1jZxAV/yNYHg981R1pawrOW7YFuI1+ofHGXqZFYLUBG125rocKl8jNOhAMvZX
         XH3xK3jmMPuqh/3087cJkrsLIMA4WG4YkKwy/m5Mgj10DoRvD59EADEZNquUt+cOX0/d
         iJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb6n6M8pbwzRZZR2l4sbr7TL+rqsikC7n5LyKV/8F661MQlpUbQfqfwGiN5Cjn8icUzn46wZrp5YmVRO6s4RGR98PR+pQYNsRq5gR5nd2A/g==
X-Gm-Message-State: AOJu0Yz6gQAHIcK1q8nC6KwGQeXa9m0O4qotGFWLFLwaIwhvHz35Do9p
	lSR5j0rXUUvmyktVBXoakRceSn3PHQ3YVpUsSfRDrtI4TOUp5gFF5oiGndJgLjM3vv9GtNoJgaH
	Sliky6NIJujExQbqe5SmCNpudkE9vElWFyW4k
X-Google-Smtp-Source: AGHT+IGZ+wQ5paiV+PWlGynymSUJhN54OEDKMuW96jm2acGfWWjiiR9n6TG7U0iEzwVBoqP8zvmsvmseAPIEyOKAROk=
X-Received: by 2002:a17:906:e21a:b0:a55:b27c:1299 with SMTP id
 gf26-20020a170906e21a00b00a55b27c1299mr239146ejb.70.1714156925318; Fri, 26
 Apr 2024 11:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL715WJK893gQd1m9CCAjz5OkxsRc5C4ZR7yJWJXbaGvCeZxQA@mail.gmail.com>
 <b3868bf5-4e16-3435-c807-f484821fccc6@loongson.cn> <CAL715W++maAt2Ujfvmu1pZKS4R5EmAPebTU_h9AB8aFbdLFrTQ@mail.gmail.com>
 <f843298c-db08-4fde-9887-13de18d960ac@linux.intel.com> <Zikeh2eGjwzDbytu@google.com>
 <7834a811-4764-42aa-8198-55c4556d947b@linux.intel.com> <CAL715WKh8VBJ-O50oqSnCqKPQo4Bor_aMnRZeS_TzJP3ja8-YQ@mail.gmail.com>
 <6af2da05-cb47-46f7-b129-08463bc9469b@linux.intel.com> <CAL715W+zeqKenPLP2Fm9u_BkGRKAk-mncsOxrg=EKs74qK5f1Q@mail.gmail.com>
 <42acf1fc-1603-4ac5-8a09-edae2d85963d@linux.intel.com> <ZirPGnSDUzD-iWwc@google.com>
 <77913327-2115-42b5-850a-04ef0581faa7@linux.intel.com> <CAL715WJCHJD_wcJ+r4TyWfvmk9uNT_kPy7Pt=CHkB-Sf0D4Rqw@mail.gmail.com>
 <ff4a4229-04ac-4cbf-8aea-c84ccfa96e0b@linux.intel.com>
In-Reply-To: <ff4a4229-04ac-4cbf-8aea-c84ccfa96e0b@linux.intel.com>
From: Mingwei Zhang <mizhang@google.com>
Date: Fri, 26 Apr 2024 11:41:28 -0700
Message-ID: <CAL715WJKL5__8RU0xxUf0HifNVQBDRODE54O2bwOx45w67TQTQ@mail.gmail.com>
Subject: Re: [RFC PATCH 23/41] KVM: x86/pmu: Implement the save/restore of PMU
 state for Intel CPU
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, Sean Christopherson <seanjc@google.com>, 
	maobibo <maobibo@loongson.cn>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, pbonzini@redhat.com, 
	peterz@infradead.org, kan.liang@intel.com, zhenyuw@linux.intel.com, 
	jmattson@google.com, kvm@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhiyuan.lv@intel.com, eranian@google.com, 
	irogers@google.com, samantha.alt@intel.com, like.xu.linux@gmail.com, 
	chao.gao@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 7:10=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-25 11:12 p.m., Mingwei Zhang wrote:
> >>>> the perf_guest_enter(). The stale information is saved in the KVM. P=
erf
> >>>> will schedule the event in the next perf_guest_exit(). KVM will not =
know it.
> >>> Ya, the creation of an event on a CPU that currently has guest PMU st=
ate loaded
> >>> is what I had in mind when I suggested a callback in my sketch:
> >>>
> >>>   :  D. Add a perf callback that is invoked from IRQ context when per=
f wants to
> >>>   :     configure a new PMU-based events, *before* actually programmi=
ng the MSRs,
> >>>   :     and have KVM's callback put the guest PMU state
> >>
> >> when host creates a perf event with exclude_guest attribute which is
> >> used to profile KVM/VMM user space, the vCPU process could work at thr=
ee
> >> places.
> >>
> >> 1. in guest state (non-root mode)
> >>
> >> 2. inside vcpu-loop
> >>
> >> 3. outside vcpu-loop
> >>
> >> Since the PMU state has already been switched to host state, we don't
> >> need to consider the case 3 and only care about cases 1 and 2.
> >>
> >> when host creates a perf event with exclude_guest attribute to profile
> >> KVM/VMM user space,  an IPI is triggered to enable the perf event
> >> eventually like the following code shows.
> >>
> >> event_function_call(event, __perf_event_enable, NULL);
> >>
> >> For case 1,  a vm-exit is triggered and KVM starts to process the
> >> vm-exit and then run IPI irq handler, exactly speaking
> >> __perf_event_enable() to enable the perf event.
> >>
> >> For case 2, the IPI irq handler would preempt the vcpu-loop and call
> >> __perf_event_enable() to enable the perf event.
> >>
> >> So IMO KVM just needs to provide a callback to switch guest/host PMU
> >> state, and __perf_event_enable() calls this callback before really
> >> touching PMU MSRs.
> > ok, in this case, do we still need KVM to query perf if there are
> > active exclude_guest events? yes? Because there is an ordering issue.
> > The above suggests that the host-level perf profiling comes when a VM
> > is already running, there is an IPI that can invoke the callback and
> > trigger preemption. In this case, KVM should switch the context from
> > guest to host. What if it is the other way around, ie., host-level
> > profiling runs first and then VM runs?
> >
> > In this case, just before entering the vcpu loop, kvm should check
> > whether there is an active host event and save that into a pmu data
> > structure.
>
> KVM doesn't need to save/restore the host state. Host perf has the
> information and will reload the values whenever the host events are
> rescheduled. But I think KVM should clear the registers used by the host
> to prevent the value leaks to the guest.

Right, KVM needs to know about the host state to optimize its own PMU
context switch. If the host is using a counter of index, say 1, then
KVM may not need to zap the value of counter #1, since perf side will
override it.

>
> > If none, do the context switch early (so that KVM saves a
> > huge amount of unnecessary PMU context switches in the future).
> > Otherwise, keep the host PMU context until vm-enter. At the time of
> > vm-exit, do the check again using the data stored in pmu structure. If
> > there is an active event do the context switch to the host PMU,
> > otherwise defer that until exiting the vcpu loop. Of course, in the
> > meantime, if there is any perf profiling started causing the IPI, the
> > irq handler calls the callback, preempting the guest PMU context. If
> > that happens, at the time of exiting the vcpu boundary, PMU context
> > switch is skipped since it is already done. Of course, note that the
> > irq could come at any time, so the PMU context switch in all 4
> > locations need to check the state flag (and skip the context switch if
> > needed).
> >
> > So this requires vcpu->pmu has two pieces of state information: 1) the
> > flag similar to TIF_NEED_FPU_LOAD; 2) host perf context info (phase #1
> > just a boolean; phase #2, bitmap of occupied counters).
> >
> > This is a non-trivial optimization on the PMU context switch. I am
> > thinking about splitting them into the following phases:
> >
> > 1) lazy PMU context switch, i.e., wait until the guest touches PMU MSR
> > for the 1st time.
> > 2) fast PMU context switch on KVM side, i.e., KVM checking event
> > selector value (enable/disable) and selectively switch PMU state
> > (reducing rd/wr msrs)
> > 3) dynamic PMU context boundary, ie., KVM can dynamically choose PMU
> > context switch boundary depending on existing active host-level
> > events.
> > 3.1) more accurate dynamic PMU context switch, ie., KVM checking
> > host-level counter position and further reduces the number of msr
> > accesses.
> > 4) guest PMU context preemption, i.e., any new host-level perf
> > profiling can immediately preempt the guest PMU in the vcpu loop
> > (instead of waiting for the next PMU context switch in KVM).
>
> I'm not quit sure about the 4.
> The new host-level perf must be an exclude_guest event. It should not be
> scheduled when a guest is using the PMU. Why do we want to preempt the
> guest PMU? The current implementation in perf doesn't schedule any
> exclude_guest events when a guest is running.

right. The grey area is the code within the KVM_RUN loop, but
_outside_ of the guest. This part of the code is on the "host" side.
However, for efficiency reasons, KVM defers the PMU context switch by
retaining the guest PMU MSR values within the loop. Optimization 4
allows the host side to immediately profiling this part instead of
waiting for vcpu to reach to PMU context switch locations. Doing so
will generate more accurate results.

Do we want to preempt that? I think it depends. For regular cloud
usage, we don't. But for any other usages where we want to prioritize
KVM/VMM profiling over guest vPMU, it is useful.

My current opinion is that optimization 4 is something nice to have.
But we should allow people to turn it off just like we could choose to
disable preempt kernel.

Thanks.
-Mingwei
>
> Thanks,
> Kan
