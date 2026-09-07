Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC282FB969
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 01:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746078; cv=pass; b=aCY4au/zl1WlXHF3hqk+vjaUtbZ7YCYexRYiG5JpnIeYxGyS40KpkVDaLriUCRahCxb/4BZmUk3Z2UBFlhR0bw2EPEVBZM3PnJixY8PLUxv2mEiHTKVNGC461RiEJyDyYZXNd5owAyQIkQVvCZCWn/Yt5qWZqsyA/JsaVfQBxHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746078; c=relaxed/simple;
	bh=HsGjhU3uBTpHPuq4JphTd+S+S3oIGE294X2u5LK4rnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpCFX0V8FEfFXMJFPMlnGAtMhp03Jaggy/y4D4xP/4oGskl13a2KCF1h2r4ocUXc1vED8W8E6zE5SAqY3883ohngAnSSoNYH4VpCTBMwqY8/B/kP1EKsVoS5kjh7loKdKkXr5o6UrbtqwnmOBuSzijKw5vJRiIe8JcYeRiBwv+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TXWFr3Va; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TXWFr3Va"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a668cacdadso4279937a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 06 Sep 2026 18:54:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788746072; cv=none;
        d=google.com; s=arc-20260327;
        b=Qfsa2Shv9jCZM3hrmstmGdtZaRgNPZa+gkg3La0ypmKz2zt4x3yqRt5xwoKTGIGxhI
         i3WRAPOUIAgte8afeSQPjcoZd4Rz8Ld11uTh1bJxDpXH7euG1kS8X4exPNBYCgTU3Evh
         V1wCl05XLkuWQ7Fr+vUSoa8R9r9iPW9I6ZdnF5pTSLw/EDEkWAzSw3c8XFN3bGJQcOF3
         JJPLyBsgT4AO3w3RRkdJc51ZpO0ziDlCV1pFNcbkIa2eyg587o6Fv66SRhhtaYbJZLjk
         B+GUgJ1ettJaOQUf7W9Jf9voUkPkMz6K6h+3lSsKcLEDe75gf5FhouNbvWJYCzZXY/43
         2uzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        fh=08V51gQhd7vuan5tfFa6+hUJ8biWrZVlWIZFZyX/vD8=;
        b=dG+edBg+ES+dlYNtSsBGzU8ChMNHz6BXgBJwjZlbVZA7IlCSqajpMRsxRPLN89Hrsn
         XeQE4KeBz/+9/d3HS8msSgQb6TkFMcirO49NTVu/8PxEeR+D7sil1HizKYBQD2/AlS7r
         OTClzvHo7ddXB7twtcY2dUDl7wLAmEUGDrYqziS8pMCcD7W7mK+od53eD768Nh4WaOyb
         MvZr2WBoW4qcGR0Qa/5F1Nl0v7gyEBIUOtJkQ5djwXtogH8PQAXbgvIA/g7KlJhDr1vU
         0rw9+ubCZtDmb78fXc7a/GRF2bG44fdKjY7eMTTdHdMrTe2j8VVV/cgPC3ZgM+wjtQxG
         T7Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1788746072; x=1789350872; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        b=TXWFr3VaUgZXPplnfCtqLkWPvV5u7MJO28UrUmN0patsFPjeKyNAgNM06S9Ky3dwSL
         UYSZr3ANyb8kjxYsBatZJNzxox6jpAPB/K/3ZH1HUNHsw0pGygOjyZ43/Svx8K5grVvm
         jK+xDwgBTMkcuKgpby7UF55WDrcAYNEJ6vm5ZX5yakd0uyIVfJWnVfIrUNK6MsdFhTNC
         N0BRbhoAMWyBdJkkSBZOozEwxezOMdj3hHMJBvHc6cnvQB1BIT9Bh1v0PBTUk97HtT9t
         ZIa/X4ekRrLU9arjbQ4FPXa+HCRqK+yi4RS/+BpCajWSnDw3tgcb4mGdQJZvhY2qLfdW
         7qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788746072; x=1789350872;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deuBYUmBSWla/VSTwOIDmtGNAoeBNifbTvyqlKPlcA0=;
        b=kCBc2+qllgxISUpsF7DJJ8gEhkcJpvQIVBt9GaZis93SxGxkSBYCVQ6XRa0FYfpoVq
         hUJoTe4YWE8Fsewl5hrat6zp1rTuWE40x63BcSz0kQmqSnAWQlsh6Bx3M7dp1YZ8gedv
         DV7zPdckqFzQQfmCThhCjBWvD5zSeLioE4tMnSAF2HH93JQM7HY/w/FuJexwTGfR0icP
         goyTI777UlURYE+vm4P9s1IZqRGC6ICVmvuaVeJaZ6ksBWYPmy8FlBZFnN53P2uIImo5
         sOjsW0Oo97hA0wAdE0swnHQX2BcaCKr0jHKv3gPDgV/q8TuR40v9eVWIOY8nl8ZaoYAO
         5eWw==
X-Forwarded-Encrypted: i=1; AKwUvBw6A+9fmVbDEBoxCGnLCRc79ZFg7oclkGeaSdk92D3LvQ6oxoczU/fGSbPQ7nmQSxizLVDJQhpBQ7PxgLwKMZsY@vger.kernel.org
X-Gm-Message-State: AFuF++n3dRsN5O6iIIixAe2MU+AGmIzbLXL/cF0wLd/wcNMPeIHqHg5B
	y7G91K6GcPbk4OhqVqQTe1n8gZKEn+JZSA/su8KuKjefSsmCwXRfFLJbO9n1KwSYyMLwkVSGNbn
	HXTnYhTkSvsgq54POsC0TRnxn3jcjPA618K8O+Z1TnA==
X-Gm-Gg: AYBFou3LeRAXbeDGpgeZKHukNdo9srTb6oT9PNPwg57q5BKqkagWNaLRh1C38oygyk4
	GnQLhgUjjQ1NmGoJYCHif5eFkoX5D2GQXqWONCM2n/jg2EyblKz/Bbs5oLwGNmhc9yKmtjt/7iZ
	j0UQI1+QgfKMjnvOmzrQwr8/uJ807TvMrKXIBRGOyktkrO0pjCHy4mQZJ8I795e1eBvULcXcwOv
	PUkwuVndguRy1XFvRWlKD70d7XF+BLN0A3k3WvT7ZrXbdVfcLuRtMpD0N4lksva0o9uFS29yRg8
	uprBEcPkp4RfSR1mbvnAkaG5/1gcxXWMn77samM5OVVRHyk=
X-Received: by 2002:a05:6402:305c:10b0:6a7:ea54:399 with SMTP id
 4fb4d7f45d1cf-6a7ea5426d4mr4258443a12.42.1788746072194; Sun, 06 Sep 2026
 18:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828085819.4076449-1-zong.li@sifive.com> <20260828085819.4076449-4-zong.li@sifive.com>
 <8267ee7a-98b7-42a5-b479-648d2bec8ade@picoheart.com> <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
In-Reply-To: <CANXhq0ogpMSEdjycnz0HCO15q_gYA1hwFU98u09tYL0X8PMtoA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 7 Sep 2026 09:54:19 +0800
X-Gm-Features: AcwNN1UqYHffd6ZBPh96YDoJNjnRCCNlysDBXVVYQF3Pt6h68uGWSGmk51VjT04
Message-ID: <CANXhq0oBHPFAmANKyt91mKn7_cm2bfZYpcMyO47==GA_WD6fQQ@mail.gmail.com>
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

On Fri, Sep 4, 2026 at 4:38=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Wed, Sep 2, 2026 at 4:07=E2=80=AFPM Yicong Yang <yang.yicong@picoheart=
.com> wrote:
> >
> > On 8/28/26 4:58 PM, Zong Li wrote:
> > > Events are bound to one CPU and the interrupt is affine to it, so the
> > > perf callbacks running with interrupts disabled would be enough to
> > > exclude the handler.
> > >
> > > PCI MSI/MSI-X on IMSIC breaks that: the irqchip sets
> > > IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports success while on=
ly
> > > recording the request, and the move is applied in interrupt context u=
pon
> > > the next device interrupt. Until then the interrupt is still routed t=
o
> > > the CPU IMSIC picked initially, so the first overflow interrupt can r=
un
> > > concurrently with the perf callbacks on the CPU the events are bound =
to.
> > >
> > > Take a raw spinlock, with interrupts disabled so that the handler can
> > > never interrupt a holder on the same CPU, rather than depending on th=
at
> > > irqchip behaviour. It covers the state which is reachable from both
> > > sides:
> > >
> > >  - IOCOUNTINH is read-modify-written by ->start()/->stop() and is sav=
ed
> > >    and restored around the whole handler.
> > >  - pmu->events[] is written by ->del() and read by the handler.
> > >  - hw_perf_event::prev_count is updated by both.
> > >
> > > ->add() and ->del() call the unlocked __riscv_iommu_pmu_start() and
> > > __riscv_iommu_pmu_stop() so the lock is taken once per callback.
> > >
> > > Signed-off-by: Zong Li <zong.li@sifive.com>
> > > ---
> > >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++--=
--
> > >  1 file changed, 60 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iomm=
u_pmu.c
> > > index f6acd56f2f61..ee2f6d1fbece 100644
> > > --- a/drivers/perf/riscv_iommu_pmu.c
> > > +++ b/drivers/perf/riscv_iommu_pmu.c
> > > @@ -101,6 +101,7 @@ struct riscv_iommu_pmu {
> > >       u64 event_cntr_mask;
> > >       struct perf_event *events[RISCV_IOMMU_HPM_COUNTER_NUM];
> > >       DECLARE_BITMAP(used_counters, RISCV_IOMMU_HPM_COUNTER_NUM);
> > > +     raw_spinlock_t lock;
> > >  };
> > >
> > >  #define to_riscv_iommu_pmu(p) (container_of(p, struct riscv_iommu_pm=
u, pmu))
> > > @@ -485,7 +486,8 @@ static void riscv_iommu_pmu_update(struct perf_ev=
ent *event)
> > >       local64_add(delta, &event->count);
> > >  }
> > >
> > > -static void riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> > > +/* Called with pmu->lock held */
> > > +static void __riscv_iommu_pmu_start(struct perf_event *event, int fl=
ags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > @@ -500,11 +502,22 @@ static void riscv_iommu_pmu_start(struct perf_e=
vent *event, int flags)
> > >       riscv_iommu_pmu_set_period(event);
> > >       riscv_iommu_pmu_set_event(pmu, hwc->idx, hwc->config);
> > >       riscv_iommu_pmu_enable_counter(pmu, hwc->idx);
> > > +}
> > > +
> > > +static void riscv_iommu_pmu_start(struct perf_event *event, int flag=
s)
> > > +{
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_start(event, flags);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> >
> > could use guard(raw_spinlock_irqsave)() to help handle the lock release=
.
> >
> > I'm considering if it'll better to use irq_work or function call to han=
dle the
> > counts update from the interrupt handler, e.g. in the irq handler first=
 check
> > if current cpu is the pmu->on_cpu, if so update the counts, otherwise q=
ueue
> > the update work to pmu->on_cpu by irq work or smp_call_function_single_=
async.
> > In this way we can use pmu's original synchronization mechanism without
> > extra spin locks since the callbacks will always run and synchronized b=
y
> > the same cpu, and the shared interrupt doesn't matter at all.
> >
> > any thoughts on this?
> >
>
> Thank you for your suggestion. It really helped me re-think the impact
> of IRQCHIP_MOVE_DEFERRED.
>
> When an IRQ goes to the wrong CPU, handle_edge_irq() already changes
> the affinity to the correct CPU via irq_ack at this time. Because of
> this, we might only need a simple check at the beginning of the IRQ
> handler. We can just check if the current CPU is the correct one. If
> it is not, we can simply return and do nothing. Since PMIP is still
> asserted, the IRQ will trigger again and go to the correct CPU.

I apologize, I missed one detail. The interrupt won't re-trigger if
the PMIP and OF bits are not cleared.
I will follow your suggestion and use the irq_work mechanism. I will
add this to the updated version.
Thank you for your help

>
> I will drop this patch and make a new, simpler fix.
>
> Thanks again for your help!
>
> > thanks.
> >
> > >
> > >       perf_event_update_userpage(event);
> > >  }
> > >
> > > -static void riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> > > +/* Called with pmu->lock held */
> > > +static void __riscv_iommu_pmu_stop(struct perf_event *event, int fla=
gs)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > @@ -521,13 +534,26 @@ static void riscv_iommu_pmu_stop(struct perf_ev=
ent *event, int flags)
> > >       hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> > >  }
> > >
> > > +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags=
)
> > > +{
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_stop(event, flags);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > > +}
> > > +
> > >  static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > >       unsigned int num_counters =3D pmu->num_counters;
> > > +     unsigned long irqflags;
> > >       unsigned int idx;
> > >
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +
> > >       /* Reserve index zero for iohpmcycles */
> > >       if (is_cycle_event(event->attr.config))
> > >               idx =3D RISCV_IOMMU_HPM_CYCLE_IDX;
> > > @@ -535,8 +561,10 @@ static int riscv_iommu_pmu_add(struct perf_event=
 *event, int flags)
> > >               idx =3D find_next_zero_bit(pmu->used_counters, num_coun=
ters, 1);
> > >
> > >       /* All event counters or cycle counter are in use */
> > > -     if (idx =3D=3D num_counters || pmu->events[idx])
> > > +     if (idx =3D=3D num_counters || pmu->events[idx]) {
> > > +             raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >               return -EAGAIN;
> > > +     }
> > >
> > >       set_bit(idx, pmu->used_counters);
> > >
> > > @@ -546,7 +574,9 @@ static int riscv_iommu_pmu_add(struct perf_event =
*event, int flags)
> > >       local64_set(&hwc->prev_count, 0);
> > >
> > >       if (flags & PERF_EF_START)
> > > -             riscv_iommu_pmu_start(event, flags);
> > > +             __riscv_iommu_pmu_start(event, flags);
> > > +
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >
> > >       /* Propagate changes to the userspace mapping. */
> > >       perf_event_update_userpage(event);
> > > @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_even=
t *event, int flags)
> > >
> > >  static void riscv_iommu_pmu_read(struct perf_event *event)
> > >  {
> > > +     struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > > +     unsigned long irqflags;
> > > +
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > >       riscv_iommu_pmu_update(event);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >  }
> > >
> > >  static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> > >       struct hw_perf_event *hwc =3D &event->hw;
> > > +     unsigned long irqflags;
> > >       int idx =3D hwc->idx;
> > >
> > > -     riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +     __riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> > >       pmu->events[idx] =3D NULL;
> > >       clear_bit(idx, pmu->used_counters);
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > >
> > >       perf_event_update_userpage(event);
> > >  }
> > > @@ -635,12 +673,24 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(=
int irq, void *dev_id)
> > >  {
> > >       struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_i=
d;
> > >       DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> > > +     unsigned long irqflags;
> > >       u32 ovf, idx, inhibit;
> > >
> > > -     /* Check whether this interrupt is for PMU */
> > > +     /*
> > > +      * Check whether this interrupt is for PMU. Done outside the lo=
ck so
> > > +      * that a shared interrupt line is left alone as cheaply as pos=
sible.
> > > +      */
> > >       if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IO=
MMU_IPSR_PMIP))
> > >               return IRQ_NONE;
> > >
> > > +     /*
> > > +      * Hold the lock across the whole sequence below. Stopping the
> > > +      * counters, processing them and restoring the previous inhibit=
 state
> > > +      * has to be atomic against ->start()/->stop(), otherwise a cou=
nter
> > > +      * enabled in between would be inhibited again by the restore.
> > > +      */
> > > +     raw_spin_lock_irqsave(&pmu->lock, irqflags);
> > > +
> > >       /* Process PMU IRQ */
> > >       inhibit =3D riscv_iommu_pmu_stop_all(pmu);
> > >
> > > @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(in=
t irq, void *dev_id)
> > >
> > >       riscv_iommu_pmu_start_all(pmu, inhibit);
> > >
> > > +     raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> > > +
> > >       return IRQ_HANDLED;
> > >  }
> > >
> > > @@ -735,6 +787,8 @@ static int riscv_iommu_pmu_probe(struct auxiliary=
_device *auxdev,
> > >
> > >       iommu_pmu->reg =3D iommu_dev->reg;
> > >
> > > +     raw_spin_lock_init(&iommu_pmu->lock);
> > > +
> > >       /*
> > >        * Counter number and width are hardware-implemented, detect th=
em by
> > >        * writing 1s and reading back which bits stuck.
