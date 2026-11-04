Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797162;
	b=JHqNvOBrk2kQFKN9nTIRxX/Mf2+yk6KZhhvr9lUSOTB+nP622G3fCWrvNCNqxAzjZoxm
	 /2pxrLArYpfv0LlEsdGFeeybdInXNfRtuU6vdzCxRqva68OJKXdoI1NCZVFZXVLwarmCO
	 l6qDP0Fnz3jwAZmgsZ+rukyPm8dXMOokZgejWHmO3SZJCOcSahcWrsjf2rKmsFeH8NwFN
	 6eyyl6Up1md5QyZG5iWdDSZsSX14tLpAv/EC21RzAZN7mOgvS7TKNPpjN7Rsmx83nTZ9L
	 Nun7lAuRQvByfgwEujfE1XMowtef4aMYTFMVY+tprHrJfEdFsV3wgqMdsSY90ISJU8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797162;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nd7kADZgodTb54n9b+XTnvtmzKhovXgowvZQIlEeTH8=;
	b=yT3OWWntxvzrALg88LYOwqa1tft2q2IF3dsN3WMB8SYj2IC5xxEoWC99RrmPaQNXrc+s
	 SGWEtez4xSWYSPEA7D3QaM2OuPWjeLSNPdLZdo/ZiUEyQyup6EA+eR25hqP7Fpehb2VjK
	 oPXQUMvrbHzuYj/2IxojTsybIG7oe9TMRbdR/rfkoCE3kFml1UjUWZ0nX9vY9qWpXtVb8
	 aKgSo1SXqJNkI42xkUlWnPg/1b3/XafzKFc3btk1RSBw0Od3dSWUUhzx29ttkBN3eh+l1
	 ai8k+jf+G5kCS3kvLXf2kDF/+noK4ClvYBeuOv6KTHolnYNxtv3qIVdrlmk9LtXL3qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBJSllBh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E20A606A326;
	Wed,  4 Nov 2026 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBJSllBh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2241F00A16;
	Wed,  4 Nov 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793797161;
	bh=nd7kADZgodTb54n9b+XTnvtmzKhovXgowvZQIlEeTH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBJSllBhnDR7WWrkv1y3e/hqRoezfi09pMp/ctyZ+RQuqk9zw3FWeikYEC7sIKRPj
	 f793oKbAwOKKWDSyqPGZOguSsOSv0cOl0pjSjo9UKdKk55KCxA1GSSUy7QPY3NIlH9
	 oDu9ivav0GEygSI3fuDJDSR4CxNCHNzUm0JfPo5zBtl8hluw+lfQ4+p+g+fQ5TLIcp
	 V3+UeEkhelygerKDmAGbAVKVqRC8bDRqmm/7tHoKAgDwK3kEziWur2yhn9joRrbRIQ
	 dfNwO5LCohVnXyj97RbOchle+B2aBsuRwW9G5YL3vieNci2eOWNrknePE46WfII2hI
	 LWJeZikhx+fLA==
Date: Wed, 4 Nov 2026 12:59:13 +0000
From: Will Deacon <will@kernel.org>
To: Yabin Cui <yabinc@google.com>
Cc: Dev Jain <dev.jain@arm.com>, Leo Yan <leo.yan@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <aussIYUR1BGfUzqn@willie-the-truck>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
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
In-Reply-To: <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>

On Tue, Nov 03, 2026 at 12:46:24PM -0800, Yabin Cui wrote:
> On Sun, Oct 25, 2026 at 04:24:06PM +0000, Leo Yan wrote:
> > The original commit claimed that contiguous AUX pages unnecessarily
> > exacerbate fragmentation for SPE, TRBE and ETR. This is not generally
> > valid: larger allocations can keep pages with the same lifetime together,
> > while order-0 allocations can scatter them across large blocks and prevent
> > free pages from coalescing [1]. The follow-up discussion [2] has not
> > established how forcing order-0 allocations addresses the reported problem.
> ...
> > Restore the previous policy of trying higher-order allocations first.
> > The allocator already uses __GFP_NORETRY and falls back to smaller
> > orders, including order 0, when larger allocations fail.
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

[...]

Thanks, Yabin. This just hardens my stance [1] that the allocation decision
should be driven by userspace and not second-guessed by the kernel. So the
revert is _not_ the right approach, in my view.

Will

[1] https://lore.kernel.org/all/ar4Iuanz_vA4twGP@willie-the-truck/
