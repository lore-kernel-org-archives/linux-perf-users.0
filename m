Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D417A305;
	Wed,  1 Oct 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759350055; cv=none; b=IzDtsiZXfIyx1vd2MyvLWJq1fmYy0TinN4j617fRH+o83wneA3BG8myiRvhcr2oycra51aNDWOhHwv8Azd/tANqp+EhqnjiLOF9RKoucHD3QI5MbKWDFkSvGtD/C6JED7Z5KHKvRyGRNeDwjBLp+i5g2nFP2sGRu6NOVj09htWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759350055; c=relaxed/simple;
	bh=gH8Bk/26mj0XCvAzQheDtiveLzBJprZeUJW3oTWn67g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP/Wl1ItnXFlY3kB4baT7AwjaoJa/FvgN2X3G9KuGZE+RuAAnK2N8nB3yU2adnKq+lVR/NVxmxdSDg//3kIGBUmuFerEkY8KBJcGw3pOHkeqrq8jdk07lYIDNGTijsuzuSd1t11m9x+Rn5TCF70v+hpkNZ03pM4z2rLDvN6d+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 902B516F8;
	Wed,  1 Oct 2025 13:20:44 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37A5D3F5A1;
	Wed,  1 Oct 2025 13:20:52 -0700 (PDT)
Date: Wed, 1 Oct 2025 21:20:50 +0100
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/8] perf build: Support building with Clang
Message-ID: <20251001202050.GT7985@e132581.arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
 <aN044EY-Ds9-E6iz@x1>
 <20251001152217.GQ7985@e132581.arm.com>
 <aN1yNKxXLnMtQczW@x1>
 <20251001183256.GS7985@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001183256.GS7985@e132581.arm.com>

On Wed, Oct 01, 2025 at 07:32:56PM +0100, Leo Yan wrote:

[...]

> > + make 'ARCH=' 'CROSS_COMPILE=' 'EXTRA_CFLAGS=' -C tools/perf 'O=/tmp/build/perf' 'CC=clang'
> > make: Entering directory '/git/perf-6.17.0-rc6/tools/perf'
> >   BUILD:   Doing 'make -j28' parallel build
> > Makefile.config:494: *** No gnu/libc-version.h found, please install glibc-dev[el].  Stop.

It does not set correctly --target as x86_64-alpine-linux-musl if
distros are using musl libc.

Now running the container build for updated code.  Once pass test,
I will send new series.

Thanks,
Leo
