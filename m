Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057F3812D1;
	Sat, 29 Aug 2026 20:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788033914; cv=none; b=YrPEmgpHjNP6B83HgwIg2aXknNnUCtsiYDHQD9rmI9LnMJ7NXvi3FbkF2cDq0sIegYhRiVArFhyPUVNn6Uc+3uQ0ZyC5inm4+4NGIIJCS8Z3ZWrkoZ8rFC+F6Ab7NKRt/FAqfzN886WL+eZs44CX8/y/NDmEmUooYI9L/J6lmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788033914; c=relaxed/simple;
	bh=gY6FSJWgwoYVeJSPXpe+kK4hGkqcWed5jSj8uFrTtBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA0k02p65CliUm7EAaE2oEWdNbYr8xVNBu3BjYpQxFIBYzFizzBebqZC6KyjviVconOGgopQeFQRPbAgTTLFukOZGkkrxfhMqVus3J5dvXD5DGUfCy2BF8sBYfF4U0rwLy7lBweMbqIwm7bQ971x5OjmtpqSl/gQ8p71ssRv+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv81zQ30; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv81zQ30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A231F000E9;
	Sat, 29 Aug 2026 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788033912;
	bh=+2Dt5/BbAVekxcUUIjKXOQEvmb4XXCWGEA7Zc0IQ9tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jv81zQ306+cAkPB/utYyGrgbdFKEL4L4yenho/60R1++l4hUj/CyOVIOPyY67/raS
	 yCnGd/yclav90BGnZCFsXw8cCU5G41HditwlTZaCA0oTwbETxKHGxvcVe0xLdzeDqN
	 6vwtJNE4dGPfbzJV0+aUKHcNUOyemvAcEnLSletJF1hy0XElVpyAK7QpkYoAkUz80Z
	 J5v9RWMOkozWcRWgjPUHhXEKPp7tWAQYbK7t+PgETNESMXe7QPn2YkER/U8HAadVDb
	 deYyV2FzlamS/zxaK9NJEzVqR5ODLs4PSFXvFidCF9qKl1x+ldlW07iR6DS7crcIRk
	 CjQrQ9pnGqthw==
Date: Sat, 29 Aug 2026 13:05:08 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jiebin Sun <jiebin.sun@intel.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org,
	mark.rutland@arm.com, dapeng1.mi@linux.intel.com,
	thomas.falcon@intel.com, tianyou.li@intel.com,
	wangyang.guo@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] perf c2c: Add function-view stdio support and
 coverage
Message-ID: <apM7dIdexptTo-1M@google.com>
References: <cover.1787283281.git.jiebin.sun@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1787283281.git.jiebin.sun@intel.com>

Hello,

On Fri, Aug 21, 2026 at 01:56:07PM +0800, Jiebin Sun wrote:
> The recently merged function-view series added an interactive TUI for
> examining the c2c data as:
> 
>   read-side function -> contending writer -> shared cacheline
> 
> This follow-up makes the same view available to builds without SLANG and
> to pipes and scripts. `perf c2c report --function` now implies stdio and
> prints the three-level hierarchy fully expanded. It requires `iaddr` in
> the coalescing fields and is rejected together with `--stats`.
> 
> The first two patches fix adjacent pre-existing issues: the documented
> default coalesce fields are stale, and a workload recording failure in
> the existing c2c shell test is incorrectly reported as a pass. The third
> patch adds the stdio function view, and the final patch adds automated
> coverage using a separate contended futex workload. Systems that record
> no contended samples report a skip for the hierarchy checks rather than a
> spurious failure.
> 
> This series follows the function-view work merged from:
> 
>   https://lore.kernel.org/linux-perf-users/20260817094623.3288456-1-jiebin.sun@intel.com/
> 
> The series is based on perf-tools-next commit 9453bc6a69ef ("perf vendor
> events arm64: Fix Tegra410 Olympus event 0x0197").
> 
> Tested with:
> 
>   - SLANG and NO_SLANG=1 builds
>   - perf test c2c
>   - perf test 'import perf'
>   - checkpatch.pl --strict on each patch
>   - unresolved-symbol checks on the Python perf module
> 
> Jiebin Sun (4):
>   perf c2c: Fix documented default coalesce fields
>   perf tests c2c: Report skip when the workload fails
>   perf c2c: Add stdio support for the function view
>   perf tests c2c: Add function view stdio coverage

Thanks for doing this!

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Documentation/perf-c2c.txt |  14 +++-
>  tools/perf/builtin-c2c.c              |  85 +++++++++++++++++--
>  tools/perf/tests/shell/c2c.sh         | 114 ++++++++++++++++++++++++++
>  tools/perf/util/c2c-function.c        |   9 +-
>  tools/perf/util/c2c.h                 |   1 +
>  5 files changed, 205 insertions(+), 18 deletions(-)
> 
> 
> base-commit: 9453bc6a69ef43755f1c28d5688cacdd69fa16bd
> -- 
> 2.52.0
