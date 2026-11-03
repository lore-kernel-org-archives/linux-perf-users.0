Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738800;
	b=zilJVXcQRWW/5FbB/1z+kxzWzPIjqZrx1zUaD9EAm2BjEjFkp5+SAlT5OsxzluFDMBlA
	 IoCdZpClw5onJsgbk40xDq+mYpBCHsVI80HEdsBRalQrIb+ZljO2+tDAU82hRJPa1SdPK
	 F/5n9WzvJDqnCWMrGPruiG/WzEMIcbjzlS7RgmXHhJ+J0EyfmiNNTNWtlx1hWhPIqNaNy
	 6woaVkwKRg5JJrlTutN7ela0q+S53PB7R3ziRwP/v+OE+FdNfOaH6jSTteQnIZifvGOZh
	 PFwVMT1HC4LqKwQOAdoSY8DclSZx2louiUtQrTpJOTe38IClKekjgojFfEiTV0UFg6g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AynCs1XzM/X+YCVOYm23JTUMsv1IaRtgwUtvx7wJO6Y=;
	b=P9QiOY4Y0Qo9j6stzlplOXvhp2BV4A+8gMRXp3ERne7s9kbRozjHDTZda7yDzv3Opn4Q
	 hdtGXEjt4Av2My22d41Ag4X+RWFYCg0YuzZsWSQcg+V2srZlSM28o6k9jdPjdx8FtDPaw
	 FkWvGa1CVxGtICdoPjSuSWA2jfUnxMxw90YVHhBqPTSxWh4t7XTtPtQmYhYLpwFZMZe2r
	 1s3TVMrM9zvbR15ZYjrGvvw4w89SoAWzmuKUALP0Z4yUQlXvCzpMzyoclUJsH+pTfzoCp
	 zpYfsY3D7qabo0sejTkyy5mC4UqNqPMyyRZnzXd1pOUckgNqICSJMczCFg1XgF6Xh5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aN+fdkBU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499C2606A324
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Nov 2026 20:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499C2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aN+fdkBU
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso2733066b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Nov 2026 12:46:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793738798; cv=none;
        d=google.com; s=arc-20260327;
        b=rmM44X/JFYJq7c3NfrL4QsHVQ9137Uuqne5/SdltTYktaR7C8Y3/evb12Dyv1tSzmh
         79b4UQ3odSz3IIj1p/FpAhkr6K/iHJZ9jLsF2vv5wifNH7Zs8L84FL+qUV5iQcrh+Rop
         LGcGjXVhQi5+q/4ZHLx7pW8hXB/dhH09CYqtpD2T2JKXlHhhCdZ+kBaopfcCHU7HRm6T
         CO7+kIzTX+0B0IwdCIe8h/4DziYaKsxo7+JyzaqGp20fV/h+qTaRlH5VIG4oT6p+wbML
         dAtnfQSWqBWnPTuGh/CA2+OLjOCnfeRVh6z0P5zSSgamlk7p+NPCwWhbV7BbCiC5K+nf
         Lehw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AynCs1XzM/X+YCVOYm23JTUMsv1IaRtgwUtvx7wJO6Y=;
        fh=Rs9rYEqUV9qXl52toucBo7ugXhzSYXoQsVW/ywGqcf0=;
        b=iAiHO2eS8d4T60Bd8PB7Z6qsYA8SPaL2oNniluMO9+9r6Cx8GnuYuaBs2NpOM3POVr
         J0n/kqSRERb0q9qFa5whMmAhZeQ03d4djwEkR2OJWi9ZLkKhaowiUHH3jL6APdMgX08W
         Mb8rx3N4BahWrBScCqF/Gs6DGtt8lSsnxqh2TT9d7KSCCWduBKpT25Ws+EIM6R3dPokW
         AnuWQ1umNZDEhyzKXA9lmaKA5Hm1/PnbBIkrT7381iKXPo7slQ2jkfKSnnOL1mPgkmiI
         lRiaui4SOg7CM+aZdHUknHoFPchvwYD5qRNJSqUDYJ+KcSoIvCWv3I+00N4lEDncAKh3
         vuyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793738798; x=1794343598; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AynCs1XzM/X+YCVOYm23JTUMsv1IaRtgwUtvx7wJO6Y=;
        b=aN+fdkBUJT2+mTdWObCKt7vXHg2ThHpuNsH8mDEd6RjLFEpz4uP+JuMRD5Vy/I1H66
         hCKxuE0lvU5U7QKR5bMwQxIc0f8UHm6TtkPgacAoUJJcqzAJDndd1H5Q4eKu1I1Sy33B
         SqxB7W2VP2y1Ct3TZqG+lkmhuD/gliVSIW3Uf51liLoJP1/lKq0YngmddehwCj5HGrLD
         tVFQCAoU2EsVI9HD21gzvJBk7LhseX+GNz5hn/9pHFTxeS5/WCKLxap7cOyZ0xuAUTm4
         CdsaOA/U6yJE5coKzRgN3GYLU4ZQVtmQsuQ909QEbQebUmOvIX1hrOA0S9nYSWV/eJEc
         7g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738798; x=1794343598;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AynCs1XzM/X+YCVOYm23JTUMsv1IaRtgwUtvx7wJO6Y=;
        b=EgCQfU2F95oQE8R6n0viM8j0pWg5VD4K07djLUp4NBqCmE/rHOd6OfQK4VYnoTCpHi
         g42pFbIxeoHZTo/Zf2CN0r11TUlKiBO6pf2+iT5gg0XmUTILM0jXJL4qcss4d4qKU6mD
         p/9tXrVSUTZZRP9NyoSY+bWJY35wZjbIDS/Ye+WnSaW7yIPUmLvkcrPng4lPU/RbSH7z
         H0Bk9H2IIujbIekL10Zr64dQyNs/1h8zC5sKm/r03MibyB658gnhBy13TwwFhIVwKjRG
         W19SM6BGI2Im/GQcPbltkg9G2N3h4oR+teUnjneWzV0g2t95M0JZMj1WQ5cN8rXl7gHh
         aKRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJRwO713UbJRniVfk3aRoRYW26aMmryZagjx1QEOyMO2lOaNt+VTIr/3xkpmIuH+mGkgIGyOYxsWbsQD0rYdrz@vger.kernel.org
X-Gm-Message-State: APuU4Z82bfkmfGu9hrAKY6JE4lVKcssm5TuK+UZ5lAv3lWVjXmu4UWFl
	lrAlo1j5NSdpp/ghVPSrEln2xQA0iZr+F5VuRQE4t2PoBhwL7KktI9wGwSS8fyKcLAaQ48wZfj/
	WBvAXFj/++N6VBJNrStTGavM1bBya6Ardp6PldKM=
X-Gm-Gg: AYBFou2koot+DWwQX4PDObVmVAwoNqe3AHCNj9j9D9mUD8D8LC6lPK1vrv/fGFkgSCo
	Ez7EfkrO1D5XQhIb+r/5vaamo00UIh8zpVUIao7BujWKmvPPhUnELiOycmiBL2z2ZXFKCUVL1Y6
	kWekqEhU7S43sfW29J92c4Lst5sDioLQV/KoDamX6ts5N2h8Tc9NiwPo9qBgPXUJhdy67gj40z5
	bz/bfrrrXIMyJE8VcTUQG7Fmlg2+GBm1XNKrBtAH3y+f3ACoRupVPHfu3v9ir1cu40x7fubYCMy
	7vkdabna4C/3QN0t9smvdaUOZKx3sxFeakz6NGJ4zxiYNMl6CVtB+bQGzbrakrTYjtFdkFavoa+
	EDwnOHAZCrA7l+woOmNyQtvokqL0rw0XZnMtgNYB91fl87IT+gRtYnkxbM4u9/OHOIw==
X-Received: by 2002:a17:907:3e05:b0:c2e:52d6:1fb7 with SMTP id
 a640c23a62f3a-c4ca7a4f249mr1187526766b.22.1793738796738; Tue, 03 Nov 2026
 12:46:36 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com> <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
In-Reply-To: <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Tue, 3 Nov 2026 12:46:24 -0800
X-Gm-Features: AclHuK8iEHxePdb-8WNKYpve9kn-EtoohpZD5cwJdhLuon3DsvpeV_IW968yDp4
Message-ID: <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by default"
To: Dev Jain <dev.jain@arm.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>, 
	James Clark <james.clark@linaro.org>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Tamas Petz <tamas.petz@arm.com>, Tamas Zsoldos <tamas.zsoldos@arm.com>, 
	Michiel van Tol <michiel.vantol@arm.com>, coresight@lists.linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Resending in plain text for the mailing lists; sorry for the duplicate.]

Hi Leo, Will, Dev,

On Sun, Oct 25, 2026 at 04:24:06PM +0000, Leo Yan wrote:
> The original commit claimed that contiguous AUX pages unnecessarily
> exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
> valid: larger allocations can keep pages with the same lifetime together,
> while order-0 allocations can scatter them across large blocks and preven=
t
> free pages from coalescing [1]. The follow-up discussion [2] has not
> established how forcing order-0 allocations addresses the reported proble=
m.
...
> Restore the previous policy of trying higher-order allocations first.
> The allocator already uses __GFP_NORETRY and falls back to smaller
> orders, including order 0, when larger allocations fail.

Sorry for the late reply, and sorry that the commit message in
18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by default")
was imprecise about "exacerbating memory fragmentation". You and Dev are
right that grouping same-lifetime pages into higher-order allocations
does not itself worsen fragmentation, and the TLB reduction numbers for
TRBE and SPE with large vmap() mappings make total sense given TRBE's
tiny TLB.

However, a straight revert will reintroduce a severe production issue we
hit on Android devices, so I'd like to share what actually happened and
suggest a way to get large mappings for SPE/TRBE without bringing back
the regression.

### What happened in production (even with __GFP_NORETRY)

On Android Pixel dogfood devices, a background daemon (profcollectd)
periodically records short (1s) system-wide CoreSight ETM traces every
~10 minutes for AutoFDO, using a 4 MiB AUX buffer per CPU with default
aux_watermark =3D 0 (so watermark =3D 2 MiB, max_order =3D 9).

Although PERF_AUX_GFP includes __GFP_NORETRY, it is based on GFP_KERNEL,
which retains __GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM. __GFP_NORETRY
only avoids retry loops and the kernel OOM killer at the end of
__alloc_pages_slowpath(). On long-running phones where physical memory is
already fragmented and order 9..4 pages are unavailable, every failed
high-order call in rb_alloc_aux_page() still enters the slowpath and:

  1. Wakes kswapd/kcompactd at that high order.
  2. Runs synchronous direct compaction (__alloc_pages_direct_compact()).
  3. Runs synchronous direct reclaim (__alloc_pages_direct_reclaim()),
     evicting pages and raising memory PSI pressure. On Android, PSI
     reclaim stalls trigger userspace lmkd (Low Memory Killer daemon)
     even though the kernel OOM killer is never invoked.

This is amplified by two loops in rb_alloc_aux():
  - rb_alloc_aux_page() steps down one order at a time (9, 8, ..., 0),
    hitting direct compaction/reclaim at each unavailable order.
  - Worse, the outer loop in rb_alloc_aux() never lowers max_order when
    rb_alloc_aux_page() falls back:

      order =3D min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
      page =3D rb_alloc_aux_page(node, order);

    When a 4 MiB buffer (1024 pages) only finds order-0 pages, it retries
    orders 9..1 on almost every iteration -- thousands of failed
    high-order slowpath compaction/reclaim attempts for a single
    perf_mmap() call.

In field telemetry and local ftrace on Pixel devices (prior to
18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
kcompactd0 pinned on big cores scanning order-9, and this accounted for
>20% of all perceptible app kills (via lmkd) across dogfood devices
until we stopped high-order AUX allocations.

Initially we worked around this in userspace (simpleperf) by setting
perf_event_attr::aux_watermark =3D 4096 so get_order(watermark) =3D=3D 0. T=
hat
was fine for CoreSight ETR (which uses its own separate scatter-gather
buffer and only copies into AUX on flush/stop), but when enabling TRBE
(and SPE) it caused hardware maintenance interrupts every 4 KiB instead
of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c.

### Possible solutions

For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
Intel PT), higher-order AUX pages are an opportunistic optimization
rather than a functional requirement -- very similar to THP allocations
on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLUB
(allocate_slab()).

Instead of reverting to GFP_KERNEL reclaim/compaction for all high-order
attempts, could we do the following?

1. Make opportunistic high-order AUX allocations no-reclaim:
   When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
   order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
   SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):

     gfp_t gfp =3D PERF_AUX_GFP;

     if (order && !has_no_sg)
             gfp =3D (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;

   When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
   keep PERF_AUX_GFP so single-page allocations still reclaim normally
   under memory pressure.

   That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
   them immediately for PMD / contiguous-PTE vmap() mappings (and pages
   stay grouped together); when memory is fragmented on a long-running
   device, high-order probes fail fast on the freelist without waking
   kcompactd/kswapd or triggering direct compaction and reclaim.

2. Clamp max_order in rb_alloc_aux() after fallback:
   If rb_alloc_aux_page() requested `order` and had to fall back to a
   smaller order, update `max_order =3D page_private(page)` in
   rb_alloc_aux() so subsequent iterations for the rest of the buffer do
   not keep re-probing higher orders that just failed.

(Optionally, if server/benchmark workloads ever want synchronous
compaction to form huge AUX mappings even on fragmented hosts, that could
be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
with light/no-reclaim as the default.)

Would this approach work for your SPE/TRBE use cases? Happy to help test
on our side.

Thanks,
Yabin


On Tue, Nov 3, 2026 at 12:32=E2=80=AFPM Yabin Cui <yabinc@google.com> wrote=
:
>
> Hi Leo, Will, Dev,
>
> Sorry for the late reply, and sorry that the commit message in
> 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by default")
> was imprecise about "exacerbating memory fragmentation". You and Dev are
> right that grouping same-lifetime pages into higher-order allocations
> does not itself worsen fragmentation, and the TLB reduction numbers for
> TRBE and SPE with large vmap() mappings make total sense given TRBE's
> tiny TLB.
>
> However, a straight revert will reintroduce a severe production issue we
> hit on Android devices, so I'd like to share what actually happened and
> suggest a way to get large mappings for SPE/TRBE without bringing back
> the regression.
>
> ### What happened in production (even with __GFP_NORETRY)
>
> On Android Pixel dogfood devices, a background daemon (profcollectd)
> periodically records short (1s) system-wide CoreSight ETM traces every
> ~10 minutes for AutoFDO, using a 4 MiB AUX buffer per CPU with default
> aux_watermark =3D 0 (so watermark =3D 2 MiB, max_order =3D 9).
>
> Although PERF_AUX_GFP includes __GFP_NORETRY, it is based on GFP_KERNEL,
> which retains __GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM. __GFP_NORETRY
> only avoids retry loops and the kernel OOM killer at the end of
> __alloc_pages_slowpath(). On long-running phones where physical memory is
> already fragmented and order 9..4 pages are unavailable, every failed
> high-order call in rb_alloc_aux_page() still enters the slowpath and:
>
>   1. Wakes kswapd/kcompactd at that high order.
>   2. Runs synchronous direct compaction (__alloc_pages_direct_compact()).
>   3. Runs synchronous direct reclaim (__alloc_pages_direct_reclaim()),
>      evicting pages and raising memory PSI pressure. On Android, PSI
>      reclaim stalls trigger userspace lmkd (Low Memory Killer daemon)
>      even though the kernel OOM killer is never invoked.
>
> This is amplified by two loops in rb_alloc_aux():
>   - rb_alloc_aux_page() steps down one order at a time (9, 8, ..., 0),
>     hitting direct compaction/reclaim at each unavailable order.
>   - Worse, the outer loop in rb_alloc_aux() never lowers max_order when
>     rb_alloc_aux_page() falls back:
>
>       order =3D min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
>       page =3D rb_alloc_aux_page(node, order);
>
>     When a 4 MiB buffer (1024 pages) only finds order-0 pages, it retries
>     orders 9..1 on almost every iteration -- thousands of failed
>     high-order slowpath compaction/reclaim attempts for a single
>     perf_mmap() call.
>
> In field telemetry and local ftrace on Pixel devices (prior to
> 18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
> rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
> kcompactd0 pinned on big cores scanning order-9, and this accounted for
> >20% of all perceptible app kills (via lmkd) across dogfood devices
> until we stopped high-order AUX allocations.
>
> Initially we worked around this in userspace (simpleperf) by setting
> perf_event_attr::aux_watermark =3D 4096 so get_order(watermark) =3D=3D 0.=
 That
> was fine for CoreSight ETR (which uses its own separate scatter-gather
> buffer and only copies into AUX on flush/stop), but when enabling TRBE
> (and SPE) it caused hardware maintenance interrupts every 4 KiB instead
> of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
> aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c.
>
> ### Possible solutions
>
> For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
> Intel PT), higher-order AUX pages are an opportunistic optimization
> rather than a functional requirement -- very similar to THP allocations
> on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLUB
> (allocate_slab()).
>
> Instead of reverting to GFP_KERNEL reclaim/compaction for all high-order
> attempts, could we do the following?
>
> 1. Make opportunistic high-order AUX allocations no-reclaim:
>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
>
>      gfp_t gfp =3D PERF_AUX_GFP;
>
>      if (order && !has_no_sg)
>              gfp =3D (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
>
>    When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
>    keep PERF_AUX_GFP so single-page allocations still reclaim normally
>    under memory pressure.
>
>    That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
>    them immediately for PMD / contiguous-PTE vmap() mappings (and pages
>    stay grouped together); when memory is fragmented on a long-running
>    device, high-order probes fail fast on the freelist without waking
>    kcompactd/kswapd or triggering direct compaction and reclaim.
>
> 2. Clamp max_order in rb_alloc_aux() after fallback:
>    If rb_alloc_aux_page() requested `order` and had to fall back to a
>    smaller order, update `max_order =3D page_private(page)` in
>    rb_alloc_aux() so subsequent iterations for the rest of the buffer do
>    not keep re-probing higher orders that just failed.
>
> (Optionally, if server/benchmark workloads ever want synchronous
> compaction to form huge AUX mappings even on fragmented hosts, that could
> be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
> with light/no-reclaim as the default.)
>
> Would this approach work for your SPE/TRBE use cases? Happy to help test
> on our side.
>
> Thanks,
> Yabin
>
>
> On Wed, Oct 28, 2026 at 11:56=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrot=
e:
>>
>>
>>
>> On 25/10/26 9:54 pm, Leo Yan wrote:
>> > This reverts commit 18049c8cff9cc89daadc4df6975f7d9069638926.
>> >
>> > The original commit claimed that contiguous AUX pages unnecessarily
>> > exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
>> > valid: larger allocations can keep pages with the same lifetime
>> > together, while order-0 allocations can scatter them across large
>> > blocks and prevent free pages from coalescing [1]. The follow-up
>> > discussion [2] has not established how forcing order-0 allocations
>> > addresses the reported problem.
>> >
>> > TRBE and SPE write to virtually addressed buffers. The TRBE L1 TLB
>> > has one entry on Neoverse V2 [3] and two on Neoverse V3 [4]. Small
>> > mappings increase translation pressure, and TTW stalls can contribute
>> > to FIFO overflow and trace loss on TRBE.
>> >
>> > Larger allocations provide contiguous, aligned chunks for PMD or
>> > contiguous-PTE mappings with the proposed vmap() support [5].
>> > With the proposed vmap() support already applied, the tests in [2]
>> > showed that preferring larger AUX allocations reduced L2 data TLB
>> > refills by 99.68% in the TRBE test and 34.74% in the SPE test.
>> >
>> > Restore the previous policy of trying higher-order allocations first.
>> > The allocator already uses __GFP_NORETRY and falls back to smaller
>> > orders, including order 0, when larger allocations fail.
>> >
>> > Remove PERF_PMU_CAP_AUX_PREFER_LARGE, since the restored default
>> > provides that preference. Intel PT retains its existing allocation
>> > behaviour, with no functional change.
>> >
>> > [1] https://lore.kernel.org/all/aPjrRkjiIt6HmXmT@casper.infradead.org/
>> > [2] https://lore.kernel.org/linux-arm-kernel/20260810-perf_aux_trace_l=
arge_granule-v1-0-03306c9339e3@arm.com/
>> > [3] https://documentation-service.arm.com/static/633fe1ec4c59b30b51773=
0b8#page=3D52
>> > [4] https://documentation-service.arm.com/static/67361bd2c7fc0d1f211da=
382#page=3D54
>> > [5] https://lore.kernel.org/linux-mm/20260715120813.3609949-1-jiangwen=
6@xiaomi.com/
>> >
>> > Signed-off-by: Leo Yan <leo.yan@arm.com>
>> > ---
>>
>> Reviewed-by: Dev Jain <dev.jain@arm.com>
>>
>>
>> >  arch/x86/events/intel/pt.c  |  2 --
>> >  include/linux/perf_event.h  |  5 ++---
>> >  kernel/events/ring_buffer.c | 29 +++++++++--------------------
>> >  3 files changed, 11 insertions(+), 25 deletions(-)
>> >
>> > diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
>> > index 49349afee6119fb6fad815c847cb3cd9daa97604..3782af40f0832a874a7f0b=
60961d6652513de241 100644
>> > --- a/arch/x86/events/intel/pt.c
>> > +++ b/arch/x86/events/intel/pt.c
>> > @@ -1896,8 +1896,6 @@ static __init int pt_init(void)
>> >
>> >       if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
>> >               pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_NO_SG;
>> > -     else
>> > -             pt_pmu.pmu.capabilities =3D PERF_PMU_CAP_AUX_PREFER_LARG=
E;
>> >
>> >       pt_pmu.pmu.capabilities         |=3D PERF_PMU_CAP_EXCLUSIVE |
>> >                                          PERF_PMU_CAP_ITRACE |
>> > diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> > index eb3f7bab498ca9bee9ce7193744943b24ab2e0c5..b8d8b005f5c8a7c1def7ca=
d02230bf9ffb876bd6 100644
>> > --- a/include/linux/perf_event.h
>> > +++ b/include/linux/perf_event.h
>> > @@ -304,9 +304,8 @@ struct perf_event_pmu_context;
>> >  #define PERF_PMU_CAP_AUX_OUTPUT              0x0080
>> >  #define PERF_PMU_CAP_EXTENDED_HW_TYPE        0x0100
>> >  #define PERF_PMU_CAP_AUX_PAUSE               0x0200
>> > -#define PERF_PMU_CAP_AUX_PREFER_LARGE        0x0400
>> > -#define PERF_PMU_CAP_MEDIATED_VPMU   0x0800
>> > -#define PERF_PMU_CAP_SIMD_REGS               0x1000
>> > +#define PERF_PMU_CAP_MEDIATED_VPMU   0x0400
>> > +#define PERF_PMU_CAP_SIMD_REGS               0x0800
>> >
>> >  /**
>> >   * pmu::scope
>> > diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>> > index 64d4dbdc6c071b72b670dd044616f52981206ae8..95f4fbdfd2764de5b72d90=
1d778c46302f525fad 100644
>> > --- a/kernel/events/ring_buffer.c
>> > +++ b/kernel/events/ring_buffer.c
>> > @@ -684,15 +684,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct p=
erf_event *event,
>> >  {
>> >       bool overwrite =3D !(flags & RING_BUFFER_WRITABLE);
>> >       int node =3D (event->cpu =3D=3D -1) ? -1 : cpu_to_node(event->cp=
u);
>> > -     bool use_contiguous_pages =3D event->pmu->capabilities & (
>> > -             PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
>> > -     /*
>> > -      * Initialize max_order to 0 for page allocation. This allocates=
 single
>> > -      * pages to minimize memory fragmentation. This is overridden if=
 the
>> > -      * PMU needs or prefers contiguous pages (use_contiguous_pages =
=3D true).
>> > -      */
>> > -     int max_order =3D 0;
>> > -     int ret =3D -ENOMEM;
>> > +     int ret =3D -ENOMEM, max_order;
>> >
>> >       if (!has_aux(event))
>> >               return -EOPNOTSUPP;
>> > @@ -702,8 +694,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct pe=
rf_event *event,
>> >
>> >       if (!overwrite) {
>> >               /*
>> > -              * Watermark defaults to half the buffer, to aid PMU dri=
vers
>> > -              * in double buffering.
>> > +              * Watermark defaults to half the buffer, and so does th=
e
>> > +              * max_order, to aid PMU drivers in double buffering.
>> >                */
>> >               if (!watermark)
>> >                       watermark =3D min_t(unsigned long,
>> > @@ -711,19 +703,16 @@ int rb_alloc_aux(struct perf_buffer *rb, struct =
perf_event *event,
>> >                                         (unsigned long)nr_pages << (PA=
GE_SHIFT - 1));
>> >
>> >               /*
>> > -              * If using contiguous pages, use aux_watermark as the b=
asis
>> > -              * for chunking to help PMU drivers honor the watermark.
>> > +              * Use aux_watermark as the basis for chunking to
>> > +              * help PMU drivers honor the watermark.
>> >                */
>> > -             if (use_contiguous_pages)
>> > -                     max_order =3D get_order(watermark);
>> > +             max_order =3D get_order(watermark);
>> >       } else {
>> >               /*
>> > -              * If using contiguous pages, we need to start with the
>> > -              * max_order that fits in nr_pages, not the other way ar=
ound,
>> > -              * hence ilog2() and not get_order.
>> > +              * We need to start with the max_order that fits in nr_p=
ages,
>> > +              * not the other way around, hence ilog2() and not get_o=
rder.
>> >                */
>> > -             if (use_contiguous_pages)
>> > -                     max_order =3D ilog2(nr_pages);
>> > +             max_order =3D ilog2(nr_pages);
>> >               watermark =3D 0;
>> >       }
>> >
>> >
>> > ---
>> > base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
>> > change-id: 20261025-perf_revert_prefer_large_alloc-a0177d6379f6
>> >
>> > Best regards,
>>
