Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957755;
	b=RobzJlwqiNWS4bLvJ0qelv2QW+p23ZO1CNXHkHsvXa+ApNpb0kkFXhCfXZfLwfN7Kesc
	 XG4aEDqE2vL4SRIQgzPmol4QSIy3miioY1p1asrc7gtOm9tOs4OF25jd7ZyQLFT/mre7s
	 1Qlgj7N29gNph8P8V5XXIkeA4TcU0ZZ1PGpGAEaDyJNU2qXNcHeeoZ5PuTpzsa8vVMUjO
	 CXn0t1NI94g8D+P43ySsVLNTgrxZGf64MVH5Y+ds+d0AbOp13HUk3yPKNxbKn0U5hWbuU
	 /2UKsj7cRZrh8OJQChhc6Xexth6s6yBmr3dq67oJmcnL3ibDHVgysaGcGQHHJx/YO2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957755;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=AuQzATelnmDjKnoi/WThuzmUYvvV7GWZYk1OPN8btk8=;
	b=5SNeFth+10RUfQTaXa1+qcXKDsuQTyz6GuJFC7XAVf/xiDev+O8Zqfwt+eV6D8G2vnFE
	 1Prf+qA0fteaVeSESWz/zBi+MbRjH9CmovzNsTbD0v9oOody5KDH/IH65LvcFzQ4GGTYw
	 dsGOv2gbPOOl5cvvRy/sjqwuUcY0SH2EgraiWbRVauZyU1ZTY4Fv7mOGQqswly4TRfjW7
	 8dcn7o1uxic400CnOjFy06O++BVpEL4V/DpqGW140lCtGhxYy27kTQPKow/2OQXouevde
	 LOBVysJIEnKXizi3/t5gtGcVNUTT8iLQtub+OmAMhKQMg/dr5SVaH1Kpa43YmKa7tcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nI9cIiiG;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5BC60A3816;
	Fri,  6 Nov 2026 09:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B5BC60A3816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nI9cIiiG
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 703AD1682;
	Fri,  6 Nov 2026 01:35:50 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FA1F3F628;
	Fri,  6 Nov 2026 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793957753; bh=jYmh+bA1tMRDuwRkyGpujBnx+YjabsgM13OGBc749BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nI9cIiiGGR4bazichtzF10dlhkgr3k/QZy+bsp96RB1pHpxWqJbwjBq1rkP4RypEj
	 J+HPyHbFTVCDcSGKaTk2Nq10vac1coPWVuoNMDYazXpj9k/CnUnxVSXd/06dPqINep
	 Em/c7DXyXKLI/7HwXhbTaPIccNBE0ykXp4co+Ebw=
Date: Fri, 6 Nov 2026 09:35:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Yabin Cui <yabinc@google.com>, Dev Jain <dev.jain@arm.com>,
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
Message-ID: <20261106093551.GW9176@e132581.arm.com>
References: <20261025-perf_revert_prefer_large_alloc-v1-1-5fb431bbd624@arm.com>
 <57c34e26-3048-474d-8e74-f65799e32ff4@arm.com>
 <CALJ9ZPNWcDtajO+Luhxe1K3af64mPRFQSjvfvNornyFFkam-+g@mail.gmail.com>
 <CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com>
 <aussIYUR1BGfUzqn@willie-the-truck>
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
In-Reply-To: <aussIYUR1BGfUzqn@willie-the-truck>

On Wed, Nov 04, 2026 at 12:59:13PM +0000, Will Deacon wrote:

[...]

> > Sorry for the late reply, and sorry that the commit message in
> > 18049c8cff9c ("perf/aux: Allocate non-contiguous AUX pages by default")
> > was imprecise about "exacerbating memory fragmentation". You and Dev are
> > right that grouping same-lifetime pages into higher-order allocations
> > does not itself worsen fragmentation, and the TLB reduction numbers for
> > TRBE and SPE with large vmap() mappings make total sense given TRBE's
> > tiny TLB.
> > 
> > However, a straight revert will reintroduce a severe production issue we
> > hit on Android devices, so I'd like to share what actually happened and
> > suggest a way to get large mappings for SPE/TRBE without bringing back
> > the regression.
> 
> [...]
> 
> Thanks, Yabin. This just hardens my stance [1] that the allocation decision
> should be driven by userspace and not second-guessed by the kernel. So the
> revert is _not_ the right approach, in my view.

If a userspace interface is needed, what remaining reclaim or allocation
policy should userspace control? I am not clear how userspace control
would fix the PSI reclaim stalls described in Yabin's reply.

Alternatively, we could optimize the reported reclaim cost in the kernel
by clearing __GFP_RECLAIM for optional higher-order attempts, while
preserving the existing policy at order 0 and for
PERF_PMU_CAP_AUX_NO_SG PMUs.

If testing confirms this works, combining this mitigation with a revert
of 18049c8cff9c would be a reasonable way to restore higher-order
allocations for SPE/TRBE without adding a userspace interface.

Thanks,
Leo
