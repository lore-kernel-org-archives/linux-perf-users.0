Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62800359703
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Dec 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886697; cv=none; b=YiuZgm3UUUhrlzXb1fe51KGmXI1QX2T11alTdtSY2ELSANsvy8fzMnAYK5egNBZJ+BWV+fZbvpGA3X0/eOHmbYYF6Tnte7R0R0eVsIpz4m2LGZIVEYuWxzF+vzFv8iUDd2lujHv1JbojCRSI+6NTMhomB6yHJia2EchmDyMzwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886697; c=relaxed/simple;
	bh=Sk8kAilxtGpCp4cWpOd06jb5pFkZnOC4vCM3TT1l/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwpIAHjJy/RhulXd7nut3TcaemhFGDyDGY1FN4HivtlMX9jxv/8G5I67rWjNy/q21Sw0sSQ0BsLTcvrGGljm4pbYscAz4OAxh6p3eTYuVf1YGVXBOKqEf3QNCa8VY+TZrbWxCBpkwAg8ixsNs8OSHwoOOOb1dIzfIXmCXVw84fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BD7FEC;
	Tue, 16 Dec 2025 04:04:47 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DEE43F694;
	Tue, 16 Dec 2025 04:04:54 -0800 (PST)
Date: Tue, 16 Dec 2025 12:04:52 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, Joel May <joel-linux@jmay.us>,
	Ian Rogers <irogers@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Linux perf Profiling <linux-perf-users@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] arm64: perf: fix syscalltbl path base
Message-ID: <20251216120452.GA912180@e132581.arm.com>
References: <b2651f20-6f3a-49f5-9cd8-3fb028b2cab5@app.fastmail.com>
 <fcefc3c0-541d-40cc-84e3-9c2460308bdb@linaro.org>
 <23c07ac4-ff13-47a5-824a-e7af1d1847a3@app.fastmail.com>
 <bda366b4-fa53-4feb-a7ce-ee47cfc404b5@linaro.org>
 <20251215112818.GB681384@e132581.arm.com>
 <0076b248-9b23-408d-9448-701df3c8d952@app.fastmail.com>
 <20251215164920.GD681384@e132581.arm.com>
 <67bafe7d-6761-4b1c-8742-628513e7e8bd@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67bafe7d-6761-4b1c-8742-628513e7e8bd@app.fastmail.com>

On Tue, Dec 16, 2025 at 08:17:51AM +0100, Arnd Bergmann wrote:

[...]

> I didn't find the reference to breaking, do you just mean it
> would break when falling back to a header provided by the
> toolchain's own asm/unistd.h, or a problem with the modern
> generated version that is solved by using the old asm-generic
> file?

Sorry for confusion.  I mean build breakage caused by using
toolchain's own asm/unistd.h.

> I would also point out that s390 no longer needs a custom script
> as of 6.19, since the last incompatibility between the s390 format
> and the x86 format of the tbl files got resolved with the removal
> of the s390 compat mode.

Thanks for the info.  I saw 4ac286c4a8d9 ("s390/syscalls: Switch to
generic system call table generation") for the s390 consolidation.

To be clear, Perf makefile now only uses
tools/perf/arch/*/entry/syscalls/syscall*.tbl to create syscall arrays
for tracing (e.g., print beauty string for syscall trace).

The dilemma is that the *.tbl files are in ./tools/perf, if we generate
unistd_64/32.h headers are not visible to other programs under ./tools.

> >> or we just stick with
> >> the old asm-generic/unistd.h copy and use that on arm64 as well.
> >
> > I will proceed this way for now.  From a maintenance view, it is a
> > pragmatic solution that only requires reverting a few patches and does
> > not introduce any new code.
> 
> Note that if we ever need to update the
> tools/include/uapi/asm-generic/unistd.h file for new syscalls,
> that will get harder in the future once we remove the
> kernel's own include/uapi/asm-generic/unistd.h. I'm sorry
> I never sent that fix after the previous cleanup that introduced
> the common script.

I agree this is a potential risk if we stick to static headers.

Thanks,
Leo
