Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793926538;
	b=1qoXS6UsCKp+iGV13TmkGx+K7h94CfbASVHOStTrYWRb99H27HIOk/ilG7vLP7bc/4wc
	 9/dnPu3eKDBoQ/Yt02cFQmvyfqN7Yt4wrfQUUFe1/wxetLNo6UYJJDjF8lQScolHUXMS/
	 ba7BJrnDRvWMxi2mRZ7P0jjDj1Gyqmc70XMQuJIKUNBPMhfWoWsfMD6p3/KB1VrBTDKiP
	 6aanWGnL8tZE1f8kH77fU9u8oY3wLR1xCYPuuRYQdNnZPmC4ua1Cy3DWOFfu9wsGJvzG7
	 87x+Ro31tDWofAXbF5soQUC/RgHwT2QUDbWfxOwiwHfR9hfRLm0oxZGic+GR2iSImjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cG4Vu2hIpV+2Fg+Fc0+5tp9E8hoAs2YnJFXtUQKuC5A=;
	b=HLFO02AWZIG7CU7XEP4GXMbYWp+H6FmzkAgi150NvBoB5voctaYFodkhBwm+9KvDZWuO
	 l2ldS+38C9H2pZ4j9og5iHvbrzDhM3v4ORVAP0CFMmkQhJHRzPvDZPNB3Gx3N3OsCepKX
	 LOg36Riz11Zku1RguYYENKH52Gt5ZASscj+OM+V5x7ozV0jhfAsRevAoxZh2vnmVj+n+s
	 k5KH49qlN/7BGciSRE5UpvNNmtdmF4CuVpGJySUZ9dxWscIdxXa40NajozkebijTbXDWZ
	 Bn3lHOJrQz5yACb/ed7GD60KxKbS6AF18qYekuon8F8LBsqLmeFa1gfEdLIjFK3RclA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fdUCanml;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2620F606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 00:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2620F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fdUCanml
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso18368466b.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 16:55:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793926531; cv=none;
        d=google.com; s=arc-20260327;
        b=JiFHDuVHt2MsifPf9NSYEyPdq7QHx4SLv2GV/SrKx9txrzrkvGe/ZZcKH8QmaPS6vF
         PBLZr8b3Mw18qpVzIhfC4z6KozI5F+V1BkBLUFEEVFVpm4Z4sEFl3CTis8kcQBooqVGD
         vlbaMPnW+evCjtNhes+mQTbTcNBJgQtczS56Zc2/xyKiVtQx832G+kwntjC2h9t211tZ
         K+FZlG0LJI5OsEl9gGH46t59LbN9s6B4FFZGHNXsx5Q9XhPJ9Twe5hwmhIpYERJE8qBU
         2BDI6bR4Y+J2HwdhnOKTh5x1jzENfhLogJd+zCxLlkC3/pDkNNfpTu6X7oEmJVtWNS9T
         b93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cG4Vu2hIpV+2Fg+Fc0+5tp9E8hoAs2YnJFXtUQKuC5A=;
        fh=M9+zfNGU+iLOvtYbLpGfdtkbolmgmTJjbXYCqCmnDIo=;
        b=lw1a2xjOrmsw8gavw9ZkWZenT6D3yrrd6SnYidIn0PT0d6TZM4cLYMccVjqq/YBn5r
         mQMXVJaOXqRriSYLMpfEZVS2S0FZhqlnbn2GmhylmOQ0Y2FymJUWpC3tw4WlFHCw9WcC
         av7DzO7sHjwq0QaCQ6uQ7o/I2miryVrFfZtdT22JweviNHkck1lFYX0HL5hMmhnYIin2
         GiP6EJMIsVoYTjBP4JSoNbHaPwGdyQnM5yzJrA0E+mfSybROlYO5ifO1GMwLXvwupyzQ
         k2OK6U6rhFbHgE1pKWK+FTurtjk5I62oItDaRKjtsLGCSQjEFXg0uIMRdvz8FIr3Gw/j
         Lx0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793926531; x=1794531331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cG4Vu2hIpV+2Fg+Fc0+5tp9E8hoAs2YnJFXtUQKuC5A=;
        b=fdUCanmlqPJWepnCKb8zcPxA/q1q812SPiH4Jo3aaExXMCX3ocdTkCIXaV9BhLmxn/
         QOV67aa7Hb3L0uhhmrfrm73U61oyWdI21nGLERQ28tjJ3gB86zEGF6nMZHXueWl9jl+7
         4Fe+mxE9LKD1ti7GyHXy3WaorNX4tMDF+Aq+ugQbRahv6JEmQR9R4ryJJj1a2vmrYgQc
         rPyLoo8BxV8NUE8h4+3UEtMlabSItOEzpf5nxnAfwciSOQoeya4rDqPxJIltzhTcj6tc
         kQXtfuUyghnk4+8OoPR3fs24akrsTcWAaR39aIPujb6Q0Bt5axN3aiQ+D5JuP7UcgPZN
         x5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793926531; x=1794531331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cG4Vu2hIpV+2Fg+Fc0+5tp9E8hoAs2YnJFXtUQKuC5A=;
        b=qQUSTQcxiNcw95jjSvbiXBfT9DZ4HqMX5EvAZ6MJT4P76f7ErKdNyPK7VkR4+4oXb9
         UV5jyMzQwp0T/pgTplJZ20wLCAzyy+xLjFLofr7UXUpYX88+wf1rfoOWshY3vP/ektpe
         0jFBBZ8i98Q+tcH3MOX+92cOE4hsm2QWQR5bGkE/O10zjwGIPrGxA17O0c9suGMTSrW/
         hIem4nNzmq+HfLASNltdMjqNS9sQwt/XTQiJryTi5voiwprxNX8fHFvQ4ou4V1gUmHEo
         /5XXk9oinEWKZnEJFkgzIoxZgZMmOyM8SwCNUzDH+qASQHeyAUxJ3Sz9hmkW+mtm4CI0
         tlYA==
X-Forwarded-Encrypted: i=1; AKwUvByQFwyBZuEZupYqw5sJYUZu0QlSsQOhD/nP7ocw/DS8d+WE4lIyvcHd3BlWo5l7umHrF1QpeoB0O5TuIO2Txe2l@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ctya+jQxKKVVRAvKZfF+baWGshPqk0UC2Jw9cobQO5D1Ptpn2
	9ymdMAO48Gx7sfURcDudQr4iAkdv6Kfrmaq7I1Q+Bpq1Aheha+sL0kr/TSJ1R9YEjBVGcB7ZlG1
	hg8BX/7Wmj5rAc8Vyj337K/p3V0vhGuKfgxfQ+ck=
X-Gm-Gg: AYBFou0XCUM2THNaWFGdCIfjbSLCM/VAJTXryA4Gw/LYba/2YlAdnOzu+YqZGzDi+gZ
	sD8Rnpsyudcf1Z0Ek0slYPI4tdHPAfV9m3f+9Y7gjRIyaAPXvBRkrsAhpLhF5HS9d+GzbG5nb5J
	Eto5SJ8xKzz3V0j5bGccZVPh4LpqD/3vnmU/aLs/M299f5kE+S11v9l5TYjQjWq6FoBEaHHCzbw
	ntJM3aVNgK8iDQQuDGEWwRIOTRByIsfyYGrOEnuup+iIP2Cim+xOb8JgYtPDvL+anqORGIitl98
	fs+xEIQk9YGXQ+lUMxXatBKoqsoHHB/eZfWNwcWzCqTDj6FKHbQmIB5nA4Aq+Ye6W/PhZ909NnD
	hbqmns4rLGcacR51Xiq8vEBYZOWD/BsWhgwBCP7L1gMmGZIRFnoCoteMPsdPj5dZqYQ==
X-Received: by 2002:a17:907:868d:b0:c42:2f4e:522a with SMTP id
 a640c23a62f3a-c4d354de714mr85066266b.25.1793926530859; Thu, 05 Nov 2026
 16:55:30 -0800 (PST)
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
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com> <20261105173501.GV9176@e132581.arm.com>
In-Reply-To: <20261105173501.GV9176@e132581.arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Thu, 5 Nov 2026 16:55:18 -0800
X-Gm-Features: AclHuK8fgkoE7IlvDviQgcEKfjokSZYFNDtwd4rbJD0XpUrUeaFEZyOBfB7FFy8
Message-ID: <CALJ9ZPP8X+5A+WaFNVXRy32PZA5EjS1Uw4CD3_PQ62y26h_FTw@mail.gmail.com>
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by default"
To: Leo Yan <leo.yan@arm.com>
Cc: Dev Jain <dev.jain@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
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

On Thu, Nov 5, 2026 at 9:35=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Tue, Nov 03, 2026 at 12:46:24PM -0800, Yabin Cui wrote:
>
> ...
>
> > In field telemetry and local ftrace on Pixel devices (prior to
> > 18049c8cff9c, so __GFP_NORETRY was already in place), we observed heavy
> > rb_alloc_aux() -> __alloc_pages_direct_compact() stalls alongside
> > kcompactd0 pinned on big cores scanning order-9, and this accounted for
> > >20% of all perceptible app kills (via lmkd) across dogfood devices
> > until we stopped high-order AUX allocations.
>
> Thanks for the detailed explanation. My understanding is that repeated
> reclaim/compaction during AUX allocation raises memory PSI and can lead
> to lmkd killing applications. The problem to address is therefore the
> cost of obtaining higher-order pages under memory fragmentation.
>
> > Initially we worked around this in userspace (simpleperf) by setting
> > perf_event_attr::aux_watermark =3D 4096 so get_order(watermark) =3D=3D =
0. That
> > was fine for CoreSight ETR (which uses its own separate scatter-gather
> > buffer and only copies into AUX on flush/stop), but when enabling TRBE
> > (and SPE) it caused hardware maintenance interrupts every 4 KiB instead
> > of every 2 MiB. Also, in overwrite/snapshot mode rb_alloc_aux() ignores
> > aux_watermark and uses ilog2(nr_pages). That is why I sent 18049c8cff9c=
.
>
> Agreed. Reducing watermark to 4096 also increases maintenance interrupt
> frequency for SPE/TRBE. We should refine buffer allocation rather than
> using watermark as a workaround.
>
> > ### Possible solutions
> >
> > For PMUs without PERF_PMU_CAP_AUX_NO_SG (such as SPE, TRBE, and modern
> > Intel PT), higher-order AUX pages are an opportunistic optimization
> > rather than a functional requirement -- very similar to THP allocations
> > on fault (GFP_TRANSHUGE_LIGHT) or opportunistic high-order slabs in SLU=
B
> > (allocate_slab()).
> >
> > Instead of reverting to GFP_KERNEL reclaim/compaction for all high-orde=
r
> > attempts, could we do the following?
> >
> > 1. Make opportunistic high-order AUX allocations no-reclaim:
> >    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
> >    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
> >    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
> >
> >      gfp_t gfp =3D PERF_AUX_GFP;
> >
> >      if (order && !has_no_sg)
> >              gfp =3D (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM=
;
> >
> >    When order falls back to 0 (or when PERF_PMU_CAP_AUX_NO_SG is set),
> >    keep PERF_AUX_GFP so single-page allocations still reclaim normally
> >    under memory pressure.
> >
> >    That way, when free order-9 / order-4 blocks exist, SPE and TRBE get
> >    them immediately for PMD / contiguous-PTE vmap() mappings (and pages
> >    stay grouped together); when memory is fragmented on a long-running
> >    device, high-order probes fail fast on the freelist without waking
> >    kcompactd/kswapd or triggering direct compaction and reclaim.
>
> This looks reasonable for me: try to obtain larger blocks cheaply, then
> then retain the PERF_AUX_GFP policy for order-0 allocations. I also
> agree with preserving the allocation policy for PERF_PMU_CAP_AUX_NO_SG
> case.
>
> Could you compare the memory PSI stall deltas before and after applying
> this option? I think measurements from your production devices would be
> convinced evidence for benefits.

Hi Leo,

Unfortunately I'm tied up with other priorities at the moment and don't
have the bandwidth to put together and upstream the kernel patches
myself.
Whether you and Will decide to go with Option 1, a userspace-controlled
interface, or a combination of both, please feel free to take it forward
and send the patches. Once you have a patch series ready, please CC me
-- I'll be very happy to test it on Android.

Thanks,
Yabin

>
> > 2. Clamp max_order in rb_alloc_aux() after fallback:
> >    If rb_alloc_aux_page() requested `order` and had to fall back to a
> >    smaller order, update `max_order =3D page_private(page)` in
> >    rb_alloc_aux() so subsequent iterations for the rest of the buffer d=
o
> >    not keep re-probing higher orders that just failed.
>
> This also can avoid reclaim repeatedly, but the side effect is subsequent
> iterations would no longer try high order, which have no chance to
> benefit from large mapping.
>
> I would prefer to evaluate option 1 first.
>
> > (Optionally, if server/benchmark workloads ever want synchronous
> > compaction to form huge AUX mappings even on fragmented hosts, that cou=
ld
> > be gated behind an opt-in attr/sysfs knob similar to THP defrag modes,
> > with light/no-reclaim as the default.)
>
> I will follow up with Will separately about the userspace interface.
>
> > Would this approach work for your SPE/TRBE use cases? Happy to help tes=
t
> > on our side.
>
> If option 1 works, we can confidently revert 18049c8cff9c, as it would
> restore higher-order allocations for TRBE/SPE without introducing the
> regression you mentioned.
>
> Thanks,
> Leo
