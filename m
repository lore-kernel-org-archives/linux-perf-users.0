Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794062813;
	b=QI38ZZNNVzPDuIbMSfkQLIn5YywTwQs6b+9OPRiCHwaT6qlX8+fvQ4AWZIEYsw3mEhiJ
	 4ZYQXUtJXkh8aqKy2OsAuYA1SXrvnYbUSv1Z9fHARO5tdDDG6tTL/qJCSSsw41+d+zXLG
	 vKOsVdb6kV49dctSYwe4KESfULM3K2fEqGf3Cpa47Bw1qtp3dD75PLW6mTjK+hhcANJd0
	 5laOLeu5cxwr/0vXtHii+LY+AX6v2tZEVuDWNg/HMxcJmYq8bqXt7AZdlNNo5bidvrLpF
	 1klt4IxcKOJLHsqJAQ6LpwNhnqEqqwpeUk4Es3mViG6/9797fJm92sqIWSebYetCxhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
	b=ghutXmQgM7jlp1JUVC1odqDp0OoYohM4Hkvgh+EQ/SsTXpavkaN6r+BD9YAcuxBxskv9
	 SIotrsK1WFn0gf6FG/N9m16jqNSRo33KyDhtl7q+1pduFDw9fN0O8HvLzRNn5LLQPXmci
	 RuC6oSzSObMWJhEvtU6orTpAY8gxZqfgpBDMepAp/Kbe3TU67vnvlTJyNaxcwNu/+RNxL
	 IAPRpDhMm3btxccvG2wJ3arJOzttr921CqFIIiKq996F1y3oleIDcn5pVQrhAXrbNxZaE
	 t79e6FOT97a2oX2W3baFZNbmElcZmX1mZVq5xZycp29W56jrhJa3Jp4odf0M3pB9cuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sifive.com;
	spf=pass smtp.mailfrom=sifive.com;
	dkim=pass header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=B3Pl9onQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29FA606D805
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 14:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C29FA606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=B3Pl9onQ
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b704171bc9so293312a12.0
        for <linux-perf-users@vger.kernel.org>; Sat, 07 Nov 2026 06:46:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794062811; cv=none;
        d=google.com; s=arc-20260327;
        b=kFEAeJm/souzhnnEOZ+T4xcW8jroZsZVgocxspayRdTAa2W832O4FOxNlbwiFbEQ/I
         zmYN4/2YNGJQk6yQanGi37klqo4LuXmuzVlRT+/5nVeU/rVwy+0atQjTJno+ofqLM7bs
         +T1kDk72f2WPfUyyGBwLrdihURgYWWrwlYzFHo8xIg+Sxd8I6c+b84O6KoUoOic1hpmD
         c73vxOOZ1TMrgR2Xe4aXz7LjaWJXqcxfVRpfFGtQ1OxEqEP6JLZgweRoZqKFHN3Hj5Ub
         6LcPEUMYR3Shumc1Gl3YHQpjqvbS8TcRXxZxcIwDWCKgwYnuOAlCgA/mvov7vSyEOCZA
         XETQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        fh=0dSZ8Bt0T3blCZto972oik0eLdffieo6lIA1INzdF/c=;
        b=nB67LMZBPaXHlJLEK5T8pqrko9wPI9W7p2wiEC1ZfBnLBtMgLwoCWKMOpk76R3Nseu
         ykrYXuoRq9wd/AqEmyHfMz/RZfNEDcv0DojtBWoAWXaxuOvM22P7FPPMAL7xfnv0HMRW
         MOfT4pnt3n7LdrM9I3+qX7LCorJmAA2ww/1VNZauPX2KdFDtoSucFMCeJDJW5oyt6zXi
         sXdtBcKOmkozS9TlMwsuef4X+uAr4chxNOk8pSAxDH7G2lEhUSlrXbTsG+6MA+BuYOlL
         uDDj6lHVMzZ04GuwrO3t/6531JrCRv/ugNym5ws+iyCa6g+PGapjGVn2xb+l8N8vh+gm
         Tl7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1794062811; x=1794667611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        b=B3Pl9onQPa2k0fPvoGDNTc5+wn0COtvE1KZZJyTNbBcq6ZUOnhIPXzx/fGjsd/2h5S
         DOjc8G0ByGgogim9cIZ4tehp331i45spbgoJ7Vs0p3YWICSGoAusVfAVLMfSZdOmEOLq
         Wj6tH6NWk8Ccoz4S4z7tUoNMmPX+QWHSmWedauVGCFovQbx0qgodto99OXQ7cnb22qd+
         QpXq1NjNOqbl2GsRtxtBJUYx7ipO+GsCVaFNi15ddtE+zCaTR5mrChdiUUdOM1XJ/P9J
         KWRIFMKfhFf1XXXZxxAlu+JHJmB01cSFq78lCTt366pPgl/6lNPbBGBmnHC/WSYZFrOV
         TQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062811; x=1794667611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pxitTAYlT4aTP/HIST+A7fiKG52u+ZyWvKldQ+tSMQk=;
        b=j8Hd8/gDdC5AXvAvecXaOmETK8kQMpl6t0w7NE+ZXjNYa5julOdhDo+Y2sYp9mYlRb
         +qQE3SbhjG8WrPnEJKadLxSkDqmV7hIs2OZvfk0mKYru/SNGynOt+q49rdOEX2EB+51B
         wK1X+tQFVqQ9Mu1tI+coxsxWwNjQoQlq3+3tyWYhR5VkrmocEEnb0nC8TD+cQUCx+S2W
         39Pvyor9uGFWXxDgP54GDu9MOD+Y98P+biHcxzYBAzTdJpQoPoPn0nTGoJ8NRTXSA8YF
         znVX08w+EMesK/p6k9pJyCPhmEIHxHg+8ZRXox65KyT7KQfnm0SEdupK4gok9YD0GFH8
         dKug==
X-Forwarded-Encrypted: i=1; AL+hErE9QmTGnW2j/xvU4z19JZawN6Ct684L7f1TvT68ZyrLDL27Z81w4HO5TgeIwywNSoMwmQbibjqOE0diVucknL6t@vger.kernel.org
X-Gm-Message-State: APuU4Z8E75kjLD+gcg0rMF5mcFvrotcYOxJ+pJw3D1tPrcfQoewu20gf
	wIbCuu7AVUhD0D7TMDXsTRP2PvnTK2WjrpbKmvyY3pQACynMZ8geW4KpDwYOAnJMpJYYt5EPdac
	0VyVCaHjtbmQH2lsMV0LLA3kwOtGsNzE30ZKNkUn72A==
X-Gm-Gg: AYBFou2ZXkc4cz0z8DrYHGGCaHQtlVX7HI0l5Z3uF61msR/ogBlPldQcsFqJfGvsr4f
	9ZkMmU/IiqyaPjq0jBOtidUPF9LVo+RdonTH+Yzh7H1qgoqZUBLTkzzkRPe2UMs1B29iq3Jz82E
	2TeGetekrOZYZ42MyGosc7X7EmpKJJfndsqmk46nZYU/XbC2iJfge4B6Z7XOq4lcsZNpuhfgChW
	KvYKXrMS9V81Uir1/y1j7yxIYuKoHK8X5MfZatDBJ4A14wNQd9nWJsn4Q5NjKFdcGRLJMqqJNiW
	l0hX3Gd1TeSMyPrn71lGx0DqvRXRm3NbQlT5lVhmzZ5TN3lnBYjmkW/pJFCIBtw/8tlFvwjoe9t
	cRSvro7QfO4AMYspHQ5LR/jSmg0ljoqURYiSgtgc=
X-Received: by 2002:a05:6402:d05:b0:6b5:9156:4e9b with SMTP id
 4fb4d7f45d1cf-6b5977a301emr3803850a12.8.1794062811145; Sat, 07 Nov 2026
 06:46:51 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261006090327.309550-1-zong.li@sifive.com> <CANXhq0qPxywpTmw=mAspYgfXivAyyoBN-r8iPpwYVXmJ3AmXyQ@mail.gmail.com>
 <7f7a6f3a-de8b-4ca2-8fc7-ea7586cbb270@picoheart.com>
In-Reply-To: <7f7a6f3a-de8b-4ca2-8fc7-ea7586cbb270@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Sat, 7 Nov 2026 22:46:37 +0800
X-Gm-Features: AclHuK8qfSlihFNyI0xS7KkPURkTjEgxqr80EjCjuJaTqfla2V-ZszF9QGRBUYA
Message-ID: <CANXhq0oMmqeDkMLu1L7+vBGXQ+_N2ANfBV9EbbQ+19BGiBR8OA@mail.gmail.com>
Subject: Re: [PATCH v16 0/2] RISC-V IOMMU HPM support
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	nutty.liu@hotmail.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 8:37=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> On 10/7/26 3:30 PM, Zong Li wrote:
> > On Tue, Oct 6, 2026 at 5:03=E2=80=AFPM Zong Li <zong.li@sifive.com> wro=
te:
> >>
> >> This series implements support for the RISC-V IOMMU hardware performan=
ce
> >> monitor.
> >>
> >> The RISC-V IOMMU PMU driver is implemented as an auxiliary device driv=
er
> >> created by the parent RISC-V IOMMU driver. Therefore, the child driver
> >> can obtain resources and information from the parent device, such as
> >> the MMIO base address and IRQ number.
> >>
> >> It seems sashiko-bot is giving conflicting advice about whether to add
> >> a lock to ->read(). No matter if we add it or not, the sashiko-bot alw=
ays
> >> suggests the opposite. Looking at no lock case again, sashiko-bot
> >> concerns about a BPF program calling bpf_perf_event_read() from NMI
> >> context and self-deadlocking against the IRQ handler, but that scenari=
o
> >> cannot occur here:
> >>
> >>   - bpf_perf_event_read() goes through perf_event_read_local(), which
> >>     refuses to call ->read() unless event_cpu =3D=3D smp_processor_id(=
)
> >>     (kernel/events/core.c). All events on this PMU are CPU-bound and
> >>     non-task-bound (->event_init() forces event->cpu =3D pmu->on_cpu a=
nd
> >>     rejects sampling events), so PERF_ATTACH_TASK is never set.
> >>   - More fundamentally, perf overflow interrupts are not NMIs on RISC-=
V,
> >>     and every pmu->lock critical section in this driver is held under
> >>     raw_spin_lock_irqsave(). There is no context that can interrupt th=
em
> >>     and re-enter ->read().
> >>
> >> No other driver under drivers/perf/ uses a trylock or in_nmi() check i=
n
> >> its ->read() callback, so dropping it also brings this driver in line
> >> with the rest.
> >>
> >> sashiko-bot also reported that migration calling trigger a NULL pointe=
r
> >> dereference. I don't think this can happen on current mainline.
> >> perf_pmu_migrate_context() does not touch pmu->cpu_pmu_context unless =
it
> >> actually finds events to migrate. This used to be a real hazard: befor=
e
> >> commit bd2756811766 ("perf: Rewrite core context handling", v6.2-rc1)
> >> the first two lines were per_cpu_ptr(pmu->pmu_cpu_context, ...), which
> >> did dereference a pmu-owned pointer unconditionally. That is also why
> >> several in-tree drivers pre-seed thier ->cpu field with a real CPU num=
ber
> >> rather than a sentinel, and so do call perf_pmu_migrate_context() in
> >> this window, without any reported oops.
> >>
>
> [...]
>
> >
> > Hi all
> >
> > In the v16, sashiko-bot suggested to add a pmu->lock in ->read()
> > again, let me address this, and explain why I would prefer to leave it
> > as a documented limitation in this series rather than respin.
> >
> > What I would like to push back on is the suggested fix, because every
> > point fix in this area has already been reviewed and rejected in an
> > earlier round of this series:
> >
> >   - Taking pmu->lock in ->read() (which is literally the diff
> > suggested here) was in v7-resend. It was rejected: a BPF program
> > reading an IOMMU PMU event from NMI context via bpf_perf_event_read()
> > invokes pmu->read(), and if that NMI lands on a CPU already holding
> > pmu->lock in the IRQ handler or in ->add(), the read callback spins
> > forever.
> >   - raw_spin_trylock_irqsave() in ->read() was the v13 answer to that.
> > It was rejected in v14: on cross-CPU contention the trylock fails,
> > ->read() returns without updating, and userspace silently gets a stale
> > count.
> >   - The current lockless form is what v15 and v16 are objecting to.
> >
> > So the three obvious shapes for ->read() have each been rejected, in
> > each case for a valid reason. That is a strong hint that ->read() is
> > the wrong place to fix this: the actual root cause is that the
> > overflow handler may run off the bound CPU at all.
> >
> > Worth noting that no PMU driver under drivers/perf/ (including all the
> > hisilicon ones) or arch/x86/events/intel/uncore.c takes a spinlock in
> > its ->read() callback -- not even on x86, which does have NMI-context
> > perf events. They don't need to, because they pin the overflow
> > interrupt to on_cpu with irq_set_affinity(), so the handler and the
> > perf callbacks all run on the same CPU, and ->read() is already
> > invoked there with interrupts disabled (smp_call_function_single()
> > from perf_event_read(), or the event_cpu =3D=3D smp_processor_id() chec=
k
> > in perf_event_read_local()). Same-CPU plus interrupts-disabled is the
> > entire synchronisation mechanism, and it is why the
> > prev_count/hardware pair cannot be observed half-updated.
>
> that's how the event core's synchronization is designed and expect the
> PMU drivers to follow. so the race is true if pmu::read() is not protecte=
d
> in the current implementation.
> >
> > RISC-V IOMMU PMU driver does the same irq_set_affinity() call, but on
> > IMSIC the move can be deferred, so the guarantee is weaker. Hence the
> > race. On the scope of the impact, to explain why I think this can
> > wait:
> >   - The consequence is confined to a reported count. prev_count and
> > event->count are local64_t and the cmpxchg cannot tear, so there is no
> > memory-safety issue, no oops, and no effect on IOMMU operation itself.
> >   - The window requires an affinity change to be in flight.
> > riscv_iommu_pmu_bind_cpu() is only called from the CPU hotplug online
> > and offline callbacks, so a deferred move is only pending during CPU
> > hotplug. In steady state the interrupt is already on on_cpu, ->read()
> > runs on that same CPU with interrupts disabled, and the window does
> > not exist. This is a transient during hotplug, not the common case.
>
> so the problematic part is that the counter update from the overflow
> interrupt is not guaranteed to run on the event->cpu for the first
> even if the affinity is set to event->cpu, due to IMSIC's affinity
> move deferral. this should only affect IOMMU implemented as PCIe
> device, not platform device with either wired interrupt or MSI.
>
> what was the problem of using irq work to queue the counter update
> on the event->cpu? I see it was removed in v10 due to IRQCHIP_MOVE_DEFERR=
ED
> which confused me. with irq work we can ensure the counter update
> on event->cpu no matter which cpu take the interrupt. was there
> other issues with the irq work?

Yes, as I mentioned at the end of the cover letter, I might prefer to
send a separate patch to address this issue. In that new patch, I am
trying to use irq_work to solve it. The main difference from the
irq_work implementation in v9 is that the previous approach was too
simplistic. The new patch will take more scenarios and corner cases
into consideration and address them properly.

>
> thanks.
>
> >
> > That is a structural change to the interrupt path with several
> > interacting constraints, each of which has already caused a regression
> > in this series once. I would rather not fold it into this series at
> > this point, both because it deserves review on its own and because
> > getting it wrong again in a hurry is worse than a documented
> > counter-accuracy limitation during hotplug. So my proposal is: leave
> > the code as-is for this series, add a comment on
> > riscv_iommu_pmu_read() recording the limitation and why the three
> > obvious fixes are not used, and address it in a follow-up patchset.
> >
> > Please let me know if you want me to do more for this series.
> > Thanks!
> >
> >> Zong Li (2):
> >>   drivers/perf: riscv-iommu: add risc-v iommu pmu driver
> >>   iommu/riscv: create a auxiliary device for HPM
> >>
> >>  drivers/iommu/riscv/Kconfig      |    1 +
> >>  drivers/iommu/riscv/iommu-bits.h |   61 --
> >>  drivers/iommu/riscv/iommu.c      |   58 ++
> >>  drivers/iommu/riscv/iommu.h      |    4 +
> >>  drivers/perf/Kconfig             |   12 +
> >>  drivers/perf/Makefile            |    1 +
> >>  drivers/perf/riscv_iommu_pmu.c   | 1102 +++++++++++++++++++++++++++++=
+
> >>  7 files changed, 1178 insertions(+), 61 deletions(-)
> >>  create mode 100644 drivers/perf/riscv_iommu_pmu.c
> >>
> >> --
> >> 2.43.7
> >>
