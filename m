Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879C265621
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 02:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770257498; cv=pass; b=raijXxPe+T8CRsNlanlg29dxe6Es2Czk6OXr5HK/RBAyLqvTUhDCxLArlVzQCn51M5p+HwduXkDwJ85MEB21hoGE0LA+YfXnvtRGcNE2cpu623Mf9cBKTH61bNiHPK3/lsyoILZRkkGWibW0BZgAwSvQ3FdJUhnkolGdN7MQN+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770257498; c=relaxed/simple;
	bh=LzenXCyNDGAV2/s4Mt5xg7gtxO2w2kJ2SKaLgFjq5Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ll5t7LvnB2UjvIZK1+bFxaO6ncfo6rw9Wo/EM7Vr7DzBJ4nOTrbtiHshDppVitcDUysssAuWiVVDv6LJ54s2CEMuuN+k+dzHwz8hfbGHlNh1fpwbe3uGnuuXYbQMqP/XgXKGiC8cqA3NLrHHgN+MXg5Dsxm8DMHxnVtshqeS/UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=VpqndtIB; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VpqndtIB"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8871718b05so63951166b.2
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 18:11:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770257496; cv=none;
        d=google.com; s=arc-20240605;
        b=TTIaTMGunGmhqjFiViqmBwhCDXrPA+VL0lMg9+BMl4RCDub1U3gxJC+akyCqIbL1oK
         TbCoY7E7jViZcmulTJLp+IiPIFSesjajxEXacZAGIuAufMRd4ARSCLnosvqyY7/quPtQ
         Cm8QAZA38RHw+OZBwuoAvomfeROVeSST/sDWyrOYyuEtqfYXmmAvcG+OzceK+8mUhmPm
         WF0sISEBK7fyM3mkuFnEW5a91G+3NCZ3LoaGAQ8YLLMoa0ghyb2d/+pAdkN7tzcH2OIH
         rZCv6GE1trGpDk0kiNJnShHpLnJOBs6+LSHGoc0AoN+B52TzscNN/CuFwH7IDX664HW/
         1l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        fh=8XCDfIYmFHjs7hsNpB0wfXnNXkSsBUUYkkkTCF6/FAA=;
        b=ZYWeneYqL1qNz6scjZXVaH572g6QG2RCrPNEQSEedy/YxYpvZtBVBoikmSwY6lQvJj
         GWzQmBKJjT7CXy1D0jzhnVi7lYxNh2GRE3I9G62YXLNhNkOVL4KoHVHUzW4sDnmmq4As
         t4aNWLWBlw3j7cCqZZ9OJCoPpVzI5VAqHe/6Y7vkpqi+znhOYqtJHk3ofOAH7d4sp+Ye
         dsnLIh2qsmZmz2h29fDsNT5cKRKrTRc4XOrL+R5nDZsDn1D9TLmlnhHIJvOM+sTVxBUF
         IVmsY2y3++eSI12vkNGufRIR/m2MMbBKF8z81+0cGW/5KA317ynA4A8BU0V/ihMJjJxP
         blUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770257496; x=1770862296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        b=VpqndtIBXgU0SG+aS6q7loT1IUfX1bDa9Y+L0UOEfh/utyPvXZp71jg92Xf4FwFZjr
         RtvqWzeHTMoqKPKP+cbu06sL263lJSuq06xRjmF+suFgPk+EcBvvCnoPkTrg/S+fKjUO
         wl8IM1zWj6llTjkyFIJB3rm6Fz1JfupYHuQ5g2emOAiy6RGVSs2sCR3MnUIBzXp5pdIb
         nMSUCLSjj+6/WzHT/z59OOKUAwjWWe3yoyCj6Nl6gYmDuJMxa+qAjnz4ZlxgoeMB7Tn/
         0Pes7Fijj1CCTPWiRXA8Cwlq+YvSyfOe04UhHBu6ili5n+mHozeJ/2ADUn6k68QcrWrg
         5tZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770257496; x=1770862296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oXfwfxqJ3Ud1a18EjbgGs6RmrKLEcJt2awiaooMVBjk=;
        b=qAOqyuMJ7CYJ7FSwq597Rmz5Hj3xSCTAEd6OA1cnWta6bcFKYmSeexZuBBSV4a25CR
         5dJZUtMB8owrpelGcyyqeIbdL1WH/0s733Ie06fC59nUsir7TvAAFD33f18XV5aEl2Gc
         TxZZutNHnkppaFLSmvH6H9ik/2ZFeONxoRI4g4CT8eoSnOjNJK40vTCcE9LEYii+kZk6
         mu8v529xxnFDpxXBrCCiaP/M1InI9tRF6oX3u54gg++7VXcWjhNTnPVDyef3LejSvtfF
         z0k9+ICYH3nS4x7RScX1r+RWLQFR2TGY7la6a/mPc54cE2VCBsRfyLrwW/LPnJ42Tf+T
         rIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV061+ZthMRv1NWXn2Nj9W617T2c/DTYPga+0/cJCKpXlz1Jb1ejpX0J1xcesNptuGJ4dOHhBWaKj/i8ptg8irr@vger.kernel.org
X-Gm-Message-State: AOJu0YyhzNPujIDolsznMliBbX6FfwZI2ZGDTW/z/ks+cv7CjbjeL0+c
	J0BFPO6JIUyVL88QXGtao3WS7hx7zqLeaz6uASSOBYFyfYbIvPlTnaSAAQ9o3pK2TvydN6+6MwP
	rLpWwUK2u+fPMHC+R1i7IwRNFO1LES3o8OFE6Xt/9JQ==
X-Gm-Gg: AZuq6aKoTq0Bwsik+6Tap9G9Y+Nak1bhRM3tx1i91WhjQyXZqEMsuckDuIWoDizEfcR
	ePhbRAAc5oO4b/ZYcoa5ETfbULvl8qIumWTRWWSKlTbYDbVTk5iz+/ZE/tLq/UGJKOdWtKgDDLN
	Q/USxRRdNFuH1xW7QDyhuRl5gIPPwsu4w/UauafJUxgHd23Rr7JPHTZmhztnMVH1VZlz1z7Hla4
	QgbQFhiAM7WmdcUXjADJuyfOOhKzyMFXruQ0y8kcB3lvlKNYi6EyX4PUMxb7lzXpGi2vDCYmg==
X-Received: by 2002:a17:907:26c9:b0:b87:892:f43b with SMTP id
 a640c23a62f3a-b8e9f196585mr325916866b.42.1770257496389; Wed, 04 Feb 2026
 18:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
In-Reply-To: <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Feb 2026 10:11:26 +0800
X-Gm-Features: AZwV_QhMZOXglwbGVqgOIj-KY2N0eLcLOg3n2x9z4Uh395TNa1CEOvBa9sxLG3g
Message-ID: <CANXhq0oi9nE7ffLGsz5j8GnC1UDTD-4bE4cantRjW2fXHYrjHA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Lv Zheng <lv.zheng@linux.spacemit.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, 
	Zhijian Chen <zhijian@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 2:39=E2=80=AFAM Andrew Jones
<andrew.jones@oss.qualcomm.com> wrote:
>
> How does this relate to
>
> https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
>
> From a quick skim it looks like there's plenty of overlap.
>
> Thanks,
> drew
>

Hi all,

Thanks Andrew for bringing me here, and sorry for the long delay on
the IOMMU PMU driver series.

I=E2=80=99m currently working on the next version to incorporate the feedba=
ck
from my earlier series. The main goals are to decouple the IOMMU perf
driver from the IOMMU driver itself, and to make it easier to add
custom events.
The implementation is almost done, but I=E2=80=99m still working on binding=
  a
name between the PMU driver with the IOMMU driver on PCIe and ACPI
cases. This part is related to how custom events should be added.
That said, I=E2=80=99m thinking that I could submit the current implementat=
ion
first, and then send a separate patch series later to handle the
custom event support.

Also, I=E2=80=99d like to mention that Yaxing has a similar implementation.=
 We
had some discussion about this last month.
https://lore.kernel.org/linux-iommu/2ce9d8be-10b3-48dd-b99e-7358347fc171@bo=
sc.ac.cn/

I think I should be able to submit this next week.

Thanks,


>
> On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> > From: Jingyu Li <joey.li@spacemit.com>
> >
> > Introduces perf-based HPM driver for RISC-V IOMMU, enabling performance
> > monitoring capabilities.
> >
> > Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> > counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> > indexes of other HPMEVENTS in order to correctly index into IOHPMEVT an=
d
> > IOHPMCTR registers that have already been defined in the iommu-bits.h.
> > However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-1=
 as
> > the indexes of other HPMEVENTS, thus care should be taken in dealing wi=
th
> > counter indexes between userspace and kernel space.
> >
> > Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> > Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> > Link: https://github.com/riscv-non-isa/riscv-iommu
> > ---
> >  drivers/iommu/riscv/Kconfig          |   9 +
> >  drivers/iommu/riscv/Makefile         |   1 +
> >  drivers/iommu/riscv/iommu-bits.h     |   6 +
> >  drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++++
> >  drivers/iommu/riscv/iommu-pci.c      |  13 +-
> >  drivers/iommu/riscv/iommu-platform.c |   8 +-
> >  drivers/iommu/riscv/iommu.h          |  42 ++
> >  7 files changed, 919 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> >
