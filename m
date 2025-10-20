Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D79C2F618F;
	Mon, 20 Oct 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955328; cv=none; b=Z4gOkS8GEqHYekTApJmmJCruyZUNE1FG3k6TKx31S9GiRhpWBWJVge1fKKMfo+MHLV+B5Dkt/MJaI0Hh+40r4RGNNU22SFWW/u+4+syTNZ0zv1dI+PtPBjaBcmoRkm9ceCYoyuPpQ+UTIUurs9V+rKKqFvo3zEqQbRiD4LEsuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955328; c=relaxed/simple;
	bh=6i+WB0Tq8+B4dcsaJzgkmAvi1jwR+YbvQcxpaUoU47U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3m2NUsarIDWxBLSm6SkjPEgc7vSlQVoEVDGurSQuZH6MgMmhKdEgbEEl3YnBqQdEKR5ehHq2hJpTkasL4A+xcqgk0aQ+TNIsjovInBJyLtAaLI9l4+u+RTt0/jFHEM/Dgzv5KxehLJFn2+0U+4QP1alg61UPb6g9SINYvFGWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D13A1063;
	Mon, 20 Oct 2025 03:15:17 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01453F63F;
	Mon, 20 Oct 2025 03:15:24 -0700 (PDT)
Date: Mon, 20 Oct 2025 11:15:23 +0100
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: hupu <hupu.gm@gmail.com>, acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	jolsa@kernel.org, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	peterz@infradead.org
Subject: Re: [PATCH] perf build: Support passing extra Clang options via
 EXTRA_BPF_FLAGS
Message-ID: <20251020101523.GE281971@e132581.arm.com>
References: <CADHxFxQHFkn-J9R6AJY8LxkDN-eTWjp34VvoQDcshfZs1eF0rQ@mail.gmail.com>
 <20251020024049.6877-1-hupu.gm@gmail.com>
 <aPW3rilb8DtFDIMC@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPW3rilb8DtFDIMC@google.com>

On Mon, Oct 20, 2025 at 01:16:46PM +0900, Namhyung Kim wrote:

[...]

> On Mon, Oct 20, 2025 at 10:40:49AM +0800, hupu wrote:
> > When cross-compiling perf with BPF enabled, Clang is invoked during the
> > build. Some cross-compilation environments require additional compiler
> > options, such as `--sysroot` or custom include paths.

[...]

> Leo, are you ok with this?

To be clear, now we are not talking cross build for perf program or any
targeting a CPU arch, it is a build failure for eBPF program.

This patch does not make clear why we cannot build eBPF program in
self-contained way. E.g., after installed kernel headers, why Makefile
misses to include installed headers when build eBPF program.

I am not saying we cannot specify an external sysroot path, but before
proceed that, we should make sure the build can work with self-contained
headers.

Thanks,
Leo
