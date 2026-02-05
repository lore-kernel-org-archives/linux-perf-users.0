Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB41D54FA
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 03:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770263239; cv=pass; b=NuZd6FB4psqVwA8OYJ2QMVuQNdTj/PomUAg7GYFa5ZKDlEBrgPT6FRcJe1XYMxReqOv9XL9x3HNer/FUhqXIk/9PSwMeM8EPGFtwkQRJsYiVtnL01swZGg65Uo+rTyW9VHbjaOoFnNPHKag2NRXPOk7cvcK4xw/txTygSmEk5gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770263239; c=relaxed/simple;
	bh=U1uxpilUx2DxGX0pxECF9QK743XJ04lwD+hGq3RgaM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smRxdmk8GRr7/AqJiEdLyMMxBaiZ037CJ9XqYRlZCHfJSWUcWtkzHI38xA2uKTmc2lkjrfbmmanEcthMM0MLeabdQBQ/KSO0Szx7cRSgLXNemzqEfYOJDVqGJmbbo91dpi8LUJ7BGr9DgGtwvVnU4spHGhUD4FUnDMplwLQ1x/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=V2SROXXL; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="V2SROXXL"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65939428896so714353a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Feb 2026 19:47:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770263238; cv=none;
        d=google.com; s=arc-20240605;
        b=INU4Q8RBDYhrFltjxGYB5NI03Kbe2bKo7bs9fTNnOxLLbMdLlXcBymkipX8vHUp50N
         lv2yeD/jQaM4VW6Yf1PG3IGd9ZUUfURy2y8ShfCf36kCbfVMk5HTSXuy3hLR3BdYE/0O
         +8sdDAEbgWyPfqQDHmITlylYedPLckMLhOdTZX/Vacul/xeOdozFcB/B3PN5BmYGzFxt
         tg2Yop4kZTQuNpSlTVdeDirsA1ovf3l0qbdTuq39XGik6xpsw4hn19d7ARCiROer1p42
         AWu78LXLEALuynxN+cevm0agXJd4I4zwpyILrRmrhriEDvak3WV1nFhJoZiqvVBJnByz
         KbnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        fh=++QKzBTHMbL127e5rMeADW5q6HGA+oSLXAX0UXVi/sU=;
        b=kmbcUL9r0mQkXx5bk17K7PQXV3WGMCuiSjbYvtfPkm9uueWLgp/flk0+QAHHJq6yaU
         OpNBaSLG9UQMvtIzmXyv8WVC3XnAyPiPB9TAmGwka+JkQuZuQtfXhJNNJmfhw3bGp36L
         vmtnEBY9fQHsHs6EGc/4W3n2fDm9yhuxaMIKjg7qwp6LjIkl73VGH1Mn4fEeBLxRcB4Q
         LZOgs/kjvGubHDYzzMBoY35l2eO9yp2D7vSGfCikpGFxib94CjMivJFz74/qZnxNOb7W
         DMetQBxXswf9kt/XExmpOihJnYJFglWGMzsKj6SdQYmrW7TLZ+abD/oD2+W7114YNCbn
         ELDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1770263238; x=1770868038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        b=V2SROXXL+njmMepY2TZsbNmuWUDOZWOzNBZZK1wlMkm6Mw7OBjucI1fkSlJQq4Lbxa
         0z0+FpARS6QOigUL+nicaHND67+Ks5Y+oE+VYpyocrwKFrO7jzcEJz5p/BX2wUHsfspY
         J0FQQS87yDz444ueuVbdU+C3QmBBLf5BZprA+Oo2FycYNW0rmwKJ7dRLQ8POu1YrNyZq
         +WHc6McjW8qyKh/+OjWxgrKhkeaGgSnTd741LQAnN1e8VKJahECpQCvoo9Ist8WmQFee
         bne/Vzv/YWDgcDiugM93Z8Mj84mzh8+pLPQs7K98GHA2cDM+/3LCQRYwnu3pDY2svQor
         Y8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770263238; x=1770868038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWzU3QUTkSaGp/URwdKcUANl9SeI3h8kqMKRyxrmMQw=;
        b=RIIu4HbhsMn/TvRe6OQCqTwlotmDCpxSU+Jrwap2VWfZ87Uu3U4rrrAR7eaO36MGOl
         gE1fMAXgBMmXdLgqFb97t+81FwL+6uwS7fQ82Zw1CaM8ZIOu1+DUcGvpWvvT0+vB2+F4
         L4i7zFtwiWyjcXDebR/jK+Ptdjw7pOcgYyp325aoP2pQ/2BkxQ9r5QGmgiIFJWTBxSda
         iXAtknH/FZJ7m6lnvu80wiKmTt81H1rstgqDsdzAuV6kB89i08vNOXLTxePfWpQQbsqi
         eghEqbu3hqLnU7URYOjFvBMyQWRy1vOJosTw+d/aD79w+YM1Vk8eR6WJb4VNH/GPVC09
         ONUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAfuGPtmCUgvLmbMcjQVTNxoiSh8vhptiC3y71sFuCY36l5k86/c+mZXaaMrTI7w2P2JhLBXnPimN+QP4jUoEF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uMev6G5rzmml33W9h8x/aauaqhHJZHVzF5gDpGTyldPCfe9S
	sm9Bk5TqDnbwFfTTr48wabuDskkUIJMabEb/YGyDYW9nho+jRriwMpmKQAUB2nhBncmlsRmgpX7
	6ATZdkmTX3+6Cef7gBjWTdAAwU+6i4O7pmz0GCKblgw==
X-Gm-Gg: AZuq6aInIIcrUk6OPURXUpE+gIsB06DEbR/8kG1/u5TYlEUmGqIKBP+EYx3TgbXld3N
	xbDbJraDHppl30vIdCyglvnjw05OqFeXBKgv7y4s8S8l8rNfkLJ4+W+Qgg58tVd6WGszlHjAtpV
	i3Eqke0SU7Sytr7Wu+sFfoJfiFMibrqz6v1t724ktyu8LurM1/nq8e14UiIJKM49/jnTeQB2KU7
	RRbAobviMSNOhEXIejh+m39XipBFcPqF4nUHX5iWGPy/tMt9TkF5glXGBlFLTVdp5k/+c/XIaWt
	FIS3lb4v
X-Received: by 2002:a17:907:9409:b0:b8e:8874:8384 with SMTP id
 a640c23a62f3a-b8e9ef30487mr317378866b.4.1770263237571; Wed, 04 Feb 2026
 19:47:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769562575.git.lv.zheng@spacemit.com> <cover.1770195980.git.lv.zheng@linux.spacemit.com>
 <9C0A2AD4850D179B+524146e74e808db90d5f28fcb6ee791cf1d1bfaa.1770195980.git.lv.zheng@linux.spacemit.com>
 <p74snip7yykhogvzqld4gyjlygmd2z4kqnat7w3qj63fwebnmm@dlz6tloevgbs> <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
In-Reply-To: <4D87481E9AABE2C6+72d18f72-9407-4d68-8195-edc6c171df14@linux.spacemit.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 5 Feb 2026 11:47:07 +0800
X-Gm-Features: AZwV_Qj4QZXbWJXyq8Jiiv-VQvhct2TUKL3kLYYPr0oB9fDJjewtTcIansChXl4
Message-ID: <CANXhq0q8N5eHx9ytabZR97Y7AULKwgS2-uEGhcaOOGp9mvbtRQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iommu/riscv: Add HPM support for performance monitoring
To: Lv Zheng <lv.zheng@linux.spacemit.com>
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>, Tomasz Jeznach <tjeznach@rivosinc.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Jingyu Li <joey.li@spacemit.com>, iommu@lists.linux.dev, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 11:35=E2=80=AFAM Lv Zheng <lv.zheng@linux.spacemit.c=
om> wrote:
>
> On 2/5/2026 2:39 AM, Andrew Jones wrote:
> > How does this relate to
> >
> > https://lore.kernel.org/all/20250115030306.29735-1-zong.li@sifive.com/
> >
> >  From a quick skim it looks like there's plenty of overlap.
>
> We developed the driver in 2024 and demonstrated it in China summit. We
> didn't notice that a patch is on-going now in the community.
>
> Now it looks our approach solved more issues, and we'll check and update
> if there are any community concerns still not addressed in this patchset.
>
> We can add Reviewed-by/Tested-by and Signed-off-by of Zong Li to this
> patch if he wishes.
>
> Thanks,
> Lv
>

Perhaps I can first post my next revision to the mailing list (hope it
won't waste the community resource), so that you could have a chance
to review it and see whether that version is architecturally closer to
what the community is looking for, while also addressing your issue.
If you also feel that my next revision meets your needs, perhaps you
could append your additional implementations on top of it.

Of course, if the community would prefer to go your version, I=E2=80=99m
perfectly fine with that as well.

> >
> > Thanks,
> > drew
> >
> >
> > On Wed, Feb 04, 2026 at 05:09:01PM +0800, Lv Zheng wrote:
> >> From: Jingyu Li <joey.li@spacemit.com>
> >>
> >> Introduces perf-based HPM driver for RISC-V IOMMU, enabling performanc=
e
> >> monitoring capabilities.
> >>
> >> Note that the RISC-V IOMMU HPM module uses COUNTER_MAX-1 as a static
> >> counter index of HPMCYCLES, and 0~COUNTER_MAX-2 as the dynamic counter
> >> indexes of other HPMEVENTS in order to correctly index into IOHPMEVT a=
nd
> >> IOHPMCTR registers that have already been defined in the iommu-bits.h.
> >> However the users treat 0 as the index of HPMCYCLES and 1~COUNTER_MAX-=
1 as
> >> the indexes of other HPMEVENTS, thus care should be taken in dealing w=
ith
> >> counter indexes between userspace and kernel space.
> >>
> >> Signed-off-by: Jingyu Li <joey.li@spacemit.com>
> >> Signed-off-by: Lv Zheng <lv.zheng@linux.spacemit.com>
> >> Link: https://github.com/riscv-non-isa/riscv-iommu
> >> ---
> >>   drivers/iommu/riscv/Kconfig          |   9 +
> >>   drivers/iommu/riscv/Makefile         |   1 +
> >>   drivers/iommu/riscv/iommu-bits.h     |   6 +
> >>   drivers/iommu/riscv/iommu-hpm.c      | 843 +++++++++++++++++++++++++=
++
> >>   drivers/iommu/riscv/iommu-pci.c      |  13 +-
> >>   drivers/iommu/riscv/iommu-platform.c |   8 +-
> >>   drivers/iommu/riscv/iommu.h          |  42 ++
> >>   7 files changed, 919 insertions(+), 3 deletions(-)
> >>   create mode 100644 drivers/iommu/riscv/iommu-hpm.c
> >>
> >
>
