Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447302;
	b=WPTYYgmP788ARrsHH1HOMExltSvy8u0aaxbSDLK40G8fZLA2flf+kNGfafdqXqjD3W5M
	 v0SNZX+Z1H8XnismF7bKIiQexZuW1Ip8+tWBrmE+G3L4GGZN/Ti2waFf6sNfxf4pMd/uw
	 whqx6elLewZLvDmudRiz+WMmhOuJRHx86suzJsL10D/PhrzH0bDw2dcCl7ER5NKjxFaKI
	 zpMnSctGUquFM13MKSt7eRxtE3moJ6MiqiJTttciP0804XU1ELSjsQ6LlluCiQShPFoIE
	 HAyDrwbpdUj8gX3CvgT2tf2OzETMkBKBZ59PiMqBmnqz6KQ8RpaQz4u1c/NVmaLZ5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447302;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9R9+S3mSuWLZBPvNUC6+4d4WMHKTLlAs7ugZ9p09fy4=;
	b=0mEmkZ7HxgIpbHGQfkpdxxrP/D8YNWcN6sY8g0S34BBHMp0mUnDU9JGSU1FlTgS+NmsD
	 xUH2AGpgYJ3EtbZOsxFcFmHHfVZ97dPQwOFFSOK/GojuchEObLDtaDGRcBnQYvQVHF1Xt
	 UVj2MF0lU+MXTectNaYuDtognUo02gimJLSf5aONgIArF2NtMhPzb33LLMcH06QM19wUq
	 A6lzCojFfXRz+j6X+MIgBu78mUEcEFUpPHLB9a22rQDDDwM1RhBf7IWEmua4/EDvtziP+
	 KW2IPkdJeIx7FHy6vjS23QMdMzaWrDbiS/Hxb7KKFmiZiaedhqPfjDasw6bnhWAeusg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oRhiKpFz;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6EE60A2621;
	Mon, 23 Nov 2026 15:21:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D6EE60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oRhiKpFz
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCF7143D;
	Mon, 23 Nov 2026 07:21:37 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2972B3F632;
	Mon, 23 Nov 2026 07:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795447300; bh=fpRq0XHe3KXaJk7U24ztuGm8cRIyiBoN98OpPRJxQVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRhiKpFzp3maAFyufuRgNdMWX7MnGYvG95nb2qZeu1KKbv2Prt2yC4yCyizqHQoi3
	 HdX3NOcnZ2OX45WSw7uiWaFpjrc7HY+ficNi3i15HO33UbOgM5wODU9AcywxKDLiV9
	 lrzUr+R5+0fMp9hTq17+Hld1pS6GcDbBDGiTSDdY=
Date: Mon, 23 Nov 2026 15:21:38 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yabin Cui <yabinc@google.com>
Cc: Dev Jain <dev.jain@arm.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Tamas Petz <tamas.petz@arm.com>,
	Tamas Zsoldos <tamas.zsoldos@arm.com>,
	Michiel van Tol <michiel.vantol@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "perf/aux: Allocate non-contiguous AUX pages by
 default"
Message-ID: <20261123152138.GD9176@e132581.arm.com>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
 <307b4d48-00f2-40dc-bf3f-ffa0f2f58d33@arm.com>
 <20261118165702.GX9176@e132581.arm.com>
 <5909a504-0534-4f6a-8925-bb18f24eca0e@arm.com>
 <CALJ9ZPObeFj0mm8ahwCa-ePYHXU2nE=hvPW97bStH2mX7RvqnA@mail.gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALJ9ZPObeFj0mm8ahwCa-ePYHXU2nE=hvPW97bStH2mX7RvqnA@mail.gmail.com>

On Thu, Nov 19, 2026 at 01:00:03PM -0800, Yabin Cui wrote:

[...]

> Hi Leo, Dev,
> 
> I tested on an arm64 Android Pixel device (4 KiB pages, 12 GiB RAM +
> 6 GiB zram, TRBE & SPE) using an Android kernel patched locally to match
> v7.4-rc3's rb_alloc_aux() / __alloc_pages_slowpath() behavior
> (526d945ad9c0, 669872181549, 53a9b4646f67, 0e05a469c294).
> 
> v7.4-rc3 alone still causes heavy PSI and compaction/reclaim stalls on
> Android, while patch [1] keeping __GFP_NORETRY fixes it completely.
> 
> compact-bench (90/95/99%, 10 runs each = 30 runs, 4 MiB/CPU TRBE AUX,
> 0 allocation failures; system-wide PSI since Android sets
> cgroup_disable=pressure):
> 
>   Config             PSI some(ms)  cmp_stall  allocstall  daemon_wake  sp_kswapd_wk
>   order-0                  297.76          0           0            0             0
>   revert                 2,578.00      3,957       1,984           17            28
>   v7.4-rc3-sim           1,840.29        522         161           14            21
>   rc3 + [1]                270.77          0           0            0             0
>   rc3 + [1]-noretry         41.78          0           0            0             1

It's good to see no allocation failures and much lower PSI with
rc3 + [1]-noretry.

> Even when order-3 pages are still plentiful (e.g. 95%, where order-3
> never failed and cmp_stall/allocstall were 0), v7.4-rc3-sim still
> woke kswapd/kcompactd for failed orders 4..9 on 10/10 runs (7
> kcompactd wakes), producing 895.48 ms PSI vs. 2.87 ms with
> [1]-noretry.
> 
> When order-3 does run out (99% Run 1), v7.4-rc3-sim bypasses
> 0e05a469c294 and hits 521 direct compactions / 161 direct reclaims
> (Runs 2..10 dropped to 1/0 by reusing freed AUX pages; that only
> helps when traces run back-to-back in a short window, which doesn't
> match our use case on Android).

I see that v7.4-rc3-sim (or with equivalent mainline kernel) can still
show increased PSI.

> Under a realistic Android fragmentation test (incompressible zram
> pages, unmovable pages, re-fragmented between runs), v7.4-rc3-sim also
> triggered an lmkd kill (TRBE) and direct compaction/reclaim stalls
> (SPE), all 0 with [1]-noretry.
> 
> When unfragmented, [1]-noretry still allocates 100% order-9 (2 MiB)
> chunks for both TRBE and SPE.
> 
> So I agree with Dev to drop __GFP_RETRY_MAYFAIL and keep __GFP_NORETRY
>   (0 allocation failures and lower PSI). Please proceed with v2 of [1]
> keeping __GFP_NORETRY (and avoid backporting 526d945ad9c0 to
> stable without it).

I don't expect 526d945ad9c0 to be backported to stable kernels, as it
has no Fixes tag. We just need to ensure that mainline and future LTS
kernels (and ACK) avoid PSI regressions..

I'll send v2 with keeping __GFP_NORETRY as you and Dev suggested.

Thanks a lot, Yabin and Dev!

Leo
