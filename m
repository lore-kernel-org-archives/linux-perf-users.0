Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A147E44CADF
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786014233; cv=pass; b=dnlCL0aUXPactYKk97vCjoIbjBaPwy2OMBVyQAIn4KaKTf0iRQGPLjZAPd45Uw/KOHSiFo5QN4foTtMOeVYGUTue3U74KVb+jMFMPEgSBayDJBw0n1+w/D3DtUlET94iLusUOqkAZ2bUEq4GOKtp8IcvRmQUOu1sfW+2tkbLklY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786014233; c=relaxed/simple;
	bh=oiL+B2h6AuSfY8Rv3bYul6pnOV2F8Xe1GqK5pQzx4so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R9CvugywJyhqvTgUcA7qqZyKDouQWxAQKVO3Ae/4bAc6ybpFYRViMdIJn2CUo/SXcbwMvxrcQNrAcWVLxV5wRo/GnFKFypn/1Nr7Dymo4hflMcNU1peKaD9JINKyhwCor7NP+O6aGyd/A8xD1y9QWzmlebprP0O0C2sM6dQFH1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Y2zRExfB; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Y2zRExfB"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-456395f4e7bso1400046fac.0
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Aug 2026 04:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786014227; cv=none;
        d=google.com; s=arc-20260327;
        b=OgUw13S2dVbagdAJvewYRWQbBOqpNWyIKcqmGymbQS0iAh+N4Ulry7SlFLi20vmpEc
         aR3R0HupxVvaH8Lyd0LHCu7Ph9BvzmAamXFzWwub5VMqu0TzcrBohu8mrKJ5smVtdhzR
         YfZIvZizBCKya1HDMKEKIAdvodO1gCXn7uGOslgB51JSoZrn27NZWw8oK5h4i9HOqPZq
         9dYmguSQSAMqGj3wm3dXQDT/RjP0WOS3tmhBhyxN8PdaRdYCFTcJxAxjyzVcYarAmsJU
         nBkRDzvood2qtxsxsh44qpVHN1aVPfezAPVLQ7SPDeozYYzuA5Cwrl4qkM2AeJhF5cyz
         rRFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        fh=sG0wsF9/K1w1BqLmPor6pJNxeYlJblpv/DFZ2ZxxxoU=;
        b=qcdAlSvVAbZiiVumPHqJxUPE1JVs4H3lsUmuXq++ZXnnqemGj8PZM9qhAeX7rqzKMj
         5mZUGT2TRayXrlxMo+s1uKTQuYMW/XUiuwuTOSo7/m2Xcdd/2ychUj9LtnBDbTnnJNbE
         OArjLea0r9GkJBct2ZSDRGb8LmuO31MRhG2jqQQRxPBdl+RfU+EkMZHBfLWKh2vy1QBB
         ChD2cwmZn1O+bjivkCjyxpwTl1m1aCHsgm3g8+oAfQMf256foCsmfsj0xKBr+QYMXniJ
         NZQr9hdR3IzSuB/m0adJYAptSRfx6pFpxS2ukGyWHFJdqeYpn7dBeup8TFdIMalkeVw1
         7rBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1786014227; x=1786619027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        b=Y2zRExfBLQUvPdcurbXQ/CJY0UazuSYyqdDTOQVrNvexWVITFePr1nVcS1wnxQKdUt
         hkFk3stB19A/OvTnQrXB+cLeYWOJ8Fbye8DSLu8x9sggIB1X9Ex1oKB7vjVgDkvwiBlK
         Rf9oJIRWAHrpC3mjFm+vOYFtqNCian6zNuAQFRGsjseLz2SRyDTYV/cnC4Kd1IARF/d8
         JW2jLO9E9q/M0vPP10EgItnb8qJXpJg4tm19XzjU/RoVNyiUdPV7qMWLDnngX1Pry0bR
         hpOdDdKEfQMB9JNokU/ghUdCcClHeHWDWKB6Z4lFlnAHhM5aKk7ZhLrK0Lv5bz7B95LD
         p/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786014227; x=1786619027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMaEeVh+/U+NbRzoGC8Idgo7QP/ahOzSH8HwXGJHBcU=;
        b=lnjMcwY1bej6P4GlqLKkxdFPDiVeVixIATR6mSZafiIDhNaEGewKuPYkEQmLY/pXDQ
         KSJ1WflRjVl09KsPpthZuyhtokmBYnfyRYPYDjT2pZ5bFK3F9M4NnmLhYFcUZQ1Vc1uY
         u94bjyYW/pD8QEGtM5T2eidzvmlzdFoVPPvcqO4yt4p85YxdO6Sp0EZe2RcZjeAvgLCz
         mHHrmiZlnUjIn0AVurLm5VNngdm87eP+kZH/gMw2f0H49FH0l1zFm25ZYJVnoFJPE8s9
         RivEGFcxDrk/5hC8zGKp1pf7a9LVPHovi0VJ8e8hfxgPJ+BuQAuIis9xnuop4cTLBUcc
         sfrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0oiMk6xB0ZOufT8xClyNezFQo6b3wuaFdV9HuaXyZUOeq4O60iGZgZnTu9kSeEqFuOz8mk8+iZc0lwOCfJgBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxkyDY8rHPF1jZiNQj620AphonlQ7E0kmD7l45mXuFBUO71tRCk
	0i0D9YuCdYscPp5DcNmZuEVJevu4wqiYj9HNhO4hEuVNknzIBUXr8zMXEBZ+44PpZ7ZatWFfWi7
	h4xxxU1EncfwjIbcWBdwWij6RiBRDzCO5CQFSYSMUcw==
X-Gm-Gg: AR+sD10ljaI2vgZP0ewScdJcaOL7tSpdt1+4d3TKmzXbf6wUEvA16ZGiQEbXUexdZEx
	wyJ/9dmsKKyWWv6P1VQiDUVB2/gR1A4rpSe7y4F+IM67m1GMIz11uh44hqR3xA+xCWjovPQOrbP
	C5KPYrtbn+ea2NQkkyXxBY7Nvc0pFJG0jkgdU/2GUVSnC2BpyQFlTea4XAcXwEI4GcDYALiZijV
	lGfxqamsc5m17+dIM5y/Sy+pa/Yoqgm7srO7C5SLqp82LA5KkIEVUpX7XEUk471wpItcdbzPxD4
	PSXZ03VZkwJ7WMprNcDWU8lHrp2f3KKYkKhxynbq5I324d8=
X-Received: by 2002:a4a:e910:0:b0:6ac:ac32:b5ff with SMTP id
 006d021491bc7-6ae96c1b306mr7392747eaf.2.1786014225348; Thu, 06 Aug 2026
 04:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784201104.git.cuiyunhui@bytedance.com> <138d74aa9863ae8ff445e16a2798d062895b75bc.1784201104.git.cuiyunhui@bytedance.com>
 <anQ2bW3JxraT6PFY@lucifer>
In-Reply-To: <anQ2bW3JxraT6PFY@lucifer>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 6 Aug 2026 19:03:33 +0800
X-Gm-Features: AUfX_myo8uemIR_J8tcaFPQk5bQ_19S-a0xl3xjkzuEjy5SWJNGo65WwssSv6nw
Message-ID: <CAEEQ3wk62WBSJb5JcnPJoVSb+JQq3ZcE4CRmqqTvkAO20XFjbg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 10/15] mm/gup: add fast-GUP specific
 lockless PTE helpers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, kasan-dev@googlegroups.com, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Thu, Aug 6, 2026 at 3:35=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> +cc literally everybody you failed to contact...!
>
> Why on earth are you doing sending a series like this which changes core =
mm,
> non-RFC and at v2 to boot, without bothering to Cc relevant people?
>
> I am also very confused as to why you are sending an ostensible RISC-V se=
ries
> then changing how core mm works to fit it, that's not how that works.
>
> And if you're seeking to change core mm send it as an RFC!
>
> On Thu, Jul 16, 2026 at 08:41:45PM +0800, Yunhui Cui wrote:
> > fast-GUP snapshots a PTE without holding the PTL, pins the page, and
> > then revalidates that the PTE did not change. Keep both reads under the
> > same lockless PTE semantics by defaulting the fast-GUP revalidation to
> > ptep_get_lockless().
>
> Why?...

Thanks for the review. Let me first explain the motivation behind patch
10/15, and then address the RFC/Cc and naming issues.

The goal of this patchset is to let RISC-V Svnapot provide contiguous PTE
semantics similar to arm64 contpte: generic MM should still see a normal
per-page PTE view, while RISC-V can fold eligible PTE ranges into the
Svnapot/NAPOT encoding underneath. Because of that, the RISC-V public
ptep_get_lockless() may, for a Svnapot PTE, return the sub-PTE for the
current address expected by generic MM, after checking the whole NAPOT rang=
e
for consistency and aggregating block-wide A/D bits.

fast-GUP has a narrower requirement. It needs the PTE for the current addre=
ss
for permission/PFN/page lookup, then pins the page, and finally checks that
the page table entry it relied on did not change during the pin. fast-GUP d=
oes
not consume the block-wide A/D aggregation. If fast-GUP uses the public
ptep_get_lockless() for both the initial read and the revalidation, it pays
the cost of the NAPOT range scan and A/D aggregation in the fast path, even
though that information is not used.

So patch 10/15 is not trying to wrap a simple equality check. The intent is=
 to
separate two semantics: the current-address PTE consumed by fast-GUP, and t=
he
original PTE snapshot used for post-pin revalidation. On normal architectur=
es
these are the same value, and the default implementation preserves the
existing ptep_get_lockless() behavior. On RISC-V Svnapot, the value consume=
d
by fast-GUP is the sub-PTE, while revalidation compares whether the raw
snapshot has changed.

Patch 11/15 is the RISC-V use of this hook. It avoids the public
ptep_get_lockless() block-wide A/D aggregation path in fast-GUP, while stil=
l
keeping correctness through raw snapshot revalidation. In the 64K THP alway=
s
mode, fio 4K random direct read improved from 2.615M IOPS / 9.97GiB/s to
2.874M IOPS / 11.0GiB/s, and the average clat dropped from 95.54 usec to
86.97 usec.

Regarding the RFC/Cc issue, you are right, I handled that poorly. Although
this series is mainly about RISC-V Svnapot, patch 10/15 adds a generic MM/G=
UP
helper and patch 12/15 also changes the arm64 contpte fast-GUP path, so the=
y
are no longer RISC-V-local changes. I was worried that the large list of
individual recipients from get_maintainer.pl would create too much noise, s=
o
I mostly kept the mailing lists and dropped some individual Cc's. That was =
a
bad call; the relevant maintainers/reviewers should have been Cc'ed
explicitly. Sorry about that.

For the next version, I will split the generic fast-GUP helper out as a
separate RFC, add the relevant MM/GUP/arm64/RISC-V maintainers and reviewer=
s
to Cc, and explain the semantic difference between the PTE consumed by
fast-GUP and the post-pin revalidation snapshot. If I keep the arm64
optimization, I will include the arm64 maintainers/reviewers in that RFC;
otherwise I will drop it from the RISC-V series for now. I will also improv=
e
the naming, such as `rawp`/`raw_pte`, and add comments to make the snapshot
semantics clearer.

>
> >
> > Introduce fast-GUP specific PTE snapshot and revalidation helpers. The
> > default implementation preserves the existing ptep_get_lockless()
> > semantics, while allowing architectures to override the helpers when th=
e
> > public lockless getter provides extra semantics that fast-GUP does not
> > consume.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  include/linux/pgtable.h | 18 ++++++++++++++++++
> >  mm/gup.c                |  6 ++++--
> >  2 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index da14328093a86..62943fcbf7046 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -813,6 +813,24 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
> >  }
> >  #endif
> >
>
> Of course, no comments, helpful!
>
> > +#ifndef gup_ptep_get_lockless
> > +static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
>
> rawp? This is terrible naming.
>
> And 'gup_ptep_get_lockless()' is worse. What on earth is this function me=
ant to
> do? And why is 'gup lockless' considered different from lockless?
>
> And you return the value twice, because of course you do. Why? Who knows.
>
> > +{
> > +     pte_t pte =3D ptep_get_lockless(ptep);
> > +
> > +     *rawp =3D pte;
> > +
> > +     return pte;
> > +}
> > +#endif
> > +
> > +#ifndef gup_ptep_revalidate
> > +static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
> > +{
> > +     return pte_val(raw_pte) =3D=3D pte_val(ptep_get_lockless(ptep));
> > +}
>
> Again this naming is utterly terrible and I'm at a loss as to why on eart=
h
> you're doing this?
>
> We don't need to abstract equality checks?
>
> > +#endif
> > +
> >  #ifndef pmdp_get_lockless
> >  static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
> >  {
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 99902c15703b0..72fb147193e55 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2842,10 +2842,12 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t =
*pmdp, unsigned long addr,
> >       if (!ptep)
> >               return 0;
> >       do {
> > -             pte_t pte =3D ptep_get_lockless(ptep);
> > +             pte_t raw_pte, pte;
>
> What on earth is a 'raw' PTE?
>
> >               struct page *page;
> >               struct folio *folio;
> >
> > +             pte =3D gup_ptep_get_lockless(ptep, &raw_pte);
> > +
> >               /*
> >                * Always fallback to ordinary GUP on PROT_NONE-mapped pa=
ges:
> >                * pte_access_permitted() better should reject these page=
s
> > @@ -2871,7 +2873,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *p=
mdp, unsigned long addr,
> >                       goto pte_unmap;
> >
> >               if (unlikely(pmd_val(pmd) !=3D pmd_val(pmdp_get_lockless(=
pmdp))) ||
> > -                 unlikely(pte_val(pte) !=3D pte_val(ptep_get_lockless(=
ptep)))) {
> > +                 unlikely(!gup_ptep_revalidate(ptep, raw_pte))) {
>
> Why do we need to refadctor a comparison between a local variable and a l=
ockless
> get?
>
> I'm just so confused by what on earth this patch is meant to be or why it=
's here...
>
> >                       gup_put_folio(folio, 1, flags);
> >                       goto pte_unmap;
> >               }
> > --
> > 2.39.5
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> --
> Cheers, Lorenzo


Thanks,
Yunhui
