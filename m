Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0723502A1;
	Wed,  7 Jan 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797291; cv=none; b=iz4ucrtqc6qAqAbC6ljDevKlh4PM/scW5lYaB/FiDSpEuIchMA41/YV5fwa0VbnkjBIr6+FcK2rd/F3/OkdegAZSG4f4xoeRnpgqvATfOV+mn6MkfK6QwfKUPRM2QADOlUPna8yLe2MsOLOUspeXC8GeWyOl+ShO4IKpBTstC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797291; c=relaxed/simple;
	bh=78V86tyUX/FZ1z9B4qR48kMxNZ0N7pBP0gGXbzJkCHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4jiwj1rZQKghfNxFDC9cT3TDBADpTT1aQ+h9xAN/tfzmG7v5dN+D8Pli3YDQZp0GMyIPvmJJz1QoDwlteEFrf54YR9bPzDVZm+3QBDkQqoxCzqP6qCvTuxI1BS9jwTOU7eJ/voQOwL9ig0mXDzmo87c/qT3J/FblwNJQ347l3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAF5497;
	Wed,  7 Jan 2026 06:48:02 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83C953F6A8;
	Wed,  7 Jan 2026 06:48:08 -0800 (PST)
Date: Wed, 7 Jan 2026 14:48:06 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 1/3] tools headers: Go back to include
 asm-generic/unistd.h for arm64
Message-ID: <20260107144806.GC336318@e132581.arm.com>
References: <20251222-perf_fix_syscall_header-v3-0-eb4a8b9dfe66@arm.com>
 <20251222-perf_fix_syscall_header-v3-1-eb4a8b9dfe66@arm.com>
 <58e432e4-5825-4f2e-9aba-29be63eac56f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58e432e4-5825-4f2e-9aba-29be63eac56f@linaro.org>

On Wed, Dec 24, 2025 at 01:47:51PM +0000, James Clark wrote:

[...]

> > To fix the issue, it restores to include asm-generic/unistd.h.  This is
> 
> Would this prevent us from using any Arm64 specific syscalls in the future?

I hope the perf code can be general enough so don't call arch specific
syscalls.

> I think that's a downside of this approach vs copying the generated output
> that should be noted here.

From pragmatic view, I don't see any issue with using the
asm-generic/unistd.h on Arm64 at current stage.

If later we need to support new syscalls, I assume it is very likely not
an issue for Arm64 specific, we need to resolve common issue either
updating asm-generic/unistd.h or change to use dynamic generated headers.

> > consistent with other architectures and ensures the header is available
> 
> 'Consistent' isn't accurate is it? x86 already has static copies of syscalls
> in tools/arch/x86/include/uapi/asm/unistd_32.h and
> tools/arch/x86/include/uapi/asm/unistd_64.h.

I went through a bit x86's unistd_32.h/unistd_64.h, it defines some
special syscall numbers.  Seems removing them will break on x86.
I'd leave this to x86 maintainers.

To avoid confusion, I will update the commit log:

  Restore to include asm-generic/unistd.h for fixing the issue.  This
  aligns with most architectures (x86 is a special case that keeps
  unistd_32.h/unistd_64.h for its particular syscall numbers) and
  ensures the header is available from the start.

> Maybe something more like "eventual consistency" is intended, if we plan to
> remove those x86 headers too?

Yes.

> I'm still a bit lost about why Arm64 copying
> the generated header is considered a special case when we already have these
> x86 ones.

If arm64 maintains its own unistd.h, there is a concern that other
architectures will do the same, and we will end up maintaining
fragmented headers for each architecture.

Later, if we need to support architecture specific syscalls, we should
explore better approaches, such as using generated headers (e.g.,
make headers) to provide UAPI headers instead.

IMO, in this case, x86 is not a good example to follow.

Thanks,
Leo
