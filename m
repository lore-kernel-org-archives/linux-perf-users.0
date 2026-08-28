Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4E73E49DD
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907418; cv=pass; b=P1jaoYkV5VZc6ewFg7RPIL6eN0iiHVqTNIN7s63PYdNzkVaSv2HDDmIC7/YNaN+Z7/Ma16EFGUsW47fKeL+OKLB9M08xz2mUQXhYRw7Qegx3zTMzlV8XG+U4QcjySD9DZFhH5MVw1KLUIG6Qc6r8eYXFliCwQMoLMkK0pC/NeME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907418; c=relaxed/simple;
	bh=SmO6o6ks0c9uUsIBN0Sbld6q6+dDo0ePNZGGhFN2EAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVrPDTd/he/FjgIxsI8JQKkYBYcPMtMhgrm/LN13C6Eo01UavAzd8YjZIBLddbB9u/DjOuilK/fl0+cpXMwNpXV4d6pOqtChzREPyKh5jvwLBSUXh2ozY2ANpOzCMexPAvhbflQIlLeNNR5QzL4ulLYKRpf3xR9IRspaRzbVfek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kJ2/R7MX; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kJ2/R7MX"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1019241a12.3
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 01:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787907415; cv=none;
        d=google.com; s=arc-20260327;
        b=JzSNVJlJZRBOg3DUknybHzvAYv1mmWCgIR6uy0UYXVYikqq8WWWjkmp7zpWE+k8YJO
         2ktEzQM7l7+sg8hFbjks7wOJx2U2Wk6Y4+He0k2AvXS9UB1jQ9h0Dfsg8LE/aoBHk3TX
         CfMS0ozvcucCJrJ/VQXgf7pTINweWKZvZL6u6GrYFo5qwZ+uvqNGZiNVXVEhs9TofOcq
         dlce301zgRnAbde4c7CmFyDO9PbAMtFlj/HMDI7KjqheAPyDbOk6NQz00GqxDxqfHmeT
         70HJiRLtv/30vk/bWOpiydlONUMIwdqoeOd4HPTQihYwAUP517t/b/OItRobI/+ESIGS
         dAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        fh=hNQ50ochzlFEwANJrpetOPJNy5MasKLdlU9lYKGodIc=;
        b=MW7L7JEK5KGlH7FtKZa8DOyto3+woGwnAZld9JXxCMfIFe9eD5JZlpVWN0DaTh830R
         R+pGoiK3lWZNX/sReR+LA9xZ8ulDOhHVg2DUB3r3WHZyPVfA0zGtnrSfymtROxtzOyad
         Mhd3Jy5KGlutGsO/CwoSajYxLMElUqNuSfUinwkInyT/BDc2E3hnZ+d5FgekW3OGfwOQ
         EfExAu+cEVYtoybjCLF1eTnLacBLPP63RsdaZCI4+hl2Kzczl2VHltM9fqduMRDUvieO
         IJlsS976NM3ZsMertEAlt97o9Zbc10KWVyRcfYQ1iA51g5GsSW7W8YHfV1vLo8JzX5ew
         qFyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787907415; x=1788512215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        b=kJ2/R7MXfRavmRprHv39+xv0U/cLDgIo7nN3j8P6KwEvoLUgOVxzw+f5u6aNQvRU34
         VwsWY8ERuiTxIsuEqGzD+JdVkLJinYOq4TsLbVp2V3gqr7pOQfAvtV/8UhsOKr1/gzhS
         m4m0ql14UXdNbmwYjgdWcnnBYE1AtmRUfPPwMtGvZfAg86hcKtajoN0sx3qQHV+2bN6m
         K7CZZBL+TQvlTwIgHlnv0abuIv7k585jBxo4g3u4MSwZycsFFk5H45fD+8NhqYWVWFDN
         WkWCpRbLEWa1LXV+YPyfoQW4mpAnZ+qRV2FPriT1KHTlq9FVhUNE/9NHkYovi0BmkGMy
         w8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907415; x=1788512215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KH0APOVPoRE7sreVg72LcwRkOSoARs0sBWd4BqC6Eg4=;
        b=dtxhFoxp564O8QHagrng12j4esNqPnB6s5VbvP44sjFWBLZUGVu4qlFpctRZ92qgE/
         0kgypNuDDkLqQbzf2qBqFsH5XgzJJy7sKsdG7Trznw8gbfKy3VqivkS9wbQC7ra3tAdz
         s8h2jCptVcWnQP+Fym8WLrh98VAE6UuPUysaREJVcq/N/sDKOR6I57d9crU+sQBAhYRs
         YjDQDM8PwRvW+68iOJ+PBVctLSLP7x8wlawBxkYjbOWKwg0cj7x4YVObVbDkoygIQdEc
         yMsYHsWbkkLcnvCjmlVygq2/TevJic9ysREMX6/GvCSeASHug5lb7D2cStKPCrLarV44
         q44w==
X-Forwarded-Encrypted: i=1; AHgh+RrF703Lr09cRH5Zm8cRlIXARFZG36Crh2Z1dXLW+dyGUTJCZkVK5pBIxaTgUP0nPfwQHGkYPHnN5LH+mn2u1tDI@vger.kernel.org
X-Gm-Message-State: AFuF++nke8Iw6GgoVcYcRTYjDib+tbIO8Mk90hpOhlq72yKs9nVzgnG7
	GsmbVNpCEDPOdXCEYHRrxDW+bA3myxDTeJTmANLIbKFgub+VGIqLXs93K/Hd2xhsK3QkhsaxKT6
	uYjpWIvv5tfI/h1PkM3HRrk4FQenMZ/nFnPK4znInng==
X-Gm-Gg: AR+sD11D9X5n2ORbp4iFmBb+WH/DVu70c/e03haYarWHis3pW++HXPJCCAIWtos3OCs
	XgadO5zjS6/mjEscuyEn3udGGCXAUMO9nb8s5mgAlQxizBRoHBl8bYrTnu5GXGa1IMqIyk2BQ8D
	proYnrkZCBlbdMEAp5FDR6UtId5Yqo0fJxlEf/CPbvxl7SEZcYbIxmfaYuDO/epntoJ3rNxVLys
	4H2tkw8MfhoLj45OCRLnkmUbzWHFvyqnvvxPOzCdG2ms0cIkmZNb4S2oF0kigVtOi7vMKw94/ik
	nxfmw2fH2U3Z4I71yR7K1TAWnvE25HSShvKAqYq/EU/J2Q4=
X-Received: by 2002:a17:906:fe04:b0:c24:c24f:e176 with SMTP id
 a640c23a62f3a-c25571576e4mr284901266b.15.1787907414399; Fri, 28 Aug 2026
 01:56:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828070747.4009519-1-zong.li@sifive.com> <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
In-Reply-To: <CAJF2gTQ-1pKoBvnRSLkDGqwKDzon_yfyT74haifeGD=VRBanYg@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 16:56:41 +0800
X-Gm-Features: AcwNN1V-ZapGFDA2xiCNdfR0yQ83uvkMjP-C1OSA7d6syIhtKwC-Wxz-1qct13s
Message-ID: <CANXhq0q6nkZapRCKew50azkrmR2Gyh_X7OA39uu1p-kR67QSMQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] RISC-V IOMMU HPM support
To: Guo Ren <guoren@kernel.org>
Cc: tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, mark.rutland@arm.com, 
	andrew.jones@oss.qualcomm.com, david.laight.linux@gmail.com, 
	zhangzhanpeng.jasper@bytedance.com, yang.yicong@picoheart.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 4:49=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Li Zong,
>
> Just two patches? Where did the riscv-iommu PMU driver patch go?
>

I apologize for missing the first commit. I will resend it as PATCH
RESEND v7. Thank you very much for pointing this out!

> --
> Best Regards
>  GUO Ren
>
> On Fri, Aug 28, 2026 at 3:07=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > This series implements support for the RISC-V IOMMU hardware performanc=
e
> > monitor.
> >
> > The RISC-V IOMMU PMU driver is implemented as an auxiliary device drive=
r
> > created by the parent RISC-V IOMMU driver. Therefore, the child driver
> > can obtain resources and information from the parent device, such as
> > the MMIO base address and IRQ number.
> >
> > The thrid commit adds raw spinlock for race condition when PCI MSI/MSI-=
X
> > on IMSIC. As the commit message mentioned:
> > Events are bound to one CPU and the interrupt is affine to it, so the
> > perf callbacks running with interrupts disabled would be enough to
> > exclude the handler. But PCI MSI/MSI-X on IMSIC breaks that:
> > The irqchip sets IRQCHIP_MOVE_DEFERRED, so irq_set_affinity() reports
> > success while only recording the request, and the move is applied in
> > interrupt context upon the next device interrupt. Until then the
> > interrupt is still routed to the CPU IMSIC picked initially, so the
> > first overflow interrupt can run concurrently with the perf callbacks
> > on the CPU the events are bound to.
> >
> > I noticed that xgene_pmu and arm-cci have similar implementation, so ad=
d
> > it in riscv_iommu_pmu should be accepted.
> >
> > Changed in v6:
> > - Rebased onto the latest v7.3-rc
> > - Use sysfs_emit instead of cpumap_print_to_pagebuf
> > - Set up on_cpu and irq affinity by cpuhp callbacks
> > - Change type of on_cpu from unsigned int to int
> > - Reject filter operands of cycle event in event_init
> > - Check return value of counter number and  masks in probe
> > - Add raw spinlock for race condition (third commit)
> >
> > Changed in v5:
> > - Pick up suggestions from sashiko-bot as follows
> > - Fix event group validation for sw event
> > - Bind IRQ to aux PMU dev instead of parent IOMMU dev
> > - Clear OF bit when event is NULL
> > - Improve hi-lo-hi patten
> > - Add back IRQF_SHARED flag due to mismatch
> > - Manage cpuhp and pmu register by devre
> >
> > Changed in v4:
> > - Rebased onto v7.3-rc
> > - Use is_sampling_event() instead of accessing vairable directly
> > - Rename the matching name from "iommu.pmu" to "riscv-iommu.pmu"
> > - Change the naming of PMU device for avoid ":" in PCIe case
> > - Add suppress_bind_attrs attribute
> > - Remove IRQF_SHARED flag
> > - Set irq affinity to local CPU of IOMMU
> > - Allocate ID by IDA for auxiliary device
> > - Pick up suggestions from sashiko-bot
> >
> > Changed in v3:
> > - Rebased onto v7.2-rc3
> > - Use hi_lo_writeq/readq to access register
> > - Pick comments from sashiko-bot as follows
> > - Set IRQ CPU affinity
> > - Remove IRQF_ONESHOT flag when request irq
> > - Adjust cycle event check by checking event_id field only
> > - Fix bug for group events verificaiton
> > - Fix KASAN issue about casting 32-bit variable to unsigned long pointe=
r
> > - Clear IPSR pending bit before starting counter
> > - Clear OF bit in event selector register in irq handler
> > - Release irq by devm instead of explicit free_irq
> >
> > Changed in v2:
> > - Rebased onto v7.2-rc1
> > - Use hi-lo-hi mechanism to read counter.
> >   Suggested by Guo Ren and David Laight
> >
> > Changed in v1:
> > - Rebased onto v6.19-rc8
> > - Pick all suggestions and feedbacks from v1 series
> > - Add cpu hotplug implementation to avoid race enablement
> > - Move PMU-related definition from header to c file
> > - Change PMU driver to auxiliary device driver
> >
> > Changed in RFC:
> > - Rebase onto v6.13-rc7
> > - Clear interrupt pending before handling interrupt
> > - Fix the counter value issue caused by OF bit in the cycle counter.
> > - Invoke riscv_iommu_hpm_disable() instead of riscv_iommu_pmu_uninit()
> >   in riscv_iommu_remove()
> >
> > Zong Li (2):
> >   iommu/riscv: create a auxiliary device for HPM
> >   drivers/perf: riscv-iommu: protect shared state with a raw spinlock
> >
> >  drivers/iommu/riscv/Kconfig    |  1 +
> >  drivers/iommu/riscv/iommu.c    | 37 +++++++++++++++++++
> >  drivers/perf/riscv_iommu_pmu.c | 66 ++++++++++++++++++++++++++++++----
> >  3 files changed, 98 insertions(+), 6 deletions(-)
> >
> > --
> > 2.43.7
> >
