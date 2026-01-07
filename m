Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E64399A46;
	Wed,  7 Jan 2026 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767806070; cv=none; b=bz+YTDJ2UD1a2mAuYB5BlsHl5nmp4J3S8foFWUZgGqCL8as/96ILTmx4tFSkgUFmvHx6n5smJZhLBDg32nnI7by2VSMG9QVHEzQD4GqMSkFaUjAzcUK0KVjSnmfhVB57PrG5o3ZUuMO8ExsvyhmTIHDSbCUgFNxctWJK4ClWNxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767806070; c=relaxed/simple;
	bh=wwizIaa1pzVWuIDrefXv5MX/o0wNlNbp9kGR4/KNfLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdoYJ2dC7fKpQWMDEiuaM8d126FQ61bxKM3DgC6m5yv8pRimV9zAxqwTVVUWokKUu3GI3g+SZw/WfQeAA6RAYnD+bajZo+pgCbV1HYerI/Rk8LRCZfeFJCQqHuozBtjqxzsAAzYuryPz0jhp4Fppc9wPuND88ov9WLsmln33zRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8348497;
	Wed,  7 Jan 2026 09:14:21 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E6F53F6A8;
	Wed,  7 Jan 2026 09:14:28 -0800 (PST)
Date: Wed, 7 Jan 2026 17:14:26 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/3] tools headers: Go back to include
 asm-generic/unistd.h for arm64
Message-ID: <20260107171426.GE336318@e132581.arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
 <58e432e4-5825-4f2e-9aba-29be63eac56f@linaro.org>
 <20260107144806.GC336318@e132581.arm.com>
 <b50402a1-f1e2-46dc-b0f8-a08326b02c96@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b50402a1-f1e2-46dc-b0f8-a08326b02c96@app.fastmail.com>

On Wed, Jan 07, 2026 at 04:21:28PM +0100, Arnd Bergmann wrote:

[...]

> >> I'm still a bit lost about why Arm64 copying
> >> the generated header is considered a special case when we already have these
> >> x86 ones.
> >
> > If arm64 maintains its own unistd.h, there is a concern that other
> > architectures will do the same, and we will end up maintaining
> > fragmented headers for each architecture.
> >
> > Later, if we need to support architecture specific syscalls, we should
> > explore better approaches, such as using generated headers (e.g.,
> > make headers) to provide UAPI headers instead.
> 
> I think the more important issue with the current code is that
> we don't support the older architectures besides x86: arm32, powerpc,
> s390, mips, etc all have a custom syscall.tbl file like x86 but
> don't have any asm/unistd.h installed in tools. If we want to
> support any of them in the future, we should start generating the
> files the same way we do for the kernel. There is already a copy
> of the syscall.tbl files in tools/perf/arch/*/entry/syscalls/syscall*.tbl
> and the arch/mips/kernel/syscalls/Makefile
> just not the corresponding scripts/syscallhdr.sh.

Thanks for the supplement, Arnd!

Using the syscall*.tbl files under tools/perf to generate unistd.h
headers is not a good idea for me.  These files are maintained within
tools/perf (mainly for perf beauty printing), but the generated
unistd.h headers are required by code outside of perf (e.g., libperf,
feature checks, etc.).

In fact, selftests already use dynamic headers (see [1]).  Seems to
me that we should apply the same approach to perf build.

Thanks,
Leo

[1] https://docs.kernel.org/dev-tools/kselftest.html#running-the-selftests-hotplug-tests-are-run-in-limited-mode
