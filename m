Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795122019;
	b=cBlR2f4wwqO8SOuicr4IUP9IrXupTT8VC0HD1KLjLZ7zFJXt2mJMtXtMBTmYMA5Fb6dr
	 xiLNv06t79ACKneQ6CXsVIVuJ/l9lPOQdQ0wTidXvi7D640m1DNqJr16bQPYszwvZbKbZ
	 jur6RCACn2y7dBGxxDyo9J9PLQzSQchTbvT84vl9IYD/5LxRVtyvHEXPyR6tkdGTTqjWP
	 3AZJNmIgI1mLOVUgBliB7cqaddMOWw0f7Ep6BlQ2tcjdaGmZ9BC3nfvAXmQf/co8it6zp
	 oHLVWzESRnr2mOUx4NQzRXuPgPYD7/j/EwVJPLw3vd9e1NRVRrU6qDFag5TTRL6y4Kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JkuoV3LRaclOhWnPJXkciWhUMBiml87NgupXy23O0DU=;
	b=D0zxpP7a8tnf5UPcOj5y3ltuT/SrHUQNwoEaFQfcknN8GV8hwa3xRFTbQJGvvtKdGyHy
	 y8akGcHMzuSPD3fS6Gv9G11P3HtUhLerAl8ufOzMFGodPqzXUElxQrvGU7p/oaG/0Uvgt
	 FAE9IzXsNqObQTPlHLvUCJ1rheAFa/QL6NjxxA5MwaZDvlT7UEyeoBm+gUjnjxPCe3yOX
	 AQD0vgzO3tlBt3R/82n4fI+RM1H/MIPX/nfnWFJO7jXZWJO14eda5qfLW+mV/8TJack3H
	 5AFDA4t7c7oSiPvmyoijt3KpKp8wzwZwdH2YnsWFX4SqQZuwnY6zbKeItKuxKFHvLkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jAvWjkuN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B7606A335
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD4B7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jAvWjkuN
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c50aaad19fbso28792366b.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 13:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795122017; cv=none;
        d=google.com; s=arc-20260327;
        b=Ap5M2DppEePYNQEiwrT/VF1q/Xzc6PpcRzcxmiDeh1yTw9s2fb87Ws/uevFV8iGiJJ
         k7Xs2oW0B7cCdZHKTxIQgHMwdXHUnq8i8pK4hk6pOc9R8nLcy+b2wGyYmh76E6bwJgF5
         TrKmHv9QdhVe44w7QcxKxoJ+hiLQC28Cv0edVOI5jdPuAx3aui8r9vk4DX8aBzEFRsWy
         7omAmfbanRs5Pd33c5/qWWjhv2D3Enb0iczTp0d1ifqoaZEQYt2nAV+XZ8QLYkH220TZ
         pcnHsXC4Im8LRMfd3JcC52Ygn+nSwtoyYIB8fv+u2XRfu1WbQYk2OUNNpbj7FR0liQp0
         zAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JkuoV3LRaclOhWnPJXkciWhUMBiml87NgupXy23O0DU=;
        fh=C+E7QGdxun+H6Jv4fWp3WCH1dAl/He/G2wX+4uv+qYs=;
        b=bcJXGcLnnLM70EczW/n7ikNQHN5d2KzKnLqNoZ73adCr6vasziBy+TwOe+ODrTlNRh
         /1li6astZXoEnrraG+dvlvT0hj9p/BJs+473zSfIjiyw3DE0azKpEFebzp124NzMlQGz
         trOk5DOUKLAtqNiD71RSdmu9CfkIwjs7kR61IzO/PgRXE5zuYeiHp3GBlWC1u2UYj0oZ
         2gxvmn8KO9SRYyVAmEXQeZF6iK1tNklGByZGoqmY9RlYfquYcMKoO7c5ipOUGPVAWJJx
         ZpAjXgHEbbLEc/Jhx/MhEa9rRZNjkciG+TGD9WaAbbZo8iwx9pBlRmlMR5fFlN/No36G
         eu3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795122017; x=1795726817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JkuoV3LRaclOhWnPJXkciWhUMBiml87NgupXy23O0DU=;
        b=jAvWjkuNAupqKsyBP9t5uXo48nSNrEIBrmNsChdIOU81a/yQ0R5MrZcjwXA3MdRs4E
         b3uUGcYXNcHush/OIc2HQaWMim8bVtbOHSWfcjf2j00VytHML3+xPIZojDMSzq4OwrgY
         S9Kj35FkGewfC8XKD+a2hVhrIvciGkHfzKV3n8Wa7FjZK6VC9tlMWZ2FSK54RZA7DTBC
         yXjBysmXPNO6sXdeQQgNREm3YHQEwdHKkBX/JQjgJVN3Gfca2KXNzIg2x21Fp7YYipr/
         aMGl21QRE4IwCjBz+hMpGHsQcCgI145vmsCG0CndBHNVFrGvzJI2/y4sguMnG7WdrHC6
         upUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795122017; x=1795726817;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JkuoV3LRaclOhWnPJXkciWhUMBiml87NgupXy23O0DU=;
        b=ymmG8hZDSV2WP8QHbuj444M+mwNwDlB4YkIM08RigXKU7pEGhFvvzskApXrjsg6bqn
         Im5zV5mnJ4xGRgS1R+vwJcS9ZXLfhJa1x/3JVNKj193Z+xeKnFWS3hNqC9pICXIc1QQa
         5iAogOkbp4mPcG8UxLFI+Gu37aSZ5o6JCpMYwGeB+dInv4HlnNmVwxFAoBzM9FuUISE5
         WZVyFeGv9j1/Hi9J+7CqB5PdidsFckPbOgq3GLvWkZgBvFVG431mh9Bk4ZHrnGULvZBY
         4+efk2UZDEemF1sutrUpDTk7t5bI/TYm8tSUYakft1As0fFTn9j+4s8QncRtnXZqPlGt
         5Y0A==
X-Forwarded-Encrypted: i=1; AL+hErE+FgAI14WI3V4o9P4eyuvRZNvsKFutHsUbcECx+dSXJTjV0fFx1YZ6+lx/Qapq+bPy1qAXFsTiyAcEqVV99i2n@vger.kernel.org
X-Gm-Message-State: APuU4Z9lRCJ32Q58CfLz/DyVZYP1NWJv+/cwNewNzpfz3I46S0JdcblT
	+sPzlQKRw1bl4M+rLLa3lpKVawr7dENH0XD86UDI6c/BqMKmX1SRYogp0vfX4CvfjCCjpi+ak0B
	XY7FI9OmJgM0nYuvwJe/cYfJpTHnXlXynl5jcxGI=
X-Gm-Gg: AYBFou0YGS0NZKqz2imamUxZCey83jSboAQIFbfQdcc/ferzjQYtujy9GnsdNBYfo0l
	SlybAfdvtVh9lt/Pp/kalPtYRM5YyZiXVRyS9IKN+X70sjWbafUDQ5euziX62jzji7MzcJDRDAU
	RWIKK5bjEhFyZshlGJNu7U+AljnREZv/bkvMDvCJLYBzlU+4bogszIa0T0FInMQLrcEd78p9oDS
	bq/MRZe5bZ9rtug09kVzKPrLncMG95+lVk07GOit4jBg2DxcAYbhHmcItMF1rSaimpBJRPdGc1f
	eyCXDdPPZxXBC5jpuuVB9pI+JOpn1L85Itb5rojtqHHyGDSX1mgwkvNBy6eitTPobBTMkZWjDbJ
	2kWI/7D+qIghXrDqMQU2eqPMf/1GbUYFTYwwFA/VdvrszscUv6FW0HP3f68XwYAVpDg==
X-Received: by 2002:a17:906:6690:b0:c50:55ad:ee74 with SMTP id
 a640c23a62f3a-c513a847118mr94076066b.26.1795122016402; Thu, 19 Nov 2026
 13:00:16 -0800 (PST)
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
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
 <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com> <20261118165702.GX9176@e132581.arm.com>
 <5909a504-0534-4f6a-8925-bb18f24eca0e@arm.com>
In-Reply-To: <5909a504-0534-4f6a-8925-bb18f24eca0e@arm.com>
From: Yabin Cui <yabinc@google.com>
Date: Thu, 19 Nov 2026 13:00:03 -0800
X-Gm-Features: AclHuK9FisnGtjXm-SFirgfztprvPOSno_qtl5fCAJTkLA5lJGL5x4nGHHFxvf0
Message-ID: <CALJ9ZPObeFj0mm8ahwCa-ePYHXU2nE=hvPW97bStH2mX7RvqnA@mail.gmail.com>
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

On Wed, Nov 18, 2026 at 11:43=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
>
> On 18/11/26 10:27 pm, Leo Yan wrote:
> > On Sun, Nov 15, 2026 at 08:32:16PM +0530, Dev Jain wrote:
> >
> > [...]
> >
> >>> 1. Make opportunistic high-order AUX allocations no-reclaim:
> >>>    When !(event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) and
> >>>    order > 0, clear __GFP_RECLAIM (and add __GFP_NOMEMALLOC, matching
> >>>    SLUB's allocate_slab() and GFP_TRANSHUGE_LIGHT):
> >>>
> >>>      gfp_t gfp =3D PERF_AUX_GFP;
> >>>
> >>>      if (order && !has_no_sg)
> >>>              gfp =3D (PERF_AUX_GFP | __GFP_NOMEMALLOC) & ~__GFP_RECLA=
IM;
> >>
> >> Thanks for your reply.
> >>
> >> This looks like the correct solution. Note commit 0e05a469c294
> >> ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_=
NORETRY allocations")
> >> post which the regression you report should reduce drastically. It onl=
y
> >> removes GFP_DIRECT_RECLAIM flag, I assume you are seeing latency even
> >> due to reclaim/compaction daemon wakeups.
> >>
> >> So instead of enhancing this commit even more by making a page-allocat=
or
> >> change, I would rather make your proposed change on the perf side to
> >> keep it simple. This should completely solve the problem.
> >
> > Thanks a lot, Dev!
> >
> > The revert (526d945ad9c0) and 0e05a469c294 are now in mainline. My test=
s
> > show significantly lower PSI on v7.4-rc3, consistent with the expected
> > benefit of 0e05a469c294.
> >
> > The following PSI some values are totals in milliseconds across runs
> > 2-10 (nine runs), excluding the first run of each case to avoid
> > glitches caused by its proximity to lauching the pressure workload:
> >
> >   Memory usage    v7.4-rc1    v7.4-rc3    rc3 + perf patch [1]
> >   90%                0.000       0.000               0.000
> >   95%               21.781       0.000               2.061
> >   100%              27.946       0.000               0.000
> >
> > My perf patch [1] reduces pageoutrun and compact_daemon_wake, but
> > increases pgscan_kswapd at 95%. The following totals compare v7.4-rc3
>
> Exactly what I expected. I would say to not complicate with GFP_RETRY_MAY=
FAIL
> and keep it simple.
>
>
> > and v7.4-rc + my patch, also across runs 2-10:
> >
> >   Usage    pageoutrun    compact_daemon_wake    pgscan_kswapd
> >   90%        58 -> 0               57 -> 0       1,932 -> 0
> >   95%         3 -> 2                2 -> 1       9,664 -> 148,079
> >   100%       40 -> 1               40 -> 0      11,616 -> 1,918
> >
> > I would wait for Yabin's testing before deciding whether to proceed
> > with the additional perf changes. In my patch, changing order 0 to
> > __GFP_RETRY_MAYFAIL needs care: it may reduce allocation failures when
> > free memory is scarce, at the cost of longer reclaim stalls and
> > higher PSI.
> >
> > Yabin, could you test the current mainline (or backport
> > 526d945ad9c0/0e05a469c294) and confirm whether it resolves the PSI issu=
e
> > on Android? If still see the reclaim pressure or observe AUX allocation
> > failures, it may also be worth testing patch [1].
> >

Hi Leo, Dev,

I tested on an arm64 Android Pixel device (4 KiB pages, 12 GiB RAM +
6 GiB zram, TRBE & SPE) using an Android kernel patched locally to match
v7.4-rc3's rb_alloc_aux() / __alloc_pages_slowpath() behavior
(526d945ad9c0, 669872181549, 53a9b4646f67, 0e05a469c294).

v7.4-rc3 alone still causes heavy PSI and compaction/reclaim stalls on
Android, while patch [1] keeping __GFP_NORETRY fixes it completely.

compact-bench (90/95/99%, 10 runs each =3D 30 runs, 4 MiB/CPU TRBE AUX,
0 allocation failures; system-wide PSI since Android sets
cgroup_disable=3Dpressure):

  Config             PSI some(ms)  cmp_stall  allocstall  daemon_wake
sp_kswapd_wk
  order-0                  297.76          0           0            0
           0
  revert                 2,578.00      3,957       1,984           17
          28
  v7.4-rc3-sim           1,840.29        522         161           14
          21
  rc3 + [1]                270.77          0           0            0
           0
  rc3 + [1]-noretry         41.78          0           0            0
           1

Even when order-3 pages are still plentiful (e.g. 95%, where order-3
never failed and cmp_stall/allocstall were 0), v7.4-rc3-sim still
woke kswapd/kcompactd for failed orders 4..9 on 10/10 runs (7
kcompactd wakes), producing 895.48 ms PSI vs. 2.87 ms with
[1]-noretry.

When order-3 does run out (99% Run 1), v7.4-rc3-sim bypasses
0e05a469c294 and hits 521 direct compactions / 161 direct reclaims
(Runs 2..10 dropped to 1/0 by reusing freed AUX pages; that only
helps when traces run back-to-back in a short window, which doesn't
match our use case on Android).

Under a realistic Android fragmentation test (incompressible zram
pages, unmovable pages, re-fragmented between runs), v7.4-rc3-sim also
triggered an lmkd kill (TRBE) and direct compaction/reclaim stalls
(SPE), all 0 with [1]-noretry.

When unfragmented, [1]-noretry still allocates 100% order-9 (2 MiB)
chunks for both TRBE and SPE.

So I agree with Dev to drop __GFP_RETRY_MAYFAIL and keep __GFP_NORETRY
  (0 allocation failures and lower PSI). Please proceed with v2 of [1]
keeping __GFP_NORETRY (and avoid backporting 526d945ad9c0 to
stable without it).

Thanks,
Yabin

> > Thanks,
> > Leo
> >
> > [1] https://lore.kernel.org/lkml/20261109-perf_aux_alloc_optimize_psi-v=
1-1-d56ac4bf3ef5@arm.com/
>
