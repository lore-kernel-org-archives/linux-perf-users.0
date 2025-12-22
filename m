Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BAE319604
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Dec 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766425019; cv=none; b=hwrrGejZ3zlA7oB4VXCCF5PnIc+CHIeAohz0Ky7pLsnmOyYlrbKojS561PpYVizkfxHtZ7JdwAlU6Na05jLeD6tUPWbRdgCGA7WyhY05JvA3th7P+aqxmeHvb9E9gB6CaVtbuqrOiwuyFt+eim3E7bNwrDVV2HmxZVZ5Mhu830k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766425019; c=relaxed/simple;
	bh=5tDOOxZ9mBelWLrXONBAeBCECp5uj+W+504HWT647ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNbxVlmE8K1v8kWGCOh9//9XCUvRXzEg04CPSp52ZxvsFgXcd5pfTtnriAUH2DywhYL6TQ/lfFukiinfbG7QqYWEX31BovzdfOIycla0kRz/TMLvNA49CB6Mt4qHLlnJrTBsYXvjL2KyhJkN0AOQrI2c2HqjV7IOaFCjt6N/F3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6376C497;
	Mon, 22 Dec 2025 09:36:48 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC763F694;
	Mon, 22 Dec 2025 09:36:54 -0800 (PST)
Date: Mon, 22 Dec 2025 17:36:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, Joel May <joel-linux@jmay.us>,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Message-ID: <20251222173653.GF9788@e132581.arm.com>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <c8161700-ad9d-43d3-8c45-cfc110ebcd49@app.fastmail.com>
 <a5448524-a147-4edb-9359-bcee3d780eb6@linaro.org>
 <ce4e1210-94c2-4664-885b-e39106905e21@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce4e1210-94c2-4664-885b-e39106905e21@app.fastmail.com>

On Mon, Dec 22, 2025 at 11:42:49AM +0100, Arnd Bergmann wrote:
> On Mon, Dec 22, 2025, at 11:05, James Clark wrote:
> > On 21/12/2025 9:48 pm, Joel May wrote:
> >> On Mon, Dec 15, 2025, at 03:28, Leo Yan wrote:
> >> 
> >> This is my first time contributing to the Linux kernel, so please bare with
> >> my ignorance.  I don't know whether it's acceptable to consider patches
> >> that conceptually improve something without an actual problem they're
> >> solving.
> >> 
> >
> > No worries, thanks for sending the fix. Yes I think it could be ok to 
> > apply your patch anyway. I just wanted to make sure we were all on the 
> > same page with both fixes fixing the same thing.
> 
> I still don't think that Leo's series is correct.

As discussed, I will respin the series to use asm-generic/unistd.h for
arm64, this is consistent with other arches.

> > You might want to drop the fixes tag though to avoid confusion if Leo's 
> > one gets accepted, because then technically it doesn't fix anything any 
> > more. Keeping Leo's fixes: tag is a bit better because it fixes 
> > additional things and targets an older commit.
> 
> Before that gets applied, someone should explain why arm64 needs
> any special treatment at all. A lot of work has gone into making
> the syscall table handling consistent across architectures, so
> whether we ship a copy of the generated header for perf, we
> generate a new copy or we rely on 'make headers_install', should
> should really be done the same way across every architecture.

I agree arm64 is not a special case.

For the long term, I think "make headers_install" is worth trying.  The
main concern is that it introduces a dependency between tool builds
and the kernel.  However, if tools/selftests need the latest kernel
features, it's natural to depend on the latest headers.

Thanks,
Leo
