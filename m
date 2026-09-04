Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F733DDDCD
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511153; cv=pass; b=bAiyOZFgXR/7H2PcxXV0FoWFjA6vBBcaTku2na3nPgIWTxadwQvcBUOa3Qs1Ckr/x+aqrf3hWiuiMAQPmrb44pPNDTiVjSPP45+MOYlZnMpa66eD41zT4uwmL02SU15yN4Se5b/o2JwgKG6ZLj801hoV6a/2JVwdZRYRywyaxGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511153; c=relaxed/simple;
	bh=GQed7CqsS3QleH5pIiv9aPt0TZqyTnZ/ZD+IeeOLgiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXexwImc+2ngjecQQu68DRVW2f5I4eCs0iJpBc65bEGUwSECdOZ4zt1PHniIMga2CZE1GikzCkrdjri6Tu4ifZYr2Jwlck4YMtzIqC7X8yXxkykt8QRqxy7/jL8CbuyM/estoAJLoypsF5LEvhWiGwCQABsX/9IMWqU0W564R1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RmKf2yp3; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RmKf2yp3"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a68aaf4840so1700823a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Sep 2026 01:39:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511149; cv=none;
        d=google.com; s=arc-20260327;
        b=AupeBppqvd2Pc3cRFq/zLyh8eUZBphc/uTICfAhwF72DowiIRMhXf8zvy7TpfeBunV
         l5RbUSblIDOXDKNNkmWkNLEPY8RXDyWaosSabaIKj4P4n5Ztd6bqbh+1e+NN2FlnLHEb
         wpTphSt6XHlRO9JXohbAdFzFGh17U/w21o5YECBdb2aGO8zCrQfP8ItYyHW14NjxzQO5
         tLhvkkaHLUNvXtlsAZ7wa0tGc6g4CP8HGmK14xj5QMABgARgzqoeterLCmhq8ituAWlF
         imLBYhLcQ7bNx+Pp0CHcfxB5pUnQ9s7ITd7KUWZu3/Ki7eiU7TScChq3dK3GBl7+rEBJ
         zMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        fh=eUAkFs4WT4DateJwGvifGzrFZBeU31wQWVPJ3s684pU=;
        b=jr7YN+T/bgVcWoSJFlWkk9E92aEDOA7aPNiw0MqvEz5Iuid6RAx0WjzaExcfOT3E4e
         QnhM1sSCrhmdO0cj1H8sQ/MulQq1u9Ti8RMJ+dU9RQiIKO9Dve+LghmENDLXcEfo5brs
         5rMVA9CqBG6Apo6Tjw9um5npYyMHGGYRNy3tkZGX1oJYSOwVOnIY327dHDGhNIZ0Cr6R
         EEHwk+l6zGNpytJx00ZxV0mnT9jWhGXbn3FHJmsjasStxnzqDFk93Gt70w4w2vwwBfTE
         bF8q6mcH3uf+KtZZHhkiu76VIqXjbMPboqCxfEWtKW/vompCjYQcR1G7Y+F4y7XS2Kk4
         Gygw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788511149; x=1789115949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        b=RmKf2yp3kM3TGCNL70B+CFoWSkLrZ/6bTQo6acZBWz7A/Y1Opa0fZaheUQYgKVoZW9
         APqua+lscUkExQBSBnXffyVaHlExIX3cqQZuSOoetKattKeAVZXbeTOxOnKyBkFbBC9J
         fAun3Y+XDWI7jGZjOw41GTdmUDxRHCNUmN2ianVfzhf7wXO6uR8vvEkVorbBtP6MU1cy
         p9JCoUe8ZYIxe1ZKvEW92uDpFATNKelP8EE4uTKofgPJi95cf5jaZGvQqmOdlNRilT2p
         AQliYyjsMLELaJP65ZZ/kEFXiP3b8hiABdebzSGgxLU9KwZquA+37OW33wSrit5cyy2L
         HaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511149; x=1789115949;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EzvphpTn3Z6bxsTKUhE7ieqFjf3qSKtb7ZjdbCXHmpM=;
        b=BSlKLcVGMMdu5kxzcgC0imHbWIGHtB4+pi0sGnjk7x2AbWG31VYrqPCsDAwEF6eB+n
         LzIOvLq7iVJQW3HH3jy5xuT+MjGXQXE/z9ZSmgRJe1mDBfFCQOiX+E5nvqXRCxTCEXIX
         6m0MmaV1N8+lPDgDQm5NHQgLS6WdxypriyyYdYiWcpsPgN9oABl9EDSBhlw4QrLlJMIQ
         Wah/Omt9Bcqgr0IaShHCCQBYb7JFKIFt0n7WNoY97e9iIhoVRJ3xIkDo3zFx8CBgLG6+
         su7ppFCQNLH9Y+SAkV/UBpU7y7Fc3o8GUamHotUhfgbvE1QWUWbRaDPMfUXhtPM1zavl
         e/kg==
X-Forwarded-Encrypted: i=1; AKwUvBw0kRv5d4UtfClPXgYgcErKsvH931Ubw7FjOgqGu9DJrXBoHPlbJ9MkWj52K4kdbNzWDmW/lUXFJxHS2UR1QgPA@vger.kernel.org
X-Gm-Message-State: AFuF++kxXyXpYoYE7N250MsJMraTS6Nb16n5dnEMuOy8IBcgMAHDxZC0
	/tXPBaRiKzjDHnH0gqWCgvkBUXDQQlJxMc6gU2O/tP3MKYz0BH31k7cPBWM4c5+Bh0w5AoPSO6L
	+agc8lF2onpPkb4whwYwogwOTq1sSb/REmau0N/r+BQ==
X-Gm-Gg: AYBFou1rGW/Jn14yPVqZgAD2hqmXsOlXZLCu3D55v854aSOlyhIEMN4uDpZhvLXXmaa
	xGSF/nDDP1MZUvYxplB22DeAWwQpSfUIU2wdo2V1AxKNF6Q4XlW/osW4lFSaPNhAqEydoCrtZx3
	cuj9iZ4m27L2Q/D63HfOjmDzVTCWLNy5TkkuwPzooyj5UArA12IawHlIx1n7MvAHwsgglvqqIqR
	5wcMNG6tSt5+yFMFmBL1BfS1edmWDbip3bY6FYTnrmlQrtAkdZ8SPcEmTjJlwBRBBsWoIFMExpl
	aRxeCSk5dN4eXU+E15/hzvfrz/gboLYi16QMDaqSJfZA/9g=
X-Received: by 2002:a05:6402:424d:10b0:6a6:b9eb:e20 with SMTP id
 4fb4d7f45d1cf-6a6b9eb0f5cmr2529416a12.2.1788511149397; Fri, 04 Sep 2026
 01:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828085819.4076449-1-zong.li@sifive.com> <20260828085819.4076449-4-zong.li@sifive.com>
 <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com>
In-Reply-To: <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 4 Sep 2026 16:38:58 +0800
X-Gm-Features: AcwNN1WRMTwypdAaHYFPNb0pSuReY3IdEEBJ4QNibyPzSTaAHRt107IZJ6oSt6Y
Message-ID: <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 3/3] drivers/perf: riscv-iommu: protect shared
 state with a raw spinlock
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, guoren@kernel.org, 
	david.laight.linux@gmail.com, zhangzhanpeng.jasper@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:07=E2=80=AFPM Yicong Yang <yang.yicong@picoheart.c=
om> wrote:
>
> On 8/28/26 4:58 PM, Zong Li wrote:
> > Events are bound to one CPU and the interrupt is affine to it, so the
> > perf callbacks running with interrupts disabled would be enough to
> > exclude the handler.
> >
> > PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
> > IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while only
> > recording the request, and the move is applied in interrupt context upo=
n
> > the next device interrupt. Until then the interrupt is still routed to
> > the CPU IMSIC picked initially, so the first overflow interrupt can run
> > concurrently with the perf callbacks on the CPU the events are bound to=
.
> >
> > Take a raw spinlock, with interrupts disabled so that the handler can
> > never interrupt a holder on the same CPU, rather than depending on that
> > irqchip behaviour. It covers the state which is reachable from both
> > sides:
> >
> >  - IOCOUNTINH is read-modify-written by ->start()/->stop() and is saved
> >    and restored around the whole handler.
> >  - pmu->events[] is written by ->del() and read by the handler.
> >  - hw_perf_event::prev_count is updated by both.
> >
> > ->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
> > __riscv_iommu_pmu_stop() so the lock is taken once per callback.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
> >  1 file changed, 60 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_=
pmu.c
> > index f6acd56f2f61..ee2f6d1fbece 100644
> > --- a/drivers/perf/riscv_iommu_pmu.c
> > +++ b/drivers/perf/riscv_iommu_pmu.c
> > @@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
> >       u64 event_cntr_mask;
> >       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> >       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > +     raw_spinlock_t lock;
> >  };
> >
> >  #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pmu,=
 pmu))
> > @@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_even=
t *event)
> >       local64_add(delta, &event->count);
> >  }
> >
> > -static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +/* Called with pmu->lock held */
> > +static void __riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > @@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_eve=
nt *event, int flags)
> >       riscv_iommu_pmu_set_period(event);
> >       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> >       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > +}
> > +
> > +static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_start(event, flags);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>
> could use guard(raw_spinlock_irqsave)() to help handle the lock release.
>
> I'm considering if it'll better to use irq_work or function call to handl=
e the
> counts update from the interrupt handler, e.g. in the irq handler first c=
heck
> if current cpu is the pmu->on_cpu, if so update the counts, otherwise que=
ue
> the update work to pmu->on_cpu by irq work or smp_call_function_single_as=
ync.
> In this way we can use pmu's original synchronization mechanism without
> extra spin locks since the callbacks will always run and synchronized by
> the same cpu, and the shared interrupt doesn't matter at all.
>
> any thoughts on this?
>

Thank you for your suggestion. It really helped me re-think the impact
of IRQCHIP_MOVE_DEFERRED.

When an IRQ goes to the wrong CPU, handle_edge_irq() already changes
the affinity to the correct CPU via irq_ack at this time. Because of
this, we might only need a simple check at the beginning of the IRQ
handler. We can just check if the current CPU is the correct one. If
it is not, we can simply return and do nothing. Since PMIP is still
asserted, the IRQ will trigger again and go to the correct CPU.

I will drop this patch and make a new, simpler fix.

Thanks again for your help!

> thanks.
>
> >
> >       perf_event_update_userpage(event);
> >  }
> >
> > -static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +/* Called with pmu->lock held */
> > +static void __riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > @@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_even=
t *event, int flags)
> >       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> >  }
> >
> > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> > +{
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_stop(event, flags);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > +}
> > +
> >  static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> >       unsigned int num_counters =3D pmu->num_counters;
> > +     unsigned long irqflags;
> >       unsigned int idx;
> >
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +
> >       /* Reserve index zero for iohpmcycles */
> >       if (is_cycle_event(event->attr.config))
> >               idx =3D RISCV_IOMMU_HPM_CYCLE_IDX;
> > @@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event *=
event, int flags)
> >               idx =3D find_next_zero_bit(pmu->used_counters, num_counte=
rs, 1);
> >
> >       /* All event counters or cycle counter are in use */
> > -     if (idx =3D=3D num_counters || pmu->events[idx])
> > +     if (idx =3D=3D num_counters || pmu->events[idx]) {
> > +             raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >               return -EAGAIN;
> > +     }
> >
> >       set_bit(idx, pmu->used_counters);
> >
> > @@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event *e=
vent, int flags)
> >       local64_set(&hwc->prev_count, 0);
> >
> >       if (flags & PERF_EF_START)
> > -             riscv_iommu_pmu_start(event, flags);
> > +             __riscv_iommu_pmu_start(event, flags);
> > +
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> >       /* Propagate changes to the userspace mapping. */
> >       perf_event_update_userpage(event);
> > @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_event =
*event, int flags)
> >
> >  static void riscv_iommu_pmu_read(struct perf_event *event)
> >  {
> > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > +     unsigned long irqflags;
> > +
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> >       riscv_iommu_pmu_update(event);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >  }
> >
> >  static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> >       struct hw_perf_event *hwc =3D &event->hw;
> > +     unsigned long irqflags;
> >       int idx =3D hwc->idx;
> >
> > -     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +     __riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> >       pmu->events[idx] =3D NULL;
> >       clear_bit(idx, pmu->used_counters);
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> >       perf_event_update_userpage(event);
> >  }
> > @@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(in=
t irq, void *dev_id)
> >  {
> >       struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> >       DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> > +     unsigned long irqflags;
> >       u32 ovf, idx, inhibit;
> >
> > -     /* Check whether this interrupt is for PMU */
> > +     /*
> > +      * Check whether this interrupt is for PMU. Done outside the lock=
 so
> > +      * that a shared interrupt line is left alone as cheaply as possi=
ble.
> > +      */
> >       if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMM=
U_IPSR_PMIP))
> >               return IRQ_NONE;
> >
> > +     /*
> > +      * Hold the lock across the whole sequence below. Stopping the
> > +      * counters, processing them and restoring the previous inhibit s=
tate
> > +      * has to be atomic against ->start()/->stop(), otherwise a count=
er
> > +      * enabled in between would be inhibited again by the restore.
> > +      */
> > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > +
> >       /* Process PMU IRQ */
> >       inhibit =3D riscv_iommu_pmu_stop_all(pmu);
> >
> > @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int =
irq, void *dev_id)
> >
> >       riscv_iommu_pmu_start_all(pmu, inhibit);
> >
> > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > +
> >       return IRQ_HANDLED;
> >  }
> >
> > @@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary_d=
evice *auxdev,
> >
> >       iommu_pmu->reg =3D iommu_dev->reg;
> >
> > +     raw_spin_lock_init(&iommu_pmu->lock);
> > +
> >       /*
> >        * Counter number and width are hardware-implemented, detect them=
 by
> >        * writing 1s and reading back which bits stuck.
