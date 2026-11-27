Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804950;
	b=09JCELC+YUqVnX6L0e39LeKrDA70stSAj4mirBvy/uUBTEyByJT9Q8iqIjnYDW9+PxGx
	 bgQpY7dDu7DpXh98+MQuKE8yu4HsUDKOcqPuO4u9xgWtN8OGzUAe4e6vzoR5AjNpGk3j2
	 9FuZceEkCYQCVzBYYrz6uZi+owAnVimCMqsxUzPN2dLXKC3bV1p1LiD+vdgY8bxbcDwLP
	 +EOsbNypwIzeYFa2maLTZeJgexW3eUhSZp68UZfZ6BBAxkEFvwPHPd6mMr9gfSwD9TxWr
	 bq6QjDRvfb72kR0vRM3O98ISzi2weFT9mKPNkvfZs9QwF4BWuRxzdX2gR6kdDUTMbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804950;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nt20LNSpJZyk74iJVViod3D3oRlAha88rqlV/T40+5s=;
	b=CgVH9VCHN34W7uAGLSHRTJWGyF7Y+kgBQruZjvMwhFSFJ7Vbqzx+ZOpsLbVNKMQsHYiN
	 zerVnaBtW7oH1f6GorjcvAUkUhZ8hasWUSWQteCfAQTIm74Q8YbKHAvZq0YMVpYhCGoFH
	 RQJchdXYqNcAXgiujUOuMMJ/JvDJkYKT+NVV4Xi2SxbDGbYXtP7gKsXiSadmo5cQUETet
	 1bYJNcXkXeuZibtm0vlKFaNA8OAGmqxsZqeZUdut/bBMIWEvLn6B6uNsBNo+MEiUwHIl1
	 gDMxmlCt0JYSylNqMK8e10/7B3AYLrdoUk8ZwKhdZkf6Bgo5QSpVLmZlZ1QhDEldrWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD2RVVqf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1AE606A31C;
	Fri, 27 Nov 2026 18:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nD2RVVqf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335B21F00897;
	Fri, 27 Nov 2026 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804949;
	bh=nt20LNSpJZyk74iJVViod3D3oRlAha88rqlV/T40+5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nD2RVVqftuOjIF75XmcD8Ok3XSQ+1UHtDlVfv10cHOHvu4bnndlPEjYajwooqYW82
	 VdjCFb4JRUE2zkgX18QfJJATRhvuRs1YIieXWozABIAZMYM53k84ba+rfaVpq8APvE
	 0jjZv74H3NsIH+g6PdeWtMb9WD7GitQDkMATuIOx3vFrynTTiG0D6XaxiaFksFlCm7
	 sXyIli6SbO1MfN3v5uL2fa0P9qpen9ThW9khYp/hRVWYqmgGf61JrOMt2Db6hWOw8x
	 wRg+JnqWYm8oeMmNrltA9EZRxlSIR44UrDKs/03gFXx5FRyRgsr1iQB86z7KWevULY
	 obrgULhOoHDfg==
Date: Fri, 27 Nov 2026 18:42:24 +0000
From: Will Deacon <will@kernel.org>
To: Haris Okanovic <harisokn@amazon.com>
Cc: robin.murphy@arm.com, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	peterz@infradead.org
Subject: Re: [PATCH v2 0/2] perf/arm-cmn: Allow userspace to select the PMU's
 CPU
Message-ID: <awnPEAxJyvdRmBFA@willie-the-truck>
References: <20260930231127.3094040-1-harisokn@amazon.com>
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
In-Reply-To: <20260930231127.3094040-1-harisokn@amazon.com>

On Wed, Sep 30, 2026 at 06:11:25PM -0500, Haris Okanovic wrote:
> arm_cmn_probe() picks the CPU that owns the PMU and nothing but the CPU
> hotplug callbacks ever revisits it, so in practice all of the PMU's
> recurring work stays on the first CPU local to the interconnect's NUMA
> node. Patch 2 makes the existing 'cpumask' attribute writable so it can
> be moved, which helps on systems that confine background kernel work to
> a chosen set of housekeeping CPUs.
> 
> I made the existing 'cpumask' attribute writable rather than
> adding a new one. Every other implementation of that file is read-only,
> so I am happy to switch to a separate attribute if you would prefer to
> keep 'cpumask' uniformly read-only across PMUs.
> 
> Patch 1 is new in v2. Robin pointed out that perf_event_open() can latch
> cmn->cpu and then install the event after a migration has already moved
> the PMU, leaving it on a CPU which no longer owns the PMU's shared state.
> The window already exists via arm_cmn_pmu_online_cpu(), so patch 1 stands
> on its own; a writable cpumask just makes it reachable on demand.

Hmm. Not sure about this. It feels to me as though, if we want interfaces
beyond CPU hotplug to control the affinity of system/uncore PMUs, then
that should probably be something managed and understood by the core
perf code rather than hacked onto one of the many PMU drivers by quietly
changing the semantics of the established debugfs interface.

Aha, you did that over at:

https://lore.kernel.org/r/20261013185603.1347265-1-harisokn@amazon.com

do you plan to respin that?

Otherwise, if over-loading CPU 0 is the problem, I suppose we could hack
the probe routine to pick an arbitrary CPU, similar to
cpumask_any_distribute().

Will
