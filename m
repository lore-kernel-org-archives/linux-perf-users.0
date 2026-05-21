Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4C33A6E2;
	Thu, 21 May 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378471; cv=none; b=pgph9l7E4db+s3nZrF5KzUdTYUFLTS4MxtkEnydkINYuPCSEfoT1RQj+bt5Ph4RxdkLRQe+W53Ls/x34w9GRG+qzTw6YvgQ59YARPuesFD69pIXHiBYCGapZ9VttkYuNFIbBCMtDzFhjH5bs6vOinCKZfN4iRnmLp7Z3aatGv/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378471; c=relaxed/simple;
	bh=RgWQMXXU8OZw0HauN9rRLacyNAndnfWJBnV9GM2xzbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTn7n52ydpThJErI0Ci5p2Jb1Vz6s5tibkk5ZmCwHbSSYTMRUdhu5PU+AkcgjIZ/99WkbAugEqICCz3DAETYWenW/dt7HeTGS6v03GNu61+YycCg8gAwqDvmh9AX/fCt3LYtqFVd+7Tfwh6qU38rv9Ay/ZxKF0HXR7MiGJcRAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=HTm7dY7M; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="HTm7dY7M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SKIBGGk0aJOb4JUAlROUeYlj7NRw6OTASU16kTkeIoM=; b=HTm7dY7M4HT8U2MLKsLsuJ2ZOH
	00JzvN4yrEZBV/7byMjnnI3iEWFqKnKYc+bM2z4nhmlV8EbNiiffbp2QxbCgvHi9e4dIURIJYM5iH
	YiSuZf/8NweZivPlC/Ukkr8x6Gc3trgQZyZ0eQ+5ZM9+8lDLt+P8t00TMqWE9OfcTMp5PrPg7atc3
	nc0PnCH3Yjy9aP19QBGAV/AYaw2b6ZDCwuChj0yi9bokEu+XRk8FYIzdhjK3NzNwn8WV4eZ0N16+f
	ZNap+iDa/SImMmmi4r+CQWbg7SqSBYYzQdSTAjAHj1xvQBd7peVqYjhtMeq4uNx58PMchR4dhRM7g
	7YW/34Yw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wQ5ch-003zUD-0n;
	Thu, 21 May 2026 15:47:47 +0000
Date: Thu, 21 May 2026 08:47:43 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench: add --write-size option to sched pipe
Message-ID: <ag8o3KZ2NAXoR6I2@gmail.com>
References: <20260515-perf_bench_pipe-v1-1-3c5b805ba178@debian.org>
 <20260515120550.8DEA0C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515120550.8DEA0C2BCB0@smtp.kernel.org>
X-Debian-User: leitao

On Fri, May 15, 2026 at 12:05:49PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Integer overflow in write_size cast bypasses pipe capacity validation and causes a deadlock.
> - [High] Missing validation for write_size == 0 causes benchmark hangs or bogus results.
> - [Medium] File descriptor leak on the fcntl error path.

Thanks for the review. Going through them:

> Is there a missing lower-bound check for write_size? If a user passes
> 0, the vfs_write system call will return 0 immediately [...]

Agreed, write_size == 0 is a foot-gun in both modes. I'll add an
explicit rejection in v2.

> Could this cast to (int) cause an unexpected crash? If write_size is
> larger than INT_MAX [...]
> Does this signed cast bypass the pipe capacity validation when
> write_size exceeds INT_MAX?

Right -- the (int) casts on an unsigned int are sloppy. In practice
/proc/sys/fs/pipe-max-size defaults to 1 MiB so the fcntl would refuse
long before INT_MAX, but the comparison logic shouldn't depend on that.

v2 will validate write_size up front (0 < write_size <= INT_MAX) and
drop the casts entirely, so both the BUG_ON checks and the fcntl
return-value comparison become unambiguous.

> Does this return path leak the pipe file descriptors?

Strictly yes, but bench_sched_pipe() returning -1 propagates out to
the perf bench dispatcher and the process exits, so the kernel reaps
the four fds. The surrounding code is consistent with this -- e.g.
the BUG_ON(pipe2(...)) above doesn't unwind either. 

I'd rather keep the style consistent than sprinkle close() calls on one error
path, so I'll leave this as-is unless someone objects.

v2 with the first two fixes coming shortly.
