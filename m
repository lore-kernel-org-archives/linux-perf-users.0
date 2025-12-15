Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E8333890D
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Dec 2025 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765817365; cv=none; b=UeHr6AaU+i+6D/KrpKXKjzH3xYUnEsJ0sjggoAYoeifciaweHTDJBwg82/kyaXYSdQEtMmmZqbTR/ilkiCmb1fZFVSqz7zphwTFrGF2NCRdnyEfv0Dkk1Jy5V4zJVYcw86gAwlKNMd747OEszk5F40kRkD0qLgfDGEvzHvJ6l28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765817365; c=relaxed/simple;
	bh=Gm8D5T0Mf4vMzuGMobl8AwCM3aXfjNpp6Qe89I8Zfco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZylqLpwswCQL9w+GbquZ6q/xnCpfh4j1ZA6040+Ac8MEm4hbjVrNOUz5DmnhkhodxeoacBOjoI1IUN+0AXF8DmZWKhMrHUtNeC6FmAHBmuCCw0Uiy8CU0FJOX5GE6ZvkT986UDq5zkzdfsUn4Kin9o/+sE9rrgHSVHOQpqFehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C40E7FEC;
	Mon, 15 Dec 2025 08:49:15 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C76F3F694;
	Mon, 15 Dec 2025 08:49:22 -0800 (PST)
Date: Mon, 15 Dec 2025 16:49:20 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, Joel May <joel-linux@jmay.us>,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Message-ID: <20251215164920.GD681384@e132581.arm.com>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <0076b248-9b23-408d-9448-701df3c8d952@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0076b248-9b23-408d-9448-701df3c8d952@app.fastmail.com>

On Mon, Dec 15, 2025 at 01:22:04PM +0100, Arnd Bergmann wrote:

[...]

> Ah, I see now that arc/hexagon/loongarch/riscv just use an old
> copy of the header based on the and no longer update them. I only
> saw that they have the stub version but hadn't realized that they
> never updated past the point where we started generating the
> ones for the uapi.
> 
> Still, I would suggest using the same method across all architectures:
> either we figure out how to use the generated headers on all of them
> (including x86, which uses yet another method)

Switching to generated unistd.h headers would require removing
tools/include/uapi/asm-generic/unistd.h and generating unistd_64/32.h
on the fly, while still keeping arch's stub headers under
tools/arch/${arch}/include/uapi/asm/.

As discussed in [1], I would prefer to drop these headers, but Ian
noted that this could break builds with older toolchains.  We keep the
tools/ copies of unistd.h because tools need the latest syscall
numbers; relying on outdated toolchain headers can lead to build
failures or incorrect behavior (e.g., perf falling back to predefined
but wrong syscall numbers).

One idea is to install kernel headers first and then build tools, e,g.:

   cd linux
   export CROSS_COMPILE=aarch64-linux-gnu-
   make ARCH=arm64 headers_install O=$OUT
   make ARCH=arm64 O=$OUT -C tools/perf

Generating the headers dynamically would avoid maintaining duplicated
copies under tools/ and no need for periodic syncs.  However, this is a
quite big effort, not just perf, we need to update makefiles to the path
of the installed headers.  I'd like to hear opinions from tools
(perf/bpf/selftest) maintainers before proceeding.

> or we just stick with
> the old asm-generic/unistd.h copy and use that on arm64 as well.

I will proceed this way for now.  From a maintenance view, it is a
pragmatic solution that only requires reverting a few patches and does
not introduce any new code.

Thanks for your suggestion!

Leo

[1] https://lore.kernel.org/linux-perf-users/20251209104926.GS724103@e132581.arm.com/
